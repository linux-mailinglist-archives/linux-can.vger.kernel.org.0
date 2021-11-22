Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 97AB1458C9E
	for <lists+linux-can@lfdr.de>; Mon, 22 Nov 2021 11:46:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239205AbhKVKtu (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Mon, 22 Nov 2021 05:49:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239067AbhKVKtu (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Mon, 22 Nov 2021 05:49:50 -0500
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBAFBC06173E
        for <linux-can@vger.kernel.org>; Mon, 22 Nov 2021 02:46:43 -0800 (PST)
Received: by mail-lf1-x131.google.com with SMTP id c32so78692635lfv.4
        for <linux-can@vger.kernel.org>; Mon, 22 Nov 2021 02:46:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=wirenboard-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=QNe6aTzR9gkb/+vCdyAp/Zw0YKIRP/v2w6mNVEQQPNA=;
        b=3OEh1zKxBUNBazeE8TXb6pak8tCqz0c4CoZMXS16AFtpOYDidMJVNek6ZxCUO5xeXx
         pMM9+KRg+aAxqMZwFgzqDlaFlYlyzKft6NLXHgMN09MOwyo8351V4S+X1V4pSbG01C4u
         ILcfBGnqeEcEVsYfK0w/qPXgTnVLn2linheH8b5nRbBR96L5A2ab/ObIfFQ0EuDUEcYI
         fAzVEmdBFCzWn8UiGcuHDgESMCLUTw8hKAn8NwZCktXMLXNTKDZ+j2mV1pRC9cO0/soY
         GPbXLHXzxb05ZlgrQg4DBAbPjRWXAubO8sOUI77c5bFf3bXery24v2vYgj7c5TNXiZph
         5MyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=QNe6aTzR9gkb/+vCdyAp/Zw0YKIRP/v2w6mNVEQQPNA=;
        b=OOnafN4ftG4taAFa7/XyIPQ6BFdqYqI2/UtQsQOM1VnACwJ1LHT7wPxDt2VZo73kxe
         AUxScrpU7kHgJCF+KryxRbd7XXfI+jvLhN3Sy4sGJdxqZ4z1jPo9StQZS01EXq9i/VW3
         3dd6Te9XCUzWQazdo75AOKcrSvvlF8KypB6bdKg55LLLNU7yZ3HKMstm1BgaZW/akRp2
         HiluWsohbcaDvKFZxw0twg4FDQ6NdwERiIORx8seQAX4I1+dp9IoiW7qB4XDUlZjwBjz
         KO+dw4XTG5H1dWaokAGQsZ9MvsFf13IgVVYNn93ZHxZOS2h0W7NomfwIzlxSbQLrRXhs
         I47A==
X-Gm-Message-State: AOAM531huvmJooO2hiHLUh7TCM+TfvWfezGgRRUODDIuUWK2bvUpg8Ni
        9os0f3ISeBfLWkRXIgspqG024A==
X-Google-Smtp-Source: ABdhPJzL4Pb/y4VHvTqNi3h3McYI6lp2gv8xX2z4vKS4OUiGMikVJcAVlJtMMmJ8yufQyTioFh7x+Q==
X-Received: by 2002:a05:6512:1194:: with SMTP id g20mr52837084lfr.58.1637578001912;
        Mon, 22 Nov 2021 02:46:41 -0800 (PST)
Received: from boger-laptop.lan (81.5.99.121.dhcp.mipt-telecom.ru. [81.5.99.121])
        by smtp.gmail.com with ESMTPSA id bi24sm923538lfb.49.2021.11.22.02.46.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Nov 2021 02:46:41 -0800 (PST)
From:   Evgeny Boger <boger@wirenboard.com>
To:     Maxime Ripard <mripard@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        linux-arm-kernel@lists.infradead.org
Cc:     Evgeny Boger <boger@wirenboard.com>, devicetree@vger.kernel.org,
        linux-sunxi@lists.linux.dev, linux-can@vger.kernel.org,
        Wolfgang Grandegger <wg@grandegger.com>,
        Marc Kleine-Budde <mkl@pengutronix.de>,
        "David S . Miller" <davem@davemloft.net>,
        Jeroen Hofstee <jhofstee@victronenergy.com>,
        Gerhard Bertelsmann <info@gerhard-bertelsmann.de>
Subject: [PATCH 1/3] dt-bindings: net: can: add support for Allwinner R40 CAN controller
Date:   Mon, 22 Nov 2021 13:46:14 +0300
Message-Id: <20211122104616.537156-2-boger@wirenboard.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211122104616.537156-1-boger@wirenboard.com>
References: <20211122104616.537156-1-boger@wirenboard.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Allwinner R40 (also known as A40i, T3, V40) has a CAN controller. The
controller is the same as in earlier A10 and A20 SoCs, but needs reset
line to be deasserted before use.

This patch Introduces new compatible for R40 CAN controller with
required resets property.

Signed-off-by: Evgeny Boger <boger@wirenboard.com>
---
 .../net/can/allwinner,sun4i-a10-can.yaml      | 24 +++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/Documentation/devicetree/bindings/net/can/allwinner,sun4i-a10-can.yaml b/Documentation/devicetree/bindings/net/can/allwinner,sun4i-a10-can.yaml
index a95960ee3feb..c93fe9d3ea82 100644
--- a/Documentation/devicetree/bindings/net/can/allwinner,sun4i-a10-can.yaml
+++ b/Documentation/devicetree/bindings/net/can/allwinner,sun4i-a10-can.yaml
@@ -17,6 +17,7 @@ properties:
           - const: allwinner,sun7i-a20-can
           - const: allwinner,sun4i-a10-can
       - const: allwinner,sun4i-a10-can
+      - const: allwinner,sun8i-r40-can
 
   reg:
     maxItems: 1
@@ -27,6 +28,19 @@ properties:
   clocks:
     maxItems: 1
 
+  resets:
+    maxItems: 1
+
+if:
+  properties:
+    compatible:
+      contains:
+        const: allwinner,sun8i-r40-can
+
+then:
+  required:
+    - resets
+
 required:
   - compatible
   - reg
@@ -47,5 +61,15 @@ examples:
         interrupts = <GIC_SPI 26 IRQ_TYPE_LEVEL_HIGH>;
         clocks = <&ccu CLK_APB1_CAN>;
     };
+  - |
+    #define RST_BUS_CAN		68
+    #define CLK_BUS_CAN		91
+    can1: can@1c2bc00 {
+        compatible = "allwinner,sun8i-r40-can";
+        reg = <0x01c2bc00 0x400>;
+        interrupts = <GIC_SPI 26 IRQ_TYPE_LEVEL_HIGH>;
+        clocks = <&ccu CLK_BUS_CAN>;
+        resets = <&ccu RST_BUS_CAN>;
+    };
 
 ...
-- 
2.25.1

