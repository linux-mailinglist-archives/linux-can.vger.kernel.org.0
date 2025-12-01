Return-Path: <linux-can+bounces-5804-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 46CB5C9979E
	for <lists+linux-can@lfdr.de>; Mon, 01 Dec 2025 23:59:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3A5C83A6460
	for <lists+linux-can@lfdr.de>; Mon,  1 Dec 2025 22:58:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B364D29A30E;
	Mon,  1 Dec 2025 22:56:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Er1vY3Mz"
X-Original-To: linux-can@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 833492C11CB;
	Mon,  1 Dec 2025 22:56:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764629808; cv=none; b=J2daRZJnNuL7Dq4yWU6ILphmHxVEBH6VvEWiRLC5ppQTKwAPhFTg5BWTqyefIjxHDcgMIqp2hWc44qYKjhJ+n5GXnk40rC+oaM5KaBky0kBW6xRRAEwJyUhuGKf5ntW5k6OYmwNuphPeLmTgHv89ofXy4eSIGIaW6RpMHIq6vSQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764629808; c=relaxed/simple;
	bh=CAqoEU5ZBw9f4vxKsNKUAmN5pLXt7BE/7ve/chDvvqE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=JYIBWzr1wBU5Tz8rc22STKm0ZZ3bqlX2fxtl0n+D2ievKZk3VD3I/Zm09PyeKPKbQwbVQROzqDXTjnkcDS+XKpzBLIU5V00QTzZ1LumY7BTquWJsB1osL1IoPZwHtCyl6lQ3hUbEdSg3z56geaAHvPq8VgsPdYLGd5qYsZ0a91c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Er1vY3Mz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AEDCAC116C6;
	Mon,  1 Dec 2025 22:56:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764629808;
	bh=CAqoEU5ZBw9f4vxKsNKUAmN5pLXt7BE/7ve/chDvvqE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=Er1vY3Mz1VGG9PSA9rBZabF50+1qF+Y8N6YuXJ3lK+canho2dMOSKaW5no+g78A2/
	 akNj+3VFoNlHi3qKY6uuFWZLP2YCZ6ZxLT+rbn0Uj0afdcMpX/emzz7uB37CbehCku
	 uVFBmnS9ebVqmKHHs+BkfqDx/x/3PCldDO7pXP07ZqmerL0vRwJ5hC3Kp2Ke3FnteL
	 VMGVkKmy4wAMq2z5GpQSEIM0C7IRvCVWxDLvDz3OOg4ThYAiWlwHUhTqX4Y0YJqckl
	 fwdDfmRBOCwq1qYJ6tHusYK0rITBuZy/PbfXoqPoEy69ker67invPQk1V9H5h/1KxK
	 Lv86g+OMREVxQ==
From: Vincent Mailhol <mailhol@kernel.org>
Date: Mon, 01 Dec 2025 23:55:15 +0100
Subject: [PATCH iproute2-next v2 7/7] iplink_can: add CAN XL's PWM
 interface
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251201-canxl-netlink-v2-7-dadfac811872@kernel.org>
References: <20251201-canxl-netlink-v2-0-dadfac811872@kernel.org>
In-Reply-To: <20251201-canxl-netlink-v2-0-dadfac811872@kernel.org>
To: netdev@vger.kernel.org, Stephen Hemminger <stephen@networkplumber.org>, 
 Marc Kleine-Budde <mkl@pengutronix.de>, 
 Oliver Hartkopp <socketcan@hartkopp.net>, David Ahern <dsahern@kernel.org>
Cc: Rakuram Eswaran <rakuram.e96@gmail.com>, 
 =?utf-8?q?St=C3=A9phane_Grosjean?= <stephane.grosjean@free.fr>, 
 linux-kernel@vger.kernel.org, linux-can@vger.kernel.org, 
 Vincent Mailhol <mailhol@kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=7660; i=mailhol@kernel.org;
 h=from:subject:message-id; bh=CAqoEU5ZBw9f4vxKsNKUAmN5pLXt7BE/7ve/chDvvqE=;
 b=owGbwMvMwCV2McXO4Xp97WbG02pJDJl6ssJ9F5km20itayt/3+xzoVn3BNP/7+EXzi6RyXufd
 rb7ztJ1HaUsDGJcDLJiiizLyjm5FToKvcMO/bWEmcPKBDKEgYtTACYSPYfhv+trhWIps92rd5/m
 sec62XbBsmhJYvVj/t4Lr7f3fE99bszwTz1byOTDAaeq8On7r6s43lVKTDWLfbrsjMd670vbmfp
 XcAAA
