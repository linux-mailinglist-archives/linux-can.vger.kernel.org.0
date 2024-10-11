Return-Path: <linux-can+bounces-1623-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D0C0599A4BC
	for <lists+linux-can@lfdr.de>; Fri, 11 Oct 2024 15:18:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 68CBA28303F
	for <lists+linux-can@lfdr.de>; Fri, 11 Oct 2024 13:18:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDA1B219CB0;
	Fri, 11 Oct 2024 13:18:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="mc42f60X"
X-Original-To: linux-can@vger.kernel.org
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA32121949B
	for <linux-can@vger.kernel.org>; Fri, 11 Oct 2024 13:18:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728652685; cv=none; b=PRutuqyrCdijICFcLhsl7PsuVSazJyCx6FBATx3/S8oS2DbR3CAxum9GoAVyJmazYfRo+ap3Ir36del4piYw8TF9rG0zM6KLkY8FcCRj5eWri8Lpy7FH2pmiaiGfnI+I0A2rmCnuZA4Co01rFjfb/WL2ir/HYPUVaCTXUmtSstA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728652685; c=relaxed/simple;
	bh=cwyU19cQrq3CFX81zcGwso0Vwsxh5WskwRCVqlVQBpY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=NRFq2VQ7q9iS0DE+l6IPbHgI7KbYWDWFUX/MiASXycQ2NW/c8WXb1C1W0NceKdMswZHf2XlNEHZ3fqI9evZOew3Cm72d6NyLjY7qMSXRYGgYetyjA1EQIDnJ6md2K2xq0rAlSuJG+1zNADikF4NRc5PXmhJsyGiNoS5saV+r+sQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=mc42f60X; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-a998a5ca499so286844666b.0
        for <linux-can@vger.kernel.org>; Fri, 11 Oct 2024 06:18:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1728652682; x=1729257482; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GSdY/jWydsnh5WtGKd8S4In1q/EQUwCvNawFPtKHEzU=;
        b=mc42f60X8a/b00gOdY/nGotsyNSbgFvSUKYXnSXEWzqjTk/2ifXLA6kfSI7VoDMjlR
         XN4nS4N4xKKv+0TKPHDHEi8cI8d3dj+aInyNlssOZWF8Mo2AkFZKXO17Yg7yH2nIvkVK
         0bI4BOhc91VxMJcNnxZGNV+8bYmWu1F7rzH/dYH/pQvjPTgcC1MjYnJn7kR2iyW1MUgz
         Cjs8DoD4Je9kqX6WlCYFm4KyLoWO0dP+7qxsFiz++yh7fvJqO3UBsQ0B+t8N3Sy0lHyf
         0FEHXhuVQj4/12/xdC6/fOm51Ka4M5pCCkC+udaHkzjzVKIIh2FAD5krLotCkGxahNoy
         uYtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728652682; x=1729257482;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GSdY/jWydsnh5WtGKd8S4In1q/EQUwCvNawFPtKHEzU=;
        b=hyh39aw1tJTRtOZV7K4cOdICXURWEFyi5oQ+jvOVdMwlsh2X+N5ceAQoMK84cK/F0N
         vYV2a68rcjC36hEG9KiOqLWydMXB8hEJ+MQC7YzBdURVwIXZUjDSDvANpOdP0mKWmJUn
         7e99z0NA0JPSBZZhdIPaNzf9jf3NdlpaLqh94aD4rxkmPb1pGecn39riJXWyu+m3kga/
         7DEt9FgPtFOKu7TaABI11BKsLuPk14pcAsB8wuR28qAJ64INCVrOpoYXfvcY4yOfoUnh
         G8QsF2gGHqcLZRp6VPgqKzgfxunb/eDmufQ6NY/MY/rL6M+a05EPIXaF7OXGXysTQzit
         bcRw==
