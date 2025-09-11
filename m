Return-Path: <linux-can+bounces-4667-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E28A7B536F6
	for <lists+linux-can@lfdr.de>; Thu, 11 Sep 2025 17:08:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A22A05822A4
	for <lists+linux-can@lfdr.de>; Thu, 11 Sep 2025 15:08:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9E5934572E;
	Thu, 11 Sep 2025 15:08:41 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from cstnet.cn (smtp21.cstnet.cn [159.226.251.21])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8D863D76
	for <linux-can@vger.kernel.org>; Thu, 11 Sep 2025 15:08:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757603321; cv=none; b=gElA+ZQ4VRlNXxyoAyk5mVlaL7ijb5V7uiaB3h6TeoT8D/CDvxbjrfMnhHy2tyAUy+E4ycGSgOBbyXzBYV+HRrBjN7yo2Ob3pkI0smSkk+uSnEyvFdGlNZMGvCRFkMpnfbCnLrYDq227phrk2ooH0qL9YzXThGzqiQ63UT1dtAg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757603321; c=relaxed/simple;
	bh=UgQMB6QTzrAO9fWGc+nthuK5Hive2S2mYZGFMi2rt+c=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=XNRFLSOnUyNETLF8TacUF03q3SHGVcAXIAaNKcwoXvxaMh3bRgtNpxixiIMEgS/IuMvkhTFiiUYf7zLvfzzipp1KTM6OItZYO0urFyeYwOYuQh+AuxaODXauYxIhlhGXi7bNtIdLm5yvUY03gDpnhTWqVpqY8MANafg9uHP9lKc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iie.ac.cn; spf=pass smtp.mailfrom=iie.ac.cn; arc=none smtp.client-ip=159.226.251.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iie.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iie.ac.cn
Received: from localhost.localdomain (unknown [159.226.95.28])
	by APP-01 (Coremail) with SMTP id qwCowABnvqDv5cJoxNZMAg--.1317S2;
	Thu, 11 Sep 2025 23:08:31 +0800 (CST)
From: Chen Yufeng <chenyufeng@iie.ac.cn>
To: mkl@pengutronix.de
Cc: linux-can@vger.kernel.org,
	Chen Yufeng <chenyufeng@iie.ac.cn>
Subject: [PATCH v2] can: hi311x: fix null pointer dereference when resuming from sleep before interface was enabled
Date: Thu, 11 Sep 2025 23:08:20 +0800
Message-ID: <20250911150820.250-1-chenyufeng@iie.ac.cn>
X-Mailer: git-send-email 2.43.0.windows.1
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qwCowABnvqDv5cJoxNZMAg--.1317S2
X-Coremail-Antispam: 1UD129KBjvJXoWxWF1DGw47CFyUAw1kZw47urg_yoW5ZFWUpw
	sIvryFyrZ7Jr409an5Xw4UXFn8Wa18W3W8CFy7Ww48Xw13CFyvga40vFWjqrZ3AFWFvFWa
	kFWDX39xGF1DZ37anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUkS14x267AKxVWUJVW8JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26r1j6r1xM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r1j
	6r4UM28EF7xvwVC2z280aVAFwI0_Cr1j6rxdM28EF7xvwVC2z280aVCY1x0267AKxVW0oV
	Cq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0
	I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r
	4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwCY02Avz4vE14v_XrWl
	42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJV
	WUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1Y6r17MIIYrxkI7VAK
	I48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r
	4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY
	6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjfU1uWlUUUUU
X-CM-SenderInfo: xfkh05xxih0wo6llvhldfou0/1tbiCQ4CEmjCjOv+IgABsH

This issue is similar to the vulnerability in the `mcp251x` driver, which 
was fixed in commit 03c427147b2d ("can: mcp251x: fix resume from sleep before 
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
Changes in v2:
- Use the right goto label in hi3110_can_probe()

 drivers/net/can/spi/hi311x.c | 33 +++++++++++++++++----------------
 1 file changed, 17 insertions(+), 16 deletions(-)

diff --git a/drivers/net/can/spi/hi311x.c b/drivers/net/can/spi/hi311x.c
index 09ae218315d7..96bef8f384c4 100644
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
+		goto out_clk;
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


