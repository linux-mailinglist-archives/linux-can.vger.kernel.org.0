Return-Path: <linux-can+bounces-676-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 32F1D8CCD6A
	for <lists+linux-can@lfdr.de>; Thu, 23 May 2024 09:55:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AD678283063
	for <lists+linux-can@lfdr.de>; Thu, 23 May 2024 07:55:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF51313D2A9;
	Thu, 23 May 2024 07:54:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="APU8nV6P"
X-Original-To: linux-can@vger.kernel.org
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15ED813D262
	for <linux-can@vger.kernel.org>; Thu, 23 May 2024 07:54:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716450871; cv=none; b=eYjPuEytg8/Y5ugRsXU7UsAwlhOxB6mWpogxKSYntSTeDGjNRWabw699shXti63NKXsC8x1Z3RIukzFehu2jW1IfU0pUtHdcBPviyyWIb2PuFRcvrIMnpc4TQQ06l76kuR9GYlPs4/Q/qvb2MhR/6aRfkvr6Jp7c87DOByxXcCo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716450871; c=relaxed/simple;
	bh=psaW3D5sy9xXOmkzELpixxLbVsz3tVfuUMx9AZiaJks=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=e77MSeXWVCHC+lO1/48ZyCHcxj3dQlS1KXzQaq+qJhgmp4GYBfixQH2IJs0ddUSaa68LdBVKjGEovTsM7VChY8ATPDjRvEUgvgn6IEGC/YyPbPRxyAtrOe9+UTOCxbmgN6CjXF5E5pkPg9JfgBVC88myBdJzTfWvgnKgh/ydArY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=APU8nV6P; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-34d9c9f2cf0so1965692f8f.3
        for <linux-can@vger.kernel.org>; Thu, 23 May 2024 00:54:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1716450868; x=1717055668; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=P4T6sy6AEq30+xE+MXFJmyPKxLYvjiOTPFV8oNWYyfY=;
        b=APU8nV6PUH3bX5GA0rppxHpHVJP88901zi2kPOwVbk8S/fLlm0LEfDTd2/UoFpsnN8
         uUGVrfwZbyaU/PRR2GD8mV6ABnpPy7crQr9hwnJsar+cZFbijE900/ekMESI4RXIcBt+
         20L/J7dW3MwWyaLZwKGX6/8F0ypFjDgxlCad35TtCbt/iYr4+s5Zfkcm4KPY/Mhrnk0p
         Kqq/u7+ukUxcnSeyYjJjyI+cbWmSh/BUYR0lHER9KU9DOSlTK/6hOq7iUwvVb0fjJy4u
         LnqnDR2VsZ8NxZSlO0p4yxwAGK3KyAJSWDNSgZL4JKjjK7UeyD7vCQJAIagAwjeJnUc1
         KSfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716450868; x=1717055668;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=P4T6sy6AEq30+xE+MXFJmyPKxLYvjiOTPFV8oNWYyfY=;
        b=IVej28EAHHjthARHfLCFn1EGsf3GU6FYsOXqaWg90lBImsToDHDbh46422YLKO79yy
         uVWwspLSg1KhWvcS0Gk9xpTuDGUwMU229cAt621/U3J2NAyCbr5rcPfTT79xdU5no3Xr
         04SPDzKqTSqONMl4C8xg+XMfI9xodv91oPTYDgFY3evc7WJh/ZgiF2EOwFPxH2UnurlH
         /cfMxXg1kT6jX9M2IheufRwPuG2Y7eTse+/apa34Bz68AQJNhODZxH2Ib7Xh8piDg5WI
         /AcVYvtYa22tE+HGnV8ukWCDydAnoBmFAWjL8ZLrntgL10dAuNT+QUi9VA1W0c+20CI0
         lzDw==
X-Forwarded-Encrypted: i=1; AJvYcCWxKDYvaSPn1YBGd/7I4ZEdvw/R3S9d1J7Akisfa+CuX3Y6yKVDrG3+Owx6TNKjExma6uU7l0MkAhxtOyJCQyMeUCP0mh6pL1nM
X-Gm-Message-State: AOJu0YyCSWopLPkflFxqtJzumgoZkhKdNSlFd7D97Yoo6ZnDbn6/ShuI
	eJA3GHsU9ZaXA7dpd/txiBhI1HIFUnzWp8fLfOwbbTZen4tnMloWk4PaqWegn2I=
