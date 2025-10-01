Return-Path: <linux-can+bounces-5094-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C11FBB0B4E
	for <lists+linux-can@lfdr.de>; Wed, 01 Oct 2025 16:31:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 60F79177AF9
	for <lists+linux-can@lfdr.de>; Wed,  1 Oct 2025 14:31:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 712AD25B1FC;
	Wed,  1 Oct 2025 14:31:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="vXVt2X3a"
X-Original-To: linux-can@vger.kernel.org
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A62C256C88
	for <linux-can@vger.kernel.org>; Wed,  1 Oct 2025 14:31:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759329078; cv=none; b=XLuKTbNomuQtdVjhNgQmqP8bt1redCF6aFEcca0HTMI+9qmVsqfubvUm+sjXmU+nwhS/uUBhnp98Wpuu1+bC9eBULS4xHhM+i3lXl5eeEuHRDs0/d7X0H+soP8zJ+wnY84XKQ6yORQA7mQBSXyYvRGlEFI4DzEZ9gAqpja2kEGc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759329078; c=relaxed/simple;
	bh=xZlvLU7Ypb0xKlRYD5iljCSFnDT7FHVy6fNCxwcJyWU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=dt1f5/PI6T0GAQ1h9D7/q3WbzKBTtXE4XkSFyRyT0QQjfnvtKz1yRitPSm7brza5OzZcx321UUF/8wUU0T76IzXTlvIwD59FFB1ewbxqvHG0wvkeZqe8h5foN760s91E4HB1QXrLBshsY5/PNqGkccTHOkm4bV+0N3gCMfY36Qw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=vXVt2X3a; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-afcb7a16441so1189666566b.2
        for <linux-can@vger.kernel.org>; Wed, 01 Oct 2025 07:31:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1759329075; x=1759933875; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Dzk1cyUo2yEMvFwDWljkPdo7pcoK+QmbShr4jxlb2e4=;
        b=vXVt2X3aBfV9Sr2VW6jz97BBtD0orWG6kIfmIPHOqrANqwfjgML0CUfVdfzk0kdCxu
         VO0LTmI5lIUq3lRXgM3FTcK9Zcpibq9tASsF8flKhjEdZNw/tYmXJHn2iNY3PpLxXWt/
         843ICzkhYJ7zL3ywtiIsVLsavec/sVWv5hG4ppt6V9jh5+9Xf4yBuYaPiH9takeEaRxb
         9olio9kEO7jK9ZFgMDLdJiy/gNKwUZB4pggDIbxoMGLiNHCMd/38tP7wFgk+x4owvAOV
         gVK4n64hsjoopuD3eJFzKPURqM8NudgLilvAg9adtql4XB6z7lLjQzllPKEOP3j4NdxD
         o9Hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759329075; x=1759933875;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Dzk1cyUo2yEMvFwDWljkPdo7pcoK+QmbShr4jxlb2e4=;
        b=mgtH/LDMxtl/U2m2AiL36sUZAQyJKXhnpaDTYqVTNaBDTVVN+BUdVgNZ84tdPCN+cB
         /MNz9mZ1jtpf2Ky0alAeGZsSJzzoNGMOqR/ZdoM9ly2f+S5BfgJ0MakigQyPdLUxdmU5
         /LOXafYpmqB0WmJWfzvgt5fVc3vaPL3q5FvgmIw8G+x+4EBJ3IylNlcqi8bU3nUgBBY8
         KWfqQ3pRWhV8n27NQc+M6J26J4wepKhbmDdyqo8wO18V7Fabmm+hbz/Jvn5Eh/2WlQeN
         JDiWoeu0mvV0fVqGY1kfgUniL9c3cUDuG8kU6t+nH0axhEGrP8DOefXfFrsigzxco7JX
         9PKg==
X-Forwarded-Encrypted: i=1; AJvYcCV9fjHXJXeO9m6aPE1HwT0QJYpFVI3liH+JAsw+nkSR+tCC0fr3xKrILcHZ0rNCMYlibO4+Eyg+SmE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwExQgyFpixmDWLpYJqwPhyUrw3omC7h5rfFRX1ybnG7mKWZaHj
	DR+4n5pun5gNIWqMxhDw0XUSf1BN0Suf7woi89jbbiAkYYE+OQztVFNhgZdCsj/8hfQ=
