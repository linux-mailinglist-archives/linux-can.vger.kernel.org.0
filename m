Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E3A26B989E
	for <lists+linux-can@lfdr.de>; Tue, 14 Mar 2023 16:12:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231612AbjCNPMZ (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Tue, 14 Mar 2023 11:12:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231590AbjCNPMY (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 14 Mar 2023 11:12:24 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1863E9BE25
        for <linux-can@vger.kernel.org>; Tue, 14 Mar 2023 08:12:22 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id j2so14657394wrh.9
        for <linux-can@vger.kernel.org>; Tue, 14 Mar 2023 08:12:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112; t=1678806740;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8fjPi0++9HsE/g35dDtgt0nVDV0ftpyC2jXqNwiLftg=;
        b=wWN0v8x3ge9+v/J0sUDB316m/AXx/aBfzFM4Br27vN+PgTRTZmSvt6C4sniYj84A6P
         3RN72kOYp3ztPUnLaW3dDcV70GpWiwdDKbA9lV2PwQnnTCXRYC1FtttmKpG+WSiRJLTS
         nWq6Oy6/35vDp0N8Q/OBs1fJ4qP2y/dagc3Key4rlGM8OWzkQ47yNxn96L3IIlgwZpEU
         aAgD+3uLUAwfRY0gmp2amA3lmHeHGSlwSkO2EDYzJBBL1L3jVu78sTX/jnANP/rSUpk3
         ymK4FWCz1twMyF473a1JDqq+CDR4ybHhPIjSFSqk4FRqIl+m7Emurz9gfrpN26VvTXls
         NB4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678806740;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8fjPi0++9HsE/g35dDtgt0nVDV0ftpyC2jXqNwiLftg=;
        b=Q/aDhfPnO4lmNaTftQISMZJKNDywpSwsodAAi91V/yJUVJpKqeFV1Hv9jGBxre4dhC
         /2dno44c8yBa/qNw2xp2vXk/tCvto4BvPIlU5nVX02ngZ5FCsGe2PUZbdekXtrD3SknI
         TbGMQwfnB4nHlVKiJr8vs5y1QQeflw/P3YPAHZ4J1bYtEa6zQKepmQQyWnCh7/BXFfPf
         JoS/0JxdkyyXNzMbrBPySQ3kbwzZN58BKXLAAvpV9R60FDeZOti6iJ+/cICQ/GZR9wd2
         Bt/m0HygvFuzUxLpEa5b71wRMuzS41ZS2Dd18TpJapcZQ1vT8vipO9Bp0YcCKFTpsfbY
         33Xg==
X-Gm-Message-State: AO0yUKUV4bkQPT81PQ6nKnlV5nso3Bw5uJAF7JLKP2e190+pKfPxESuq
        Sb+MFrzr00Lg4S0zwaaOPwPO3Q==
X-Google-Smtp-Source: AK7set+/gABvKl6digK4jG++dRZEgS+HO1lTXWAnkCnkbxLJrX5P0SKZ5QIitztMFudn7j/6sciNSQ==
X-Received: by 2002:a5d:6b87:0:b0:2c7:1c72:69a3 with SMTP id n7-20020a5d6b87000000b002c71c7269a3mr25214914wrx.29.1678806740600;
        Tue, 14 Mar 2023 08:12:20 -0700 (PDT)
Received: from blmsp.fritz.box ([2001:4090:a247:8056:be7d:83e:a6a5:4659])
        by smtp.gmail.com with ESMTPSA id d9-20020a5d4f89000000b002c707b336c9sm2320158wru.36.2023.03.14.08.12.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Mar 2023 08:12:20 -0700 (PDT)
From:   Markus Schneider-Pargmann <msp@baylibre.com>
To:     Marc Kleine-Budde <mkl@pengutronix.de>,
        Chandrasekar Ramakrishnan <rcsekar@samsung.com>,
        Wolfgang Grandegger <wg@grandegger.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     Vincent MAILHOL <mailhol.vincent@wanadoo.fr>,
        Simon Horman <simon.horman@corigine.com>,
        linux-can@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Markus Schneider-Pargmann <msp@baylibre.com>
Subject: [PATCH 4/5] can: tcan4x5x: Rename ID registers to match datasheet
Date:   Tue, 14 Mar 2023 16:12:00 +0100
Message-Id: <20230314151201.2317134-5-msp@baylibre.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230314151201.2317134-1-msp@baylibre.com>
References: <20230314151201.2317134-1-msp@baylibre.com>
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

The datasheet calls these registers ID1 and ID2. Rename these to avoid
confusion.

Signed-off-by: Markus Schneider-Pargmann <msp@baylibre.com>
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
2.39.2

