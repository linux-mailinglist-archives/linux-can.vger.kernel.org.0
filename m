Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ACC8E67BB0A
	for <lists+linux-can@lfdr.de>; Wed, 25 Jan 2023 20:51:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235606AbjAYTvM (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Wed, 25 Jan 2023 14:51:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235570AbjAYTvL (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Wed, 25 Jan 2023 14:51:11 -0500
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEFAD45236
        for <linux-can@vger.kernel.org>; Wed, 25 Jan 2023 11:51:09 -0800 (PST)
Received: by mail-ej1-x62e.google.com with SMTP id rl14so47280985ejb.2
        for <linux-can@vger.kernel.org>; Wed, 25 Jan 2023 11:51:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4ZXxLGpYkNLGcR4LovdInInPDGQW3TFLwetgUaPjssQ=;
        b=W23tRwv4tlQnu6fkwQN0QX5jysPCG+Kz3MLqdQNRukYPtFbsJNAHdRBnwI+8nIIOS3
         SWLRhvPidwFEPSuwytVvoN+lZNLPna9ZbzZ2YZiiRIJlsthFLOHanspC1t8rFcxYz2MQ
         hncplSZ7Z+DF687j8Tn0jdT1waGrR/Wjbf25ruiTrzFPqQszyRFhFA1XMLqfarPVXnqm
         WVrZ5YB/3sCX9/QvcTdOnMzNsJ4aWekhryMF9T/AA8tlO7qIQBtNB1hw9eZiMaCtWehp
         NP9xE+AKDsGD4cGULtD0L9N0c8LOOgQdXmzhJN3iG4OthKEQviuL4dbfuL0peRTzS/kQ
         /sXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4ZXxLGpYkNLGcR4LovdInInPDGQW3TFLwetgUaPjssQ=;
        b=rVtWJxNwqy59Tk1cfvCNq42HvX/ShkfJkt1psBgGQTn2hrZqoOUP4tDUpnyGSsdd7Y
         eSEQuPnhEQg9xYtTuQneTbaLaJ2jDfP/m5ZdIvN8swgYl6GAkXWVpOOlFRfc5NTE0O38
         +gm5rnboD15wfjJ48t8S3Q7CUNBEV0ycW1XpEyhOZF9bRC5e8n93Tm+h43WA/nXSSk7V
         u4MEMVI+urXmpODuFheO9d55dXrcaqe54B8DmfMTOTNe7/wuEfQAF1LPUMel6BATx9hx
         ToTtGD0s7NFFgxn708GpQ7pBoD0RZRZpiY+nIs5lPW6G5tRWn6BwRikNMspJiHP0aMwd
         /0GQ==
X-Gm-Message-State: AFqh2kpxOLC67vghF6AWXU6CJa3LzeUPKQUHPBC/sldEvkBZSOFEqchG
        6WbEn40NOKcMLjCMAX92IrZLvA==
X-Google-Smtp-Source: AMrXdXuJqlJ4BwrQ3seyihhYisO1FkL14aPwdjEO4WMMh2NxbebSR2QVLZrzjMCciL5WxhDFqYKvRA==
X-Received: by 2002:a17:906:774f:b0:870:94e:13f9 with SMTP id o15-20020a170906774f00b00870094e13f9mr35455819ejn.0.1674676268196;
        Wed, 25 Jan 2023 11:51:08 -0800 (PST)
Received: from blmsp.fritz.box ([2001:4091:a247:815f:ef74:e427:628a:752c])
        by smtp.gmail.com with ESMTPSA id s15-20020a170906454f00b00872c0bccab2sm2778830ejq.35.2023.01.25.11.51.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Jan 2023 11:51:07 -0800 (PST)
From:   Markus Schneider-Pargmann <msp@baylibre.com>
To:     Marc Kleine-Budde <mkl@pengutronix.de>,
        Chandrasekar Ramakrishnan <rcsekar@samsung.com>,
        Wolfgang Grandegger <wg@grandegger.com>
Cc:     Vincent MAILHOL <mailhol.vincent@wanadoo.fr>,
        linux-can@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Markus Schneider-Pargmann <msp@baylibre.com>
Subject: [PATCH v2 04/18] can: m_can: Always acknowledge all interrupts
Date:   Wed, 25 Jan 2023 20:50:45 +0100
Message-Id: <20230125195059.630377-5-msp@baylibre.com>
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

The code already exits the function on !ir before this condition. No
need to check again if anything is set as IR_ALL_INT is 0xffffffff.

Signed-off-by: Markus Schneider-Pargmann <msp@baylibre.com>
---
 drivers/net/can/m_can/m_can.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/net/can/m_can/m_can.c b/drivers/net/can/m_can/m_can.c
index 33abe938c30b..2df39dfa309b 100644
--- a/drivers/net/can/m_can/m_can.c
+++ b/drivers/net/can/m_can/m_can.c
@@ -1083,8 +1083,7 @@ static irqreturn_t m_can_isr(int irq, void *dev_id)
 		return IRQ_NONE;
 
 	/* ACK all irqs */
-	if (ir & IR_ALL_INT)
-		m_can_write(cdev, M_CAN_IR, ir);
+	m_can_write(cdev, M_CAN_IR, ir);
 
 	if (cdev->ops->clear_interrupts)
 		cdev->ops->clear_interrupts(cdev);
-- 
2.39.0

