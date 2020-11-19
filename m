Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 588132B8C6A
	for <lists+linux-can@lfdr.de>; Thu, 19 Nov 2020 08:35:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725877AbgKSHeB (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Thu, 19 Nov 2020 02:34:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725873AbgKSHeA (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Thu, 19 Nov 2020 02:34:00 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80274C0613CF
        for <linux-can@vger.kernel.org>; Wed, 18 Nov 2020 23:34:00 -0800 (PST)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=blackshift.org)
        by metis.ext.pengutronix.de with esmtp (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1kfeS6-0003uy-HJ; Thu, 19 Nov 2020 08:33:58 +0100
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     linux-can@vger.kernel.org
Cc:     Joakim Zhang <qiangqing.zhang@nxp.com>, kernel@pengutronix.de,
        Marc Kleine-Budde <mkl@pengutronix.de>,
        Oleksij Rempel <ore@pengutronix.de>
Subject: [PATCH] dt-bindings: can: fsl,flexcan: add uint32 reference to clock-frequency property
Date:   Thu, 19 Nov 2020 08:33:57 +0100
Message-Id: <20201119073357.2858925-1-mkl@pengutronix.de>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2001:67c:670:201:5054:ff:fe8d:eefb
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

This patch adds the missing reference to the clock-frequency property. The
driver uses a of_property_read_u32() to read the property to mark it as uint32.

Fixes: e5ab9aa7e49b ("dt-bindings: can: flexcan: convert fsl,*flexcan bindings to yaml")
Cc: Joakim Zhang <qiangqing.zhang@nxp.com>
Cc: Oleksij Rempel <ore@pengutronix.de>
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 Documentation/devicetree/bindings/net/can/fsl,flexcan.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/net/can/fsl,flexcan.yaml b/Documentation/devicetree/bindings/net/can/fsl,flexcan.yaml
index 43df15ba8fa4..53d9396f1f7f 100644
--- a/Documentation/devicetree/bindings/net/can/fsl,flexcan.yaml
+++ b/Documentation/devicetree/bindings/net/can/fsl,flexcan.yaml
@@ -54,6 +54,7 @@ properties:
       - const: per
 
   clock-frequency:
+    $ref: /schemas/types.yaml#/definitions/uint32
     description: |
       The oscillator frequency driving the flexcan device, filled in by the
       boot loader. This property should only be used the used operating system
-- 
2.29.2

