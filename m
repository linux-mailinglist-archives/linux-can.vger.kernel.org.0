Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 23CB94CC98E
	for <lists+linux-can@lfdr.de>; Fri,  4 Mar 2022 00:00:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231184AbiCCXAv (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Thu, 3 Mar 2022 18:00:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229947AbiCCXAu (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Thu, 3 Mar 2022 18:00:50 -0500
X-Greylist: delayed 170 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 03 Mar 2022 15:00:03 PST
Received: from smtp-out3.electric.net (smtp-out3.electric.net [208.70.128.181])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3B512A734;
        Thu,  3 Mar 2022 15:00:03 -0800 (PST)
Received: from 1nPuNg-0006DD-W9 by out3b.electric.net with emc1-ok (Exim 4.94.2)
        (envelope-from <kris@embeddedTS.com>)
        id 1nPuNi-0006M2-Vk; Thu, 03 Mar 2022 14:57:10 -0800
Received: by emcmailer; Thu, 03 Mar 2022 14:57:10 -0800
Received: from [66.210.251.27] (helo=mail.embeddedts.com)
        by out3b.electric.net with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <kris@embeddedTS.com>)
        id 1nPuNg-0006DD-W9; Thu, 03 Mar 2022 14:57:09 -0800
Received: from tsdebian.Massive (unknown [75.164.75.221])
        by mail.embeddedts.com (Postfix) with ESMTPSA id 28C7038F6C;
        Thu,  3 Mar 2022 15:57:08 -0700 (MST)
From:   Kris Bahnsen <kris@embeddedTS.com>
To:     linus.walleij@linaro.org, brgl@bgdev.pl, wg@grandegger.com,
        mkl@pengutronix.de, linux-gpio@vger.kernel.org,
        linux-can@vger.kernel.org
Cc:     Kris Bahnsen <kris@embeddedTS.com>
Subject: [PATCH] drivers: Fix Links to Technologic Systems web resources
Date:   Thu,  3 Mar 2022 14:55:25 -0800
Message-Id: <20220303225525.29846-1-kris@embeddedTS.com>
X-Mailer: git-send-email 2.11.0
X-Outbound-IP: 66.210.251.27
X-Env-From: kris@embeddedTS.com
X-Proto: esmtps
X-Revdns: wsip-66-210-251-27.ph.ph.cox.net
X-HELO: mail.embeddedts.com
X-TLS:  TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256
X-Authenticated_ID: 
X-Virus-Status: Scanned by VirusSMART (c)
X-Virus-Status: Scanned by VirusSMART (b)
X-FM-Delivery-Delay: 15749372,23518412
X-PolicySMART: 13164782, 15749372, 26810492
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=embeddedTS.com; s=mailanyone20220121;h=Message-Id:Date:To:From; bh=M0CaPYNbuqqPBKUGMAOYIjz9RulZ3sYoiLMPvbPJyeA=;b=MIH1PKHt993iEs6xkHWBy8zHe1RlleZdE2iFD+3jAb8S10Kvk8htr3xsm2ICl2EiRAV1tAj4Uf+kUL4aHL1O9ufo9hnG6rtZYnnOHyg7IIOLAP2B8vXAJnyXugb2zXO1ryrB0RPExJtuQMSP5wSlq9kwFr5hW5IR9SFubwdVTdR1C2GVVrn8OQBA9xcHYUONZYoqATxTwSaLeG8OSpB6fPaOFbAibHHkyGt19f9NKb8y5wxB9K3VM1hYZOfElP5xSqAKJ0Frp+P8qxx3eQ3lVEDS8u9JOWW6GVHZ9EctfhJL+wMBorZL8LfuV8I5Sr0t/FGlN8tuqjaNQqaRjtiuog==;
X-FM-Delivery-Delay: 15749372,23518412
X-PolicySMART: 13164782, 15749372, 26810492
X-FM-Delivery-Delay: 15749372,23518412
X-PolicySMART: 13164782, 15749372, 26810492
X-FM-Delivery-Delay: 15749372,23518412
X-PolicySMART: 13164782, 15749372, 26810492
X-FM-Delivery-Delay: 15749372,23518412
X-PolicySMART: 13164782, 15749372, 26810492
X-FM-Delivery-Delay: 15749372,23518412
X-PolicySMART: 13164782, 15749372, 26810492
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Technologic Systems has rebranded as embeddedTS with the current
domain eventually going offline. Update web/doc URLs to correct
resource locations.

Signed-off-by: Kris Bahnsen <kris@embeddedTS.com>
---
 drivers/gpio/gpio-ts5500.c       | 4 ++--
 drivers/net/can/sja1000/Kconfig  | 2 +-
 drivers/net/can/sja1000/tscan1.c | 4 ++--
 3 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/gpio/gpio-ts5500.c b/drivers/gpio/gpio-ts5500.c
index b159e92a3612..8e03614c7a24 100644
--- a/drivers/gpio/gpio-ts5500.c
+++ b/drivers/gpio/gpio-ts5500.c
@@ -11,11 +11,11 @@
  * Actually, the following platforms have DIO support:
  *
  * TS-5500:
- *   Documentation: http://wiki.embeddedarm.com/wiki/TS-5500
+ *   Documentation: https://docs.embeddedts.com/TS-5500
  *   Blocks: DIO1, DIO2 and LCD port.
  *
  * TS-5600:
- *   Documentation: http://wiki.embeddedarm.com/wiki/TS-5600
+ *   Documentation: https://docs.embeddedts.com/TS-5600
  *   Blocks: LCD port (identical to TS-5500 LCD).
  */
 
diff --git a/drivers/net/can/sja1000/Kconfig b/drivers/net/can/sja1000/Kconfig
index 110071b26921..4b2f9cb17fc3 100644
--- a/drivers/net/can/sja1000/Kconfig
+++ b/drivers/net/can/sja1000/Kconfig
@@ -107,7 +107,7 @@ config CAN_TSCAN1
 	depends on ISA
 	help
 	  This driver is for Technologic Systems' TSCAN-1 PC104 boards.
-	  http://www.embeddedarm.com/products/board-detail.php?product=TS-CAN1
+	  https://www.embeddedts.com/products/TS-CAN1
 	  The driver supports multiple boards and automatically configures them:
 	  PLD IO base addresses are read from jumpers JP1 and JP2,
 	  IRQ numbers are read from jumpers JP4 and JP5,
diff --git a/drivers/net/can/sja1000/tscan1.c b/drivers/net/can/sja1000/tscan1.c
index 3dbba8d61afb..749002f21e27 100644
--- a/drivers/net/can/sja1000/tscan1.c
+++ b/drivers/net/can/sja1000/tscan1.c
@@ -7,8 +7,8 @@
 
 /*
  * References:
- * - Getting started with TS-CAN1, Technologic Systems, Jun 2009
- *	http://www.embeddedarm.com/documentation/ts-can1-manual.pdf
+ * - Getting started with TS-CAN1, Technologic Systems, Feb 2022
+ *	https://docs.embeddedts.com/TS-CAN1
  */
 
 #include <linux/init.h>
-- 
2.11.0

