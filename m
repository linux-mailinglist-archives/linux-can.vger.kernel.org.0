Return-Path: <linux-can+bounces-1625-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 969B499A4C4
	for <lists+linux-can@lfdr.de>; Fri, 11 Oct 2024 15:19:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EA36F1F22299
	for <lists+linux-can@lfdr.de>; Fri, 11 Oct 2024 13:19:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B317C21B438;
	Fri, 11 Oct 2024 13:18:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="f4WMPRYY"
X-Original-To: linux-can@vger.kernel.org
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B831021A6EB
	for <linux-can@vger.kernel.org>; Fri, 11 Oct 2024 13:18:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728652688; cv=none; b=FRvQAzZrWuZbqD27f8KFJMDsbDPCG/9XiyM4AA6cpCVB3zThQMk1CFwy7X+kNAXEC1zRnH1sakKvRmrUR+27xF9aqk7mIIIAOQa0FzbvIFUjYVoJK0coXgJXuwCFRD6Q1P8kB1Ee9EiEnvYs6RXfkVL1QUVefgUZm9R1nD+3VH0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728652688; c=relaxed/simple;
	bh=y4cyNWxW+AAMzsvEv+B5MML+u/SjeALajlpD0Ds81SU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=pUmbEend3JATHffiu+SArgO1+6duebBf6OAMV8kl/+WgACXIDI5nvVZD73bcZsQTztZhYtVhMWc+tcxn0G1OJKrXUMKePwFL2+Sf0n5uLC/9O4/RTI8o18A48uMvE1fv7tv3L1Z6g0g2xRRtANyHRezvEE2+TY2XU8A5m7WlMfE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=f4WMPRYY; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-a9932aa108cso309830866b.2
        for <linux-can@vger.kernel.org>; Fri, 11 Oct 2024 06:18:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1728652685; x=1729257485; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Qi/qlics3jG9EexkXmJNmMTUpWskqoYCj2V24qVovxY=;
        b=f4WMPRYYdFhR76J3Rgh3KNrdBY2EWqVeGrCfLRCD1vz4CRGUf/Uz6Oku6JSabN7jrW
         IauHu/QqfJu/pMGyrNttsXUopfgA0MXAjUPmEBv1XC62byZ5Geb50jNlibn3WIM+kRqC
         PNFHIcMc3LMGUIGbMLcBUVBfz6dhp1UixQ7862Dj7YYdsKHvQj5W0on/U+MzAwAeTHBT
         F6Iy3g1+SfA3HFV08Zgry3POWHozepWkGOgco4DSNyIrZ7gyyNktuYdeRzBnmRmvdjUl
         lYEf84oX/5qlo44qg2/iMUVouw3qKtWkvq6vWQ0iz5gRvGn4j/i1p7PHGoynOyf+QJzJ
         okTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728652685; x=1729257485;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Qi/qlics3jG9EexkXmJNmMTUpWskqoYCj2V24qVovxY=;
        b=I+xeHTOzJienza2C72AB7AWzPuIq9Rqrp2Quzkie+ujv406RjaPgDLkMt8H424qcJy
         Y+geDc0vvIMoiYgtD3+C0oi9DUm0Z6YSOqbqGIpTgZ380gSQAUj0OGaiZ+l9XaSyoo0t
         GJSfEwQA10SKcpK4h5jBVMfRVbT6VSPWwl1L6JBBLRauVo+eWwtpjPHOn4On3tTYCxRO
         5bjS05qULtv/OKciYpX1QUAgQg7FRBqSo3QBP3XsgPO8ZdNgDx5CGFLjYu+TWd8bEaLd
         CLnLvA1jL4VvJowmDKTK4YByPpLeWBG7IBsiBFSUvz/StEQi5zHP/iwLcrkMpb9KPomn
         Bsqw==
X-Gm-Message-State: AOJu0YyEqItp4iQeu9uoIrcDU8eB6ZVVkU7Sxq+LCNQOBMC5rMEwpGn6
	x9KlLcNmaxh1N5deEUSEC1mS3asyyFw04NcSHd+/Tiip2TWQoOAbKkaPBFdJ/G8=
X-Google-Smtp-Source: AGHT+IHFHVZb0xFh7E/t9gOKFFFtdY640Gp4pHWzck9QzbrflS9WO8wY0rdkL08vnT39n2iJtnT/qg==
X-Received: by 2002:a17:906:c14c:b0:a99:53cf:26bc with SMTP id a640c23a62f3a-a99b96b0c3emr256114266b.44.1728652685059;
        Fri, 11 Oct 2024 06:18:05 -0700 (PDT)
