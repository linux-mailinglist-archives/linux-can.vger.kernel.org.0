Return-Path: <linux-can+bounces-1811-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 150399B37F4
	for <lists+linux-can@lfdr.de>; Mon, 28 Oct 2024 18:42:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 38B621C21E08
	for <lists+linux-can@lfdr.de>; Mon, 28 Oct 2024 17:42:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4CF41E0B61;
	Mon, 28 Oct 2024 17:40:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="Fd/vvyQk"
X-Original-To: linux-can@vger.kernel.org
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8269D1DFE0A
	for <linux-can@vger.kernel.org>; Mon, 28 Oct 2024 17:40:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730137230; cv=none; b=UvPdw6aNSO+Q7FaJyvUVhI0S76G3Pvdue4IP98cjPMAoT6ccIAx9oKFh41DzUMyNyshm1nyHQF3xxmrH7Cz/zbA2m6ChrzX+U1y/VRV3pCoseYEKi1ynPnLtjoFkasfusKSqz8dtCJ/eJL61Zw+TwFvapZIEcIdlKTl2VYzYqX4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730137230; c=relaxed/simple;
	bh=XR3crKyWb+tG9mI1yPCh57mhnmim4HwK+22w7Gd3XFE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=jF5fFiVEcvtaXkfm1rDS4jkITcwa/cluL5YukhnKBRhPv3yfe87bcCeZAg9HBh/ywwUQiS4X7ayr3FuTPdEBbnhhkPWT7CWKutqsR5DPbeJdXC13LR2asHeQQhYxuyktOTwT/txGBVSa7LFpCZW81bsWfLBLsQExbDKng+Z8+2Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=Fd/vvyQk; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-37d4c1b1455so2978432f8f.3
        for <linux-can@vger.kernel.org>; Mon, 28 Oct 2024 10:40:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1730137226; x=1730742026; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OiJccS24YzbERRopKG6CEKyvgFFySXKUJlR/ejlx6gc=;
        b=Fd/vvyQkTdZn9KXWxzP39EQKOMHCQx5BNQEqd5jt9YinDUTzbbyiJ1uaCALFSK1eSF
         0nxPxy541tH09wkcOjpr7REXqKi4odPRu2fiw8xiCbmBA9YSqztrdOZwxX3hZtxtwybC
         zbhNmKAi9Au5lhXFBRris8BNa1wN6L1+EzZ1Gng6xQ2AxkDZ3I8ceNjih/qMcd0y4eNW
         zWfxVz/nwZs5wAXDAT/YletGiWVFUEeFv0BhdbUqZcnZboW5GNfrXoja/qWWf8GuGzGT
         zbOECTGPNt6UtWY+PTNu6zYw1WA1KUZNMJ3fz9BNZGj99ZeGA02qHgpm/rM+CjQ04dJs
         zxhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730137226; x=1730742026;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OiJccS24YzbERRopKG6CEKyvgFFySXKUJlR/ejlx6gc=;
        b=cTrwcJfVaLEmCKtAzUQcfToTOGeMDKQf6fz1XVoWcBJ2P5vrmWr0ZELA8mCvFIigmS
         2LDm45JjbcM4WivGeF2TWREU5gX0FYM8sRxcx3YchvVpaM4d0jRgCiIFmKPOpcalUjMU
         wWbuImhjcW2MhYPI8//Xf5dHdG/tHFuGBFmOmCBPO47qTh7T6v9wQ3SrVJuINZbTbevF
         QyJTNtbe+IzgiKXuF+g6ba4Oc+xCc1wT/HIuCfPaNZKJoYA3cKdeFANvK+Cj0AzvwCyD
         VJRzRg+ZEl1e/hrvY9D9AkkdizGLPyHpjZRoHJ9lg3bjG+dLEvFaVfB/Y+x1I1wT9Yu/
         eSJg==
