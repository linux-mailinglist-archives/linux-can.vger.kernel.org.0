Return-Path: <linux-can+bounces-3074-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 53729A61212
	for <lists+linux-can@lfdr.de>; Fri, 14 Mar 2025 14:09:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 50B4B462AC1
	for <lists+linux-can@lfdr.de>; Fri, 14 Mar 2025 13:09:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C8361FFC5D;
	Fri, 14 Mar 2025 13:09:22 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7641D1FF1B8
	for <linux-can@vger.kernel.org>; Fri, 14 Mar 2025 13:09:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741957762; cv=none; b=vGgJwWOqwAfGMMqd4W8iTalEoSK3xdAv9z30ahyB4CvMTQQyunzrkSp9jWPtFlSBf3SI4y/vbEAs9t+tP/cQvHl9HPf5a6SOmLsYvecogVBHQIhODmUZ6n3yPKyxxUhhRSLFZ4ij2Zn9CYEkVm9tzThm7XqCYWggfH7jfkexs+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741957762; c=relaxed/simple;
	bh=1Yt9ejSAtnuypntzxYofl4jDhgcGmB/Prls4KsiZpnw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cO7JFXHUGhe5n9sXdfWUykxG1xZpQjHguV3tWl+Xr+lWj0RTLmUuZD3CujXVddhAXcMvfAD68l4yij97ASzQWT6fLHYgiFYQhfQKrxuMO08bX1gICfL+YMJwAWiGVGZxGVgQZqrwFrWtQjf5kBoFA5kk0I/prf8dSPbMStV0Q6Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1tt4mr-0007Ks-FG
	for linux-can@vger.kernel.org; Fri, 14 Mar 2025 14:09:17 +0100
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1tt4mq-005hoW-1p
	for linux-can@vger.kernel.org;
	Fri, 14 Mar 2025 14:09:16 +0100
Received: from dspam.blackshift.org (localhost [127.0.0.1])
	by bjornoya.blackshift.org (Postfix) with SMTP id 3E87B3DBB7A
	for <linux-can@vger.kernel.org>; Fri, 14 Mar 2025 13:09:16 +0000 (UTC)
Received: from hardanger.blackshift.org (unknown [172.20.34.65])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by bjornoya.blackshift.org (Postfix) with ESMTPS id 3334C3DBB4F;
	Fri, 14 Mar 2025 13:09:14 +0000 (UTC)
Received: from blackshift.org (localhost [::1])
	by hardanger.blackshift.org (OpenSMTPD) with ESMTP id eae45b8c;
	Fri, 14 Mar 2025 13:09:12 +0000 (UTC)
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	linux-can@vger.kernel.org,
	kernel@pengutronix.de,
	Biju Das <biju.das.jz@bp.renesas.com>,
	stable@vger.kernel.org,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH net 4/6] can: rcar_canfd: Fix page entries in the AFL list
Date: Fri, 14 Mar 2025 14:04:03 +0100
Message-ID: <20250314130909.2890541-5-mkl@pengutronix.de>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250314130909.2890541-1-mkl@pengutronix.de>
References: <20250314130909.2890541-1-mkl@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org

From: Biju Das <biju.das.jz@bp.renesas.com>

There are a total of 96 AFL pages and each page has 16 entries with
registers CFDGAFLIDr, CFDGAFLMr, CFDGAFLP0r, CFDGAFLP1r holding
the rule entries (r = 0..15).

Currently, RCANFD_GAFL* macros use a start variable to find AFL entries,
which is incorrect as the testing on RZ/G3E shows ch1 and ch4
gets a start value of 0 and the register contents are overwritten.

Fix this issue by using rule_entry corresponding to the channel
to find the page entries in the AFL list.

Fixes: dd3bd23eb438 ("can: rcar_canfd: Add Renesas R-Car CAN FD driver")
Cc: stable@vger.kernel.org
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
Tested-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://patch.msgid.link/20250307170330.173425-3-biju.das.jz@bp.renesas.com
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/rcar/rcar_canfd.c | 28 +++++++++++-----------------
 1 file changed, 11 insertions(+), 17 deletions(-)

