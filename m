Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7F8BF2BAB40
	for <lists+linux-can@lfdr.de>; Fri, 20 Nov 2020 14:34:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728210AbgKTNdc (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Fri, 20 Nov 2020 08:33:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728169AbgKTNdc (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Fri, 20 Nov 2020 08:33:32 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4954C0617A7
        for <linux-can@vger.kernel.org>; Fri, 20 Nov 2020 05:33:31 -0800 (PST)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=blackshift.org)
        by metis.ext.pengutronix.de with esmtp (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1kg6XW-0006Fn-NT; Fri, 20 Nov 2020 14:33:26 +0100
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     netdev@vger.kernel.org
Cc:     davem@davemloft.net, kuba@kernel.org, linux-can@vger.kernel.org,
        kernel@pengutronix.de, Marc Kleine-Budde <mkl@pengutronix.de>,
        Joakim Zhang <qiangqing.zhang@nxp.com>,
        Oleksij Rempel <ore@pengutronix.de>
Subject: [net-next 12/25] dt-bindings: can: fsl,flexcan: add uint32 reference to clock-frequency property
Date:   Fri, 20 Nov 2020 14:33:05 +0100
Message-Id: <20201120133318.3428231-13-mkl@pengutronix.de>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201120133318.3428231-1-mkl@pengutronix.de>
References: <20201120133318.3428231-1-mkl@pengutronix.de>
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
Link: https://lore.kernel.org/r/20201119073357.2858925-1-mkl@pengutronix.de
Cc: Joakim Zhang <qiangqing.zhang@nxp.com>
Cc: Oleksij Rempel <ore@pengutronix.de>
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 Documentation/devicetree/bindings/net/can/fsl,flexcan.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/net/can/fsl,flexcan.yaml b/Documentation/devicetree/bindings/net/can/fsl,flexcan.yaml
index 13875eab2ed6..0133d777e78e 100644
--- a/Documentation/devicetree/bindings/net/can/fsl,flexcan.yaml
+++ b/Documentation/devicetree/bindings/net/can/fsl,flexcan.yaml
@@ -57,6 +57,7 @@ properties:
       - const: per
 
   clock-frequency:
+    $ref: /schemas/types.yaml#/definitions/uint32
     description: |
       The oscillator frequency driving the flexcan device, filled in by the
       boot loader. This property should only be used the used operating system
-- 
2.29.2

