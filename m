Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DE82312CA9D
	for <lists+linux-can@lfdr.de>; Sun, 29 Dec 2019 20:21:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726876AbfL2TVi (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Sun, 29 Dec 2019 14:21:38 -0500
Received: from relay-b03.edpnet.be ([212.71.1.220]:49945 "EHLO
        relay-b03.edpnet.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726369AbfL2TVi (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Sun, 29 Dec 2019 14:21:38 -0500
X-ASG-Debug-ID: 1577647294-0a881838821e9eb60001-ZXuqFv
Received: from zotac.vandijck-laurijssen.be (77.109.105.251.adsl.dyn.edpnet.net [77.109.105.251]) by relay-b03.edpnet.be with ESMTP id GkK5pquqW3o7lC4V; Sun, 29 Dec 2019 20:21:34 +0100 (CET)
X-Barracuda-Envelope-From: dev.kurt@vandijck-laurijssen.be
X-Barracuda-Effective-Source-IP: 77.109.105.251.adsl.dyn.edpnet.net[77.109.105.251]
X-Barracuda-Apparent-Source-IP: 77.109.105.251
Received: from x1.vandijck-laurijssen.be (x1.vandijck-laurijssen.be [192.168.0.36])
        by zotac.vandijck-laurijssen.be (Postfix) with ESMTPSA id ACC7EC02E4E;
        Sun, 29 Dec 2019 20:21:33 +0100 (CET)
From:   Kurt Van Dijck <dev.kurt@vandijck-laurijssen.be>
To:     linux-input@vger.kernel.org
Cc:     linux-can@vger.kernel.org,
        Kurt Van Dijck <dev.kurt@vandijck-laurijssen.be>
Subject: [PATCH 3/6] cap11xx: polling mode without irq
Date:   Sun, 29 Dec 2019 20:21:14 +0100
X-ASG-Orig-Subj: [PATCH 3/6] cap11xx: polling mode without irq
Message-Id: <1577647277-8298-4-git-send-email-dev.kurt@vandijck-laurijssen.be>
X-Mailer: git-send-email 1.8.5.rc3
In-Reply-To: <1577647277-8298-1-git-send-email-dev.kurt@vandijck-laurijssen.be>
References: <1577647277-8298-1-git-send-email-dev.kurt@vandijck-laurijssen.be>
X-Barracuda-Connect: 77.109.105.251.adsl.dyn.edpnet.net[77.109.105.251]
X-Barracuda-Start-Time: 1577647294
X-Barracuda-URL: https://212.71.1.220:443/cgi-mod/mark.cgi
X-Virus-Scanned: by bsmtpd at edpnet.be
X-Barracuda-Scan-Msg-Size: 3123
X-Barracuda-BRTS-Status: 1
X-Barracuda-Bayes: SPAM GLOBAL 0.9508 1.0000 3.7809
X-Barracuda-Spam-Score: 3.78
X-Barracuda-Spam-Status: No, SCORE=3.78 using global scores of TAG_LEVEL=1000.0 QUARANTINE_LEVEL=1000.0 KILL_LEVEL=7.0 tests=
X-Barracuda-Spam-Report: Code version 3.2, rules version 3.2.3.78985
        Rule breakdown below
         pts rule name              description
        ---- ---------------------- --------------------------------------------------
Sender: linux-can-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Signed-off-by: Kurt Van Dijck <dev.kurt@vandijck-laurijssen.be>
---
 drivers/input/keyboard/cap11xx.c | 49 ++++++++++++++++++++++++++++++++++++----
 1 file changed, 45 insertions(+), 4 deletions(-)

diff --git a/drivers/input/keyboard/cap11xx.c b/drivers/input/keyboard/cap11xx.c
index 092dcd2..5a7eaed 100644
--- a/drivers/input/keyboard/cap11xx.c
+++ b/drivers/input/keyboard/cap11xx.c
@@ -9,6 +9,7 @@
 #include <linux/module.h>
 #include <linux/interrupt.h>
 #include <linux/input.h>
+#include <linux/kthread.h>
 #include <linux/leds.h>
 #include <linux/of_irq.h>
 #include <linux/regmap.h>
@@ -78,6 +79,7 @@ struct cap11xx_led {
 
 struct cap11xx_priv {
 	struct regmap *regmap;
+	struct task_struct *poll_thread;
 	struct input_dev *idev;
 
 	struct cap11xx_led *leds;
@@ -202,6 +204,24 @@ static irqreturn_t cap11xx_thread_func(int irq_num, void *data)
 	return IRQ_HANDLED;
 }
 
+static int poll_irq(void *data) {
+
+	struct cap11xx_priv *priv = data;
+	int ret;
+	unsigned int status;
+
+	/* until module unload */
+	while (!kthread_should_stop()) {
+		ret = regmap_read(priv->regmap, CAP11XX_REG_MAIN_CONTROL, &status);
+		if (ret >= 0 && (status & 1))
+			cap11xx_thread_func(-1, priv);
+		usleep_range(15000, 25000);
+	}
+
+	return 0;
+}
+
+
 static int cap11xx_set_sleep(struct cap11xx_priv *priv, bool sleep)
 {
 	/*
@@ -320,6 +340,17 @@ static int cap11xx_init_leds(struct device *dev,
 }
 #endif
 
+static int cap11xx_i2c_remove(struct i2c_client *i2c_client)
+{
+	struct cap11xx_priv *priv = i2c_get_clientdata(i2c_client);
+
+	if (priv->poll_thread) {
+		kthread_stop(priv->poll_thread);
+		mdelay(10);
+	}
+	return 0;
+}
+
 static int cap11xx_i2c_probe(struct i2c_client *i2c_client,
 			     const struct i2c_device_id *id)
 {
@@ -348,8 +379,6 @@ static int cap11xx_i2c_probe(struct i2c_client *i2c_client,
 	if (!priv)
 		return -ENOMEM;
 
-	i2c_set_clientdata(i2c_client, priv);
-
 	priv->regmap = devm_regmap_init_i2c(i2c_client, &cap11xx_regmap_config);
 	if (IS_ERR(priv->regmap))
 		return PTR_ERR(priv->regmap);
@@ -458,8 +487,19 @@ static int cap11xx_i2c_probe(struct i2c_client *i2c_client,
 
 	irq = irq_of_parse_and_map(node, 0);
 	if (!irq) {
-		dev_err(dev, "Unable to parse or map IRQ\n");
-		return -ENXIO;
+		if (!of_property_read_bool(node, "linux,irq-poll")) {
+			dev_err(dev, "Unable to parse or map IRQ\n");
+			return -ENXIO;
+		}
+		dev_info(dev, "IRQ failed or undefined, using poll_thread\n");
+		priv->poll_thread = kthread_create(poll_irq, priv, "%s-%s-poll",
+				id->name, dev_name(dev));
+		if (!priv->poll_thread) {
+			dev_err(dev, "Unable to start poll_thread\n");
+			return -ENXIO;
+		}
+		wake_up_process(priv->poll_thread);
+		return 0;
 	}
 
 	error = devm_request_threaded_irq(dev, irq, NULL, cap11xx_thread_func,
@@ -495,6 +535,7 @@ static int cap11xx_i2c_probe(struct i2c_client *i2c_client,
 	},
 	.id_table	= cap11xx_i2c_ids,
 	.probe		= cap11xx_i2c_probe,
+	.remove		= cap11xx_i2c_remove,
 };
 
 module_i2c_driver(cap11xx_i2c_driver);
-- 
1.8.5.rc3

