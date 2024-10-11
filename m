Return-Path: <linux-can+bounces-1624-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C92499A4C0
	for <lists+linux-can@lfdr.de>; Fri, 11 Oct 2024 15:19:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5E93F1C22A61
	for <lists+linux-can@lfdr.de>; Fri, 11 Oct 2024 13:19:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BE6E21A70B;
	Fri, 11 Oct 2024 13:18:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="gIT8a4Wa"
X-Original-To: linux-can@vger.kernel.org
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EF94219C92
	for <linux-can@vger.kernel.org>; Fri, 11 Oct 2024 13:18:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728652687; cv=none; b=WA3/V8kRj3pf2IQXe0XuILtPW8zK2xY6mxVWqThwRBRTqxodMb9uvNPXZLbHmWa1msTWot1oXmx6lX90uUE+aITyR6aD2nC2h69LutH6fLchH2mwSDWrHZspLCX9G9KjB6LYbQjPw8Osf9vxDmhcU65l8zmiBaLmxYkm3FDa4bc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728652687; c=relaxed/simple;
	bh=Yb7+ZkGNEL4O326OlkJgvKGqwn2t7za2oUgItrtB1AA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ZJQzuTpRtWXIp9cZsg+ZBiRKzcqGFiGF4l1cD8k0vExWRirWk/zaYTSY0hpxRCDZGiRaZD+7I6MJb58kjXRBhTqnizDq6ukLkNeVlmVUkaTlkj3KgjvXIOmx4b9rDAZK6F5sxzLYOm9CsWUi49zp7HojmxQpoLTdkQ3AH+0dsYE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=gIT8a4Wa; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-5c5b954c359so2402978a12.1
        for <linux-can@vger.kernel.org>; Fri, 11 Oct 2024 06:18:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1728652684; x=1729257484; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iCNLKfw0M7WpUeLbjzkp9aabjUez3xfd1Cb1mml4nhQ=;
        b=gIT8a4WaxjpgHu8t4LniuBQw11N/vH8shdIn2pYdSwX2nK7RwYN7158C2st0sy7W/e
         xEf11Zrxqs0NtIYOdXygiYihJ1yObzEfN6kex/BdK/8fjoRlay21GEacRLhIZe4c1xew
         tD2xth4Db/NSB7mjifFxEJHLfchg7hg4aVd+/zkVI/Wk5EeY5RnNwqQQBKsMPK5DAHCl
         i713F6zihic57uk+y6WNsLE6Tgr+OCbRhVTraLo6wsZI6RRucAWYor1NbzxSmmiOi6o4
         gP+EDYWeihxnv0zNnRDJFrGdR0d9XWtvOn+VOvRzbuwohflT4aiFENS/w0wX0WdLPSha
         geug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728652684; x=1729257484;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iCNLKfw0M7WpUeLbjzkp9aabjUez3xfd1Cb1mml4nhQ=;
        b=q4uRevBJBk/9xuwNMiP1fbOP/G0ek53wxlJ2DHp+/guv/8T3D+KX6Yk1CYbbl0KmF1
         mNcMFvzHHlxaPo4GnGSmEL1h5VwRZ50d4kDwNL0Ch8ySmawlJ4nFRcLZBAFJa9+h/G1S
         clBGPmclLF4M/5mychRKHbwalZav7u5cKAesrsTjG/V9sKTtohbpz1tv1Bpn9JtUHQnK
         Q1Re9rN0KuAVF6tZpOM/VHruk631JDC4D1+uLxXTfZvg1NQvu9Q/+wcJ3n9pz/l9XXLc
         m+UCiNmvl7szrTGUyiHtiiBfG9wxfv41H253ycd+lVV/WOEi/nFX3FsnZCzlIxx+lu3F
         HgSg==
X-Gm-Message-State: AOJu0YzMiqh0gslUJv2f9ns+a8DMqT9K7fSRn2tHdO3A0W8fzCLc5roA
	fJJR37G/jBbtOm2hwZU7Xu3VafgLlzuuFJ7Os3tRFSfV4bVFIxoNWE9GTdOH5ec=
X-Google-Smtp-Source: AGHT+IFQfR6/BL+UbBnXcWXuHv+Bf9nvEzHpLlQPVU/JaI/HqDVV39oK5GhdoCm9/k00vv50syIxeA==
X-Received: by 2002:a17:907:368d:b0:a77:c95e:9b1c with SMTP id a640c23a62f3a-a99b93c1e47mr236799766b.27.1728652683727;
        Fri, 11 Oct 2024 06:18:03 -0700 (PDT)
