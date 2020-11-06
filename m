Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 75E4B2A9A85
	for <lists+linux-can@lfdr.de>; Fri,  6 Nov 2020 18:11:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727358AbgKFRLY (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Fri, 6 Nov 2020 12:11:24 -0500
Received: from mail3.ems-wuensche.com ([81.169.186.156]:44498 "EHLO
        mail3.ems-wuensche.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727346AbgKFRLX (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Fri, 6 Nov 2020 12:11:23 -0500
Received: from localhost (unknown [127.0.0.1])
        by h2257714.serverkompetenz.net (Postfix) with ESMTP id 6F1D1FFA5F
        for <linux-can@vger.kernel.org>; Fri,  6 Nov 2020 17:04:20 +0000 (UTC)
X-Virus-Scanned: amavisd-new at h2257714.serverkompetenz.net
X-Spam-Flag: NO
X-Spam-Score: -1.902
X-Spam-Level: 
X-Spam-Status: No, score=-1.902 tagged_above=-9999.9 required=5
        tests=[BAYES_00=-1.9, NO_RECEIVED=-0.001, NO_RELAYS=-0.001]
        autolearn=unavailable autolearn_force=no
Received: from mail3.ems-wuensche.com ([81.169.186.156])
        by localhost (h2257714.serverkompetenz.net [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id K2_KQfg7lkhL for <linux-can@vger.kernel.org>;
        Fri,  6 Nov 2020 18:04:05 +0100 (CET)
From:   Gerhard Uttenthaler <uttenthaler@ems-wuensche.com>
To:     linux-can@vger.kernel.org
Cc:     wg@grandegger.com, mkl@pengutronix.de,
        Gerhard Uttenthaler <uttenthaler@ems-wuensche.com>
Subject: [PATCH 07/17] can: ems_usb: Added CPC_ClearCmdQueue routine to get access to the interface even it is flooded with messages which cannot successfully be sent. Set timestamp to 0 in ems_usb_control_cmd.
Date:   Fri,  6 Nov 2020 18:01:56 +0100
Message-Id: <20201106170206.32162-8-uttenthaler@ems-wuensche.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201106170206.32162-1-uttenthaler@ems-wuensche.com>
References: <20201106170206.32162-1-uttenthaler@ems-wuensche.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Signed-off-by: Gerhard Uttenthaler <uttenthaler@ems-wuensche.com>
---
 drivers/net/can/usb/ems_usb.c | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/drivers/net/can/usb/ems_usb.c b/drivers/net/can/usb/ems_usb.c
index 66418e5af87d..c664af4499a1 100644
--- a/drivers/net/can/usb/ems_usb.c
+++ b/drivers/net/can/usb/ems_usb.c
@@ -637,12 +637,29 @@ static int ems_usb_control_cmd(struct ems_usb *dev, u8 val)
 	cmd.length = CPC_MSG_HEADER_LEN + 1;
 
 	cmd.msgid = 0;
+	cmd.ts_sec = 0;
+	cmd.ts_nsec = 0;
 
 	cmd.msg.generic[0] = val;
 
 	return ems_usb_command_msg(dev, &cmd);
 }
 
+/* Send a CPC_ClearCmdQueue command
+ */
+static int ems_usb_clear_cmd_queue(struct ems_usb *dev)
+{
+	struct ems_cpc_msg cmd;
+
+	cmd.type = CPC_CMD_TYPE_CLEAR_CMD_QUEUE;
+	cmd.length = CPC_MSG_HEADER_LEN;
+	cmd.msgid = 0;
+	cmd.ts_sec = 0;
+	cmd.ts_nsec = 0;
+
+	return ems_usb_command_msg(dev, &cmd);
+}
+
 /* Start interface
  */
 static int ems_usb_start(struct ems_usb *dev)
@@ -978,11 +995,19 @@ static int ems_usb_set_bittiming_arm7(struct net_device *netdev)
 	struct can_bittiming *bt = &dev->can.bittiming;
 	struct cpc_sja1000_params *sja1000 =
 		&dev->active_params.msg.can_params.cc_params.sja1000;
+	int err;
 
 	sja1000->btr0 = ((bt->brp - 1) & 0x3f) | (((bt->sjw - 1) & 0x3) << 6);
 	sja1000->btr1 = ((bt->prop_seg + bt->phase_seg1 - 1) & 0xf) |
 		(((bt->phase_seg2 - 1) & 0x7) << 4);
 
+	/* If the command queue in the device is full of sending requests
+	 * a reinitialization would not be possible before the queue is cleared.
+	 */
+	err = ems_usb_clear_cmd_queue(dev);
+	if (err)
+		return err;
+
 	netdev_info(netdev, "Set bit timing for CPC-USB/ARM7\n");
 	netdev_info(netdev, "BTR0=0x%02x, BTR1=0x%02x\n",
 		    sja1000->btr0, sja1000->btr1);
-- 
2.26.2

-- 
EMS Dr. Thomas Wuensche e.K.
Sonnenhang 3
85304 Ilmmuenster
HR Ingolstadt, HRA 170106

Phone: +49-8441-490260
Fax  : +49-8441-81860
http://www.ems-wuensche.com