X-Developer-Key: i=mailhol@kernel.org; a=openpgp;
 fpr=ED8F700574E67F20E574E8E2AB5FEB886DBB99C2

This is the iproute2 counterpart of Linux kernel's commit 46552323fa67
("can: netlink: add PWM netlink interface").

When the TMS is switched on, the node uses PWM (Pulse Width Modulation)
during the data phase instead of the classic NRZ (Non Return to Zero)
encoding.

PWM is configured by three parameters:

  - PWMS: Pulse Width Modulation Short phase
  - PWML: Pulse Width Modulation Long phase
  - PWMO: Pulse Width Modulation Offset time

For each of these parameters, the CAN netlink interface defines three IFLA
symbols:

  - IFLA_CAN_PWM_PWM*_MIN: the minimum allowed value.
  - IFLA_CAN_PWM_PWM*_MAX: the maximum allowed value.
  - IFLA_CAN_PWM_PWM*: the runtime value.

This results in a total of nine IFLA symbols which are all nested in a
parent IFLA_CAN_XL_PWM symbol.

Add the "pwms", "pwml" and "pwmo" options to iplink_can which controls the
IFLA_CAN_PWM_PWM* runtime values.

Add the logic to query and print all those IFLA values. Update
print_usage() accordingly.

Example using the dummy_can driver:

  # modprobe dummy_can
  # ip link set can0 type can bitrate 1000000 xl on xbitrate 20000000 tms on
  $ ip --details link show can0
  5: can0: <NOARP> mtu 2060 qdisc noop state DOWN mode DEFAULT group default qlen 10
      link/can  promiscuity 0 allmulti 0 minmtu 76 maxmtu 2060
      can <XL,TMS> state STOPPED restart-ms 0
  	  bitrate 1000000 sample-point 0.750
  	  tq 6 prop-seg 59 phase-seg1 60 phase-seg2 40 sjw 20 brp 1
  	  dummy_can CC: tseg1 2..256 tseg2 2..128 sjw 1..128 brp 1..512 brp_inc 1
  	  dummy_can FD: dtseg1 2..256 dtseg2 2..128 dsjw 1..128 dbrp 1..512 dbrp_inc 1
  	  tdco 0..127 tdcf 0..127
  	  xbitrate 20000000 xsample-point 0.625
  	  xtq 6 xprop-seg 2 xphase-seg1 2 xphase-seg2 3 xsjw 1 xbrp 1
  	  pwms 2 pwml 6 pwmo 0
  	  dummy_can XL: xtseg1 2..256 xtseg2 2..128 xsjw 1..128 xbrp 1..512 xbrp_inc 1
  	  xtdco 0..127 xtdcf 0..127
  	  pwms 1..8 pwml 2..24 pwmo 0..16
  	  clock 160000000 numtxqueues 1 numrxqueues 1 gso_max_size 65536 gso_max_segs 65535 tso_max_size 65536 tso_max_segs 65535 gro_max_size 65536 gso_ipv4_max_size 65536 gro_ipv4_max_size 65536

Signed-off-by: Vincent Mailhol <mailhol@kernel.org>
---
Changelog:

v1 -> v2:

  - Remove a double space in patch description
  - s/matches/strcmp/g in can_parse_opt()
---
 ip/iplink_can.c | 92 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 91 insertions(+), 1 deletion(-)

diff --git a/ip/iplink_can.c b/ip/iplink_can.c
index d91e807b..2ce54f0a 100644
--- a/ip/iplink_can.c
+++ b/ip/iplink_can.c
@@ -34,7 +34,7 @@ static void print_usage(FILE *f)
 		"\n"
 		"\t[ xbitrate BITRATE [ xsample-point SAMPLE-POINT] ] |\n"
 		"\t[ xtq TQ xprop-seg PROP_SEG xphase-seg1 PHASE-SEG1\n \t  xphase-seg2 PHASE-SEG2 [ xsjw SJW ] ]\n"