X-Gm-Message-State: AOJu0Yz7o81l8JqRzl6vOq97zacuCuUqSV7AoIx3V0r0rF/HLFTQHm8T
	/dBac2Qupsgu5kw5Zy5fL9SoHoPlUpSlLYjzvpHqHeeXLONF2E5KN8bZohhNQVM=
X-Google-Smtp-Source: AGHT+IEldii35e9PVlPZq7x1sIW5eSePwbQUs9Zkn2MXaSKHf3A/zUtyi0U68UtWtK/MFFkB8BzaRQ==
X-Received: by 2002:a17:907:6d22:b0:a99:40e6:157c with SMTP id a640c23a62f3a-a99b930192dmr224582866b.4.1728652682272;
        Fri, 11 Oct 2024 06:18:02 -0700 (PDT)
Received: from localhost ([2001:4090:a244:83ae:2517:2666:43c9:d0d3])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a99a80df530sm212717066b.145.2024.10.11.06.18.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Oct 2024 06:18:01 -0700 (PDT)
From: Markus Schneider-Pargmann <msp@baylibre.com>
Date: Fri, 11 Oct 2024 15:16:40 +0200
Subject: [PATCH v3 3/9] can: m_can: Map WoL to device_set_wakeup_enable
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241011-topic-mcan-wakeup-source-v6-12-v3-3-9752c714ad12@baylibre.com>
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
 Dhruva Gole <d-gole@ti.com>, Markus Schneider-Pargmann <msp@baylibre.com>, 
 Andrew Lunn <andrew@lunn.ch>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2838; i=msp@baylibre.com;
 h=from:subject:message-id; bh=cwyU19cQrq3CFX81zcGwso0Vwsxh5WskwRCVqlVQBpY=;
 b=owGbwMvMwCGm0rPl0RXRdfaMp9WSGNI5VRN01scys/0ROFZQ7ylmKfw1ZNPKvnsdr7es7vJJy
 92oP/1YRykLgxgHg6yYIsvdDwvf1cldXxCx7pEjzBxWJpAhDFycAjCR3KsM/7RYmS5OuZNmd99Z
 LKHvwfFNQp3/g39di/+g4B4n5MKcW8Pwv6p/68TPjFx90aK3AxynV854Vr5yjWbI3x1Cb3bUnhM
 T5gMA
X-Developer-Key: i=msp@baylibre.com; a=openpgp;
 fpr=BADD88DB889FDC3E8A3D5FE612FA6A01E0A45B41

In some devices the pins of the m_can module can act as a wakeup source.
This patch helps do that by connecting the PHY_WAKE WoL option to
device_set_wakeup_enable. By marking this device as being wakeup
enabled, this setting can be used by platform code to decide which
sleep or poweroff mode to use.

Also this prepares the driver for the next patch in which the pinctrl
settings are changed depending on the desired wakeup source.

Signed-off-by: Markus Schneider-Pargmann <msp@baylibre.com>
Reviewed-by: Andrew Lunn <andrew@lunn.ch>
---
 drivers/net/can/m_can/m_can.c | 37 +++++++++++++++++++++++++++++++++++++
 1 file changed, 37 insertions(+)

diff --git a/drivers/net/can/m_can/m_can.c b/drivers/net/can/m_can/m_can.c
index a978b960f1f1e1e8273216ff330ab789d0fd6d51..29accadc20de7e9efa509f14209cc62e599f03bb 100644
--- a/drivers/net/can/m_can/m_can.c
+++ b/drivers/net/can/m_can/m_can.c
@@ -2185,6 +2185,36 @@ static int m_can_set_coalesce(struct net_device *dev,
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
+	bool wol_enable = !!wol->wolopts & WAKE_PHY;
+	int ret;
+
+	if ((wol->wolopts & WAKE_PHY) != wol->wolopts)
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
@@ -2194,10 +2224,14 @@ static const struct ethtool_ops m_can_ethtool_ops_coalescing = {
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
@@ -2324,6 +2358,9 @@ struct m_can_classdev *m_can_class_allocate_dev(struct device *dev,
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


