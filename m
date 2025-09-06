Return-Path: <linux-can+bounces-4499-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 90FBDB469FF
	for <lists+linux-can@lfdr.de>; Sat,  6 Sep 2025 09:50:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6FBD51C2006D
	for <lists+linux-can@lfdr.de>; Sat,  6 Sep 2025 07:51:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 051A621FF33;
	Sat,  6 Sep 2025 07:50:42 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from cstnet.cn (smtp21.cstnet.cn [159.226.251.21])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE6B233E7
	for <linux-can@vger.kernel.org>; Sat,  6 Sep 2025 07:50:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757145041; cv=none; b=ArKiWjLzvrj6Jh0ZuNI8lQDim4TZFKFEqupR9CfHVKYo5reRCX5cKdWp5dEMB18BQA8jhe7RS0RPXnlb/zZeeyoZSOmN6rAeeX7H8uHa9kvPChHO11ezLLMCaI8EKDzd0WOAUi3cbNpmwqDDIqrqNyGHM4G7btZV2+aWKOrO3Ow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757145041; c=relaxed/simple;
	bh=zV98mP24Xba4hOXOUpYJAW5AuV9S1qcwCgzDsbAVwH8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=gX0lQdXVnU6UTUC0b4okayyMItE5LhiwEV+Gg7x0T4DcjT7n+jwvw8TqUtc3/+OH+LXLZ2J0RvgPuERrucK2foCJEEMwZf+RINwHnPczevRl4hWTZRUafJudXW7dhsCssP5DynQ6T+G6e9+n8pIvBSlf90m0em+h/YjX9INt028=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iie.ac.cn; spf=pass smtp.mailfrom=iie.ac.cn; arc=none smtp.client-ip=159.226.251.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iie.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iie.ac.cn
Received: from localhost.localdomain (unknown [159.226.95.28])
	by APP-01 (Coremail) with SMTP id qwCowABnvqDH57toDyUHAQ--.13570S2;
	Sat, 06 Sep 2025 15:50:33 +0800 (CST)
From: Chen Yufeng <chenyufeng@iie.ac.cn>
To: mkl@pengutronix.de
Cc: mailhol.vincent@wanadoo.fr,
	dario.binacchi@amarulasolutions.com,
	linux-can@vger.kernel.org,
	Chen Yufeng <chenyufeng@iie.ac.cn>
Subject: [PATCH] can: hi311x: fix null pointer dereference when resuming  from sleep before interface was enabled
Date: Sat,  6 Sep 2025 15:50:19 +0800
Message-ID: <20250906075019.124-1-chenyufeng@iie.ac.cn>
X-Mailer: git-send-email 2.43.0.windows.1
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qwCowABnvqDH57toDyUHAQ--.13570S2
X-Coremail-Antispam: 1UD129KBjvJXoWxWF1DGw47CFyUAw1kZw47urg_yoW5Zr43pw
	sIvryrtrZ7Jr409an5Xw4UXFn8Wa18W3W8CFy7Ww40qw13CFyvga40yFWjqrZ3AFZYvFWa
	kFWDX39xGFn8Z37anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvm14x267AKxVWUJVW8JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26r1j6r1xM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r1j
	6r4UM28EF7xvwVC2z280aVAFwI0_Cr0_Gr1UM28EF7xvwVC2z280aVCY1x0267AKxVW8Jr
	0_Cr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj
	6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr
	0_Gr1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7MxkF7I0En4kS14v2
	6r126r1DMxkIecxEwVAFwVW8CwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJV
	W8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF
	1VAFwI0_JF0_Jw1lIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6x
	IIjxv20xvEc7CjxVAFwI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvE
	x4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Jr0_GrUvcSsGvfC2KfnxnU
	UI43ZEXa7VUjyE_tUUUUU==
X-CM-SenderInfo: xfkh05xxih0wo6llvhldfou0/1tbiBgsREmi7kYygswAAsT

