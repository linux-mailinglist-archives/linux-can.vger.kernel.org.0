Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0FFC729E0CE
	for <lists+linux-can@lfdr.de>; Thu, 29 Oct 2020 02:38:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729896AbgJ1WDD (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Wed, 28 Oct 2020 18:03:03 -0400
Received: from mo4-p00-ob.smtp.rzone.de ([85.215.255.24]:16483 "EHLO
        mo4-p00-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729470AbgJ1WBG (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Wed, 28 Oct 2020 18:01:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1603922462;
        s=strato-dkim-0002; d=hartkopp.net;
        h=References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
        X-RZG-CLASS-ID:X-RZG-AUTH:From:Subject:Sender;
        bh=+EwYHsyP/ujanmkr16VmrZcP5N+3A2Gh/sBGP7WiYdY=;
        b=Awq5EiJ/I3DcMjSqtTouuI6e7DBQ8w7u5QeI3vYllAdWDG0GH0EiUf+roAYY7l8UOK
        zvvuFsqNBdoNHAja0h1yhf1eLMBzkLERztRTg1TmVzG/5hl/aALGYdL4jf3j8KY4ZtJA
        XiEXfXF+ko2xWJ9Hqou+cxwMK1u2WDM29JiynQEw84MzoVVOUoMenCjgqHYC6dkrMRLP
        LQvJ0elimLo6RGTIMGezx0bQUv++dM9ZdzLh05qn5/O99f9sucufQS/3zDsB/HhheKST
        1a6cMIJUdYqGe9tMvQMhI3QrfxacrQDHh8ZERhgn/pyx/qpq1xsX02ApLlmgkHuYK9u3
        dOWA==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjGrp7owjzFK3JbFk1mS0k+8CejudJy4jsSjttw=="
X-RZG-CLASS-ID: mo00
Received: from silver.lan
        by smtp.strato.de (RZmta 47.2.3 DYNA|AUTH)
        with ESMTPSA id J01b14w9SB0x0RL
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
        Wed, 28 Oct 2020 12:00:59 +0100 (CET)
From:   Oliver Hartkopp <socketcan@hartkopp.net>
To:     mailhol.vincent@wanadoo.fr, mkl@pengutronix.de
Cc:     linux-can@vger.kernel.org, Oliver Hartkopp <socketcan@hartkopp.net>
Subject: [PATCH 1/4] can: add optional DLC element to Classical CAN frame structure
Date:   Wed, 28 Oct 2020 12:00:30 +0100
Message-Id: <20201028110033.113702-2-socketcan@hartkopp.net>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201028110033.113702-1-socketcan@hartkopp.net>
References: <20201028110033.113702-1-socketcan@hartkopp.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

ISO 11898-1 Chapter 8.4.2.3 defines a 4 bit data length code (DLC) table which
maps the DLC to the payload length of the CAN frame in bytes:

    DLC      ->  payload length
    0 .. 8   ->  0 .. 8
    9 .. 15  ->  8

Although the DLC values 8 .. 15 in Classical CAN always result in a payload
length of 8 bytes these DLC values are transparently transmitted on the CAN
bus. As the struct can_frame only provides a 'len' element (formerly 'can_dlc')
which contains the plain payload length ( 0 .. 8 ) of the CAN frame, the raw
DLC is not visible to the application programmer, e.g. for testing use-cases.

To access the raw DLC values 9 .. 15 the len8_dlc element is introduced, which
is only valid when the payload length 'len' is 8 and the DLC is greater than 8.

The len8_dlc element is filled by the CAN interface driver and used for CAN
frame creation by the CAN driver when the CAN_CTRLMODE_CC_LEN8_DLC flag is
supported by the driver and enabled via netlink configuration interface.

Reported-by: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Signed-off-by: Oliver Hartkopp <socketcan@hartkopp.net>
---
 include/uapi/linux/can.h         | 36 ++++++++++++++++++++------------
 include/uapi/linux/can/netlink.h |  1 +
 2 files changed, 24 insertions(+), 13 deletions(-)

diff --git a/include/uapi/linux/can.h b/include/uapi/linux/can.h
index 6a6d2c7655ff..b131617d60ae 100644
--- a/include/uapi/linux/can.h
+++ b/include/uapi/linux/can.h
@@ -82,34 +82,44 @@ typedef __u32 canid_t;
  */
 typedef __u32 can_err_mask_t;
 
 /* CAN payload length and DLC definitions according to ISO 11898-1 */
 #define CAN_MAX_DLC 8
+#define CAN_MAX_RAW_DLC 15
 #define CAN_MAX_DLEN 8
 
 /* CAN FD payload length and DLC definitions according to ISO 11898-7 */
 #define CANFD_MAX_DLC 15
 #define CANFD_MAX_DLEN 64
 
 /**
  * struct can_frame - basic CAN frame structure
- * @can_id:  CAN ID of the frame and CAN_*_FLAG flags, see canid_t definition
- * @can_dlc: frame payload length in byte (0 .. 8) aka data length code
- *           N.B. the DLC field from ISO 11898-1 Chapter 8.4.2.3 has a 1:1
- *           mapping of the 'data length code' to the real payload length
- * @__pad:   padding
- * @__res0:  reserved / padding
- * @__res1:  reserved / padding
- * @data:    CAN frame payload (up to 8 byte)
+ * @can_id:   CAN ID of the frame and CAN_*_FLAG flags, see canid_t definition
+ * @len:      CAN frame payload length in byte (0 .. 8)
+ * @can_dlc:  deprecated name for CAN frame payload length in byte (0 .. 8)
+ * @__pad:    padding
+ * @__res0:   reserved / padding
+ * @len8_dlc: optional DLC value (9 .. 15) at 8 byte payload length
+ *            len8_dlc contains values from 9 .. 15 when the payload length is
+ *            8 bytes but the DLC value (see ISO 11898-1) is greater then 8.
+ *            CAN_CTRLMODE_CC_LEN8_DLC flag has to be enabled in CAN driver.
+ * @data:     CAN frame payload (up to 8 byte)
  */
 struct can_frame {
 	canid_t can_id;  /* 32 bit CAN_ID + EFF/RTR/ERR flags */
-	__u8    can_dlc; /* frame payload length in byte (0 .. CAN_MAX_DLEN) */
-	__u8    __pad;   /* padding */
-	__u8    __res0;  /* reserved / padding */
-	__u8    __res1;  /* reserved / padding */
-	__u8    data[CAN_MAX_DLEN] __attribute__((aligned(8)));
+	union {
+		/* CAN frame payload length in byte (0 .. CAN_MAX_DLEN)
+		 * was previously named can_dlc so we need to carry that
+		 * name for legacy support
+		 */
+		__u8 len;
+		__u8 can_dlc; /* deprecated */
+	};
+	__u8 __pad; /* padding */
+	__u8 __res0; /* reserved / padding */
+	__u8 len8_dlc; /* optional DLC for 8 byte payload length (9 .. 15) */
+	__u8 data[CAN_MAX_DLEN] __attribute__((aligned(8)));
 };
 
 /*
  * defined bits for canfd_frame.flags
  *
diff --git a/include/uapi/linux/can/netlink.h b/include/uapi/linux/can/netlink.h
index 6f598b73839e..f730d443b918 100644
--- a/include/uapi/linux/can/netlink.h
+++ b/include/uapi/linux/can/netlink.h
@@ -98,10 +98,11 @@ struct can_ctrlmode {
 #define CAN_CTRLMODE_ONE_SHOT		0x08	/* One-Shot mode */
 #define CAN_CTRLMODE_BERR_REPORTING	0x10	/* Bus-error reporting */
 #define CAN_CTRLMODE_FD			0x20	/* CAN FD mode */
 #define CAN_CTRLMODE_PRESUME_ACK	0x40	/* Ignore missing CAN ACKs */
 #define CAN_CTRLMODE_FD_NON_ISO		0x80	/* CAN FD in non-ISO mode */
+#define CAN_CTRLMODE_CC_LEN8_DLC	0x100	/* Classic CAN DLC option */
 
 /*
  * CAN device statistics
  */
 struct can_device_stats {
-- 
2.28.0

