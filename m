Return-Path: <linux-can+bounces-5095-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E2FC0BB0B57
	for <lists+linux-can@lfdr.de>; Wed, 01 Oct 2025 16:31:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B440F2A52F3
	for <lists+linux-can@lfdr.de>; Wed,  1 Oct 2025 14:31:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 404BC266581;
	Wed,  1 Oct 2025 14:31:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="zgpoLfKm"
X-Original-To: linux-can@vger.kernel.org
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 392E5259CBD
	for <linux-can@vger.kernel.org>; Wed,  1 Oct 2025 14:31:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759329080; cv=none; b=KgXehmqatsT8hKlYGNqW6ccUxM8et7qwPO519St8P/2QvRA3z3TCTzJpflsOvX7GGcBHhM5dGEVQhm6Bf6oSYyysjAQ3WvAtEw8kgtD8IebsOcRgURL5AGXDygp2nz/g2oqezmZosQoBQGiuf1sxuVeVfo3fqTkNotx7vFED1Uo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759329080; c=relaxed/simple;
	bh=/yHKEt8Rr3If5+tCEsC8wZyogE4OT/kjZ3EpKwOUyqs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=IQl12JlvGkbOnHEfDGu/sM2l3Kf7K83Fd9s7Ww2h7uPq3x2smj+wwMRemNMvs1r7nmPZa4urqFIodj5TB14cmj9hGkXWv+j/laMQYQVA3inpbPxQ9qqUhJPa5SU3Rht8HQINkoUL5ZqRPIh++9O7N/FSnSAEaBijh+piz82RCmI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=zgpoLfKm; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-636255b92c9so8218901a12.3
        for <linux-can@vger.kernel.org>; Wed, 01 Oct 2025 07:31:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1759329076; x=1759933876; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KdLivDeTnVnUn8n9mNOw+X9zdT6wYP2WdyrL7Td1u1I=;
        b=zgpoLfKmEYIAU/+0hPxGiBxuoNwqGSviImdC1muzFym6zUgFrYK9+yd4Y6i9n2bOUK
         rNYNfpu5mnUMXtj2hW0R6sSdIX3AXdtOB9turOUN/Jtxj1kljfioTEdrv/u3Ji+zh93Y
         bhczpFTJ1u4dUUNYhsO52L6HfaEsMyYJSi4/oMquDiSBqyLaaDoUJVIxydg0cv4TQSrL
         gQ5gcJhO/ThfE1/qEXIyqZsuHAoGp+9oGgVfmmJVWq7OJT+CohEVYDpgrJkt4r/nAvLS
         O2kZlwPReGxiBRpf342k/i2/U8o/cybYwJvbeU+S/zuhZje+I8BOScfko+DtEz4R+btS
         GFQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759329076; x=1759933876;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KdLivDeTnVnUn8n9mNOw+X9zdT6wYP2WdyrL7Td1u1I=;
        b=RexN29FidX0B6b8hRMLQWjN0HehBhGXYJX0bcY7fkBAQtXGdJSwQ6FETWgL8iZcMOS
         x9DzfCcWKxtqKxAxB1815AXat/mOYfqvae/OdGKUdBnWS2qR+w837Y3RYNfQQIh+mLHJ
         7oynFy/kchr3iScGbFfP5KRT/Dy3Uku92bHJaxvv/v8Hez4Obhro0M0wHQFS+4irtDrm
         gRZdeq1SmPhL3D7zMtkscNDyHoJGgcP0r5TBdnzavpgrcB8N06R5LzPj1fMogpW+8KK2
         K3+Br0Hm72dA1EGlfQiH/hfZ6qDzZ6nJLkf8LWBWUxjL1sH6DD78R4y2QCAOPbZlv6Dx
         v+rw==
X-Forwarded-Encrypted: i=1; AJvYcCVWuq+kpB+NklUS8lKaBgxWNvURn5RufBscon68NReVvjSLIbrQ4uJtQwcwltcIxApg2LKxpXhR+Tk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy+PW95ziph2ELordWJCn/jbSigEHMrvAKlcVw6et+Doa4AF8XP
	lXrRG7ZzmP+Biw6Uelcz+x1TRWwIsIh/ciGTdTxM0PF37X34n3eY/ghFncu5lOf8irY=
X-Gm-Gg: ASbGncucPL/ku2+17y8AuOBFZKfOKjQpc/R/QcMnu0F9DZGKEhANlJmbqHEvMMXVXoY
	y7FkL77FZprDXlohcAUmRH7E5nrK+oC/AIusuWB5MjwyN3odal/hd6gp9oO1hBGf5cEC2HgUFAu
	7iZ3SyFNHGS0ggcM/ScHA7Q3n4U8xM36r1xXWk+U9zS5vqCJ/tbo6lee0GKw1DFIeZz5RMRpMSL
	8shcBuJ8qTKcXHX0XDPQ7ZmqFu0QP/BzUFdDiX047Cv/FYrDhK1ARWdHNV8/tdauNcDsAvd/74f
	IDBPJ1xN0xhkn4xYDxZAINIzzZ6+A1nB8xXPJwqGi1kFy5tQUaY0VKNBkfyXFKmnTCsa16tZuYw
	Bf24DcQoabpg88YTfaHAfDrxIGvloudYc/Rx5K5o/Eg6k
X-Google-Smtp-Source: AGHT+IG6BwWH7BIiNil/oxI6lXTRQcMIxSU1UVN3zv7lET+I9q0q8YQGGQOkk3j2gMWSrAXuAlej1Q==
X-Received: by 2002:a05:6402:5246:b0:62f:a3ae:ff0d with SMTP id 4fb4d7f45d1cf-63678c052aemr4537082a12.14.1759329076458;
        Wed, 01 Oct 2025 07:31:16 -0700 (PDT)
