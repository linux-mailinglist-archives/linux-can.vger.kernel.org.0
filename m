Return-Path: <linux-can+bounces-3855-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 699C2ADE6B5
	for <lists+linux-can@lfdr.de>; Wed, 18 Jun 2025 11:25:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 534E917364C
	for <lists+linux-can@lfdr.de>; Wed, 18 Jun 2025 09:24:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8DBE283FEC;
	Wed, 18 Jun 2025 09:23:44 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DACA4DF59
	for <linux-can@vger.kernel.org>; Wed, 18 Jun 2025 09:23:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750238624; cv=none; b=kzVwFzOiPsw6xm8+8vlx9W1m9aVRgVp2K/wMyCLx6XCq5MdpdAKKbwiK2UnqGPGgCxiDcdOFrzkqwTHArvRzgYSji9TDTheLWVpOgTnYUmHDBmbqSg9X/R6cPR2BpRnOSarQucGhWJNsd8fnOgyCLTAsMhKM1Z+YfgWAQ2BvffI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750238624; c=relaxed/simple;
	bh=C2qfuKdSFtujeZh5Va+imIU38G/jvWgULB2U7OEiwcg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Vq8JYAs7w2rdGE43W2PWmDWqjsU5hznsd7QTGBLuh1Jas8INkkjlLoX0NJirPqPzW6OE936ldN6x69PAO+przZyc+9GTI1Pm//bqj4blfkF0xEZpxNbjj8FNrxWVsuSG02McSgi7eqEZD7IAEejhBh5zGvzZ+lhmPUZO6ZPq6NQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1uRp1B-0006XJ-6F
	for linux-can@vger.kernel.org; Wed, 18 Jun 2025 11:23:41 +0200
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1uRp1A-00476y-2E
	for linux-can@vger.kernel.org;
	Wed, 18 Jun 2025 11:23:40 +0200
Received: from dspam.blackshift.org (localhost [127.0.0.1])
	by bjornoya.blackshift.org (Postfix) with SMTP id 5DCD242B298
	for <linux-can@vger.kernel.org>; Wed, 18 Jun 2025 09:23:40 +0000 (UTC)
Received: from hardanger.blackshift.org (unknown [172.20.34.65])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by bjornoya.blackshift.org (Postfix) with ESMTPS id DA3A142B271;
	Wed, 18 Jun 2025 09:23:38 +0000 (UTC)
Received: from blackshift.org (localhost [::1])
	by hardanger.blackshift.org (OpenSMTPD) with ESMTP id 5f63e6f4;
	Wed, 18 Jun 2025 09:23:37 +0000 (UTC)
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	linux-can@vger.kernel.org,
	kernel@pengutronix.de,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Vincent Mailhol <mailhol.vincent@wanadoo.fr>,
	Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH net-next 02/10] can: rcar_canfd: Remove bittiming debug prints
Date: Wed, 18 Jun 2025 11:19:56 +0200
Message-ID: <20250618092336.2175168-3-mkl@pengutronix.de>
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

There is no need to have debug code to print the bittiming values, as
the user can get all values through the netlink interface.

Suggested-by: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Reviewed-by: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Link: https://patch.msgid.link/a8b9f2c8938dc5e63b8faf1d0cdc91dadc12117e.1749655315.git.geert+renesas@glider.be
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/rcar/rcar_canfd.c | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/drivers/net/can/rcar/rcar_canfd.c b/drivers/net/can/rcar/rcar_canfd.c
index 2174c9667cab..b353168f75f2 100644
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
2.47.2



