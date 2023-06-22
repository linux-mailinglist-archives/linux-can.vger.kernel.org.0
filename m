Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 036DD739996
	for <lists+linux-can@lfdr.de>; Thu, 22 Jun 2023 10:27:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230171AbjFVI1w (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Thu, 22 Jun 2023 04:27:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230287AbjFVI1q (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Thu, 22 Jun 2023 04:27:46 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 044461BE1
        for <linux-can@vger.kernel.org>; Thu, 22 Jun 2023 01:27:21 -0700 (PDT)
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1qCFet-0002m0-Pa
        for linux-can@vger.kernel.org; Thu, 22 Jun 2023 10:27:15 +0200
Received: from dspam.blackshift.org (localhost [127.0.0.1])
        by bjornoya.blackshift.org (Postfix) with SMTP id 960331DF3F0
        for <linux-can@vger.kernel.org>; Thu, 22 Jun 2023 08:27:05 +0000 (UTC)
Received: from hardanger.blackshift.org (unknown [172.20.34.65])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by bjornoya.blackshift.org (Postfix) with ESMTPS id 586021DF37B;
        Thu, 22 Jun 2023 08:27:03 +0000 (UTC)
Received: from blackshift.org (localhost [::1])
        by hardanger.blackshift.org (OpenSMTPD) with ESMTP id a8371c44;
        Thu, 22 Jun 2023 08:27:01 +0000 (UTC)
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     netdev@vger.kernel.org
Cc:     davem@davemloft.net, kuba@kernel.org, linux-can@vger.kernel.org,
        kernel@pengutronix.de,
        Vincent Mailhol <mailhol.vincent@wanadoo.fr>,
        Thomas Kopp <Thomas.Kopp@microchip.com>,
        Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH net-next 18/33] can: length: refactor frame lengths definition to add size in bits
Date:   Thu, 22 Jun 2023 10:26:43 +0200
Message-Id: <20230622082658.571150-19-mkl@pengutronix.de>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230622082658.571150-1-mkl@pengutronix.de>
References: <20230622082658.571150-1-mkl@pengutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:b01:1d::7b
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

From: Vincent Mailhol <mailhol.vincent@wanadoo.fr>

Introduce a method to calculate the exact size in bits of a CAN(-FD)
frame with or without dynamic bitstuffing.

These are all the possible combinations taken into account:

  - Classical CAN or CAN-FD
  - Standard or Extended frame format
  - CAN-FD CRC17 or CRC21
  - Include or not intermission

Instead of doing several individual macro definitions, declare the
can_frame_bits() function-like macro. To this extent, do a full
refactoring of the length definitions.

In addition add the can_frame_bytes(). This function-like macro
replaces the existing macro:

  - CAN_FRAME_OVERHEAD_SFF: can_frame_bytes(false, false, 0)
  - CAN_FRAME_OVERHEAD_EFF: can_frame_bytes(false, true, 0)
  - CANFD_FRAME_OVERHEAD_SFF: can_frame_bytes(true, false, 0)
  - CANFD_FRAME_OVERHEAD_EFF: can_frame_bytes(true, true, 0)

Function-like macros were chosen over inline functions because they
can be used to initialize const struct fields.

The different maximum frame lengths (maximum data length, including
intermission) are as follow:

   Frame type				bits	bytes
  -------------------------------------------------------
   Classic CAN SFF no bitstuffing	111	14
   Classic CAN EFF no bitstuffing	131	17
   Classic CAN SFF bitstuffing		135	17
   Classic CAN EFF bitstuffing		160	20
   CAN-FD SFF no bitstuffing		579	73
   CAN-FD EFF no bitstuffing		598	75
   CAN-FD SFF bitstuffing		712	89
   CAN-FD EFF bitstuffing		736	92

The macro CAN_FRAME_LEN_MAX and CANFD_FRAME_LEN_MAX are kept as an
alias to, respectively, can_frame_bytes(false, true, CAN_MAX_DLEN) and
can_frame_bytes(true, true, CANFD_MAX_DLEN).

In addition to the above:

 - Use ISO 11898-1:2015 definitions for the names of the CAN frame
   fields.
 - Include linux/bits.h for use of BITS_PER_BYTE.
 - Include linux/math.h for use of mult_frac() and
   DIV_ROUND_UP(). N.B: the use of DIV_ROUND_UP() is not new to this
   patch, but the include was previously omitted.
 - Add copyright 2023 for myself.

Suggested-by: Thomas Kopp <Thomas.Kopp@microchip.com>
Signed-off-by: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Reviewed-by: Thomas Kopp <Thomas.Kopp@microchip.com>
Link: https://lore.kernel.org/all/20230611025728.450837-4-mailhol.vincent@wanadoo.fr
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/dev/length.c |  15 +-
 include/linux/can/length.h   | 318 ++++++++++++++++++++++++-----------
 2 files changed, 224 insertions(+), 109 deletions(-)

diff --git a/drivers/net/can/dev/length.c b/drivers/net/can/dev/length.c
index b48140b1102e..b7f4d76dd444 100644
--- a/drivers/net/can/dev/length.c
+++ b/drivers/net/can/dev/length.c
@@ -78,18 +78,7 @@ unsigned int can_skb_get_frame_len(const struct sk_buff *skb)
 	else
 		len = cf->len;
 
-	if (can_is_canfd_skb(skb)) {
-		if (cf->can_id & CAN_EFF_FLAG)
-			len += CANFD_FRAME_OVERHEAD_EFF;
-		else
-			len += CANFD_FRAME_OVERHEAD_SFF;
-	} else {
-		if (cf->can_id & CAN_EFF_FLAG)
-			len += CAN_FRAME_OVERHEAD_EFF;
-		else
-			len += CAN_FRAME_OVERHEAD_SFF;
-	}
-
-	return len;
+	return can_frame_bytes(can_is_canfd_skb(skb), cf->can_id & CAN_EFF_FLAG,
+			       false, len);
 }
 EXPORT_SYMBOL_GPL(can_skb_get_frame_len);
