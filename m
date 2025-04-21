Return-Path: <linux-can+bounces-3444-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 156A1A94DB8
	for <lists+linux-can@lfdr.de>; Mon, 21 Apr 2025 10:11:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E13AE7A2CD5
	for <lists+linux-can@lfdr.de>; Mon, 21 Apr 2025 08:10:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E813212FBF;
	Mon, 21 Apr 2025 08:11:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="OD7nzw7K"
X-Original-To: linux-can@vger.kernel.org
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1679320E70B
	for <linux-can@vger.kernel.org>; Mon, 21 Apr 2025 08:11:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745223074; cv=none; b=R5ZM0I5DJFXs/u+U4cYdwZBIxa6lY6N5LS5cOEbmJmJGEAuBDq9iR/9ds1wCg+w7CudwNHzYW96qUFKaQEX98muYzrfw8YAwYmKYoOhQ/VGHO5NcW4PdFSVPjkcHR8QxCLqlAksNVwiaWTyf/8AINDsPBXitrotzHloQodjB57A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745223074; c=relaxed/simple;
	bh=dDHRE1N1nz5IxvkFWD189S+eb/qdswz6/31P5AqP5ho=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=I55hTn12dPVzyVJ7BdDr3hma6mwEWMWCYy3dWjNtXsOOPBkZ4EU+lqYM/WzIvejbKaGmwhtNmhDj7MygglxrLwRh1IRm+fVyvk1Tc6xHfF7Wx+av4vUN62tS1MbUBBlJfg1+gxa1vp1ps1tdCrN4jeZSxh0z5OhjDgC1YFOnnzA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=OD7nzw7K; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-5e6c18e2c7dso7036853a12.3
        for <linux-can@vger.kernel.org>; Mon, 21 Apr 2025 01:11:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1745223069; x=1745827869; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qSuVgbbOPBnjsDOIduDjz+jGxykBq30MNjzwBqDkw2g=;
        b=OD7nzw7KneatgmKmpU7MmOWuvm2Afl1P//Jjp57ezoR0E6wlGLE9d1zT1dW1JVT0Wo
         0D+E3/1yYjySQrHeBHZCqibGJxKC08rDXP8KMzsfUq8wN2HqVgK/XehtOzK/BTXXVekM
         s5eNfxgfZmM8Wwsa98/vsGAAMYUKN7xeyH3F5suXUvs2Hi8d7dmE9ZlDElyYv4+3Qh1P
         GFVoeDdtJQtv/HX5rKQaPf4u13mnS4lEguLKPjYyCO1vDNJr0a2vU1MfCDBewjV+73Cx
         6fXanhHAqZ+yiF1wPIkPYNzIG12oGL1Xzh+lpB7PRvvJsIx0nntw+r1vZuIY24DDy1Fm
         aqHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745223069; x=1745827869;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qSuVgbbOPBnjsDOIduDjz+jGxykBq30MNjzwBqDkw2g=;
        b=Omg1qhF5CWeAPpB72IgvekMy5Su0g/+1GXiUw/N+ckbkc3eJIfcJEP6EsEA+/EpDnq
         w5VlZ/XK4JnNFGNdoS8IhdQMmirgZhLmOhZty2Y9Sf0FcEDYpmtlCioUMRdM9hHTlzfl
         vjjl6j9iHLWBZ2ILh9rvAg2CZmexDpUNOpcFWQLx3pogMYLlVGd4z2pqqVkvbMy/54IT
         wyeNgoyrgJJWt0ONhSXNhHdiTOctqXOHw5eVQ9Df74u1yEaFa40mNL05USiS4D9XgPkD
         J+6JuZZu5eQfICVDsNbvy+w+DohlIjBm1AeB6RFI+9zgLPNTIo000/oSFkxV9jgQ3grf
         LpIA==
