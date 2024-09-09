Return-Path: <linux-can+bounces-1439-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 425C3970FD1
	for <lists+linux-can@lfdr.de>; Mon,  9 Sep 2024 09:30:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B69461F2120B
	for <lists+linux-can@lfdr.de>; Mon,  9 Sep 2024 07:30:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B35B61AF4E3;
	Mon,  9 Sep 2024 07:28:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="TvoXA7RV"
X-Original-To: linux-can@vger.kernel.org
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 697B82AD00
	for <linux-can@vger.kernel.org>; Mon,  9 Sep 2024 07:28:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725866890; cv=none; b=EnXCIRV10lH5nzDLvl5hLWiMcvhi5X6wbzmWR0p07dFwVbZXqZWm5wI0KnSYsevw33GywKlr/9i88Qvs1lEwAh4dolGTTUmkvUVAmZST/mergyPKEOEaY9cTsvT6PtA0NufVE/AP8WAfVR0DDLNIJUAkTFNSnsVHDHwTjzfDLb4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725866890; c=relaxed/simple;
	bh=5vW/9fU2Wb9l71VyYleN0tc4OC2LdkbXzD4rexvwR3M=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=gBy1RKYJxAwoaACI79pWKMPav+0fB+nhEW2zGh8W8NcNAYGK1lTdu0xR7GyQDjv1ysEKOKs9U3pFMfsj8g0BbiPsMlfSSaVNJGjcq0BZgjkQKoCyXAy4pcA2olekYE06jUqfz+2pJHh5O10TUSJij8DJduTRNWobqdHFYZg/nI8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=TvoXA7RV; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-374c180d123so2184290f8f.3
        for <linux-can@vger.kernel.org>; Mon, 09 Sep 2024 00:28:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1725866884; x=1726471684; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=aioH+Jqlpgz93H+NQQS2WSnNxr1TKSdja0YdEIYgX7Q=;
        b=TvoXA7RV4jncdlHWyxTnu1ZRzQF59moBR10LQyDA7v2UgOsppZkZFMfNFE/bRVD++j
         PswrfQckmNFrhGeizH27MSstJ+KwqfkyrNV5jo2m6sh0ak3qEVnP+F4gqVHJx+RHhE0b
         hN8mqvC6TqmhIQQld3jCJ1Y/xlzC5rplFWe4uWOte2GuAgc/K5Vj+A/zZQApBmJ0AFIP
         3RSJJutIUR6oPgkZ/b5nD4lrKYgtB14Nk4lnJkhQORBrGbNsxdoB4YbYjwwdbUMt9wRX
         SJW6wmmLUaOiXTfsipUFClXWTzK1A2yhU67nczC+zC6kWJeMO9bQ7bLB40ReF5snw3u5
         wcXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725866884; x=1726471684;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aioH+Jqlpgz93H+NQQS2WSnNxr1TKSdja0YdEIYgX7Q=;
        b=MzASrtqB48sVZKAn0CJQk7tgLXjqI6SURJVpCiJQrBXexbiiDRAz5Kg7xzPf7loN09
         miFCha3sXSS8hpRZ7VEUM2tKBe5nkjHsVCuSidA8GYxVDqYNsymNteckNb5r2GaVZYQj
         vStD81jVDPbXpb+YIxfwXU8sQMh040YhbGUqa4X80+9BTap/lH1C19qNalB27yIJoP+9
         sXT2EiRnPB2m6h79SryPzdpnUPDh9rghS1qLnvNerbRGOkIwa4OkByXrZcgopqQs56j+
         GVj9XxOvq7K4F0+h9LKM010HBFUOXRLTBDWgYIz+1ZX9Wxx9JjGA5FLwOdtyNmiLQwy6
         hk3g==
X-Forwarded-Encrypted: i=1; AJvYcCUgxX0y0Xuc1HIBBvy4raUhhpbrsasau7yzOF9EmOo8xPG7I3tDuJHJl6r4FpBcmv8SsX5AM1zg9ak=@vger.kernel.org
X-Gm-Message-State: AOJu0YwD5WJbyrOlxbumvnx8EDH5PaqBxIil10VL11brFFR8Z770Ktcy
	7hrXd/bPaYYvKuhlJWMdPuahR2WMxcqLxs6YUj9snfHZvaK5WwxLcMJ20whti0U=
