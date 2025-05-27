Return-Path: <linux-can+bounces-3708-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 59977AC5B22
	for <lists+linux-can@lfdr.de>; Tue, 27 May 2025 22:00:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 00F201BC0AD8
	for <lists+linux-can@lfdr.de>; Tue, 27 May 2025 20:00:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA6FB205ACF;
	Tue, 27 May 2025 20:00:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="H08V0+5U";
	dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="LjqDnfKE"
X-Original-To: linux-can@vger.kernel.org
Received: from mo4-p02-ob.smtp.rzone.de (mo4-p02-ob.smtp.rzone.de [85.215.255.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AACBA202C48
	for <linux-can@vger.kernel.org>; Tue, 27 May 2025 20:00:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=85.215.255.83
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748376008; cv=pass; b=tA+VW8WMJBcpr1+u08l6Pxxni6JZE0fdxuCkWSDsmsbrpUXQM8p8E862yqflksHOwPmFUpXe3bf8nF1qfRAiYzNWibb5CeOlQPUbSu/UHjmSkjj1oY76zukBqTCr1O9a5BSAo1yRtH8us4ffotx8tVKHm2240OTv9ZHjBaBz4gA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748376008; c=relaxed/simple;
	bh=x29L8HC5Q6rvrfQ985GkO//yeN41rqNvTF4ryIupdQM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ET5zE30FIdrUXsLQCN6YuLNZBX15pWDVn6AUV3Wc1t81kJy0S+ei2Y5DTyKCK69/C0OJkb6eag5yIB9yFV1btWgw4u70xmvu7uT2hal8nLgnMWDRZg+G+fBXfT3jFdGIMnytawwA5yIzOTILGJvMDbYUdRiqS55qS7ImmxvVnC8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net; spf=pass smtp.mailfrom=hartkopp.net; dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=H08V0+5U; dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=LjqDnfKE; arc=pass smtp.client-ip=85.215.255.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hartkopp.net
ARC-Seal: i=1; a=rsa-sha256; t=1748375822; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=OP1Zw+IkC0XAgIAexKEEN59wLoRZnI4jYPLncsuoTNx2teVBwZxC09Y3mhaho6Wt+M
    XxBGeCzvCsMAshWRuM/4J5oRtdWeMCQkEUBIYfFSA3ot4VfS63F0P6doRn5kRV1luoxZ
    bWWZRdkfVA7yRH901fWBLKjVlI7TnjQEh3Q9SVtjs9Nf9s0Bj9lpqEw14v7ITsRukyxn
    tARStgvxDREC4hz0gUESUeh1VWfGxApB8c2y6+t53IOmoKAS/+rS5NlvRv5Pb3OlCnvT
    1SUKeJHDojFFsR1Q4XhilN8del+Y9psWl+8eN387rh2fvFi9VcFAZXbZu5g3PaA7hALF
    LRlw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1748375822;
    s=strato-dkim-0002; d=strato.com;
    h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=Gk7HFaYACMWmuG/8Kry5UmD0dY0dTw+YcNd5C0Igqzg=;
    b=K+IBWQJVCjWsiCy7nhwmdGirR/a4WDdI9BjO5mmCPid31X3PVgEmFZQ76B8KYcgqjT
    PQ/nfBRvknZm4FbzU88VYG8F4fATpGHvhzlYsuyOCztPl8XwwmK1RuJkUF9MB0mw8UQ0
    BfPZPqLyaBAzU/eCozPUbeDZp0lZqgZ4AiOSq4SnJaLfu2KzPdVgJvPflWCF13zWDwAr
    MDOx8YJL+1aj1z3tyJGEff6DQvwaDRstsmSwDt7VKHBqT15sTunjKtDdMkdrf4BMZjxu
    pt1gyLdcD2FpuiftUPgYVpI0j3VVZ/WkNoCevVhjYaLWresqKw/C/DDrFCbyDFJGLte/
    eq8g==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo02
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1748375822;
    s=strato-dkim-0002; d=hartkopp.net;
    h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=Gk7HFaYACMWmuG/8Kry5UmD0dY0dTw+YcNd5C0Igqzg=;
    b=H08V0+5USsvNQ74JJo/Al8I0LAuQHvwOtb3j9RxBR48zKc9WqdmXok3IwT9DIGa958
    g648LiQKCyN6oNUgG0A9RmT+Ez2BY4rgLTE8f4WPb4iOLV0Weqq1HYqnpJEQdsh0ixIT
    PBnfMMnjqXjVIqBIRdhsXBloBKxlMGg4otMPJ12rkcFat/Xx4hYU4imPS1yKsr5ayCVs
    C4AnFZhrrV5lurZetiSGFoCZIuuSDSYAk0IjB7+QvDHI9REdRlJ+tErf1zPXqA0QTUCt
    LXV0Q8bwf1qA8mCPAasEPtiOvvvNHBThmbHVW2WBPnpHrWjHqr0VWTcZEh/6OzziTFm9
    bJHA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1748375822;
    s=strato-dkim-0003; d=hartkopp.net;
    h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=Gk7HFaYACMWmuG/8Kry5UmD0dY0dTw+YcNd5C0Igqzg=;
    b=LjqDnfKEVAgW4wwOIeP9hHsi/l3FFNeoR2hx8dIR5aW3P/46fb5bJwcXxIoNQTYYlX
    Mw3eej7Cq22uWlb198AA==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjH4JKvMdQv2tTUsMrZpkO3Mw3lZ/vMMcFB+5xtv9aJ67XA=="
Received: from lenov17.lan
    by smtp.strato.de (RZmta 51.3.0 AUTH)
    with ESMTPSA id K2a3e514RJv2iWJ
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Tue, 27 May 2025 21:57:02 +0200 (CEST)
From: Oliver Hartkopp <socketcan@hartkopp.net>
To: linux-can@vger.kernel.org
Cc: Oliver Hartkopp <socketcan@hartkopp.net>
Subject: [PATCH 5/5] iplink_can: canxl: add PWM config support
Date: Tue, 27 May 2025 21:56:50 +0200
Message-ID: <20250527195650.65306-5-socketcan@hartkopp.net>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250527195650.65306-1-socketcan@hartkopp.net>
References: <20250527195650.65306-1-socketcan@hartkopp.net>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="us-ascii"

Signed-off-by: Oliver Hartkopp <socketcan@hartkopp.net>
---
 include/uapi/linux/can/netlink.h | 15 +++++++++++
 ip/iplink_can.c                  | 44 ++++++++++++++++++++++++++++++++
 2 files changed, 59 insertions(+)

diff --git a/include/uapi/linux/can/netlink.h b/include/uapi/linux/can/netlink.h
index 903d7f2f..79f348a5 100644
--- a/include/uapi/linux/can/netlink.h
+++ b/include/uapi/linux/can/netlink.h
@@ -146,16 +146,31 @@ enum {
 	IFLA_CAN_CTRLMODE_EXT,
 	IFLA_CAN_XL_DATA_BITTIMING,
 	IFLA_CAN_XL_DATA_BITTIMING_CONST,
 	IFLA_CAN_XL_DATA_BITRATE_CONST,
 	IFLA_CAN_XL_TDC,
+	IFLA_CAN_XL_PWM,
 
 	/* add new constants above here */
 	__IFLA_CAN_MAX,
 	IFLA_CAN_MAX = __IFLA_CAN_MAX - 1
 };
 
+/*
+ * CAN XL Transceiver data mode switching PWM configuration
+ */
+enum {
+	IFLA_CAN_PWM_UNSPEC,
+	IFLA_CAN_PWM_OFFSET,	/* u8 */
+	IFLA_CAN_PWM_LONG,	/* u8 */
+	IFLA_CAN_PWM_SHORT,	/* u8 */
+
+	/* add new constants above here */
+	__IFLA_CAN_PWM,
+	IFLA_CAN_PWM_MAX = __IFLA_CAN_PWM - 1
+};
+
 /*
  * CAN FD/XL Transmitter Delay Compensation (TDC)
  *
  * Please refer to struct can_tdc_const and can_tdc in
  * include/linux/can/bittiming.h for further details.
diff --git a/ip/iplink_can.c b/ip/iplink_can.c
index 766eadbe..88cc908f 100644
--- a/ip/iplink_can.c
+++ b/ip/iplink_can.c
@@ -27,10 +27,11 @@ static void print_usage(FILE *f)
 		"\t[ tdcv TDCV tdco TDCO tdcf TDCF ]\n"
 		"\n"
 		"\t[ xbitrate BITRATE [ xsample-point SAMPLE-POINT] ] |\n"
 		"\t[ xtq TQ xprop-seg PROP_SEG xphase-seg1 PHASE-SEG1\n \t  xphase-seg2 PHASE-SEG2 [ xsjw SJW ] ]\n"
 		"\t[ xtdcv TDCV xtdco TDCO xtdcf TDCF ]\n"
+		"\t[ pwmo PWMO pwml PWML pwms PWMS ]\n"
 		"\n"
 		"\t[ loopback { on | off } ]\n"
 		"\t[ listen-only { on | off } ]\n"
 		"\t[ triple-sampling { on | off } ]\n"
 		"\t[ one-shot { on | off } ]\n"
@@ -142,17 +143,24 @@ struct can_tdc {
 	__u32 tdcv;
 	__u32 tdco;
 	__u32 tdcf;
 };
 
+struct can_pwm {
+	__u8 pwm_offset;
+	__u8 pwm_phase_long;
+	__u8 pwm_phase_short;
+};
+
 static int can_parse_opt(struct link_util *lu, int argc, char **argv,
 			 struct nlmsghdr *n)
 {
 	struct can_bittiming bt = {}, fd_dbt = {}, xl_dbt = {};
 	struct can_ctrlmode cm = { 0 };
 	struct can_tdc fd = { .tdcv = -1, .tdco = -1, .tdcf = -1 };
 	struct can_tdc xl = { .tdcv = -1, .tdco = -1, .tdcf = -1 };
+	struct can_pwm pwm = { 0 };
 
 	while (argc > 0) {
 		if (matches(*argv, "bitrate") == 0) {
 			NEXT_ARG();
 			if (get_u32(&bt.bitrate, *argv, 0))
@@ -339,10 +347,22 @@ static int can_parse_opt(struct link_util *lu, int argc, char **argv,
 					   CAN_CTRLMODE_XL_TDC_MANUAL;
 			} else {
 				invarg("\"xtdc-mode\" must be either of \"auto\", \"manual\" or \"off\"",
 					*argv);
 			}
+		} else if (matches(*argv, "pwmo") == 0) {
+			NEXT_ARG();
+			if (get_u8(&pwm.pwm_offset, *argv, 0))
+				invarg("invalid \"pwmo\" value", *argv);
+		} else if (matches(*argv, "pwml") == 0) {
+			NEXT_ARG();
+			if (get_u8(&pwm.pwm_phase_long, *argv, 0))
+				invarg("invalid \"pwml\" value", *argv);
+		} else if (matches(*argv, "pwms") == 0) {
+			NEXT_ARG();
+			if (get_u8(&pwm.pwm_phase_short, *argv, 0))
+				invarg("invalid \"pwms\" value", *argv);
 		} else if (matches(*argv, "xlrrs") == 0) {
 			NEXT_ARG();
 			set_ctrlmode("xlrrs", *argv, &cm,
 				     CAN_CTRLMODE_XL_RRS);
 		} else if (matches(*argv, "xltrx") == 0) {
@@ -414,10 +434,22 @@ static int can_parse_opt(struct link_util *lu, int argc, char **argv,
 			addattr32(n, 1024, IFLA_CAN_TDC_TDCO, xl.tdco);
 		if (xl.tdcf != -1)
 			addattr32(n, 1024, IFLA_CAN_TDC_TDCF, xl.tdcf);
 		addattr_nest_end(n, tdc);
 	}
+	if (pwm.pwm_offset || pwm.pwm_phase_long || pwm.pwm_phase_short) {
+		struct rtattr *xlpwm = addattr_nest(n, 1024,
+						  IFLA_CAN_XL_PWM | NLA_F_NESTED);
+
+		if (pwm.pwm_offset)
+			addattr8(n, 1024, IFLA_CAN_PWM_OFFSET, pwm.pwm_offset);
+		if (pwm.pwm_phase_long)
+			addattr8(n, 1024, IFLA_CAN_PWM_LONG, pwm.pwm_phase_long);
+		if (pwm.pwm_phase_short)
+			addattr8(n, 1024, IFLA_CAN_PWM_SHORT, pwm.pwm_phase_short);
+		addattr_nest_end(n, xlpwm);
+	}
 
 	return 0;
 }
 
 static const char *can_state_names[CAN_STATE_MAX] = {
@@ -807,10 +839,22 @@ static void can_print_opt(struct link_util *lu, FILE *f, struct rtattr *tb[])
 				   dbitrate_const[i]);
 		}
 		close_json_array(PRINT_ANY, " ]");
 	}
 
+	if (tb[IFLA_CAN_XL_PWM]) {
+		struct can_pwm *pwm =
+			RTA_DATA(tb[IFLA_CAN_XL_PWM]);
+
+		open_json_object("xl_pwm");
+		can_print_nl_indent();
+		print_uint(PRINT_ANY, "pwmo", " pwmo %u", pwm->pwm_offset);
+		print_uint(PRINT_ANY, "pwml", " pwml %u", pwm->pwm_phase_long);
+		print_uint(PRINT_ANY, "pwms", " pwms %u", pwm->pwm_phase_short);
+		close_json_object();
+	}
+
 	if (tb[IFLA_CAN_TERMINATION_CONST] && tb[IFLA_CAN_TERMINATION]) {
 		__u16 *trm = RTA_DATA(tb[IFLA_CAN_TERMINATION]);
 		__u16 *trm_const = RTA_DATA(tb[IFLA_CAN_TERMINATION_CONST]);
 		int trm_cnt = RTA_PAYLOAD(tb[IFLA_CAN_TERMINATION_CONST]) /
 			sizeof(*trm_const);
-- 
2.47.2


