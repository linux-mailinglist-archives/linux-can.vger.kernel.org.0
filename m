Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A2954292AA5
	for <lists+linux-can@lfdr.de>; Mon, 19 Oct 2020 17:42:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730354AbgJSPmm (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Mon, 19 Oct 2020 11:42:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729075AbgJSPml (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Mon, 19 Oct 2020 11:42:41 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61521C0613CE
        for <linux-can@vger.kernel.org>; Mon, 19 Oct 2020 08:42:41 -0700 (PDT)
Received: from heimdall.vpn.pengutronix.de ([2001:67c:670:205:1d::14] helo=blackshift.org)
        by metis.ext.pengutronix.de with esmtp (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1kUXJ1-0000nY-Ev; Mon, 19 Oct 2020 17:42:39 +0200
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     linux-can@vger.kernel.org
Cc:     kernel@pengutronix.de, Dan Murphy <dmurphy@ti.com>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [net-rfc 03/12] can: tcan4x5x: replace depends on REGMAP_SPI with depends on SPI
Date:   Mon, 19 Oct 2020 17:42:24 +0200
Message-Id: <20201019154233.1262589-4-mkl@pengutronix.de>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201019154233.1262589-1-mkl@pengutronix.de>
References: <20201019154233.1262589-1-mkl@pengutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2001:67c:670:205:1d::14
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

From: Enric Balletbo i Serra <enric.balletbo@collabora.com>

regmap is a library function that gets selected by drivers that need it. No
driver modules should depend on it. Instead depends on SPI and select
REGMAP_SPI. Depending on REGMAP_SPI makes this driver only build if another
driver already selected REGMAP_SPI, as the symbol can't be selected through the
menu kernel configuration.

Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
Link: http://lore.kernel.org/r/20200413141013.506613-1-enric.balletbo@collabora.com
Reviewed-by: Dan Murphy <dmurphy@ti.com>
Fixes: 5443c226ba91 ("can: tcan4x5x: Add tcan4x5x driver to the kernel")
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/m_can/Kconfig | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/can/m_can/Kconfig b/drivers/net/can/m_can/Kconfig
index 48be627c85c2..5f9f8192dd0b 100644
--- a/drivers/net/can/m_can/Kconfig
+++ b/drivers/net/can/m_can/Kconfig
@@ -16,7 +16,8 @@ config CAN_M_CAN_PLATFORM
 
 config CAN_M_CAN_TCAN4X5X
 	depends on CAN_M_CAN
-	depends on REGMAP_SPI
+	depends on SPI
+	select REGMAP_SPI
 	tristate "TCAN4X5X M_CAN device"
 	help
 	  Say Y here if you want support for Texas Instruments TCAN4x5x
-- 
2.28.0

