Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 28B4262CBBA
	for <lists+linux-can@lfdr.de>; Wed, 16 Nov 2022 21:57:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231261AbiKPU5R (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Wed, 16 Nov 2022 15:57:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238684AbiKPUyB (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Wed, 16 Nov 2022 15:54:01 -0500
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DB3865FD
        for <linux-can@vger.kernel.org>; Wed, 16 Nov 2022 12:53:35 -0800 (PST)
Received: by mail-ej1-x630.google.com with SMTP id ud5so47210755ejc.4
        for <linux-can@vger.kernel.org>; Wed, 16 Nov 2022 12:53:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ah82tTOOObOFB3MDfuIM4J36KFmptfShWyxBMhuP5Xo=;
        b=FuFd7KEQ6d41KZBOZhhpBhnMjYXdxKD3gEK+faGWa/XfhW2EFx9CCnj4pbSYMac2Rg
         VIuXojA8qB/pnTAwSH/PmZxKpCmL2eAkLQyhE5BR42zG3IEDpWTJHKhUoMPbBlM0cwsa
         aoDXSsa8MbXs5ScTvpr0crbR+Zr5r66T3BoltNI3RObZ5w0EZWcatVi6Jt5ZsATEp/Dw
         jt8b+Zt2tr8/FhtYKWD6X46XX4b1PFmxtCddxq2uisW6m40miJnZawPupYuP4ofRL7OM
         qqYATmJca9f9feYgFHce3A/dYWupesj+8yaW4A7p+R4+b/3M0R4QMymOG5zlpIyc1L2s
         gTUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ah82tTOOObOFB3MDfuIM4J36KFmptfShWyxBMhuP5Xo=;
        b=1K4wX4c3NIi867foQSquAhEy7qk3dgcyVIHnAWRgGA+Enk1AROHXv5qtXG/tLWhUiT
         YhvBdNqYWvmrI80msi7k0I1/2xYcSBKW/kEZ/JS1uT1D1AQ2RXKRXMJ8hC+COqEv/Dv1
         fMlPMluDw5v2Td/yfo5AtMH4VnLA+BoMv7rPff5gmaggYtWG/yaPL2h/kvsX57pMDCte
         z0srdRIdZNkoEjCk6D4JIzuihvsPu5eOTDX6877n297RRyrvCvlipFBBHojKxIHsg2a3
         NeVg8RqDs7vOgx3kcQirKTh804Wdk8fQmMbLW5uDoKzIkXo7YI/9ThOqPPDV6awUcuBC
         k56Q==
X-Gm-Message-State: ANoB5pmsCjYUatmkzIfq1xEj2GBFOzdBl7IQ725/RAapl/ZviIT0Me90
        3AQeDdjxWPsSSqMNHB+tpzB82g==
X-Google-Smtp-Source: AA0mqf6TsBpIXovEdmEucl/l73gbKjxzP+VkiJgvsdH0sgJf+BVmPrCsGlJrR9tyIjg9pqj+KeInIA==
X-Received: by 2002:a17:906:53cd:b0:78c:1f2f:233e with SMTP id p13-20020a17090653cd00b0078c1f2f233emr19534963ejo.307.1668632013651;
        Wed, 16 Nov 2022 12:53:33 -0800 (PST)
Received: from blmsp.fritz.box ([2001:4090:a244:804b:353b:565:addf:3aa7])
        by smtp.gmail.com with ESMTPSA id kv17-20020a17090778d100b007aece68483csm6782828ejc.193.2022.11.16.12.53.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Nov 2022 12:53:33 -0800 (PST)
From:   Markus Schneider-Pargmann <msp@baylibre.com>
To:     Chandrasekar Ramakrishnan <rcsekar@samsung.com>,
        Marc Kleine-Budde <mkl@pengutronix.de>,
        Wolfgang Grandegger <wg@grandegger.com>
Cc:     linux-can@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Markus Schneider-Pargmann <msp@baylibre.com>
Subject: [PATCH 12/15] can: tcan4x5x: Remove invalid write in clear_interrupts
Date:   Wed, 16 Nov 2022 21:53:05 +0100
Message-Id: <20221116205308.2996556-13-msp@baylibre.com>
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

Register 0x824 TCAN4X5X_MCAN_INT_REG is a read-only register. Any writes
to this register do not have any effect.

Remove this write. The m_can driver aldready clears the interrupts in
m_can_isr() by writing to M_CAN_IR which is translated to register
0x1050 which is a writable version of this register.

Signed-off-by: Markus Schneider-Pargmann <msp@baylibre.com>
---
 drivers/net/can/m_can/tcan4x5x-core.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/drivers/net/can/m_can/tcan4x5x-core.c b/drivers/net/can/m_can/tcan4x5x-core.c
index 41645a24384c..1fec394b3517 100644
--- a/drivers/net/can/m_can/tcan4x5x-core.c
+++ b/drivers/net/can/m_can/tcan4x5x-core.c
@@ -204,11 +204,6 @@ static int tcan4x5x_clear_interrupts(struct m_can_classdev *cdev)
 	if (ret)
 		return ret;
 
-	ret = tcan4x5x_write_tcan_reg(cdev, TCAN4X5X_MCAN_INT_REG,
-				      TCAN4X5X_ENABLE_MCAN_INT);
-	if (ret)
-		return ret;
-
 	ret = tcan4x5x_write_tcan_reg(cdev, TCAN4X5X_INT_FLAGS,
 				      TCAN4X5X_CLEAR_ALL_INT);
 	if (ret)
-- 
2.38.1

