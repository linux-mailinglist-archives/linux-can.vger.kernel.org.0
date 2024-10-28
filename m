Return-Path: <linux-can+bounces-1810-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 615109B37F0
	for <lists+linux-can@lfdr.de>; Mon, 28 Oct 2024 18:41:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 20E2D28290C
	for <lists+linux-can@lfdr.de>; Mon, 28 Oct 2024 17:41:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E11C81E0493;
	Mon, 28 Oct 2024 17:40:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="zwdpxeW/"
X-Original-To: linux-can@vger.kernel.org
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15ADC1DFDB7
	for <linux-can@vger.kernel.org>; Mon, 28 Oct 2024 17:40:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730137229; cv=none; b=pnHAT1Tk2/BHcnBNAQgDvylI6LgoFhSKovKt6uJ2yJYelrmtGWoJRleQA2zW7AOJozPUreFhLZDZ648Qd2nQ2dBuL3iqOf/Fsk/I9MnU3fWqVl9wzPfKns7e0Ew7V7hcmNYOl/kVSjWOOhIT4ygYqr3DzJtLGKY8PRferRhVkpc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730137229; c=relaxed/simple;
	bh=4LejsatiaRcX2zgFBZl/CQNpfL8Zgty2MrObjJLOJXU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=L8mPClsJwQpsaJ6OtMp13kazQPdJqKbD2chR3wnkIbDlDJyEPREz+qIlfaWh860/MhMyh/2RCVEXM3sM9HOYre9w3ROA6iOYiwVwiWn9mdMabyxa9YsptNojy9H9aySYN/2s+hWmnzFiSrc+b9XPVToUH7NOQuz00neDTpXhZk4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=zwdpxeW/; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-3807dd08cfcso560842f8f.1
        for <linux-can@vger.kernel.org>; Mon, 28 Oct 2024 10:40:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1730137224; x=1730742024; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fPlAnibnmD1fnySJZSs640gnIf/nP26iEQ1zSenIATs=;
        b=zwdpxeW/STgBOsoqkOjfZ8CGPP8R4qUiq6bUGGkiyyeAvTo71BIFNBbbs9GdNmxJDD
         mf2FjrHz+p3UFILJhfuFYx4OFkLyDzZJrjTjXN4rZKSnmTKJGsfMpOqgeWIATfgf4Wpv
         Mf3vvY/Knagtx6H1edZX4WvqYVZOvInNJe3CKYb/EiEk7HNwU5a46Ki3t5DRlH0GGmOr
         EmhRj5guFGLjP7BObL1yNtqntC+6GQCfIhMUWxkhnfGSEoh71WWg7e4e8nLTsA0vocCI
         K3hDh6PJrPSr1E29EQHHJHxwJqMwCLA3NFAFb/6ldah+yTUJ+Qy2lA3xk2oVLKWlmpcV
         Plyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730137224; x=1730742024;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fPlAnibnmD1fnySJZSs640gnIf/nP26iEQ1zSenIATs=;
        b=OeWMqvJCPVz/Bk0lMH+USewkspV80f6z5nvl2esgaQ9lgJ8GEFX120iOMeeE35cpgD
         E7KCFD/KdBzm1WDsvHmkCEgn2H+eFC2QBHczimRBr27CO/avzk4QWFXcIpKYY51z2sqM
         5rxVEy5S6bK0+WvDZnULaen4KLJo29VNv+kpUrbfiLjmKE78/WDlO8aGTDyZcPwN1q6f
         8huMFKjKGjIsHXr5vneqAV2gTs29s9Kj/XH8jhDseMnvGWd+cnFibdb3/7RFXAPuQLVp
         wSlwZTF37tPe62lRGhFDFTIc6sxqBSSjlmyl2W9dmymmUBCKQb0VXV6VlYuYXK2aP/aw
         n5mw==
X-Gm-Message-State: AOJu0YyZhHoRLc+2DcKrDH7sIc49mJX/HsOXKK9mJaDlbuv43RUJwYuJ
	tLOX2d6phzUmTNNcaLUA6PNWL7fhdW0/zFt89vk4rQMA5yayADQNsRHBHGKwTxU=
X-Google-Smtp-Source: AGHT+IHK6xiZTRx/ZH4MVy2X0svjOnw4jE7voI4s3c0JLrRDquRo8a/+4WCEh7ljG+D+BHZxsVc0Hg==
X-Received: by 2002:a05:6000:1a44:b0:37d:53d1:84f2 with SMTP id ffacd0b85a97d-3806114091cmr8424440f8f.11.1730137224125;
        Mon, 28 Oct 2024 10:40:24 -0700 (PDT)
Received: from localhost ([2001:4091:a245:81f4:340d:1a9d:1fa6:531f])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38058b4e56csm10119427f8f.65.2024.10.28.10.40.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Oct 2024 10:40:23 -0700 (PDT)
From: Markus Schneider-Pargmann <msp@baylibre.com>
Date: Mon, 28 Oct 2024 18:38:10 +0100
Subject: [PATCH v5 4/9] can: m_can: Return ERR_PTR on error in allocation
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241028-topic-mcan-wakeup-source-v6-12-v5-4-33edc0aba629@baylibre.com>
References: <20241028-topic-mcan-wakeup-source-v6-12-v5-0-33edc0aba629@baylibre.com>
In-Reply-To: <20241028-topic-mcan-wakeup-source-v6-12-v5-0-33edc0aba629@baylibre.com>
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
 h=from:subject:message-id; bh=4LejsatiaRcX2zgFBZl/CQNpfL8Zgty2MrObjJLOJXU=;
 b=owGbwMvMwCGm0rPl0RXRdfaMp9WSGNLlz8RXnd/0e1lXZ4945vpslqasUylSMo9X/TryWObo3
 +sJd99c6yhlYRDjYJAVU2S5+2Hhuzq56wsi1j1yhJnDygQyhIGLUwAmwrOdkeFT+WlNu3fmJ6f1
 /U8NkrnPql+fc0/7dYX4mnuywvMeSr1n+Gdx6s/7C34bXVd+0z1q3vjk3tUetZh3E29yJnHvX/v
 z5R5GAA==
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
index b358b60a1dee0f39aba9e2ec89dcbd0d65cd7823..b7e350ff64cb9cc706b7d53321dffaa079f3a8c0 100644
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


