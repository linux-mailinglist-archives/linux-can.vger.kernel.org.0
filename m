Return-Path: <linux-can+bounces-4274-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 77991B2DCEE
	for <lists+linux-can@lfdr.de>; Wed, 20 Aug 2025 14:46:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AD7AA4E6E21
	for <lists+linux-can@lfdr.de>; Wed, 20 Aug 2025 12:43:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFC42315779;
	Wed, 20 Aug 2025 12:43:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="hkCtMmJz"
X-Original-To: linux-can@vger.kernel.org
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8CB022126D
	for <linux-can@vger.kernel.org>; Wed, 20 Aug 2025 12:43:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755693788; cv=none; b=KutNVIoezpEfi9ck9/9Ouy9xYmPC/mffwpYrNOzIhz9apcaV/teMt+UuFFNbvCsiWKmFbrr1XFnPbTu40a3CnAcKLvByx45uF+p2iipaKWfroTVuOZ2M8iRC/OL177DAlV2P2aYcxtEXvTbKFbDsKBM16mN2a7rm2cF1aqOTOYQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755693788; c=relaxed/simple;
	bh=7HeBaIxl7KiuIAyKpj+m8oswjIWs+2EP4qDg/8DlPJ4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=qN9UXaS72oEz2TDsNsqTDljyogbiI7Paczmsr08IvwbZeEUjg8uThdagn+vxoSFtqEXgMsmgDj9tm3mZCJ2DBhiOKfCBGlXFpIqBSn/HyMh27rhaBJU8AAZOHl49+1RF3FGIvs+1xlAhKC8RyAeqLWfg9gxaM0LTuGOVG6Ak/Ls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=hkCtMmJz; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-afcb78f5df4so1063190266b.1
        for <linux-can@vger.kernel.org>; Wed, 20 Aug 2025 05:43:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1755693784; x=1756298584; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Tab2Hleppcwxq/kGW4SqXuYxShPYsb+FlXIHcmWLRu0=;
        b=hkCtMmJz8yvPv573ABp+YnLK2ty+XjI78ruLfih6MaDDRggqw7eor5ZvjiP1UoXS/m
         3wtEsSxTsi8EMac3GTI4+f0Exvv8Tr9BoI5Ncn3P1bZANPgD/TJ0lDj6LIHnzGmWszn0
         tp6QyZKT70ucq69Az04iLIQ08BV+C4JJRNRqUpCZ9zRB95d1cA+t9a2p3PhOGOHidwex
         5ROgBiaYP9VlMmJlxnLKqvTR2/MgtVz2VbtmKkhlIWWl9fegdoDlkNi39toV5frG9bfD
         Aw1n3PezANTlATAd6Z4CAQbXowxT42QUif23lMb2ZHDXAeMImeEV6aFvnDNZ8q0ahdts
         9vaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755693784; x=1756298584;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Tab2Hleppcwxq/kGW4SqXuYxShPYsb+FlXIHcmWLRu0=;
        b=E8uZQ0v+0/Dm6FalrEVaXbLRMoUE51qS8Vkojm0bsdENIefHIp2XQ2ZJHGHxPt+S6m
         5PFz9adBC1oVhbo0zxWwGJLaSymYEiJBm2uSqd7R41jDG15qfv9yYoHFtKmwdrC1SJgF
         g+7XLsCLd4eXDB0oHNrLCvw7qR4rRchDb/w0TMQUcK+VOEAJbGrjwnr/aVaD6zaA6Bvt
         OyHDVeaHk7S4r710jBM8poNv4v0nBJqO3WAfrKqnmffRl7yuh7Njnuzo6FTylI45zk90
         KVYdHx+iMI00/qIuszUSRvC35BWYNmAZ9qluqxHQQGOMDQESxeMT4HHZhpWgpuwwSTo4
         mZMw==
X-Forwarded-Encrypted: i=1; AJvYcCVNYIg4lSGIP38ZxmbEaN43//enI602ltRKZRAlcR4AVPWv/x3eSW7DZD9U/0NgNgM3s5zcQR3K+8s=@vger.kernel.org
X-Gm-Message-State: AOJu0YzQjF6qEdlzX2TQrfOw6RRhvjRkWyPTWlFOjIjKcaGr+AuklyWn
	j70N50+adRcRuDjsz+2/HwQ3V6AJc25paycia81TYDcN8RuOvY3SWODfBon2l8TpsPs=
X-Gm-Gg: ASbGnctTgPC6YKR8betS6+xCHERtyijnEgTyQnBuDQDaRAL58dP2TZrsXUuW8CrgmnM
	w0xyVb/J5lYsZbDXMy1dqf2lWX2W+VQ5nMoP15EOAgVZDod8tHlXyCvcaKEM6I0Cwq6AO+eFP8+
	XtxS6oDxGwRilHkJbAqxluXT6wljqodkPp9ugTxyQ7z34bSIQ8aK6a0UiKU8excZz4hxTdb5qaK
	sbVHIhjNv0wa3U+0L5hF2buj/p+Tpe/iASVwg9YLylFb0dp1/MpZdWrOU6xKXfyi2MGpImC1uib
	eYdGihZSmbSw8eBOLyfDfhWRsBaW1ZmXdjPNhdE8xNmvB05HY5+mMBJH0j5glMXycQt2UcdvjVA
	9r/pSUfxdSkiaWHXlvQ==
