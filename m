Return-Path: <linux-can+bounces-1490-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A42829763FC
	for <lists+linux-can@lfdr.de>; Thu, 12 Sep 2024 10:07:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0D7A6B21012
	for <lists+linux-can@lfdr.de>; Thu, 12 Sep 2024 08:06:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27053193407;
	Thu, 12 Sep 2024 08:06:20 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54F56190675
	for <linux-can@vger.kernel.org>; Thu, 12 Sep 2024 08:06:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726128380; cv=none; b=dmZdx6Eaihez3HV2xU/XWMh8cDCxmUaUQe8mMqgDylub/oPwTR4QXpbd0X3te2jtwTRFd2AAmh3gUAWwKBZOGcDe5UACvtgirAWKwXxkFIgvzRklhw+Z4X7w9DddGkM4Ujms+LhJhd9zBDbulSSCsA6Cr8YCieYvQF0yZjeOtFs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726128380; c=relaxed/simple;
	bh=PLUpfqVOEGJ6GCByah3TZI6cwIKlQLUdkndCuLFiuHI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sZpiO9EXPbRpKNvEeK93qrdStzBK95TjH17TFEX8zfudRCRHiAbIC8Wrm8uXfxhrVZBo+IbmJYLIeuqL31Uts7SW1z0FwTaQBo54wc/UisPxSXm/MagL8nlEuUJE+K3fDr3yvop3QFgXV5k23lsznl7mJMi3La1xUq7d/9FiTy8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1soeq9-000495-OX
	for linux-can@vger.kernel.org; Thu, 12 Sep 2024 10:06:09 +0200
Received: from [2a0a:edc0:0:b01:1d::7b] (helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <mkl@pengutronix.de>)
	id 1soeq6-007KgI-Tp
	for linux-can@vger.kernel.org; Thu, 12 Sep 2024 10:06:07 +0200
Received: from dspam.blackshift.org (localhost [127.0.0.1])
	by bjornoya.blackshift.org (Postfix) with SMTP id 44DA2338ED7
	for <linux-can@vger.kernel.org>; Thu, 12 Sep 2024 08:04:42 +0000 (UTC)
Received: from hardanger.blackshift.org (unknown [172.20.34.65])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by bjornoya.blackshift.org (Postfix) with ESMTPS id C382D338E9F;
	Thu, 12 Sep 2024 08:04:40 +0000 (UTC)
Received: from blackshift.org (localhost [::1])
	by hardanger.blackshift.org (OpenSMTPD) with ESMTP id f670d08f;
	Thu, 12 Sep 2024 08:04:40 +0000 (UTC)
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	linux-can@vger.kernel.org,
	kernel@pengutronix.de,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>,
	Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH net-next 1/5] can: Switch back to struct platform_driver::remove()
Date: Thu, 12 Sep 2024 09:58:58 +0200
Message-ID: <20240912080438.2826895-2-mkl@pengutronix.de>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240912080438.2826895-1-mkl@pengutronix.de>
References: <20240912080438.2826895-1-mkl@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org

From: Uwe Kleine-König <u.kleine-koenig@baylibre.com>

