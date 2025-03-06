Return-Path: <linux-can+bounces-2992-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 044FDA548EE
	for <lists+linux-can@lfdr.de>; Thu,  6 Mar 2025 12:17:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 603461894AF4
	for <lists+linux-can@lfdr.de>; Thu,  6 Mar 2025 11:17:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 314BC20B7F8;
	Thu,  6 Mar 2025 11:16:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="a4iDmv7f"
X-Original-To: linux-can@vger.kernel.org
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EC8820AF9F
	for <linux-can@vger.kernel.org>; Thu,  6 Mar 2025 11:16:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741259766; cv=none; b=htRV7PxSdgVwbyV+Bj3GkrfNyfOmLsAcVw2aGrpCh9X9XVw16nynVsW5/0c9fvMR1gHBpWPfLhmUBsO6YKGL6EXOsO4qr3sX5g9yTtHleGAsLtiIAtEM4ijwXuW37QxBUiyPa8BdbskxIR9UERXIiqboGD9zhPI2jpvNDX2xbNY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741259766; c=relaxed/simple;
	bh=fPymUYl9ngaWf3SHgyvMGysC90ZPypUMCZh825GprU8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=qtufm4xFCBAHIDapabQt5eam1yk8ZoEAI7jJ6oCmzp2TyduNDOI5VCcEBt3zKXNjI1c84A4EpN85eXJzmuLojf6aveuUAou4XEzXVY65uSzWOtx+5r+vItZ6Wc5P0tnbJ9a0TCePXwgB+T82vteqkFXaefSbzP8W452gd5apSyE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=a4iDmv7f; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-ab771575040so329526266b.1
        for <linux-can@vger.kernel.org>; Thu, 06 Mar 2025 03:16:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1741259762; x=1741864562; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nKABIWtcV5iN1s5ZB+QKBynZqHqAumHFyPcKwtZx728=;
        b=a4iDmv7f+OxBk+LxTQjILHdDQ0dJG6JjsSOngPqgOg7/g6/dzuH6y5PcEJMT/JAe8a
         9ITWNulBjtWDXF3t2wn3yNWPavnqRgV0csKibJIuNSLYJCANcvKHa1roCUxrN4C93Wao
         eUt76uXp2PxFLHfY7kgL1w8wVFCU6hFc3Hpe6gVZfg0bbQzJHtNrVIY71Uu3aIzMnEml
         BOJeUhfw8NvvO2d9HM6mp92ynmTDkkmfvForEGI1NK3dZNSLY1+DV7up6NpLnodNidfx
         633pYyvqJ9+gAmWc/q2IEJtFJ+TXnWoe2uUAH9DsJO7J45Mj6uncFa9/R9T5ejVdprZg
         uH5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741259762; x=1741864562;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nKABIWtcV5iN1s5ZB+QKBynZqHqAumHFyPcKwtZx728=;
        b=W0athAIuFcfEo6I1Zx9Edk/zlctumJZzjanb6FtKLsE5eqlu8rQ3CXOnNKC/F2jf5A
         5avBbq4YmSJp10J7aMZsF/UK/sa+pB/vZ6XU7p9PoN07OyBm+xv34eThfKuJN3U1NAYo
         XEbvtkx+kHablmOXtgpCNDdMCfkh1+3iEN8MkleFPduFJLbPfI4S33OMc5fmZyVsnRLk
         TcmIz+cHcJ0MWsf311CjV+8FW6HrQdU+8i+KDSAhmcXvc76/5pwohBDVsBbrNY9kcyEG
         8N0eoC9d4ZU5sYoqMBooBkFoHTS4Da49ySYQP9oYEG7xbiyN3XiZ2PkYLMaIZptI+Ng8
         b8OA==
X-Forwarded-Encrypted: i=1; AJvYcCUPCMy/4WmuPiWglRykTPHJiCpgEE1o3fUr4IXGMLIZcVkHx2dPrswyEQvr5L4l8FLumGvqh2nM83k=@vger.kernel.org
X-Gm-Message-State: AOJu0YwKiq/lT2gZKqwDOP83Ch/aDkkYI1W/YCs1wtQvOB//0fzIR4Po
	E7AgPH+2SfDfZqBFmBtlwR3ia/swYWZQGtttAontT0L3wsuOnmMFcJvVjCOxY9s=
