Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8AD762B0C30
	for <lists+linux-can@lfdr.de>; Thu, 12 Nov 2020 19:04:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726295AbgKLSEg (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Thu, 12 Nov 2020 13:04:36 -0500
Received: from mail3.ems-wuensche.com ([81.169.186.156]:42512 "EHLO
        mail3.ems-wuensche.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726162AbgKLSEf (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Thu, 12 Nov 2020 13:04:35 -0500
Received: from localhost (unknown [127.0.0.1])
        by h2257714.serverkompetenz.net (Postfix) with ESMTP id 34674FFA5C
        for <linux-can@vger.kernel.org>; Thu, 12 Nov 2020 18:04:33 +0000 (UTC)
X-Virus-Scanned: amavisd-new at h2257714.serverkompetenz.net
X-Spam-Flag: NO
X-Spam-Score: -1.901
X-Spam-Level: 
X-Spam-Status: No, score=-1.901 tagged_above=-9999.9 required=5
        tests=[BAYES_00=-1.9, NO_RECEIVED=-0.001, NO_RELAYS=-0.001,
        URIBL_BLOCKED=0.001] autolearn=unavailable autolearn_force=no
Received: from mail3.ems-wuensche.com ([81.169.186.156])
        by localhost (h2257714.serverkompetenz.net [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id LJEPIcx2mioy for <linux-can@vger.kernel.org>;
        Thu, 12 Nov 2020 19:04:32 +0100 (CET)
From:   Gerhard Uttenthaler <uttenthaler@ems-wuensche.com>
To:     linux-can@vger.kernel.org
Cc:     wg@grandegger.com, mkl@pengutronix.de,
        Gerhard Uttenthaler <uttenthaler@ems-wuensche.com>
Subject: [PATCH v2 02/16] can: ems_usb: Added CPC_ClearCmdQueue routine.
Date:   Thu, 12 Nov 2020 19:03:32 +0100
Message-Id: <20201112180346.29070-3-uttenthaler@ems-wuensche.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201112180346.29070-1-uttenthaler@ems-wuensche.com>
References: <20201112180346.29070-1-uttenthaler@ems-wuensche.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

If the command queue in the interface is flooded with messages which cannot
successfully be sent to the bus an initialization command would have to
wait to be executed.

Signed-off-by: Gerhard Uttenthaler <uttenthaler@ems-wuensche.com>
---
 drivers/net/can/usb/ems_usb.c | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/drivers/net/can/usb/ems_usb.c b/drivers/net/can/usb/ems_usb.c
index e943cd07c5f7..a70bda631e4e 100644
--- a/drivers/net/can/usb/ems_usb.c
+++ b/drivers/net/can/usb/ems_usb.c
@@ -565,6 +565,21 @@ static int ems_usb_control_cmd(struct ems_usb *dev, u8 val)
 	return ems_usb_command_msg(dev, &cmd);
 }
 
+/* Send a CPC_ClearCmdQueue command
+ */
+static int ems_usb_clear_cmd_queue(struct ems_usb *dev)
+{
+	struct ems_cpc_msg cmd = {
+		.type = CPC_CMD_TYPE_CLEAR_CMD_QUEUE,
+		.length = CPC_MSG_HEADER_LEN,
+		.msgid = 0,
+		.ts_sec = 0,
+		.ts_nsec = 0
+	};
+
+	return ems_usb_command_msg(dev, &cmd);
+}
+
 /* Start interface
  */
 static int ems_usb_start(struct ems_usb *dev)
@@ -897,6 +912,7 @@ static int ems_usb_set_bittiming(struct net_device *netdev)
 	struct ems_usb *dev = netdev_priv(netdev);
 	struct can_bittiming *bt = &dev->can.bittiming;
 	u8 btr0, btr1;
+	int err;
 
 	btr0 = ((bt->brp - 1) & 0x3f) | (((bt->sjw - 1) & 0x3) << 6);
 	btr1 = ((bt->prop_seg + bt->phase_seg1 - 1) & 0xf) |
@@ -904,6 +920,13 @@ static int ems_usb_set_bittiming(struct net_device *netdev)
 	if (dev->can.ctrlmode & CAN_CTRLMODE_3_SAMPLES)
 		btr1 |= 0x80;
 
+	/* If the command queue in the device is full with incoming commands
+	 * a reinitialization would not be possible before the queue is cleared.
+	 */
+	err = ems_usb_clear_cmd_queue(dev);
+	if (err)
+		return err;
+
 	netdev_info(netdev, "setting BTR0=0x%02x BTR1=0x%02x\n", btr0, btr1);
 
 	dev->active_params.msg.can_params.cc_params.sja1000.btr0 = btr0;
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
