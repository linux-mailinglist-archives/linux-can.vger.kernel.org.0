Return-Path: <linux-can+bounces-1029-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F354F93EEC1
	for <lists+linux-can@lfdr.de>; Mon, 29 Jul 2024 09:43:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9F6B8281DFA
	for <lists+linux-can@lfdr.de>; Mon, 29 Jul 2024 07:43:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0985113A25F;
	Mon, 29 Jul 2024 07:42:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="qHFOW7Xo"
X-Original-To: linux-can@vger.kernel.org
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0CD212DD88
	for <linux-can@vger.kernel.org>; Mon, 29 Jul 2024 07:42:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722238925; cv=none; b=UjjhXfB9GXigO2n/CVMogfCDjD6mrK+R7H/QgunzmdKuyMbJAAoY29ycAT9695FDCTvS0StM8sCYxZajbX9f9J9+VgCwmPYGsmCdlemFqGrdf49+MXfqIqepFsXLKGPoaS0iNKqjkX8G3k9h+R16ABpr0FQ7c/WXdEzQRk8l2RY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722238925; c=relaxed/simple;
	bh=gB4bCvkWVjw2VgpvtJGGwL3mu5ZuVwi3ug/EBaXL9+8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CruPDsdhJ7jm90XaRvAVDkt6vgPVr5YNJJr3jWU91r9h94U6i/Lnk8X7gYAGbPdBq4o9/mcp6rj9hMucXEVjVBzlaZ44DK0Z0GwYKBawxRQ+EDWNecI0yhy9Dt5dmKztFdIS/4Tn4YFXDcDUjsEynCThuqnQqJU85IDLS0s94EY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=qHFOW7Xo; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-3684407b2deso1124394f8f.1
        for <linux-can@vger.kernel.org>; Mon, 29 Jul 2024 00:42:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1722238922; x=1722843722; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=euYaEmMVMSjTk2pj25N9i4771o+mJWDFmdSDcOKEIIY=;
        b=qHFOW7XokXUPeaY0zmx4scRZC2dNWSNgeKJ7y/kiX72XTRtyvixAVJ6BizjwFxz0Zb
         FA5lBHm6ChwaXiN/gXw8/LV0CejiwQX2fhsQbWFwrap31iBqa+DGnzLTqs+e94+HdQPU
         iYJZeQphK5u10ESvl1oZ9al0OvWQHXE/hk7c/viE1s6hTZo8JNAOUa4Fuxaw3CcIEEhF
         frk3ojCEjWgZqvxyZc/OrAvzkU7dLYQ3igLA5hbnIYuPtsh3dMdOoTVaYbG6qZq+1PEU
         mldbYiA+dOahzgTtVqi/owtr1qGKQOzf/2Q0Yp5nY/qYPFirC9TtAz0Cs4NI/X/0+fBS
         swNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722238922; x=1722843722;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=euYaEmMVMSjTk2pj25N9i4771o+mJWDFmdSDcOKEIIY=;
        b=AWCCoqNjDeJGP1Bnix7v2JDwUo639ItZSaUkb7M/TY/q2m0oAW71otgMV7+TpPoSGO
         7Tde5XBCAkea/SCmBIcoVKTB0oM/rHRL04QZ3M0xkSlka71tLTNdvk7X285G/bZnk3UZ
         W4bQYYbYYJ+cg9wmBsaemSBiPmAV+m8/M4iWSfF8rDkqd2hCu3ZGUuwNFeZAfhnADsE8
         yko0sGg/LHB4K5ohubOqu/bfWjrdbmZI4MFuua7ivn5y2oApvLU0zO1fVlq4firm6FyO
         K7CupPjVyvdQsKI1Qnzl+oT3D3DacBtC2JR70RihIA09EzmWSulwrDPwh3+9+ecvEJvD
         qKkg==
X-Forwarded-Encrypted: i=1; AJvYcCWspsRPJM6dj92eIiDQ+meaHweYSYRTQA6MfoTojhwxgfOtGELwaEvb6hr+d4/b5duXAdWQ+oXqRIp5o0L4F70tQgIc++EeIVK4
X-Gm-Message-State: AOJu0Yy2YZPvbf1sQmTUR77vkz5pO+mA70MyYF9zClGv0YYgDjErj/8w
	gAR9QpTPM20SXFH0KbBHjynh7BFVBhMxeNlF5/oK7hvi6rmbkeuzttJ1rmjBbrA=
