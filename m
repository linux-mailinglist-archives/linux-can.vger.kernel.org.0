Return-Path: <linux-can+bounces-903-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E3CCE91CC76
	for <lists+linux-can@lfdr.de>; Sat, 29 Jun 2024 13:40:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 816B2B2105A
	for <lists+linux-can@lfdr.de>; Sat, 29 Jun 2024 11:40:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68C2A58235;
	Sat, 29 Jun 2024 11:40:27 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B25B14F606
	for <linux-can@vger.kernel.org>; Sat, 29 Jun 2024 11:40:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719661227; cv=none; b=OxDFZR/uvpYtUKLGFXYWQy+4nQAPKFr8x9bqjBYpyGhG+EpXEFCCfpNetedzQuvA+VOnHq4hWu3gXViiHACzYTK4O3V9/pvW4LG58y6SJtmcje7nWVjjIT1uvN8ctjQ2I4/PmmN7xDrlUMQtJuxBOC6HQKr5P8BUmDh4DXpEus0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719661227; c=relaxed/simple;
	bh=RqiBkh6sIXLxbQkYiSB8ly5wAaXJbNvqux0/EASPrEg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=W1H648MFRyuLVYUp0Q81fVWXUlGXabntwwkrHrOQxHYaxPvNH/+HxHrooFr+1/3NomeyA35r+tN2CfysgasVs9McU4IdyD6IUR6wrVJFWwp8vvueeFO2NXiRiJTrBpixoTg2lIWL/pBGKD9GdVydrzp24XhMjar4V03Tx/zA0MY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1sNWRL-00035X-Ka
	for linux-can@vger.kernel.org; Sat, 29 Jun 2024 13:40:23 +0200
Received: from [2a0a:edc0:0:b01:1d::7b] (helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <mkl@pengutronix.de>)
	id 1sNWRK-005pYU-1P
	for linux-can@vger.kernel.org; Sat, 29 Jun 2024 13:40:22 +0200
Received: from dspam.blackshift.org (localhost [127.0.0.1])
	by bjornoya.blackshift.org (Postfix) with SMTP id B4F902F6463
	for <linux-can@vger.kernel.org>; Sat, 29 Jun 2024 11:40:21 +0000 (UTC)
Received: from hardanger.blackshift.org (unknown [172.20.34.65])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by bjornoya.blackshift.org (Postfix) with ESMTPS id D52D32F6434;
	Sat, 29 Jun 2024 11:40:19 +0000 (UTC)
Received: from blackshift.org (localhost [::1])
	by hardanger.blackshift.org (OpenSMTPD) with ESMTP id e5217d75;
	Sat, 29 Jun 2024 11:40:18 +0000 (UTC)
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	linux-can@vger.kernel.org,
	kernel@pengutronix.de,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Wolfram Sang <wsa+renesas@sang-engineering.com>,
	Vincent Mailhol <mailhol.vincent@wanadoo.fr>,
	Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH net-next 03/14] can: rcar_canfd: Remove superfluous parentheses in address calculations
Date: Sat, 29 Jun 2024 13:36:17 +0200
Message-ID: <20240629114017.1080160-4-mkl@pengutronix.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240629114017.1080160-1-mkl@pengutronix.de>
References: <20240629114017.1080160-1-mkl@pengutronix.de>
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

There is no need to wrap simple variables or multiplications inside
parentheses.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Reviewed-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
Reviewed-by: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Link: https://lore.kernel.org/all/b5aee80895fa029070fd37d1d837cf1c0ecb52dc.1716973640.git.geert+renesas@glider.be
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/rcar/rcar_canfd.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/net/can/rcar/rcar_canfd.c b/drivers/net/can/rcar/rcar_canfd.c
index c2c1c47bcc7a..c919668bbe7a 100644
--- a/drivers/net/can/rcar/rcar_canfd.c
+++ b/drivers/net/can/rcar/rcar_canfd.c
@@ -627,28 +627,28 @@ static inline void rcar_canfd_update(u32 mask, u32 val, u32 __iomem *reg)
 
 static inline u32 rcar_canfd_read(void __iomem *base, u32 offset)
 {
-	return readl(base + (offset));
+	return readl(base + offset);
 }
 
 static inline void rcar_canfd_write(void __iomem *base, u32 offset, u32 val)
 {
-	writel(val, base + (offset));
+	writel(val, base + offset);
 }
 
 static void rcar_canfd_set_bit(void __iomem *base, u32 reg, u32 val)
 {
-	rcar_canfd_update(val, val, base + (reg));
+	rcar_canfd_update(val, val, base + reg);
 }
 
 static void rcar_canfd_clear_bit(void __iomem *base, u32 reg, u32 val)
 {
-	rcar_canfd_update(val, 0, base + (reg));
+	rcar_canfd_update(val, 0, base + reg);
 }
 
 static void rcar_canfd_update_bit(void __iomem *base, u32 reg,
 				  u32 mask, u32 val)
 {
-	rcar_canfd_update(mask, val, base + (reg));
+	rcar_canfd_update(mask, val, base + reg);
 }
 
 static void rcar_canfd_get_data(struct rcar_canfd_channel *priv,
@@ -659,7 +659,7 @@ static void rcar_canfd_get_data(struct rcar_canfd_channel *priv,
 	lwords = DIV_ROUND_UP(cf->len, sizeof(u32));
 	for (i = 0; i < lwords; i++)
 		*((u32 *)cf->data + i) =
-			rcar_canfd_read(priv->base, off + (i * sizeof(u32)));
+			rcar_canfd_read(priv->base, off + i * sizeof(u32));
 }
 
 static void rcar_canfd_put_data(struct rcar_canfd_channel *priv,
@@ -669,7 +669,7 @@ static void rcar_canfd_put_data(struct rcar_canfd_channel *priv,
 
 	lwords = DIV_ROUND_UP(cf->len, sizeof(u32));
 	for (i = 0; i < lwords; i++)
-		rcar_canfd_write(priv->base, off + (i * sizeof(u32)),
+		rcar_canfd_write(priv->base, off + i * sizeof(u32),
 				 *((u32 *)cf->data + i));
 }
 
-- 
2.43.0



