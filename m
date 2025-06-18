Return-Path: <linux-can+bounces-3860-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CF477ADE6C0
	for <lists+linux-can@lfdr.de>; Wed, 18 Jun 2025 11:25:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4736617ADF3
	for <lists+linux-can@lfdr.de>; Wed, 18 Jun 2025 09:25:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8374628507E;
	Wed, 18 Jun 2025 09:23:48 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5330285044
	for <linux-can@vger.kernel.org>; Wed, 18 Jun 2025 09:23:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750238628; cv=none; b=dx9f42sDC9rgaW8Vl/DcVj0lR+p3qV5Tp6v2+5FCA5NhysMneMdZsBhzLGfuTWS8Arg+HpjLI+RWZqv5zX/Pu8ObB5/3umYAp0zcCLwY37UH0oUcOkzdqvF97pMlmBIVne+scPeZNs9YxYc+o1cZvdZrws4L5KKjT4vjUGpRPSw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750238628; c=relaxed/simple;
	bh=GzGR9FAsgMGPxwdjJcPaHiC/kkUlytMjamAq0np+uTc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=W6lvIVShhhXDkC6R8zNbvddIw/QV6ME9us9kvu1Tjs0p2MbSVWEuh/2erxwZaEKjXLR8zSA3ep1aOEewX8Kog8SiVNzlsfyJSGG3d+aLOeylk5Fu5wG1DwzuaQWxp6e/ey+6L+vNsjRj14BJM8BpVIPaIRpBDtTKF7jd+fFeImk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1uRp1D-0006dv-UZ
	for linux-can@vger.kernel.org; Wed, 18 Jun 2025 11:23:43 +0200
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1uRp1C-00479i-2D
	for linux-can@vger.kernel.org;
	Wed, 18 Jun 2025 11:23:42 +0200
Received: from dspam.blackshift.org (localhost [127.0.0.1])
	by bjornoya.blackshift.org (Postfix) with SMTP id 5B41C42B2C6
	for <linux-can@vger.kernel.org>; Wed, 18 Jun 2025 09:23:42 +0000 (UTC)
Received: from hardanger.blackshift.org (unknown [172.20.34.65])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by bjornoya.blackshift.org (Postfix) with ESMTPS id 7737542B280;
	Wed, 18 Jun 2025 09:23:39 +0000 (UTC)
Received: from blackshift.org (localhost [::1])
	by hardanger.blackshift.org (OpenSMTPD) with ESMTP id f1e0a5e3;
	Wed, 18 Jun 2025 09:23:38 +0000 (UTC)
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	linux-can@vger.kernel.org,
	kernel@pengutronix.de,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Vincent Mailhol <mailhol.vincent@wanadoo.fr>,
	Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH net-next 08/10] can: rcar_canfd: Share config code in rcar_canfd_set_bittiming()
Date: Wed, 18 Jun 2025 11:20:02 +0200
Message-ID: <20250618092336.2175168-9-mkl@pengutronix.de>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250618092336.2175168-1-mkl@pengutronix.de>
References: <20250618092336.2175168-1-mkl@pengutronix.de>
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

From: Geert Uytterhoeven <geert+renesas@glider.be>

The configuration register format for nominal bit timings in CAN-FD mode
and the format for bit timings in CAN mode on CAN-FD controllers with
shared Classical CAN registers are the same.

Restructure the code to make this clear, also reducing kernel size by 80
bytes.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Reviewed-by: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Link: https://patch.msgid.link/b7643a3c49777989d02145a85b85cf773ec2123f.1749655315.git.geert+renesas@glider.be
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/rcar/rcar_canfd.c | 25 +++++++------------------
 1 file changed, 7 insertions(+), 18 deletions(-)

diff --git a/drivers/net/can/rcar/rcar_canfd.c b/drivers/net/can/rcar/rcar_canfd.c
index c292694ae4d2..9ee49ef57e4f 100644
--- a/drivers/net/can/rcar/rcar_canfd.c
+++ b/drivers/net/can/rcar/rcar_canfd.c
@@ -1474,13 +1474,17 @@ static void rcar_canfd_set_bittiming(struct net_device *ndev)
 	tseg1 = bt->prop_seg + bt->phase_seg1 - 1;
 	tseg2 = bt->phase_seg2 - 1;
 
-	if (priv->can.ctrlmode & CAN_CTRLMODE_FD) {
-		/* CAN FD only mode */
+	if ((priv->can.ctrlmode & CAN_CTRLMODE_FD) || gpriv->info->shared_can_regs) {
 		cfg = (RCANFD_NCFG_NTSEG1(gpriv, tseg1) | RCANFD_NCFG_NBRP(brp) |
 		       RCANFD_NCFG_NSJW(gpriv, sjw) | RCANFD_NCFG_NTSEG2(gpriv, tseg2));
+	} else {
+		cfg = (RCANFD_CFG_TSEG1(tseg1) | RCANFD_CFG_BRP(brp) |
+		       RCANFD_CFG_SJW(sjw) | RCANFD_CFG_TSEG2(tseg2));
+	}
 
-		rcar_canfd_write(priv->base, RCANFD_CCFG(ch), cfg);
+	rcar_canfd_write(priv->base, RCANFD_CCFG(ch), cfg);
 
+	if (priv->can.ctrlmode & CAN_CTRLMODE_FD) {
 		/* Data bit timing settings */
 		brp = dbt->brp - 1;
 		sjw = dbt->sjw - 1;
@@ -1491,21 +1495,6 @@ static void rcar_canfd_set_bittiming(struct net_device *ndev)
 		       RCANFD_DCFG_DSJW(gpriv, sjw) | RCANFD_DCFG_DTSEG2(gpriv, tseg2));
 
 		rcar_canfd_write(priv->base, rcar_canfd_f_dcfg(gpriv, ch), cfg);
-	} else {
-		/* Classical CAN only mode */
-		if (gpriv->info->shared_can_regs) {
-			cfg = (RCANFD_NCFG_NTSEG1(gpriv, tseg1) |
-			       RCANFD_NCFG_NBRP(brp) |
-			       RCANFD_NCFG_NSJW(gpriv, sjw) |
-			       RCANFD_NCFG_NTSEG2(gpriv, tseg2));
-		} else {
-			cfg = (RCANFD_CFG_TSEG1(tseg1) |
-			       RCANFD_CFG_BRP(brp) |
-			       RCANFD_CFG_SJW(sjw) |
-			       RCANFD_CFG_TSEG2(tseg2));
-		}
-
-		rcar_canfd_write(priv->base, RCANFD_CCFG(ch), cfg);
 	}
 }
 
-- 
2.47.2