-		"\t[ xtdcv TDCV xtdco TDCO xtdcf TDCF ]\n"
+		"\t[ xtdcv TDCV xtdco TDCO xtdcf TDCF pwms PWMS pwml PWML pwmo PWMO]\n"
 		"\n"
 		"\t[ loopback { on | off } ]\n"
 		"\t[ listen-only { on | off } ]\n"
@@ -67,6 +67,9 @@ static void print_usage(FILE *f)
 		"\t	TDCV		:= { NUMBER in mtq }\n"
 		"\t	TDCO		:= { NUMBER in mtq }\n"
 		"\t	TDCF		:= { NUMBER in mtq }\n"
+		"\t	PWMS		:= { NUMBER in mtq }\n"
+		"\t	PWML		:= { NUMBER in mtq }\n"
+		"\t	PWMO		:= { NUMBER in mtq }\n"
 		"\t	RESTART-MS	:= { 0 | NUMBER in ms }\n"
 		"\n"
 		"\tUnits:\n"
@@ -143,6 +146,7 @@ static int can_parse_opt(struct link_util *lu, int argc, char **argv,
 	struct can_ctrlmode cm = { 0 };
 	struct can_tdc fd = { .tdcv = -1, .tdco = -1, .tdcf = -1 };
 	struct can_tdc xl = { .tdcv = -1, .tdco = -1, .tdcf = -1 };
+	__u32 pwms = -1, pwml = -1, pwmo = -1;
 
 	while (argc > 0) {
 		if (matches(*argv, "bitrate") == 0) {
@@ -266,6 +270,18 @@ static int can_parse_opt(struct link_util *lu, int argc, char **argv,
 			NEXT_ARG();
 			if (get_u32(&xl.tdcf, *argv, 0))
 				invarg("invalid \"xtdcf\" value", *argv);
+		} else if (strcmp(*argv, "pwms") == 0) {
+			NEXT_ARG();
+			if (get_u32(&pwms, *argv, 0))
+				invarg("invalid \"pwms\" value", *argv);
+		} else if (strcmp(*argv, "pwml") == 0) {
+			NEXT_ARG();
+			if (get_u32(&pwml, *argv, 0))
+				invarg("invalid \"pwml\" value", *argv);
+		} else if (strcmp(*argv, "pwmo") == 0) {
+			NEXT_ARG();
+			if (get_u32(&pwmo, *argv, 0))
+				invarg("invalid \"pwmo\" value", *argv);
 		} else if (matches(*argv, "loopback") == 0) {
 			NEXT_ARG();
 			set_ctrlmode("loopback", *argv, &cm,
@@ -401,6 +417,18 @@ static int can_parse_opt(struct link_util *lu, int argc, char **argv,
 			addattr32(n, 1024, IFLA_CAN_TDC_TDCF, xl.tdcf);
 		addattr_nest_end(n, tdc);
 	}
+	if (pwms != -1 || pwml != -1 || pwmo != -1) {
+		struct rtattr *pwm = addattr_nest(n, 1024,
+						  IFLA_CAN_XL_PWM | NLA_F_NESTED);
+
+		if (pwms != -1)
+			addattr32(n, 1024, IFLA_CAN_PWM_PWMS, pwms);
+		if (pwml != -1)
+			addattr32(n, 1024, IFLA_CAN_PWM_PWML, pwml);
+		if (pwmo != -1)
+			addattr32(n, 1024, IFLA_CAN_PWM_PWMO, pwmo);
+		addattr_nest_end(n, pwm);
+	}
 
 	return 0;
 }
@@ -496,6 +524,62 @@ static void can_print_tdc_const_opt(struct rtattr *tdc_attr, bool is_xl)
 	close_json_object();
 }
 
+static void can_print_pwm_opt(struct rtattr *pwm_attr)
+{
+	struct rtattr *tb[IFLA_CAN_PWM_MAX + 1];
+
+	parse_rtattr_nested(tb, IFLA_CAN_PWM_MAX, pwm_attr);
+	if (tb[IFLA_CAN_PWM_PWMS] || tb[IFLA_CAN_PWM_PWML] ||
+	    tb[IFLA_CAN_PWM_PWMO]) {
+		open_json_object("pwm");
+		can_print_nl_indent();
+		if (tb[IFLA_CAN_PWM_PWMS]) {
+			__u32 *pwms = RTA_DATA(tb[IFLA_CAN_PWM_PWMS]);
+
+			print_uint(PRINT_ANY, " pwms", " pwms %u", *pwms);
+		}
+		if (tb[IFLA_CAN_PWM_PWML]) {
+			__u32 *pwml = RTA_DATA(tb[IFLA_CAN_PWM_PWML]);
+
+			print_uint(PRINT_ANY, " pwml", " pwml %u", *pwml);
+		}
+		if (tb[IFLA_CAN_PWM_PWMO]) {
+			__u32 *pwmo = RTA_DATA(tb[IFLA_CAN_PWM_PWMO]);
+
+			print_uint(PRINT_ANY, " pwmo", " pwmo %u", *pwmo);
+		}
+		close_json_object();
+	}
+}
+
+static void can_print_pwm_const_opt(struct rtattr *pwm_attr)
+{
+	struct rtattr *tb[IFLA_CAN_PWM_MAX + 1];
+
+	parse_rtattr_nested(tb, IFLA_CAN_PWM_MAX, pwm_attr);
+	open_json_object("pwm");
+	can_print_nl_indent();
+	if (tb[IFLA_CAN_PWM_PWMS_MAX]) {
+		__u32 *pwms_min = RTA_DATA(tb[IFLA_CAN_PWM_PWMS_MIN]);
+		__u32 *pwms_max = RTA_DATA(tb[IFLA_CAN_PWM_PWMS_MAX]);
+
+		can_print_timing_min_max("pwms", " pwms", *pwms_min, *pwms_max);
+	}
+	if (tb[IFLA_CAN_PWM_PWML_MAX]) {
+		__u32 *pwml_min = RTA_DATA(tb[IFLA_CAN_PWM_PWML_MIN]);
+		__u32 *pwml_max = RTA_DATA(tb[IFLA_CAN_PWM_PWML_MAX]);
+
+		can_print_timing_min_max("pwml", " pwml", *pwml_min, *pwml_max);
+	}
+	if (tb[IFLA_CAN_PWM_PWMO_MAX]) {
+		__u32 *pwmo_min = RTA_DATA(tb[IFLA_CAN_PWM_PWMO_MIN]);
+		__u32 *pwmo_max = RTA_DATA(tb[IFLA_CAN_PWM_PWMO_MAX]);
+
+		can_print_timing_min_max("pwmo", " pwmo", *pwmo_min, *pwmo_max);
+	}
+	close_json_object();
+}
+
 static void can_print_ctrlmode_ext(struct rtattr *ctrlmode_ext_attr,
 				   __u32 cm_flags)
 {
@@ -735,6 +819,9 @@ static void can_print_opt(struct link_util *lu, FILE *f, struct rtattr *tb[])
 		if (tb[IFLA_CAN_XL_TDC])
 			can_print_tdc_opt(tb[IFLA_CAN_XL_TDC], true);
 
+		if (tb[IFLA_CAN_XL_PWM])
+			can_print_pwm_opt(tb[IFLA_CAN_XL_PWM]);
+
 		close_json_object();
 	}
 
@@ -759,6 +846,9 @@ static void can_print_opt(struct link_util *lu, FILE *f, struct rtattr *tb[])
 		if (tb[IFLA_CAN_XL_TDC])
 			can_print_tdc_const_opt(tb[IFLA_CAN_XL_TDC], true);
 
+		if (tb[IFLA_CAN_XL_PWM])
+			can_print_pwm_const_opt(tb[IFLA_CAN_XL_PWM]);
+
 		close_json_object();
 	}
 

-- 
2.51.2


