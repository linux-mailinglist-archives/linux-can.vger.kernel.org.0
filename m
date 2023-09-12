Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F03379CC04
	for <lists+linux-can@lfdr.de>; Tue, 12 Sep 2023 11:38:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232331AbjILJig (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Tue, 12 Sep 2023 05:38:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232563AbjILJif (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 12 Sep 2023 05:38:35 -0400
Received: from www530.your-server.de (www530.your-server.de [188.40.30.78])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4079ACC3
        for <linux-can@vger.kernel.org>; Tue, 12 Sep 2023 02:38:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=geanix.com;
        s=default2211; h=Content-Transfer-Encoding:Content-Type:MIME-Version:
        References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID;
        bh=0K/BWaCt1nidiVVYJEYyhBy0tpWx2zKWMS7K2X0+tCU=; b=EbTvnyuAcg5sbXKBPPJqgU/Hd6
        K9agXslMvHyJpn/es3hwMqyuPayIAEA5ikjQnmEdGgVMyfgbMyglKVjuljm6x6rIH1T0pDWUniB3O
        gYuVqVcM5/wj4vgf6MUWCy1ALRGLvh0k7TfzPANNwNDSa9NeZ3s734cVqyIsKCoZMRerJQfWwdxlL
        Qh98QTG5DMhKOG1rGOZ+VqYPRN82o1nVZvL5X6IEHOFlW6dyf40K2E4vGQVUUNC11hCQbTyKXHNYe
        CwnChqBV7loaEARJDL14UN0Duoc85pjMAtk6crv5PVV0I83hZ5I4+MapIokiZVaTmx9U6TNLsIzS5
        A4CY9C9Q==;
Received: from sslproxy02.your-server.de ([78.47.166.47])
        by www530.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <martin@geanix.com>)
        id 1qfzqk-00041F-TG; Tue, 12 Sep 2023 11:38:26 +0200
Received: from [185.17.218.86] (helo=zen..)
        by sslproxy02.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <martin@geanix.com>)
        id 1qfzqk-000PsR-Ja; Tue, 12 Sep 2023 11:38:26 +0200
From:   =?UTF-8?q?Martin=20Hundeb=C3=B8ll?= <martin@geanix.com>
To:     linux-can@vger.kernel.org
Cc:     =?UTF-8?q?Martin=20Hundeb=C3=B8ll?= <martin@geanix.com>,
        Chandrasekar Ramakrishnan <rcsekar@samsung.com>,
        Wolfgang Grandegger <wg@grandegger.com>,
        Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH 2/2] can: tcan4x5x: support resuming from rx interrupt signal
Date:   Tue, 12 Sep 2023 11:38:04 +0200
Message-ID: <20230912093807.1383720-2-martin@geanix.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230912093807.1383720-1-martin@geanix.com>
References: <20230912093807.1383720-1-martin@geanix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Authenticated-Sender: martin@geanix.com
X-Virus-Scanned: Clear (ClamAV 0.103.8/27029/Tue Sep 12 09:38:51 2023)
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Implement the "wakeup-source" device tree property, so the chip is left
running when suspending, and its rx interrupt is used as a wakeup source
to resume operation.

Signed-off-by: Martin Hundebøll <martin@geanix.com>
---
 drivers/net/can/m_can/tcan4x5x-core.c | 33 ++++++++++++++++++++++++++-
 1 file changed, 32 insertions(+), 1 deletion(-)

diff --git a/drivers/net/can/m_can/tcan4x5x-core.c b/drivers/net/can/m_can/tcan4x5x-core.c
index 8a4143809d33..e0dee2ce3286 100644
--- a/drivers/net/can/m_can/tcan4x5x-core.c
+++ b/drivers/net/can/m_can/tcan4x5x-core.c
@@ -459,6 +459,9 @@ static int tcan4x5x_can_probe(struct spi_device *spi)
 		goto out_power;
 	}
 
+	if (device_property_read_bool(&spi->dev, "wakeup-source"))
+		device_init_wakeup(&spi->dev, true);
+
 	ret = m_can_class_register(mcan_class);
 	if (ret) {
 		dev_err(&spi->dev, "Failed registering m_can device %pe\n",
@@ -487,6 +490,30 @@ static void tcan4x5x_can_remove(struct spi_device *spi)
 	m_can_class_free_dev(priv->cdev.net);
 }
 
+static int __maybe_unused tcan4x5x_suspend(struct device *dev)
+{
+	struct spi_device *spi = to_spi_device(dev);
+
+	if (device_may_wakeup(dev)) {
+		enable_irq_wake(spi->irq);
+
+		return m_can_class_suspend(dev, true);
+	}
+
+	return m_can_class_suspend(dev, false);
+}
+
+static int __maybe_unused tcan4x5x_resume(struct device *dev)
+{
+	struct spi_device *spi = to_spi_device(dev);
+	int ret = m_can_class_resume(dev);
+
+	if (device_may_wakeup(dev))
+		disable_irq_wake(spi->irq);
+
+	return ret;
+}
+
 static const struct of_device_id tcan4x5x_of_match[] = {
 	{
 		.compatible = "ti,tcan4x5x",
@@ -505,11 +532,15 @@ static const struct spi_device_id tcan4x5x_id_table[] = {
 };
 MODULE_DEVICE_TABLE(spi, tcan4x5x_id_table);
 
+const struct dev_pm_ops tcan4x5x_pm_ops = {
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