X-Gm-Gg: ASbGnctP4PjWIui4ZcGfHay9nAGLEeujCHtJIsc1fjwIrbEn/8Wroqdl+vhFoYb68iW
	01WYJMjroq0EenH1LMJmqN6u9tF4ICb5r8zJGGg5lm0D9bX9qFegIDQxuc/QrKy5qXwjz6fXssg
	XbL4Q2ufgyimS81fiOUXh/Um6zR3VC+qMj4etYGzVM+GNA+O4JpC875JcV/V+jw6UqBPkByTQ6O
	wN+HRhky4uu740nTwez68mmeJjIOXugbWzMZqO8FConwzzSkX/nbd2Pre2kIEAg1pqR9xbFbsv8
	dBziDbdaSDmvsp8cIZz9hmhdNkfsM4eCDFjMsRg03Q==
X-Google-Smtp-Source: AGHT+IFzQjVI6La/fumbYhe/tIf2DHPmT0/Tg7rUjpYZXnegofxlVrDrXprOyMSVtKs+Ncydte7CDQ==
X-Received: by 2002:a17:906:c142:b0:abf:7a26:c473 with SMTP id a640c23a62f3a-ac22cba0296mr292630166b.13.1741259762247;
        Thu, 06 Mar 2025 03:16:02 -0800 (PST)
Received: from localhost ([2001:4091:a245:8327:80ad:8144:3b07:4679])
        by smtp.gmail.com with UTF8SMTPSA id a640c23a62f3a-ac239482096sm80348766b.54.2025.03.06.03.16.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Mar 2025 03:16:01 -0800 (PST)
From: Markus Schneider-Pargmann <msp@baylibre.com>
Date: Thu, 06 Mar 2025 12:14:43 +0100
Subject: [PATCH v5 05/13] can: m_can: Return ERR_PTR on error in allocation
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250306-topic-am62-partialio-v6-12-b4-v5-5-f9323d3744a2@baylibre.com>
References: <20250306-topic-am62-partialio-v6-12-b4-v5-0-f9323d3744a2@baylibre.com>
In-Reply-To: <20250306-topic-am62-partialio-v6-12-b4-v5-0-f9323d3744a2@baylibre.com>
To: Nishanth Menon <nm@ti.com>, Tero Kristo <kristo@kernel.org>, 
 Santosh Shilimkar <ssantosh@kernel.org>, 
 Vignesh Raghavendra <vigneshr@ti.com>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Anand Gadiyar <gadiyar@ti.com>, 
 Chandrasekar Ramakrishnan <rcsekar@samsung.com>, 
 Marc Kleine-Budde <mkl@pengutronix.de>, 
 Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 devicetree@vger.kernel.org, Vishal Mahaveer <vishalm@ti.com>, 
 Kevin Hilman <khilman@baylibre.com>, Dhruva Gole <d-gole@ti.com>, 
 Akashdeep Kaur <a-kaur@ti.com>, Kendall Willis <k-willis@ti.com>, 
 linux-can@vger.kernel.org, Markus Schneider-Pargmann <msp@baylibre.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3520; i=msp@baylibre.com;
 h=from:subject:message-id; bh=fPymUYl9ngaWf3SHgyvMGysC90ZPypUMCZh825GprU8=;
 b=owGbwMvMwCGm0rPl0RXRdfaMp9WSGNJPNh94ufOPjv+RD2e8Djx/5537bMpvzlkf2iSfHpr5+
 anYpxtWcR2lLAxiHAyyYoosdz8sfFcnd31BxLpHjjBzWJlAhjBwcQrARParMzJ8iI+2fDgjeiN3
 1El57vOn5t7QYzO+uUujujv+rcOUcG1tRoYpU+48DnrfuCtm4V2B4sxvocHHjyxNYks+1xJ18c6
 tX94cAA==
X-Developer-Key: i=msp@baylibre.com; a=openpgp;
 fpr=BADD88DB889FDC3E8A3D5FE612FA6A01E0A45B41

We have more detailed error values available, return them in the core
driver and the calling drivers to return proper errors to callers.

Reviewed-by: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Signed-off-by: Markus Schneider-Pargmann <msp@baylibre.com>
---
 drivers/net/can/m_can/m_can.c          | 6 +++---
 drivers/net/can/m_can/m_can_pci.c      | 4 ++--
 drivers/net/can/m_can/m_can_platform.c | 4 ++--
 drivers/net/can/m_can/tcan4x5x-core.c  | 4 ++--
 4 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/net/can/m_can/m_can.c b/drivers/net/can/m_can/m_can.c
