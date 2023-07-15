Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C98C75486D
	for <lists+linux-can@lfdr.de>; Sat, 15 Jul 2023 13:32:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229764AbjGOLci (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Sat, 15 Jul 2023 07:32:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229745AbjGOLch (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Sat, 15 Jul 2023 07:32:37 -0400
X-Greylist: delayed 409 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sat, 15 Jul 2023 04:32:31 PDT
Received: from out-32.mta1.migadu.com (out-32.mta1.migadu.com [95.215.58.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 038EB35A0
        for <linux-can@vger.kernel.org>; Sat, 15 Jul 2023 04:32:31 -0700 (PDT)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jookia.org; s=key1;
        t=1689420347;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=TwGDE3yVIxPwsfY7daqG3Fg4YYN3E6U2TSbdOoNGr2c=;
        b=qij1kjnFwoJdPsm8qHKTlc+hKlEqw0z6iH0/AKScKt/SNRm2MnIEdugATrTQV7XEoY5Tyu
        awM9uAT0Ja7GYNRqt0zuQlHylvACAggWDBFPsJIwUrUZbxOQ9vc9SdXq3ujOjIHN9Bo9DI
        M/myL22XbVD07cjWzndjI7gDUjVTO9fTWwWey3fzAhsKK0TxLAYBGnlQ1sMxnE7Gk/MNUZ
        quj/oLQsJH/RdpMIxzLy46NJAzzMZNvN9QnKf+hzKzBD5ZG+hoIO7zwvKfR6SB0yYY+tBh
        pH8hqw5zSR7xDca8eOIBM8nKZM4TOe8upoWE5Qw7HYXyJbZGxN7tJ7KhITGS4A==
From:   Jookia <contact@jookia.org>
To:     linux-sunxi@lists.linux.dev
Cc:     John Watts <contact@jookia.org>, devicetree@vger.kernel.org,
        linux-can@vger.kernel.org, linux-riscv@lists.infradead.org,
        Fabien Poussin <fabien.poussin@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Chen-Yu Tsai <wens@csie.org>
Subject: [PATCH 1/4] dt-bindings: net: can: Add support for Allwinner D1 CAN controller
Date:   Sat, 15 Jul 2023 21:25:19 +1000
Message-ID: <20230715112523.2533742-2-contact@jookia.org>
In-Reply-To: <20230715112523.2533742-1-contact@jookia.org>
References: <20230715112523.2533742-1-contact@jookia.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

From: John Watts <contact@jookia.org>

The Allwinner D1 has two CAN controllers, both a variant of the R40
controller. Unfortunately the registers for the D1 controllers are
moved around enough to be incompatible and require a new compatible.

Introduce the "allwinner,sun20i-d1-can" compatible to support this.

Signed-off-by: John Watts <contact@jookia.org>
---
 .../bindings/net/can/allwinner,sun4i-a10-can.yaml           | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/net/can/allwinner,sun4i-a10-can.yaml b/Documentation/devicetree/bindings/net/can/allwinner,sun4i-a10-can.yaml
index 9c494957a07a..e42ea28d6ab4 100644
--- a/Documentation/devicetree/bindings/net/can/allwinner,sun4i-a10-can.yaml
+++ b/Documentation/devicetree/bindings/net/can/allwinner,sun4i-a10-can.yaml
@@ -21,6 +21,7 @@ properties:
           - const: allwinner,sun4i-a10-can
       - const: allwinner,sun4i-a10-can
       - const: allwinner,sun8i-r40-can
+      - const: allwinner,sun20i-d1-can
 
   reg:
     maxItems: 1
@@ -37,8 +38,9 @@ properties:
 if:
   properties:
     compatible:
-      contains:
-        const: allwinner,sun8i-r40-can
+      enum:
+        - allwinner,sun8i-r40-can
+        - allwinner,sun20i-d1-can
 
 then:
   required:
-- 
2.41.0

