Return-Path: <linux-can+bounces-3645-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C4446AC0768
	for <lists+linux-can@lfdr.de>; Thu, 22 May 2025 10:43:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1986E3BC3E2
	for <lists+linux-can@lfdr.de>; Thu, 22 May 2025 08:41:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EC3C2874FA;
	Thu, 22 May 2025 08:41:42 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BBA5286893
	for <linux-can@vger.kernel.org>; Thu, 22 May 2025 08:41:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747903302; cv=none; b=Pc0swjS+D4MF2zgvpXzlInb89JlGw1I+mzgHxEQTns+vnxNtUsKq5RAZ+pxZ1MQ5GoY8rGAGgCGlZZgFvXhbyHFBS6W24IxdkZxePho5Y+kxy1F92xWZihZsqosyHW8aUMnKsjveIdyyLFty8Xu+td0a8xknZK8dRaCduhgjVWI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747903302; c=relaxed/simple;
	bh=3mtbNAyYQCSDw96OC7u0R7OrPdNuhLeR0od3jWbnik4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ao27ReX7peLuPK6KwACxCij38EhcZZ+4ABHCUdxrQdF70maBshYIQl8rKvvQOzil6XtA/AKJMnypVOQJos9JRo8VHWc7yRz9oQ16w05WtTHqv9YLAkaIZ9WLn3umdRXjsh1z4YC4gBcYs4m25HI1a/gXxZmExOnvbRypUSn/UDg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1uI1Ug-00067z-6t
	for linux-can@vger.kernel.org; Thu, 22 May 2025 10:41:38 +0200
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1uI1Uf-000hkm-0N
	for linux-can@vger.kernel.org;
	Thu, 22 May 2025 10:41:37 +0200
Received: from dspam.blackshift.org (localhost [127.0.0.1])
	by bjornoya.blackshift.org (Postfix) with SMTP id C55A64172F6
	for <linux-can@vger.kernel.org>; Thu, 22 May 2025 08:41:36 +0000 (UTC)
Received: from hardanger.blackshift.org (unknown [172.20.34.65])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by bjornoya.blackshift.org (Postfix) with ESMTPS id BF5944172CB;
	Thu, 22 May 2025 08:41:34 +0000 (UTC)
Received: from blackshift.org (localhost [::1])
	by hardanger.blackshift.org (OpenSMTPD) with ESMTP id 08c18bdb;
	Thu, 22 May 2025 08:41:30 +0000 (UTC)
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	linux-can@vger.kernel.org,
	kernel@pengutronix.de,
	Biju Das <biju.das.jz@bp.renesas.com>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH net-next 07/22] can: rcar_canfd: Add rcar_canfd_setrnc()
Date: Thu, 22 May 2025 10:36:35 +0200
Message-ID: <20250522084128.501049-8-mkl@pengutronix.de>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250522084128.501049-1-mkl@pengutronix.de>
References: <20250522084128.501049-1-mkl@pengutronix.de>
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

Add rcar_canfd_setrnc() to replace the macro RCANFD_GAFLCFG_SETRNC.
While at it, replace int->unsigned int for local variables offset, page
and num_rules in rcar_canfd_configure_afl_rules().

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
Link: https://patch.msgid.link/20250417054320.14100-8-biju.das.jz@bp.renesas.com
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/rcar/rcar_canfd.c | 18 +++++++++++-------
 1 file changed, 11 insertions(+), 7 deletions(-)

diff --git a/drivers/net/can/rcar/rcar_canfd.c b/drivers/net/can/rcar/rcar_canfd.c
index 45d0c34f64f6..6b87c1548f68 100644
--- a/drivers/net/can/rcar/rcar_canfd.c
+++ b/drivers/net/can/rcar/rcar_canfd.c
@@ -90,10 +90,6 @@
 
 /* AFL Rx rules registers */
 
-/* RSCFDnCFDGAFLCFG0 / RSCFDnGAFLCFG0 */
-#define RCANFD_GAFLCFG_SETRNC(gpriv, n, x) \
-	((x) << (reg_gen4(gpriv, 16, 24) - ((n) & 1) * reg_gen4(gpriv, 16, 8)))
-
 /* RSCFDnCFDGAFLECTR / RSCFDnGAFLECTR */
 #define RCANFD_GAFLECTR_AFLDAE		BIT(8)
 #define RCANFD_GAFLECTR_AFLPN(gpriv, x)	((x) & reg_gen4(gpriv, 0x7f, 0x1f))
@@ -677,6 +673,15 @@ static void rcar_canfd_tx_failure_cleanup(struct net_device *ndev)
 		can_free_echo_skb(ndev, i, NULL);
 }
 
+static void rcar_canfd_setrnc(struct rcar_canfd_global *gpriv, unsigned int ch,
+			      unsigned int num_rules)
+{
+	unsigned int shift = reg_gen4(gpriv, 16, 24) - (ch & 1) * reg_gen4(gpriv, 16, 8);
+	u32 rnc = num_rules << shift;
+
+	rcar_canfd_set_bit(gpriv->base, RCANFD_GAFLCFG(ch), rnc);
+}
+
 static void rcar_canfd_set_mode(struct rcar_canfd_global *gpriv)
 {
 	if (is_gen4(gpriv)) {
@@ -785,7 +790,7 @@ static void rcar_canfd_configure_controller(struct rcar_canfd_global *gpriv)
 static void rcar_canfd_configure_afl_rules(struct rcar_canfd_global *gpriv,
 					   u32 ch, u32 rule_entry)
 {
-	int offset, page, num_rules = RCANFD_CHANNEL_NUMRULES;
+	unsigned int offset, page, num_rules = RCANFD_CHANNEL_NUMRULES;
 	u32 rule_entry_index = rule_entry % 16;
 	u32 ridx = ch + RCANFD_RFFIFO_IDX;
 
@@ -796,8 +801,7 @@ static void rcar_canfd_configure_afl_rules(struct rcar_canfd_global *gpriv,
 			    RCANFD_GAFLECTR_AFLDAE));
 
 	/* Write number of rules for channel */
-	rcar_canfd_set_bit(gpriv->base, RCANFD_GAFLCFG(ch),
-			   RCANFD_GAFLCFG_SETRNC(gpriv, ch, num_rules));
+	rcar_canfd_setrnc(gpriv, ch, num_rules);
 	if (is_gen4(gpriv))
 		offset = RCANFD_GEN4_GAFL_OFFSET;
 	else if (gpriv->fdmode)
-- 
2.47.2



