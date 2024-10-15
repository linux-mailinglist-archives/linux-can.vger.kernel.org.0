Return-Path: <linux-can+bounces-1700-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A4D4199F700
	for <lists+linux-can@lfdr.de>; Tue, 15 Oct 2024 21:18:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5B5A228282E
	for <lists+linux-can@lfdr.de>; Tue, 15 Oct 2024 19:18:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C60FA1F8F08;
	Tue, 15 Oct 2024 19:17:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="juhgP7ay"
X-Original-To: linux-can@vger.kernel.org
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D91B31F76C1
	for <linux-can@vger.kernel.org>; Tue, 15 Oct 2024 19:17:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729019837; cv=none; b=Tk8xt2F/5dGlxMh2/OvNnQnHh260W7wCMvzylwAkjXDFztwSqmbLug1MQxd+G0Qmn/8YyXhJtb1+AmKdnqgh4NZkGy8zZgTRTBb6Sy1Y6GnvTkJ2eBRe0hCKQgHbUlxT1IGca3fAyd7znGZQ8DRzRRysEdXCz11Kx5g8gikUj4Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729019837; c=relaxed/simple;
	bh=FuSyoKzeygeLVHKVCKFUjItYDNK1CDXLTHh7H2UiD20=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=A3zXQpjjVJmm4ms7OBm9Bt9FzG0ALtH2Jxcn/uJ5T/Bv0UchYGZn3J+Ym14sYHQHBxvSQsY+i2MasciPDALPPPHkgnJ1pxBXJOt9fdXkAwxSlKpmNdfXRQLaSgMHqqdm1/b5oVwLEVWt35ww/aoA62hhEn+v5ZvpyU600WeI2yI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=juhgP7ay; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-a9a0c7abaa6so362820766b.2
        for <linux-can@vger.kernel.org>; Tue, 15 Oct 2024 12:17:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1729019834; x=1729624634; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=I+gZxIafqFrR6BMcHIhEjszPUzk8N9qpO7jS8LguSsI=;
        b=juhgP7ayi+LvA9yf0QMl8vCElhNfhgE+RsR56GzWQDqX3zJhpuzpaI3DWwTzZ3P5Ab
         uquwk+sENmZDyDHynds7wiEiII7JsskWwuboiH0eJcPrvsKi5CejsAKZNg+BKSD4YQwM
         jjBIZyy0FyCBapLvQ/eOYsu5LT0ANr/tNoeiBovWdhk4cdn1UGHGPBrug5Y6FqdS3xpB
         FnqFygrbHrIBCYN8s/Twh3eFgJgeoz4up26A0xO/n9h+5CbBDliHVft0TYpgrv1FCsdT
         YKrMbXrvXuv+Ak3vx3wUF2h3cZjxXe16AxB5V7lsGr98g5h0d1gswwZJwPfcBKjHuZmN
         Eobg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729019834; x=1729624634;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=I+gZxIafqFrR6BMcHIhEjszPUzk8N9qpO7jS8LguSsI=;
        b=oegQyvQIQAt4uft+bSwOtrpEATyY7doZO9mMdTml6OtIh7zp9vGbsTWiZJUpRk0Ieg
         V6B8CXg1rXu2+JRp46svELhkf+0frrpjkc6DECtj0wCrCj91TDizDfhxDFw03VI9OiVx
         nUVDAHuoLTlOsg1ocMBB9xLuzmBa6W4oHOi6T5fNF+GZFNp9nBXNWQc+WVK9TOPPnKaK
         3/iG03qvOwuspcFepT2mz9Su/b4rKvK30Em4FF2LJ/6WySH133FcTCz2WrJM2K/+VY8N
         pKBjNCJDGMiu7Fy0by6iJaTX1PpcbwSECW8iitfU95xJxwYiPBXQiUXiKwZtkozhB473
         BjTQ==
X-Gm-Message-State: AOJu0YxHKWXm0R6gPEPgjvhCKw8qrdjTqYkIVlJO6/XQzmRW3nxWzmNP
	lrjpVjqq0QTx65nk6yz27ddMY8vgOn+MvpEej5oTeEHs5nstuTIVgU5Kl2Aj31I=
X-Google-Smtp-Source: AGHT+IEnWhyoMdkPWKAnqSZfQ5E35xloBUwyytezjQk7zjPCXojeRmRve/u2bGJ3yuGwNR720ej3zA==
X-Received: by 2002:a17:907:f1c7:b0:a99:8a0e:8710 with SMTP id a640c23a62f3a-a99e3b5b167mr1064453866b.14.1729019834109;
        Tue, 15 Oct 2024 12:17:14 -0700 (PDT)
Received: from localhost ([2001:4090:a244:83ae:2517:2666:43c9:d0d3])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9a2988c57asm101052866b.204.2024.10.15.12.17.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Oct 2024 12:17:13 -0700 (PDT)
From: Markus Schneider-Pargmann <msp@baylibre.com>
Date: Tue, 15 Oct 2024 21:15:58 +0200
Subject: [PATCH v4 4/9] can: m_can: Return ERR_PTR on error in allocation
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241015-topic-mcan-wakeup-source-v6-12-v4-4-fdac1d1e7aa6@baylibre.com>
References: <20241015-topic-mcan-wakeup-source-v6-12-v4-0-fdac1d1e7aa6@baylibre.com>
In-Reply-To: <20241015-topic-mcan-wakeup-source-v6-12-v4-0-fdac1d1e7aa6@baylibre.com>
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
 Dhruva Gole <d-gole@ti.com>, Simon Horman <horms@kernel.org>, 
 Vincent MAILHOL <mailhol.vincent@wanadoo.fr>, 
 Markus Schneider-Pargmann <msp@baylibre.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3520; i=msp@baylibre.com;
 h=from:subject:message-id; bh=FuSyoKzeygeLVHKVCKFUjItYDNK1CDXLTHh7H2UiD20=;
 b=owGbwMvMwCGm0rPl0RXRdfaMp9WSGNL59k/z2Lj1No/cl7I9t1MUPx1QXZx7ecckPVFvB4mmI
 2vai37N7ShlYRDjYJAVU2S5+2Hhuzq56wsi1j1yhJnDygQyhIGLUwAmsnEtI8MuIZcVy569Tdhl
 d/vE54mpLC8EmrNF9zk++LzZc6pH01NORoZbyw0ily0ubKg1lLGYPcPCO03OcfI1x4lTduVd3MI
 WEsUIAA==
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
index d427645a5b3baf7d0a648e3b008d7d7de7f23374..5a4e0ad07e9ecc82de5f1f606707f3380d3679fc 100644
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