diff --git a/include/linux/can/length.h b/include/linux/can/length.h
index 521fdbce2d69..abc978b38f79 100644
--- a/include/linux/can/length.h
+++ b/include/linux/can/length.h
@@ -1,132 +1,258 @@
 /* SPDX-License-Identifier: GPL-2.0 */
 /* Copyright (C) 2020 Oliver Hartkopp <socketcan@hartkopp.net>
  * Copyright (C) 2020 Marc Kleine-Budde <kernel@pengutronix.de>
- * Copyright (C) 2020 Vincent Mailhol <mailhol.vincent@wanadoo.fr>
+ * Copyright (C) 2020, 2023 Vincent Mailhol <mailhol.vincent@wanadoo.fr>
  */
 
 #ifndef _CAN_LENGTH_H
 #define _CAN_LENGTH_H
 
+#include <linux/bits.h>
 #include <linux/can.h>
 #include <linux/can/netlink.h>
+#include <linux/math.h>
 
 /*
- * Size of a Classical CAN Standard Frame
+ * Size of a Classical CAN Standard Frame header in bits
+ *
+ * Name of Field				Bits
+ * ---------------------------------------------------------
+ * Start Of Frame (SOF)				1
+ * Arbitration field:
+ *	base ID					11
+ *	Remote Transmission Request (RTR)	1
+ * Control field:
+ *	IDentifier Extension bit (IDE)		1
+ *	FD Format indicator (FDF)		1
+ *	Data Length Code (DLC)			4
+ *
+ * including all fields preceding the data field, ignoring bitstuffing
+ */
+#define CAN_FRAME_HEADER_SFF_BITS 19
+
+/*
+ * Size of a Classical CAN Extended Frame header in bits
+ *
+ * Name of Field				Bits
+ * ---------------------------------------------------------
+ * Start Of Frame (SOF)				1
+ * Arbitration field:
+ *	base ID					11
+ *	Substitute Remote Request (SRR)		1
+ *	IDentifier Extension bit (IDE)		1
+ *	ID extension				18
+ *	Remote Transmission Request (RTR)	1
+ * Control field:
+ *	FD Format indicator (FDF)		1
+ *	Reserved bit (r0)			1
+ *	Data length code (DLC)			4
+ *
+ * including all fields preceding the data field, ignoring bitstuffing
+ */
+#define CAN_FRAME_HEADER_EFF_BITS 39
+
+/*
+ * Size of a CAN-FD Standard Frame in bits
+ *
+ * Name of Field				Bits
+ * ---------------------------------------------------------
+ * Start Of Frame (SOF)				1
+ * Arbitration field:
+ *	base ID					11
+ *	Remote Request Substitution (RRS)	1
+ * Control field:
+ *	IDentifier Extension bit (IDE)		1
+ *	FD Format indicator (FDF)		1
+ *	Reserved bit (res)			1
+ *	Bit Rate Switch (BRS)			1
+ *	Error Status Indicator (ESI)		1
+ *	Data length code (DLC)			4
+ *
+ * including all fields preceding the data field, ignoring bitstuffing
+ */
+#define CANFD_FRAME_HEADER_SFF_BITS 22
+
+/*
+ * Size of a CAN-FD Extended Frame in bits
+ *
+ * Name of Field				Bits
+ * ---------------------------------------------------------
+ * Start Of Frame (SOF)				1
+ * Arbitration field:
+ *	base ID					11
+ *	Substitute Remote Request (SRR)		1
+ *	IDentifier Extension bit (IDE)		1
+ *	ID extension				18
+ *	Remote Request Substitution (RRS)	1
+ * Control field:
+ *	FD Format indicator (FDF)		1
+ *	Reserved bit (res)			1
+ *	Bit Rate Switch (BRS)			1
+ *	Error Status Indicator (ESI)		1
+ *	Data length code (DLC)			4
+ *
+ * including all fields preceding the data field, ignoring bitstuffing
+ */
+#define CANFD_FRAME_HEADER_EFF_BITS 41
+
+/*
+ * Size of a CAN CRC Field in bits
+ *
+ * Name of Field			Bits
+ * ---------------------------------------------------------
+ * CRC sequence (CRC15)			15
+ * CRC Delimiter			1
+ *
+ * ignoring bitstuffing
+ */
+#define CAN_FRAME_CRC_FIELD_BITS 16
+
+/*
+ * Size of a CAN-FD CRC17 Field in bits (length: 0..16)
+ *
+ * Name of Field			Bits
+ * ---------------------------------------------------------
+ * Stuff Count				4
+ * CRC Sequence (CRC17)			17
+ * CRC Delimiter			1
+ * Fixed stuff bits			6
+ */
+#define CANFD_FRAME_CRC17_FIELD_BITS 28
+
+/*
+ * Size of a CAN-FD CRC21 Field in bits (length: 20..64)
+ *
+ * Name of Field			Bits
+ * ---------------------------------------------------------
+ * Stuff Count				4
+ * CRC sequence (CRC21)			21
+ * CRC Delimiter			1
+ * Fixed stuff bits			7
+ */
+#define CANFD_FRAME_CRC21_FIELD_BITS 33
+
+/*
+ * Size of a CAN(-FD) Frame footer in bits
  *
  * Name of Field			Bits
  * ---------------------------------------------------------
- * Start-of-frame			1
- * Identifier				11
- * Remote transmission request (RTR)	1
- * Identifier extension bit (IDE)	1
- * Reserved bit (r0)			1
- * Data length code (DLC)		4
- * Data field				0...64
- * CRC					15
- * CRC delimiter			1
  * ACK slot				1
  * ACK delimiter			1
- * End-of-frame (EOF)			7
- * Inter frame spacing			3
+ * End Of Frame (EOF)			7
  *
- * rounded up and ignoring bitstuffing
+ * including all fields following the CRC field
  */