Received: from localhost ([2001:4090:a244:83ae:2517:2666:43c9:d0d3])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a99a80f29e5sm209874466b.204.2024.10.11.06.18.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Oct 2024 06:18:03 -0700 (PDT)
From: Markus Schneider-Pargmann <msp@baylibre.com>
Date: Fri, 11 Oct 2024 15:16:41 +0200
Subject: [PATCH v3 4/9] can: m_can: Return ERR_PTR on error in allocation
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241011-topic-mcan-wakeup-source-v6-12-v3-4-9752c714ad12@baylibre.com>
References: <20241011-topic-mcan-wakeup-source-v6-12-v3-0-9752c714ad12@baylibre.com>
In-Reply-To: <20241011-topic-mcan-wakeup-source-v6-12-v3-0-9752c714ad12@baylibre.com>
To: Chandrasekar Ramakrishnan <rcsekar@samsung.com>, 
 Marc Kleine-Budde <mkl@pengutronix.de>, 
 Vincent Mailhol <mailhol.vincent@wanadoo.fr>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Nishanth Menon <nm@ti.com>, 
 Vignesh Raghavendra <vigneshr@ti.com>, Tero Kristo <kristo@kernel.org>
Cc: linux-can@vger.kernel.org, netdev@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, 
 Matthias Schiffer <matthias.schiffer@ew.tq-group.com>, 
 Vishal Mahaveer <vishalm@ti.com>, Kevin Hilman <khilman@baylibre.com>, 
 Dhruva Gole <d-gole@ti.com>, Markus Schneider-Pargmann <msp@baylibre.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3461; i=msp@baylibre.com;
 h=from:subject:message-id; bh=Yb7+ZkGNEL4O326OlkJgvKGqwn2t7za2oUgItrtB1AA=;
 b=owGbwMvMwCGm0rPl0RXRdfaMp9WSGNI5VVODT7w+FxYs9OfegbtnYh7vX1my6OWWKDnLPY/Nf
 0xWVrpm2lHKwiDGwSArpshy98PCd3Vy1xdErHvkCDOHlQlkCAMXpwBM5LAUwz/NpJMRi159XsZV
 +DXSxWhz1eH0V9azq04//uXl+jX/wLVzDL9ZFaferzTifqX/NYT/VLTz47fTH1ateGhbKPq+/0a
 Usx8rAA==
X-Developer-Key: i=msp@baylibre.com; a=openpgp;
 fpr=BADD88DB889FDC3E8A3D5FE612FA6A01E0A45B41

We have more detailed error values available, return them in the core
driver and the calling drivers to return proper errors to callers.

Signed-off-by: Markus Schneider-Pargmann <msp@baylibre.com>
---
 drivers/net/can/m_can/m_can.c          | 6 +++---
 drivers/net/can/m_can/m_can_pci.c      | 4 ++--
 drivers/net/can/m_can/m_can_platform.c | 4 ++--
 drivers/net/can/m_can/tcan4x5x-core.c  | 4 ++--
 4 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/net/can/m_can/m_can.c b/drivers/net/can/m_can/m_can.c
index 29accadc20de7e9efa509f14209cc62e599f03bb..5ab0bb3f1c71e7dc4d6144f7b9e8f58d0e0303fe 100644
--- a/drivers/net/can/m_can/m_can.c
+++ b/drivers/net/can/m_can/m_can.c
@@ -2355,7 +2355,7 @@ struct m_can_classdev *m_can_class_allocate_dev(struct device *dev,
 					     sizeof(mram_config_vals) / 4);
 	if (ret) {
 		dev_err(dev, "Could not get Message RAM configuration.");
-		goto out;
+		return ERR_PTR(ret);
 	}
 
 	if (dev->of_node && of_property_read_bool(dev->of_node, "wakeup-source"))
@@ -2370,7 +2370,7 @@ struct m_can_classdev *m_can_class_allocate_dev(struct device *dev,
 	net_dev = alloc_candev(sizeof_priv, tx_fifo_size);
 	if (!net_dev) {
 		dev_err(dev, "Failed to allocate CAN device");
-		goto out;
+		return ERR_PTR(-ENOMEM);
 	}
 
 	class_dev = netdev_priv(net_dev);
@@ -2379,7 +2379,7 @@ struct m_can_classdev *m_can_class_allocate_dev(struct device *dev,
 	SET_NETDEV_DEV(net_dev, dev);
 
 	m_can_of_parse_mram(class_dev, mram_config_vals);
-out:
+
 	return class_dev;
 }
 EXPORT_SYMBOL_GPL(m_can_class_allocate_dev);
diff --git a/drivers/net/can/m_can/m_can_pci.c b/drivers/net/can/m_can/m_can_pci.c
index d72fe771dfc7aa768c728f817e67a87b49fd9974..05a01dfdbfbf18b74f796d2efc75e2be5cbb75ed 100644
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
index 2f73bf3abad889c222f15c39a3d43de1a1cf5fbb..4c40b444727585b30df33a897c398e35e7592fb2 100644
--- a/drivers/net/can/m_can/tcan4x5x-core.c
+++ b/drivers/net/can/m_can/tcan4x5x-core.c
@@ -375,8 +375,8 @@ static int tcan4x5x_can_probe(struct spi_device *spi)
 
 	mcan_class = m_can_class_allocate_dev(&spi->dev,
 					      sizeof(struct tcan4x5x_priv));
-	if (!mcan_class)
-		return -ENOMEM;
+	if (IS_ERR(mcan_class))
+		return PTR_ERR(mcan_class);
 
 	ret = m_can_check_mram_cfg(mcan_class, TCAN4X5X_MRAM_SIZE);
 	if (ret)

-- 
2.45.2


