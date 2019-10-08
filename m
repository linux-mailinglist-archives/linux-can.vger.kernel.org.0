Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 69402CF520
	for <lists+linux-can@lfdr.de>; Tue,  8 Oct 2019 10:38:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729986AbfJHIiZ (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Tue, 8 Oct 2019 04:38:25 -0400
Received: from smtp1-g21.free.fr ([212.27.42.1]:17262 "EHLO smtp1-g21.free.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728866AbfJHIiZ (ORCPT <rfc822;linux-can@vger.kernel.org>);
        Tue, 8 Oct 2019 04:38:25 -0400
Received: from linux-dev.peak.localnet (unknown [185.109.201.203])
        (Authenticated sender: stephane.grosjean)
        by smtp1-g21.free.fr (Postfix) with ESMTPSA id F0DCBB004B6;
        Tue,  8 Oct 2019 10:38:19 +0200 (CEST)
From:   Stephane Grosjean <s.grosjean@peak-system.com>
To:     linux-can Mailing List <linux-can@vger.kernel.org>
Cc:     Stephane Grosjean <s.grosjean@peak-system.com>
Subject: [PATCH 1/2] can/peak_usb: fix a potential out-of-sync while decoding packets
Date:   Tue,  8 Oct 2019 10:35:44 +0200
Message-Id: <20191008083545.4569-2-s.grosjean@peak-system.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191008083545.4569-1-s.grosjean@peak-system.com>
References: <20191008083545.4569-1-s.grosjean@peak-system.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-can-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

When decoding a buffer received from PCAN-USB, the first timestamp read in
a packet is a 16-bit coded time base, and the next ones are an 8-bit
offset to this base, regardless of the type of packet read.

This patch corrects a potential loss of synchronization by using a
timestamp index read from the buffer, rather than an index of received
data packets, to determine on the sizeof the timestamp to be read from the
packet being decoded.

Signed-off-by: Stephane Grosjean <s.grosjean@peak-system.com>
---
 drivers/net/can/usb/peak_usb/pcan_usb.c | 17 ++++++++++++-----
 1 file changed, 12 insertions(+), 5 deletions(-)

diff --git a/drivers/net/can/usb/peak_usb/pcan_usb.c b/drivers/net/can/usb/peak_usb/pcan_usb.c
index dd2a7f529012..d2539c95adb6 100644
--- a/drivers/net/can/usb/peak_usb/pcan_usb.c
+++ b/drivers/net/can/usb/peak_usb/pcan_usb.c
@@ -100,7 +100,7 @@ struct pcan_usb_msg_context {
 	u8 *end;
 	u8 rec_cnt;
 	u8 rec_idx;
-	u8 rec_data_idx;
+	u8 rec_ts_idx;
 	struct net_device *netdev;
 	struct pcan_usb *pdev;
 };
@@ -552,10 +552,15 @@ static int pcan_usb_decode_status(struct pcan_usb_msg_context *mc,
 	mc->ptr += PCAN_USB_CMD_ARGS;
 
 	if (status_len & PCAN_USB_STATUSLEN_TIMESTAMP) {
-		int err = pcan_usb_decode_ts(mc, !mc->rec_idx);
+		int err = pcan_usb_decode_ts(mc, !mc->rec_ts_idx);
 
 		if (err)
 			return err;
+
+		/* Next packet in the buffer will have a timestamp on a single
+		 * byte
+		 */
+		mc->rec_ts_idx++;
 	}
 
 	switch (f) {
@@ -637,10 +642,13 @@ static int pcan_usb_decode_data(struct pcan_usb_msg_context *mc, u8 status_len)
 
 	cf->can_dlc = get_can_dlc(rec_len);
 
-	/* first data packet timestamp is a word */
-	if (pcan_usb_decode_ts(mc, !mc->rec_data_idx))
+	/* Only first packet timestamp is a word */
+	if (pcan_usb_decode_ts(mc, !mc->rec_ts_idx))
 		goto decode_failed;
 
+	/* Next packet in the buffer will have a timestamp on a single byte */
+	mc->rec_ts_idx++;
+
 	/* read data */
 	memset(cf->data, 0x0, sizeof(cf->data));
 	if (status_len & PCAN_USB_STATUSLEN_RTR) {
@@ -693,7 +701,6 @@ static int pcan_usb_decode_msg(struct peak_usb_device *dev, u8 *ibuf, u32 lbuf)
 		/* handle normal can frames here */
 		} else {
 			err = pcan_usb_decode_data(&mc, sl);
-			mc.rec_data_idx++;
 		}
 	}
 
-- 
2.20.1

