Return-Path: <linux-can+bounces-6260-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0Ma9MgkXcmksawAAu9opvQ
	(envelope-from <linux-can+bounces-6260-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Thu, 22 Jan 2026 13:24:41 +0100
X-Original-To: lists+linux-can@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F3BE6694B
	for <lists+linux-can@lfdr.de>; Thu, 22 Jan 2026 13:24:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 1C89B904FBB
	for <lists+linux-can@lfdr.de>; Thu, 22 Jan 2026 12:12:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 091F943E9D3;
	Thu, 22 Jan 2026 12:11:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=gaisler.com header.i=@gaisler.com header.b="JbeGnaqt"
X-Original-To: linux-can@vger.kernel.org
Received: from smtp-out3.simply.com (smtp-out3.simply.com [94.231.106.210])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45C4331AF1F;
	Thu, 22 Jan 2026 12:10:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=94.231.106.210
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769083859; cv=none; b=B+Yv4mEP62Ph6QfpV4+TeOnaaFlb8Qy7qHMOeJCohOm78JVqqbnB4h3aDxCnZgaqqJTlLL96yUXfx9hrIOPIeIXSR8XhYJelELC2x8ImXDK+rwlp+J85JYq8WjFhEsOFDp29VuhBGo/rkyrQaUhRjGq+K+6ZQN5Mcs0mUgVNocM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769083859; c=relaxed/simple;
	bh=0n307RI2osGkwAnwHOdE+jJLyTXApuRW/XscUPfHsXI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JlFnyCSvs+v2hZcAVTRJo6Y4IKq5/M8cZEgydTiKcBa5rdXO1JmsdhjCkmG3HkegZT6Iq7vodcIFiN8UTMH3bFvypz0AEKwJjtbE0OjaEeDnSVWEZsfWoddH9Gvc0O1iTENWKNSgVr7HDDVsTW1Gnt1iemeVkyqEoB4oDpttSyM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gaisler.com; spf=pass smtp.mailfrom=gaisler.com; dkim=fail (0-bit key) header.d=gaisler.com header.i=@gaisler.com header.b=JbeGnaqt reason="key not found in DNS"; arc=none smtp.client-ip=94.231.106.210
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gaisler.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gaisler.com
Received: from localhost (localhost [127.0.0.1])
	by smtp.simply.com (Simply.com) with ESMTP id 4dxfzC5YMdz1Fgcr;
	Thu, 22 Jan 2026 13:10:47 +0100 (CET)
Received: from d-5xj5g74.got.gaisler.com.com (h-98-128-223-123.NA.cust.bahnhof.se [98.128.223.123])
	by smtp.simply.com (Simply.com) with ESMTPA id 4dxfzC06VJz1DDC3;
	Thu, 22 Jan 2026 13:10:46 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gaisler.com;
	s=simplycom2; t=1769083847;
	bh=EMkpJcbf388KKgy3H9YvNKkEn9x2GMeSt2rV8zMvFWg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=JbeGnaqtxaAb/xcv6B06Sh2OBidUzm2VXi7PO13rhCLg7JADZ5um9XnEko9B1COzR
	 KcbtEzksiVntGVIXhmcIfeUcf7uqElV/+V+Uw9KHFXRpTarm5AAGryAT/H1KewDJBf
	 Ach4EGB+Pu1r2Zvmd0qcGEYsmSFrFpriVvHrA6hDFiag+5mtOwfZbdEk4nwWRY93w9
	 ytKJ6rKt5jWwjMtMuMIhLkRYqF0D64s8cwGF5613Cy+p3J4/bXK0k++fHmSLX7Vmjm
	 GW+ahqYFRWOjJ6GY2jqa9RPzwQylDYyxCBLUMQiqzYEe6qaQ8stJ2ULw82O2w/LqCk
	 5i3/HW/I/nbgA==
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
Subject: [PATCH v3 06/15] can: grcan: Simplify timing configuration
Date: Thu, 22 Jan 2026 13:10:29 +0100
Message-ID: <20260122121038.7910-7-arun.muthusamy@gaisler.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260122121038.7910-1-arun.muthusamy@gaisler.com>
References: <20260122121038.7910-1-arun.muthusamy@gaisler.com>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.34 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[gaisler.com : No valid SPF,none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	TAGGED_FROM(0.00)[bounces-6260-lists,linux-can=lfdr.de];
	PRECEDENCE_BULK(0.00)[];
	R_DKIM_PERMFAIL(0.00)[gaisler.com:s=simplycom2];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[gaisler.com:~];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:7979, ipnet:2605:f480::/32, country:US];
	RCVD_COUNT_FIVE(0.00)[5];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	FROM_NEQ_ENVFROM(0.00)[arun.muthusamy@gaisler.com,linux-can@vger.kernel.org];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-can,dt];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[gaisler.com:mid,gaisler.com:email,dfw.mirrors.kernel.org:helo,dfw.mirrors.kernel.org:rdns]
X-Rspamd-Queue-Id: 4F3BE6694B
X-Rspamd-Action: no action

Remove redundant error checks and use FIELD_PREP for bit timing
assignments to simplify the timing configuration

Signed-off-by: Arun Muthusamy <arun.muthusamy@gaisler.com>
Signed-off-by: Daniel Hellstrom <daniel@gaisler.com>
---
 drivers/net/can/grcan.c | 41 +++++++++++++----------------------------
 1 file changed, 13 insertions(+), 28 deletions(-)

diff --git a/drivers/net/can/grcan.c b/drivers/net/can/grcan.c
index f34ca558fa5d..5a63d0a0365f 100644
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