X-Gm-Message-State: AOJu0YyK6jdkleP14HDClxDkAV9AGwvjiRlGQx4bNa5rn5nqGiJCwqCK
	dFDR+x26DRZHyBoAn6Y66BQf1ZyShV1rLcIPOlFSDRxtXtjJwSCF2x9nN+A9u4k=
X-Google-Smtp-Source: AGHT+IF1bTuUiXOYCTuy45+oilc80aMb+3rzydWNyd626/C9NhqmYcI5G2GAG8x29z0tzaS8fa7Ybg==
X-Received: by 2002:adf:a444:0:b0:37d:46f4:35 with SMTP id ffacd0b85a97d-380611dc87dmr6493569f8f.45.1730137225466;
        Mon, 28 Oct 2024 10:40:25 -0700 (PDT)
Received: from localhost ([2001:4091:a245:81f4:340d:1a9d:1fa6:531f])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38058b3be78sm10179460f8f.31.2024.10.28.10.40.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Oct 2024 10:40:25 -0700 (PDT)
From: Markus Schneider-Pargmann <msp@baylibre.com>
Date: Mon, 28 Oct 2024 18:38:11 +0100
Subject: [PATCH v5 5/9] can: m_can: Support pinctrl wakeup state
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241028-topic-mcan-wakeup-source-v6-12-v5-5-33edc0aba629@baylibre.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=4086; i=msp@baylibre.com;
 h=from:subject:message-id; bh=XR3crKyWb+tG9mI1yPCh57mhnmim4HwK+22w7Gd3XFE=;
 b=owGbwMvMwCGm0rPl0RXRdfaMp9WSGNLlz6TIeQcn3PZZtDPgXIMps8Gqc9lBOhL+PuomwsW9m
 1R1sro6SlkYxDgYZMUUWe5+WPiuTu76goh1jxxh5rAygQxh4OIUgIn0LGf4X1uz+MJTjZO3X1xK
 e7W46GV+xvZ4rUy/5fr+W/pMVMKVXzH8Fd1e12Whxf501YxTMW0KFVzp1mstul7cvWjJ7RKguzW
 AHwA=
X-Developer-Key: i=msp@baylibre.com; a=openpgp;
 fpr=BADD88DB889FDC3E8A3D5FE612FA6A01E0A45B41

am62 requires a wakeup flag being set in pinctrl when mcan pins acts as
a wakeup source. Add support to select the wakeup state if WOL is
enabled.

Reviewed-by: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Signed-off-by: Markus Schneider-Pargmann <msp@baylibre.com>
---
 drivers/net/can/m_can/m_can.c | 68 +++++++++++++++++++++++++++++++++++++++++++
 drivers/net/can/m_can/m_can.h |  4 +++
 2 files changed, 72 insertions(+)

diff --git a/drivers/net/can/m_can/m_can.c b/drivers/net/can/m_can/m_can.c
index b7e350ff64cb9cc706b7d53321dffaa079f3a8c0..8c6452d1490c11d365bab598f2abe047f730d24b 100644
--- a/drivers/net/can/m_can/m_can.c
+++ b/drivers/net/can/m_can/m_can.c
@@ -2196,6 +2196,7 @@ static void m_can_get_wol(struct net_device *dev, struct ethtool_wolinfo *wol)
 static int m_can_set_wol(struct net_device *dev, struct ethtool_wolinfo *wol)
 {
 	struct m_can_classdev *cdev = netdev_priv(dev);
+	struct pinctrl_state *new_pinctrl_state = NULL;
 	bool wol_enable = !!(wol->wolopts & WAKE_PHY);
 	int ret;
 
@@ -2212,7 +2213,28 @@ static int m_can_set_wol(struct net_device *dev, struct ethtool_wolinfo *wol)
 		return ret;
 	}
 
