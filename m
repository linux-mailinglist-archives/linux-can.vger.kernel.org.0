Return-Path: <linux-can+bounces-3812-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 920DCAD5AD7
	for <lists+linux-can@lfdr.de>; Wed, 11 Jun 2025 17:42:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3842B1889593
	for <lists+linux-can@lfdr.de>; Wed, 11 Jun 2025 15:38:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C0FC1CBEAA;
	Wed, 11 Jun 2025 15:37:53 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FA631B0412;
	Wed, 11 Jun 2025 15:37:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749656273; cv=none; b=MOdiqt8jmQF607hWm1FBGlV4BaGQ/oTSmkmTxs3/6H2/QRYOTRvrEf4Niavhb2HIjMH7+P9nqOrSC+M+wVZmoF9/ORzOmxLjYvoWqKl5LZddoAnyqMwQKkju+fNCayI8GTVXg0n9Ms/osVCi2woSB21pMoZJWzCvLZcmfRj1SL0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749656273; c=relaxed/simple;
	bh=ZO1ks7oamK+0RCT5QpBlfmv4bwYIcLZ+4TrYkXqk2GE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jAtWjnBoH1kR8/1IO5wMmAAnG9cPGLfgVtzPfVnIgvYZqB4CPFufg1KwKrytvnX7xCr4AtBZQoFB7bzAs/3t34xbNNU8H9y8lIuAkRvuVtP6VH3iXBX8Tu6li6lA2Ye3RFVSI8c4SI6XU7HrQg+Xdh8Sn8hE3FwvSweIqvX77jc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 79BA0C4CEE3;
	Wed, 11 Jun 2025 15:37:51 +0000 (UTC)
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
Subject: [PATCH v2 02/10] can: rcar_canfd: Remove bittiming debug prints
Date: Wed, 11 Jun 2025 17:37:31 +0200
Message-ID: <a8b9f2c8938dc5e63b8faf1d0cdc91dadc12117e.1749655315.git.geert+renesas@glider.be>
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

There is no need to have debug code to print the bittiming values, as
the user can get all values through the netlink interface.

Suggested-by: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
v2:
  - New.
---
 drivers/net/can/rcar/rcar_canfd.c | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/drivers/net/can/rcar/rcar_canfd.c b/drivers/net/can/rcar/rcar_canfd.c
index 2174c9667cabce54..b353168f75f28565 100644
--- a/drivers/net/can/rcar/rcar_canfd.c
+++ b/drivers/net/can/rcar/rcar_canfd.c
@@ -1458,8 +1458,6 @@ static void rcar_canfd_set_bittiming(struct net_device *ndev)
 		       RCANFD_NCFG_NSJW(gpriv, sjw) | RCANFD_NCFG_NTSEG2(gpriv, tseg2));
 
 		rcar_canfd_write(priv->base, RCANFD_CCFG(ch), cfg);
-		netdev_dbg(priv->ndev, "nrate: brp %u, sjw %u, tseg1 %u, tseg2 %u\n",
-			   brp, sjw, tseg1, tseg2);
 
 		/* Data bit timing settings */
 		brp = dbt->brp - 1;
@@ -1471,8 +1469,6 @@ static void rcar_canfd_set_bittiming(struct net_device *ndev)
 		       RCANFD_DCFG_DSJW(gpriv, sjw) | RCANFD_DCFG_DTSEG2(gpriv, tseg2));
 
 		rcar_canfd_write(priv->base, RCANFD_F_DCFG(gpriv, ch), cfg);
-		netdev_dbg(priv->ndev, "drate: brp %u, sjw %u, tseg1 %u, tseg2 %u\n",
-			   brp, sjw, tseg1, tseg2);
 	} else {
 		/* Classical CAN only mode */
 		if (gpriv->info->shared_can_regs) {
@@ -1488,9 +1484,6 @@ static void rcar_canfd_set_bittiming(struct net_device *ndev)
 		}
 
 		rcar_canfd_write(priv->base, RCANFD_CCFG(ch), cfg);
-		netdev_dbg(priv->ndev,
-			   "rate: brp %u, sjw %u, tseg1 %u, tseg2 %u\n",
-			   brp, sjw, tseg1, tseg2);
 	}
 }
 
-- 
2.43.0


