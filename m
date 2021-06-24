Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C73C93B2562
	for <lists+linux-can@lfdr.de>; Thu, 24 Jun 2021 05:20:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229800AbhFXDWZ (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Wed, 23 Jun 2021 23:22:25 -0400
Received: from relay-b01.edpnet.be ([212.71.1.221]:57456 "EHLO
        relay-b01.edpnet.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229796AbhFXDWY (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Wed, 23 Jun 2021 23:22:24 -0400
X-ASG-Debug-ID: 1624504803-15c43444e47e7d30001-ZXuqFv
Received: from zotac.vandijck-laurijssen.be (94.105.105.164.dyn.edpnet.net [94.105.105.164]) by relay-b01.edpnet.be with ESMTP id 50YkyG2yKdwJysAW for <linux-can@vger.kernel.org>; Thu, 24 Jun 2021 05:20:03 +0200 (CEST)
X-Barracuda-Envelope-From: dev.kurt@vandijck-laurijssen.be
X-Barracuda-Effective-Source-IP: 94.105.105.164.dyn.edpnet.net[94.105.105.164]
X-Barracuda-Apparent-Source-IP: 94.105.105.164
Received: from x1.vandijck-laurijssen.be (x1.vandijck-laurijssen.be [192.168.0.36])
        by zotac.vandijck-laurijssen.be (Postfix) with ESMTPSA id 132931503AC3;
        Thu, 24 Jun 2021 05:20:03 +0200 (CEST)
From:   Kurt Van Dijck <dev.kurt@vandijck-laurijssen.be>
To:     linux-can@vger.kernel.org
Cc:     Kurt Van Dijck <dev.kurt@vandijck-laurijssen.be>
Subject: [PATCH 2/3] can-calc-bittiming: add c_can
Date:   Thu, 24 Jun 2021 05:19:53 +0200
X-ASG-Orig-Subj: [PATCH 2/3] can-calc-bittiming: add c_can
Message-Id: <20210624031954.26195-2-dev.kurt@vandijck-laurijssen.be>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20210624031954.26195-1-dev.kurt@vandijck-laurijssen.be>
References: <20210624031954.26195-1-dev.kurt@vandijck-laurijssen.be>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Barracuda-Connect: 94.105.105.164.dyn.edpnet.net[94.105.105.164]
X-Barracuda-Start-Time: 1624504803
X-Barracuda-URL: https://212.71.1.221:443/cgi-mod/mark.cgi
X-Virus-Scanned: by bsmtpd at edpnet.be
X-Barracuda-Scan-Msg-Size: 1445
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
 can-calc-bit-timing.c | 34 ++++++++++++++++++++++++++++++++++
 1 file changed, 34 insertions(+)

diff --git a/can-calc-bit-timing.c b/can-calc-bit-timing.c
index fb61947..d0626f7 100644
--- a/can-calc-bit-timing.c
+++ b/can-calc-bit-timing.c
@@ -289,6 +289,24 @@ static void printf_btr_bxcan(struct can_bittiming *bt, bool hdr)
 	}
 }
 
+static void printf_btr_c_can(struct can_bittiming *bt, bool hdr)
+{
+	if (hdr) {
+		printf("%s", "  BTR  BRPEXT");
+	} else {
+		uint32_t btr;
+		uint32_t brpext;
+
+		btr = (((bt->brp -1) & 0x3f) << 0) |
+			(((bt->sjw -1) & 0x3) << 6) |
+			(((bt->prop_seg + bt->phase_seg1 -1) & 0xf) << 8) |
+			(((bt->phase_seg2 -1) & 0x7) << 12);
+		brpext = ((bt->brp -1) >> 6) & 0xf;
+
+		printf("0x%04x 0x%04x", btr, brpext);
+	}
+}
+
 static struct calc_bittiming_const can_calc_consts[] = {
 	{
 		.bittiming_const = {
@@ -449,6 +467,22 @@ static struct calc_bittiming_const can_calc_consts[] = {
 			{ .clk = 48000000, },
 		},
 		.printf_btr = printf_btr_bxcan,
+	}, {
+		.bittiming_const = {
+			.name = "c_can",
+			.tseg1_min = 2,
+			.tseg1_max = 16,
+			.tseg2_min = 1,
+			.tseg2_max = 8,
+			.sjw_max = 4,
+			.brp_min = 1,
+			.brp_max = 1024,
+			.brp_inc = 1,
+		},
+		.ref_clk = {
+			{ .clk = 24000000, },
+		},
+		.printf_btr = printf_btr_c_can,
 	},
 };
 
-- 
2.25.0

