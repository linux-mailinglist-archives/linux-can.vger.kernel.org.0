Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B1C71579295
	for <lists+linux-can@lfdr.de>; Tue, 19 Jul 2022 07:42:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236710AbiGSFmW (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Tue, 19 Jul 2022 01:42:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236733AbiGSFmT (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 19 Jul 2022 01:42:19 -0400
Received: from mo4-p00-ob.smtp.rzone.de (mo4-p00-ob.smtp.rzone.de [85.215.255.23])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23CBB3056B
        for <linux-can@vger.kernel.org>; Mon, 18 Jul 2022 22:42:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1658209333;
    s=strato-dkim-0002; d=hartkopp.net;
    h=References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=9OItUrGJmllTxwOjjIOYpHcfw73/qMnchtL64JrJywU=;
    b=kvJxsEiT8wyafNBx1VATdNJO1a+BQTvBXpPKN6AhaxbY5sp77J8QqSaO3ebbeM0JL6
    Ug7o0Vulb82+jjvpAAux+48ouVxCsCdC0+tnJvwOXF39X1MfV9pmeBKJooufJbBpoJ4s
    2ceMW3a/FtvjCpc7fikYUKE09Ub5gXQhq9VevihrZsXJJoCiR8EPA7Sch8pAtjdqiBL8
    m66PbDM1plzmefRzyOHolEXdBLEO13eN7aX2QVX2g2xE6eD6FpVZYdtd2Z/EeycmG8H9
    748s0DHgTYMCm/3K3cHA4kqPrLGbNckC4WlU5QErnxAN3ufG80p8w8SOwCSN9acFo2at
    YdUw==
Authentication-Results: strato.com;
    dkim=none
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjGrp7owjzFK3JbFk1mS/xvEBL7X5sbo3UIh9JiLceSWJaYwXUKbZ"
X-RZG-CLASS-ID: mo00
Received: from silver.lan
    by smtp.strato.de (RZmta 47.47.0 AUTH)
    with ESMTPSA id t870d5y6J5gDF5j
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Tue, 19 Jul 2022 07:42:13 +0200 (CEST)
From:   Oliver Hartkopp <socketcan@hartkopp.net>
To:     linux-can@vger.kernel.org
Cc:     Oliver Hartkopp <socketcan@hartkopp.net>
Subject: [RFC PATCH v4 1/5] can: canxl: introduce CAN XL data structure
Date:   Tue, 19 Jul 2022 07:42:00 +0200
Message-Id: <20220719054204.29061-2-socketcan@hartkopp.net>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220719054204.29061-1-socketcan@hartkopp.net>
References: <20220719054204.29061-1-socketcan@hartkopp.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
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
 include/uapi/linux/can.h | 49 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 49 insertions(+)

diff --git a/include/uapi/linux/can.h b/include/uapi/linux/can.h
index 90801ada2bbe..e736ed7be32d 100644
--- a/include/uapi/linux/can.h
+++ b/include/uapi/linux/can.h
@@ -46,10 +46,11 @@
 #ifndef _UAPI_CAN_H
 #define _UAPI_CAN_H
 
 #include <linux/types.h>
 #include <linux/socket.h>
+#include <linux/stddef.h> /* for offsetof */
 
 /* controller area network (CAN) kernel definitions */
 
 /* special address description flags for the CAN_ID */
 #define CAN_EFF_FLAG 0x80000000U /* EFF/SFF is set in the MSB */
@@ -58,10 +59,11 @@
 
 /* valid bits in CAN ID for frame formats */
 #define CAN_SFF_MASK 0x000007FFU /* standard frame format (SFF) */
 #define CAN_EFF_MASK 0x1FFFFFFFU /* extended frame format (EFF) */
 #define CAN_ERR_MASK 0x1FFFFFFFU /* omit EFF, RTR, ERR flags */
+#define CANXL_PRIO_MASK CAN_SFF_MASK /* 11 bit priority mask */
 
 /*
  * Controller Area Network Identifier structure
  *
  * bit 0-28	: CAN identifier (11/29 bit)
@@ -71,10 +73,11 @@
  */
 typedef __u32 canid_t;
 
 #define CAN_SFF_ID_BITS		11
 #define CAN_EFF_ID_BITS		29
+#define CANXL_PRIO_BITS		CAN_SFF_ID_BITS
 
 /*
  * Controller Area Network Error Message Frame Mask structure
  *
  * bit 0-28	: error class mask (see include/uapi/linux/can/error.h)
@@ -89,10 +92,20 @@ typedef __u32 can_err_mask_t;
 
 /* CAN FD payload length and DLC definitions according to ISO 11898-7 */
 #define CANFD_MAX_DLC 15
 #define CANFD_MAX_DLEN 64
 
+/*
+ * CAN XL payload length and DLC definitions according to ISO 11898-1
+ * CAN XL DLC ranges from 0 .. 2047 => data length from 1 .. 2048 byte
+ */
+#define CANXL_MIN_DLC 0
+#define CANXL_MAX_DLC 2047
+#define CANXL_MAX_DLC_MASK 0x07FF
+#define CANXL_MIN_DLEN 1
+#define CANXL_MAX_DLEN 2048
+
 /**
  * struct can_frame - Classical CAN frame structure (aka CAN 2.0B)
  * @can_id:   CAN ID of the frame and CAN_*_FLAG flags, see canid_t definition
  * @len:      CAN frame payload length in byte (0 .. 8)
  * @can_dlc:  deprecated name for CAN frame payload length in byte (0 .. 8)
@@ -164,12 +177,48 @@ struct canfd_frame {
 	__u8    __res0;  /* reserved / padding */
 	__u8    __res1;  /* reserved / padding */
 	__u8    data[CANFD_MAX_DLEN] __attribute__((aligned(8)));
 };
 
+/*
+ * defined bits for canxl_frame.flags
+ *
+ * The canxl_frame.flags element contains two bits CANXL_XLF and CANXL_SEC
+ * and shares the relative position of the struct can[fd]_frame.len element.
+ * The CANXL_XLF bit ALWAYS needs to be set to indicate a valid CAN XL frame.
+ * As a side effect setting this bit intentionally breaks the length checks
+ * for Classical CAN and CAN FD frames.
+ *
+ * Undefined bits in canxl_frame.flags are reserved and shall be set to zero.
+ */
+#define CANXL_XLF 0x80 /* mandatory CAN XL frame flag (must always be set!) */
+#define CANXL_SEC 0x01 /* Simple Extended Content (security/segmentation) */
+
+/**
+ * struct canxl_frame - CAN with e'X'tended frame 'L'ength frame structure
+ * @prio:  11 bit arbitration priority with zero'ed CAN_*_FLAG flags
+ * @flags: additional flags for CAN XL
+ * @sdt:   SDU (service data unit) type
+ * @len:   frame payload length in byte (1 .. CANXL_MAX_DLEN)
+ * @af:    acceptance field
+ * @data:  CAN XL frame payload (up to CANXL_MAX_DLEN byte)
+ *
+ * @prio shares the same position as @can_id from struct can[fd]_frame.
+ */
+struct canxl_frame {
+	canid_t prio;  /* 11 bit priority for arbitration (canid_t) */
+	__u8    flags; /* additional flags for CAN XL */
+	__u8    sdt;   /* SDU (service data unit) type */
+	__u16   len;   /* frame payload length in byte */
+	__u32   af;    /* acceptance field */
+	__u8    data[CANXL_MAX_DLEN];
+};
+
 #define CAN_MTU		(sizeof(struct can_frame))
 #define CANFD_MTU	(sizeof(struct canfd_frame))
+#define CANXL_MTU	(sizeof(struct canxl_frame))
+#define CANXL_HDR_SZ	(offsetof(struct canxl_frame, data))
 
 /* particular protocols of the protocol family PF_CAN */
 #define CAN_RAW		1 /* RAW sockets */
 #define CAN_BCM		2 /* Broadcast Manager */
 #define CAN_TP16	3 /* VAG Transport Protocol v1.6 */
-- 
2.30.2

