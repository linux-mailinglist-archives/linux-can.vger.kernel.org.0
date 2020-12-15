Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 624BB2DAD93
	for <lists+linux-can@lfdr.de>; Tue, 15 Dec 2020 13:57:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729240AbgLOM5L (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Tue, 15 Dec 2020 07:57:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729213AbgLOM5C (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 15 Dec 2020 07:57:02 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17FD2C0617B0
        for <linux-can@vger.kernel.org>; Tue, 15 Dec 2020 04:56:22 -0800 (PST)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1kp9sK-0004xp-NF
        for linux-can@vger.kernel.org; Tue, 15 Dec 2020 13:56:20 +0100
Received: from dspam.blackshift.org (localhost [127.0.0.1])
        by bjornoya.blackshift.org (Postfix) with SMTP id 832FA5ADE4F
        for <linux-can@vger.kernel.org>; Tue, 15 Dec 2020 12:56:19 +0000 (UTC)
Received: from hardanger.blackshift.org (unknown [172.20.34.65])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by bjornoya.blackshift.org (Postfix) with ESMTPS id 25CB45ADE49;
        Tue, 15 Dec 2020 12:56:19 +0000 (UTC)
Received: from blackshift.org (localhost [::1])
        by hardanger.blackshift.org (OpenSMTPD) with ESMTP id 4c1d1193;
        Tue, 15 Dec 2020 12:56:18 +0000 (UTC)
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     linux-can@vger.kernel.org
Cc:     Vincent Mailhol <mailhol.vincent@wanadoo.fr>,
        Arunachalam Santhanam <arunachalam.santhanam@in.bosch.com>,
        Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH 2/2] can: dev: can_skb_get_dll_len(): introduce function to get data length of frame in data link layer
Date:   Tue, 15 Dec 2020 13:55:49 +0100
Message-Id: <20201215125549.540918-2-mkl@pengutronix.de>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201215125549.540918-1-mkl@pengutronix.de>
References: <20201215125549.540918-1-mkl@pengutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2001:67c:670:201:5054:ff:fe8d:eefb
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

From: Vincent Mailhol <mailhol.vincent@wanadoo.fr>

This patch adds the function can_skb_get_dll_len() which returns the length of
a CAN frame on the data link layer, including Start-of-frame, Identifier,
various other bits, the CRC, the End-of-frame, the Inter frame spacing and the
actual data.

Co-developed-by: Arunachalam Santhanam <arunachalam.santhanam@in.bosch.com>
Not-Signed-off-by: Arunachalam Santhanam <arunachalam.santhanam@in.bosch.com>
Co-developed-by: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Not-Signed-off-by: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Co-developed-by: Marc Kleine-Budde <mkl@pengutronix.de>
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/dev.c   | 166 ++++++++++++++++++++++++++++++++++++++++
 include/linux/can/dev.h |   3 +
 2 files changed, 169 insertions(+)

diff --git a/drivers/net/can/dev.c b/drivers/net/can/dev.c
index fa81e3067b3b..e11e3d95453b 100644
--- a/drivers/net/can/dev.c
+++ b/drivers/net/can/dev.c
@@ -81,6 +81,172 @@ u8 can_len2dll_len(u8 len)
 }
 EXPORT_SYMBOL_GPL(can_len2dll_len);
 
