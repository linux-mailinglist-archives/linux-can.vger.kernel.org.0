Return-Path: <linux-can+bounces-666-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DE818CC2F6
	for <lists+linux-can@lfdr.de>; Wed, 22 May 2024 16:17:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 950EDB23720
	for <lists+linux-can@lfdr.de>; Wed, 22 May 2024 14:17:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22E66145B14;
	Wed, 22 May 2024 14:16:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b="M0LMV8SL";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b="E97ZsL2x"
X-Original-To: linux-can@vger.kernel.org
Received: from mx1.tq-group.com (mx1.tq-group.com [93.104.207.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC14C1422A3;
	Wed, 22 May 2024 14:16:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.104.207.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716387380; cv=none; b=NzQ3vVIlNuGuCWOSwnIzzA3f0Rt8sdmKdzo8QClYMpiAoG4querflcdCzY0qTddEbsLo+4i/QTEsyreKkxPcNJ22W8D7Ea6X/ku2VIIfz++uHnwCpNXLtD8eIiow69LPlAnsKPjC9lNjxqS8xIU78YcWBhnHgrGDcmFH1J5onJw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716387380; c=relaxed/simple;
	bh=/8/nmVISpEctdKRq4DMkNXmqc21rjaVVy5jr4gqm79Q=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=tNeka9vxpyy7NAO1aDWH2Mcbcu70kpHe6HPBEG0/bW3ZgmumntE8vTlu4z0vabg6zBEv90ZRRQFmNXhw6TE2nVYSeP4/Q63cFH5hArcH8drNehYT8yK4lFr0h9NqfsAzu+nIIfgzOrZaNpOq9BrctytMH+R1b3pc19o8OsYXYac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com; spf=pass smtp.mailfrom=ew.tq-group.com; dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b=M0LMV8SL; dkim=fail (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b=E97ZsL2x reason="key not found in DNS"; arc=none smtp.client-ip=93.104.207.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ew.tq-group.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1716387377; x=1747923377;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=HzgRfkx69ejCT8/j9/r35vaN4dbCC/lhZPLg+w23TA8=;
  b=M0LMV8SLJsHF0LR3iglMutAB7zCYXG4szfHV62dH4qLRMH7zBYeEasQD
   IlfCESDncWIdR/jtBlt0VgbbVJiPeeDykphEV22v7SrpcTYzGiEgyznUV
   L3fOyBgJcrU3sfFl1733fzi0/Sa390p+lAPZwwzhrx09/YuQFcfIrwdL0
   z69l+NQB/bASBmSVr1AirdQ34Yy2M0NdCysGY+vZ7OdlI3grs2N/RPKwd
   HwWpWStbDt3N7EFhiLbt527AbnjlJwEJQRUt8OMiQjuOVFwCejTR8m8Iy
   LgDWpeapZoDk6MCUfaxpMj/36k9SGSPBcj49Jr0avKghRWTELc+soQoR3
   Q==;
X-CSE-ConnectionGUID: pzYhZPaCTGeAF2vEtvzX6A==
X-CSE-MsgGUID: N9W4pjDYRySeCT17leOBUg==
X-IronPort-AV: E=Sophos;i="6.08,179,1712613600"; 
   d="scan'208";a="37017664"
Received: from vmailcow01.tq-net.de ([10.150.86.48])
  by mx1.tq-group.com with ESMTP; 22 May 2024 16:16:16 +0200
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 6B66D161302;
	Wed, 22 May 2024 16:16:11 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ew.tq-group.com;
	s=dkim; t=1716387372;
	h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=HzgRfkx69ejCT8/j9/r35vaN4dbCC/lhZPLg+w23TA8=;
	b=E97ZsL2x9hRUrKS9xr9f86ApPW1OMiTYapJS8Zmvj85JbiPPqldZIu4W6/S6TTtMRglqHV
	oBBV7z4yl0CcVGiVzkuvTdgIdOS0HWGWlOxNTdsKdFROcNGGXlhb+p/NYUliNmvNFDGlwk
	sE0vRutb76z6Saal90fUJHrY6EWE2qw2KdIUlWufCwfrhYhbo8DM6skrF/G1FCKHXvaIeO
	Drd5JnU/7vhDfmUoS5nFLmDVRVsd8qBpQGKwVQnTdL9hFm04rLOPpd7g/qI+2cCVBUAZj8
	jKLRDZP121Ho339oO7gNSNn6JiXaXlxfrSS+c93HGM7qdvynpGWqTg8lMCbjbg==
From: Gregor Herburger <gregor.herburger@ew.tq-group.com>
Date: Wed, 22 May 2024 16:15:20 +0200
Subject: [PATCH RESEND v3 3/8] can: mcp251xfd: move chip sleep mode into
 runtime pm
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240522-mcp251xfd-gpio-feature-v3-3-8829970269c5@ew.tq-group.com>
References: <20240522-mcp251xfd-gpio-feature-v3-0-8829970269c5@ew.tq-group.com>
In-Reply-To: <20240522-mcp251xfd-gpio-feature-v3-0-8829970269c5@ew.tq-group.com>
To: Marc Kleine-Budde <mkl@pengutronix.de>, 
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, 
 Thomas Kopp <thomas.kopp@microchip.com>, 
 Vincent Mailhol <mailhol.vincent@wanadoo.fr>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-can@vger.kernel.org, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
 linux@ew.tq-group.com, gregor.herburger@ew.tq-group.com, 
 Linus Walleij <linus.walleij@linaro.org>, 
 Bartosz Golaszewski <brgl@bgdev.pl>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1716387339; l=6456;
 i=gregor.herburger@ew.tq-group.com; s=20230829; h=from:subject:message-id;
 bh=1ft/Lfl50Qy9X3blOZLBvjNtkRi5g0ppER1oxgDyqpk=;
 b=X0Ijk3PhYl2Cw/Z3yeDphqGFWd4j3RObpsD6MfQmtDu/RsvknzQTOws+53csS9KIqVteH8yl/
 Dr7fqo5bjk3AWNOQPoycRGPeWKTgvwys1fKh2plMPo++UPafSggqKbJ
X-Developer-Key: i=gregor.herburger@ew.tq-group.com; a=ed25519;
 pk=+eRxwX7ikXwazcRjlOjj2/tbDmfVZdDLoW+xLZbQ4h4=
X-Last-TLS-Session-Version: TLSv1.3

From: Marc Kleine-Budde <mkl@pengutronix.de>

This is a preparation patch to add GPIO support.

Up to now, the Vdd regulator and the clocks have been managed by
Runtime-PM (on systems without CONFIG_PM these remain permanently
switched on).

During the mcp251xfd_open() callback the mcp251xfd is powered,
soft-reset and configured. In mcp251xfd_stop() the chip is shut down
again. To support the on-chip GPIOs, the chip must be supplied with
power while GPIOs are being requested, even if the networking
interface ist down.

To support this, move the functions mcp251xfd_chip_softreset() and
mcp251xfd_chip_clock_init() from mcp251xfd_chip_start() to
mcp251xfd_runtime_resume(). Instead of setting the controller to sleep
mode in mcp251xfd_chip_stop(), bring it into configuration mode. This
way it doesn't take part in bus activity and doesn't enter sleep mode.

Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
Signed-off-by: Gregor Herburger <gregor.herburger@ew.tq-group.com>
---
 drivers/net/can/spi/mcp251xfd/mcp251xfd-core.c | 99 ++++++++++++++++----------
 1 file changed, 61 insertions(+), 38 deletions(-)

diff --git a/drivers/net/can/spi/mcp251xfd/mcp251xfd-core.c b/drivers/net/can/spi/mcp251xfd/mcp251xfd-core.c
index 4ae201426a46..4739ad80ef2a 100644
--- a/drivers/net/can/spi/mcp251xfd/mcp251xfd-core.c
+++ b/drivers/net/can/spi/mcp251xfd/mcp251xfd-core.c
@@ -745,21 +745,13 @@ static void mcp251xfd_chip_stop(struct mcp251xfd_priv *priv,
 	mcp251xfd_chip_interrupts_disable(priv);
 	mcp251xfd_chip_rx_int_disable(priv);
 	mcp251xfd_timestamp_stop(priv);
-	mcp251xfd_chip_sleep(priv);
+	mcp251xfd_chip_set_mode(priv, MCP251XFD_REG_CON_MODE_CONFIG);
 }
 
 static int mcp251xfd_chip_start(struct mcp251xfd_priv *priv)
 {
 	int err;
 
-	err = mcp251xfd_chip_softreset(priv);
-	if (err)
-		goto out_chip_stop;
-
-	err = mcp251xfd_chip_clock_init(priv);
-	if (err)
-		goto out_chip_stop;
-
 	err = mcp251xfd_chip_timestamp_init(priv);
 	if (err)
 		goto out_chip_stop;
@@ -1602,8 +1594,11 @@ static int mcp251xfd_open(struct net_device *ndev)
 		return err;
 
 	err = pm_runtime_resume_and_get(ndev->dev.parent);
-	if (err)
+	if (err) {
+		if (err == -ETIMEDOUT || err == -ENODEV)
+			pm_runtime_set_suspended(ndev->dev.parent);
 		goto out_close_candev;
+	}
 
 	err = mcp251xfd_ring_alloc(priv);
 	if (err)
@@ -1872,53 +1867,53 @@ static int mcp251xfd_register(struct mcp251xfd_priv *priv)
 	struct net_device *ndev = priv->ndev;
 	int err;
 
+	mcp251xfd_register_quirks(priv);
+
 	err = mcp251xfd_clks_and_vdd_enable(priv);
 	if (err)
 		return err;
 
+	err = mcp251xfd_chip_softreset(priv);
+	if (err == -ENODEV)
+		goto out_clks_and_vdd_disable;
+	if (err)
+		goto out_chip_sleep;
+
+	err = mcp251xfd_chip_clock_init(priv);
+	if (err == -ENODEV)
+		goto out_clks_and_vdd_disable;
+	if (err)
+		goto out_chip_sleep;
+
 	pm_runtime_get_noresume(ndev->dev.parent);
 	err = pm_runtime_set_active(ndev->dev.parent);
 	if (err)
 		goto out_runtime_put_noidle;
 	pm_runtime_enable(ndev->dev.parent);
 
-	mcp251xfd_register_quirks(priv);
-
-	err = mcp251xfd_chip_softreset(priv);
-	if (err == -ENODEV)
-		goto out_runtime_disable;
-	if (err)
-		goto out_chip_sleep;
-
-	err = mcp251xfd_chip_clock_init(priv);
-	if (err == -ENODEV)
-		goto out_runtime_disable;
-	if (err)
-		goto out_chip_sleep;
-
 	err = mcp251xfd_register_chip_detect(priv);
 	if (err)
-		goto out_chip_sleep;
+		goto out_runtime_disable;
 
 	err = mcp251xfd_register_check_rx_int(priv);
 	if (err)
-		goto out_chip_sleep;
+		goto out_runtime_disable;
 
 	mcp251xfd_ethtool_init(priv);
 
 	err = register_candev(ndev);
 	if (err)
-		goto out_chip_sleep;
+		goto out_runtime_disable;
 
 	err = mcp251xfd_register_done(priv);
 	if (err)
 		goto out_unregister_candev;
 
-	/* Put controller into sleep mode and let pm_runtime_put()
-	 * disable the clocks and vdd. If CONFIG_PM is not enabled,
-	 * the clocks and vdd will stay powered.
+	/* Put controller into Config mode and let pm_runtime_put()
+	 * put in sleep mode, disable the clocks and vdd. If CONFIG_PM
+	 * is not enabled, the clocks and vdd will stay powered.
 	 */
-	err = mcp251xfd_chip_sleep(priv);
+	err = mcp251xfd_chip_set_mode(priv, MCP251XFD_REG_CON_MODE_CONFIG);
 	if (err)
 		goto out_unregister_candev;
 
@@ -1928,12 +1923,13 @@ static int mcp251xfd_register(struct mcp251xfd_priv *priv)
 
 out_unregister_candev:
 	unregister_candev(ndev);
-out_chip_sleep:
-	mcp251xfd_chip_sleep(priv);
 out_runtime_disable:
 	pm_runtime_disable(ndev->dev.parent);
 out_runtime_put_noidle:
 	pm_runtime_put_noidle(ndev->dev.parent);
+out_chip_sleep:
+	mcp251xfd_chip_sleep(priv);
+out_clks_and_vdd_disable:
 	mcp251xfd_clks_and_vdd_disable(priv);
 
 	return err;
@@ -1945,10 +1941,12 @@ static inline void mcp251xfd_unregister(struct mcp251xfd_priv *priv)
 
 	unregister_candev(ndev);
 
-	if (pm_runtime_enabled(ndev->dev.parent))
+	if (pm_runtime_enabled(ndev->dev.parent)) {
 		pm_runtime_disable(ndev->dev.parent);
-	else
+	} else {
+		mcp251xfd_chip_sleep(priv);
 		mcp251xfd_clks_and_vdd_disable(priv);
+	}
 }
 
 static const struct of_device_id mcp251xfd_of_match[] = {
@@ -2175,16 +2173,41 @@ static void mcp251xfd_remove(struct spi_device *spi)
 
 static int __maybe_unused mcp251xfd_runtime_suspend(struct device *device)
 {
-	const struct mcp251xfd_priv *priv = dev_get_drvdata(device);
+	struct mcp251xfd_priv *priv = dev_get_drvdata(device);
 
+	mcp251xfd_chip_sleep(priv);
 	return mcp251xfd_clks_and_vdd_disable(priv);
 }
 
 static int __maybe_unused mcp251xfd_runtime_resume(struct device *device)
 {
-	const struct mcp251xfd_priv *priv = dev_get_drvdata(device);
+	struct mcp251xfd_priv *priv = dev_get_drvdata(device);
+	int err;
 
-	return mcp251xfd_clks_and_vdd_enable(priv);
+	err = mcp251xfd_clks_and_vdd_enable(priv);
+	if (err)
+		return err;
+
+	err = mcp251xfd_chip_softreset(priv);
+	if (err == -ENODEV)
+		goto out_clks_and_vdd_disable;
+	if (err)
+		goto out_chip_sleep;
+
+	err = mcp251xfd_chip_clock_init(priv);
+	if (err == -ENODEV)
+		goto out_clks_and_vdd_disable;
+	if (err)
+		goto out_chip_sleep;
+
+	return 0;
+
+out_chip_sleep:
+	mcp251xfd_chip_sleep(priv);
+out_clks_and_vdd_disable:
+	mcp251xfd_clks_and_vdd_disable(priv);
+
+	return err;
 }
 
 static const struct dev_pm_ops mcp251xfd_pm_ops = {

-- 
2.34.1


