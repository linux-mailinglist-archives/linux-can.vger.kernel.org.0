Return-Path: <linux-can+bounces-2463-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EE9A29F8541
	for <lists+linux-can@lfdr.de>; Thu, 19 Dec 2024 21:03:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B04B17A0567
	for <lists+linux-can@lfdr.de>; Thu, 19 Dec 2024 20:03:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E77DF1FDE3B;
	Thu, 19 Dec 2024 19:59:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="0wkKGBYS"
X-Original-To: linux-can@vger.kernel.org
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3C421BEF7A
	for <linux-can@vger.kernel.org>; Thu, 19 Dec 2024 19:59:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734638349; cv=none; b=QSqJEqy6OaaYUxzQgWZBXSGEZG7juJHy+bFw8JA7Z4FOvo0o7jMO9Nw2dktSHYCnWah8Y/0gVVVs1ZsiHBpBS5zyl+nUFcpuVMzrb6cjFD1BaWJLLnv6jJNDEvpLuKB8nm5sYHGLW+0XGbIzTDWTOMVhdGR8/WROQ4WYI89PJEQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734638349; c=relaxed/simple;
	bh=JFdVPVem4046BqyFJNrVT8yrmK5qAD0B08AcK/8jouc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=BuPZVC6PfmRxNEgZUTl+owl3iJ/jRduIbh8L/xh07iJrW/2BK5QRvBLCnbvompIWb344PZwc0yHujoMVLu3JlQQTeCxF2bYeeHVA33Dfjg5Zf4isXajFSjOihFKME9pMF1AJh0bfc0aRQg0iHm0R+fpGdz+RwfzFjfUCZj5aezM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=0wkKGBYS; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-5d3ea065b79so1579491a12.3
        for <linux-can@vger.kernel.org>; Thu, 19 Dec 2024 11:59:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1734638345; x=1735243145; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2hLOILUzDo5sXZb8TaMc1HjYSIW50UI2D0EZn3eUUCc=;
        b=0wkKGBYSOT+GOIyMCexAHrBesg9G+IyTAtBXbt0UUVtGefnsORJr+f2CZmNf9Rt5Rf
         OvrzsAKwGJq4lV5i+tEEXc/i61jsF701lnGL4L+znJSK6HWo1CqJz1brp0ewViDe4J0O
         T+YypQ+6hyFCkPfXNAUehGcIIrq71yEYM/CIlVNHSMwmqJmVAjx95YcKLP1I0jyUumuo
         amhihI9ZXTR66S7qgIERmhIy7zz99as17PPGhtqhWiTDMRH+qBz4eSvPoe4mIlds844Q
         7TB/J0g1BlCA5BruOCUSBTelm4EXFe45MXY/Einy/bYQ9rs/0OJIsUy+6UhFv3Dx81Tk
         Pw+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734638345; x=1735243145;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2hLOILUzDo5sXZb8TaMc1HjYSIW50UI2D0EZn3eUUCc=;
        b=hsw7HlyF/rzx9PoM1joDb+HlsHCcb1BnGWlC3j9zojtrOrYssrkPAMOUE1An5vr9aw
         Q8p9XFy+njYN7AqfDsIek33r0Bs9vXVPDvEETWyY/42/lXGo/NQB5EXgKN/NIM2bhuGM
         2I8J7yHlnxvzEpZR8pbp1CikmstgzYnGrmihPZuLmpPgPgA+G73BARub+e4aDtPUWmfN
         7cotPBw/OSSjJJ29OL++Hq3OQUA+kGkP8+i/phNZ8vyCtL2cMqG+BGaQBSfQUxquHm/1
         TbA1iBR0mEiEPfisWcqbUFwdwXlqGDvL3+j4cbv1qawht/5phuHnyqwau9dcLG1rcJu6
         7Jrw==
X-Gm-Message-State: AOJu0YwMC2YLCJubVPeZoakXaPe5DZhIVYlDWmRJg1Xp8tGLcNREKbvX
	KsbamfiOjd66nb8gIlkUeatg2jmVWv824LxvrjC5sURYh6xBV/hKk+38E9+3fxY=
X-Gm-Gg: ASbGncvYRWDPFVskNsLrmCxG93yyFifn9WCwWFr3k1eLjhmehw/91zB5HlgPkqPTS3Z
	wsz5M9YCaKs7PtzKp2WiRxRwoawHl+LsGoHA6dF4zUYJu/68sroi4LqQlqUsm2cofYQx7e65JWP
	mqXAeCMc4tP/JoL4nzWy9rWeoWym842fkf/gpaBfc5XFi1u9kpJVRif3CtB059qZZKAsRgkYds1
	tUvIghzsLw39pkj+17a+4Hgy4YEysHRprvp5ysYKoJH/m0LwA==
X-Google-Smtp-Source: AGHT+IF0fmv4Wr8LY08jRHZsI4hjJsYafL7GiFI9dClEL14qKh8/PvfWAazPI1H0PfTeK1OuVNPC+Q==
X-Received: by 2002:a05:6402:401a:b0:5d0:e560:487f with SMTP id 4fb4d7f45d1cf-5d81dd9cda0mr166803a12.11.1734638345098;
        Thu, 19 Dec 2024 11:59:05 -0800 (PST)
Received: from localhost ([2001:4090:a244:82f5:6854:cb:184:5d19])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5d80701c822sm944816a12.77.2024.12.19.11.59.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Dec 2024 11:59:04 -0800 (PST)
From: Markus Schneider-Pargmann <msp@baylibre.com>
Date: Thu, 19 Dec 2024 20:57:53 +0100
Subject: [PATCH v6 2/7] can: m_can: Map WoL to device_set_wakeup_enable
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241219-topic-mcan-wakeup-source-v6-12-v6-2-1356c7f7cfda@baylibre.com>
References: <20241219-topic-mcan-wakeup-source-v6-12-v6-0-1356c7f7cfda@baylibre.com>
In-Reply-To: <20241219-topic-mcan-wakeup-source-v6-12-v6-0-1356c7f7cfda@baylibre.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2839; i=msp@baylibre.com;
 h=from:subject:message-id; bh=JFdVPVem4046BqyFJNrVT8yrmK5qAD0B08AcK/8jouc=;
 b=owGbwMvMwCGm0rPl0RXRdfaMp9WSGNJTql42hv/19nSYusP1CavLp22BNzZ/n7ouRXbt/D8C6
 h7r+A5c6ChlYRDjYJAVU2S5+2Hhuzq56wsi1j1yhJnDygQyhIGLUwAmov+J4b9TXO2Cm37sN//f
 a8hrCUk+uTZxt8CZi5NOl7adu+ObLfaMkeFTQNfl8oeFMqtrDm/I4c1fUBR8zveqgEjR8R0uXD8
 MLzMBAA==
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
index 16e9e7d7527d9762d73a7ec47940c73c0976e05d..0dcdcde3449c7647e4bc9a92f918160a336f94c0 100644
--- a/drivers/net/can/m_can/m_can.c
+++ b/drivers/net/can/m_can/m_can.c
@@ -2186,6 +2186,36 @@ static int m_can_set_coalesce(struct net_device *dev,
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
@@ -2195,10 +2225,14 @@ static const struct ethtool_ops m_can_ethtool_ops_coalescing = {
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
@@ -2325,6 +2359,9 @@ struct m_can_classdev *m_can_class_allocate_dev(struct device *dev,
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


