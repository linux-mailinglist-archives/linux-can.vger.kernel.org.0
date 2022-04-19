Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E6815065DC
	for <lists+linux-can@lfdr.de>; Tue, 19 Apr 2022 09:29:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241889AbiDSHax (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Tue, 19 Apr 2022 03:30:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238899AbiDSHav (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 19 Apr 2022 03:30:51 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9472A2E6B7
        for <linux-can@vger.kernel.org>; Tue, 19 Apr 2022 00:28:09 -0700 (PDT)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1ngiHQ-0004uq-45
        for linux-can@vger.kernel.org; Tue, 19 Apr 2022 09:28:08 +0200
Received: from dspam.blackshift.org (localhost [127.0.0.1])
        by bjornoya.blackshift.org (Postfix) with SMTP id 05E4765BB1
        for <linux-can@vger.kernel.org>; Tue, 19 Apr 2022 07:28:07 +0000 (UTC)
Received: from hardanger.blackshift.org (unknown [172.20.34.65])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by bjornoya.blackshift.org (Postfix) with ESMTPS id CD8AA65BA6;
        Tue, 19 Apr 2022 07:28:06 +0000 (UTC)
Received: from blackshift.org (localhost [::1])
        by hardanger.blackshift.org (OpenSMTPD) with ESMTP id 975cceb9;
        Tue, 19 Apr 2022 07:28:06 +0000 (UTC)
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     linux-can@vger.kernel.org
Cc:     Manivannan Sadhasivam <mani@kernel.org>, kernel@pengutronix.de,
        Marc Kleine-Budde <mkl@pengutronix.de>,
        devicetree@vger.kernel.org, Thomas Kopp <thomas.kopp@microchip.com>
Subject: [PATCH 1/2] dt-binding: can: mcp251xfd: add binding information for mcp251863
Date:   Tue, 19 Apr 2022 09:28:04 +0200
Message-Id: <20220419072805.2840340-2-mkl@pengutronix.de>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220419072805.2840340-1-mkl@pengutronix.de>
References: <20220419072805.2840340-1-mkl@pengutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2001:67c:670:201:5054:ff:fe8d:eefb
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

The MCP251863 device is a CAN-FD controller (MCP2518FD) with an
integrated Transceiver (ATA6563). Add the microchip,mcp251863 as a new
compatible to the binding.

Cc: devicetree@vger.kernel.org
Cc: Thomas Kopp <thomas.kopp@microchip.com>
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 .../bindings/net/can/microchip,mcp251xfd.yaml | 19 ++++++++++---------
 1 file changed, 10 insertions(+), 9 deletions(-)

diff --git a/Documentation/devicetree/bindings/net/can/microchip,mcp251xfd.yaml b/Documentation/devicetree/bindings/net/can/microchip,mcp251xfd.yaml
index b3826af6bd6e..7a73057707b4 100644
--- a/Documentation/devicetree/bindings/net/can/microchip,mcp251xfd.yaml
+++ b/Documentation/devicetree/bindings/net/can/microchip,mcp251xfd.yaml
@@ -5,8 +5,8 @@ $id: http://devicetree.org/schemas/net/can/microchip,mcp251xfd.yaml#
 $schema: http://devicetree.org/meta-schemas/core.yaml#
 
 title:
-  Microchip MCP2517FD and MCP2518FD stand-alone CAN controller device tree
-  bindings
+  Microchip MCP2517FD, MCP2518FD and MCP251863 stand-alone CAN
+  controller device tree bindings
 
 maintainers:
   - Marc Kleine-Budde <mkl@pengutronix.de>
@@ -17,13 +17,14 @@ allOf:
 properties:
   compatible:
     oneOf:
-      - const: microchip,mcp2517fd
-        description: for MCP2517FD
-      - const: microchip,mcp2518fd
-        description: for MCP2518FD
-      - const: microchip,mcp251xfd
-        description: to autodetect chip variant
-
+      - enum:
+          - microchip,mcp2517fd
+          - microchip,mcp2518fd
+          - microchip,mcp251xfd
+      - items:
+          - enum:
+              - microchip,mcp251863
+          - const: microchip,mcp2518fd
   reg:
     maxItems: 1
 
-- 
2.35.1


