Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C57D7703ECA
	for <lists+linux-can@lfdr.de>; Mon, 15 May 2023 22:47:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245345AbjEOUrg (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Mon, 15 May 2023 16:47:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245339AbjEOUrd (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Mon, 15 May 2023 16:47:33 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87CD98694
        for <linux-can@vger.kernel.org>; Mon, 15 May 2023 13:47:32 -0700 (PDT)
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1pyf6Q-0004ny-J2
        for linux-can@vger.kernel.org; Mon, 15 May 2023 22:47:30 +0200
Received: from dspam.blackshift.org (localhost [127.0.0.1])
        by bjornoya.blackshift.org (Postfix) with SMTP id C42FB1C5C46
        for <linux-can@vger.kernel.org>; Mon, 15 May 2023 20:47:27 +0000 (UTC)
Received: from hardanger.blackshift.org (unknown [172.20.34.65])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by bjornoya.blackshift.org (Postfix) with ESMTPS id 5FD611C5C0B;
        Mon, 15 May 2023 20:47:25 +0000 (UTC)
Received: from blackshift.org (localhost [::1])
        by hardanger.blackshift.org (OpenSMTPD) with ESMTP id 4473973c;
        Mon, 15 May 2023 20:47:24 +0000 (UTC)
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     netdev@vger.kernel.org
Cc:     davem@davemloft.net, kuba@kernel.org, linux-can@vger.kernel.org,
        kernel@pengutronix.de,
        Dario Binacchi <dario.binacchi@amarulasolutions.com>,
        Rob Herring <robh@kernel.org>,
        Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH net 5/9] dt-bindings: net: can: add "st,can-secondary" property
Date:   Mon, 15 May 2023 22:47:18 +0200
Message-Id: <20230515204722.1000957-6-mkl@pengutronix.de>
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

From: Dario Binacchi <dario.binacchi@amarulasolutions.com>

On the stm32f7 Socs the can peripheral can be in single or dual
configuration. In the dual configuration, in turn, it can be in primary
or secondary mode. The addition of the 'st,can-secondary' property allows
you to specify this mode in the dual configuration.

CAN peripheral nodes in single configuration contain neither
"st,can-primary" nor "st,can-secondary".

Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>
Reviewed-by: Rob Herring <robh@kernel.org>
Link: https://lore.kernel.org/all/20230427204540.3126234-2-dario.binacchi@amarulasolutions.com
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 .../bindings/net/can/st,stm32-bxcan.yaml      | 19 +++++++++++++++----
 1 file changed, 15 insertions(+), 4 deletions(-)

diff --git a/Documentation/devicetree/bindings/net/can/st,stm32-bxcan.yaml b/Documentation/devicetree/bindings/net/can/st,stm32-bxcan.yaml
index 769fa5c27b76..de1d4298893b 100644
--- a/Documentation/devicetree/bindings/net/can/st,stm32-bxcan.yaml
+++ b/Documentation/devicetree/bindings/net/can/st,stm32-bxcan.yaml
@@ -21,11 +21,22 @@ properties:
 
   st,can-primary:
     description:
-      Primary and secondary mode of the bxCAN peripheral is only relevant
-      if the chip has two CAN peripherals. In that case they share some
-      of the required logic.
+      Primary mode of the bxCAN peripheral is only relevant if the chip has
+      two CAN peripherals in dual CAN configuration. In that case they share
+      some of the required logic.
+      Not to be used if the peripheral is in single CAN configuration.
       To avoid misunderstandings, it should be noted that ST documentation
-      uses the terms master/slave instead of primary/secondary.
+      uses the terms master instead of primary.
+    type: boolean
+
+  st,can-secondary:
+    description:
+      Secondary mode of the bxCAN peripheral is only relevant if the chip
+      has two CAN peripherals in dual CAN configuration. In that case they
+      share some of the required logic.
+      Not to be used if the peripheral is in single CAN configuration.
+      To avoid misunderstandings, it should be noted that ST documentation
+      uses the terms slave instead of secondary.
     type: boolean
 
   reg:
-- 
2.39.2


