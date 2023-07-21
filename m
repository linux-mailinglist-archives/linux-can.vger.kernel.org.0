Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 96E0175C843
	for <lists+linux-can@lfdr.de>; Fri, 21 Jul 2023 15:50:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231502AbjGUNu3 (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Fri, 21 Jul 2023 09:50:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231464AbjGUNuV (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Fri, 21 Jul 2023 09:50:21 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32A4F2D50
        for <linux-can@vger.kernel.org>; Fri, 21 Jul 2023 06:50:19 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id 5b1f17b1804b1-3fbc63c2e84so17297795e9.3
        for <linux-can@vger.kernel.org>; Fri, 21 Jul 2023 06:50:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20221208.gappssmtp.com; s=20221208; t=1689947417; x=1690552217;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tK3XW9CvIKNotY0VMKRibuYSfqNfjSdewyrI1jRS2zM=;
        b=0ctkDHsJLr567qj00My9u/DwovaTt7nVS0cVaepA86zfFneViqAlpM4chikj9YNjt3
         KlTL4vYYcjlmlMHwc+SKh/+xXAkR3OhXaqYSFferh6wND2fdMOEDZ6aS5HB14zXPaVLu
         01Ge809ipavv5JQ8PxQ/x6kPY60W2EuxY/4BPBpNQHl4y8M1q/iN9+73+T9K9czoeU9y
         jwVXSRdJyVefdJ1xzvkssK9P4GpXffMhdBBW1WIExz05IpK+HM6yDYwpUFpHYZX2Qq3t
         Pv1PgAcxoOTi2f1MUVrDdmu3LJ2nnadMjVj7wS7B3U4lLCwY0ES6m8/rf8nHVwZta9G9
         cRKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689947417; x=1690552217;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tK3XW9CvIKNotY0VMKRibuYSfqNfjSdewyrI1jRS2zM=;
        b=Is4iBkckerT4PInlnokdtO7syihB1+1Xmcd4ylpgY7/DobIzL4CuqsaIBVCR5J7JoL
         GtrjopOZlqk6Ed3LR+VO+VCwX2IcsGuHuwLmLRarygPkEFaZjz6Ke4DhPK/QcJKXzpP5
         GSI2/mzvBNQb/3W65mo1pyr+UDCt1YztWFB/LWL9EPRxad2lvDqGYFZ5COBqif9zz3m9
         Rsdp5r1eIbBIc6rIbRHZ91JI02IU0FVbKvqfc1zkC23QN1SciqjWbB75YI9CRr8J6SEA
         rslsuAetJ+Z1S6ze1kAPIyaOpA9clz8zt5Uik7sv3VhfLMJPvQVp5SXeGwoV3hJWeawY
         IWQw==
X-Gm-Message-State: ABy/qLbzRioBRCOecjt2SRG7Syel+1xD8MBea27dJHl/8wSq2ZR39bY1
        NlnY9zXiA6V5I/bNZnAMGaD27A==
X-Google-Smtp-Source: APBJJlEYGOJohpsvToAwNTHgc3LKCSn7YXvsUGwDkuU0VAHrmITjFOeoFfDz7sdQfHoDDp7yNk7Lbw==
X-Received: by 2002:a1c:f206:0:b0:3fb:415a:d07 with SMTP id s6-20020a1cf206000000b003fb415a0d07mr1476441wmc.36.1689947417293;
        Fri, 21 Jul 2023 06:50:17 -0700 (PDT)
Received: from blmsp.fritz.box ([2001:4091:a247:82fa:b762:4f68:e1ed:5041])
        by smtp.gmail.com with ESMTPSA id c14-20020adfed8e000000b00313e4d02be8sm4233980wro.55.2023.07.21.06.50.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Jul 2023 06:50:16 -0700 (PDT)
From:   Markus Schneider-Pargmann <msp@baylibre.com>
To:     Wolfgang Grandegger <wg@grandegger.com>,
        Marc Kleine-Budde <mkl@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     "David S . Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Conor Dooley <conor+dt@kernel.org>,
        Chandrasekar Ramakrishnan <rcsekar@samsung.com>,
        Michal Kubiak <michal.kubiak@intel.com>,
        Vivek Yadav <vivek.2311@samsung.com>,
        linux-can@vger.kernel.org, netdev@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Simon Horman <simon.horman@corigine.com>,
        Markus Schneider-Pargmann <msp@baylibre.com>
Subject: [PATCH v3 4/6] can: tcan4x5x: Rename ID registers to match datasheet
Date:   Fri, 21 Jul 2023 15:50:07 +0200
Message-Id: <20230721135009.1120562-5-msp@baylibre.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230721135009.1120562-1-msp@baylibre.com>
References: <20230721135009.1120562-1-msp@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

The datasheet calls these registers ID1 and ID2. Rename these to avoid
confusion.

Signed-off-by: Markus Schneider-Pargmann <msp@baylibre.com>
Reviewed-by: Michal Kubiak <michal.kubiak@intel.com>
---
 drivers/net/can/m_can/tcan4x5x-core.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/can/m_can/tcan4x5x-core.c b/drivers/net/can/m_can/tcan4x5x-core.c
index e706518176e4..fb9375fa20ec 100644
--- a/drivers/net/can/m_can/tcan4x5x-core.c
+++ b/drivers/net/can/m_can/tcan4x5x-core.c
@@ -6,8 +6,8 @@
 
 #define TCAN4X5X_EXT_CLK_DEF 40000000
 
-#define TCAN4X5X_DEV_ID0 0x00
-#define TCAN4X5X_DEV_ID1 0x04
+#define TCAN4X5X_DEV_ID1 0x00
+#define TCAN4X5X_DEV_ID2 0x04
 #define TCAN4X5X_REV 0x08
 #define TCAN4X5X_STATUS 0x0C
 #define TCAN4X5X_ERROR_STATUS_MASK 0x10
-- 
2.40.1