-#define CAN_FRAME_OVERHEAD_SFF DIV_ROUND_UP(47, 8)
+#define CAN_FRAME_FOOTER_BITS 9
 
 /*
- * Size of a Classical CAN Extended Frame
- *
- * Name of Field			Bits
- * ---------------------------------------------------------
- * Start-of-frame			1
- * Identifier A				11
- * Substitute remote request (SRR)	1
- * Identifier extension bit (IDE)	1
- * Identifier B				18
- * Remote transmission request (RTR)	1
- * Reserved bits (r1, r0)		2
- * Data length code (DLC)		4
- * Data field				0...64
- * CRC					15
- * CRC delimiter			1
- * ACK slot				1
- * ACK delimiter			1
- * End-of-frame (EOF)			7
- * Inter frame spacing			3
- *
- * rounded up and ignoring bitstuffing
+ * First part of the Inter Frame Space
+ * (a.k.a. IMF - intermission field)
  */
-#define CAN_FRAME_OVERHEAD_EFF DIV_ROUND_UP(67, 8)
+#define CAN_INTERMISSION_BITS 3
+
+/**
+ * can_bitstuffing_len() - Calculate the maximum length with bitstuffing
+ * @destuffed_len: length of a destuffed bit stream
+ *
+ * The worst bit stuffing case is a sequence in which dominant and
+ * recessive bits alternate every four bits:
+ *
+ *   Destuffed: 1 1111  0000  1111  0000  1111
+ *   Stuffed:   1 1111o 0000i 1111o 0000i 1111o
+ *
+ * Nomenclature
+ *
+ *  - "0": dominant bit
+ *  - "o": dominant stuff bit
+ *  - "1": recessive bit
+ *  - "i": recessive stuff bit
+ *
+ * Aside from the first bit, one stuff bit is added every four bits.
+ *
+ * Return: length of the stuffed bit stream in the worst case scenario.
+ */
+#define can_bitstuffing_len(destuffed_len)			\
+	(destuffed_len + (destuffed_len - 1) / 4)
+
+#define __can_bitstuffing_len(bitstuffing, destuffed_len)	\
+	(bitstuffing ? can_bitstuffing_len(destuffed_len) :	\
+		       destuffed_len)
+
+#define __can_cc_frame_bits(is_eff, bitstuffing,		\
+			    intermission, data_len)		\
+(								\
+	__can_bitstuffing_len(bitstuffing,			\
+		(is_eff ? CAN_FRAME_HEADER_EFF_BITS :		\
+			  CAN_FRAME_HEADER_SFF_BITS) +		\
+		(data_len) * BITS_PER_BYTE +			\
+		CAN_FRAME_CRC_FIELD_BITS) +			\
+	CAN_FRAME_FOOTER_BITS +					\
+	(intermission ? CAN_INTERMISSION_BITS : 0)		\
+)
+
+#define __can_fd_frame_bits(is_eff, bitstuffing,		\
+			    intermission, data_len)		\
+(								\
+	__can_bitstuffing_len(bitstuffing,			\
+		(is_eff ? CANFD_FRAME_HEADER_EFF_BITS :		\
+			  CANFD_FRAME_HEADER_SFF_BITS) +	\
+		(data_len) * BITS_PER_BYTE) +			\
+	((data_len) <= 16 ?					\
+		CANFD_FRAME_CRC17_FIELD_BITS :			\
+		CANFD_FRAME_CRC21_FIELD_BITS) +			\
+	CAN_FRAME_FOOTER_BITS +					\
+	(intermission ? CAN_INTERMISSION_BITS : 0)		\
+)
+
+/**
+ * can_frame_bits() - Calculate the number of bits on the wire in a
+ *	CAN frame
+ * @is_fd: true: CAN-FD frame; false: Classical CAN frame.
+ * @is_eff: true: Extended frame; false: Standard frame.
+ * @bitstuffing: true: calculate the bitstuffing worst case; false:
+ *	calculate the bitstuffing best case (no dynamic
+ *	bitstuffing). CAN-FD's fixed stuff bits are always included.
+ * @intermission: if and only if true, include the inter frame space
+ *	assuming no bus idle (i.e. only the intermission). Strictly
+ *	speaking, the inter frame space is not part of the
+ *	frame. However, it is needed when calculating the delay
+ *	between the Start Of Frame of two consecutive frames.
+ * @data_len: length of the data field in bytes. Correspond to
+ *	can(fd)_frame->len. Should be zero for remote frames. No
+ *	sanitization is done on @data_len and it shall have no side
+ *	effects.
+ *
+ * Return: the numbers of bits on the wire of a CAN frame.
+ */
+#define can_frame_bits(is_fd, is_eff, bitstuffing,		\
+		       intermission, data_len)			\
+(								\
+	is_fd ? __can_fd_frame_bits(is_eff, bitstuffing,	\
+				    intermission, data_len) :	\
+		__can_cc_frame_bits(is_eff, bitstuffing,	\
+				    intermission, data_len)	\
+)
 
 /*
- * Size of a CAN-FD Standard Frame
- *
- * Name of Field			Bits
- * ---------------------------------------------------------
- * Start-of-frame			1
- * Identifier				11
- * Remote Request Substitution (RRS)	1
- * Identifier extension bit (IDE)	1
- * Flexible data rate format (FDF)	1
- * Reserved bit (r0)			1
- * Bit Rate Switch (BRS)		1
- * Error Status Indicator (ESI)		1
- * Data length code (DLC)		4
- * Data field				0...512
- * Stuff Bit Count (SBC)		4
- * CRC					0...16: 17 20...64:21
- * CRC delimiter (CD)			1
- * Fixed Stuff bits (FSB)		0...16: 6 20...64:7
- * ACK slot (AS)			1
- * ACK delimiter (AD)			1
- * End-of-frame (EOF)			7
- * Inter frame spacing			3
- *
- * assuming CRC21, rounded up and ignoring dynamic bitstuffing
+ * Number of bytes in a CAN frame
+ * (rounded up, including intermission)
  */