+	if (wol_enable)
+		new_pinctrl_state = cdev->pinctrl_state_wakeup;
+	else
+		new_pinctrl_state = cdev->pinctrl_state_default;
+
+	if (IS_ERR_OR_NULL(new_pinctrl_state))
+		return 0;
+
+	ret = pinctrl_select_state(cdev->pinctrl, new_pinctrl_state);
+	if (ret) {
+		netdev_err(cdev->net, "Failed to select pinctrl state %pE\n",
+			   ERR_PTR(ret));
+		goto err_wakeup_enable;
+	}
+
 	return 0;
+
+err_wakeup_enable:
+	/* Revert wakeup enable */
+	device_set_wakeup_enable(cdev->dev, !wol_enable);
+
+	return ret;
 }
 
 static const struct ethtool_ops m_can_ethtool_ops_coalescing = {
@@ -2340,6 +2362,44 @@ int m_can_class_get_clocks(struct m_can_classdev *cdev)
 }
 EXPORT_SYMBOL_GPL(m_can_class_get_clocks);
 
+static int m_can_class_setup_optional_pinctrl(struct m_can_classdev *class_dev)
+{
+	struct device *dev = class_dev->dev;
+	int ret;
+
+	class_dev->pinctrl = devm_pinctrl_get(dev);
+	if (IS_ERR(class_dev->pinctrl)) {
+		ret = PTR_ERR(class_dev->pinctrl);
+		class_dev->pinctrl = NULL;
+
+		if (ret == -ENODEV)
+			return 0;
+
+		return dev_err_probe(dev, ret, "Failed to get pinctrl\n");
+	}
+
+	class_dev->pinctrl_state_wakeup =
+		pinctrl_lookup_state(class_dev->pinctrl, "wakeup");
+	if (IS_ERR(class_dev->pinctrl_state_wakeup)) {
+		ret = PTR_ERR(class_dev->pinctrl_state_wakeup);
+		class_dev->pinctrl_state_wakeup = NULL;
+
+		if (ret == -ENODEV)
+			return 0;
+
+		return dev_err_probe(dev, ret, "Failed to lookup pinctrl wakeup state\n");
+	}
+
+	class_dev->pinctrl_state_default =
+		pinctrl_lookup_state(class_dev->pinctrl, "default");
+	if (IS_ERR(class_dev->pinctrl_state_default)) {
+		ret = PTR_ERR(class_dev->pinctrl_state_default);
+		return dev_err_probe(dev, ret, "Failed to lookup pinctrl default state\n");
+	}
+
+	return 0;
+}
+
 struct m_can_classdev *m_can_class_allocate_dev(struct device *dev,
 						int sizeof_priv)
 {
@@ -2380,7 +2440,15 @@ struct m_can_classdev *m_can_class_allocate_dev(struct device *dev,
 
 	m_can_of_parse_mram(class_dev, mram_config_vals);
 
+	ret = m_can_class_setup_optional_pinctrl(class_dev);
+	if (ret)
+		goto err_free_candev;
+
 	return class_dev;
+
+err_free_candev:
+	free_candev(net_dev);
+	return ERR_PTR(ret);
 }
 EXPORT_SYMBOL_GPL(m_can_class_allocate_dev);
 
diff --git a/drivers/net/can/m_can/m_can.h b/drivers/net/can/m_can/m_can.h
index 92b2bd8628e6b31370f4accbc2e28f3b2257a71d..b75b0dd6ccc93973d0891daac07c92b61f81dc2a 100644
--- a/drivers/net/can/m_can/m_can.h
+++ b/drivers/net/can/m_can/m_can.h
@@ -126,6 +126,10 @@ struct m_can_classdev {
 	struct mram_cfg mcfg[MRAM_CFG_NUM];
 
 	struct hrtimer hrtimer;
+
+	struct pinctrl *pinctrl;
+	struct pinctrl_state *pinctrl_state_default;
+	struct pinctrl_state *pinctrl_state_wakeup;
 };
 
 struct m_can_classdev *m_can_class_allocate_dev(struct device *dev, int sizeof_priv);

-- 
2.45.2


