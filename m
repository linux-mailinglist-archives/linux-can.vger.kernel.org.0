Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA2CF7A62E5
	for <lists+linux-can@lfdr.de>; Tue, 19 Sep 2023 14:29:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229988AbjISM3R (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Tue, 19 Sep 2023 08:29:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231501AbjISM3Q (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 19 Sep 2023 08:29:16 -0400
Received: from www530.your-server.de (www530.your-server.de [188.40.30.78])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF3E7E3
        for <linux-can@vger.kernel.org>; Tue, 19 Sep 2023 05:29:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=geanix.com;
        s=default2211; h=Content-Transfer-Encoding:Content-Type:MIME-Version:
        References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID;
        bh=AAxzke1vXCmIlWvAD6yVp1aVST7MODkE1kU8X26rQV8=; b=lxIXFuBmhNndVydtgrQvx0mhKJ
        7EyCOw9rHigKAjXWcean8Fk5Ze25cBpA33A2H1YyJiU+T/rUqXF+8Opclbi8UWDlvZjNtxOUsiKm1
        lYXnY8U2B4xU8UDtKNq4JiJj4LzQRUINWMw2czZXEfUB0l6825hF8119Jrpxav558SApzd/APbQ2Z
        zypkLvcVVQEApqgS1xtA3+HZKantZ04RNHzdw4FQNJmYV9MvMBTjylFM45sKYb4ftO95GbSWLzsiF
        GyMYAuzCEZKo0A7aVnr/h0wCM0FAwuW39x63lPNhOjbncm3I1drwl8A8SwK1G+yH1Q5oM3zHbB3AU
        iO239/WQ==;
Received: from sslproxy03.your-server.de ([88.198.220.132])
        by www530.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <martin@geanix.com>)
        id 1qiZqb-00033g-Hc; Tue, 19 Sep 2023 14:28:57 +0200
Received: from [185.17.218.86] (helo=zen..)
        by sslproxy03.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <martin@geanix.com>)
        id 1qiZqa-000GHn-Tw; Tue, 19 Sep 2023 14:28:56 +0200
From:   =?UTF-8?q?Martin=20Hundeb=C3=B8ll?= <martin@geanix.com>
To:     linux-can@vger.kernel.org
Cc:     =?UTF-8?q?Martin=20Hundeb=C3=B8ll?= <martin@geanix.com>,
        Chandrasekar Ramakrishnan <rcsekar@samsung.com>,
        Wolfgang Grandegger <wg@grandegger.com>,
        Marc Kleine-Budde <mkl@pengutronix.de>,
        Dong Aisheng <b29396@freescale.com>,
        Dan Murphy <dmurphy@ti.com>
Subject: [PATCH v2 2/2] can: tcan4x5x: support resuming from rx interrupt signal
Date:   Tue, 19 Sep 2023 14:28:33 +0200
Message-ID: <20230919122841.3803289-2-martin@geanix.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230919122841.3803289-1-martin@geanix.com>
References: <20230919122841.3803289-1-martin@geanix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Authenticated-Sender: martin@geanix.com
X-Virus-Scanned: Clear (ClamAV 0.103.10/27036/Tue Sep 19 09:42:31 2023)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Implement the "wakeup-source" device tree property, so the chip is left
running when suspending, and its rx interrupt is used as a wakeup source
to resume operation.

Signed-off-by: Martin Hundebøll <martin@geanix.com>
---

Change since v1:
 * Added `static` keyword to dev_pm_ops sturcture

 drivers/net/can/m_can/tcan4x5x-core.c | 34 ++++++++++++++++++++++++++-
 1 file changed, 33 insertions(+), 1 deletion(-)

diff --git a/drivers/net/can/m_can/tcan4x5x-core.c b/drivers/net/can/m_can/tcan4x5x-core.c
index 8a4143809d33..ccb279af22bb 100644
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
@@ -487,6 +490,31 @@ static void tcan4x5x_can_remove(struct spi_device *spi)
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
+	bool wake_source = device_may_wakeup(dev);
+	int ret = m_can_class_resume(dev, wake_source);
+
+	if (wake_source)
+		disable_irq_wake(spi->irq);
+
+	return ret;
+}
+
 static const struct of_device_id tcan4x5x_of_match[] = {
 	{
 		.compatible = "ti,tcan4x5x",
@@ -505,11 +533,15 @@ static const struct spi_device_id tcan4x5x_id_table[] = {
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

