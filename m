Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A55B62CBB8
	for <lists+linux-can@lfdr.de>; Wed, 16 Nov 2022 21:57:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239326AbiKPU5P (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Wed, 16 Nov 2022 15:57:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234935AbiKPUyB (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Wed, 16 Nov 2022 15:54:01 -0500
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95F8D9FFE
        for <linux-can@vger.kernel.org>; Wed, 16 Nov 2022 12:53:35 -0800 (PST)
Received: by mail-ej1-x632.google.com with SMTP id f27so14282eje.1
        for <linux-can@vger.kernel.org>; Wed, 16 Nov 2022 12:53:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YM61plGO68WaURjQUGMFYN3EyOhHGwttCZUHVzMzSmk=;
        b=Ai+PNsCF8RUwtUbnUOAUElOEHQCIBtfvFr4FFEPhc4TBV1LylFALavmdFCQF1QzYq/
         qDLB9z/9yjs+tm0zJDPFsIHbvWfXxkuKo96Mw4ScW7PN57/EQlnKCQF3ks2yEEWGQS4M
         fOkPJMw5pzIgSHSJxAAN/m0vsKCwGMVMEeXP40tQCc2n8qnsGB+hhZa1DA4jL5zut82i
         7bC2rKxw1gYmVP6CvdtAOEt2IjHSFaOJPPC4uXz5zk7Yf+apbdDgU6asT4dd1JJgsrsU
         hgu+opVs9duZiov5egbrN5iBHXVuLoqZhPNnLyLFx6oOgUWVE2t7GU+wFAKEtKmsFXq3
         kPfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YM61plGO68WaURjQUGMFYN3EyOhHGwttCZUHVzMzSmk=;
        b=l3A7yYnuBDxBOdLwiuO+m63mzbd76fL+HI3ply2nEVe8gAaA8yBK3zTry3kBRji6HI
         AI3haC8aB+GLM36CKHVn9m2NxCmh8Renwh+JcvQLX3S+SRbZgKacidP/qoRKILfwxD1K
         jgoa5t1D+/E9S8wvdPPCvULWwXRT5WzXWGyTXZGl6BkpA2uxmUsJJyZsPnSKKNzeT3YC
         2rPAxbODD2DhxnG5g7nG23JA1qVQ4frJ52dDPS/dWexGLTJ3FbtPZ2z85ff2CLrENHzT
         8YTyinHYrNJbmNaBx2NGGtj7znMgDdufX8kOyJwqEAn41hcQXI3BNLmmmn3tN0JKbL/a
         Hc1Q==
X-Gm-Message-State: ANoB5pnomMhZGWVK1R3IIn/2XoEDsSqur05+EC5R0wRjLEqf2d9dZfBu
        3uINRe8lpczOLuhWz67kz46HwA==
X-Google-Smtp-Source: AA0mqf7VeG4VcKKp/7grTNCCfy6yeZuKVFMgRgRP2joVmv0aloO7Kuyi4aEcATQ/8m/x/shIVVm6OQ==
X-Received: by 2002:a17:907:c78d:b0:7af:113a:7416 with SMTP id tz13-20020a170907c78d00b007af113a7416mr10052021ejc.16.1668632015148;
        Wed, 16 Nov 2022 12:53:35 -0800 (PST)
Received: from blmsp.fritz.box ([2001:4090:a244:804b:353b:565:addf:3aa7])
        by smtp.gmail.com with ESMTPSA id kv17-20020a17090778d100b007aece68483csm6782828ejc.193.2022.11.16.12.53.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Nov 2022 12:53:34 -0800 (PST)
From:   Markus Schneider-Pargmann <msp@baylibre.com>
To:     Chandrasekar Ramakrishnan <rcsekar@samsung.com>,
        Marc Kleine-Budde <mkl@pengutronix.de>,
        Wolfgang Grandegger <wg@grandegger.com>
Cc:     linux-can@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Markus Schneider-Pargmann <msp@baylibre.com>
Subject: [PATCH 14/15] can: tcan4x5x: Fix register range of first block
Date:   Wed, 16 Nov 2022 21:53:07 +0100
Message-Id: <20221116205308.2996556-15-msp@baylibre.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221116205308.2996556-1-msp@baylibre.com>
References: <20221116205308.2996556-1-msp@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

According to the datasheet 0x1c is the last register in the first block,
not register 0x2c.

Signed-off-by: Markus Schneider-Pargmann <msp@baylibre.com>
---
 drivers/net/can/m_can/tcan4x5x-regmap.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/can/m_can/tcan4x5x-regmap.c b/drivers/net/can/m_can/tcan4x5x-regmap.c
index 26e212b8ca7a..d4b79d2d4598 100644
--- a/drivers/net/can/m_can/tcan4x5x-regmap.c
+++ b/drivers/net/can/m_can/tcan4x5x-regmap.c
@@ -91,7 +91,7 @@ static int tcan4x5x_regmap_read(void *context,
 }
 
 static const struct regmap_range tcan4x5x_reg_table_yes_range[] = {
-	regmap_reg_range(0x0000, 0x002c),	/* Device ID and SPI Registers */
+	regmap_reg_range(0x0000, 0x001c),	/* Device ID and SPI Registers */
 	regmap_reg_range(0x0800, 0x083c),	/* Device configuration registers and Interrupt Flags*/
 	regmap_reg_range(0x1000, 0x10fc),	/* M_CAN */
 	regmap_reg_range(0x8000, 0x87fc),	/* MRAM */
-- 
2.38.1

