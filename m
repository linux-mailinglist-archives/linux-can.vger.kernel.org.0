Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D2B0928D165
	for <lists+linux-can@lfdr.de>; Tue, 13 Oct 2020 17:41:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728873AbgJMPlP (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Tue, 13 Oct 2020 11:41:15 -0400
Received: from smtp5-g21.free.fr ([212.27.42.5]:17002 "EHLO smtp5-g21.free.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727830AbgJMPlO (ORCPT <rfc822;linux-can@vger.kernel.org>);
        Tue, 13 Oct 2020 11:41:14 -0400
Received: from debian.peak-system.com (unknown [89.158.155.184])
        (Authenticated sender: stephane.grosjean)
        by smtp5-g21.free.fr (Postfix) with ESMTPSA id 0AEC85FF23;
        Tue, 13 Oct 2020 17:41:09 +0200 (CEST)
From:   Stephane Grosjean <s.grosjean@peak-system.com>
To:     linux-can Mailing List <linux-can@vger.kernel.org>
Cc:     Stephane Grosjean <s.grosjean@peak-system.com>
Subject: [PATCH] can/peak_canfd: fix echo management when loopback is on
Date:   Tue, 13 Oct 2020 17:39:47 +0200
Message-Id: <20201013153947.28012-1-s.grosjean@peak-system.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Echo management is driven by PUCAN_MSG_LOOPED_BACK bit, while loopback
frames are identified with PUCAN_MSG_SELF_RECEIVE bit. Those bits are set
for each outgoing frame written to the IP core so that a copy of each one
will be placed into the rx path. Thus,

- when PUCAN_MSG_LOOPED_BACK is set then the rx frame is an echo of a
  previously sent frame,
- when PUCAN_MSG_LOOPED_BACK+PUCAN_MSG_SELF_RECEIVE are set, then the rx
  frame is an echo AND a loopback frame. Therefore, this frame must be
  put into the socket rx path too.

This patch fixes how CAN frames are handled when these are sent while the
can interface is configured in "loopback on" mode.

Signed-off-by: Stephane Grosjean <s.grosjean@peak-system.com>
---
 drivers/net/can/peak_canfd/peak_canfd.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/drivers/net/can/peak_canfd/peak_canfd.c b/drivers/net/can/peak_canfd/peak_canfd.c
index 10aa3e457c33..40c33b8a5fda 100644
--- a/drivers/net/can/peak_canfd/peak_canfd.c
+++ b/drivers/net/can/peak_canfd/peak_canfd.c
@@ -262,8 +262,7 @@ static int pucan_handle_can_rx(struct peak_canfd_priv *priv,
 		cf_len = get_can_dlc(pucan_msg_get_dlc(msg));
 
 	/* if this frame is an echo, */
-	if ((rx_msg_flags & PUCAN_MSG_LOOPED_BACK) &&
-	    !(rx_msg_flags & PUCAN_MSG_SELF_RECEIVE)) {
+	if (rx_msg_flags & PUCAN_MSG_LOOPED_BACK) {
 		unsigned long flags;
 
 		spin_lock_irqsave(&priv->echo_lock, flags);
@@ -277,7 +276,13 @@ static int pucan_handle_can_rx(struct peak_canfd_priv *priv,
 		netif_wake_queue(priv->ndev);
 
 		spin_unlock_irqrestore(&priv->echo_lock, flags);
-		return 0;
+
+		/* if this frame is only an echo, stop here. Otherwise,
+		 * continue to push this application self-received frame into
+		 * its own rx queue.
+		 */
+		if (!(rx_msg_flags & PUCAN_MSG_SELF_RECEIVE))
+			return 0;
 	}
 
 	/* otherwise, it should be pushed into rx fifo */
-- 
2.20.1

