Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 157C14C2608
	for <lists+linux-can@lfdr.de>; Thu, 24 Feb 2022 09:30:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231879AbiBXIaR (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Thu, 24 Feb 2022 03:30:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232035AbiBXI3o (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Thu, 24 Feb 2022 03:29:44 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 591C62782B9
        for <linux-can@vger.kernel.org>; Thu, 24 Feb 2022 00:29:00 -0800 (PST)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1nN9Ug-0004ZK-LG
        for linux-can@vger.kernel.org; Thu, 24 Feb 2022 09:28:58 +0100
Received: from dspam.blackshift.org (localhost [127.0.0.1])
        by bjornoya.blackshift.org (Postfix) with SMTP id B134C3C1F9
        for <linux-can@vger.kernel.org>; Thu, 24 Feb 2022 08:27:28 +0000 (UTC)
Received: from hardanger.blackshift.org (unknown [172.20.34.65])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by bjornoya.blackshift.org (Postfix) with ESMTPS id 57C8C3C1CD;
        Thu, 24 Feb 2022 08:27:28 +0000 (UTC)
Received: from blackshift.org (localhost [::1])
        by hardanger.blackshift.org (OpenSMTPD) with ESMTP id 189d8b58;
        Thu, 24 Feb 2022 08:27:28 +0000 (UTC)
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     netdev@vger.kernel.org
Cc:     davem@davemloft.net, kuba@kernel.org, linux-can@vger.kernel.org,
        kernel@pengutronix.de, Marc Kleine-Budde <mkl@pengutronix.de>,
        Evgeny Boger <boger@wirenboard.com>,
        Gerhard Bertelsmann <info@gerhard-bertelsmann.de>,
        Rob Herring <robh@kernel.org>
Subject: [PATCH net-next 02/36] dt-binding: can: sun4i_can: include common CAN controller bindings
Date:   Thu, 24 Feb 2022 09:26:52 +0100
Message-Id: <20220224082726.3000007-3-mkl@pengutronix.de>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220224082726.3000007-1-mkl@pengutronix.de>
References: <20220224082726.3000007-1-mkl@pengutronix.de>
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

Since commit

| 1f9234401ce0 ("dt-bindings: can: add can-controller.yaml")

there is a common CAN controller binding. Add this to the sun4i_can
binding.

Link: https://lore.kernel.org/all/20220124220653.3477172-3-mkl@pengutronix.de
Cc: Evgeny Boger <boger@wirenboard.com>
Cc: Gerhard Bertelsmann <info@gerhard-bertelsmann.de>
Acked-by: Rob Herring <robh@kernel.org>
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 .../devicetree/bindings/net/can/allwinner,sun4i-a10-can.yaml   | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/net/can/allwinner,sun4i-a10-can.yaml b/Documentation/devicetree/bindings/net/can/allwinner,sun4i-a10-can.yaml
index c93fe9d3ea82..3c51b2d02957 100644
--- a/Documentation/devicetree/bindings/net/can/allwinner,sun4i-a10-can.yaml
+++ b/Documentation/devicetree/bindings/net/can/allwinner,sun4i-a10-can.yaml
@@ -10,6 +10,9 @@ maintainers:
   - Chen-Yu Tsai <wens@csie.org>
   - Maxime Ripard <mripard@kernel.org>
 
+allOf:
+  - $ref: can-controller.yaml#
+
 properties:
   compatible:
     oneOf:
-- 
2.34.1


