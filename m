Return-Path: <linux-can+bounces-327-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0717085B5F8
	for <lists+linux-can@lfdr.de>; Tue, 20 Feb 2024 09:53:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 99F491F211F9
	for <lists+linux-can@lfdr.de>; Tue, 20 Feb 2024 08:53:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA98C5FB93;
	Tue, 20 Feb 2024 08:51:40 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 728335F49C
	for <linux-can@vger.kernel.org>; Tue, 20 Feb 2024 08:51:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708419100; cv=none; b=FJNi3zVSli7DYuATzfyyvxa2NQ/ETWxWdez1syF6dTzjqirlN4ckQTyxPz5FusLpMy8lLZuh3af9nAvQKMA/Jw2Y5JNpFUIVlcRFIUVOt4QsL0UMmnzhn7zCI4benOIgogKQ3enSoh0jWWENr0TigrT8XV/ZXU6p/t642q835Ak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708419100; c=relaxed/simple;
	bh=jOAy1bL+es/6nIjSb3/cY3VI/1+JbouXkQZaRny5Kc8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=i6y9eX43tC+Y+ScQYiGQUgIserxucRX/BqOPuw+Cy0FwBkGK6rqSlbqmWhSQCeLqB5PuqJLVA9wJJnWcmlrbsvKduihbOmlSXP+4Tu8vpJ5kmtqnsSywjR9w9rch/O0f6YfIg4W5J5JD7pbtoo6P7vfKywaVlHqbgV70vjHB15E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1rcLqh-0001ce-Fd
	for linux-can@vger.kernel.org; Tue, 20 Feb 2024 09:51:35 +0100
Received: from [2a0a:edc0:0:b01:1d::7b] (helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <mkl@pengutronix.de>)
	id 1rcLqg-001oET-Ce
	for linux-can@vger.kernel.org; Tue, 20 Feb 2024 09:51:34 +0100
Received: from dspam.blackshift.org (localhost [127.0.0.1])
	by bjornoya.blackshift.org (Postfix) with SMTP id 146E5292F09
	for <linux-can@vger.kernel.org>; Tue, 20 Feb 2024 08:51:34 +0000 (UTC)
Received: from hardanger.blackshift.org (unknown [172.20.34.65])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by bjornoya.blackshift.org (Postfix) with ESMTPS id 92415292EE3;
	Tue, 20 Feb 2024 08:51:32 +0000 (UTC)
Received: from blackshift.org (localhost [::1])
	by hardanger.blackshift.org (OpenSMTPD) with ESMTP id f1ece113;
	Tue, 20 Feb 2024 08:51:31 +0000 (UTC)
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	linux-can@vger.kernel.org,
	kernel@pengutronix.de,
	=?UTF-8?q?Martin=20Hundeb=C3=B8ll?= <martin@geanix.com>,
	Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH net-next 4/9] can: tcan4x5x: support resuming from rx interrupt signal
Date: Tue, 20 Feb 2024 09:46:06 +0100
Message-ID: <20240220085130.2936533-5-mkl@pengutronix.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240220085130.2936533-1-mkl@pengutronix.de>
References: <20240220085130.2936533-1-mkl@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org

From: Martin Hundebøll <martin@geanix.com>

Implement the "wakeup-source" device tree property, so the chip is left
running when suspending, and its rx interrupt is used as a wakeup source
to resume operation.

Signed-off-by: Martin Hundebøll <martin@geanix.com>
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/m_can/tcan4x5x-core.c | 34 +++++++++++++++++++++++++--
 1 file changed, 32 insertions(+), 2 deletions(-)

diff --git a/drivers/net/can/m_can/tcan4x5x-core.c b/drivers/net/can/m_can/tcan4x5x-core.c
index 71a9e1bec008..a42600dac70d 100644
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
2.43.0



