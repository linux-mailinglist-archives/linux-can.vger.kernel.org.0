Return-Path: <linux-can+bounces-4205-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 61E1DB22284
	for <lists+linux-can@lfdr.de>; Tue, 12 Aug 2025 11:14:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 92AC01662F2
	for <lists+linux-can@lfdr.de>; Tue, 12 Aug 2025 09:11:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C27B02E8E0A;
	Tue, 12 Aug 2025 09:11:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="n7Ugw88R"
X-Original-To: linux-can@vger.kernel.org
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EF982E7BCC
	for <linux-can@vger.kernel.org>; Tue, 12 Aug 2025 09:11:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754989887; cv=none; b=YZQ1kWXO61aC8/sRSPU9//+ONuy7gwEE6htInT7+y+sLbEHp4mpOi2So+qyztKFFVvwRuY0Ob9P9C3VoNIwBMttjuNumBCPo5GNb51sVuBjticHColmSBxdHf8r9t1jwII4drpqOoTfMkofRoZDlJWTL4lpYOKDZJ5/a5zjqvlE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754989887; c=relaxed/simple;
	bh=gv4aQqLQj6qk5926WotZilrrsqGPIVpFLa7mla3fUUo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=tjDyzYyMl2UWAAcOPek+5uERvVvU2L4DYa5ShElM1Cvx5RbDYJ9tGbathtCSDbpf/8ynYRzPLxw5D3dz9a1HpEkpkfAUalA9qPnFRtYY770Zi1BkYxehOl01uq+k9YdhmZB+UrAQxx3ubHopw7AkGKOj+gvf9UHQ3zzchh36o4Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=n7Ugw88R; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-af925cbd73aso987328766b.1
        for <linux-can@vger.kernel.org>; Tue, 12 Aug 2025 02:11:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1754989884; x=1755594684; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WWNmgoaL9pn5HPHLZK1R43ly/5jtUzOZdXJxOwsahbE=;
        b=n7Ugw88R+p37GKLMz8cVzjmmgr6dghQ1CAj7kxtg4HjNx4tpzKE/Puu5MDUhzF4/Kg
         dtcsOgBNmx/A17R/gtU1AQTcn9eztUtNB1S78Qxh2PpARU+3MkL3aLItIed0sni/Lcs0
         0DW2l6CZo8S1SlI5xxURFtgeqz3ltMxpRqxq3L3g93e2gi7e+TapxY0rJNBD1nwOSE4J
         BuUckKLtn1YlsLKy5DbqRO7WS/hjZsjiejKwK5Xtjt4qx9INU++xCq0Xx98DQa3XxuDn
         K8CwEU+49PAcqeYvVspWszZ7d+D9EKqAsHqkAdbcqYRiEh5MxvXGUByRjELuV45qmg5D
         ZVkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754989884; x=1755594684;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WWNmgoaL9pn5HPHLZK1R43ly/5jtUzOZdXJxOwsahbE=;
        b=sZdzJGJKhCrJHvtQ3fAvYu+YAXMlfF/1ZdtFeh026cUPhlOZ2x53FxE/0jGIyiii6Q
         00bIyMAQg/qYs9lzdcAWhLPEcvax4hJwhTCiRqu1182e0x/3FGcxkYZzMGK+BMYwdc58
         Hr92BnbAO/Cys8v6BD6b/BRHEETYmFN/CqxxduNwUvqwrQsIMyzJ0KbQDpTlmTsmp8u4
         aiV+xqwFb/I8FWeYlyRjwiZVroagTC8BCnHkrJiXUdBMoNxJc+jojPXOqnF4LT9qJO8s
         147/3QKNxR9TGbtvC27E3g+foXtUTCCQL7nrjnTFLv+ELSlabfFqCuwsys5EsKPhLeWQ
         OYBQ==