This issue is similar to the vulnerability in the `mcp251x` driver, which 
was fixed in  03c427147b2d("can: mcp251x: fix resume from sleep before 
 interface was brought up").

In the `hi311x` driver, when the device resumes from sleep, the driver 
schedules `priv->restart_work`. However, if the network interface was 
not previously enabled, the `priv->wq` (workqueue) is not allocated and 
initialized, leading to a null pointer dereference.

To fix this, we move the allocation and initialization of the workqueue 
from the `hi3110_open` function to the `hi3110_can_probe` function. 
This ensures that the workqueue is properly initialized before it is 
used during device resume. And added logic to destroy the workqueue 
in the error handling paths of `hi3110_can_probe` and in the 
`hi3110_can_remove` function to prevent resource leaks.

Signed-off-by: Chen Yufeng <chenyufeng@iie.ac.cn>
---
 drivers/net/can/spi/hi311x.c | 33 +++++++++++++++++----------------
 1 file changed, 17 insertions(+), 16 deletions(-)

diff --git a/drivers/net/can/spi/hi311x.c b/drivers/net/can/spi/hi311x.c
index 09ae218315d7..b63687238d84 100644
--- a/drivers/net/can/spi/hi311x.c
+++ b/drivers/net/can/spi/hi311x.c
@@ -545,8 +545,6 @@ static int hi3110_stop(struct net_device *net)
 
 	priv->force_quit = 1;
 	free_irq(spi->irq, priv);
-	destroy_workqueue(priv->wq);
-	priv->wq = NULL;
 
 	mutex_lock(&priv->hi3110_lock);
 
@@ -770,34 +768,23 @@ static int hi3110_open(struct net_device *net)
 		goto out_close;
 	}
 
-	priv->wq = alloc_workqueue("hi3110_wq", WQ_FREEZABLE | WQ_MEM_RECLAIM,
-				   0);
-	if (!priv->wq) {
-		ret = -ENOMEM;
-		goto out_free_irq;
-	}
-	INIT_WORK(&priv->tx_work, hi3110_tx_work_handler);
-	INIT_WORK(&priv->restart_work, hi3110_restart_work_handler);
-
 	ret = hi3110_hw_reset(spi);
 	if (ret)
-		goto out_free_wq;
+		goto out_free_irq;
 
 	ret = hi3110_setup(net);
 	if (ret)
-		goto out_free_wq;
+		goto out_free_irq;
 
 	ret = hi3110_set_normal_mode(spi);
 	if (ret)
-		goto out_free_wq;
+		goto out_free_irq;
 
 	netif_wake_queue(net);
 	mutex_unlock(&priv->hi3110_lock);
 
 	return 0;
 
- out_free_wq:
-	destroy_workqueue(priv->wq);
  out_free_irq:
 	free_irq(spi->irq, priv);
 	hi3110_hw_sleep(spi);
@@ -908,6 +895,15 @@ static int hi3110_can_probe(struct spi_device *spi)
 	if (ret)
 		goto out_clk;
 
+	priv->wq = alloc_workqueue("hi3110_wq", WQ_FREEZABLE | WQ_MEM_RECLAIM,
+				   0);
+	if (!priv->wq) {
+		ret = -ENOMEM;
+		goto out_free_irq;
+	}
+	INIT_WORK(&priv->tx_work, hi3110_tx_work_handler);
+	INIT_WORK(&priv->restart_work, hi3110_restart_work_handler);
+
 	priv->spi = spi;
 	mutex_init(&priv->hi3110_lock);
 
@@ -943,6 +939,8 @@ static int hi3110_can_probe(struct spi_device *spi)
 	return 0;
 
  error_probe:
+	destroy_workqueue(priv->wq);
+	priv->wq = NULL;
 	hi3110_power_enable(priv->power, 0);
 
  out_clk:
@@ -963,6 +961,9 @@ static void hi3110_can_remove(struct spi_device *spi)
 
 	hi3110_power_enable(priv->power, 0);
 
+	destroy_workqueue(priv->wq);
+	priv->wq = NULL;
+
 	clk_disable_unprepare(priv->clk);
 
 	free_candev(net);
-- 
2.34.1