+/* Size of a Classical CAN Standard Frame
+ *
+ * Name of Field			Bits
+ * ---------------------------------------------------------
+ * Start-of-frame			1
+ * Identifier				11
+ * Remote transmission request (RTR)	1
+ * Identifier extension bit (IDE)	1
+ * Reserved bit (r0)			1
+ * Data length code (DLC)		4
+ * Data field				0...64
+ * CRC					15
+ * CRC delimiter			1
+ * ACK slot				1
+ * ACK delimiter			1
+ * End-of-frame (EOF)			7
+ * Inter frame spacing			3
+ *
+ * rounded up and ignoring bitsuffing
+ */
+#define CAN_DLL_OVERHEAD_SFF DIV_ROUND_UP(47, 8)
+
+/* Size of a Classical CAN Extended Frame
+ *
+ * Name of Field			Bits
+ * ---------------------------------------------------------
+ * Start-of-frame			1
+ * Identifier A				11
+ * Substitute remote request (SRR)	1
+ * Identifier extension bit (IDE)	1
+ * Identifier B				18
+ * Remote transmission request (RTR)	1
+ * Reserved bits (r1, r0)		2
+ * Data length code (DLC)		4
+ * Data field				0...64
+ * CRC					15
+ * CRC delimiter			1
+ * ACK slot				1
+ * ACK delimiter			1
+ * End-of-frame (EOF)			7
+ * Inter frame spacing			3
+ *
+ * rounded up and ignoring bitsuffing
+ */
+#define CAN_DLL_OVERHEAD_EFF DIV_ROUND_UP(67, 8)
+
+/* Size of a CAN-FD Standard Frame
+ *
+ * Name of Field			Bits
+ * ---------------------------------------------------------
+ * Start-of-frame			1
+ * Identifier				11
+ * Reserved bit (r1)			1
+ * Identifier extension bit (IDE)	1
+ * Flexible data rate format (FDF)	1
+ * Reserved bit (r0)			1
+ * Bit Rate Switch (BRS)		1
+ * Error Status Indicator (ESI)		1
+ * Data length code (DLC)		4
+ * Data field				0...512
+ * Stuff Bit Count (SBC)		4/5 0...16/20...64
+ * CRC					17/21 0...16/20...64
+ * CRC delimiter (CD)			1
+ * ACK slot (AS)			1
+ * ACK delimiter (AD)			1
+ * End-of-frame (EOF)			7
+ * Inter frame spacing			3
+ *
+ * assuming CRC21, rounded up and ignoring bitsuffing
+ */
+#define CANFD_DLL_OVERHEAD_SFF DIV_ROUND_UP(61, 8)
+
+/* Size of a CAN-FD Extended Frame
+ *
+ * Name of Field			Bits
+ * ---------------------------------------------------------
+ * Start-of-frame			1
+ * Identifier A				11
+ * Substitute remote request (SRR)	1
+ * Identifier extension bit (IDE)	1
+ * Identifier B				18
+ * Reserved bit (r1)			1
+ * Flexible data rate format (FDF)	1
+ * Reserved bit (r0)			1
+ * Bit Rate Switch (BRS)		1
+ * Error Status Indicator (ESI)		1
+ * Data length code (DLC)		4
+ * Data field				0...512
+ * Stuff Bit Count (SBC)		4/5 0...16/20...64
+ * CRC					17/21 0...16/20...64
+ * CRC delimiter (CD)			1
+ * ACK slot (AS)			1
+ * ACK delimiter (AD)			1
+ * End-of-frame (EOF)			7
+ * Inter frame spacing			3
+ *
+ * assuming CRC21, rounded up and ignoring bitsuffing
+ */
+#define CANFD_DLL_OVERHEAD_EFF DIV_ROUND_UP(80, 8)
+
+/* Maximum size of a Classical CAN frame
+ * (rounded up and ignoring bitsuffing)
+ */
+#define CAN_DLL_LEN_MAX (CAN_DLL_OVERHEAD_EFF + CAN_MAX_DLEN)
+
+/* Maximum size of a CAN-FD frame (rough estimation because
+ * ES58X_SFF_BYTES() and ES58X_EFF_BYTES() macros are using the
+ * constant values for Classical CAN, not CAN-FD).
+ */
+#define CANFD_DLL_LEN_MAX (CANFD_DLL_OVERHEAD_EFF + CANFD_MAX_DLEN)
+
+/**
+ * can_skb_get_dll_len() - Calculate the CAN Data Link Layer length in
+ * bytes of a given skb.
+ * @skb: socket buffer of a CAN message.
+ *
+ * Do a rough calculation: bit stuffing is ignored and length in bits
+ * is rounded up to a length in bytes.
+ *
+ * Rationale: this function is to be used for the BQL functions
+ * (netdev_sent_queue() and netdev_completed_queue()) which expect a
+ * value in bytes. Just using skb->len is insufficient because it will
+ * return the constant value of CAN(FD)_MTU. Doing the bit stuffing
+ * calculation would be too expensive in term of computing resources
+ * for no noticeable gain.
+ *
+ * Remarks:
+ * a.) The payload of CAN FD frames with BRS flag are sent at a
+ * different bitrate. Currently, the can-utils canbusload tool does
+ * not support CAN-FD yet and so we could not run any benchmark to
+ * measure the impact. There might be possible improvement here.
+ * b.) The macro CAN_DLL_OVERHEAD_EFF and CAN_DLL_OVERHEAD_SFF are
+ * for classical CAN. Need to do the addition for CAN-FD (the value
+ * are expected to be close enough so the impact should be minimal or
+ * none).
+ *
+ * Return: length in bytes.
+ */
+unsigned int can_skb_get_dll_len(const struct sk_buff *skb)
+{
+	const struct canfd_frame *cf = (const struct canfd_frame *)skb->data;
+	u8 len;
+
+	if (can_is_canfd_skb(skb))
+		len = can_len2dll_len(cf->len);
+	else if (cf->can_id & CAN_RTR_FLAG)
+		len = 0;
+	else
+		len = cf->len;
+
+	if (can_is_canfd_skb(skb)) {
+		if (cf->can_id & CAN_EFF_FLAG)
+			len += CANFD_DLL_OVERHEAD_EFF;
+		else
+			len += CANFD_DLL_OVERHEAD_SFF;
+	} else {
+		if (cf->can_id & CAN_EFF_FLAG)
+			len += CAN_DLL_OVERHEAD_EFF;
+		else
+			len += CAN_DLL_OVERHEAD_SFF;
+	}
+
+	return len;
+}
+EXPORT_SYMBOL_GPL(can_skb_get_dll_len);
+
 #ifdef CONFIG_CAN_CALC_BITTIMING
 #define CAN_CALC_MAX_ERROR 50 /* in one-tenth of a percent */
 
diff --git a/include/linux/can/dev.h b/include/linux/can/dev.h
index 27c359a00203..affdee8f64c4 100644
--- a/include/linux/can/dev.h
+++ b/include/linux/can/dev.h
@@ -195,6 +195,9 @@ u8 can_len2dlc(u8 len);
 /* map the sanitized data length to an appropriate data link layer length */
 u8 can_len2dll_len(u8 len);
 
+/* get data link layer length of CAN/CAN-FD frame */
+unsigned int can_skb_get_dll_len(const struct sk_buff *skb);
+
 struct net_device *alloc_candev_mqs(int sizeof_priv, unsigned int echo_skb_max,
 				    unsigned int txqs, unsigned int rxqs);
 #define alloc_candev(sizeof_priv, echo_skb_max) \
-- 
2.29.2


