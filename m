Return-Path: <linux-can+bounces-6985-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +EwYAvYBq2msZQEAu9opvQ
	(envelope-from <linux-can+bounces-6985-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Fri, 06 Mar 2026 17:33:58 +0100
X-Original-To: lists+linux-can@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 96DA7224F97
	for <lists+linux-can@lfdr.de>; Fri, 06 Mar 2026 17:33:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 1EA6030898CB
	for <lists+linux-can@lfdr.de>; Fri,  6 Mar 2026 16:30:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D7843ED5AB;
	Fri,  6 Mar 2026 16:30:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=gaisler.com header.i=@gaisler.com header.b="UXhQEsU5"
X-Original-To: linux-can@vger.kernel.org
Received: from smtp-out3.simply.com (smtp-out3.simply.com [94.231.106.210])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE9973F23BE;
	Fri,  6 Mar 2026 16:29:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=94.231.106.210
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772814605; cv=none; b=D17/vCJugX3pWzdrSTQEgl8p+PYHUJbOj1paQme4cLkKOz0yLbuRp6XaVr7R4xP2PNfRqP9pajqPxyO9rCvfWDmdYzQCuvDnXshDC8BEKklOql/SGENBznncAvewl+TOzQxRVGI1de1cbSS6h2YlM/d7q4kzuh6tuNMwppnKfZ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772814605; c=relaxed/simple;
	bh=igF+hLU1L5ID9WyNspch4RFhzKl9bZvoNEezH3jqiKM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fhnczvgbFgzKF1q6sn8nHN2/H7AZ+bNne0HkaURUnGCB3cCydpHCAW8MeMNajk9lhur59YfVDW9CAp4XmYKyLEzoN+2z2hbhGKa0LRW2RauidY8arW+1rB6OCPj5+kSjhlkuFZhFRfozlKoQ8fGfnlUMaxCobjw+tGo52oYauvc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gaisler.com; spf=pass smtp.mailfrom=gaisler.com; dkim=fail (0-bit key) header.d=gaisler.com header.i=@gaisler.com header.b=UXhQEsU5 reason="key not found in DNS"; arc=none smtp.client-ip=94.231.106.210
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gaisler.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gaisler.com
Received: from localhost (localhost [127.0.0.1])
	by smtp.simply.com (Simply.com) with ESMTP id 4fSBhB20X6z1Fg9L;
	Fri,  6 Mar 2026 17:29:46 +0100 (CET)
Received: from d-5xj5g74.got.gaisler.com.com (h-98-128-223-123.NA.cust.bahnhof.se [98.128.223.123])
	by smtp.simply.com (Simply.com) with ESMTPA id 4fSBhB08flz1DDTQ;
	Fri,  6 Mar 2026 17:29:46 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gaisler.com;
	s=simplycom2; t=1772814586;
	bh=AWhiK64Qe9+qE4eBamGkQQY/DBTVBN3Vw0RtnG6lRe0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=UXhQEsU5O2Y378m1559M/zkxS82zt75xGMauvvIMng8dqZvGRwtPbjFDJ8IwMDOMf
	 bU8RJ6fYqR8ivu3X5qR3B8Or+fBB4slcA/qTMxOJdTIM789p5w09fFkEcHBlEL//IF
	 p12FJGv+S0PdaguGKO+nxMq5Ds/ySvnRs91xz9AC6mE/wPRWUvZoDgZ6f/KxoUvCy5
	 /fzD71tbYTYY/jyVYZ5XxZN2bzpXvXriQdFEEEQR6j3jidcTQ+pNKvlBJgsNkz82Vt
	 t33wnZbrO4HQrUFAh7XHcH2ExC90slw4YVRLEBgCHQ0mivWVmE9pBuHCq/Sich6wju
	 iRcAfgMnCmlUg==
From: Arun Muthusamy <arun.muthusamy@gaisler.com>
To: robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	mkl@pengutronix.de,
	mailhol@kernel.org
Cc: devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-can@vger.kernel.org,
	Arun Muthusamy <arun.muthusamy@gaisler.com>,
	Daniel Hellstrom <daniel@gaisler.com>
Subject: [PATCH v6 06/15] can: grcan: Simplify timing configuration
Date: Fri,  6 Mar 2026 17:29:25 +0100
Message-ID: <20260306162934.22955-7-arun.muthusamy@gaisler.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260306162934.22955-1-arun.muthusamy@gaisler.com>
References: <20260306162934.22955-1-arun.muthusamy@gaisler.com>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 96DA7224F97
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.14 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[gaisler.com : SPF not aligned (relaxed),none];
	HAS_LIST_UNSUB(-0.01)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-6985-lists,linux-can=lfdr.de];
	PRECEDENCE_BULK(0.00)[];
	R_DKIM_PERMFAIL(0.00)[gaisler.com:s=simplycom2];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[gaisler.com:~];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FROM_NEQ_ENVFROM(0.00)[arun.muthusamy@gaisler.com,linux-can@vger.kernel.org];
	NEURAL_HAM(-0.00)[-0.739];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-can,dt];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,gaisler.com:mid,gaisler.com:email]