X-Google-Smtp-Source: AGHT+IFm7jH5BGc6rdlbvbZkPnXZ2grgH+UcbaItSluJX1MzgInudyFqKiuw/HXm6Db74/4zVrXUdQ==
X-Received: by 2002:a17:906:4fd1:b0:ae0:ded9:7f31 with SMTP id a640c23a62f3a-afdf0088379mr260077366b.20.1755693783935;
        Wed, 20 Aug 2025 05:43:03 -0700 (PDT)
Received: from localhost ([2001:4090:a245:849b:bc8d:b969:7631:815])
        by smtp.gmail.com with UTF8SMTPSA id a640c23a62f3a-afded479020sm174592466b.74.2025.08.20.05.43.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Aug 2025 05:43:03 -0700 (PDT)
From: Markus Schneider-Pargmann <msp@baylibre.com>
Date: Wed, 20 Aug 2025 14:42:26 +0200
Subject: [PATCH v9 2/4] can: m_can: Map WoL to device_set_wakeup_enable
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250820-topic-mcan-wakeup-source-v6-12-v9-2-0ac13f2ddd67@baylibre.com>
References: <20250820-topic-mcan-wakeup-source-v6-12-v9-0-0ac13f2ddd67@baylibre.com>
In-Reply-To: <20250820-topic-mcan-wakeup-source-v6-12-v9-0-0ac13f2ddd67@baylibre.com>
To: Chandrasekar Ramakrishnan <rcsekar@samsung.com>, 
 Marc Kleine-Budde <mkl@pengutronix.de>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: Vishal Mahaveer <vishalm@ti.com>, Kevin Hilman <khilman@baylibre.com>, 
 Dhruva Gole <d-gole@ti.com>, Sebin Francis <sebin.francis@ti.com>, 
 Kendall Willis <k-willis@ti.com>, Akashdeep Kaur <a-kaur@ti.com>, 
 Simon Horman <horms@kernel.org>, 
 Vincent MAILHOL <mailhol.vincent@wanadoo.fr>, linux-can@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Markus Schneider-Pargmann <msp@baylibre.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2839; i=msp@baylibre.com;
 h=from:subject:message-id; bh=7HeBaIxl7KiuIAyKpj+m8oswjIWs+2EP4qDg/8DlPJ4=;
 b=owGbwMvMwCXWejAsc4KoVzDjabUkhoylhw7XlSiK5HXte7DwRmPdOp/JrYvDE240Tr59ULlth
 nTxX8vPHaUsDGJcDLJiiiydiaFp/+V3HktetGwzzBxWJpAhDFycAjARLVuG/2m/2XpO7cravWSF
 jn8b3668xqeZy6dlLrsmE/EzMy+Faz8jw9TdUto9MiyWAhM/FcQkiVoqy5f/TLnvPN9DXnVjlNg
 JPgA=
X-Developer-Key: i=msp@baylibre.com; a=openpgp;
 fpr=BADD88DB889FDC3E8A3D5FE612FA6A01E0A45B41

In some devices the pins of the m_can module can act as a wakeup source.
This patch helps do that by connecting the PHY_WAKE WoL option to
device_set_wakeup_enable. By marking this device as being wakeup
enabled, this setting can be used by platform code to decide which
sleep or poweroff mode to use.

Also this prepares the driver for the next patch in which the pinctrl
settings are changed depending on the desired wakeup source.

Reviewed-by: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Signed-off-by: Markus Schneider-Pargmann <msp@baylibre.com>
---
 drivers/net/can/m_can/m_can.c | 37 +++++++++++++++++++++++++++++++++++++
 1 file changed, 37 insertions(+)

diff --git a/drivers/net/can/m_can/m_can.c b/drivers/net/can/m_can/m_can.c
index fe74dbd2c9663b7090678ab78318698d50ffb481..c68c95cc97075ddf72dbd2f177a999a09b8a21ca 100644
--- a/drivers/net/can/m_can/m_can.c
+++ b/drivers/net/can/m_can/m_can.c
@@ -2222,6 +2222,36 @@ static int m_can_set_coalesce(struct net_device *dev,
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
+	if (wol->wolopts & ~WAKE_PHY)
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
@@ -2231,10 +2261,14 @@ static const struct ethtool_ops m_can_ethtool_ops_coalescing = {
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
@@ -2361,6 +2395,9 @@ struct m_can_classdev *m_can_class_allocate_dev(struct device *dev,
 		goto out;
 	}
 
+	if (dev->of_node && of_property_read_bool(dev->of_node, "wakeup-source"))
+		device_set_wakeup_capable(dev, true);
+
 	/* Get TX FIFO size
 	 * Defines the total amount of echo buffers for loopback
 	 */

-- 
2.50.1