After commit 0edb555a65d1 ("platform: Make platform_driver::remove()
return void") .remove() is (again) the right callback to implement for
platform drivers.

Convert all can drivers to use .remove(), with the eventual goal to drop
struct platform_driver::remove_new(). As .remove() and .remove_new() have
the same prototypes, conversion is done by just changing the structure
member name in the driver initializer.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@baylibre.com>
Link: https://patch.msgid.link/20240909072742.381003-2-u.kleine-koenig@baylibre.com
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/at91_can.c                   | 2 +-
 drivers/net/can/bxcan.c                      | 2 +-
 drivers/net/can/c_can/c_can_platform.c       | 2 +-
 drivers/net/can/cc770/cc770_isa.c            | 2 +-
 drivers/net/can/cc770/cc770_platform.c       | 2 +-
 drivers/net/can/ctucanfd/ctucanfd_platform.c | 2 +-
 drivers/net/can/flexcan/flexcan-core.c       | 2 +-
 drivers/net/can/grcan.c                      | 2 +-
 drivers/net/can/ifi_canfd/ifi_canfd.c        | 2 +-
 drivers/net/can/janz-ican3.c                 | 2 +-
 drivers/net/can/m_can/m_can_platform.c       | 2 +-
 drivers/net/can/mscan/mpc5xxx_can.c          | 2 +-
 drivers/net/can/rcar/rcar_can.c              | 2 +-
 drivers/net/can/rcar/rcar_canfd.c            | 2 +-
 drivers/net/can/sja1000/sja1000_isa.c        | 2 +-
 drivers/net/can/sja1000/sja1000_platform.c   | 2 +-
 drivers/net/can/softing/softing_main.c       | 2 +-
 drivers/net/can/sun4i_can.c                  | 2 +-
 drivers/net/can/ti_hecc.c                    | 2 +-
 drivers/net/can/xilinx_can.c                 | 2 +-
 20 files changed, 20 insertions(+), 20 deletions(-)

diff --git a/drivers/net/can/at91_can.c b/drivers/net/can/at91_can.c
index 11f434d708b3..191707d7e3da 100644
--- a/drivers/net/can/at91_can.c
+++ b/drivers/net/can/at91_can.c
@@ -1191,7 +1191,7 @@ MODULE_DEVICE_TABLE(platform, at91_can_id_table);
 
 static struct platform_driver at91_can_driver = {
 	.probe = at91_can_probe,
-	.remove_new = at91_can_remove,
+	.remove = at91_can_remove,
 	.driver = {
 		.name = KBUILD_MODNAME,
 		.of_match_table = of_match_ptr(at91_can_dt_ids),
diff --git a/drivers/net/can/bxcan.c b/drivers/net/can/bxcan.c
index 49cf9682b925..bfc60eb33dc3 100644
--- a/drivers/net/can/bxcan.c
+++ b/drivers/net/can/bxcan.c
@@ -1092,7 +1092,7 @@ static struct platform_driver bxcan_driver = {
 		.of_match_table = bxcan_of_match,
 	},
 	.probe = bxcan_probe,
-	.remove_new = bxcan_remove,
+	.remove = bxcan_remove,
 };
 
 module_platform_driver(bxcan_driver);
diff --git a/drivers/net/can/c_can/c_can_platform.c b/drivers/net/can/c_can/c_can_platform.c
index e2ec69aa46e5..6cba9717a6d8 100644
--- a/drivers/net/can/c_can/c_can_platform.c
+++ b/drivers/net/can/c_can/c_can_platform.c
@@ -476,7 +476,7 @@ static struct platform_driver c_can_plat_driver = {
 		.of_match_table = c_can_of_table,
 	},
 	.probe = c_can_plat_probe,
-	.remove_new = c_can_plat_remove,
+	.remove = c_can_plat_remove,
 	.suspend = c_can_suspend,
 	.resume = c_can_resume,
 	.id_table = c_can_id_table,
diff --git a/drivers/net/can/cc770/cc770_isa.c b/drivers/net/can/cc770/cc770_isa.c
index 22009440a983..d06762817153 100644
--- a/drivers/net/can/cc770/cc770_isa.c
+++ b/drivers/net/can/cc770/cc770_isa.c
@@ -307,7 +307,7 @@ static void cc770_isa_remove(struct platform_device *pdev)
 
 static struct platform_driver cc770_isa_driver = {
 	.probe = cc770_isa_probe,
-	.remove_new = cc770_isa_remove,
+	.remove = cc770_isa_remove,
 	.driver = {
 		.name = KBUILD_MODNAME,
 	},
diff --git a/drivers/net/can/cc770/cc770_platform.c b/drivers/net/can/cc770/cc770_platform.c
index f2424fe58612..b6c4f02ffb97 100644
--- a/drivers/net/can/cc770/cc770_platform.c
+++ b/drivers/net/can/cc770/cc770_platform.c
@@ -247,7 +247,7 @@ static struct platform_driver cc770_platform_driver = {
 		.of_match_table = cc770_platform_table,
 	},
 	.probe = cc770_platform_probe,
-	.remove_new = cc770_platform_remove,
+	.remove = cc770_platform_remove,
 };
 
 module_platform_driver(cc770_platform_driver);
diff --git a/drivers/net/can/ctucanfd/ctucanfd_platform.c b/drivers/net/can/ctucanfd/ctucanfd_platform.c
index 55bb10b157b4..70e2577c8541 100644
--- a/drivers/net/can/ctucanfd/ctucanfd_platform.c
+++ b/drivers/net/can/ctucanfd/ctucanfd_platform.c
@@ -111,7 +111,7 @@ MODULE_DEVICE_TABLE(of, ctucan_of_match);
 
 static struct platform_driver ctucanfd_driver = {
 	.probe	= ctucan_platform_probe,
-	.remove_new = ctucan_platform_remove,
+	.remove = ctucan_platform_remove,
 	.driver	= {
 		.name = DRV_NAME,
 		.pm = &ctucan_platform_pm_ops,
diff --git a/drivers/net/can/flexcan/flexcan-core.c b/drivers/net/can/flexcan/flexcan-core.c
index d11411029330..ac1a860986df 100644
--- a/drivers/net/can/flexcan/flexcan-core.c
+++ b/drivers/net/can/flexcan/flexcan-core.c
@@ -2385,7 +2385,7 @@ static struct platform_driver flexcan_driver = {
 		.of_match_table = flexcan_of_match,
 	},
 	.probe = flexcan_probe,
-	.remove_new = flexcan_remove,
+	.remove = flexcan_remove,
 	.id_table = flexcan_id_table,
 };
 
diff --git a/drivers/net/can/grcan.c b/drivers/net/can/grcan.c
index 6d3ba71a6a73..cdf0ec9fa7f3 100644
--- a/drivers/net/can/grcan.c
+++ b/drivers/net/can/grcan.c
@@ -1725,7 +1725,7 @@ static struct platform_driver grcan_driver = {
 		.of_match_table = grcan_match,
 	},
 	.probe = grcan_probe,
-	.remove_new = grcan_remove,
+	.remove = grcan_remove,
 };
 
 module_platform_driver(grcan_driver);
diff --git a/drivers/net/can/ifi_canfd/ifi_canfd.c b/drivers/net/can/ifi_canfd/ifi_canfd.c
index 72307297d75e..d32b10900d2f 100644
--- a/drivers/net/can/ifi_canfd/ifi_canfd.c
+++ b/drivers/net/can/ifi_canfd/ifi_canfd.c
@@ -1033,7 +1033,7 @@ static struct platform_driver ifi_canfd_plat_driver = {
 		.of_match_table	= ifi_canfd_of_table,
 	},
 	.probe	= ifi_canfd_plat_probe,
-	.remove_new = ifi_canfd_plat_remove,
+	.remove = ifi_canfd_plat_remove,
 };
 
 module_platform_driver(ifi_canfd_plat_driver);
diff --git a/drivers/net/can/janz-ican3.c b/drivers/net/can/janz-ican3.c
index d048ea565b89..60c7b83b4539 100644
--- a/drivers/net/can/janz-ican3.c
+++ b/drivers/net/can/janz-ican3.c
@@ -2049,7 +2049,7 @@ static struct platform_driver ican3_driver = {
 		.name	= DRV_NAME,
 	},
 	.probe		= ican3_probe,
-	.remove_new	= ican3_remove,
+	.remove		= ican3_remove,
 };
 
 module_platform_driver(ican3_driver);
