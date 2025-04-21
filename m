Return-Path: <linux-can+bounces-3446-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CDD6DA94DBD
	for <lists+linux-can@lfdr.de>; Mon, 21 Apr 2025 10:11:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E60A43AD73F
	for <lists+linux-can@lfdr.de>; Mon, 21 Apr 2025 08:11:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7328C214204;
	Mon, 21 Apr 2025 08:11:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="NRJkoEJI"
X-Original-To: linux-can@vger.kernel.org
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FCD921127E
	for <linux-can@vger.kernel.org>; Mon, 21 Apr 2025 08:11:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745223075; cv=none; b=FC/tDT9qVWM1Gjqk7wec/xWuZtCcf4DQUg1u52lBbnN1RbOCQ2iHBdOlNwkMXabwua3j6vZy+S5rs7XX2PvZ1OqZbHwSEzhDJiR1omlMuDsSCJ35Oxj6HteqT7/985O1HIdSpkLltSzcnPEEWEdAwSiqla6sVBITDCFWYmiWzFI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745223075; c=relaxed/simple;
	bh=5wED3naIw2KQXYR5hW7lWQjIghjG5l/KvSlr5KMFYgg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=O2i8KY7fCFsCy5IjtrCLpsNosQ7cJvE08qhELcsZdwO0eNeW/X8J5rM8fss8vtWo6zLD1PCzHPmzOMrDrlexgh17DKie4JDeUq8SdagIAfqMH/g4xR9Ah9Ttboth+M7w5AHWxA0Pcxs64uNDWi8/LQJ99Y2Rvze9L7YzFbU7OfI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=NRJkoEJI; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-5e61da95244so6348110a12.2
        for <linux-can@vger.kernel.org>; Mon, 21 Apr 2025 01:11:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1745223072; x=1745827872; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=um5ofTGAtJJdiDu6WNPULch/kVh9ObI22iWsBiO2sbQ=;
        b=NRJkoEJIq2zPtmfg3X1l8geD09kFzfiKlecvA+QBP6pHDpPGjmRTNFLTxOETvRTG3u
         DNlO1c/RIZdQEnXOg3C/hd9UYhnVGIhVyuvquFPWI191nCxSmR+Us5oLgFQEqd1XNGdk
         snJYn0OCmimqEw576iWyhSCZo1damGjMG0zkFtOB1qDRRLLdBC8queB28PJUBtG9g3g0
         fep0bZx9TzjP3F4Rt7GQvYP9JO0Q3ksdo74YnkdWRicBrH2CYuau9TneBj/i2rW37Mfo
         gzUr/Wk4MjanPUieFlzCEEO/3x6ZUZcJ3vrvQXSyeeEGs1/eoyThZs2gT00K12ckbJZe
         WV+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745223072; x=1745827872;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=um5ofTGAtJJdiDu6WNPULch/kVh9ObI22iWsBiO2sbQ=;
        b=GUkMK+elhNOdi8TH5C4+wUz6lC+2O5ruoWSkPGDnkpD5SmkaLF0fw5btHHshHrB9CW
         6gyjYvmejZCtgJ8npO3v8eePqFHQJX7AlqgKTcMVbovo19RixNrqTq023BAqz17QZHvm
         osIXkNLT2SQia+YKU4yCkIG1QDfJmCGCAYMaKxMAL7S/IF86tssDa/FXgWVnvZlKUGoa
         qrMiVeoO+qtp6YescV4kL+BDnGw0tSu8O1clC5MTQvht8zkLT4i0UI3XDdlI+WeCyo3u
         zpra4EH7x99+viS478gO2MfzRus/ST3y7sYWgCTZjB+5dGyipZwA8K6ze0fLPMM0nv06
         yp4A==
X-Forwarded-Encrypted: i=1; AJvYcCUdEpWG+1jsPe24IV8UjKfhNMK9b64RsJWBvSohK6a++QdFi1kMcQRpNPxp5zxC2WO9rtgU6w+sinE=@vger.kernel.org
X-Gm-Message-State: AOJu0YywTiIbqzR8vV0bw3HD0WA8YSdt99KVlrWoAH9jAzXn5aVi6zOr
	rk6iadY0rh5kdTLRpEZkIggxpiPHsCJIpBgaih1lLUDlhTvYUoP5LJU7XKOd1d8=
X-Gm-Gg: ASbGncvT2X41FQ0VM+gFEhzN0faYSIahqoXJpWn8LwjCWLrL+oSpQJ8dFyVnMNHO4HX
	dtXy3cQV1Z5AgsUq4FlIIzUItBes2XQNQfZEGtiIJCOxWnlSzgb09kquzlxleaP6jpjBGi2qCvh
	SAVokGT95/lE/MNmPfFqrd2OjBXKNahifv8ljbKvBp3Ocxxrw1xROq+ERpvWJCOFsfexG1XD9z5
	Xwtd5XTwa0sXuT467cxzmWsFd45Luk9hxdQZ6wPicoumLGDwou13BdNycSJvv2cnmHfqf9YYTYg
	+d8V+sPeYzvHTBw7iCUSJVNhkIZqwJdcHc8=
X-Google-Smtp-Source: AGHT+IFvi0kETTffXUifYRaE4aQEbNEHpmLl8aVzHDt4HHvdhtbAnyHG0mrQ9EwkSspilFn+9U8n7Q==
X-Received: by 2002:a17:907:1b21:b0:acb:33c6:5c71 with SMTP id a640c23a62f3a-acb74b8189cmr987173866b.29.1745223071717;
        Mon, 21 Apr 2025 01:11:11 -0700 (PDT)
Received: from localhost ([2001:4091:a245:826e:c0c:4cef:7dd:26bd])
        by smtp.gmail.com with UTF8SMTPSA id a640c23a62f3a-acb6ec0b302sm476492966b.3.2025.04.21.01.11.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Apr 2025 01:11:11 -0700 (PDT)
From: Markus Schneider-Pargmann <msp@baylibre.com>
Date: Mon, 21 Apr 2025 10:10:40 +0200
Subject: [PATCH v7 4/4] can: m_can: Support pinctrl wakeup state
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250421-topic-mcan-wakeup-source-v6-12-v7-4-1b7b916c9832@baylibre.com>
References: <20250421-topic-mcan-wakeup-source-v6-12-v7-0-1b7b916c9832@baylibre.com>
In-Reply-To: <20250421-topic-mcan-wakeup-source-v6-12-v7-0-1b7b916c9832@baylibre.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=4086; i=msp@baylibre.com;
 h=from:subject:message-id; bh=5wED3naIw2KQXYR5hW7lWQjIghjG5l/KvSlr5KMFYgg=;
 b=owGbwMvMwCXWejAsc4KoVzDjabUkhgzWv5Nrj29xf7z7X7oU5zGh/Z+ePdSfyzJlvb9zYcEhn
 /S8E5GvO0pZGMS4GGTFFFk6E0PT/svvPJa8aNlmmDmsTCBDGLg4BWAiB90YGV7mp5itPW4w88/q
 7Z+X+x7i4HauKDZ5oR0loxtXtPzPDBeG/zGa33K2zXyUoWBjc+vqk627DxRFvXlWv3rzlFM/TTJ
 +yrICAA==
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
2.49.0


