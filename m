Return-Path: <linux-can+bounces-9-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 253847E9CCF
	for <lists+linux-can@lfdr.de>; Mon, 13 Nov 2023 14:15:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A5F2C280A47
	for <lists+linux-can@lfdr.de>; Mon, 13 Nov 2023 13:15:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83FA11DFEA;
	Mon, 13 Nov 2023 13:15:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b="XGEuILR8"
X-Original-To: linux-can@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 627991DFD6;
	Mon, 13 Nov 2023 13:15:08 +0000 (UTC)
Received: from www530.your-server.de (www530.your-server.de [188.40.30.78])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D3D71722;
	Mon, 13 Nov 2023 05:15:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=geanix.com;
	s=default2211; h=Content-Transfer-Encoding:Content-Type:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID;
	bh=QwxS8AAVgWbWSXqucpTTpQWhMELRpsu4i5sqjUo/D6s=; b=XGEuILR8RHW7TNXIQ1ezV0tScb
	xUSQKxrzyuVi+QB8Ar20pQ3kSSCmDOdvNgn3WYau210ggYhkPr80PXwQculpOWMyR3RtDm043Y2X8
	AdPCzVfY8B8uqnPVEslGNWEGXScT0KUMElcnPPpM6l0XY75GDZNZTDuSsX5y7dHuVk4z/YBww9Qxq
	XDwo7Z0piDLYzQ1vzDzibt9H1ryEG24pCZ76tAyvjfbhNeKCwF4pbyDc5W9U0HTx/2HODtir+W1cY
	7XeNrpnU9Xh5idNOU4ZLK/kbGkuPyex/MG0d0rv3YkHM3opDDrXpgQOTAtlE+WHt+ABGmBbxE9yb+
	9FcX+jNw==;
Received: from sslproxy05.your-server.de ([78.46.172.2])
	by www530.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <martin@geanix.com>)
	id 1r2WmF-0007Gd-Uw; Mon, 13 Nov 2023 14:14:55 +0100
Received: from [185.17.218.86] (helo=zen..)
	by sslproxy05.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <martin@geanix.com>)
	id 1r2WmF-000XPJ-CC; Mon, 13 Nov 2023 14:14:55 +0100
From: =?UTF-8?q?Martin=20Hundeb=C3=B8ll?= <martin@geanix.com>
To: linux-can@vger.kernel.org,
	devicetree@vger.kernel.org
Cc: Chandrasekar Ramakrishnan <rcsekar@samsung.com>,
	Wolfgang Grandegger <wg@grandegger.com>,
	Marc Kleine-Budde <mkl@pengutronix.de>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	=?UTF-8?q?Martin=20Hundeb=C3=B8ll?= <martin@geanix.com>
Subject: [PATCH v3 2/3] can: tcan4x5x: support resuming from rx interrupt signal
Date: Mon, 13 Nov 2023 14:14:51 +0100
Message-ID: <20231113131452.214961-3-martin@geanix.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231113131452.214961-1-martin@geanix.com>
References: <20231113131452.214961-1-martin@geanix.com>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Authenticated-Sender: martin@geanix.com
X-Virus-Scanned: Clear (ClamAV 0.103.10/27092/Mon Nov 13 09:38:20 2023)

Implement the "wakeup-source" device tree property, so the chip is left
running when suspending, and its rx interrupt is used as a wakeup source
to resume operation.

Signed-off-by: Martin Hundebøll <martin@geanix.com>
---

Change in v3:
 * Updated to use the property in struct m_can_classdev instead of
   passing parameters to suspend/resume functions.

Change in v2:
 * Added `static` keyword to dev_pm_ops sturcture

 drivers/net/can/m_can/tcan4x5x-core.c | 34 +++++++++++++++++++++++++--
 1 file changed, 32 insertions(+), 2 deletions(-)

diff --git a/drivers/net/can/m_can/tcan4x5x-core.c b/drivers/net/can/m_can/tcan4x5x-core.c
index 870ab4aef610..0f4c2ac7e4f6 100644
--- a/drivers/net/can/m_can/tcan4x5x-core.c
+++ b/drivers/net/can/m_can/tcan4x5x-core.c
@@ -411,7 +411,7 @@ static int tcan4x5x_can_probe(struct spi_device *spi)
 	priv->spi = spi;
 
 	mcan_class->pm_clock_support = 0;
-	mcan_class->pm_wake_source = 0;
+	mcan_class->pm_wake_source = device_property_read_bool(&spi->dev, "wakeup-source");
 	mcan_class->can.clock.freq = freq;
 	mcan_class->dev = &spi->dev;
 	mcan_class->ops = &tcan4x5x_ops;
@@ -460,6 +460,9 @@ static int tcan4x5x_can_probe(struct spi_device *spi)
 		goto out_power;
 	}
 
+	if (mcan_class->pm_wake_source)
+		device_init_wakeup(&spi->dev, true);
+
 	ret = m_can_class_register(mcan_class);
 	if (ret) {
 		dev_err(&spi->dev, "Failed registering m_can device %pe\n",
@@ -488,6 +491,29 @@ static void tcan4x5x_can_remove(struct spi_device *spi)
 	m_can_class_free_dev(priv->cdev.net);
 }
 
+static int __maybe_unused tcan4x5x_suspend(struct device *dev)
+{
+	struct m_can_classdev *cdev = dev_get_drvdata(dev);
+	struct spi_device *spi = to_spi_device(dev);
+
+	if (cdev->pm_wake_source)
+		enable_irq_wake(spi->irq);
+
+	return m_can_class_suspend(dev);
+}
+
+static int __maybe_unused tcan4x5x_resume(struct device *dev)
+{
+	struct m_can_classdev *cdev = dev_get_drvdata(dev);
+	struct spi_device *spi = to_spi_device(dev);
+	int ret = m_can_class_resume(dev);
+
+	if (cdev->pm_wake_source)
+		disable_irq_wake(spi->irq);
+
+	return ret;
+}
+
 static const struct of_device_id tcan4x5x_of_match[] = {
 	{
 		.compatible = "ti,tcan4x5x",
@@ -506,11 +532,15 @@ static const struct spi_device_id tcan4x5x_id_table[] = {
 };
 MODULE_DEVICE_TABLE(spi, tcan4x5x_id_table);
 
+static const struct dev_pm_ops tcan4x5x_pm_ops = {
+	SET_SYSTEM_SLEEP_PM_OPS(tcan4x5x_suspend, tcan4x5x_resume)
+};
+
 static struct spi_driver tcan4x5x_can_driver = {
 	.driver = {
 		.name = KBUILD_MODNAME,
 		.of_match_table = tcan4x5x_of_match,
-		.pm = NULL,
+		.pm = &tcan4x5x_pm_ops,
 	},
 	.id_table = tcan4x5x_id_table,
 	.probe = tcan4x5x_can_probe,
-- 
2.42.0


