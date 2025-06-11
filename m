Return-Path: <linux-can+bounces-3817-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9680FAD5ABB
	for <lists+linux-can@lfdr.de>; Wed, 11 Jun 2025 17:38:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A133B3A2ECE
	for <lists+linux-can@lfdr.de>; Wed, 11 Jun 2025 15:37:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CFBA1D7E57;
	Wed, 11 Jun 2025 15:38:05 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 010441C6FF6;
	Wed, 11 Jun 2025 15:38:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749656285; cv=none; b=o96gaaWFG1XwM4GjbDAuv3/AfKlraJYvLgo3aYI1v9R95xjUhlsFxhQmC/YJOkOrSehN9M6PjAndytqH/ukfYNXkHGWbQZGHmE1tchk8Rh+vIDzdAKPQqixaVMzs3m6MVEYu/rT89/dsNgZ62N06iGEB1kWNaFm8JbJycJJaBpk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749656285; c=relaxed/simple;
	bh=aNzNOZESmXL402egjCsHYPhxA1KKGhNpr98B6r2a20o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=angSBg644BSdnVyL/C2VC89Uyvwp43nM3Pw4FiFITsaL8RhaqPluTT9kPs5KFo21AXp5bOxMwQuquIyBi41GWKcoTOeuSl2rA+PsMiqbJm1w5AlBnQZ+RQqRPR95319Ha6/w6GzsIsRdZKbC8GT6WTCyUq4+JOdgCS34iFjrAMc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C7DDEC4CEE3;
	Wed, 11 Jun 2025 15:38:02 +0000 (UTC)
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
Subject: [PATCH v2 07/10] can: rcar_canfd: Rename rcar_canfd_setrnc() to rcar_canfd_set_rnc()
Date: Wed, 11 Jun 2025 17:37:36 +0200
Message-ID: <9fdc2584ce27b2784ecea76390d2a81eab289d0d.1749655315.git.geert+renesas@glider.be>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1749655315.git.geert+renesas@glider.be>
References: <cover.1749655315.git.geert+renesas@glider.be>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Insert an underscore in the function's name, for consistency with other
getter and setter helper functions.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
v2:
  - New.
---
 drivers/net/can/rcar/rcar_canfd.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/net/can/rcar/rcar_canfd.c b/drivers/net/can/rcar/rcar_canfd.c
index 8baf8a928da757f2..c292694ae4d27ac4 100644
--- a/drivers/net/can/rcar/rcar_canfd.c
+++ b/drivers/net/can/rcar/rcar_canfd.c
@@ -830,8 +830,8 @@ static void rcar_canfd_tx_failure_cleanup(struct net_device *ndev)
 		can_free_echo_skb(ndev, i, NULL);
 }
 
-static void rcar_canfd_setrnc(struct rcar_canfd_global *gpriv, unsigned int ch,
-			      unsigned int num_rules)
+static void rcar_canfd_set_rnc(struct rcar_canfd_global *gpriv, unsigned int ch,
+			       unsigned int num_rules)
 {
 	unsigned int rnc_stride = 32 / gpriv->info->rnc_field_width;
 	unsigned int shift = 32 - (ch % rnc_stride + 1) * gpriv->info->rnc_field_width;
@@ -960,7 +960,7 @@ static void rcar_canfd_configure_afl_rules(struct rcar_canfd_global *gpriv,
 			    RCANFD_GAFLECTR_AFLDAE));
 
 	/* Write number of rules for channel */
-	rcar_canfd_setrnc(gpriv, ch, num_rules);
+	rcar_canfd_set_rnc(gpriv, ch, num_rules);
 	if (gpriv->info->shared_can_regs)
 		offset = RCANFD_GEN4_GAFL_OFFSET;
 	else if (gpriv->fdmode)
-- 
2.43.0