diff --git a/drivers/net/can/rcar/rcar_canfd.c b/drivers/net/can/rcar/rcar_canfd.c
index df1a5d0b37b2..aa3df0d05b85 100644
--- a/drivers/net/can/rcar/rcar_canfd.c
+++ b/drivers/net/can/rcar/rcar_canfd.c
@@ -787,22 +787,14 @@ static void rcar_canfd_configure_controller(struct rcar_canfd_global *gpriv)
 }
 
 static void rcar_canfd_configure_afl_rules(struct rcar_canfd_global *gpriv,
-					   u32 ch)
+					   u32 ch, u32 rule_entry)
 {
-	u32 cfg;
-	int offset, start, page, num_rules = RCANFD_CHANNEL_NUMRULES;
+	int offset, page, num_rules = RCANFD_CHANNEL_NUMRULES;
+	u32 rule_entry_index = rule_entry % 16;
 	u32 ridx = ch + RCANFD_RFFIFO_IDX;
 
-	if (ch == 0) {
-		start = 0; /* Channel 0 always starts from 0th rule */
-	} else {
-		/* Get number of Channel 0 rules and adjust */
-		cfg = rcar_canfd_read(gpriv->base, RCANFD_GAFLCFG(ch));
-		start = RCANFD_GAFLCFG_GETRNC(gpriv, 0, cfg);
-	}
-
 	/* Enable write access to entry */
-	page = RCANFD_GAFL_PAGENUM(start);
+	page = RCANFD_GAFL_PAGENUM(rule_entry);
 	rcar_canfd_set_bit(gpriv->base, RCANFD_GAFLECTR,
 			   (RCANFD_GAFLECTR_AFLPN(gpriv, page) |
 			    RCANFD_GAFLECTR_AFLDAE));
@@ -818,13 +810,13 @@ static void rcar_canfd_configure_afl_rules(struct rcar_canfd_global *gpriv,
 		offset = RCANFD_C_GAFL_OFFSET;
 
 	/* Accept all IDs */
-	rcar_canfd_write(gpriv->base, RCANFD_GAFLID(offset, start), 0);
+	rcar_canfd_write(gpriv->base, RCANFD_GAFLID(offset, rule_entry_index), 0);
 	/* IDE or RTR is not considered for matching */
-	rcar_canfd_write(gpriv->base, RCANFD_GAFLM(offset, start), 0);
+	rcar_canfd_write(gpriv->base, RCANFD_GAFLM(offset, rule_entry_index), 0);
 	/* Any data length accepted */
-	rcar_canfd_write(gpriv->base, RCANFD_GAFLP0(offset, start), 0);
+	rcar_canfd_write(gpriv->base, RCANFD_GAFLP0(offset, rule_entry_index), 0);
 	/* Place the msg in corresponding Rx FIFO entry */
-	rcar_canfd_set_bit(gpriv->base, RCANFD_GAFLP1(offset, start),
+	rcar_canfd_set_bit(gpriv->base, RCANFD_GAFLP1(offset, rule_entry_index),
 			   RCANFD_GAFLP1_GAFLFDP(ridx));
 
 	/* Disable write access to page */
@@ -1851,6 +1843,7 @@ static int rcar_canfd_probe(struct platform_device *pdev)
 	unsigned long channels_mask = 0;
 	int err, ch_irq, g_irq;
 	int g_err_irq, g_recc_irq;
+	u32 rule_entry = 0;
 	bool fdmode = true;			/* CAN FD only mode - default */
 	char name[9] = "channelX";
 	int i;
@@ -2023,7 +2016,8 @@ static int rcar_canfd_probe(struct platform_device *pdev)
 		rcar_canfd_configure_tx(gpriv, ch);
 
 		/* Configure receive rules */
-		rcar_canfd_configure_afl_rules(gpriv, ch);
+		rcar_canfd_configure_afl_rules(gpriv, ch, rule_entry);
+		rule_entry += RCANFD_CHANNEL_NUMRULES;
 	}
 
 	/* Configure common interrupts */
-- 
2.47.2



