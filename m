Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D3C962CB9E
	for <lists+linux-can@lfdr.de>; Wed, 16 Nov 2022 21:54:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237725AbiKPUyV (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Wed, 16 Nov 2022 15:54:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234789AbiKPUxu (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Wed, 16 Nov 2022 15:53:50 -0500
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E3EA2BD3
        for <linux-can@vger.kernel.org>; Wed, 16 Nov 2022 12:53:31 -0800 (PST)
Received: by mail-ej1-x632.google.com with SMTP id f27so13484eje.1
        for <linux-can@vger.kernel.org>; Wed, 16 Nov 2022 12:53:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qMp0tWmayQFDCuQozvTUDpU6JW1zD9b9gmw4AkF62cg=;
        b=DfeLSauoK/xGMIYKQS8dUtNF5Y18jC4Dz7wPaMBhY5Wz7+f37x4ilwFFQVnDpFTXSy
         RKqXurBocAzbyzMqPdiS6IFjDxXzj+E3RZZQepcFM0ml8inFXsUQmDvg0Hy2EsCOITDH
         JHZYC75OVUxxK1+3P2am1KYY0AVX41vaxmwed/okFMyJDFu0zoFRlpFGwsO6hKrIPbwS
         inW4U/bJrq78cR6BOJhNepOxNwuQ/Qzlt8apxkk1uMwSP5visMZepMGF+j0smMOFVL/n
         NTjVi45THe7cCOGS1X7kkLDZg9X3Ivh5BUibveo9ryklA21H8QR8Gt0Or4XILbIIvTJT
         23jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qMp0tWmayQFDCuQozvTUDpU6JW1zD9b9gmw4AkF62cg=;
        b=2SxdaBe8qSwXfE9JbD8knRmMTyg9XQPiakJuQnqZtlwCc7eiDFEoO0jWUKyaUVbssh
         BzSrR7gkfQzlj7Rii6ySb1XSHNBFoLZPpuVcNLEJIo84uA8rPEZ1yZmVXJICPPgHzSAR
         SCwRTsgx0Dmn/GvYxnDQ6ssFN7JTtPaIRGjdF/j8UI9LrLe+g3I/cS8JhenI7cRuDpHh
         vGgQEtfEJ0s/c3hFPSOdfcTYTjmt2vvxlTMW6Mmc//jvvanP48738UfeKZ1WhwB8/ylv
         +h/BiO4x7tEzu1Nh5+LFGa6eBkjz7bmErxQn1GPmChbKFXAr2FtInzLU9QItRzYEnY2V
         mr0g==
X-Gm-Message-State: ANoB5pl6G5MunSlpJ8Z00qvFK3LvJZWS4mUse0miIO5QdlOzOYXlPRti
        4YjkULjiOH+2brgc4pOUhtU3vA==
X-Google-Smtp-Source: AA0mqf5UtYQOtXnOHStEcoyycrgqiCBoL8jfnYcxOSZJ0kartEU1g5NyzH2ae4zG0NlZQX+qHgcbWQ==
X-Received: by 2002:a17:907:cc9d:b0:7ac:ef6b:1ef4 with SMTP id up29-20020a170907cc9d00b007acef6b1ef4mr20163923ejc.104.1668632009629;
        Wed, 16 Nov 2022 12:53:29 -0800 (PST)
Received: from blmsp.fritz.box ([2001:4090:a244:804b:353b:565:addf:3aa7])
        by smtp.gmail.com with ESMTPSA id kv17-20020a17090778d100b007aece68483csm6782828ejc.193.2022.11.16.12.53.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Nov 2022 12:53:29 -0800 (PST)
From:   Markus Schneider-Pargmann <msp@baylibre.com>
To:     Chandrasekar Ramakrishnan <rcsekar@samsung.com>,
        Marc Kleine-Budde <mkl@pengutronix.de>,
        Wolfgang Grandegger <wg@grandegger.com>
Cc:     linux-can@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Markus Schneider-Pargmann <msp@baylibre.com>
Subject: [PATCH 07/15] can: m_can: Read register PSR only on error
Date:   Wed, 16 Nov 2022 21:53:00 +0100
Message-Id: <20221116205308.2996556-8-msp@baylibre.com>
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

Only read register PSR if there is an error indicated in irqstatus.

Signed-off-by: Markus Schneider-Pargmann <msp@baylibre.com>
---
 drivers/net/can/m_can/m_can.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/net/can/m_can/m_can.c b/drivers/net/can/m_can/m_can.c
index 0efa6dee0617..1d15beaea920 100644
--- a/drivers/net/can/m_can/m_can.c
+++ b/drivers/net/can/m_can/m_can.c
@@ -901,7 +901,6 @@ static int m_can_rx_handler(struct net_device *dev, int quota, u32 irqstatus)
 	struct m_can_classdev *cdev = netdev_priv(dev);
 	int rx_work_or_err;
 	int work_done = 0;
-	u32 psr;
 
 	if (!irqstatus)
 		goto end;
@@ -927,13 +926,13 @@ static int m_can_rx_handler(struct net_device *dev, int quota, u32 irqstatus)
 		}
 	}
 
-	psr = m_can_read(cdev, M_CAN_PSR);
-
 	if (irqstatus & IR_ERR_STATE)
-		work_done += m_can_handle_state_errors(dev, psr);
+		work_done += m_can_handle_state_errors(dev,
+						       m_can_read(cdev, M_CAN_PSR));
 
 	if (irqstatus & IR_ERR_BUS_30X)
-		work_done += m_can_handle_bus_errors(dev, irqstatus, psr);
+		work_done += m_can_handle_bus_errors(dev, irqstatus,
+						     m_can_read(cdev, M_CAN_PSR));
 
 	if (irqstatus & IR_RF0N) {
 		rx_work_or_err = m_can_do_rx_poll(dev, (quota - work_done));
-- 
2.38.1

