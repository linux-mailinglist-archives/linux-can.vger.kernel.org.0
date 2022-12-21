Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A8705653326
	for <lists+linux-can@lfdr.de>; Wed, 21 Dec 2022 16:25:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234644AbiLUPZu (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Wed, 21 Dec 2022 10:25:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229934AbiLUPZr (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Wed, 21 Dec 2022 10:25:47 -0500
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48076F7F
        for <linux-can@vger.kernel.org>; Wed, 21 Dec 2022 07:25:43 -0800 (PST)
Received: by mail-ed1-x529.google.com with SMTP id c17so22425937edj.13
        for <linux-can@vger.kernel.org>; Wed, 21 Dec 2022 07:25:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HU1fM1Lkfa3GCTAXKr+w8jT2gXMcP3RN7DZ2MvUOkc8=;
        b=WtYsqbILYftz9L6zgOypJZRybELx1w/ZwOle04X7RjSeaOzSX9dfIq0MlOI00pcnjW
         w8VrrKfUe19RUPuUB8GtaYjdXRRd9Mf/ydmkXRgqWu8FV60YW1/kkpWfWF0owTOsTuTf
         DSJsdsGKZpyr/iewDGgSYILZhOTpYuLEKNX78jRIjQvuOICZPs5kWwBMNfXLn2reAf4U
         q+ch1/wBGACrelb1yYqQCO9xtPXtQMu7SdhtW7aix7YndS46sjLdo2+fhffTFI0tOX5e
         cQEh62Ts1JGOA7BMNPmq2EYDFwRjgksrsjTaMPFoRWGrmYcnQtfp7JAnDm3oeK2PbFp0
         34Sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HU1fM1Lkfa3GCTAXKr+w8jT2gXMcP3RN7DZ2MvUOkc8=;
        b=iHmnNXkLLruKz13rEzJ1YfUUEp+0nx1YY39jLEgb9JYbTVXp3hsveUp5VoEYfFxVJj
         TsCOXJEEME89f/KnYCarHVRyU+fzCBZiYkgCjG16JGJ9KUTE6gPLKq8lidY1E/NJiCew
         kSEUkFS1TgVzZchS4ecJG+82KiQ76CdW5NfawmJa9XjpfsXTE9UxVPvsYnebZ4MGoEJK
         PUlrRPlNhBRD0sGOrSFDxHClmu1bQAhkRsDySbIW6qqeb6cclbcpnBqC3m3l2XR286kZ
         qriMEVaw9T+7D5QlKQoILzQtoOKFH/xgVdnEAhZha1DwaCWo8TWTfRJrbfkJgCKlnCoD
         96qQ==
X-Gm-Message-State: AFqh2kqopr9g6vHv2QrwGsiu4A6UIu4mBBaDODqyuIK65/CWPdZ4JnF7
        9zkr6CBwh6xG2SUynQ7okMo5BA==
X-Google-Smtp-Source: AMrXdXtZz9fpR8hP9aUKNWjugy5IKldEiN3VoOl3UFA/+2MNt9/fVWOYL/jVZn0mGWFR1ULpR3yaQg==
X-Received: by 2002:a05:6402:38d:b0:46f:b2df:4e0b with SMTP id o13-20020a056402038d00b0046fb2df4e0bmr1836537edv.14.1671636341814;
        Wed, 21 Dec 2022 07:25:41 -0800 (PST)
Received: from blmsp.fritz.box ([2001:4091:a245:805c:8713:84e4:2a9e:cbe8])
        by smtp.gmail.com with ESMTPSA id n19-20020aa7c793000000b0045cf4f72b04sm7105428eds.94.2022.12.21.07.25.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Dec 2022 07:25:41 -0800 (PST)
From:   Markus Schneider-Pargmann <msp@baylibre.com>
To:     Marc Kleine-Budde <mkl@pengutronix.de>,
        Chandrasekar Ramakrishnan <rcsekar@samsung.com>,
        Wolfgang Grandegger <wg@grandegger.com>
Cc:     Vincent MAILHOL <mailhol.vincent@wanadoo.fr>,
        linux-can@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Markus Schneider-Pargmann <msp@baylibre.com>
Subject: [PATCH 01/18] can: tcan4x5x: Remove reserved register 0x814 from writable table
Date:   Wed, 21 Dec 2022 16:25:20 +0100
Message-Id: <20221221152537.751564-2-msp@baylibre.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221221152537.751564-1-msp@baylibre.com>
References: <20221221152537.751564-1-msp@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
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
2.38.1

