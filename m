Return-Path: <linux-can+bounces-3963-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 15075B0198A
	for <lists+linux-can@lfdr.de>; Fri, 11 Jul 2025 12:17:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6E0004A043F
	for <lists+linux-can@lfdr.de>; Fri, 11 Jul 2025 10:17:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41F501D799D;
	Fri, 11 Jul 2025 10:17:14 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A8CC6BFCE
	for <linux-can@vger.kernel.org>; Fri, 11 Jul 2025 10:17:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752229034; cv=none; b=YdVRZ0d+TJIDMal+vQm5PcXkgRMpBmMCDbnXhyjShPzIWzBkrNmnz0JDrRZfRup/BeJbPUpvognpfRLG0hxLPQQFRFGL81e5bN+x75Q5/gmV9mB7STPBQNu96criy2PaHr3IEpHcTlpTNteYlSZZJ9W5kYn9OJ9MWnwLiwymTZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752229034; c=relaxed/simple;
	bh=dABLekjmsLwp9rq1EMP0lOJ5/WX6RS+zYrVAxO+R6zc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=g849cOoDUGd1des2mTGx7+0uh81tnI2cHxaegA1MX63xgEyBoWlerkUUK/brgWCrNL8bJUZzpYQXnQuTIddAtr4tuqEvpMxTloKoHAPyQNytPqzI2E1r4S7wdc8g3uIgUJ5o4OzOnEUXzC+PvDe94AoYxbo6BMVYGvAnyy4XeHY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1uaAoY-00040C-RU
	for linux-can@vger.kernel.org; Fri, 11 Jul 2025 12:17:10 +0200
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1uaAoY-007uAR-26
	for linux-can@vger.kernel.org;
	Fri, 11 Jul 2025 12:17:10 +0200
Received: from dspam.blackshift.org (localhost [127.0.0.1])
	by bjornoya.blackshift.org (Postfix) with SMTP id 57FC943C7E9
	for <linux-can@vger.kernel.org>; Fri, 11 Jul 2025 10:17:10 +0000 (UTC)
Received: from hardanger.blackshift.org (unknown [172.20.34.65])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by bjornoya.blackshift.org (Postfix) with ESMTPS id B5FF643C7D7;
	Fri, 11 Jul 2025 10:17:08 +0000 (UTC)
Received: from blackshift.org (localhost [::1])
	by hardanger.blackshift.org (OpenSMTPD) with ESMTP id 1cfd3dbb;
	Fri, 11 Jul 2025 10:17:07 +0000 (UTC)
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	linux-can@vger.kernel.org,
	kernel@pengutronix.de,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH net-next 1/2] can: rcar_can: Convert to DEFINE_SIMPLE_DEV_PM_OPS()
Date: Fri, 11 Jul 2025 12:15:08 +0200
Message-ID: <20250711101706.2822687-2-mkl@pengutronix.de>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250711101706.2822687-1-mkl@pengutronix.de>
References: <20250711101706.2822687-1-mkl@pengutronix.de>
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

Convert the Renesas R-Car CAN driver from SIMPLE_DEV_PM_OPS() to
DEFINE_SIMPLE_DEV_PM_OPS() and pm_sleep_ptr().  This lets us drop the
__maybe_unused annotations from its suspend and resume callbacks, and
reduces kernel size in case CONFIG_PM or CONFIG_PM_SLEEP is disabled.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://patch.msgid.link/6ffe085f6e2548f53674dd11704b388cf4b303e9.1752086078.git.geert+renesas@glider.be
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/rcar/rcar_can.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/net/can/rcar/rcar_can.c b/drivers/net/can/rcar/rcar_can.c
index 2b7dd359f27b..64e664f5adcc 100644
--- a/drivers/net/can/rcar/rcar_can.c
+++ b/drivers/net/can/rcar/rcar_can.c
@@ -834,7 +834,7 @@ static void rcar_can_remove(struct platform_device *pdev)
 	free_candev(ndev);
 }
 
-static int __maybe_unused rcar_can_suspend(struct device *dev)
+static int rcar_can_suspend(struct device *dev)
 {
 	struct net_device *ndev = dev_get_drvdata(dev);
 	struct rcar_can_priv *priv = netdev_priv(ndev);
@@ -857,7 +857,7 @@ static int __maybe_unused rcar_can_suspend(struct device *dev)
 	return 0;
 }
 
-static int __maybe_unused rcar_can_resume(struct device *dev)
+static int rcar_can_resume(struct device *dev)
 {
 	struct net_device *ndev = dev_get_drvdata(dev);
 	struct rcar_can_priv *priv = netdev_priv(ndev);
@@ -886,7 +886,8 @@ static int __maybe_unused rcar_can_resume(struct device *dev)
 	return 0;
 }
 
-static SIMPLE_DEV_PM_OPS(rcar_can_pm_ops, rcar_can_suspend, rcar_can_resume);
+static DEFINE_SIMPLE_DEV_PM_OPS(rcar_can_pm_ops, rcar_can_suspend,
+				rcar_can_resume);
 
 static const struct of_device_id rcar_can_of_table[] __maybe_unused = {
 	{ .compatible = "renesas,can-r8a7778" },
@@ -904,7 +905,7 @@ static struct platform_driver rcar_can_driver = {
 	.driver = {
 		.name = RCAR_CAN_DRV_NAME,
 		.of_match_table = of_match_ptr(rcar_can_of_table),
-		.pm = &rcar_can_pm_ops,
+		.pm = pm_sleep_ptr(&rcar_can_pm_ops),
 	},
 	.probe = rcar_can_probe,
 	.remove = rcar_can_remove,

base-commit: 0f26870a989bf69957ed69d10c7ffc57ca5a7f52
-- 
2.47.2



