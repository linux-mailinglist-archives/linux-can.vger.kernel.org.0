Return-Path: <linux-can+bounces-1702-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 73CB099F707
	for <lists+linux-can@lfdr.de>; Tue, 15 Oct 2024 21:18:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 974FC1C237C1
	for <lists+linux-can@lfdr.de>; Tue, 15 Oct 2024 19:18:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62E1A1FBF76;
	Tue, 15 Oct 2024 19:17:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="g8MztsLb"
X-Original-To: linux-can@vger.kernel.org
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 387391FAF1E
	for <linux-can@vger.kernel.org>; Tue, 15 Oct 2024 19:17:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729019840; cv=none; b=Qnit/cHVt/ZqtluXhDmLFmFwSXIVqNk7x7NExjP1UmaP8mI9os+bGE8DUEYis2mtUP2ceOzIErw30qwgjAPR/YppUn0PC9L256PLacEedp9VS17QH29XNi6AJmIwWSHS07/jRUwOvm21xfM5ZEWUXBXiRTfLKczTVLiKgDlXxhE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729019840; c=relaxed/simple;
	bh=fXagSgDKvwKb5T6QGKzoWAYbWw5MKKnGO7kvv5dC+zw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=I14TBQY8AhuUObMCF9cu1IKBETtdjfSaZTwWaFJQhO+ii1NoHiQMaDsdR0dpLKI/TimAKkB85I5LB6T9xDV4YYx5xO05pODiIlU8bj1Q6UCyf6d3ttGoul3Xx/CM0Y+9d0YOuWzwDMxKuAh9C1C5ynqhjkS+o9JDfNE9qUvHjeM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=g8MztsLb; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-5c94dd7e1c0so6141731a12.0
        for <linux-can@vger.kernel.org>; Tue, 15 Oct 2024 12:17:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1729019835; x=1729624635; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=C53L7ElLnJx+g4UjgYE4Yk8Jb0cDN7FkWpfutP4xQkE=;
        b=g8MztsLbbVe2vbXc3HI9g111NcVnftyTdIDoktkJf6sxtGJKEdRxSzPvJMU9OJe682
         k2srQbja1hjXcKdIjF/r7yzVJAIxKX3EivNIQDxOCEoU8d/xASrQ9WSgQqkpyhE/wHjf
         t/OZSpKpNJAUGbvpn4SDak8IEn+yD8vaGxw0npgqeDsdcb5VJfybMVXUhJ3b3LYQ1jZ0
         asPIt3zpRhJo6Hi6FaEOkn9zhq4SAibfKuHwNxhMhEwu6fxK8QbrXxSLjMU3pDdiHM/x
         jpEYj+zcG0YrsSjSMK6h6SYUufvHMie5hGAgkVW6SVJ03MiqgqbGEbT06+YuEUs1US0g
         Pe8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729019835; x=1729624635;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=C53L7ElLnJx+g4UjgYE4Yk8Jb0cDN7FkWpfutP4xQkE=;
        b=BnZMeNqab6ccYIYu+DwhZsy3e17/LfCGIjbC/dIh1NJyUPq1Z2UwWHgaSmH8ECeK6e
         IP+b+LcTmCNdZH/hQCVfNvgImNJlVfC77LifcAvGW6dKLuwnOOai5W1r+faZbDmMWwqC
         a2LrjzXTOJsccbEP4JTgUo7MlIrdPisRJ3fAnKjeZYhQ5qf20Y52TlKZAKggsdCBIWmJ
         eQ5cZbugfRQGLKQ/AIUxmyeSoakqdeL/ZgB1NFOOhV0S7YHIuB86c8wb/GO/MMciBoKd
         OlSTvGLoVN0Zlrp/jSAkSHPC4i6fp5LgS+5K82nICNAwdW2zQCWIDmegedUPiroNgJIF
         ln0A==
X-Gm-Message-State: AOJu0YxEkZ6GzwsXtNzdU1ak+TSbhUXosW1bSoouhYKoPg/D/jKQ7/dn
	q3T0zaaenPBd7bWio3kYrMv4Eq79hNbovlvi9xQneJ9dKgls80YJc3z4MDiC4Q8=
X-Google-Smtp-Source: AGHT+IFuNaXJ/r/nqGOo1Icj0J/5EWknD2G800st6YUHsrMWW7mRsRlVQykeajKpoYEWh9kT1ftaMA==
X-Received: by 2002:a05:6402:5191:b0:5c9:5e43:9480 with SMTP id 4fb4d7f45d1cf-5c95e43f157mr8602638a12.7.1729019835369;
        Tue, 15 Oct 2024 12:17:15 -0700 (PDT)
Received: from localhost ([2001:4090:a244:83ae:2517:2666:43c9:d0d3])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5c98d5298d1sm990283a12.57.2024.10.15.12.17.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Oct 2024 12:17:14 -0700 (PDT)
From: Markus Schneider-Pargmann <msp@baylibre.com>
Date: Tue, 15 Oct 2024 21:15:59 +0200
Subject: [PATCH v4 5/9] can: m_can: Support pinctrl wakeup state
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241015-topic-mcan-wakeup-source-v6-12-v4-5-fdac1d1e7aa6@baylibre.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=4027; i=msp@baylibre.com;
 h=from:subject:message-id; bh=fXagSgDKvwKb5T6QGKzoWAYbWw5MKKnGO7kvv5dC+zw=;
 b=owGbwMvMwCGm0rPl0RXRdfaMp9WSGNL59s9uW8v09/SRimWqRdrZTa8f+wvx3hdxjb40ibtyW
 kPi0VCzjlIWBjEOBlkxRZa7Hxa+q5O7viBi3SNHmDmsTCBDGLg4BWAiTz8yMmyomvCWXXrysZVi
 HZXeE9ms2F33pGXcrYjQbDRR2r9z4RFGho4nHXcD3TPPxG17WRX4rudRD3OK5KsTb6+y+FfkTem
 I5AAA
X-Developer-Key: i=msp@baylibre.com; a=openpgp;
 fpr=BADD88DB889FDC3E8A3D5FE612FA6A01E0A45B41

am62 requires a wakeup flag being set in pinctrl when mcan pins acts as
a wakeup source. Add support to select the wakeup state if WOL is
enabled.

Signed-off-by: Markus Schneider-Pargmann <msp@baylibre.com>
---
 drivers/net/can/m_can/m_can.c | 68 +++++++++++++++++++++++++++++++++++++++++++
 drivers/net/can/m_can/m_can.h |  4 +++
 2 files changed, 72 insertions(+)

diff --git a/drivers/net/can/m_can/m_can.c b/drivers/net/can/m_can/m_can.c
index 5a4e0ad07e9ecc82de5f1f606707f3380d3679fc..c539375005f71c88fd1f7d1a885ce890ce0e9327 100644
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