X-Forwarded-Encrypted: i=1; AJvYcCXTuwKkpN/1qM1cDNOBHyRz7ISK34l1CHrlyVfx7mmD0SlQ7M3GrrW/Xynkemy0RCSp7NIjb5238OE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwhvXBCf/pEcSGGvpKhNj/e5+pFFnrjf+2C6QHvmWzwT6ooZ7O9
	UC7F0ClIwdFhCVtot/8SfhB27z9uEhaORCLFImSmeileXAKCJGCYOleHV3ieusSZB74=
X-Gm-Gg: ASbGnctEFTrfpi/LGZ2pmIOn9juZsFDolTRqYXJ/NJqQTlgjJje2NEB3ko1V+xJxFVo
	qylnxWUUBX/PEaK9g1IQ3OEk69K9NHr/s12Ux94skoG3O83A9ACx+ZkJPGJrzIbsOzT4/x64Svi
	IWGCYFA4LfiEDVPaPJXQOAyesIdDRdrsnE1zqcocfnsr23n97jdqVLy8hV5wsd+RSd2O9ygO04H
	QehYuZ19XhlqY8U4mzcIep5yXgPw3ehuV2XyxhDX+q4XyIp+Mo328wo2lF3uJ799uF/vINSaDad
	oztJF6ctMkIRSQlVaPimczLi8mtsbL/l5WNCtYoD+zCKNx6DArYtpn4C7irNjnrDiAZsleVKOsZ
	MHTod1w10twbj5Kpi1w==
X-Google-Smtp-Source: AGHT+IFAazmUi/aRbw5Twc92V84t4z0NIo06UksQYmLsp1JA0GgYsP4z1F3V+M2ifd+59uTvbZfSig==
X-Received: by 2002:a17:907:9408:b0:af9:29c1:1103 with SMTP id a640c23a62f3a-afa1e22544amr224457166b.55.1754989883816;
        Tue, 12 Aug 2025 02:11:23 -0700 (PDT)
Received: from localhost ([2001:4090:a244:8691:4b7a:7bbd:bac:c56e])
        by smtp.gmail.com with UTF8SMTPSA id 4fb4d7f45d1cf-615cc38aeccsm18161232a12.2.2025.08.12.02.11.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Aug 2025 02:11:23 -0700 (PDT)
From: Markus Schneider-Pargmann <msp@baylibre.com>
Date: Tue, 12 Aug 2025 11:10:25 +0200
Subject: [PATCH v8 4/4] can: m_can: Support pinctrl wakeup state
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250812-topic-mcan-wakeup-source-v6-12-v8-4-6972a810d63b@baylibre.com>
References: <20250812-topic-mcan-wakeup-source-v6-12-v8-0-6972a810d63b@baylibre.com>
In-Reply-To: <20250812-topic-mcan-wakeup-source-v6-12-v8-0-6972a810d63b@baylibre.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=4136; i=msp@baylibre.com;
 h=from:subject:message-id; bh=gv4aQqLQj6qk5926WotZilrrsqGPIVpFLa7mla3fUUo=;
 b=owGbwMvMwCXWejAsc4KoVzDjabUkhozZrAYmp9VPZ8fec/q3KXe/a2lua5rcFP1ocxY5v8x7j
 HnnhZU6SlkYxLgYZMUUWToTQ9P+y+88lrxo2WaYOaxMIEMYuDgFYCKOJxgZ5tblOz74yq1k4Mvq
 F/T6pGSt0CZlISF211WNcbv31TrNYGQ4m3QkpWrnoY42L3ut2Obj/ReqxBOWeEk9fn/lRf5/h2x
 mAA==
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
index e08fae5ddf5efa8345670dd50d50954ec5d52b29..99ae6f817b313798aaa7d57166b3f564cd3aa946 100644
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
@@ -2418,7 +2478,15 @@ struct m_can_classdev *m_can_class_allocate_dev(struct device *dev,
 	m_can_of_parse_mram(class_dev, mram_config_vals);
 	spin_lock_init(&class_dev->tx_handling_spinlock);
 
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
2.50.1