diff --git a/drivers/net/can/m_can/m_can_platform.c b/drivers/net/can/m_can/m_can_platform.c
index 983ab80260dd..b832566efda0 100644
--- a/drivers/net/can/m_can/m_can_platform.c
+++ b/drivers/net/can/m_can/m_can_platform.c
@@ -231,7 +231,7 @@ static struct platform_driver m_can_plat_driver = {
 		.pm     = &m_can_pmops,
 	},
 	.probe = m_can_plat_probe,
-	.remove_new = m_can_plat_remove,
+	.remove = m_can_plat_remove,
 };
 
 module_platform_driver(m_can_plat_driver);
diff --git a/drivers/net/can/mscan/mpc5xxx_can.c b/drivers/net/can/mscan/mpc5xxx_can.c
index 5b3d69c3b6b6..0080c39ee182 100644
--- a/drivers/net/can/mscan/mpc5xxx_can.c
+++ b/drivers/net/can/mscan/mpc5xxx_can.c
@@ -435,7 +435,7 @@ static struct platform_driver mpc5xxx_can_driver = {
 		.of_match_table = mpc5xxx_can_table,
 	},
 	.probe = mpc5xxx_can_probe,
-	.remove_new = mpc5xxx_can_remove,
+	.remove = mpc5xxx_can_remove,
 #ifdef CONFIG_PM
 	.suspend = mpc5xxx_can_suspend,
 	.resume = mpc5xxx_can_resume,
diff --git a/drivers/net/can/rcar/rcar_can.c b/drivers/net/can/rcar/rcar_can.c
index f5aa5dbacaf2..2b7dd359f27b 100644
--- a/drivers/net/can/rcar/rcar_can.c
+++ b/drivers/net/can/rcar/rcar_can.c
@@ -907,7 +907,7 @@ static struct platform_driver rcar_can_driver = {
 		.pm = &rcar_can_pm_ops,
 	},
 	.probe = rcar_can_probe,
-	.remove_new = rcar_can_remove,
+	.remove = rcar_can_remove,
 };
 
 module_platform_driver(rcar_can_driver);
