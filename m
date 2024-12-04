Return-Path: <linux-can+bounces-2327-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B4F459E34D0
	for <lists+linux-can@lfdr.de>; Wed,  4 Dec 2024 09:03:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7727F285414
	for <lists+linux-can@lfdr.de>; Wed,  4 Dec 2024 08:03:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F4BC192580;
	Wed,  4 Dec 2024 07:57:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="M9ebbO56";
	dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="rRztWKPV"
X-Original-To: linux-can@vger.kernel.org
Received: from mo4-p01-ob.smtp.rzone.de (mo4-p01-ob.smtp.rzone.de [85.215.255.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EA7D18FC84
	for <linux-can@vger.kernel.org>; Wed,  4 Dec 2024 07:57:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=85.215.255.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733299073; cv=pass; b=AY3FFR3LBqXPBftXqVHApxEAVT5w6VciAAub8sg3yBZI/mAbvpKsz+cOz/CHXl9XhcScyCtA5LiV3R52nz7qcR6FuzFJXd1XVkNaXM5LzhUzhgMtuN4MmrKbRVGCXNAcuKiC9COLqdWvukPD8nrz/KdabWt7+QGXhSDRkdCIlUY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733299073; c=relaxed/simple;
	bh=yG8/K4WjuuOCYn1oKhh8RaYV1/2DlH04WOOos1meZMY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Xqj/Q4J9srInkQ7N5iH2LS62Pun0Smy4N6DnqUrCJMGxATemUBiNJawrPT+JgKj9R/2B63YhI2vvoAY3L/t9WvUFY9Tmr+imahKAC/inbEL0TWS4K71EUnBYmXHrMR3VxTvq9x6BandXea3Ub/keBhPIT4el8VCGDwLf7gxtl/E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net; spf=pass smtp.mailfrom=hartkopp.net; dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=M9ebbO56; dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=rRztWKPV; arc=pass smtp.client-ip=85.215.255.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hartkopp.net
ARC-Seal: i=1; a=rsa-sha256; t=1733299069; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=MXHM1Z9MPXpBawRddzZW5IeUAEpQt91HirVcxAY78Z47IM3YUOn4bkkfF2yta7wgfF
    TNN6/x1/fGgrtRJ8c+SB9JIMKVs4uLHFmtcdsZXDaG0PP7ws0BdhP4RFA8lJIjwYRf9R
    tyhvWBE9U6rLUjSV2udDp8pkdpyC4wqEtCT6S3gLAUnMRPpcw8uKxoOpLblkr1365fRe
    L3ed+g2Es3Tn0X11P4MeDvUPOSYSQAaqLdVZSDtSq4qakg3wEVUh+FC7ykSW+2YbhqpV
    1jVu3FR2u/ruUZ7trXw6pUXf5ggbhVka05+1xNRMBb9/ZfTvOrP3Zs6ikWRVL4p5lyYF
    7+dQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1733299069;
    s=strato-dkim-0002; d=strato.com;
    h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=zS6VkgkDLRqefL/qC1S2BM932epxcFdpD6dvr1IU1Rw=;
    b=UzjxXQiJ+aiTpqnbgqLAEBjaL10p0+Nc+cF27fLlyWw9LwY2OzdTzovPYLCIeMWSyt
    5IduURQw8vjLVYmVM10gK+D4X0TKr6Ph4gef61sgiHk2nKkcbFZJXrkNOl3vWu9kmVkF
    BE6G7lW6TdI3VMe2fpInEZ/dS7hhq7v3OtS53mNm+cF71zsuNCS0oQVfSWTz5gxWxEUe
    QCMz0gIFmPQbYp/q5BhfDwrzy75r10EOsP2HoNVHBW11NFaWxnRnz/lVRJiOuA0XY0cc
    zntISwcV95HleJRb+wXYgWdKItKuMMMn5w17EZD/LyWVIbE0eLGNqWUN2/tvQpN1lpjA
    +6Kg==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1733299069;
    s=strato-dkim-0002; d=hartkopp.net;
    h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=zS6VkgkDLRqefL/qC1S2BM932epxcFdpD6dvr1IU1Rw=;
    b=M9ebbO56Ogp2kqDz78QgBVNCNZDZDhurX4UINgPP7EA0aoKZOtoUaOGK4sbgjyON9+
    a1lq/4pMv5xKeT/D2ID8yFzz8LlXm7E57dSmPfxxBf8FIIJ/172yFH0h0pL+9/X3x1CD
    yggvuZ9HUG5CHm1G+syo8C1BwtFJbBCLrluzTRf7672Qfm0Unq3qYy4CsMP2VvIDxua4
    6OzoYcIv3JVXvXn1xkAut9X9iq2gy4EXJ1AYM7YjsUw6ssieKVNgAaZqThQmz2CdOC2g
    aM07/GcmLszojj6Bm0TUt9+ddVjzDQsywW3PyUr2b4T/+O8BUAgDFRovITYM5xEAc/8T
    ei5g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1733299069;
    s=strato-dkim-0003; d=hartkopp.net;
    h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=zS6VkgkDLRqefL/qC1S2BM932epxcFdpD6dvr1IU1Rw=;
    b=rRztWKPVrz2nJvcVXW+RaW23x9rGGFl4xfHM3JNWVBcDC1O0NZSyfISDmt/RpSp9nG
    pZOWaElUShbipO64wqBg==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjH4JKvMdQv2tRkI16oOSXVT6pap5"
Received: from lenov17.lan
    by smtp.strato.de (RZmta 51.2.11 DYNA|AUTH)
    with ESMTPSA id K63ada0B47vnsrF
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Wed, 4 Dec 2024 08:57:49 +0100 (CET)
From: Oliver Hartkopp <socketcan@hartkopp.net>
To: linux-can@vger.kernel.org
Cc: Oliver Hartkopp <socketcan@hartkopp.net>
Subject: [RFC PATCH v2 2/3] iplink_can: canxl: support Remote Request Substitution bit access
Date: Wed,  4 Dec 2024 08:57:40 +0100
Message-ID: <20241204075741.3727-2-socketcan@hartkopp.net>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241204075741.3727-1-socketcan@hartkopp.net>
References: <20241204075741.3727-1-socketcan@hartkopp.net>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="us-ascii"

The Remote Request Substitution bit is a dominant bit ("0") in the CAN XL
frame. As some CAN XL controllers support to access this bit a new
CANXL_RRS value has been defined for the canxl_frame.flags element.

To read/write the Remote Request Substitution (RRS) bit in the CAN XL
frame the CAN_CTRLMODE_XL_RRS has to be enabled in CAN driver.

Signed-off-by: Oliver Hartkopp <socketcan@hartkopp.net>
---
 include/uapi/linux/can.h         | 5 ++++-
 include/uapi/linux/can/netlink.h | 1 +
 ip/iplink_can.c                  | 6 ++++++
 3 files changed, 11 insertions(+), 1 deletion(-)

diff --git a/include/uapi/linux/can.h b/include/uapi/linux/can.h
index 229a77ff..513d3d75 100644
--- a/include/uapi/linux/can.h
+++ b/include/uapi/linux/can.h
@@ -180,20 +180,23 @@ struct canfd_frame {
 };
 
 /*
  * defined bits for canxl_frame.flags
  *
- * The canxl_frame.flags element contains two bits CANXL_XLF and CANXL_SEC
+ * The canxl_frame.flags element contains three bits CANXL_[XLF|SEC|RRS]
  * and shares the relative position of the struct can[fd]_frame.len element.
  * The CANXL_XLF bit ALWAYS needs to be set to indicate a valid CAN XL frame.
  * As a side effect setting this bit intentionally breaks the length checks
  * for Classical CAN and CAN FD frames.
+ * To read/write the Remote Request Substitution (RRS) bit in the CAN XL
+ * frame the CAN_CTRLMODE_XL_RRS has to be enabled in CAN driver.
  *
  * Undefined bits in canxl_frame.flags are reserved and shall be set to zero.
  */
 #define CANXL_XLF 0x80 /* mandatory CAN XL frame flag (must always be set!) */
 #define CANXL_SEC 0x01 /* Simple Extended Content (security/segmentation) */
+#define CANXL_RRS 0x02 /* Remote Request Substitution */
 
 /* the 8-bit VCID is optionally placed in the canxl_frame.prio element */
 #define CANXL_VCID_OFFSET 16 /* bit offset of VCID in prio element */
 #define CANXL_VCID_VAL_MASK 0xFFUL /* VCID is an 8-bit value */
 #define CANXL_VCID_MASK (CANXL_VCID_VAL_MASK << CANXL_VCID_OFFSET)
diff --git a/include/uapi/linux/can/netlink.h b/include/uapi/linux/can/netlink.h
index 416e2feb..19267678 100644
--- a/include/uapi/linux/can/netlink.h
+++ b/include/uapi/linux/can/netlink.h
@@ -104,10 +104,11 @@ struct can_ctrlmode {
 #define CAN_CTRLMODE_TDC_AUTO		0x200	/* FD transceiver automatically calculates TDCV */
 #define CAN_CTRLMODE_TDC_MANUAL		0x400	/* FD TDCV is manually set up by user */
 #define CAN_CTRLMODE_XL			0x800	/* CAN XL mode */
 #define CAN_CTRLMODE_XL_TDC_AUTO	0x1000	/* XL transceiver automatically calculates TDCV */
 #define CAN_CTRLMODE_XL_TDC_MANUAL	0x2000	/* XL TDCV is manually set up by user */
+#define CAN_CTRLMODE_XL_RRS		0x4000	/* XL enable RRS bit access */
 
 /*
  * CAN device statistics
  */
 struct can_device_stats {
diff --git a/ip/iplink_can.c b/ip/iplink_can.c
index 8dc9229b..9fe9ae6c 100644
--- a/ip/iplink_can.c
+++ b/ip/iplink_can.c
@@ -40,10 +40,11 @@ static void print_usage(FILE *f)
 		"\t[ presume-ack { on | off } ]\n"
 		"\t[ cc-len8-dlc { on | off } ]\n"
 		"\t[ tdc-mode { auto | manual | off } ]\n"
 		"\t[ xl { on | off } ]\n"
 		"\t[ xtdc-mode { auto | manual | off } ]\n"
+		"\t[ xlrrs { on | off } ]\n"
 		"\n"
 		"\t[ restart-ms TIME-MS ]\n"
 		"\t[ restart ]\n"
 		"\n"
 		"\t[ termination { 0..65535 } ]\n"
@@ -123,10 +124,11 @@ static void print_ctrlmode(enum output_type t, __u32 flags, const char* key)
 	print_flag(t, &flags, CAN_CTRLMODE_TDC_AUTO, "TDC-AUTO");
 	print_flag(t, &flags, CAN_CTRLMODE_TDC_MANUAL, "TDC-MANUAL");
 	print_flag(t, &flags, CAN_CTRLMODE_XL, "XL");
 	print_flag(t, &flags, CAN_CTRLMODE_XL_TDC_AUTO, "XL-TDC-AUTO");
 	print_flag(t, &flags, CAN_CTRLMODE_XL_TDC_MANUAL, "XL-TDC-MANUAL");
+	print_flag(t, &flags, CAN_CTRLMODE_XL_RRS, "XL-RRS");
 
 	if (flags)
 		print_hex(t, NULL, "%x", flags);
 
 	close_json_array(t, "> ");
@@ -333,10 +335,14 @@ static int can_parse_opt(struct link_util *lu, int argc, char **argv,
 					   CAN_CTRLMODE_XL_TDC_MANUAL;
 			} else {
 				invarg("\"xtdc-mode\" must be either of \"auto\", \"manual\" or \"off\"",
 					*argv);
 			}
+		} else if (matches(*argv, "xlrrs") == 0) {
+			NEXT_ARG();
+			set_ctrlmode("xlrrs", *argv, &cm,
+				     CAN_CTRLMODE_XL_RRS);
 		} else if (matches(*argv, "restart") == 0) {
 			__u32 val = 1;
 
 			addattr32(n, 1024, IFLA_CAN_RESTART, val);
 		} else if (matches(*argv, "restart-ms") == 0) {
-- 
2.45.2