X-Google-Smtp-Source: AGHT+IFtIc5i+hivOWt1FZJ1gwG5chb73rVNDKqh9Iu9jNZxfSYT+HyovD+5k8o5exozIdt5jmzJ4A==
X-Received: by 2002:adf:e6cb:0:b0:354:f2b0:ebda with SMTP id ffacd0b85a97d-354f2b0ec82mr3067448f8f.10.1716450868279;
        Thu, 23 May 2024 00:54:28 -0700 (PDT)
Received: from blmsp.fritz.box ([2001:4091:a246:821e:6f3b:6b50:4762:8343])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3502baad074sm36501833f8f.70.2024.05.23.00.54.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 May 2024 00:54:27 -0700 (PDT)
From: Markus Schneider-Pargmann <msp@baylibre.com>
To: Chandrasekar Ramakrishnan <rcsekar@samsung.com>,
	Marc Kleine-Budde <mkl@pengutronix.de>,
	Vincent Mailhol <mailhol.vincent@wanadoo.fr>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Nishanth Menon <nm@ti.com>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Tero Kristo <kristo@kernel.org>
Cc: Vibhore Vardhan <vibhore@ti.com>,
	Kevin Hilman <khilman@baylibre.com>,
	Dhruva Gole <d-gole@ti.com>,
	=?UTF-8?q?Martin=20Hundeb=C3=B8ll?= <martin@geanix.com>,
	Simon Horman <horms@kernel.org>,
	linux-can@vger.kernel.org,
	netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	Markus Schneider-Pargmann <msp@baylibre.com>
Subject: [PATCH 4/7] can: m_can: Support pinctrl wakeup state
Date: Thu, 23 May 2024 09:53:44 +0200
Message-ID: <20240523075347.1282395-5-msp@baylibre.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240523075347.1282395-1-msp@baylibre.com>
References: <20240523075347.1282395-1-msp@baylibre.com>
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
 drivers/net/can/m_can/m_can.c | 20 +++++++++++++++++++-
 drivers/net/can/m_can/m_can.h |  4 ++++
 2 files changed, 23 insertions(+), 1 deletion(-)

diff --git a/drivers/net/can/m_can/m_can.c b/drivers/net/can/m_can/m_can.c
index 80964e403a5e..c5585dc68f2f 100644
--- a/drivers/net/can/m_can/m_can.c
+++ b/drivers/net/can/m_can/m_can.c
@@ -2140,11 +2140,21 @@ static void m_can_get_wol(struct net_device *dev, struct ethtool_wolinfo *wol)
 static int m_can_set_wol(struct net_device *dev, struct ethtool_wolinfo *wol)
 {
 	struct m_can_classdev *cdev = netdev_priv(dev);
+	struct pinctrl_state *new_pinctrl_state = NULL;
+	bool wol_enable = !!wol->wolopts & WAKE_PHY;
 
 	if ((wol->wolopts & WAKE_PHY) != wol->wolopts)
 		return -EINVAL;
 
-	device_set_wakeup_enable(cdev->dev, !!wol->wolopts & WAKE_PHY);
+	if (wol_enable)
+		new_pinctrl_state = cdev->pinctrl_state_wakeup;
+	else
+		new_pinctrl_state = cdev->pinctrl_state_default;
+
+	if (!IS_ERR_OR_NULL(new_pinctrl_state))
+		pinctrl_select_state(cdev->pinctrl, new_pinctrl_state);
+
+	device_set_wakeup_enable(cdev->dev, wol_enable);
 
 	return 0;
 }
@@ -2309,6 +2319,14 @@ struct m_can_classdev *m_can_class_allocate_dev(struct device *dev,
 	SET_NETDEV_DEV(net_dev, dev);
 
 	m_can_of_parse_mram(class_dev, mram_config_vals);
+
+	class_dev->pinctrl = devm_pinctrl_get(dev);
+	if (!IS_ERR_OR_NULL(class_dev->pinctrl)) {
+		class_dev->pinctrl_state_default =
+			pinctrl_lookup_state(class_dev->pinctrl, "default");
+		class_dev->pinctrl_state_wakeup =
+			pinctrl_lookup_state(class_dev->pinctrl, "wakeup");
+	}
 out:
 	return class_dev;
 }
diff --git a/drivers/net/can/m_can/m_can.h b/drivers/net/can/m_can/m_can.h
index 3a9edc292593..bdfbba67b336 100644
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
2.43.0


