Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3B64627193
	for <lists+linux-can@lfdr.de>; Sun, 13 Nov 2022 19:13:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235499AbiKMSNk (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Sun, 13 Nov 2022 13:13:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235482AbiKMSNh (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Sun, 13 Nov 2022 13:13:37 -0500
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C89664D4
        for <linux-can@vger.kernel.org>; Sun, 13 Nov 2022 10:13:35 -0800 (PST)
Received: by mail-ej1-x630.google.com with SMTP id ud5so23428403ejc.4
        for <linux-can@vger.kernel.org>; Sun, 13 Nov 2022 10:13:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=D8/Md0NYJHUSKcz4MJWTxhKaskWW/ctRpyjjxqRRhnc=;
        b=ZOmYYgrEGoVimA2TEfidyVQgl7KwexHNHm+svvev3mYj94RrJx9jxXLI+SRn2X05S6
         Q99YX4bhsALtW3GQZdqYRzwitFsbhTXlF8jNOePfnjudIoVPFDFqwv/2Zm30AvuJ4MlQ
         qhjfB8i4c9xMAR13TW0wLXDJqheW2bM+CLRUo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=D8/Md0NYJHUSKcz4MJWTxhKaskWW/ctRpyjjxqRRhnc=;
        b=4P0FiZNAnl/+0L2mXkROVAkdvkDTSzu9l9NH+vwJv8+qGJs5Cja8LEkBquwWJuPi47
         K8304m0aBc1p5FvteFrAGt8XNSTDrLi9iP+mgJh/WTWpTPbdyrSnzEfm39eXIxh5xjTV
         a8/zTciPRXB80JV2Acn5nx0YrITfZmvQ4dypat68wTJ0GP9AfQPicvHoGCCQJZS5dqED
         2wBZvv8qQvjc9wU/W8o3qa4Rjmyg/0W5AhD7lUwBKiAKfL6CLMMv9akn6cRp1uDVdn/D
         O5c8h+GoXkqmV3PzP9aw2cQ1kvUDtXY/aaecZyidT9FYLZhHVV9rYv+c7yegf1Ltb6Vc
         ozzA==
X-Gm-Message-State: ANoB5pljfjkU6iZT5NXQqea4RUrQfhcO8RW3DakL8daCBceTsbS2awF2
        9RFlcJFN3oDb+gOAfW95hbVZnQ==
X-Google-Smtp-Source: AA0mqf6SbC/WbMwh0Wm+4tNMbCY+k9MqeUVdyU/Vq3PUfTmxgFJJ6edqkusVBPOWihkuCFHkH1yW5g==
X-Received: by 2002:a17:906:b855:b0:7ac:f8e3:d547 with SMTP id ga21-20020a170906b85500b007acf8e3d547mr8089231ejb.53.1668363213667;
        Sun, 13 Nov 2022 10:13:33 -0800 (PST)
Received: from dario-ThinkPad-T14s-Gen-2i.homenet.telecomitalia.it (host-79-40-103-33.business.telecomitalia.it. [79.40.103.33])
        by smtp.gmail.com with ESMTPSA id iy6-20020a170907818600b0078de26f66b9sm3225487ejc.114.2022.11.13.10.13.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Nov 2022 10:13:33 -0800 (PST)
From:   Dario Binacchi <dario.binacchi@amarulasolutions.com>
To:     linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Marc Kleine-Budde <mkl@pengutronix.de>,
        Rob Herring <robh@kernel.org>,
        Amarula patchwork <linux-amarula@amarulasolutions.com>,
        michael@amarulasolutions.com,
        Vincent Mailhol <mailhol.vincent@wanadoo.fr>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Dario Binacchi <dario.binacchi@amarulasolutions.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Paolo Abeni <pabeni@redhat.com>,
        Rob Herring <robh+dt@kernel.org>,
        Wolfgang Grandegger <wg@grandegger.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-can@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com, netdev@vger.kernel.org
Subject: [RESEND RFC PATCH v5 2/5] dt-bindings: net: can: add STM32 bxcan DT bindings
Date:   Sun, 13 Nov 2022 19:13:19 +0100
Message-Id: <20221113181322.1627084-3-dario.binacchi@amarulasolutions.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20221113181322.1627084-1-dario.binacchi@amarulasolutions.com>
References: <20221113181322.1627084-1-dario.binacchi@amarulasolutions.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Add documentation of device tree bindings for the STM32 basic extended
CAN (bxcan) controller.

Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>
Reviewed-by: Rob Herring <robh@kernel.org>

---

Changes in v5:
- Add Rob Herring's Reviewed-by tag.

Changes in v4:
- Remove "st,stm32f4-bxcan-core" compatible. In this way the can nodes
 (compatible "st,stm32f4-bxcan") are no longer children of a parent
  node with compatible "st,stm32f4-bxcan-core".
- Add the "st,gcan" property (global can memory) to can nodes which
  references a "syscon" node containing the shared clock and memory
  addresses.

Changes in v3:
- Remove 'Dario Binacchi <dariobin@libero.it>' SOB.
- Add description to the parent of the two child nodes.
- Move "patterProperties:" after "properties: in top level before "required".
- Add "clocks" to the "required:" list of the child nodes.

Changes in v2:
- Change the file name into 'st,stm32-bxcan-core.yaml'.
- Rename compatibles:
  - st,stm32-bxcan-core -> st,stm32f4-bxcan-core
  - st,stm32-bxcan -> st,stm32f4-bxcan
- Rename master property to st,can-master.
- Remove the status property from the example.
- Put the node child properties as required.

 .../bindings/net/can/st,stm32-bxcan.yaml      | 83 +++++++++++++++++++
 1 file changed, 83 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/net/can/st,stm32-bxcan.yaml

diff --git a/Documentation/devicetree/bindings/net/can/st,stm32-bxcan.yaml b/Documentation/devicetree/bindings/net/can/st,stm32-bxcan.yaml
new file mode 100644
index 000000000000..c9194345d202
--- /dev/null
+++ b/Documentation/devicetree/bindings/net/can/st,stm32-bxcan.yaml
@@ -0,0 +1,83 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/net/can/st,stm32-bxcan.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: STMicroelectronics bxCAN controller
+
+description: STMicroelectronics BxCAN controller for CAN bus
+
+maintainers:
+  - Dario Binacchi <dario.binacchi@amarulasolutions.com>
+
+allOf:
+  - $ref: can-controller.yaml#
+
+properties:
+  compatible:
+    enum:
+      - st,stm32f4-bxcan
+
+  st,can-master:
+    description:
+      Master and slave mode of the bxCAN peripheral is only relevant
+      if the chip has two CAN peripherals. In that case they share
+      some of the required logic.
+    type: boolean
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    items:
+      - description: transmit interrupt
+      - description: FIFO 0 receive interrupt
+      - description: FIFO 1 receive interrupt
+      - description: status change error interrupt
+
+  interrupt-names:
+    items:
+      - const: tx
+      - const: rx0
+      - const: rx1
+      - const: sce
+
+  resets:
+    maxItems: 1
+
+  clocks:
+    maxItems: 1
+
+  st,gcan:
+    $ref: "/schemas/types.yaml#/definitions/phandle-array"
+    description:
+      The phandle to the gcan node which allows to access the 512-bytes
+      SRAM memory shared by the two bxCAN cells (CAN1 master and CAN2
+      slave) in dual CAN peripheral configuration.
+
+required:
+  - compatible
+  - reg
+  - interrupts
+  - resets
+  - clocks
+  - st,gcan
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/clock/stm32fx-clock.h>
+    #include <dt-bindings/mfd/stm32f4-rcc.h>
+
+    can1: can@40006400 {
+        compatible = "st,stm32f4-bxcan";
+        reg = <0x40006400 0x200>;
+        interrupts = <19>, <20>, <21>, <22>;
+        interrupt-names = "tx", "rx0", "rx1", "sce";
+        resets = <&rcc STM32F4_APB1_RESET(CAN1)>;
+        clocks = <&rcc 0 STM32F4_APB1_CLOCK(CAN1)>;
+        st,can-master;
+        st,gcan = <&gcan>;
+    };
-- 
2.32.0

