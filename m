Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A0E2B59E42D
	for <lists+linux-can@lfdr.de>; Tue, 23 Aug 2022 15:32:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238978AbiHWNJ5 (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Tue, 23 Aug 2022 09:09:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241574AbiHWNJY (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 23 Aug 2022 09:09:24 -0400
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05FD3133B8D
        for <linux-can@vger.kernel.org>; Tue, 23 Aug 2022 03:11:20 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id l8so1470510lfc.12
        for <linux-can@vger.kernel.org>; Tue, 23 Aug 2022 03:11:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc;
        bh=AZasA7ru4RBuOT7il+83aHYYeB5TFBrGiGUj7Hz0hho=;
        b=rEDtys7/7ehxHoe6Wrw9K9tDKHsQaWvQWc/iO7EXhJIqEvqH8g0cRZm+ntDEI/BBho
         RUPePCWjNMAQQa7z1vSihgZ+HQaj1h021VoaQeLMiOw0+w1uPPRtPLpnA17oilmxOKig
         Ck5pabaJqWlll2wAeFXbP4S8W2o47Kvf0V+RivEivn5Gbv5eKO5RlYB5vz4FJFGQqnUJ
         q/7uO0DlfHX5rRd8SmiH/Nujcdetzhqfzt1CXFAsO1p4RZqtgUs9h82SYNJULDZpgdxi
         /dTg9cpbEYzGJVHnGv8PaBuVyF0m7BD7n4f9UzIzBqh5GtAVqvBF8tJdfVPd6yHpXRVK
         6Clw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc;
        bh=AZasA7ru4RBuOT7il+83aHYYeB5TFBrGiGUj7Hz0hho=;
        b=pnYMWxidsYExcvd6yjdNZuILcx4w3Sc92kjnwPCrzzKJsyVf/72Z4SxqcYkI/Q169n
         XNpX6NLlMuK6MGoeln1lWlmNFkZ7O+TDZRK0l1iINJXALsOleZ5JQGEfvfr/g1tlCLXS
         Sf8f/+Iw2nKMns+245di7+AxjR5RC3ZkuPsUX9Vd8styZHd4UsldfeJTCV5zqgopNht3
         63pV5TLHZznogWUkcE4lRSl+99tsPxiMebw3F5z5UL2z91WzYSNxZxYyL/0l11j/10dq
         lHaaXStawd1G+472P5+H4Rc8i8QNet0hOoKLbHHfpJg4Bg+s/Zj/IqwYuOhZjAc9s2I4
         Tl6Q==
X-Gm-Message-State: ACgBeo3eziwVeT5JcznLp1AAmez45g5go2Ama/fp5azS4cc7HuLCtAWx
        DkMV+aP59kRbG3cp/vickg4LIQ==
X-Google-Smtp-Source: AA6agR6pd09B988zCU50PRE+Ehh4CmDVrkjcaGeGv4/suuwgIa/1BEky+q4J4ZmdTHCH0FOq/Grfmg==
X-Received: by 2002:ac2:4e6a:0:b0:492:f027:218e with SMTP id y10-20020ac24e6a000000b00492f027218emr1721637lfs.676.1661249414775;
        Tue, 23 Aug 2022 03:10:14 -0700 (PDT)
Received: from krzk-bin.. (89-27-92-210.bb.dnainternet.fi. [89.27.92.210])
        by smtp.gmail.com with ESMTPSA id 28-20020ac25f5c000000b00492db7f47f2sm1383025lfz.275.2022.08.23.03.10.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Aug 2022 03:10:14 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Wolfgang Grandegger <wg@grandegger.com>,
        Marc Kleine-Budde <mkl@pengutronix.de>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-can@vger.kernel.org, netdev@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH] dt-bindings: net: can: nxp,sja1000: drop ref from reg-io-width
Date:   Tue, 23 Aug 2022 13:10:11 +0300
Message-Id: <20220823101011.386970-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

reg-io-width is a standard property, so no need for defining its type

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 Documentation/devicetree/bindings/net/can/nxp,sja1000.yaml | 1 -
 1 file changed, 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/net/can/nxp,sja1000.yaml b/Documentation/devicetree/bindings/net/can/nxp,sja1000.yaml
index b1327c5b86cf..d919910c690c 100644
--- a/Documentation/devicetree/bindings/net/can/nxp,sja1000.yaml
+++ b/Documentation/devicetree/bindings/net/can/nxp,sja1000.yaml
@@ -31,7 +31,6 @@ properties:
     maxItems: 1
 
   reg-io-width:
-    $ref: /schemas/types.yaml#/definitions/uint32
     description: I/O register width (in bytes) implemented by this device
     default: 1
     enum: [ 1, 2, 4 ]
-- 
2.34.1

