Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B12C0270334
	for <lists+linux-can@lfdr.de>; Fri, 18 Sep 2020 19:25:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726168AbgIRRZn (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Fri, 18 Sep 2020 13:25:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726187AbgIRRZm (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Fri, 18 Sep 2020 13:25:42 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 913DBC0613D3
        for <linux-can@vger.kernel.org>; Fri, 18 Sep 2020 10:25:42 -0700 (PDT)
Received: from heimdall.vpn.pengutronix.de ([2001:67c:670:205:1d::14] helo=blackshift.org)
        by metis.ext.pengutronix.de with esmtp (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1kJK8i-0006bc-P9; Fri, 18 Sep 2020 19:25:40 +0200
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     linux-can@vger.kernel.org
Cc:     manivannan.sadhasivam@linaro.org, dev.kurt@vandijck-laurijssen.be,
        Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH v53 5/6] MAINTAINERS: Add entry for Microchip MCP25XXFD SPI-CAN network driver
Date:   Fri, 18 Sep 2020 19:25:35 +0200
Message-Id: <20200918172536.2074504-6-mkl@pengutronix.de>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200918172536.2074504-1-mkl@pengutronix.de>
References: <20200918172536.2074504-1-mkl@pengutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2001:67c:670:205:1d::14
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

Add MAINTAINERS entry for Microchip MCP25XXFD SPI-CAN network driver.

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Link: https://lore.kernel.org/r/20200910133806.25077-7-manivannan.sadhasivam@linaro.org
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 MAINTAINERS | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index c99577961cc4..fcb63f0c9635 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -10671,6 +10671,14 @@ L:	linux-input@vger.kernel.org
 S:	Maintained
 F:	drivers/hid/hid-mcp2221.c
 
+MCP25XXFD SPI-CAN NETWORK DRIVER
+M:	Marc Kleine-Budde <mkl@pengutronix.de>
+M:	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
+L:	linux-can@vger.kernel.org
+S:	Maintained
+F:	Documentation/devicetree/bindings/net/can/microchip,mcp25xxfd.yaml
+F:	drivers/net/can/spi/mcp25xxfd/
+
 MCP4018 AND MCP4531 MICROCHIP DIGITAL POTENTIOMETER DRIVERS
 M:	Peter Rosin <peda@axentia.se>
 L:	linux-iio@vger.kernel.org
-- 
2.28.0

