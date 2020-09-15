Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA85126B1C9
	for <lists+linux-can@lfdr.de>; Wed, 16 Sep 2020 00:36:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727707AbgIOWgQ (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Tue, 15 Sep 2020 18:36:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727701AbgIOWfw (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 15 Sep 2020 18:35:52 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 888D0C061225
        for <linux-can@vger.kernel.org>; Tue, 15 Sep 2020 15:35:40 -0700 (PDT)
Received: from heimdall.vpn.pengutronix.de ([2001:67c:670:205:1d::14] helo=blackshift.org)
        by metis.ext.pengutronix.de with esmtp (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1kIJY2-0002Tb-K7; Wed, 16 Sep 2020 00:35:38 +0200
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     linux-can@vger.kernel.org
Cc:     kernel@pengutronix.de, Marc Kleine-Budde <mkl@pengutronix.de>,
        =?UTF-8?q?Timo=20Schl=C3=BC=C3=9Fler?= <schluessler@krause.de>
Subject: [PATCH 25/37] dt-bindings: can: mcp251x: document GPIO support
Date:   Wed, 16 Sep 2020 00:35:15 +0200
Message-Id: <20200915223527.1417033-26-mkl@pengutronix.de>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200915223527.1417033-1-mkl@pengutronix.de>
References: <20200915223527.1417033-1-mkl@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2001:67c:670:205:1d::14
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org
Sender: linux-can-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

The next patch adds gpio controller support to the mcp251x driver. This
patch updates the binding accordingly.

Cc: Timo Schlüßler <schluessler@krause.de>
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 .../devicetree/bindings/net/can/microchip,mcp251x.txt        | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/devicetree/bindings/net/can/microchip,mcp251x.txt b/Documentation/devicetree/bindings/net/can/microchip,mcp251x.txt
index e689506ac38d..381f8fb3e865 100644
--- a/Documentation/devicetree/bindings/net/can/microchip,mcp251x.txt
+++ b/Documentation/devicetree/bindings/net/can/microchip,mcp251x.txt
@@ -12,6 +12,9 @@ Required properties:
 Optional properties:
  - vdd-supply: Regulator that powers the CAN controller.
  - xceiver-supply: Regulator that powers the CAN transceiver.
+ - gpio-controller: Indicates this device is a GPIO controller.
+ - #gpio-cells: Should be two. The first cell is the pin number and
+                the second cell is used to specify the gpio polarity.
 
 Example:
 	can0: can@1 {
@@ -22,4 +25,6 @@ Example:
 		interrupts = <13 IRQ_TYPE_LEVEL_LOW>;
 		vdd-supply = <&reg5v0>;
 		xceiver-supply = <&reg5v0>;
+		gpio-controller;
+		#gpio-cells = <2>;
 	};
-- 
2.28.0

