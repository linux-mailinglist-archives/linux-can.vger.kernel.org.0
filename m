Return-Path: <linux-can+bounces-3746-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 877E6ACADA6
	for <lists+linux-can@lfdr.de>; Mon,  2 Jun 2025 13:55:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AB98A1652E2
	for <lists+linux-can@lfdr.de>; Mon,  2 Jun 2025 11:54:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 820001F4E3B;
	Mon,  2 Jun 2025 11:54:49 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6600814F70;
	Mon,  2 Jun 2025 11:54:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748865289; cv=none; b=UChc8cYQ8F2esi6/5Vx9fX0NTAmWOxaeROYmVlWVrEv2v9YYgqYaLTCSFYsP4zNPfUhOzQc2Nf4CmTqlKLp6f/oEycgJ9H+KZ6tyu9mLBRco5NhmGJXLtrfZV8RYVshJoKg8NoL34yVid3Y2nnVmO/MXf7sf558tWYDf/AwNGN8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748865289; c=relaxed/simple;
	bh=0TTNneyfRwPPG0j5La+aCDyEMgfKSv3xWu77MZUFXOw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TFMmQBthIUhmDhWG+knm7gBvuGrY5HMMIwUjwfsd47pWqSIyK9HFqaulAOZJGhQI409sbHnngPczWlBBFv0/zXz/z+DDEhF5uT8llmT2f/UCEn9iSqvMoJuWHhuSbieuXA0zvfW95wCeE9AcZoYKhLje158kEV1ulCZcYPTvde0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E1A4EC4CEED;
	Mon,  2 Jun 2025 11:54:46 +0000 (UTC)
From: Geert Uytterhoeven <geert+renesas@glider.be>
To: Marc Kleine-Budde <mkl@pengutronix.de>,
	Vincent Mailhol <mailhol.vincent@wanadoo.fr>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc: Kazuhiro Takagi <kazuhiro.takagi.hh@hitachi-solutions.com>,
	Duy Nguyen <duy.nguyen.rh@renesas.com>,
	linux-can@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH 5/9] can: rcar_canfd: Simplify data access in rcar_canfd_{ge,pu}t_data()
Date: Mon,  2 Jun 2025 13:54:24 +0200
Message-ID: <0a4cb41cfa0ca829f6782d37d525abbb3e0ef518.1748863848.git.geert+renesas@glider.be>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1748863848.git.geert+renesas@glider.be>
References: <cover.1748863848.git.geert+renesas@glider.be>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Replace the repeated casts, pointer additions, and pointer dereferences
by array accesses to improve readability.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 drivers/net/can/rcar/rcar_canfd.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/net/can/rcar/rcar_canfd.c b/drivers/net/can/rcar/rcar_canfd.c
index 94b3effd423acf77..0cad3c198e58e494 100644
--- a/drivers/net/can/rcar/rcar_canfd.c
+++ b/drivers/net/can/rcar/rcar_canfd.c
@@ -781,23 +781,23 @@ static void rcar_canfd_update_bit(void __iomem *base, u32 reg,
 static void rcar_canfd_get_data(struct rcar_canfd_channel *priv,
 				struct canfd_frame *cf, u32 off)
 {
+	u32 *data = (u32 *)cf->data;
 	u32 i, lwords;
 
 	lwords = DIV_ROUND_UP(cf->len, sizeof(u32));
 	for (i = 0; i < lwords; i++)
-		*((u32 *)cf->data + i) =
-			rcar_canfd_read(priv->base, off + i * sizeof(u32));
+		data[i] = rcar_canfd_read(priv->base, off + i * sizeof(u32));
 }
 
 static void rcar_canfd_put_data(struct rcar_canfd_channel *priv,
 				struct canfd_frame *cf, u32 off)
 {
+	const u32 *data = (u32 *)cf->data;
 	u32 i, lwords;
 
 	lwords = DIV_ROUND_UP(cf->len, sizeof(u32));
 	for (i = 0; i < lwords; i++)
-		rcar_canfd_write(priv->base, off + i * sizeof(u32),
-				 *((u32 *)cf->data + i));
+		rcar_canfd_write(priv->base, off + i * sizeof(u32), data[i]);
 }
 
 static void rcar_canfd_tx_failure_cleanup(struct net_device *ndev)
-- 
2.43.0