X-Rspamd-Action: no action

Remove redundant error checks and use FIELD_PREP for bit timing
assignments to simplify the timing configuration

Signed-off-by: Daniel Hellstrom <daniel@gaisler.com>
Signed-off-by: Arun Muthusamy <arun.muthusamy@gaisler.com>
---
 drivers/net/can/grcan.c | 41 +++++++++++++----------------------------
 1 file changed, 13 insertions(+), 28 deletions(-)

diff --git a/drivers/net/can/grcan.c b/drivers/net/can/grcan.c
index 12fd4911add2..4ed0fb1d70b7 100644
--- a/drivers/net/can/grcan.c
+++ b/drivers/net/can/grcan.c
@@ -396,41 +396,26 @@ static const struct can_bittiming_const grcan_bittiming_const = {
 static int grcan_set_bittiming(struct net_device *dev)
 {
 	struct grcan_priv *priv = netdev_priv(dev);
-	struct grcan_registers __iomem *regs = priv->regs;
-	struct can_bittiming *bt = &priv->can.bittiming;
-	u32 timing = 0;
+	struct grcan_registers __iomem *regs;
 	int bpr, rsj, ps1, ps2, scaler;
+	struct can_bittiming *bt;
+	u32 timing = 0;
 
-	/* Should never happen - function will not be called when
-	 * device is up
-	 */
-	if (grcan_read_bits(&regs->ctrl, GRCAN_CTRL_ENABLE))
-		return -EBUSY;
+	regs = priv->regs;
+	bt = &priv->can.bittiming;
 
 	bpr = 0; /* Note bpr and brp are different concepts */
 	rsj = bt->sjw;
 	ps1 = (bt->prop_seg + bt->phase_seg1) - 1; /* tseg1 - 1 */
 	ps2 = bt->phase_seg2;
-	scaler = (bt->brp - 1);
-	netdev_dbg(dev, "Request for BPR=%d, RSJ=%d, PS1=%d, PS2=%d, SCALER=%d",
-		   bpr, rsj, ps1, ps2, scaler);
-	if (!(ps1 > ps2)) {
-		netdev_err(dev, "PS1 > PS2 must hold: PS1=%d, PS2=%d\n",
-			   ps1, ps2);
-		return -EINVAL;
-	}
-	if (!(ps2 >= rsj)) {
-		netdev_err(dev, "PS2 >= RSJ must hold: PS2=%d, RSJ=%d\n",
-			   ps2, rsj);
-		return -EINVAL;
-	}
-
-	timing |= (bpr << GRCAN_CONF_BPR_BIT) & GRCAN_CONF_BPR;
-	timing |= (rsj << GRCAN_CONF_RSJ_BIT) & GRCAN_CONF_RSJ;
-	timing |= (ps1 << GRCAN_CONF_PS1_BIT) & GRCAN_CONF_PS1;
-	timing |= (ps2 << GRCAN_CONF_PS2_BIT) & GRCAN_CONF_PS2;
-	timing |= (scaler << GRCAN_CONF_SCALER_BIT) & GRCAN_CONF_SCALER;
-	netdev_info(dev, "setting timing=0x%x\n", timing);
+	scaler = bt->brp - 1;
+
+	timing |= FIELD_PREP(GRCAN_CONF_BPR, bpr);
+	timing |= FIELD_PREP(GRCAN_CONF_RSJ, rsj);
+	timing |= FIELD_PREP(GRCAN_CONF_PS1, ps1);
+	timing |= FIELD_PREP(GRCAN_CONF_PS2, ps2);
+	timing |= FIELD_PREP(GRCAN_CONF_SCALER, scaler);
+	netdev_dbg(dev, "setting timing=0x%x\n", timing);
 	grcan_write_bits(&regs->conf, timing, GRCAN_CONF_TIMING);
 
 	return 0;
-- 
2.51.0