X-Gm-Gg: ASbGncuchGaHITdzG8EKO3abkZ8NPjWgIziwbCFi/rwOIZLXEbRJoIz1sKVN5pbGjGu
	/KVF9cO/o+eAvEOysxoXy9itsb9KEBwhZGwbaNKffbpiMdtFPoioAcCV9lolZyOpA8D14YUt2Zp
	v95HBxJoQLKdm3jwXVExghNrigpcCiZ1NPnfrftxa/9ZDR0y3+fyms5a2od3vM2NeXCbPekPJV2
	SegxKQdr8MMQSuQnTWvCsd+MfcvUZkiiZgp5LHw0maqPaatmpHJRHP070dWZz++Ntt1NkVaDLS7
	/5LKj0dvxTCrsAC5ikXaOv+hmfdg/OzaKPfMc7yGPex6RyiCQGcUSIaFkDuDlXs5LPVcoNlE9tC
	xKC6GZd161n9UznM1zGWmjhgK8Cp/wU1MAUgDYoXm3LHR
X-Google-Smtp-Source: AGHT+IHrAMb+09uZwyMeIOg5Yw3oASNR/LZNf7+KcvjDZ2MgIgL6Lyu/U/SVL3McQ0r9P6GhOXrzLw==
X-Received: by 2002:a17:907:94d5:b0:b3e:580a:184f with SMTP id a640c23a62f3a-b46e0cb30f8mr499997966b.4.1759329074660;
        Wed, 01 Oct 2025 07:31:14 -0700 (PDT)
Received: from localhost ([2001:4090:a245:8496:49da:2c07:5e9a:7fb9])
        by smtp.gmail.com with UTF8SMTPSA id a640c23a62f3a-b3e89655b09sm683210466b.77.2025.10.01.07.31.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Oct 2025 07:31:14 -0700 (PDT)
From: "Markus Schneider-Pargmann (TI.com)" <msp@baylibre.com>
Date: Wed, 01 Oct 2025 16:30:20 +0200
Subject: [PATCH v10 2/4] can: m_can: Map WoL to device_set_wakeup_enable
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251001-topic-mcan-wakeup-source-v6-12-v10-2-4ab508ac5d1e@baylibre.com>
References: <20251001-topic-mcan-wakeup-source-v6-12-v10-0-4ab508ac5d1e@baylibre.com>
In-Reply-To: <20251001-topic-mcan-wakeup-source-v6-12-v10-0-4ab508ac5d1e@baylibre.com>
To: Chandrasekar Ramakrishnan <rcsekar@samsung.com>, 
 Marc Kleine-Budde <mkl@pengutronix.de>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Vincent Mailhol <mailhol@kernel.org>
Cc: Vishal Mahaveer <vishalm@ti.com>, Kevin Hilman <khilman@baylibre.com>, 
 Dhruva Gole <d-gole@ti.com>, Sebin Francis <sebin.francis@ti.com>, 
 Kendall Willis <k-willis@ti.com>, Akashdeep Kaur <a-kaur@ti.com>, 
 Simon Horman <horms@kernel.org>, linux-can@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 "Markus Schneider-Pargmann (TI.com)" <msp@baylibre.com>, 
 Vincent Mailhol <mailhol@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2895; i=msp@baylibre.com;
 h=from:subject:message-id; bh=xZlvLU7Ypb0xKlRYD5iljCSFnDT7FHVy6fNCxwcJyWU=;
 b=owGbwMvMwCXWejAsc4KoVzDjabUkhoy71tJMSUE53iVthy5YThN0+73q8y1GK/H8EwWsX2/cE
 J3Hv+xeRykLgxgXg6yYIktnYmjaf/mdx5IXLdsMM4eVCWQIAxenAExEbT8jw565j2qrd019MH9N
 HMuW/luP/1xe0hR8fMvPlNxpS4/PO9DK8D9oLTvLHtYfPJ9NmLNdTmSuqpdg19kkd8HMwOOO0IG
 7otwA
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
Reviewed-by: Kendall Willis <k-willis@ti.com>
Signed-off-by: Markus Schneider-Pargmann (TI.com) <msp@baylibre.com>
---
 drivers/net/can/m_can/m_can.c | 37 +++++++++++++++++++++++++++++++++++++
 1 file changed, 37 insertions(+)

diff --git a/drivers/net/can/m_can/m_can.c b/drivers/net/can/m_can/m_can.c
index e1d725979685ff90bff9957bcf6193265bfbcb55..e5588e2205797be03090a7317e9d3518bc09b054 100644
--- a/drivers/net/can/m_can/m_can.c
+++ b/drivers/net/can/m_can/m_can.c
@@ -2220,6 +2220,36 @@ static int m_can_set_coalesce(struct net_device *dev,
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
@@ -2229,10 +2259,14 @@ static const struct ethtool_ops m_can_ethtool_ops_coalescing = {
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
@@ -2359,6 +2393,9 @@ struct m_can_classdev *m_can_class_allocate_dev(struct device *dev,
 		goto out;
 	}
 
+	if (dev->of_node && of_property_read_bool(dev->of_node, "wakeup-source"))
+		device_set_wakeup_capable(dev, true);
+
 	/* Get TX FIFO size
 	 * Defines the total amount of echo buffers for loopback
 	 */

-- 
2.51.0


