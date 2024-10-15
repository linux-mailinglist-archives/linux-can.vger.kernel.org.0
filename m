Return-Path: <linux-can+bounces-1701-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 98E4B99F703
	for <lists+linux-can@lfdr.de>; Tue, 15 Oct 2024 21:18:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 58AE8281B0A
	for <lists+linux-can@lfdr.de>; Tue, 15 Oct 2024 19:18:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 035DF1FAEE9;
	Tue, 15 Oct 2024 19:17:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="aRx+WeMN"
X-Original-To: linux-can@vger.kernel.org
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB8CB1F583B
	for <linux-can@vger.kernel.org>; Tue, 15 Oct 2024 19:17:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729019837; cv=none; b=pZwD/QP5UpyLk5iQMrFgJi7QRkbIn4wo8CCx7Z6zX5WU9Du2+QFbbAb3g1asSj57ezPRbvc9JWdtq9yapCYmsicf+TN+2+UnY77LiDJxBQDA9Dr+b28BB3pMDtJi4KQTYvL3iAR5sxBnJ3CAemgceg9d+4IADoiN2Zh5s+Nxp7E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729019837; c=relaxed/simple;
	bh=u3MS8m9UeG/FKMz+2aOKCV8URfG29eAzix8kKH+yzxk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=hhEKZAnhkNP6TiCOaOfQczg+P4W3svlVPONpBvEl7zI1jHVeEOR9xkCPMXesJBbS5c38Qs02NjCWtSHnNXZDpowQlJuSqSckukme0y9C8TS6iXbmsSa9324Z4q+eCOYN9HMnya6n5ZXul4SclcKVIBezuH8VvIPMaAnRWXqfmSU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=aRx+WeMN; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-a9a2cdc6f0cso149195066b.2
        for <linux-can@vger.kernel.org>; Tue, 15 Oct 2024 12:17:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1729019833; x=1729624633; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mWNsNiv/VcA8vMctiIZy19xLDs/iPmWut03+H1meriQ=;
        b=aRx+WeMNDcw4oUMj2yecYMyn8GuQMs1T05uOVYxNyL5CYOAilZtw600Q8cwMBRrMSn
         SdjQqeg+QAKJXbVy/YjiFMod7a+3GMYc54YGCsdHFwiRg3Iyhp8UL0yDFdzWwsy242p6
         Spz9PmXvR4RI8fM18I1K/4/04vmkGyn6jGWwSysdBt6gL4FhjRRfVbl2ImHsf9yWdPrv
         FGS62aCUKiYFlm7lTujED/4YXHHe7WXATmzHdpYZIL85y515v+AZSoHmWb7iHd2aElEu
         2wElNhXzqYygd8oqFhYcDYhHqxc7QGReYdqcQZk7dh73x/RiT6AiisNiThWHN1nJwVmF
         4Y7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729019833; x=1729624633;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mWNsNiv/VcA8vMctiIZy19xLDs/iPmWut03+H1meriQ=;
        b=GOhaAfa7nwAOxgsoAg7zTHZpsv9wawy5iOzXVzrso7RQmNu4hnPmeugun7o/hteQY4
         wnj1oFH4nTylFZAjUiiyuf+hmuHnjNqQ3nVzye59r5C7jl5U1X61EuyxUoCjxFrzEgxz
         C2G5TbGkxr+t+DwXMhT06E6bq1Mksyq+bfYu7YIIGROQCntGsHE+yan7Fv3dFbXR88C7
         mN9wcezHEmDRF7WzI+u10epDCSu9p+KlYNDePwkd9thF3eli+sG5zxQcXN8X047MxE3h
         tRwwyW+W+pHutM0emfRnAFAIm2djwd9paHq6sJ76bnmfaVN+3bF8JK2cOKh+0eFTN+WS
         1yQw==
X-Gm-Message-State: AOJu0YxG9ODNt7VOfE8DGBqXpDxiHvUB9svSs4xeLl4Xm11bAM8s9O/8
	NPL9ZzIrnaMpDJchxYapKWdYQKk8w1ys4aEVe21kK8OcqZgFpG+MdIEyJQf5xM0=
X-Google-Smtp-Source: AGHT+IG6Wi1Y05CbHfGWTKc2Zvkf+SR2UYH5CumYtIzfZCX8f8wWHAG3iJhGVNaioMcvfL42erh2WA==
X-Received: by 2002:a17:907:94d0:b0:a9a:e2b:170e with SMTP id a640c23a62f3a-a9a0e2b1ab5mr793919066b.10.1729019832936;
        Tue, 15 Oct 2024 12:17:12 -0700 (PDT)
