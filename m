Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 505D03B2561
	for <lists+linux-can@lfdr.de>; Thu, 24 Jun 2021 05:20:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229758AbhFXDWY (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Wed, 23 Jun 2021 23:22:24 -0400
Received: from relay-b02.edpnet.be ([212.71.1.222]:42052 "EHLO
        relay-b02.edpnet.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229759AbhFXDWX (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Wed, 23 Jun 2021 23:22:23 -0400
X-ASG-Debug-ID: 1624504803-15c4330a7079ea90001-ZXuqFv
Received: from zotac.vandijck-laurijssen.be (94.105.105.164.dyn.edpnet.net [94.105.105.164]) by relay-b02.edpnet.be with ESMTP id r4dRmoORQ43BfsVL for <linux-can@vger.kernel.org>; Thu, 24 Jun 2021 05:20:03 +0200 (CEST)
X-Barracuda-Envelope-From: dev.kurt@vandijck-laurijssen.be
X-Barracuda-Effective-Source-IP: 94.105.105.164.dyn.edpnet.net[94.105.105.164]
X-Barracuda-Apparent-Source-IP: 94.105.105.164
Received: from x1.vandijck-laurijssen.be (x1.vandijck-laurijssen.be [192.168.0.36])
        by zotac.vandijck-laurijssen.be (Postfix) with ESMTPSA id 0D4BD1503AC2;
        Thu, 24 Jun 2021 05:20:03 +0200 (CEST)
From:   Kurt Van Dijck <dev.kurt@vandijck-laurijssen.be>
To:     linux-can@vger.kernel.org
Cc:     Kurt Van Dijck <dev.kurt@vandijck-laurijssen.be>
Subject: [PATCH 1/3] can-calc-bittiming: add stm32 bxcan
Date:   Thu, 24 Jun 2021 05:19:52 +0200
X-ASG-Orig-Subj: [PATCH 1/3] can-calc-bittiming: add stm32 bxcan
Message-Id: <20210624031954.26195-1-dev.kurt@vandijck-laurijssen.be>
X-Mailer: git-send-email 2.25.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Barracuda-Connect: 94.105.105.164.dyn.edpnet.net[94.105.105.164]
X-Barracuda-Start-Time: 1624504803
X-Barracuda-URL: https://212.71.1.222:443/cgi-mod/mark.cgi
X-Virus-Scanned: by bsmtpd at edpnet.be
X-Barracuda-Scan-Msg-Size: 1372
X-Barracuda-BRTS-Status: 1
X-Barracuda-Spam-Score: 0.00
X-Barracuda-Spam-Status: No, SCORE=0.00 using global scores of TAG_LEVEL=1000.0 QUARANTINE_LEVEL=1000.0 KILL_LEVEL=7.0 tests=
X-Barracuda-Spam-Report: Code version 3.2, rules version 3.2.3.90858
        Rule breakdown below
         pts rule name              description
        ---- ---------------------- --------------------------------------------------
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Signed-off-by: Kurt Van Dijck <dev.kurt@vandijck-laurijssen.be>
---
 can-calc-bit-timing.c | 32 ++++++++++++++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/can-calc-bit-timing.c b/can-calc-bit-timing.c
index d99bd22..fb61947 100644
--- a/can-calc-bit-timing.c
+++ b/can-calc-bit-timing.c
@@ -273,6 +273,22 @@ static void printf_btr_rcar_can(struct can_bittiming *bt, bool hdr)
 	}
 }
 
+static void printf_btr_bxcan(struct can_bittiming *bt, bool hdr)
+{
+	if (hdr) {
+		printf("%10s", "CAN_BTR");
+	} else {
+		uint32_t btr;
+
+		btr = (((bt->brp -1) & 0x3ff) << 0) |
+			(((bt->prop_seg + bt->phase_seg1 -1) & 0xf) << 16) |
+			(((bt->phase_seg2 -1) & 0x7) << 20) |
+			(((bt->sjw -1) & 0x3) << 24);
+
+		printf("0x%08x", btr);
+	}
+}
+
 static struct calc_bittiming_const can_calc_consts[] = {
 	{
 		.bittiming_const = {
@@ -417,6 +433,22 @@ static struct calc_bittiming_const can_calc_consts[] = {
 			{ .clk = 65000000, },
 		},
 		.printf_btr = printf_btr_rcar_can,
+	}, {
+		.bittiming_const = {
+			.name = "bxcan",
+			.tseg1_min = 1,
+			.tseg1_max = 16,
+			.tseg2_min = 1,
+			.tseg2_max = 8,
+			.sjw_max = 4,
+			.brp_min = 1,
+			.brp_max = 1024,
+			.brp_inc = 1,
+		},
+		.ref_clk = {
+			{ .clk = 48000000, },
+		},
+		.printf_btr = printf_btr_bxcan,
 	},
 };
 
-- 
2.25.0

