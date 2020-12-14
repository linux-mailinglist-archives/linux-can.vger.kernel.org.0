Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2F4F42D94C7
	for <lists+linux-can@lfdr.de>; Mon, 14 Dec 2020 10:17:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407262AbgLNJPO (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Mon, 14 Dec 2020 04:15:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2407249AbgLNJPL (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Mon, 14 Dec 2020 04:15:11 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C1CDC0613D3
        for <linux-can@vger.kernel.org>; Mon, 14 Dec 2020 01:14:31 -0800 (PST)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1kojw5-000646-NE
        for linux-can@vger.kernel.org; Mon, 14 Dec 2020 10:14:29 +0100
Received: from dspam.blackshift.org (localhost [127.0.0.1])
        by bjornoya.blackshift.org (Postfix) with SMTP id CA11C5ACFE1
        for <linux-can@vger.kernel.org>; Mon, 14 Dec 2020 09:14:28 +0000 (UTC)
Received: from hardanger.blackshift.org (unknown [172.20.34.65])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by bjornoya.blackshift.org (Postfix) with ESMTPS id 385385ACFDD;
        Mon, 14 Dec 2020 09:14:28 +0000 (UTC)
Received: from blackshift.org (localhost [::1])
        by hardanger.blackshift.org (OpenSMTPD) with ESMTP id 919240d5;
        Mon, 14 Dec 2020 09:14:27 +0000 (UTC)
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     linux-can@vger.kernel.org
Cc:     kernel@pengutronix.de,
        Vincent Mailhol <mailhol.vincent@wanadoo.fr>,
        Arunachalam Santhanam <arunachalam.santhanam@in.bosch.com>,
        Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH RFC net-next] can: dev: can_skb_get_dll_len(): introduce function to get data length of frame in data link layer
Date:   Mon, 14 Dec 2020 10:14:26 +0100
Message-Id: <20201214091426.417867-1-mkl@pengutronix.de>
X-Mailer: git-send-email 2.29.2
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
Hello,

while reviewing the etas_es58X driver and hacking on BQL support for the
mcp251xfd driver, it turned out the a function to calculate the length of the
CAN frame that's send over the wire should go into the generic CAN dev code.

Looking at the CAN and OSI layering I think the first layer where we have all
the bits that we see on the wire is the data link layer (DLL).

https://www.can-cia.org/can-knowledge/can/can-data-link-layers

This is why I named the function can_skb_get_dll_len().

I'm planing to add a (better) calculation of the CAN-FD dll_len, depending on
the data and including different CRC lengths.

As this code is copied from the etas_es58X driver, I've added the authors as
Co-developed-by and I'd like to add their S-o-b to this patch.

Please review and commnt on the naming on the functions.

regards,
Marc

 drivers/net/can/dev.c   | 103 ++++++++++++++++++++++++++++++++++++++++
 include/linux/can/dev.h |   3 ++
 2 files changed, 106 insertions(+)

diff --git a/drivers/net/can/dev.c b/drivers/net/can/dev.c
index 81e39d7507d8..58c04785b46d 100644
--- a/drivers/net/can/dev.c
+++ b/drivers/net/can/dev.c
@@ -58,6 +58,109 @@ u8 can_len2dlc(u8 len)
 }
 EXPORT_SYMBOL_GPL(can_len2dlc);
 
+/* Size of a Classical CAN Standard Frame in Bits:
+ *
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
+ * Rounded up and ignoring bitsuffing
+ */
+#define CAN_DLL_OVERHEAD_SFF DIV_ROUND_UP(47, 8)
+
+/* Size of a Classical CAN Extended Frame in Bits:
+ *
+ * Start-of-frame			1
+ * Identifier A 			11
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
+ * Rounded up and ignoring bitsuffing
+ */
+#define CAN_DLL_OVERHEAD_EFF DIV_ROUND_UP(67, 8)
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
+#define CANFD_DLL_LEN_MAX (CAN_DLL_OVERHEAD_EFF + CANFD_MAX_DLEN)
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
+	if (can_is_canfd_skb(skb)) {
+		len = cf->len + CAN_DLL_OVERHEAD_EFF;
+	} else {
+		if (cf->can_id & CAN_RTR_FLAG)
+			len = 0;
+		else
+			len = cf->len;
+
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
index 41ff31795320..fc830f919099 100644
--- a/include/linux/can/dev.h
+++ b/include/linux/can/dev.h
@@ -192,6 +192,9 @@ u8 can_dlc2len(u8 can_dlc);
 /* map the sanitized data length to an appropriate data length code */
 u8 can_len2dlc(u8 len);
 
+/* get data link layer length of CAN/CAN-FD frame */
+unsigned int can_skb_get_dll_len(const struct sk_buff *skb);
+
 struct net_device *alloc_candev_mqs(int sizeof_priv, unsigned int echo_skb_max,
 				    unsigned int txqs, unsigned int rxqs);
 #define alloc_candev(sizeof_priv, echo_skb_max) \
-- 
2.29.2