Received: from localhost ([2001:4090:a244:83ae:2517:2666:43c9:d0d3])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a99a7ede845sm214686166b.13.2024.10.11.06.18.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Oct 2024 06:18:04 -0700 (PDT)
From: Markus Schneider-Pargmann <msp@baylibre.com>
Date: Fri, 11 Oct 2024 15:16:42 +0200
Subject: [PATCH v3 5/9] can: m_can: Support pinctrl wakeup state
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241011-topic-mcan-wakeup-source-v6-12-v3-5-9752c714ad12@baylibre.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=3643; i=msp@baylibre.com;
 h=from:subject:message-id; bh=y4cyNWxW+AAMzsvEv+B5MML+u/SjeALajlpD0Ds81SU=;
 b=owGbwMvMwCGm0rPl0RXRdfaMp9WSGNI5VbN4Bc4uOvxl3u3Gs4oZS6ct2r0/8tr94zIv2l/q/
 Su3U1pwrqOUhUGMg0FWTJHl7oeF7+rkri+IWPfIEWYOKxPIEAYuTgGYyMR3jAwL+xfm1jNcO3Jw
 ttKPR41P6j5MTDfYOr18s/6CV3lTO6eWMPwPXnzaTfVR6Tv3E48qjDevXZJ3afrEJO4NE4Iayk9
 /vtzJAgA=
X-Developer-Key: i=msp@baylibre.com; a=openpgp;
 fpr=BADD88DB889FDC3E8A3D5FE612FA6A01E0A45B41

am62 requires a wakeup flag being set in pinctrl when mcan pins acts as
a wakeup source. Add support to select the wakeup state if WOL is
enabled.

Signed-off-by: Markus Schneider-Pargmann <msp@baylibre.com>
---
 drivers/net/can/m_can/m_can.c | 60 +++++++++++++++++++++++++++++++++++++++++++
 drivers/net/can/m_can/m_can.h |  4 +++
 2 files changed, 64 insertions(+)

diff --git a/drivers/net/can/m_can/m_can.c b/drivers/net/can/m_can/m_can.c
index 5ab0bb3f1c71e7dc4d6144f7b9e8f58d0e0303fe..c56d61b0d20b05be36c95ec4a6651b0457883b66 100644
--- a/drivers/net/can/m_can/m_can.c
+++ b/drivers/net/can/m_can/m_can.c
@@ -2196,6 +2196,7 @@ static void m_can_get_wol(struct net_device *dev, struct ethtool_wolinfo *wol)
 static int m_can_set_wol(struct net_device *dev, struct ethtool_wolinfo *wol)
 {
 	struct m_can_classdev *cdev = netdev_priv(dev);
+	struct pinctrl_state *new_pinctrl_state = NULL;
 	bool wol_enable = !!wol->wolopts & WAKE_PHY;
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
@@ -2380,7 +2402,45 @@ struct m_can_classdev *m_can_class_allocate_dev(struct device *dev,
 
 	m_can_of_parse_mram(class_dev, mram_config_vals);
 
+	class_dev->pinctrl = devm_pinctrl_get(dev);
+	if (IS_ERR(class_dev->pinctrl)) {
+		ret = PTR_ERR(class_dev->pinctrl);
+
+		if (ret != -ENODEV) {
+			dev_err_probe(dev, ret, "Failed to get pinctrl\n");
+			goto err_free_candev;
+		}
+
+		class_dev->pinctrl = NULL;
+	} else {
+		class_dev->pinctrl_state_wakeup =
+			pinctrl_lookup_state(class_dev->pinctrl, "wakeup");
+		if (IS_ERR(class_dev->pinctrl_state_wakeup)) {
+			ret = PTR_ERR(class_dev->pinctrl_state_wakeup);
+			ret = -EIO;
+
+			if (ret != -ENODEV) {
+				dev_err_probe(dev, ret, "Failed to lookup pinctrl wakeup state\n");
+				goto err_free_candev;
+			}
+
+			class_dev->pinctrl_state_wakeup = NULL;
+		} else {
+			class_dev->pinctrl_state_default =
+				pinctrl_lookup_state(class_dev->pinctrl, "default");
+			if (IS_ERR(class_dev->pinctrl_state_default)) {
+				ret = PTR_ERR(class_dev->pinctrl_state_default);
+				dev_err_probe(dev, ret, "Failed to lookup pinctrl default state\n");
+				goto err_free_candev;
+			}
+		}
+	}
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