diff --git a/drivers/net/can/rcar/rcar_canfd.c b/drivers/net/can/rcar/rcar_canfd.c
index c919668bbe7a..df1a5d0b37b2 100644
--- a/drivers/net/can/rcar/rcar_canfd.c
+++ b/drivers/net/can/rcar/rcar_canfd.c
@@ -2118,7 +2118,7 @@ static struct platform_driver rcar_canfd_driver = {
 		.pm = &rcar_canfd_pm_ops,
 	},
 	.probe = rcar_canfd_probe,
-	.remove_new = rcar_canfd_remove,
+	.remove = rcar_canfd_remove,
 };
 
 module_platform_driver(rcar_canfd_driver);
diff --git a/drivers/net/can/sja1000/sja1000_isa.c b/drivers/net/can/sja1000/sja1000_isa.c
index fca5a9a1d857..2d1f715459d7 100644
--- a/drivers/net/can/sja1000/sja1000_isa.c
+++ b/drivers/net/can/sja1000/sja1000_isa.c
@@ -245,7 +245,7 @@ static void sja1000_isa_remove(struct platform_device *pdev)
 
 static struct platform_driver sja1000_isa_driver = {
 	.probe = sja1000_isa_probe,
-	.remove_new = sja1000_isa_remove,
+	.remove = sja1000_isa_remove,
 	.driver = {
 		.name = DRV_NAME,
 	},
diff --git a/drivers/net/can/sja1000/sja1000_platform.c b/drivers/net/can/sja1000/sja1000_platform.c
index 33f0e46ab1c2..c42ebe9da55a 100644
--- a/drivers/net/can/sja1000/sja1000_platform.c
+++ b/drivers/net/can/sja1000/sja1000_platform.c
@@ -329,7 +329,7 @@ static void sp_remove(struct platform_device *pdev)
 
 static struct platform_driver sp_driver = {
 	.probe = sp_probe,
-	.remove_new = sp_remove,
+	.remove = sp_remove,
 	.driver = {
 		.name = DRV_NAME,
 		.of_match_table = sp_of_table,
diff --git a/drivers/net/can/softing/softing_main.c b/drivers/net/can/softing/softing_main.c
index bd25137062c5..278ee8722770 100644
--- a/drivers/net/can/softing/softing_main.c
+++ b/drivers/net/can/softing/softing_main.c
@@ -854,7 +854,7 @@ static struct platform_driver softing_driver = {
 		.name = KBUILD_MODNAME,
 	},
 	.probe = softing_pdev_probe,
-	.remove_new = softing_pdev_remove,
+	.remove = softing_pdev_remove,
 };
 
 module_platform_driver(softing_driver);
diff --git a/drivers/net/can/sun4i_can.c b/drivers/net/can/sun4i_can.c
index ab8d01784686..360158c295d3 100644
--- a/drivers/net/can/sun4i_can.c
+++ b/drivers/net/can/sun4i_can.c
@@ -914,7 +914,7 @@ static struct platform_driver sun4i_can_driver = {
 		.of_match_table = sun4ican_of_match,
 	},
 	.probe = sun4ican_probe,
-	.remove_new = sun4ican_remove,
+	.remove = sun4ican_remove,
 };
 
 module_platform_driver(sun4i_can_driver);
diff --git a/drivers/net/can/ti_hecc.c b/drivers/net/can/ti_hecc.c
index 5aab440074c6..644e8b8eb91e 100644
--- a/drivers/net/can/ti_hecc.c
+++ b/drivers/net/can/ti_hecc.c
@@ -1025,7 +1025,7 @@ static struct platform_driver ti_hecc_driver = {
 		.of_match_table = ti_hecc_dt_ids,
 	},
 	.probe = ti_hecc_probe,
-	.remove_new = ti_hecc_remove,
+	.remove = ti_hecc_remove,
 	.suspend = ti_hecc_suspend,
 	.resume = ti_hecc_resume,
 };
diff --git a/drivers/net/can/xilinx_can.c b/drivers/net/can/xilinx_can.c
index d944911d7f05..436c0e4b0344 100644
--- a/drivers/net/can/xilinx_can.c
+++ b/drivers/net/can/xilinx_can.c
@@ -2103,7 +2103,7 @@ static void xcan_remove(struct platform_device *pdev)
 
 static struct platform_driver xcan_driver = {
 	.probe = xcan_probe,
-	.remove_new = xcan_remove,
+	.remove = xcan_remove,
 	.driver	= {
 		.name = DRIVER_NAME,
 		.pm = &xcan_dev_pm_ops,

base-commit: f3b6129b7d252b2fbdcac2e0005abc6804dc287c
-- 
2.45.2



