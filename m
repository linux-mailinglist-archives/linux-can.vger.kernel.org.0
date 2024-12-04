Return-Path: <linux-can+bounces-2328-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D01E9E3539
	for <lists+linux-can@lfdr.de>; Wed,  4 Dec 2024 09:26:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5DF1AB29AEE
	for <lists+linux-can@lfdr.de>; Wed,  4 Dec 2024 08:03:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 065A818C900;
	Wed,  4 Dec 2024 07:57:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="KQx9vPbp";
	dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="6AtHgH8M"
X-Original-To: linux-can@vger.kernel.org
Received: from mo4-p01-ob.smtp.rzone.de (mo4-p01-ob.smtp.rzone.de [85.215.255.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43B3418FC92
	for <linux-can@vger.kernel.org>; Wed,  4 Dec 2024 07:57:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=85.215.255.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733299073; cv=pass; b=R0K/Hv1ctB0yVRXU5MHn3yawk0Gr5ObrZLU/NXswFDA+D8g0ee4khwQ0zW90t0gifPZ8IUGMsVTgSk7uhWt0IwCI5PqHeJGO9b5RHSh2mHqErIRpELR5540VKrp9XX1gOltcgEQ7OjLXor/Nv09dP7KXEl7BV9fv2b5xnrSMpRs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733299073; c=relaxed/simple;
	bh=Toh7Aks2wrnmT8YooGRv27q5917BWA4WUcv6oGOaamg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=OIH3a7F0yi+5FJtF3pCc8zTrUc1sltFaiFt5ugmZG/A7sRv2tjUWAgtT0k1KeIPL2Op7arhcKOlwvDTabL4UXPmqmsoW0Clz6xYZg/kIzIFx5hLGfIsLsnuHa2XgVW7ou3PMatyGBjgdllQgDviawY6vrNRv4WXJfdopx/Z5BBk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net; spf=pass smtp.mailfrom=hartkopp.net; dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=KQx9vPbp; dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=6AtHgH8M; arc=pass smtp.client-ip=85.215.255.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hartkopp.net
ARC-Seal: i=1; a=rsa-sha256; t=1733299069; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=fKjId4pjdoyrOhmPOSzHkkWopCeEfte6QD3j4wlNReIQzko0pguOm3Xbi3u4VtVhsO
    UgOhU+I1fc0homlwrjpPOR5VrrWebhguYBSm7HEVPzU9AGGxf72eSF5svQhpNDbADATt
    62VVMc3nap/OMtwy3ZN8SERKtLUIzB9qpq38PEX5KGMgcGrLMHtJAxqcN2Rc/qfTeBWV
    ELfDfSvVH8KNLW4EJnbi4BXZNx4V0fKXMdj6hVZde2T4SNt5JyOtH7jEcPMsw3CX1zCs
    LxSYmOcNGI4tnOIhma1VUmR1WBZ4bbXKBWmpcE8fPSdJlfKY+CP99h6yd5tBlmn9jStT
    NUiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1733299069;
    s=strato-dkim-0002; d=strato.com;
    h=Message-ID:Date:Subject:Cc:To:From:Cc:Date:From:Subject:Sender;
    bh=k4qKqcsye2SyP2oBfXAA3wN5cDjB5oceP2ChP2dlPlw=;
    b=kYS0/CgBvAZvAciFr84xzLWGzzlEhauCJtRdtTHSjSY1BOXQFTxBI5ZqQnaCCM6I7Z
    eitolH4pBymkVdGUfiT1GYxCetGKeV9+9Q9cKO2TSEJmhifByu+STF/vlORsi+ip0Fx5
    G+mwJt+2VDt29j/5Fy6NKIpXOuoOTLuZCBKGu34FjCuuiLqfv+KVEUMbGdo1QVYi7cFG
    K/wT8p0HB2TsBxJtq8sQXGXRR7BFVD2VGUtpsgQ10Wubch22d+yNNcewTfiFIvn3emYV
    rD8tM+qCh7EYaKjAzIB4ToTC0+SinaFFI7Emalb9Iu0hswGuKYQDJGUc0IYuRNHcZL6f
    OyrQ==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1733299069;
    s=strato-dkim-0002; d=hartkopp.net;
    h=Message-ID:Date:Subject:Cc:To:From:Cc:Date:From:Subject:Sender;
    bh=k4qKqcsye2SyP2oBfXAA3wN5cDjB5oceP2ChP2dlPlw=;
    b=KQx9vPbp9m1DEQWBNkH5x7mqYFTd3bSXtcDVydWbLpbaAAE0owuzT/jTiU16+gZ747
    GMF7S40GiDBP3EvU3oFAnDS7L4V/9ooyGYOvJx+O75jjqCOlkDlySqk/SLY03Bncgc4r
    tLpN8xkIxrMgeLalIa5UFaB6XlQqG7aQdQz8SOZfbn+aI8EZClRDXpOBsm4s6fIWnz+O
    lYwc5EH8L0qFi5mRstK2ljSMCsrQfGtZR8CDsgoV9eqeuX/bxnw+ySiTa9SgoX37css5
    68fswcAcTTLMJu9/ZzbyPc+QPRWYHjHZzl4D/9Ps8gB34lRdb1Cb+h4EUuzr5RNWeCsa
    SQ1Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1733299069;
    s=strato-dkim-0003; d=hartkopp.net;
    h=Message-ID:Date:Subject:Cc:To:From:Cc:Date:From:Subject:Sender;
    bh=k4qKqcsye2SyP2oBfXAA3wN5cDjB5oceP2ChP2dlPlw=;
    b=6AtHgH8MJMrHNxJ4i8th3/nWK9ClHWfkOs8NRonh4celASD0IceiRPCBPHOor5MtK0
    19EroOf5ZcHN0134JeDg==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjH4JKvMdQv2tRkI16oOSXVT6pap5"
Received: from lenov17.lan
    by smtp.strato.de (RZmta 51.2.11 DYNA|AUTH)
    with ESMTPSA id K63ada0B47vmsrE
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Wed, 4 Dec 2024 08:57:48 +0100 (CET)
From: Oliver Hartkopp <socketcan@hartkopp.net>
To: linux-can@vger.kernel.org
Cc: Oliver Hartkopp <socketcan@hartkopp.net>
Subject: [RFC PATCH v2 1/3] iplink_can: add CAN XL support RFC based on Vincent cleanups
Date: Wed,  4 Dec 2024 08:57:39 +0100
Message-ID: <20241204075741.3727-1-socketcan@hartkopp.net>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="us-ascii"

Fixes from Oliver:
- remove newline before tdc information to increase readability
- fix copy/paste issue in CAN_CTRLMODE_XL_TDC_ definitions

Based on the iproute2 CAN XL preparations patch set at
https://lore.kernel.org/linux-can/173194923075.4109060.18408610499610779344.git-patchwork-notify@kernel.org/T/#t
which was already merged into iproute2-next tree:
https://git.kernel.org/pub/scm/network/iproute2/iproute2-next.git/commit/?id=7b4d64895f7c58a12c01d2f394f75b0d1938eb9c

Signed-off-by: Oliver Hartkopp <socketcan@hartkopp.net>
---
 include/uapi/linux/can/netlink.h |  21 ++-
 ip/iplink_can.c                  | 223 ++++++++++++++++++++++++++++---
 2 files changed, 216 insertions(+), 28 deletions(-)

diff --git a/include/uapi/linux/can/netlink.h b/include/uapi/linux/can/netlink.h
index 8ec98c21..416e2feb 100644
--- a/include/uapi/linux/can/netlink.h
+++ b/include/uapi/linux/can/netlink.h
@@ -99,12 +99,15 @@ struct can_ctrlmode {
 #define CAN_CTRLMODE_BERR_REPORTING	0x10	/* Bus-error reporting */
 #define CAN_CTRLMODE_FD			0x20	/* CAN FD mode */
 #define CAN_CTRLMODE_PRESUME_ACK	0x40	/* Ignore missing CAN ACKs */
 #define CAN_CTRLMODE_FD_NON_ISO		0x80	/* CAN FD in non-ISO mode */
 #define CAN_CTRLMODE_CC_LEN8_DLC	0x100	/* Classic CAN DLC option */
-#define CAN_CTRLMODE_TDC_AUTO		0x200	/* CAN transiver automatically calculates TDCV */
-#define CAN_CTRLMODE_TDC_MANUAL		0x400	/* TDCV is manually set up by user */
+#define CAN_CTRLMODE_TDC_AUTO		0x200	/* FD transceiver automatically calculates TDCV */
+#define CAN_CTRLMODE_TDC_MANUAL		0x400	/* FD TDCV is manually set up by user */
+#define CAN_CTRLMODE_XL			0x800	/* CAN XL mode */
+#define CAN_CTRLMODE_XL_TDC_AUTO	0x1000	/* XL transceiver automatically calculates TDCV */
+#define CAN_CTRLMODE_XL_TDC_MANUAL	0x2000	/* XL TDCV is manually set up by user */
 
 /*
  * CAN device statistics
  */
 struct can_device_stats {
@@ -127,27 +130,31 @@ enum {
 	IFLA_CAN_STATE,
 	IFLA_CAN_CTRLMODE,
 	IFLA_CAN_RESTART_MS,
 	IFLA_CAN_RESTART,
 	IFLA_CAN_BERR_COUNTER,
-	IFLA_CAN_DATA_BITTIMING,
-	IFLA_CAN_DATA_BITTIMING_CONST,
+	IFLA_CAN_DATA_BITTIMING, /* FD */
+	IFLA_CAN_DATA_BITTIMING_CONST, /* FD */
 	IFLA_CAN_TERMINATION,
 	IFLA_CAN_TERMINATION_CONST,
 	IFLA_CAN_BITRATE_CONST,
-	IFLA_CAN_DATA_BITRATE_CONST,
+	IFLA_CAN_DATA_BITRATE_CONST, /* FD */
 	IFLA_CAN_BITRATE_MAX,
-	IFLA_CAN_TDC,
+	IFLA_CAN_TDC, /* FD */
 	IFLA_CAN_CTRLMODE_EXT,
+	IFLA_CAN_XL_DATA_BITTIMING,
+	IFLA_CAN_XL_DATA_BITTIMING_CONST,
+	IFLA_CAN_XL_DATA_BITRATE_CONST,
+	IFLA_CAN_XL_TDC,
 
 	/* add new constants above here */
 	__IFLA_CAN_MAX,
 	IFLA_CAN_MAX = __IFLA_CAN_MAX - 1
 };
 
 /*
- * CAN FD Transmitter Delay Compensation (TDC)
+ * CAN FD/XL Transmitter Delay Compensation (TDC)
  *
  * Please refer to struct can_tdc_const and can_tdc in
  * include/linux/can/bittiming.h for further details.
  */
 enum {
diff --git a/ip/iplink_can.c b/ip/iplink_can.c
index fcffa852..8dc9229b 100644
--- a/ip/iplink_can.c
+++ b/ip/iplink_can.c
@@ -13,16 +13,10 @@
 
 #include "rt_names.h"
 #include "utils.h"
 #include "ip_common.h"
 
-struct can_tdc {
-	__u32 tdcv;
-	__u32 tdco;
-	__u32 tdcf;
-};
-
 static void print_usage(FILE *f)
 {
 	fprintf(f,
 		"Usage: ip link set DEVICE type can\n"
 		"\t[ bitrate BITRATE [ sample-point SAMPLE-POINT] ] |\n"
@@ -30,20 +24,26 @@ static void print_usage(FILE *f)
 		"\n"
 		"\t[ dbitrate BITRATE [ dsample-point SAMPLE-POINT] ] |\n"
 		"\t[ dtq TQ dprop-seg PROP_SEG dphase-seg1 PHASE-SEG1\n \t  dphase-seg2 PHASE-SEG2 [ dsjw SJW ] ]\n"
 		"\t[ tdcv TDCV tdco TDCO tdcf TDCF ]\n"
 		"\n"
+		"\t[ xbitrate BITRATE [ xsample-point SAMPLE-POINT] ] |\n"
+		"\t[ xtq TQ xprop-seg PROP_SEG xphase-seg1 PHASE-SEG1\n \t  xphase-seg2 PHASE-SEG2 [ xsjw SJW ] ]\n"
+		"\t[ xtdcv TDCV xtdco TDCO xtdcf TDCF ]\n"
+		"\n"
 		"\t[ loopback { on | off } ]\n"
 		"\t[ listen-only { on | off } ]\n"
 		"\t[ triple-sampling { on | off } ]\n"
 		"\t[ one-shot { on | off } ]\n"
 		"\t[ berr-reporting { on | off } ]\n"
 		"\t[ fd { on | off } ]\n"
 		"\t[ fd-non-iso { on | off } ]\n"
 		"\t[ presume-ack { on | off } ]\n"
 		"\t[ cc-len8-dlc { on | off } ]\n"
 		"\t[ tdc-mode { auto | manual | off } ]\n"
+		"\t[ xl { on | off } ]\n"
+		"\t[ xtdc-mode { auto | manual | off } ]\n"
 		"\n"
 		"\t[ restart-ms TIME-MS ]\n"
 		"\t[ restart ]\n"
 		"\n"
 		"\t[ termination { 0..65535 } ]\n"
@@ -120,23 +120,33 @@ static void print_ctrlmode(enum output_type t, __u32 flags, const char* key)
 	print_flag(t, &flags, CAN_CTRLMODE_FD_NON_ISO, "FD-NON-ISO");
 	print_flag(t, &flags, CAN_CTRLMODE_PRESUME_ACK, "PRESUME-ACK");
 	print_flag(t, &flags, CAN_CTRLMODE_CC_LEN8_DLC, "CC-LEN8-DLC");
 	print_flag(t, &flags, CAN_CTRLMODE_TDC_AUTO, "TDC-AUTO");
 	print_flag(t, &flags, CAN_CTRLMODE_TDC_MANUAL, "TDC-MANUAL");
+	print_flag(t, &flags, CAN_CTRLMODE_XL, "XL");
+	print_flag(t, &flags, CAN_CTRLMODE_XL_TDC_AUTO, "XL-TDC-AUTO");
+	print_flag(t, &flags, CAN_CTRLMODE_XL_TDC_MANUAL, "XL-TDC-MANUAL");
 
 	if (flags)
 		print_hex(t, NULL, "%x", flags);
 
 	close_json_array(t, "> ");
 }
 
+struct can_tdc {
+	__u32 tdcv;
+	__u32 tdco;
+	__u32 tdcf;
+};
+
 static int can_parse_opt(struct link_util *lu, int argc, char **argv,
 			 struct nlmsghdr *n)
 {
-	struct can_bittiming bt = {}, fd_dbt = {};
+	struct can_bittiming bt = {}, fd_dbt = {}, xl_dbt = {};
 	struct can_ctrlmode cm = { 0 };
 	struct can_tdc fd = { .tdcv = -1, .tdco = -1, .tdcf = -1 };
+	struct can_tdc xl = { .tdcv = -1, .tdco = -1, .tdcf = -1 };
 
 	while (argc > 0) {
 		if (matches(*argv, "bitrate") == 0) {
 			NEXT_ARG();
 			if (get_u32(&bt.bitrate, *argv, 0))
@@ -210,10 +220,57 @@ static int can_parse_opt(struct link_util *lu, int argc, char **argv,
 				invarg("invalid \"tdco\" value", *argv);
 		} else if (matches(*argv, "tdcf") == 0) {
 			NEXT_ARG();
 			if (get_u32(&fd.tdcf, *argv, 0))
 				invarg("invalid \"tdcf\" value", *argv);
+		} else if (matches(*argv, "xl") == 0) {
+			NEXT_ARG();
+			set_ctrlmode("xl", *argv, &cm,
+				     CAN_CTRLMODE_XL);
+		} else if (matches(*argv, "xbitrate") == 0) {
+			NEXT_ARG();
+			if (get_u32(&xl_dbt.bitrate, *argv, 0))
+				invarg("invalid \"xbitrate\" value", *argv);
+		} else if (matches(*argv, "xsample-point") == 0) {
+			float sp;
+
+			NEXT_ARG();
+			if (get_float(&sp, *argv))
+				invarg("invalid \"xsample-point\" value", *argv);
+			xl_dbt.sample_point = (__u32)(sp * 1000);
+		} else if (matches(*argv, "xtq") == 0) {
+			NEXT_ARG();
+			if (get_u32(&xl_dbt.tq, *argv, 0))
+				invarg("invalid \"xtq\" value", *argv);
+		} else if (matches(*argv, "xprop-seg") == 0) {
+			NEXT_ARG();
+			if (get_u32(&xl_dbt.prop_seg, *argv, 0))
+				invarg("invalid \"xprop-seg\" value", *argv);
+		} else if (matches(*argv, "xphase-seg1") == 0) {
+			NEXT_ARG();
+			if (get_u32(&xl_dbt.phase_seg1, *argv, 0))
+				invarg("invalid \"xphase-seg1\" value", *argv);
+		} else if (matches(*argv, "xphase-seg2") == 0) {
+			NEXT_ARG();
+			if (get_u32(&xl_dbt.phase_seg2, *argv, 0))
+				invarg("invalid \"xphase-seg2\" value", *argv);
+		} else if (matches(*argv, "xsjw") == 0) {
+			NEXT_ARG();
+			if (get_u32(&xl_dbt.sjw, *argv, 0))
+				invarg("invalid \"xsjw\" value", *argv);
+		} else if (matches(*argv, "xtdcv") == 0) {
+			NEXT_ARG();
+			if (get_u32(&xl.tdcv, *argv, 0))
+				invarg("invalid \"xtdcv\" value", *argv);
+		} else if (matches(*argv, "xtdco") == 0) {
+			NEXT_ARG();
+			if (get_u32(&xl.tdco, *argv, 0))
+				invarg("invalid \"xtdco\" value", *argv);
+		} else if (matches(*argv, "xtdcf") == 0) {
+			NEXT_ARG();
+			if (get_u32(&xl.tdcf, *argv, 0))
+				invarg("invalid \"xtdcf\" value", *argv);
 		} else if (matches(*argv, "loopback") == 0) {
 			NEXT_ARG();
 			set_ctrlmode("loopback", *argv, &cm,
 				     CAN_CTRLMODE_LOOPBACK);
 		} else if (matches(*argv, "listen-only") == 0) {
@@ -261,10 +318,25 @@ static int can_parse_opt(struct link_util *lu, int argc, char **argv,
 					   CAN_CTRLMODE_TDC_MANUAL;
 			} else {
 				invarg("\"tdc-mode\" must be either of \"auto\", \"manual\" or \"off\"",
 					*argv);
 			}
+		} else if (matches(*argv, "xtdc-mode") == 0) {
+			NEXT_ARG();
+			if (strcmp(*argv, "auto") == 0) {
+				cm.flags |= CAN_CTRLMODE_XL_TDC_AUTO;
+				cm.mask |= CAN_CTRLMODE_XL_TDC_AUTO;
+			} else if (strcmp(*argv, "manual") == 0) {
+				cm.flags |= CAN_CTRLMODE_XL_TDC_MANUAL;
+				cm.mask |= CAN_CTRLMODE_XL_TDC_MANUAL;
+			} else if (strcmp(*argv, "off") == 0) {
+				cm.mask |= CAN_CTRLMODE_XL_TDC_AUTO |
+					   CAN_CTRLMODE_XL_TDC_MANUAL;
+			} else {
+				invarg("\"xtdc-mode\" must be either of \"auto\", \"manual\" or \"off\"",
+					*argv);
+			}
 		} else if (matches(*argv, "restart") == 0) {
 			__u32 val = 1;
 
 			addattr32(n, 1024, IFLA_CAN_RESTART, val);
 		} else if (matches(*argv, "restart-ms") == 0) {
@@ -295,10 +367,12 @@ static int can_parse_opt(struct link_util *lu, int argc, char **argv,
 
 	if (bt.bitrate || bt.tq)
 		addattr_l(n, 1024, IFLA_CAN_BITTIMING, &bt, sizeof(bt));
 	if (fd_dbt.bitrate || fd_dbt.tq)
 		addattr_l(n, 1024, IFLA_CAN_DATA_BITTIMING, &fd_dbt, sizeof(fd_dbt));
+	if (xl_dbt.bitrate || xl_dbt.tq)
+		addattr_l(n, 1024, IFLA_CAN_XL_DATA_BITTIMING, &xl_dbt, sizeof(xl_dbt));
 	if (cm.mask)
 		addattr_l(n, 1024, IFLA_CAN_CTRLMODE, &cm, sizeof(cm));
 
 	if (fd.tdcv != -1 || fd.tdco != -1 || fd.tdcf != -1) {
 		struct rtattr *tdc = addattr_nest(n, 1024,
@@ -310,10 +384,22 @@ static int can_parse_opt(struct link_util *lu, int argc, char **argv,
 			addattr32(n, 1024, IFLA_CAN_TDC_TDCO, fd.tdco);
 		if (fd.tdcf != -1)
 			addattr32(n, 1024, IFLA_CAN_TDC_TDCF, fd.tdcf);
 		addattr_nest_end(n, tdc);
 	}
+	if (xl.tdcv != -1 || xl.tdco != -1 || xl.tdcf != -1) {
+		struct rtattr *tdc = addattr_nest(n, 1024,
+						  IFLA_CAN_XL_TDC | NLA_F_NESTED);
+
+		if (xl.tdcv != -1)
+			addattr32(n, 1024, IFLA_CAN_TDC_TDCV, xl.tdcv);
+		if (xl.tdco != -1)
+			addattr32(n, 1024, IFLA_CAN_TDC_TDCO, xl.tdco);
+		if (xl.tdcf != -1)
+			addattr32(n, 1024, IFLA_CAN_TDC_TDCF, xl.tdcf);
+		addattr_nest_end(n, tdc);
+	}
 
 	return 0;
 }
 
 static const char *can_state_names[CAN_STATE_MAX] = {
@@ -340,62 +426,69 @@ can_print_timing_min_max(const char *json_attr, const char *fp_attr,
 	print_uint(PRINT_ANY, "min", " %d", min);
 	print_uint(PRINT_ANY, "max", "..%d", max);
 	close_json_object();
 }
 
-static void can_print_tdc_opt(struct rtattr *tdc_attr)
+static void can_print_tdc_opt(struct rtattr *tdc_attr, bool is_xl)
 {
 	struct rtattr *tb[IFLA_CAN_TDC_MAX + 1];
 
 	parse_rtattr_nested(tb, IFLA_CAN_TDC_MAX, tdc_attr);
 	if (tb[IFLA_CAN_TDC_TDCV] || tb[IFLA_CAN_TDC_TDCO] ||
 	    tb[IFLA_CAN_TDC_TDCF]) {
-		open_json_object("tdc");
-		can_print_nl_indent();
+		const char *tdc = is_xl ? "xtdc" : "tdc";
+
+		open_json_object(tdc);
 		if (tb[IFLA_CAN_TDC_TDCV]) {
+			const char *tdcv_fmt = is_xl ? " xtdcv %u" : " tdcv %u";
 			__u32 *tdcv = RTA_DATA(tb[IFLA_CAN_TDC_TDCV]);
 
-			print_uint(PRINT_ANY, "tdcv", " tdcv %u", *tdcv);
+			print_uint(PRINT_ANY, "tdcv", tdcv_fmt, *tdcv);
 		}
 		if (tb[IFLA_CAN_TDC_TDCO]) {
+			const char *tdco_fmt = is_xl ? " xtdco %u" : " tdco %u";
 			__u32 *tdco = RTA_DATA(tb[IFLA_CAN_TDC_TDCO]);
 
-			print_uint(PRINT_ANY, "tdco", " tdco %u", *tdco);
+			print_uint(PRINT_ANY, "tdco", tdco_fmt, *tdco);
 		}
 		if (tb[IFLA_CAN_TDC_TDCF]) {
+			const char *tdcf_fmt = is_xl ? " xtdcf %u" : " tdcf %u";
 			__u32 *tdcf = RTA_DATA(tb[IFLA_CAN_TDC_TDCF]);
 
-			print_uint(PRINT_ANY, "tdcf", " tdcf %u", *tdcf);
+			print_uint(PRINT_ANY, "tdcf", tdcf_fmt, *tdcf);
 		}
 		close_json_object();
 	}
 }
 
-static void can_print_tdc_const_opt(struct rtattr *tdc_attr)
+static void can_print_tdc_const_opt(struct rtattr *tdc_attr, bool is_xl)
 {
+	const char *tdc = is_xl ? "xtdc" : "tdc";
 	struct rtattr *tb[IFLA_CAN_TDC_MAX + 1];
 
 	parse_rtattr_nested(tb, IFLA_CAN_TDC_MAX, tdc_attr);
-	open_json_object("tdc");
-	can_print_nl_indent();
+	open_json_object(tdc);
 	if (tb[IFLA_CAN_TDC_TDCV_MIN] && tb[IFLA_CAN_TDC_TDCV_MAX]) {
 		__u32 *tdcv_min = RTA_DATA(tb[IFLA_CAN_TDC_TDCV_MIN]);
 		__u32 *tdcv_max = RTA_DATA(tb[IFLA_CAN_TDC_TDCV_MAX]);
+		const char *tdcv = is_xl ? " xtdcv" : " tdcv";
 
-		can_print_timing_min_max("tdcv", " tdcv", *tdcv_min, *tdcv_max);
+		can_print_timing_min_max("tdcv", tdcv, *tdcv_min, *tdcv_max);
 	}
 	if (tb[IFLA_CAN_TDC_TDCO_MIN] && tb[IFLA_CAN_TDC_TDCO_MAX]) {
 		__u32 *tdco_min = RTA_DATA(tb[IFLA_CAN_TDC_TDCO_MIN]);
 		__u32 *tdco_max = RTA_DATA(tb[IFLA_CAN_TDC_TDCO_MAX]);
+		const char *tdco = is_xl ? " xtdco" : " tdco";
 
-		can_print_timing_min_max("tdco", " tdco", *tdco_min, *tdco_max);
+		can_print_timing_min_max("tdco", tdco, *tdco_min, *tdco_max);
 	}
 	if (tb[IFLA_CAN_TDC_TDCF_MIN] && tb[IFLA_CAN_TDC_TDCF_MAX]) {
 		__u32 *tdcf_min = RTA_DATA(tb[IFLA_CAN_TDC_TDCF_MIN]);
 		__u32 *tdcf_max = RTA_DATA(tb[IFLA_CAN_TDC_TDCF_MAX]);
+		const char *tdcf = is_xl ? " xtdcf" : " tdcf";
 
-		can_print_timing_min_max("tdcf", " tdcf", *tdcf_min, *tdcf_max);
+		can_print_timing_min_max("tdcf", tdcf, *tdcf_min, *tdcf_max);
 	}
 	close_json_object();
 }
 
 static void can_print_ctrlmode_ext(struct rtattr *ctrlmode_ext_attr,
@@ -545,11 +638,11 @@ static void can_print_opt(struct link_util *lu, FILE *f, struct rtattr *tb[])
 			   dbt->phase_seg2);
 		print_uint(PRINT_ANY, "sjw", " dsjw %u", dbt->sjw);
 		print_uint(PRINT_ANY, "brp", " dbrp %u", dbt->brp);
 
 		if (tb[IFLA_CAN_TDC])
-			can_print_tdc_opt(tb[IFLA_CAN_TDC]);
+			can_print_tdc_opt(tb[IFLA_CAN_TDC], false);
 
 		close_json_object();
 	}
 
 	/* data bittiming const is irrelevant if fixed bitrate is defined */
@@ -569,11 +662,11 @@ static void can_print_opt(struct link_util *lu, FILE *f, struct rtattr *tb[])
 		can_print_timing_min_max("brp", " dbrp",
 					 dbtc->brp_min, dbtc->brp_max);
 		print_uint(PRINT_ANY, "brp_inc", " dbrp_inc %u", dbtc->brp_inc);
 
 		if (tb[IFLA_CAN_TDC])
-			can_print_tdc_const_opt(tb[IFLA_CAN_TDC]);
+			can_print_tdc_const_opt(tb[IFLA_CAN_TDC], false);
 
 		close_json_object();
 	}
 
 	if (tb[IFLA_CAN_DATA_BITRATE_CONST]) {
@@ -608,10 +701,98 @@ static void can_print_opt(struct link_util *lu, FILE *f, struct rtattr *tb[])
 				   dbitrate_const[i]);
 		}
 		close_json_array(PRINT_ANY, " ]");
 	}
 
+	/* data bittiming is irrelevant if fixed bitrate is defined */
+	if (tb[IFLA_CAN_XL_DATA_BITTIMING] &&
+	    !tb[IFLA_CAN_XL_DATA_BITRATE_CONST]) {
+		struct can_bittiming *dbt =
+			RTA_DATA(tb[IFLA_CAN_XL_DATA_BITTIMING]);
+		char dsp[6];
+
+		open_json_object("xl_data_bittiming");
+		can_print_nl_indent();
+		print_uint(PRINT_ANY, "bitrate", " xbitrate %u", dbt->bitrate);
+		snprintf(dsp, sizeof(dsp), "%.3f", dbt->sample_point / 1000.);
+		print_string(PRINT_ANY, "sample_point", " xsample-point %s",
+			     dsp);
+		can_print_nl_indent();
+		print_uint(PRINT_ANY, "tq", " xtq %u", dbt->tq);
+		print_uint(PRINT_ANY, "prop_seg", " xprop-seg %u",
+			   dbt->prop_seg);
+		print_uint(PRINT_ANY, "phase_seg1", " xphase-seg1 %u",
+			   dbt->phase_seg1);
+		print_uint(PRINT_ANY, "phase_seg2", " xphase-seg2 %u",
+			   dbt->phase_seg2);
+		print_uint(PRINT_ANY, "sjw", " xsjw %u", dbt->sjw);
+		print_uint(PRINT_ANY, "brp", " xbrp %u", dbt->brp);
+
+		if (tb[IFLA_CAN_XL_TDC])
+			can_print_tdc_opt(tb[IFLA_CAN_XL_TDC], true);
+
+		close_json_object();
+	}
+
+	/* data bittiming const is irrelevant if fixed bitrate is defined */
+	if (tb[IFLA_CAN_XL_DATA_BITTIMING_CONST] &&
+	    !tb[IFLA_CAN_XL_DATA_BITRATE_CONST]) {
+		struct can_bittiming_const *dbtc =
+			RTA_DATA(tb[IFLA_CAN_XL_DATA_BITTIMING_CONST]);
+
+		open_json_object("xl_data_bittiming_const");
+		can_print_nl_indent();
+		print_string(PRINT_ANY, "name", " %s:", dbtc->name);
+		can_print_timing_min_max("tseg1", " xtseg1",
+					 dbtc->tseg1_min, dbtc->tseg1_max);
+		can_print_timing_min_max("tseg2", " xtseg2",
+					 dbtc->tseg2_min, dbtc->tseg2_max);
+		can_print_timing_min_max("sjw", " xsjw", 1, dbtc->sjw_max);
+		can_print_timing_min_max("brp", " xbrp",
+					 dbtc->brp_min, dbtc->brp_max);
+		print_uint(PRINT_ANY, "brp_inc", " xbrp_inc %u", dbtc->brp_inc);
+
+		if (tb[IFLA_CAN_XL_TDC])
+			can_print_tdc_const_opt(tb[IFLA_CAN_XL_TDC], true);
+
+		close_json_object();
+	}
+
+	if (tb[IFLA_CAN_XL_DATA_BITRATE_CONST]) {
+		__u32 *dbitrate_const =
+			RTA_DATA(tb[IFLA_CAN_XL_DATA_BITRATE_CONST]);
+		int dbitrate_cnt =
+			RTA_PAYLOAD(tb[IFLA_CAN_XL_DATA_BITRATE_CONST]) /
+			sizeof(*dbitrate_const);
+		int i;
+		__u32 dbitrate = 0;
+
+		if (tb[IFLA_CAN_XL_DATA_BITTIMING]) {
+			struct can_bittiming *dbt =
+				RTA_DATA(tb[IFLA_CAN_XL_DATA_BITTIMING]);
+			dbitrate = dbt->bitrate;
+		}
+
+		can_print_nl_indent();
+		print_uint(PRINT_ANY, "xl_data_bittiming_bitrate", " xbitrate %u",
+			   dbitrate);
+		can_print_nl_indent();
+		open_json_array(PRINT_ANY, is_json_context() ?
+				"data_bitrate_const" : "    [");
+		for (i = 0; i < dbitrate_cnt; ++i) {
+			/* This will keep lines below 80 signs */
+			if (!(i % 6) && i) {
+				can_print_nl_indent();
+				print_string(PRINT_FP, NULL, "%s", "     ");
+			}
+			print_uint(PRINT_ANY, NULL,
+				   i < dbitrate_cnt - 1 ? "%8u, " : "%8u",
+				   dbitrate_const[i]);
+		}
+		close_json_array(PRINT_ANY, " ]");
+	}
+
 	if (tb[IFLA_CAN_TERMINATION_CONST] && tb[IFLA_CAN_TERMINATION]) {
 		__u16 *trm = RTA_DATA(tb[IFLA_CAN_TERMINATION]);
 		__u16 *trm_const = RTA_DATA(tb[IFLA_CAN_TERMINATION_CONST]);
 		int trm_cnt = RTA_PAYLOAD(tb[IFLA_CAN_TERMINATION_CONST]) /
 			sizeof(*trm_const);
-- 
2.45.2