Received: from localhost ([2001:4090:a244:83ae:2517:2666:43c9:d0d3])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9a29843374sm101011666b.157.2024.10.15.12.17.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Oct 2024 12:17:12 -0700 (PDT)
From: Markus Schneider-Pargmann <msp@baylibre.com>
Date: Tue, 15 Oct 2024 21:15:57 +0200
Subject: [PATCH v4 3/9] can: m_can: Map WoL to device_set_wakeup_enable
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241015-topic-mcan-wakeup-source-v6-12-v4-3-fdac1d1e7aa6@baylibre.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2797; i=msp@baylibre.com;
 h=from:subject:message-id; bh=u3MS8m9UeG/FKMz+2aOKCV8URfG29eAzix8kKH+yzxk=;
 b=owGbwMvMwCGm0rPl0RXRdfaMp9WSGNL59k90PPz83/zbxmZT0q8prg/tYjDLUb7E+uH+Ke9ZS
 Uq3Dhjc7ChlYRDjYJAVU2S5+2Hhuzq56wsi1j1yhJnDygQyhIGLUwAmIv+N4X980sdAKe+fenOi
 BPbcXe81x0oilP1I45oVa5WXOBxoP9/IyNDGrD/7x7TU6bdipAy7HDhEikS1Q0/v9ew/mdkS1qO
 nyQYA
X-Developer-Key: i=msp@baylibre.com; a=openpgp;
 fpr=BADD88DB889FDC3E8A3D5FE612FA6A01E0A45B41

In some devices the pins of the m_can module can act as a wakeup source.
This patch helps do that by connecting the PHY_WAKE WoL option to
device_set_wakeup_enable. By marking this device as being wakeup
enabled, this setting can be used by platform code to decide which
sleep or poweroff mode to use.

Also this prepares the driver for the next patch in which the pinctrl
settings are changed depending on the desired wakeup source.

Signed-off-by: Markus Schneider-Pargmann <msp@baylibre.com>
---
 drivers/net/can/m_can/m_can.c | 37 +++++++++++++++++++++++++++++++++++++
 1 file changed, 37 insertions(+)

diff --git a/drivers/net/can/m_can/m_can.c b/drivers/net/can/m_can/m_can.c
index a978b960f1f1e1e8273216ff330ab789d0fd6d51..d427645a5b3baf7d0a648e3b008d7d7de7f23374 100644
--- a/drivers/net/can/m_can/m_can.c
+++ b/drivers/net/can/m_can/m_can.c
@@ -2185,6 +2185,36 @@ static int m_can_set_coalesce(struct net_device *dev,
 	return 0;
 }
 
+static void m_can_get_wol(struct net_device *dev, struct ethtool_wolinfo *wol)
+{
+	struct m_can_classdev *cdev = netdev_priv(dev);
+
+	wol->supported = device_can_wakeup(cdev->dev) ? WAKE_PHY : 0;
+	wol->wolopts = device_may_wakeup(cdev->dev) ? WAKE_PHY : 0;
+}
+
+static int m_can_set_wol(struct net_device *dev, struct ethtool_wolinfo *wol)
+{
+	struct m_can_classdev *cdev = netdev_priv(dev);
+	bool wol_enable = !!(wol->wolopts & WAKE_PHY);
+	int ret;
+
+	if ((wol->wolopts & WAKE_PHY) != wol->wolopts)
+		return -EINVAL;
+
+	if (wol_enable == device_may_wakeup(cdev->dev))
+		return 0;
+
+	ret = device_set_wakeup_enable(cdev->dev, wol_enable);
+	if (ret) {
+		netdev_err(cdev->net, "Failed to set wakeup enable %pE\n",
+			   ERR_PTR(ret));
+		return ret;
+	}
+
+	return 0;
+}
+
 static const struct ethtool_ops m_can_ethtool_ops_coalescing = {
 	.supported_coalesce_params = ETHTOOL_COALESCE_RX_USECS_IRQ |
 		ETHTOOL_COALESCE_RX_MAX_FRAMES_IRQ |
@@ -2194,10 +2224,14 @@ static const struct ethtool_ops m_can_ethtool_ops_coalescing = {
 	.get_ts_info = ethtool_op_get_ts_info,
 	.get_coalesce = m_can_get_coalesce,
 	.set_coalesce = m_can_set_coalesce,
+	.get_wol = m_can_get_wol,
+	.set_wol = m_can_set_wol,
 };
 
 static const struct ethtool_ops m_can_ethtool_ops = {
 	.get_ts_info = ethtool_op_get_ts_info,
+	.get_wol = m_can_get_wol,
+	.set_wol = m_can_set_wol,
 };
 
 static int register_m_can_dev(struct m_can_classdev *cdev)
@@ -2324,6 +2358,9 @@ struct m_can_classdev *m_can_class_allocate_dev(struct device *dev,
 		goto out;
 	}
 
+	if (dev->of_node && of_property_read_bool(dev->of_node, "wakeup-source"))
+		device_set_wakeup_capable(dev, true);
+
 	/* Get TX FIFO size
 	 * Defines the total amount of echo buffers for loopback
 	 */

-- 
2.45.2