X-Forwarded-Encrypted: i=1; AJvYcCXAENQerrEZVExOrmYJgiro+xjYMUeaxov4HMwr/KGRYB1n4LumD2LUHXGPTMXZj2uDxJdPMr5LDkM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzcNortcPS2reiUI4B4/qLautPqWlrP1NS2BMNpwpjqUh8JbNkv
	fNCFJi6xmFFBIbJxn5LkduTGi86Of2Ns8h3PGR7HYLfCDjMtdvdBqg363hUuztQ=
X-Gm-Gg: ASbGnctQu/gp/ZNwJHZxOYWZCIBfWx1h3E3B4pkJHnbG6gh+IoRrRUfC/D92NLa1kgC
	3eIdf0+jvNh3vDwxrvDAG3r3KYMFqk0WvMX3UACveawAZiVuJ2UGv237sstIXdBGRJkY/vs52WH
	jqsRn07WzxbfRKM8K3tKG4seuOb+26CDo93xa/SPJvknqE5C3502mrYtJGRb1Np0l6Glve/qR8h
	LyOxPB4pWkzUoJcvix6BTQzJnRl2OJw1DgzViuRC4cb0cLxRgyjSS3rQJiOhtygsNg/unDSpOIk
	SBT5HV+vX3LgPWa61jkXZkxBL9EIeiWz4UA=
X-Google-Smtp-Source: AGHT+IEsRYa/rGSxt5vTfUSELawpvZ3nxncA/J4aiCnhXctfiKhQ6OgVur7z1uLT9K/5OYdZOn7/LQ==
X-Received: by 2002:a05:6402:1d49:b0:5f5:f890:3dd5 with SMTP id 4fb4d7f45d1cf-5f6285461aemr8429941a12.15.1745223069231;
        Mon, 21 Apr 2025 01:11:09 -0700 (PDT)
Received: from localhost ([2001:4091:a245:826e:c0c:4cef:7dd:26bd])
        by smtp.gmail.com with UTF8SMTPSA id 4fb4d7f45d1cf-5f625578098sm4254090a12.20.2025.04.21.01.11.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Apr 2025 01:11:08 -0700 (PDT)
From: Markus Schneider-Pargmann <msp@baylibre.com>
Date: Mon, 21 Apr 2025 10:10:38 +0200
Subject: [PATCH v7 2/4] can: m_can: Map WoL to device_set_wakeup_enable
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250421-topic-mcan-wakeup-source-v6-12-v7-2-1b7b916c9832@baylibre.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2839; i=msp@baylibre.com;
 h=from:subject:message-id; bh=dDHRE1N1nz5IxvkFWD189S+eb/qdswz6/31P5AqP5ho=;
 b=owGbwMvMwCXWejAsc4KoVzDjabUkhgzWv52vzl9Q/Rq9+IvCy9vFErdZdjEePFpUGjmDxW49l
 4P2M4tbHaUsDGJcDLJiiiydiaFp/+V3HktetGwzzBxWJpAhDFycAjCRJ/GMDB9+sXu3N3+0qOa/
 KW/xlvNa/mVW60wX36IClRdMdq11qgx/xcxbmjY+nup/iZ3BYVmOxjGj62nL7jGIy8pba21e9e0
 MIwA=
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
index 884a6352c42b7bc372c55a6be19ca9fcb15d3d63..20f7533ad9e7735013ff000e6f3b11d016f8a09f 100644
--- a/drivers/net/can/m_can/m_can.c
+++ b/drivers/net/can/m_can/m_can.c
@@ -2222,6 +2222,36 @@ static int m_can_set_coalesce(struct net_device *dev,
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
@@ -2231,10 +2261,14 @@ static const struct ethtool_ops m_can_ethtool_ops_coalescing = {
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
@@ -2361,6 +2395,9 @@ struct m_can_classdev *m_can_class_allocate_dev(struct device *dev,
 		goto out;
 	}
 
+	if (dev->of_node && of_property_read_bool(dev->of_node, "wakeup-source"))
+		device_set_wakeup_capable(dev, true);
+
 	/* Get TX FIFO size
 	 * Defines the total amount of echo buffers for loopback
 	 */

-- 
2.49.0