Received: from localhost ([2001:4090:a245:8496:49da:2c07:5e9a:7fb9])
        by smtp.gmail.com with UTF8SMTPSA id 4fb4d7f45d1cf-634a3339b63sm11684228a12.0.2025.10.01.07.31.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Oct 2025 07:31:15 -0700 (PDT)
From: "Markus Schneider-Pargmann (TI.com)" <msp@baylibre.com>
Date: Wed, 01 Oct 2025 16:30:21 +0200
Subject: [PATCH v10 3/4] can: m_can: Return ERR_PTR on error in allocation
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251001-topic-mcan-wakeup-source-v6-12-v10-3-4ab508ac5d1e@baylibre.com>
References: <20251001-topic-mcan-wakeup-source-v6-12-v10-0-4ab508ac5d1e@baylibre.com>
In-Reply-To: <20251001-topic-mcan-wakeup-source-v6-12-v10-0-4ab508ac5d1e@baylibre.com>
To: Chandrasekar Ramakrishnan <rcsekar@samsung.com>, 
 Marc Kleine-Budde <mkl@pengutronix.de>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Vincent Mailhol <mailhol@kernel.org>
Cc: Vishal Mahaveer <vishalm@ti.com>, Kevin Hilman <khilman@baylibre.com>, 
 Dhruva Gole <d-gole@ti.com>, Sebin Francis <sebin.francis@ti.com>, 
 Kendall Willis <k-willis@ti.com>, Akashdeep Kaur <a-kaur@ti.com>, 
 Simon Horman <horms@kernel.org>, linux-can@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 "Markus Schneider-Pargmann (TI.com)" <msp@baylibre.com>, 
 Vincent Mailhol <mailhol@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3638; i=msp@baylibre.com;
 h=from:subject:message-id; bh=/yHKEt8Rr3If5+tCEsC8wZyogE4OT/kjZ3EpKwOUyqs=;
 b=owGbwMvMwCXWejAsc4KoVzDjabUkhoy71oqKH13SVljILTb0bGvbWP3z7s2Ijpuxs2aW2vLH3
 977Mu97RykLgxgXg6yYIktnYmjaf/mdx5IXLdsMM4eVCWQIAxenAEzkmhvDP9vj0xeli9Q+e3xk
 asSsHvc135Zkt7m7eBdsn5fW58n28AfD/7y003VaTWxPnjasL/evTis6r3nSTEl2DdPj5VcXNHz
 3ZQQA
X-Developer-Key: i=msp@baylibre.com; a=openpgp;
 fpr=BADD88DB889FDC3E8A3D5FE612FA6A01E0A45B41

We have more detailed error values available, return them in the core
driver and the calling drivers to return proper errors to callers.

Reviewed-by: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Reviewed-by: Dhruva Gole <d-gole@ti.com>
Reviewed-by: Kendall Willis <k-willis@ti.com>
Signed-off-by: Markus Schneider-Pargmann (TI.com) <msp@baylibre.com>
---
 drivers/net/can/m_can/m_can.c          | 6 +++---
 drivers/net/can/m_can/m_can_pci.c      | 4 ++--
 drivers/net/can/m_can/m_can_platform.c | 4 ++--
 drivers/net/can/m_can/tcan4x5x-core.c  | 4 ++--
 4 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/net/can/m_can/m_can.c b/drivers/net/can/m_can/m_can.c
index e5588e2205797be03090a7317e9d3518bc09b054..835b03db1003db6ffa21044ac756676fb193f64d 100644
--- a/drivers/net/can/m_can/m_can.c
+++ b/drivers/net/can/m_can/m_can.c
@@ -2390,7 +2390,7 @@ struct m_can_classdev *m_can_class_allocate_dev(struct device *dev,
 					     sizeof(mram_config_vals) / 4);
 	if (ret) {
 		dev_err(dev, "Could not get Message RAM configuration.");
-		goto out;
+		return ERR_PTR(ret);
 	}
 
 	if (dev->of_node && of_property_read_bool(dev->of_node, "wakeup-source"))
@@ -2405,7 +2405,7 @@ struct m_can_classdev *m_can_class_allocate_dev(struct device *dev,
 	net_dev = alloc_candev(sizeof_priv, tx_fifo_size);
 	if (!net_dev) {
 		dev_err(dev, "Failed to allocate CAN device");
-		goto out;
+		return ERR_PTR(-ENOMEM);
 	}
 
 	class_dev = netdev_priv(net_dev);
@@ -2415,7 +2415,7 @@ struct m_can_classdev *m_can_class_allocate_dev(struct device *dev,
 
 	m_can_of_parse_mram(class_dev, mram_config_vals);
 	spin_lock_init(&class_dev->tx_handling_spinlock);
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
index 39b0b5277b11f5cf86137528e7ebea93a6d29c80..31cc9d0abd45360de8700d0a0270af8d3e42967d 100644
--- a/drivers/net/can/m_can/tcan4x5x-core.c
+++ b/drivers/net/can/m_can/tcan4x5x-core.c
@@ -416,8 +416,8 @@ static int tcan4x5x_can_probe(struct spi_device *spi)
 
 	mcan_class = m_can_class_allocate_dev(&spi->dev,
 					      sizeof(struct tcan4x5x_priv));
-	if (!mcan_class)
-		return -ENOMEM;
+	if (IS_ERR(mcan_class))
+		return PTR_ERR(mcan_class);
 
 	ret = m_can_check_mram_cfg(mcan_class, TCAN4X5X_MRAM_SIZE);
 	if (ret)

-- 
2.51.0


