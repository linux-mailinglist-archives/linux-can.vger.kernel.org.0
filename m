Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED8AD570A01
	for <lists+linux-can@lfdr.de>; Mon, 11 Jul 2022 20:34:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229984AbiGKSey (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Mon, 11 Jul 2022 14:34:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230331AbiGKSew (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Mon, 11 Jul 2022 14:34:52 -0400
Received: from mo4-p00-ob.smtp.rzone.de (mo4-p00-ob.smtp.rzone.de [81.169.146.160])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3A0B52DF6
        for <linux-can@vger.kernel.org>; Mon, 11 Jul 2022 11:34:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1657564480;
    s=strato-dkim-0002; d=hartkopp.net;
    h=References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=4Ghs3K3iTuiBwUdu6PLNxFddceDf4PNW6koTMVNsZXY=;
    b=eQ0G4+aJuHHTb5KsnZFEXuXIIsCXd2M0rSU1/SxbjVEniq5/uOcY73zXGlb2sBpWUx
    7OXsB46ydbSTv2D/ygulpuAvfGLIeB04m40sFGS8kY2kR1WnAa7k0MyqcyQYlCDFMa8o
    5OGuV/ic6Hf8XJlKu/3Qle5UHGwaM7ld11fI1pZ6hV8R6rdb2TDIm3u0bZyUKNDk3BRQ
    QfeId1lYr34su0mx13yOCp8eIrevzCRb6n8eu7rs1F86NmLhAGjpO6iqPInxVLNfXVUi
    UR+cGbnv85wQbtcTbzNKtfh/1S6XW0RPBPf3/YZHBBVJmdbwslv9jt+GCjDv2Q8RewP5
    gxgg==
Authentication-Results: strato.com;
    dkim=none
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjGrp7owjzFK3JbFk1mS/xvEBL7X5sbo3UIh9JiLceSWJaYwXUKbZ"
X-RZG-CLASS-ID: mo00
Received: from silver.lan
    by smtp.strato.de (RZmta 47.46.1 AUTH)
    with ESMTPSA id 398cccy6BIYeReL
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Mon, 11 Jul 2022 20:34:40 +0200 (CEST)
From:   Oliver Hartkopp <socketcan@hartkopp.net>
To:     linux-can@vger.kernel.org
Cc:     Oliver Hartkopp <socketcan@hartkopp.net>
Subject: [RFC PATCH 1/5] can: canxl: introduce CAN XL data structure
Date:   Mon, 11 Jul 2022 20:34:22 +0200
Message-Id: <20220711183426.96446-2-socketcan@hartkopp.net>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220711183426.96446-1-socketcan@hartkopp.net>
References: <20220711183426.96446-1-socketcan@hartkopp.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

This patch adds defines for data structures and length information for
CAN XL (CAN with eXtended data Length) which can transfer up to 2048
byte insinde a single frame.

Notable changes from CAN FD:

- the 11 bit arbitration field is now named 'priority' instead of 'can_id'
  (there are no 29 bit identifiers nor RTR frames anymore)
- the data length needs a uint16 value to cover up to 2048 byte
  (the length element position is different to struct can[fd]_frame)
- new fields (SDT, AF) and a SEC bit have been introduced
- the virtual CAN interface identifier is not part if the CAN XL frame
  struct as this VCID value is stored in struct skbuff (analog to vlan id)

Signed-off-by: Oliver Hartkopp <socketcan@hartkopp.net>
---
 include/uapi/linux/can.h | 38 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 38 insertions(+)

diff --git a/include/uapi/linux/can.h b/include/uapi/linux/can.h
index 90801ada2bbe..9f97a5d06f3b 100644
--- a/include/uapi/linux/can.h
+++ b/include/uapi/linux/can.h
@@ -58,10 +58,11 @@
 
 /* valid bits in CAN ID for frame formats */
 #define CAN_SFF_MASK 0x000007FFU /* standard frame format (SFF) */
 #define CAN_EFF_MASK 0x1FFFFFFFU /* extended frame format (EFF) */
 #define CAN_ERR_MASK 0x1FFFFFFFU /* omit EFF, RTR, ERR flags */
+#define CANXL_PRIO_MASK CAN_SFF_MASK /* 11 bit priority mask */
 
 /*
  * Controller Area Network Identifier structure
  *
  * bit 0-28	: CAN identifier (11/29 bit)
@@ -71,10 +72,11 @@
  */
 typedef __u32 canid_t;
 
 #define CAN_SFF_ID_BITS		11
 #define CAN_EFF_ID_BITS		29
+#define CANXL_PRIO_BITS		CAN_SFF_ID_BITS
 
 /*
  * Controller Area Network Error Message Frame Mask structure
  *
  * bit 0-28	: error class mask (see include/uapi/linux/can/error.h)
@@ -89,10 +91,18 @@ typedef __u32 can_err_mask_t;
 
 /* CAN FD payload length and DLC definitions according to ISO 11898-7 */
 #define CANFD_MAX_DLC 15
 #define CANFD_MAX_DLEN 64
 
+/*
+ * CAN XL payload length and DLC definitions according to ISO 11898-1
+ * CAN XL DLC ranges from 0 .. 2047 => data length from 1 .. 2048 byte
+ */
+#define CANXL_MAX_DLC 2047
+#define CANXL_MAX_DLC_MASK 0x07FF
+#define CANXL_MAX_DLEN 2048
+
 /**
  * struct can_frame - Classical CAN frame structure (aka CAN 2.0B)
  * @can_id:   CAN ID of the frame and CAN_*_FLAG flags, see canid_t definition
  * @len:      CAN frame payload length in byte (0 .. 8)
  * @can_dlc:  deprecated name for CAN frame payload length in byte (0 .. 8)
@@ -141,14 +151,20 @@ struct can_frame {
  * When this is done the former differentiation via CAN_MTU / CANFD_MTU gets
  * lost. CANFD_FDF allows programmers to mark CAN FD frames in the case of
  * using struct canfd_frame for mixed CAN / CAN FD content (dual use).
  * N.B. the Kernel APIs do NOT provide mixed CAN / CAN FD content inside of
  * struct canfd_frame therefore the CANFD_FDF flag is disregarded by Linux.
+ * Same applies to the CANXL_XLF bit.
+ *
+ * For CAN XL the SEC bit has been added to the flags field which shares the
+ * same position in struct can[fd|xl]_frame.
  */
 #define CANFD_BRS 0x01 /* bit rate switch (second bitrate for payload data) */
 #define CANFD_ESI 0x02 /* error state indicator of the transmitting node */
 #define CANFD_FDF 0x04 /* mark CAN FD for dual use of struct canfd_frame */
+#define CANXL_XLF 0x08 /* mark CAN XL for dual use of struct canfd_frame */
+#define CANXL_SEC 0x10 /* Simple Extended Content (security/segmentation) */
 
 /**
  * struct canfd_frame - CAN flexible data rate frame structure
  * @can_id: CAN ID of the frame and CAN_*_FLAG flags, see canid_t definition
  * @len:    frame payload length in byte (0 .. CANFD_MAX_DLEN)
@@ -164,12 +180,34 @@ struct canfd_frame {
 	__u8    __res0;  /* reserved / padding */
 	__u8    __res1;  /* reserved / padding */
 	__u8    data[CANFD_MAX_DLEN] __attribute__((aligned(8)));
 };
 
+/**
+ * struct canxl_frame - CAN with e'X'tended frame 'L'ength frame structure
+ * @prio:  11 bit arbitration priority with zero'ed CAN_*_FLAG flags
+ * @sdt:   SDU (service data unit) type
+ * @flags: additional flags for CAN XL
+ * @len:   frame payload length in byte (1 .. CANXL_MAX_DLEN)
+ * @af:    acceptance field
+ * @data:  CAN XL frame payload (up to CANXL_MAX_DLEN byte)
+ *
+ * @prio shares the same position as @can_id from struct canfd_frame.
+ * Same applies to the relative position and length of @flags.
+ */
+struct canxl_frame {
+	canid_t prio;  /* 11 bit priority for arbitration (canid_t) */
+	__u8    sdt;   /* SDU (service data unit) type */
+	__u8    flags; /* additional flags for CAN XL */
+	__u16   len;   /* frame payload length in byte */
+	__u32   af;    /* acceptance field */
+	__u8    data[CANXL_MAX_DLEN];
+};
+
 #define CAN_MTU		(sizeof(struct can_frame))
 #define CANFD_MTU	(sizeof(struct canfd_frame))
+#define CANXL_MTU	(sizeof(struct canxl_frame))
 
 /* particular protocols of the protocol family PF_CAN */
 #define CAN_RAW		1 /* RAW sockets */
 #define CAN_BCM		2 /* Broadcast Manager */
 #define CAN_TP16	3 /* VAG Transport Protocol v1.6 */
-- 
2.30.2