-#define CANFD_FRAME_OVERHEAD_SFF DIV_ROUND_UP(67, 8)
-
-/*
- * Size of a CAN-FD Extended Frame
- *
- * Name of Field			Bits
- * ---------------------------------------------------------
- * Start-of-frame			1
- * Identifier A				11
- * Substitute remote request (SRR)	1
- * Identifier extension bit (IDE)	1
- * Identifier B				18
- * Remote Request Substitution (RRS)	1
- * Flexible data rate format (FDF)	1
- * Reserved bit (r0)			1
- * Bit Rate Switch (BRS)		1
- * Error Status Indicator (ESI)		1
- * Data length code (DLC)		4
- * Data field				0...512
- * Stuff Bit Count (SBC)		4
- * CRC					0...16: 17 20...64:21
- * CRC delimiter (CD)			1
- * Fixed Stuff bits (FSB)		0...16: 6 20...64:7
- * ACK slot (AS)			1
- * ACK delimiter (AD)			1
- * End-of-frame (EOF)			7
- * Inter frame spacing			3
- *
- * assuming CRC21, rounded up and ignoring dynamic bitstuffing
- */
-#define CANFD_FRAME_OVERHEAD_EFF DIV_ROUND_UP(86, 8)
+#define can_frame_bytes(is_fd, is_eff, bitstuffing, data_len)	\
+	DIV_ROUND_UP(can_frame_bits(is_fd, is_eff, bitstuffing,	\
+				    true, data_len),		\
+		     BITS_PER_BYTE)
 
 /*
  * Maximum size of a Classical CAN frame
- * (rounded up and ignoring bitstuffing)
+ * (rounded up, ignoring bitstuffing but including intermission)
  */
-#define CAN_FRAME_LEN_MAX (CAN_FRAME_OVERHEAD_EFF + CAN_MAX_DLEN)
+#define CAN_FRAME_LEN_MAX can_frame_bytes(false, true, false, CAN_MAX_DLEN)
 
 /*
  * Maximum size of a CAN-FD frame
- * (rounded up and ignoring bitstuffing)
+ * (rounded up, ignoring dynamic bitstuffing but including intermission)
  */
-#define CANFD_FRAME_LEN_MAX (CANFD_FRAME_OVERHEAD_EFF + CANFD_MAX_DLEN)
+#define CANFD_FRAME_LEN_MAX can_frame_bytes(true, true, false, CANFD_MAX_DLEN)
 
 /*
  * can_cc_dlc2len(value) - convert a given data length code (dlc) of a
-- 
2.40.1


