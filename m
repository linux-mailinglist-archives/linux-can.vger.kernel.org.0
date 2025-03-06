Return-Path: <linux-can+bounces-2994-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D1EB7A548F5
	for <lists+linux-can@lfdr.de>; Thu,  6 Mar 2025 12:18:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 08DCF16941B
	for <lists+linux-can@lfdr.de>; Thu,  6 Mar 2025 11:18:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C0CF20CCC4;
	Thu,  6 Mar 2025 11:16:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="FnPKrrfn"
X-Original-To: linux-can@vger.kernel.org
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F12920C025
	for <linux-can@vger.kernel.org>; Thu,  6 Mar 2025 11:16:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741259769; cv=none; b=hY77S/LOWNZKhx6ZBBVojgq62tGruuT77J7gvhupeGzdml3W2zvz/r78LbXptdzIDBp4x9a+hbvVvvrw+Odjges3Qk+ks5Ceti/g59uRztX8HkFC4RkIf/swVS+5afSMR4NwTQr6hf1LR/cQeWtSLc5a28JKgo9Adig0r4uQ7Mo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741259769; c=relaxed/simple;
	bh=mSNYgSWj+YADxcJYTld46k4BIENA6g6D+Jdi+6l+eLo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=vC8uMjk6qwIRL5/s1NZeA+JITcjKAHY+H1v206Jup+Ut1u131uXq5uXUYNbWS9FnODS4dqMeEJaDMC41Pvu/1RHMFJvOUa3w1LFTvxPs/KsA0VC7SWlXKf4Hq3iBLkAMZxfjuXwHgtvziupN4p79XwaPmBzrioAVilVJz/BL/HA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=FnPKrrfn; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-abf6f3b836aso82323266b.3
        for <linux-can@vger.kernel.org>; Thu, 06 Mar 2025 03:16:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1741259763; x=1741864563; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=B5B/1MAbm7XWDn7sksBQeFE3Zfzb3mpfhe3LWfzUyF0=;
        b=FnPKrrfnP1o7xSfYW4aFG6TWv46kegcCtKd354DkkYyPxe73I5QasuM6O3AyITrkfR
         6HalAhIjA3QsLCR+T+5QOMiDE2Y9+2fJpQAP1eScx0GXZbBpFrkgN3lkAH8tA92vAflm
         uDSyXmyFJrWmOzVk9VEW1h0q1+SpS98XS0vrsmWPs9nBtu+jmCO2Qeby5DuzrXR+sn2a
         AM6pQplPJP2Rb/r+KAVJRloGfWHe9o05IfmKCABEmX2MAkx+ffM8Ct+11hiBPnNNynZk
         hkMfYm991gttxMUQLCm1c9niIVb9Mxb+4+nsU8TKHSDPbmIKUf1L3PcKKQTrKel05v05
         JsDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741259763; x=1741864563;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=B5B/1MAbm7XWDn7sksBQeFE3Zfzb3mpfhe3LWfzUyF0=;
        b=wzyHw3+CNxGkKz6j8pAyP4HM8FclvgqJGlSwpYNszsSIpTUEWXHNeRu02xWOT7vwes
         RqO6DfFyt/A0WIWVwKwkAGmdKqkVOlvfxZiXjkKBWaCA1lXvChWyw2t6RZtqiBA6Nof7
         2KCBA7ggwPNohdgjlVjXYNyJRInzTj9GGtD1wVnfxrsjmwvTULcB/SI8YSqbAi8FPyBn
         3G5wk0o5KNCYn6xQ7Z0w+DEoEkkQGzGdRUFpa7zOG2cbJZ+qPLmwvhkEOT6sak/XSLQG
         7ySFk6mnPiIjM9hxde24x9JmDw6I+vMr2HLVBK9DmUrJEDcI1/m92j33yDvvV+ph+G0h
         M1Pg==
X-Forwarded-Encrypted: i=1; AJvYcCWiWMahJ4GZHJu64Y1qz8c7Z6TVXJJ/b4FP15GL0Xnbl2fJkRPUK31i9X5iIem2jaR6RT0PZ884pIU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwmSm4sQmjmYKidst4/UV0h2SphhJbQoUf2TNj6SyoGmwaC5WL0
	9Ul91ujcEGiRTXbFB9REQuZSCwsX8WXrJ41YNI58OuHDPd3OG6DJpGVCr3UbO40=