X-Google-Smtp-Source: AGHT+IHlZDsneAUmpWQlVvOflGKEic5Rye1tKD/dzfIRoSAvJF4QRKJTN1ym1tr9RuFfvC7ACtRobg==
X-Received: by 2002:a5d:6c68:0:b0:367:958e:9832 with SMTP id ffacd0b85a97d-36b5cee19c1mr5071133f8f.14.1722238922156;
        Mon, 29 Jul 2024 00:42:02 -0700 (PDT)
Received: from blmsp.fritz.box ([2001:4091:a245:8609:c1c4:a4f8:94c8:31f2])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-36b36863aa7sm11460879f8f.109.2024.07.29.00.42.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jul 2024 00:42:01 -0700 (PDT)
From: Markus Schneider-Pargmann <msp@baylibre.com>
To: Chandrasekar Ramakrishnan <rcsekar@samsung.com>,
	Marc Kleine-Budde <mkl@pengutronix.de>,
	Vincent Mailhol <mailhol.vincent@wanadoo.fr>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Nishanth Menon <nm@ti.com>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Tero Kristo <kristo@kernel.org>,
	Markus Schneider-Pargmann <msp@baylibre.com>,
	=?UTF-8?q?Martin=20Hundeb=C3=B8ll?= <martin@geanix.com>,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	Michal Kubiak <michal.kubiak@intel.com>
Cc: Vibhore Vardhan <vibhore@ti.com>,
	Kevin Hilman <khilman@baylibre.com>,
	Dhruva Gole <d-gole@ti.com>,
	Conor Dooley <conor@kernel.org>,
	linux-can@vger.kernel.org,
	netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH v2 4/7] can: m_can: Support pinctrl wakeup state
Date: Mon, 29 Jul 2024 09:41:32 +0200
Message-ID: <20240729074135.3850634-5-msp@baylibre.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240729074135.3850634-1-msp@baylibre.com>
References: <20240729074135.3850634-1-msp@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

am62 requires a wakeup flag being set in pinctrl when mcan pins acts as
a wakeup source. Add support to select the wakeup state if WOL is
enabled.

Signed-off-by: Markus Schneider-Pargmann <msp@baylibre.com>
---
 drivers/net/can/m_can/m_can.c | 57 +++++++++++++++++++++++++++++++++++
 drivers/net/can/m_can/m_can.h |  4 +++
 2 files changed, 61 insertions(+)

diff --git a/drivers/net/can/m_can/m_can.c b/drivers/net/can/m_can/m_can.c
index 5b80a7d1f9a1..b71e7f8e9727 100644
--- a/drivers/net/can/m_can/m_can.c
+++ b/drivers/net/can/m_can/m_can.c
@@ -2193,6 +2193,7 @@ static void m_can_get_wol(struct net_device *dev, struct ethtool_wolinfo *wol)
 static int m_can_set_wol(struct net_device *dev, struct ethtool_wolinfo *wol)
 {
 	struct m_can_classdev *cdev = netdev_priv(dev);
+	struct pinctrl_state *new_pinctrl_state = NULL;
 	bool wol_enable = !!wol->wolopts & WAKE_PHY;
 	int ret;
 
@@ -2209,7 +2210,27 @@ static int m_can_set_wol(struct net_device *dev, struct ethtool_wolinfo *wol)
 		return ret;
 	}
 
+	if (wol_enable)
+		new_pinctrl_state = cdev->pinctrl_state_wakeup;
+	else
+		new_pinctrl_state = cdev->pinctrl_state_default;
+
+	if (!IS_ERR_OR_NULL(new_pinctrl_state)) {
+		ret = pinctrl_select_state(cdev->pinctrl, new_pinctrl_state);
+		if (ret) {
+			netdev_err(cdev->net, "Failed to select pinctrl state %pE\n",
+				   ERR_PTR(ret));
+			goto err_wakeup_enable;
+		}
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
@@ -2377,7 +2398,43 @@ struct m_can_classdev *m_can_class_allocate_dev(struct device *dev,
 
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
+		class_dev->pinctrl_state_wakeup = pinctrl_lookup_state(class_dev->pinctrl, "wakeup");
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
+			class_dev->pinctrl_state_default = pinctrl_lookup_state(class_dev->pinctrl, "default");
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
index 92b2bd8628e6..b75b0dd6ccc9 100644
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


