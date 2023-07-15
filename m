Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 79E9975486F
	for <lists+linux-can@lfdr.de>; Sat, 15 Jul 2023 13:33:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229861AbjGOLdS (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Sat, 15 Jul 2023 07:33:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229745AbjGOLdR (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Sat, 15 Jul 2023 07:33:17 -0400
X-Greylist: delayed 437 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sat, 15 Jul 2023 04:33:16 PDT
Received: from out-26.mta0.migadu.com (out-26.mta0.migadu.com [IPv6:2001:41d0:1004:224b::1a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C85F135A0
        for <linux-can@vger.kernel.org>; Sat, 15 Jul 2023 04:33:16 -0700 (PDT)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jookia.org; s=key1;
        t=1689420363;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=KPF7WuMTa88q4pM2B8RLcTtpmoYLpabME/stwQ3zxw8=;
        b=CvCizP0wHXr3KbIN7dwVKFLWFHr8fmROa12Yfr1EWNbQgkKHOpztrR7FjE4CeTV+/aMjRy
        ISxaiyC+x3gyUDjl5CZOg+hFuGwZWsM0Wp6e/SwF+FAjD9oMG8ylmXuaMhFce8Lj03Z1tC
        TsKtpPGzh7GQD62V6lwsGk5YQYlTaYUb5Az3KCbIKqe8Vs4TkduXgnHLahbaHoxP7s7pXT
        74cIjgqGlBJLNPkvbL3X2RHsaJv+ORM4P3mHt84LVmOnZbtdEHZmwminN3w0ARveEABhP9
        skBnDh0t8z3efwAIBt3PKpwNRRquQVJgTMCY4MKl0IgYhKsp8gyPEDP1zgz2mA==
From:   Jookia <contact@jookia.org>
To:     linux-sunxi@lists.linux.dev
Cc:     John Watts <contact@jookia.org>, devicetree@vger.kernel.org,
        linux-can@vger.kernel.org, linux-riscv@lists.infradead.org,
        Fabien Poussin <fabien.poussin@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Chen-Yu Tsai <wens@csie.org>
Subject: [PATCH 3/4] can: sun4i_can: Add send support for the Allwinner D1
Date:   Sat, 15 Jul 2023 21:25:21 +1000
Message-ID: <20230715112523.2533742-4-contact@jookia.org>
In-Reply-To: <20230715112523.2533742-1-contact@jookia.org>
References: <20230715112523.2533742-1-contact@jookia.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

From: John Watts <contact@jookia.org>

The controllers present in the D1 are extremely similar to the R40
and require the same reset quirks. This alone can support sending
packets. An extra quirk is needed to support receiving packets.

Signed-off-by: John Watts <contact@jookia.org>
---
 drivers/net/can/Kconfig     | 4 ++--
 drivers/net/can/sun4i_can.c | 9 ++++++++-
 2 files changed, 10 insertions(+), 3 deletions(-)

diff --git a/drivers/net/can/Kconfig b/drivers/net/can/Kconfig
index a5c5036dfb94..e626de33e735 100644
--- a/drivers/net/can/Kconfig
+++ b/drivers/net/can/Kconfig
@@ -185,10 +185,10 @@ config CAN_SLCAN
 
 config CAN_SUN4I
 	tristate "Allwinner A10 CAN controller"
-	depends on MACH_SUN4I || MACH_SUN7I || COMPILE_TEST
+	depends on MACH_SUN4I || MACH_SUN7I || RISCV || COMPILE_TEST
 	help
 	  Say Y here if you want to use CAN controller found on Allwinner
-	  A10/A20 SoCs.
+	  A10/A20/D1 SoCs.
 
 	  To compile this driver as a module, choose M here: the module will
 	  be called sun4i_can.
diff --git a/drivers/net/can/sun4i_can.c b/drivers/net/can/sun4i_can.c
index 0827830bbf28..06f2cf05aaf5 100644
--- a/drivers/net/can/sun4i_can.c
+++ b/drivers/net/can/sun4i_can.c
@@ -774,6 +774,10 @@ static const struct sun4ican_quirks sun4ican_quirks_r40 = {
 	.has_reset = true,
 };
 
+static const struct sun4ican_quirks sun4ican_quirks_d1 = {
+	.has_reset = true,
+};
+
 static const struct of_device_id sun4ican_of_match[] = {
 	{
 		.compatible = "allwinner,sun4i-a10-can",
@@ -784,6 +788,9 @@ static const struct of_device_id sun4ican_of_match[] = {
 	}, {
 		.compatible = "allwinner,sun8i-r40-can",
 		.data = &sun4ican_quirks_r40
+	}, {
+		.compatible = "allwinner,sun20i-d1-can",
+		.data = &sun4ican_quirks_d1
 	}, {
 		/* sentinel */
 	},
@@ -907,4 +914,4 @@ module_platform_driver(sun4i_can_driver);
 MODULE_AUTHOR("Peter Chen <xingkongcp@gmail.com>");
 MODULE_AUTHOR("Gerhard Bertelsmann <info@gerhard-bertelsmann.de>");
 MODULE_LICENSE("Dual BSD/GPL");
-MODULE_DESCRIPTION("CAN driver for Allwinner SoCs (A10/A20)");
+MODULE_DESCRIPTION("CAN driver for Allwinner SoCs (A10/A20/D1)");
-- 
2.41.0