index 20f7533ad9e7735013ff000e6f3b11d016f8a09f..20fbef50db20ab5cea5afe4c44fda8b03e5c8c85 100644
--- a/drivers/net/can/m_can/m_can.c
+++ b/drivers/net/can/m_can/m_can.c
@@ -2392,7 +2392,7 @@ struct m_can_classdev *m_can_class_allocate_dev(struct device *dev,
 					     sizeof(mram_config_vals) / 4);
 	if (ret) {
 		dev_err(dev, "Could not get Message RAM configuration.");
-		goto out;
+		return ERR_PTR(ret);
 	}
 
 	if (dev->of_node && of_property_read_bool(dev->of_node, "wakeup-source"))
@@ -2407,7 +2407,7 @@ struct m_can_classdev *m_can_class_allocate_dev(struct device *dev,
 	net_dev = alloc_candev(sizeof_priv, tx_fifo_size);
 	if (!net_dev) {
 		dev_err(dev, "Failed to allocate CAN device");
-		goto out;
+		return ERR_PTR(-ENOMEM);
 	}
 
 	class_dev = netdev_priv(net_dev);
@@ -2416,7 +2416,7 @@ struct m_can_classdev *m_can_class_allocate_dev(struct device *dev,
 	SET_NETDEV_DEV(net_dev, dev);
 
 	m_can_of_parse_mram(class_dev, mram_config_vals);
-out:
+
 	return class_dev;
 }
 EXPORT_SYMBOL_GPL(m_can_class_allocate_dev);
diff --git a/drivers/net/can/m_can/m_can_pci.c b/drivers/net/can/m_can/m_can_pci.c
index 9ad7419f88f83016e93667f4847fe536eca39ad1..eb31ed1f964491ab41c7811be317706a09951390 100644
--- a/drivers/net/can/m_can/m_can_pci.c
+++ b/drivers/net/can/m_can/m_can_pci.c
@@ -111,8 +111,8 @@ static int m_can_pci_probe(struct pci_dev *pci, const struct pci_device_id *id)
 
 	mcan_class = m_can_class_allocate_dev(&pci->dev,
 					      sizeof(struct m_can_pci_priv));
-	if (!mcan_class)
-		return -ENOMEM;
+	if (IS_ERR(mcan_class))
+		return PTR_ERR(mcan_class);
 
 	priv = cdev_to_priv(mcan_class);
 
diff --git a/drivers/net/can/m_can/m_can_platform.c b/drivers/net/can/m_can/m_can_platform.c
index b832566efda042929486578fad1879c7ad4a0cff..40bd10f71f0e2fab847c40c5bd5f7d85d3d46712 100644
--- a/drivers/net/can/m_can/m_can_platform.c
+++ b/drivers/net/can/m_can/m_can_platform.c
@@ -87,8 +87,8 @@ static int m_can_plat_probe(struct platform_device *pdev)
 
 	mcan_class = m_can_class_allocate_dev(&pdev->dev,
 					      sizeof(struct m_can_plat_priv));
-	if (!mcan_class)
-		return -ENOMEM;
+	if (IS_ERR(mcan_class))
+		return PTR_ERR(mcan_class);
 
 	priv = cdev_to_priv(mcan_class);
 
diff --git a/drivers/net/can/m_can/tcan4x5x-core.c b/drivers/net/can/m_can/tcan4x5x-core.c
index e5c162f8c589b2c75c51cd8a994fc93ab507b9dc..5523ad8c9175cacd330a330b0f45d2c6515d11fa 100644
--- a/drivers/net/can/m_can/tcan4x5x-core.c
+++ b/drivers/net/can/m_can/tcan4x5x-core.c
@@ -401,8 +401,8 @@ static int tcan4x5x_can_probe(struct spi_device *spi)
 
 	mcan_class = m_can_class_allocate_dev(&spi->dev,
 					      sizeof(struct tcan4x5x_priv));
-	if (!mcan_class)
-		return -ENOMEM;
+	if (IS_ERR(mcan_class))
+		return PTR_ERR(mcan_class);
 
 	ret = m_can_check_mram_cfg(mcan_class, TCAN4X5X_MRAM_SIZE);
 	if (ret)

-- 
2.47.2