X-Gm-Gg: ASbGncsWvJvrYj0r/Rtx6MP9kHbi/9RlgcBxhQ3YWG+pQMFjf0Q5E9stToUljsOyrlQ
	B2/+r5iH7c6zhulVdrzfo3sQpji1BylenzEEShwcOcmI7vb5wtJGL4u/edZ6vw9t/xTeoOOuMQk
	wYCc/SEDFpF3kuE3DH6nXMm73x/BeXbogmQOjBVvf6VO1mOdBoAYXJS2jI/vAUyCeZBqlfB/vft
	UvwBzp0Nde3MbLI4LH8jDVzYJzh9jE6m3frocbiZtJQIk3thqGGwaZVBJzVEIXnBbqKlda8eVkA
	rJKB2D38r5tDj0sQyEZGAcn13aQ0NiPkrsrN6LBG3A==
X-Google-Smtp-Source: AGHT+IGEsRF+ZuhCrECUeqOSfOd/YhlB/c+V8tdTbUibcDVmAxZHV2uaYCpCEp4a4SsOt6thlQaVKQ==
X-Received: by 2002:a17:907:3f89:b0:abf:3f82:1218 with SMTP id a640c23a62f3a-ac20dd0539fmr697232066b.46.1741259763526;
        Thu, 06 Mar 2025 03:16:03 -0800 (PST)
Received: from localhost ([2001:4091:a245:8327:80ad:8144:3b07:4679])
        by smtp.gmail.com with UTF8SMTPSA id a640c23a62f3a-ac2394399aesm78672066b.30.2025.03.06.03.16.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Mar 2025 03:16:03 -0800 (PST)
From: Markus Schneider-Pargmann <msp@baylibre.com>
Date: Thu, 06 Mar 2025 12:14:44 +0100
Subject: [PATCH v5 06/13] can: m_can: Support pinctrl wakeup state
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250306-topic-am62-partialio-v6-12-b4-v5-6-f9323d3744a2@baylibre.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=4086; i=msp@baylibre.com;
 h=from:subject:message-id; bh=mSNYgSWj+YADxcJYTld46k4BIENA6g6D+Jdi+6l+eLo=;
 b=owGbwMvMwCGm0rPl0RXRdfaMp9WSGNJPNh9psOCQeNLEOCn+b9SePUt9tki7Hto5sTxt5WbzS
 MFGOzufjlIWBjEOBlkxRZa7Hxa+q5O7viBi3SNHmDmsTCBDGLg4BWAiiQmMDGv+Cuxsuy9m4Bt+
 5bq2c0U4p+yipf2Kv94uemPBsfXvuSuMDM2GYXFdIh8YnRnetSdYFXOIHROwcC0LWJR/88vTsAs
 uvAA=
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
index 20fbef50db20ab5cea5afe4c44fda8b03e5c8c85..c1c5f8e90d37cde1daa8ab17c2be4b8be451dc50 100644
--- a/drivers/net/can/m_can/m_can.c
+++ b/drivers/net/can/m_can/m_can.c
@@ -2233,6 +2233,7 @@ static void m_can_get_wol(struct net_device *dev, struct ethtool_wolinfo *wol)
 static int m_can_set_wol(struct net_device *dev, struct ethtool_wolinfo *wol)
 {
 	struct m_can_classdev *cdev = netdev_priv(dev);
+	struct pinctrl_state *new_pinctrl_state = NULL;
 	bool wol_enable = !!(wol->wolopts & WAKE_PHY);
 	int ret;
 
@@ -2249,7 +2250,28 @@ static int m_can_set_wol(struct net_device *dev, struct ethtool_wolinfo *wol)
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
@@ -2377,6 +2399,44 @@ int m_can_class_get_clocks(struct m_can_classdev *cdev)
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
@@ -2417,7 +2477,15 @@ struct m_can_classdev *m_can_class_allocate_dev(struct device *dev,
 
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
index bd4746c63af3f0a032910644dfd48a9ebb3a6168..353ad73649218dc0a03d9ba947c6abc847c958eb 100644
--- a/drivers/net/can/m_can/m_can.h
+++ b/drivers/net/can/m_can/m_can.h
@@ -128,6 +128,10 @@ struct m_can_classdev {
 	struct mram_cfg mcfg[MRAM_CFG_NUM];
 
 	struct hrtimer hrtimer;
+
+	struct pinctrl *pinctrl;
+	struct pinctrl_state *pinctrl_state_default;
+	struct pinctrl_state *pinctrl_state_wakeup;
 };
 
 struct m_can_classdev *m_can_class_allocate_dev(struct device *dev, int sizeof_priv);

-- 
2.47.2


