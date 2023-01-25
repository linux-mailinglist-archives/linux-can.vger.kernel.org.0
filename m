Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC66567BB03
	for <lists+linux-can@lfdr.de>; Wed, 25 Jan 2023 20:51:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235574AbjAYTvL (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Wed, 25 Jan 2023 14:51:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229481AbjAYTvJ (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Wed, 25 Jan 2023 14:51:09 -0500
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0643058971
        for <linux-can@vger.kernel.org>; Wed, 25 Jan 2023 11:51:06 -0800 (PST)
Received: by mail-ej1-x636.google.com with SMTP id vw16so50581845ejc.12
        for <linux-can@vger.kernel.org>; Wed, 25 Jan 2023 11:51:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mxWtntR87QPQtBcaxG7QqCrr8e8g6sulYm7WbYMis/Y=;
        b=Wa6R4LehTz4hL1fyn0Tgu/fMCKHyh1QO1mweKkity5p91CDaaEV5PERR3qAPxCSGAh
         mS5bkPYot/aFGWq7p4pHq+bNwx1/aH2BpNsaXWt+yXGOz63x88/JJ0gkhKoj4qja7n/Q
         z4XNkx/ING9Fc+3wYKLZgW4UolnLMqi8Xmp1Yp1aXeiz/UB0UOqRNjbNjgXJ5/IzPefm
         E3YRtHpM0xIVoC0zjPJ2KFYu/UgA9EIrY2FJzoyw8j6Bu2V9e8EWWLXxOvy7PoOtU6vt
         oy7qUwBPOAHvTFvSD6PchZp5CxiaaK4KRRxPYcWRwX9B9akyczvbsXMTpjNYnZA0MxUv
         IoCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mxWtntR87QPQtBcaxG7QqCrr8e8g6sulYm7WbYMis/Y=;
        b=LWgBAzvQ8WuqyaE3cdiqJbuMWtItnLsxalVv3gp+nZuZGd63MVj07ARMyASmSg1Mai
         m/9d7k8MUPqwlOowiFLvKP46RE1bTWxcnV8uLPh0f15yyVsWaPMlVR/ssyNW7y20obBG
         MGxSSpKZV+1dclIPxEy4b6zQtBNj9RBLqV2GxLBs/V1aTXoE8P+Q8rxn4ymjlETXDQF1
         3hWrZyPhvgHQvKm9gLAv6VuFYxnwdjRuFHgwhxPXnc4No3+SnfrG8AN6+wbsVlOHgJuc
         pTPGjteXGKqwvasT8ACtzlhAcJVwGl0w5KKl5zm8gJsritQvT4xxr3r0I67STH5CQR8O
         hZoA==
X-Gm-Message-State: AFqh2krNTjdhiPsPFHizdU8J42XYBk7ar/TrBYzy+cK0Bx+Dmw+COQ5Y
        RPn6sl2k9t9IcefPTqMTsi/KvA==
X-Google-Smtp-Source: AMrXdXvA810tjhCEaeVq1GUR/jtyFVYXE5HaCazshldGxxf389uSU646RypmMq75NV3CDGuNck604Q==
X-Received: by 2002:a17:907:8a1d:b0:84d:3822:2fc7 with SMTP id sc29-20020a1709078a1d00b0084d38222fc7mr45785644ejc.77.1674676265435;
        Wed, 25 Jan 2023 11:51:05 -0800 (PST)
Received: from blmsp.fritz.box ([2001:4091:a247:815f:ef74:e427:628a:752c])
        by smtp.gmail.com with ESMTPSA id s15-20020a170906454f00b00872c0bccab2sm2778830ejq.35.2023.01.25.11.51.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Jan 2023 11:51:05 -0800 (PST)
From:   Markus Schneider-Pargmann <msp@baylibre.com>
To:     Marc Kleine-Budde <mkl@pengutronix.de>,
        Chandrasekar Ramakrishnan <rcsekar@samsung.com>,
        Wolfgang Grandegger <wg@grandegger.com>
Cc:     Vincent MAILHOL <mailhol.vincent@wanadoo.fr>,
        linux-can@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Markus Schneider-Pargmann <msp@baylibre.com>
Subject: [PATCH v2 01/18] can: tcan4x5x: Remove reserved register 0x814 from writable table
Date:   Wed, 25 Jan 2023 20:50:42 +0100
Message-Id: <20230125195059.630377-2-msp@baylibre.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230125195059.630377-1-msp@baylibre.com>
References: <20230125195059.630377-1-msp@baylibre.com>
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

The mentioned register is not writable. It is reserved and should not be
written.

Fixes: 39dbb21b6a29 ("can: tcan4x5x: Specify separate read/write ranges")
Signed-off-by: Markus Schneider-Pargmann <msp@baylibre.com>
---
 drivers/net/can/m_can/tcan4x5x-regmap.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/net/can/m_can/tcan4x5x-regmap.c b/drivers/net/can/m_can/tcan4x5x-regmap.c
index 2b218ce04e9f..fafa6daa67e6 100644
--- a/drivers/net/can/m_can/tcan4x5x-regmap.c
+++ b/drivers/net/can/m_can/tcan4x5x-regmap.c
@@ -95,7 +95,6 @@ static const struct regmap_range tcan4x5x_reg_table_wr_range[] = {
 	regmap_reg_range(0x000c, 0x0010),
 	/* Device configuration registers and Interrupt Flags*/
 	regmap_reg_range(0x0800, 0x080c),
-	regmap_reg_range(0x0814, 0x0814),
 	regmap_reg_range(0x0820, 0x0820),
 	regmap_reg_range(0x0830, 0x0830),
 	/* M_CAN */
-- 
2.39.0

