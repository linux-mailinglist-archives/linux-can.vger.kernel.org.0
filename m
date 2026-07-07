Return-Path: <linux-can+bounces-8055-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id Va73My3XTGqyqgEAu9opvQ
	(envelope-from <linux-can+bounces-8055-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Tue, 07 Jul 2026 12:38:37 +0200
X-Original-To: lists+linux-can@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AA9271A7CB
	for <lists+linux-can@lfdr.de>; Tue, 07 Jul 2026 12:38:37 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=none;
	dmarc=none;
	spf=pass (mail.lfdr.de: domain of "linux-can+bounces-8055-lists+linux-can=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="linux-can+bounces-8055-lists+linux-can=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 74998310F562
	for <lists+linux-can@lfdr.de>; Tue,  7 Jul 2026 10:25:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 220133E3159;
	Tue,  7 Jul 2026 10:24:40 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC2903E5567;
	Tue,  7 Jul 2026 10:24:38 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783419880; cv=none; b=RL2zyq2WpMOfEEtYAKutq74F+H1/JejNeqQX4icYjzioRF5SmZVa4Wp8oK8zV/NrgsD3TXtOdpGB33QUhcVxFEKcnBqj/bWfm+GrE4K6EUy9antfw5Fpw9Ro7CQZAB9wWuR6rTuZAm+ujoMPrUWDP/SzjTxq79pln40LbrDo1N4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783419880; c=relaxed/simple;
	bh=nNfsUqC44vFwwkE2+gZ80QHy8mJY3Uj7zT+9PEDXEKY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=S095CoisGs9C1ynz3o4UAi/vh0UVacbbUnOv1DtrVWlWxC5954YSnPI0gqXQjbQFQNPathXL9N3y08Ugr+dtblfGvcheRu1lnugc1iIgr0dyPLSGn7pehcX8dHC1IFtwIWMi5qHzVUq8gDobqWrmLVM579gBEbXK7dKXgHSnmsU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C5A181F00A3A;
	Tue,  7 Jul 2026 10:24:34 +0000 (UTC)
From: Claudiu Beznea <claudiu.beznea+renesas@tuxon.dev>
To: mkl@pengutronix.de,
	mailhol@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	geert+renesas@glider.be,
	magnus.damm@gmail.com,
	mturquette@baylibre.com,
	sboyd@kernel.org,
	bmasney@redhat.com,
	biju.das.jz@bp.renesas.com,
	tu.nguyen.xg@renesas.com,
	fabrizio.castro.jz@renesas.com
Cc: claudiu.beznea@tuxon.dev,
	linux-can@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-clk@vger.kernel.org,
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Subject: [PATCH 3/8] can: rcar_canfd: Fix typos in macro names
Date: Tue,  7 Jul 2026 13:24:13 +0300
Message-ID: <20260707102418.1646159-4-claudiu.beznea+renesas@tuxon.dev>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260707102418.1646159-1-claudiu.beznea+renesas@tuxon.dev>
References: <20260707102418.1646159-1-claudiu.beznea+renesas@tuxon.dev>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.54 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[tuxon.dev];
	RCPT_COUNT_TWELVE(0.00)[20];
	RCVD_COUNT_THREE(0.00)[4];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:mkl@pengutronix.de,m:mailhol@kernel.org,m:robh@kernel.org,m:krzk+dt@kernel.org,m:conor+dt@kernel.org,m:geert+renesas@glider.be,m:magnus.damm@gmail.com,m:mturquette@baylibre.com,m:sboyd@kernel.org,m:bmasney@redhat.com,m:biju.das.jz@bp.renesas.com,m:tu.nguyen.xg@renesas.com,m:fabrizio.castro.jz@renesas.com,m:claudiu.beznea@tuxon.dev,m:linux-can@vger.kernel.org,m:devicetree@vger.kernel.org,m:linux-renesas-soc@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-clk@vger.kernel.org,m:claudiu.beznea.uj@bp.renesas.com,m:krzk@kernel.org,m:conor@kernel.org,m:geert@glider.be,m:magnusdamm@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER(0.00)[claudiu.beznea@tuxon.dev,linux-can@vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-8055-lists,linux-can=lfdr.de,renesas];
	FREEMAIL_TO(0.00)[pengutronix.de,kernel.org,glider.be,gmail.com,baylibre.com,redhat.com,bp.renesas.com,renesas.com];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[claudiu.beznea@tuxon.dev,linux-can@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	R_DKIM_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-can,dt,renesas];
	DBL_BLOCKED_OPENRESOLVER(0.00)[renesas.com:email,tuxon.dev:mid,tuxon.dev:from_mime,vger.kernel.org:from_smtp,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 5AA9271A7CB

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

The bits 1..0 of the Channel n Control Register are named CHMDC (Channel
Mode select). Fix typos in macro names by replacing DMC with MDC.

Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---
 drivers/net/can/rcar/rcar_canfd.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/net/can/rcar/rcar_canfd.c b/drivers/net/can/rcar/rcar_canfd.c
index 4ee108abffb8..879f31c97276 100644
--- a/drivers/net/can/rcar/rcar_canfd.c
+++ b/drivers/net/can/rcar/rcar_canfd.c
@@ -132,9 +132,9 @@
 #define RCANFD_CCTR_BEIE		BIT(8)
 #define RCANFD_CCTR_CSLPR		BIT(2)
 #define RCANFD_CCTR_CHMDC_MASK		(0x3)
-#define RCANFD_CCTR_CHDMC_COPM		(0x0)
-#define RCANFD_CCTR_CHDMC_CRESET	(0x1)
-#define RCANFD_CCTR_CHDMC_CHLT		(0x2)
+#define RCANFD_CCTR_CHMDC_COPM		(0x0)
+#define RCANFD_CCTR_CHMDC_CRESET	(0x1)
+#define RCANFD_CCTR_CHMDC_CHLT		(0x2)
 
 /* RSCFDnCFDCmSTS / RSCFDnCmSTS */
 #define RCANFD_CSTS_COMSTS		BIT(7)
@@ -828,7 +828,7 @@ static int rcar_canfd_reset_controller(struct rcar_canfd_global *gpriv)
 
 		rcar_canfd_update_bit(gpriv->base, RCANFD_CCTR(ch),
 				      RCANFD_CCTR_CHMDC_MASK,
-				      RCANFD_CCTR_CHDMC_CRESET);
+				      RCANFD_CCTR_CHMDC_CRESET);
 
 		/* Ensure Channel reset mode */
 		err = readl_poll_timeout((gpriv->base + RCANFD_CSTS(ch)), sts,
@@ -1504,7 +1504,7 @@ static int rcar_canfd_start(struct net_device *ndev)
 
 	/* Set channel to Operational mode */
 	rcar_canfd_update_bit(priv->base, RCANFD_CCTR(ch),
-			      RCANFD_CCTR_CHMDC_MASK, RCANFD_CCTR_CHDMC_COPM);
+			      RCANFD_CCTR_CHMDC_MASK, RCANFD_CCTR_CHMDC_COPM);
 
 	/* Verify channel mode change */
 	err = readl_poll_timeout((priv->base + RCANFD_CSTS(ch)), sts,
@@ -1578,7 +1578,7 @@ static void rcar_canfd_stop(struct net_device *ndev)
 
 	/* Transition to channel reset mode  */
 	rcar_canfd_update_bit(priv->base, RCANFD_CCTR(ch),
-			      RCANFD_CCTR_CHMDC_MASK, RCANFD_CCTR_CHDMC_CRESET);
+			      RCANFD_CCTR_CHMDC_MASK, RCANFD_CCTR_CHMDC_CRESET);
 
 	/* Check Channel reset mode */
 	err = readl_poll_timeout((priv->base + RCANFD_CSTS(ch)), sts,
-- 
2.43.0


