Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA2A7671A75
	for <lists+linux-can@lfdr.de>; Wed, 18 Jan 2023 12:24:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230037AbjARLYk (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Wed, 18 Jan 2023 06:24:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229683AbjARLY3 (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Wed, 18 Jan 2023 06:24:29 -0500
Received: from laurent.telenet-ops.be (laurent.telenet-ops.be [IPv6:2a02:1800:110:4::f00:19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74B4E4955E
        for <linux-can@vger.kernel.org>; Wed, 18 Jan 2023 02:39:36 -0800 (PST)
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed50:4745:2e6d:e3a6:3327])
        by laurent.telenet-ops.be with bizsmtp
        id AAfX2900C2zf9gW01AfXES; Wed, 18 Jan 2023 11:39:34 +0100
Received: from rox.of.borg ([192.168.97.57])
        by ramsan.of.borg with esmtp (Exim 4.95)
        (envelope-from <geert@linux-m68k.org>)
        id 1pI5qo-005aKJ-7Z;
        Wed, 18 Jan 2023 11:39:31 +0100
Received: from geert by rox.of.borg with local (Exim 4.95)
        (envelope-from <geert@linux-m68k.org>)
        id 1pI5qt-001Jt4-ID;
        Wed, 18 Jan 2023 11:39:31 +0100
From:   Geert Uytterhoeven <geert+renesas@glider.be>
To:     Wolfgang Grandegger <wg@grandegger.com>,
        Marc Kleine-Budde <mkl@pengutronix.de>,
        Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Aswath Govindraju <a-govindraju@ti.com>
Cc:     Wolfram Sang <wsa+renesas@sang-engineering.com>,
        linux-can@vger.kernel.org, linux-phy@lists.infradead.org,
        devicetree@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH 1/2] dt-bindings: phy: ti,tcan104x-can: Document NXP TJR1443
Date:   Wed, 18 Jan 2023 11:39:23 +0100
Message-Id: <6ee5e2ce00019bd3f77d6a702b38bab1a45f3bb0.1674037830.git.geert+renesas@glider.be>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1674037830.git.geert+renesas@glider.be>
References: <cover.1674037830.git.geert+renesas@glider.be>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

The NXP TJR1443 High-speed CAN transceiver with Sleep mode is a
pin-compatible alternative for the TI TCAN1043.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 Documentation/devicetree/bindings/phy/ti,tcan104x-can.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/phy/ti,tcan104x-can.yaml b/Documentation/devicetree/bindings/phy/ti,tcan104x-can.yaml
index 02b76f15e7170231..237295b2b5a86a21 100644
--- a/Documentation/devicetree/bindings/phy/ti,tcan104x-can.yaml
+++ b/Documentation/devicetree/bindings/phy/ti,tcan104x-can.yaml
@@ -15,6 +15,7 @@ properties:
 
   compatible:
     enum:
+      - nxp,tjr1443
       - ti,tcan1042
       - ti,tcan1043
 
-- 
2.34.1

