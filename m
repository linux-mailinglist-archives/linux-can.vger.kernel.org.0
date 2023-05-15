Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3FB38703EC7
	for <lists+linux-can@lfdr.de>; Mon, 15 May 2023 22:47:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245113AbjEOUre (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Mon, 15 May 2023 16:47:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245329AbjEOUrc (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Mon, 15 May 2023 16:47:32 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2C1693E8
        for <linux-can@vger.kernel.org>; Mon, 15 May 2023 13:47:30 -0700 (PDT)
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1pyf6P-0004l9-75
        for linux-can@vger.kernel.org; Mon, 15 May 2023 22:47:29 +0200
Received: from dspam.blackshift.org (localhost [127.0.0.1])
        by bjornoya.blackshift.org (Postfix) with SMTP id F2BF01C5C33
        for <linux-can@vger.kernel.org>; Mon, 15 May 2023 20:47:26 +0000 (UTC)
Received: from hardanger.blackshift.org (unknown [172.20.34.65])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by bjornoya.blackshift.org (Postfix) with ESMTPS id 4590A1C5C08;
        Mon, 15 May 2023 20:47:25 +0000 (UTC)
Received: from blackshift.org (localhost [::1])
        by hardanger.blackshift.org (OpenSMTPD) with ESMTP id 9749b57e;
        Mon, 15 May 2023 20:47:24 +0000 (UTC)
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     netdev@vger.kernel.org
Cc:     davem@davemloft.net, kuba@kernel.org, linux-can@vger.kernel.org,
        kernel@pengutronix.de,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Simon Horman <simon.horman@corigine.com>,
        Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH net 4/9] can: CAN_BXCAN should depend on ARCH_STM32
Date:   Mon, 15 May 2023 22:47:17 +0200
Message-Id: <20230515204722.1000957-5-mkl@pengutronix.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230515204722.1000957-1-mkl@pengutronix.de>
References: <20230515204722.1000957-1-mkl@pengutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:b01:1d::7b
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

From: Geert Uytterhoeven <geert+renesas@glider.be>

The STMicroelectronics STM32 basic extended CAN Controller (bxCAN) is
only present on STM32 SoCs.  Hence drop the "|| OF" part from its
dependency rule, to prevent asking the user about this driver when
configuring a kernel without STM32 SoC support.

Fixes: f00647d8127be4d3 ("can: bxcan: add support for ST bxCAN controller")
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Reviewed-by: Simon Horman <simon.horman@corigine.com>
Link: https://lore.kernel.org/all/40095112efd1b2214e4223109fd9f0c6d0158a2d.1680609318.git.geert+renesas@glider.be
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/can/Kconfig b/drivers/net/can/Kconfig
index 3ceccafd701b..b190007c01be 100644
--- a/drivers/net/can/Kconfig
+++ b/drivers/net/can/Kconfig
@@ -95,7 +95,7 @@ config CAN_AT91
 
 config CAN_BXCAN
 	tristate "STM32 Basic Extended CAN (bxCAN) devices"
-	depends on OF || ARCH_STM32 || COMPILE_TEST
+	depends on ARCH_STM32 || COMPILE_TEST
 	depends on HAS_IOMEM
 	select CAN_RX_OFFLOAD
 	help
-- 
2.39.2


