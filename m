Return-Path: <linux-can+bounces-675-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EED1F8CCD65
	for <lists+linux-can@lfdr.de>; Thu, 23 May 2024 09:55:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9AE52282E66
	for <lists+linux-can@lfdr.de>; Thu, 23 May 2024 07:55:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81FD313D273;
	Thu, 23 May 2024 07:54:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="kg8Zfb/G"
X-Original-To: linux-can@vger.kernel.org
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A82E13CFAC
	for <linux-can@vger.kernel.org>; Thu, 23 May 2024 07:54:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716450870; cv=none; b=eE+R3UqjqMW5y7gih9FOwMnMwVNd6CHL5CXl3JGgObyTNQGQZoD/GSfLgOwEYYjcuyTbwwdaz2f3lI+hDeu/+KVsP25x5HBqfTVtIm6E9aguyCl037YoWuTgRdyulMIi72VTgvHwVzgdxE24kAnogSQPo0G0Fo3ZVur2dqxnDFk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716450870; c=relaxed/simple;
	bh=BPcdpNgRauvstbwBV7cyTFTtfwTX1AJQa1VOyBH+Orc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rGs16sQxuVEEdBFzwm6y9a8TkhLeav0SGuc6npKaetIH3Ljj5N7czFWc/1XSQ7Jb/adQEcbxmNjWbAxtSpKE2DcnpCWEnQImD4rYbecW46TO7ix233OfmdICNRX187kdH9mJs8rn0A+SVUS34Xv1lN33CWv3DsDW9D5NOTcDRjw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=kg8Zfb/G; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-34d9c9f2cf0so1965664f8f.3
        for <linux-can@vger.kernel.org>; Thu, 23 May 2024 00:54:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1716450867; x=1717055667; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hrFQSVhPJTExMHxUs9x2644C6X3jCTcC0vL8A1PKT6s=;
        b=kg8Zfb/GLOwSbemxCeWvdCe/ZqX+cEzQssOdpaqq4Yk/MH6BVrNZfbSPPDkyXwjsZe
         ARYgUbAxaqrilEzuM/moTqhvlRmYatcfb86ercfb4QY1gm/NJuwX3n4lFpYnU3IyTVA8
         mvBj28/TrQJ7umaAL6Z0gESqUN6OLAg7jCm5LI2BEcaIn0dL5bB8GpcCFGSaCxO5xQ5b
         xdu0R5lcCZz4VnwHbs9uEF/h+fRFtPcy43M+zwDIbqPPFASS1gy4BDTo6XN6hgyEPmR3
         cjaYSV074df5g+IQQnLzVzQXPGWWSK316Xd4y+Azam3bjW0mmCuFui4b8ZqTUo0+rvCm
         12yQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716450867; x=1717055667;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hrFQSVhPJTExMHxUs9x2644C6X3jCTcC0vL8A1PKT6s=;
        b=CbE+16P4R9HVtaHtFG5PirnMsDeC7i5mxNRfZazA2UOWUEHLQ3eEVVYhxNj7J8D5/Q
         XnwKm8xnDFNTm1EAMA7usDFwMvG6wP/AOVkrQjpUKAJK3MmYxCFMtfNaQ8a4BnLOd+mA
         76GfTIWKbmiH5Bvw1ztTOlyk5GmpLArhzGStUP9VOyLXeiHu8b1pLxHAeXvrSE+LjbX+
         j5OEIt8PALqOeUBCfbSn+O0b3oD2dumenzhKbv+iMl4Qs0OrkwL/fjL/IHtlcb+iHYLe
         EDMSPEF1HIcYlJxm90HmfkG2Yy/ZEA1fAMYQ24u9KkrusLAfJlltxaK11mtqfHsLyPue
         j9wQ==
X-Forwarded-Encrypted: i=1; AJvYcCUU5A3JnYk9Amq9qpn0HRl5G3mlP7UoO4065Ec2FAW0Ki4pxqvcOb1U3hQrfVet3UXJ+smo9euDNJvtFCNu7EoHWYG+JcT/fAzd
X-Gm-Message-State: AOJu0YwZoMtd86nCoGfwXFrOVPJGutAPDiG8xMzJG39j7I+fJV6SZRkW
	6OkkSzR3CEVvmIJAQ7YLsI+gsJxMxqCcz5m6iAv8OMrPLRur5Dh7p31szjWoTe8=
X-Google-Smtp-Source: AGHT+IHpdHwgvkOic2e5snbrW03BmHrtQiZTJlEnXodGIaGdt59+8iaoH1lfBH+5/wLQqizWIx78pA==
X-Received: by 2002:a05:6000:1fa5:b0:355:15a:f0b5 with SMTP id ffacd0b85a97d-355015af206mr229576f8f.32.1716450866839;
        Thu, 23 May 2024 00:54:26 -0700 (PDT)
Received: from blmsp.fritz.box ([2001:4091:a246:821e:6f3b:6b50:4762:8343])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3502baad074sm36501833f8f.70.2024.05.23.00.54.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 May 2024 00:54:26 -0700 (PDT)
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
Subject: [PATCH 3/7] can: m_can: Map WoL to device_set_wakeup_enable
Date: Thu, 23 May 2024 09:53:43 +0200
Message-ID: <20240523075347.1282395-4-msp@baylibre.com>
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

In some devices the pins of the m_can module can act as a wakeup source.
This patch helps do that by connecting the PHY_WAKE WoL option to
device_set_wakeup_enable. By marking this device as being wakeup
enabled, this setting can be used by platform code to decide which
sleep or poweroff mode to use.

Also this prepares the driver for the next patch in which the pinctrl
settings are changed depending on the desired wakeup source.

Signed-off-by: Markus Schneider-Pargmann <msp@baylibre.com>
---
 drivers/net/can/m_can/m_can.c | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/drivers/net/can/m_can/m_can.c b/drivers/net/can/m_can/m_can.c
index 14b231c4d7ec..80964e403a5e 100644
--- a/drivers/net/can/m_can/m_can.c
+++ b/drivers/net/can/m_can/m_can.c
@@ -2129,6 +2129,26 @@ static int m_can_set_coalesce(struct net_device *dev,
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
+
+	if ((wol->wolopts & WAKE_PHY) != wol->wolopts)
+		return -EINVAL;
+
+	device_set_wakeup_enable(cdev->dev, !!wol->wolopts & WAKE_PHY);
+
+	return 0;
+}
+
 static const struct ethtool_ops m_can_ethtool_ops = {
 	.supported_coalesce_params = ETHTOOL_COALESCE_RX_USECS_IRQ |
 		ETHTOOL_COALESCE_RX_MAX_FRAMES_IRQ |
@@ -2142,6 +2162,8 @@ static const struct ethtool_ops m_can_ethtool_ops = {
 
 static const struct ethtool_ops m_can_ethtool_ops_polling = {
 	.get_ts_info = ethtool_op_get_ts_info,
+	.get_wol = m_can_get_wol,
+	.set_wol = m_can_set_wol,
 };
 
 static int register_m_can_dev(struct net_device *dev)
@@ -2266,6 +2288,9 @@ struct m_can_classdev *m_can_class_allocate_dev(struct device *dev,
 		goto out;
 	}
 
+	if (dev->of_node && of_property_read_bool(dev->of_node, "wakeup-source"))
+		device_set_wakeup_capable(dev, true);
+
 	/* Get TX FIFO size
 	 * Defines the total amount of echo buffers for loopback
 	 */
-- 
2.43.0


