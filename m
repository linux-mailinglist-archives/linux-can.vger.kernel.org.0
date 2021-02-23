Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5BC1F323081
	for <lists+linux-can@lfdr.de>; Tue, 23 Feb 2021 19:20:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233026AbhBWSUA (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Tue, 23 Feb 2021 13:20:00 -0500
Received: from smtp02.smtpout.orange.fr ([80.12.242.124]:17520 "EHLO
        smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232986AbhBWST7 (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 23 Feb 2021 13:19:59 -0500
Received: from localhost.localdomain ([153.202.107.157])
        by mwinf5d04 with ME
        id YiJC240093PnFJp03iJFes; Tue, 23 Feb 2021 19:18:17 +0100
X-ME-Helo: localhost.localdomain
X-ME-Auth: bWFpbGhvbC52aW5jZW50QHdhbmFkb28uZnI=
X-ME-Date: Tue, 23 Feb 2021 19:18:17 +0100
X-ME-IP: 153.202.107.157
From:   Vincent Mailhol <mailhol.vincent@wanadoo.fr>
To:     Marc Kleine-Budde <mkl@pengutronix.de>,
        linux-can <linux-can@vger.kernel.org>,
        Oliver Hartkopp <socketcan@hartkopp.net>
Cc:     Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Subject: [PATCH v1 1/1] iplink_can: add new CAN FD bittiming parameters: Transmitter Delay Compensation (TDC)
Date:   Wed, 24 Feb 2021 03:17:14 +0900
Message-Id: <20210223181714.219655-2-mailhol.vincent@wanadoo.fr>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210223181714.219655-1-mailhol.vincent@wanadoo.fr>
References: <20210223181714.219655-1-mailhol.vincent@wanadoo.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

At high bit rates, the propagation delay from the TX pin to the RX pin
of the transceiver causes measurement errors: the sample point on the
RX pin might occur on the previous bit.

This issue is addressed in ISO 11898-1 section 11.3.3 "Transmitter
delay compensation" (TDC).

This patch brings command line support to six TDC parameters which
were recently added to the kernel's CAN netlink interface in order to
implement TDC:
  - IFLA_CAN_TDCV: Transmitter Delay Compensation Value
  - IFLA_CAN_TDCO: Transmitter Delay Compensation Offset
  - IFLA_CAN_TDCF: Transmitter Delay Compensation Filter window
  - IFLA_CAN_TDCV_MAX_CONST: Transmitter Delay Compensation Value
    maximum value
  - IFLA_CAN_TDCO_MAX_CONST: Transmitter Delay Compensation Offset
    maximum value
  - IFLA_CAN_TDCF_MAX_CONST: Transmitter Delay Compensation Filter
    window maximum value

Signed-off-by: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
---
 include/uapi/linux/can/netlink.h |  6 ++++
 ip/iplink_can.c                  | 58 ++++++++++++++++++++++++++++++++
 2 files changed, 64 insertions(+)

diff --git a/include/uapi/linux/can/netlink.h b/include/uapi/linux/can/netlink.h
index 00c763df..b85d5248 100644
--- a/include/uapi/linux/can/netlink.h
+++ b/include/uapi/linux/can/netlink.h
@@ -134,6 +134,12 @@ enum {
 	IFLA_CAN_BITRATE_CONST,
 	IFLA_CAN_DATA_BITRATE_CONST,
 	IFLA_CAN_BITRATE_MAX,
+	IFLA_CAN_TDCV,
+	IFLA_CAN_TDCO,
+	IFLA_CAN_TDCF,
+	IFLA_CAN_TDCV_MAX_CONST,
+	IFLA_CAN_TDCO_MAX_CONST,
+	IFLA_CAN_TDCF_MAX_CONST,
 	__IFLA_CAN_MAX
 };
 
diff --git a/ip/iplink_can.c b/ip/iplink_can.c
index 6a26f3ff..ebe46024 100644
--- a/ip/iplink_can.c
+++ b/ip/iplink_can.c
@@ -28,6 +28,7 @@ static void print_usage(FILE *f)
 		"\n"
 		"\t[ dbitrate BITRATE [ dsample-point SAMPLE-POINT] ] |\n"
 		"\t[ dtq TQ dprop-seg PROP_SEG dphase-seg1 PHASE-SEG1\n \t  dphase-seg2 PHASE-SEG2 [ dsjw SJW ] ]\n"
+		"\t[ tdcv TDCV tdco TDCO tdcf TDCF ]\n"
 		"\n"
 		"\t[ loopback { on | off } ]\n"
 		"\t[ listen-only { on | off } ]\n"
@@ -52,6 +53,9 @@ static void print_usage(FILE *f)
 		"\t	  PHASE-SEG2	:= { 1..8 }\n"
 		"\t	  SJW		:= { 1..4 }\n"
 		"\t	  RESTART-MS	:= { 0 | NUMBER }\n"
+		"\t	  TDCV		:= { NUMBER }\n"
+		"\t	  TDCO		:= { NUMBER }\n"
+		"\t	  TDCF		:= { NUMBER }\n"
 		);
 }
 
@@ -116,6 +120,7 @@ static int can_parse_opt(struct link_util *lu, int argc, char **argv,
 {
 	struct can_bittiming bt = {}, dbt = {};
 	struct can_ctrlmode cm = {0, 0};
+	__u32 tdcv = -1, tdco = -1, tdcf = -1;
 
 	while (argc > 0) {
 		if (matches(*argv, "bitrate") == 0) {
@@ -181,6 +186,18 @@ static int can_parse_opt(struct link_util *lu, int argc, char **argv,
 			NEXT_ARG();
 			if (get_u32(&dbt.sjw, *argv, 0))
 				invarg("invalid \"dsjw\" value\n", *argv);
+		} else if (matches(*argv, "tdcv") == 0) {
+			NEXT_ARG();
+			if (get_u32(&tdcv, *argv, 0))
+				invarg("invalid \"tdcv\" value\n", *argv);
+		} else if (matches(*argv, "tdco") == 0) {
+			NEXT_ARG();
+			if (get_u32(&tdco, *argv, 0))
+				invarg("invalid \"tdco\" value\n", *argv);
+		} else if (matches(*argv, "tdcf") == 0) {
+			NEXT_ARG();
+			if (get_u32(&tdcf, *argv, 0))
+				invarg("invalid \"tdcf\" value\n", *argv);
 		} else if (matches(*argv, "loopback") == 0) {
 			NEXT_ARG();
 			set_ctrlmode("loopback", *argv, &cm,
@@ -253,6 +270,12 @@ static int can_parse_opt(struct link_util *lu, int argc, char **argv,
 		addattr_l(n, 1024, IFLA_CAN_DATA_BITTIMING, &dbt, sizeof(dbt));
 	if (cm.mask)
 		addattr_l(n, 1024, IFLA_CAN_CTRLMODE, &cm, sizeof(cm));
+	if (tdcv != -1)
+		addattr32(n, 1024, IFLA_CAN_TDCV, tdcv);
+	if (tdco != -1)
+		addattr32(n, 1024, IFLA_CAN_TDCO, tdco);
+	if (tdcf != -1)
+		addattr32(n, 1024, IFLA_CAN_TDCF, tdcf);
 
 	return 0;
 }
@@ -523,6 +546,41 @@ static void can_print_opt(struct link_util *lu, FILE *f, struct rtattr *tb[])
 		}
 	}
 
+	if (tb[IFLA_CAN_TDCV] && tb[IFLA_CAN_TDCO] && tb[IFLA_CAN_TDCF]) {
+		__u32 *tdcv = RTA_DATA(tb[IFLA_CAN_TDCV]);
+		__u32 *tdco = RTA_DATA(tb[IFLA_CAN_TDCO]);
+		__u32 *tdcf = RTA_DATA(tb[IFLA_CAN_TDCF]);
+
+		if (is_json_context()) {
+			open_json_object("tdc");
+			print_int(PRINT_JSON, "tdcv", NULL, *tdcv);
+			print_int(PRINT_JSON, "tdco", NULL, *tdco);
+			print_int(PRINT_JSON, "tdcf", NULL, *tdcf);
+			close_json_object();
+		} else {
+			fprintf(f, "\n	  tdcv %d tdco %d tdcf %d",
+				*tdcv, *tdco, *tdcf);
+		}
+	}
+
+	if (tb[IFLA_CAN_TDCV_MAX_CONST] && tb[IFLA_CAN_TDCO_MAX_CONST] &&
+	    tb[IFLA_CAN_TDCF_MAX_CONST]) {
+		__u32 *tdcv_max = RTA_DATA(tb[IFLA_CAN_TDCV_MAX_CONST]);
+		__u32 *tdco_max = RTA_DATA(tb[IFLA_CAN_TDCO_MAX_CONST]);
+		__u32 *tdcf_max = RTA_DATA(tb[IFLA_CAN_TDCF_MAX_CONST]);
+
+		if (is_json_context()) {
+			open_json_object("tdc_const");
+			print_int(PRINT_JSON, "tdcv_max", NULL, *tdcv_max);
+			print_int(PRINT_JSON, "tdco_max", NULL, *tdco_max);
+			print_int(PRINT_JSON, "tdcf_max", NULL, *tdcf_max);
+			close_json_object();
+		} else {
+			fprintf(f, "\n	  tdcv_max %d tdco_max %d tdcf_max %d",
+				*tdcv_max, *tdco_max, *tdcf_max);
+		}
+	}
+
 	if (tb[IFLA_CAN_TERMINATION_CONST] && tb[IFLA_CAN_TERMINATION]) {
 		__u16 *trm = RTA_DATA(tb[IFLA_CAN_TERMINATION]);
 		__u16 *trm_const = RTA_DATA(tb[IFLA_CAN_TERMINATION_CONST]);
-- 
2.26.2