X-Google-Smtp-Source: AGHT+IFBMYjJw8Wa1q6p3qNj49FZrDEi32xqva4nrgSouGzRwzkvtpdmRMh+duGOwYKBbhn33r+Leg==
X-Received: by 2002:adf:f6c9:0:b0:374:c3f7:6af1 with SMTP id ffacd0b85a97d-378949f7897mr3888586f8f.15.1725866884386;
        Mon, 09 Sep 2024 00:28:04 -0700 (PDT)
Received: from localhost (p5dc68d3d.dip0.t-ipconnect.de. [93.198.141.61])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37895675b21sm5245926f8f.49.2024.09.09.00.28.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Sep 2024 00:28:03 -0700 (PDT)
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: Marc Kleine-Budde <mkl@pengutronix.de>,
	Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Cc: Nicolas Ferre <nicolas.ferre@microchip.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Claudiu Beznea <claudiu.beznea@tuxon.dev>,
	Dario Binacchi <dario.binacchi@amarulasolutions.com>,
	Pavel Pisa <pisa@cmp.felk.cvut.cz>,
	Ondrej Ille <ondrej.ille@gmail.com>,
	Chandrasekar Ramakrishnan <rcsekar@samsung.com>,
	Chen-Yu Tsai <wens@csie.org>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Samuel Holland <samuel@sholland.org>,
	Appana Durga Kedareswara rao <appana.durga.rao@xilinx.com>,
	Michal Simek <michal.simek@amd.com>,
	linux-can@vger.kernel.org
Subject: [PATCH] can: Switch back to struct platform_driver::remove()
Date: Mon,  9 Sep 2024 09:27:41 +0200
Message-ID: <20240909072742.381003-2-u.kleine-koenig@baylibre.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=11449; i=u.kleine-koenig@baylibre.com; h=from:subject; bh=5vW/9fU2Wb9l71VyYleN0tc4OC2LdkbXzD4rexvwR3M=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBm3qNuRolI4iep6YkZQoEsLPec5z9KY3wjgmQZ7 q8nXrOAdo2JATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZt6jbgAKCRCPgPtYfRL+ TlXOCACWlkCSKF5FipzwLGUnASA7dLXOFplYRHzDBcYtfkXAtqVS3b0DsQGhaJ7icYee8ojFrry +JvcVlQuO9rM56KsD4Mfmwx5Dqf3y4igLMimCmWmYaMZYdAcSLXCvIw4Ix4S33nfdVFe3lSeROp eO4TlRiOiSdhbehWCb6BS202sIwWPjhRIt5ghS6e8MfrsFPXAxsg3W1dMy6WQndi4c9zCdkuT2H JQGsAYmZ8CwcJxtlZQlHMxcsR5dOxBkOXbdnVpFoFNSYSM6a5UGz6Jl3lMU2y3qj824MmUnp/Lz nLLK37YvohYOA9akzFn6EJgm0hpe2g+rGLrnTgghp7eZINJk
X-Developer-Key: i=u.kleine-koenig@baylibre.com; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit

After commit 0edb555a65d1 ("platform: Make platform_driver::remove()
return void") .remove() is (again) the right callback to implement for
platform drivers.

Convert all can drivers to use .remove(), with the eventual goal to drop
struct platform_driver::remove_new(). As .remove() and .remove_new() have
the same prototypes, conversion is done by just changing the structure
member name in the driver initializer.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@baylibre.com>
---
Hello,

this is merge window material and should be applied to a tree that
includes 0edb555a65d1---so v6.11-rc1 is fine.

Best regards
Uwe

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
index 13bcfba05f18..49c6cec671fb 100644
--- a/drivers/net/can/cc770/cc770_platform.c
+++ b/drivers/net/can/cc770/cc770_platform.c
@@ -257,7 +257,7 @@ static struct platform_driver cc770_platform_driver = {
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

base-commit: 9aaeb87ce1e966169a57f53a02ba05b30880ffb8
-- 
2.45.2


