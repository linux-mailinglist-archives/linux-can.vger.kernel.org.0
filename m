Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3D22545A446
	for <lists+linux-can@lfdr.de>; Tue, 23 Nov 2021 14:59:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229939AbhKWOCq (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Tue, 23 Nov 2021 09:02:46 -0500
Received: from smtp10.smtpout.orange.fr ([80.12.242.132]:65128 "EHLO
        smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229808AbhKWOCp (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 23 Nov 2021 09:02:45 -0500
Received: from tomoyo.flets-east.jp ([114.149.34.46])
        by smtp.orange.fr with ESMTPA
        id pWKTmgUOi3ptZpWKZm4VGi; Tue, 23 Nov 2021 14:59:36 +0100
X-ME-Helo: tomoyo.flets-east.jp
X-ME-Auth: MDU0YmViZGZmMDIzYiBlMiM2NTczNTRjNWZkZTMwOGRiOGQ4ODf3NWI1ZTMyMzdiODlhOQ==
X-ME-Date: Tue, 23 Nov 2021 14:59:36 +0100
X-ME-IP: 114.149.34.46
From:   Vincent Mailhol <mailhol.vincent@wanadoo.fr>
To:     Jimmy Assarsson <extja@kvaser.com>, linux-can@vger.kernel.org
Cc:     Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Subject: [RFC PATCH] can: kvaser_usb: do not increase tx statistics when sending CAN error frames
Date:   Tue, 23 Nov 2021 22:59:15 +0900
Message-Id: <20211123135915.627799-1-mailhol.vincent@wanadoo.fr>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

CAN error skb is an interface specific to socket CAN. The CAN error
skb does not correspond to any actual CAN frame sent on the wire. Only
an error flag and a delimiter are transmitted when an error occurs
(c.f. ISO 11898-1 section 10.4.4.2 "Error flag").

For this reason, it makes no sense to increment the tx_packets and
tx_bytes fields of struct net_device_stats when sending an error frame
because no actual payload will be transmitted on the wire.

N.B. Sending error frames is a very specific feature which, at the
moment, is only supported by the Kvaser Hydra hardware. Please refer
to [1] for more details on the topic.

[1] https://lore.kernel.org/linux-can/CAMZ6RqK0rTNg3u3mBpZOoY51jLZ-et-J01tY6-+mWsM4meVw-A@mail.gmail.com/t/#u

CC: Jimmy Assarsson <extja@kvaser.com>
Signed-off-by: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
---
Hi Jimmy,

The statistics problem also applies to the tx path. However, in
contrary to the rx path, this is specific to the Kvaser driver because
it is the only one to support sending error flags.

I am not fully confident with my patch, so I am sending this as
RFC. Your comments will be warmly welcomed!

Yours sincerely,
Vincent Mailhol
---
 drivers/net/can/usb/kvaser_usb/kvaser_usb.h       | 3 +++
 drivers/net/can/usb/kvaser_usb/kvaser_usb_hydra.c | 8 +++++---
 2 files changed, 8 insertions(+), 3 deletions(-)

diff --git a/drivers/net/can/usb/kvaser_usb/kvaser_usb.h b/drivers/net/can/usb/kvaser_usb/kvaser_usb.h
index 390b6bde883c..9993d16dfe54 100644
--- a/drivers/net/can/usb/kvaser_usb/kvaser_usb.h
+++ b/drivers/net/can/usb/kvaser_usb/kvaser_usb.h
@@ -73,6 +73,9 @@ struct kvaser_usb_dev_card_data {
 	};
 };
 
+/* Keep track of error frames in kvaser_usb_tx_urb_context:dlc */
+#define KVASER_USB_DLC_ERROR_FRAME	(-1)
+
 /* Context for an outstanding, not yet ACKed, transmission */
 struct kvaser_usb_tx_urb_context {
 	struct kvaser_usb_net_priv *priv;
diff --git a/drivers/net/can/usb/kvaser_usb/kvaser_usb_hydra.c b/drivers/net/can/usb/kvaser_usb/kvaser_usb_hydra.c
index adab5c2a8b99..571b1baf9d23 100644
--- a/drivers/net/can/usb/kvaser_usb/kvaser_usb_hydra.c
+++ b/drivers/net/can/usb/kvaser_usb/kvaser_usb_hydra.c
@@ -1134,7 +1134,7 @@ static void kvaser_usb_hydra_tx_acknowledge(const struct kvaser_usb *dev,
 	}
 
 	context = &priv->tx_contexts[transid % dev->max_tx_urbs];
-	if (!one_shot_fail) {
+	if (!one_shot_fail && context->dlc != KVASER_USB_DLC_ERROR_FRAME) {
 		struct net_device_stats *stats = &priv->netdev->stats;
 
 		stats->tx_packets++;
@@ -1483,8 +1483,10 @@ kvaser_usb_hydra_frame_to_cmd_std(const struct kvaser_usb_net_priv *priv,
 	if (cf->can_id & CAN_RTR_FLAG)
 		flags |= KVASER_USB_HYDRA_CF_FLAG_REMOTE_FRAME;
 
-	flags |= (cf->can_id & CAN_ERR_FLAG ?
-		  KVASER_USB_HYDRA_CF_FLAG_ERROR_FRAME : 0);
+	if (cf->can_id & CAN_ERR_FLAG)
+		flags |= KVASER_USB_HYDRA_CF_FLAG_ERROR_FRAME;
+	else
+		*frame_len = KVASER_USB_DLC_ERROR_FRAME;
 
 	cmd->tx_can.id = cpu_to_le32(id);
 	cmd->tx_can.flags = flags;
-- 
2.32.0

