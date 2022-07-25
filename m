Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F05F25801EA
	for <lists+linux-can@lfdr.de>; Mon, 25 Jul 2022 17:32:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234317AbiGYPcO (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Mon, 25 Jul 2022 11:32:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232032AbiGYPcM (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Mon, 25 Jul 2022 11:32:12 -0400
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B97B60D2
        for <linux-can@vger.kernel.org>; Mon, 25 Jul 2022 08:32:11 -0700 (PDT)
Received: by mail-pf1-x432.google.com with SMTP id b133so10762966pfb.6
        for <linux-can@vger.kernel.org>; Mon, 25 Jul 2022 08:32:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=lMdXzctjvecUvKvq+1rYZTs1jbZCEiaVtYgz0V7ZnDM=;
        b=jh79zvIVuNb9ElpiK0auRTF0l7bdDA5Tjr1Nfq0YwikJ35nqzG0aVC3Gl9FZnljcrM
         aVP+GepRC0jjkc+JFySqaUTwd5LV4gG4TldB/f+LL9mGyxFNZQ3Ctp2GE7QtOWmLs0Ii
         unL/3ZlkdqTpcQ7LvzNlRt3uST3M0DHZvFCFtmZQt0/OAHx/u06CczHUYiI7GsGSJWoQ
         oFIgMSSKhNZdHS7ZVvle+LTydo8YYvU74lBfazdcjAYZJ4QVXkm1yb6R8/1U6vL7+l0K
         7O2s9Z/X6/AQ59XP1MgM5iGRWHBaLiTdK6Wh91uT1eIeYvfL65uYHta9tYslzsWsvrnl
         fNsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=lMdXzctjvecUvKvq+1rYZTs1jbZCEiaVtYgz0V7ZnDM=;
        b=YrYMugdgYWa3P8b/YmU0YZC/tjUUXxo/RVsdopVs8vNsQBQCxHUZirDHL+SXbrKOez
         +p0jelRV71UK/SiwHJqF9Sy5iOzuXiP99CV0dWg2aswd7XV4d9oVH3iR2h2ps5WdAi3p
         JdU+llxvSWqL+MmJ2rVv8/7SCCBZgxyF1igu4IBbLPJ5zfDZbGV0JOvIt0K7N8m0OXs8
         f4xUPkROl0ZgBEe4kFKKp4tiPrBpa8k1xAGA6C1B8IeWRZNIED+nM16JjYl0tyup6O1K
         mzEBvMw+vemQEIy0PbEig04qjho8YOtOpwsABR3BQLvJAhkcqKITSzzOUTk45UCMl6pd
         TfPw==
X-Gm-Message-State: AJIora+BX/EKax2dlm0Fs+tCR9MZryoBUy+/6bCWi0Z2pfvT0X3AmWnW
        36LMOvVcsiajELKAisGFvca+oJu6BWFuvQ==
X-Google-Smtp-Source: AGRyM1syQbzo+xPDDXmB2B2OQMBGNg/6eZvJPUcxaR8vr5U5+AqbZxLoAoxnCcvBluTAJ9RF+k23bQ==
X-Received: by 2002:a63:4608:0:b0:41a:617f:e194 with SMTP id t8-20020a634608000000b0041a617fe194mr11767633pga.152.1658763130883;
        Mon, 25 Jul 2022 08:32:10 -0700 (PDT)
Received: from localhost.localdomain (124x33x176x97.ap124.ftth.ucom.ne.jp. [124.33.176.97])
        by smtp.gmail.com with ESMTPSA id m1-20020a62a201000000b005289ef6db79sm9745477pff.32.2022.07.25.08.32.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Jul 2022 08:32:10 -0700 (PDT)
Sender: Vincent Mailhol <vincent.mailhol@gmail.com>
From:   Vincent Mailhol <mailhol.vincent@wanadoo.fr>
To:     linux-can@vger.kernel.org, Marc Kleine-Budde <mkl@pengutronix.de>
Cc:     Dario Binacchi <dario.binacchi@amarulasolutions.com>,
        Max Staudt <max@enpas.org>,
        Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Subject: [PATCH 4/9] can: softing: add DRV_NAME to replace hardcoded names
Date:   Tue, 26 Jul 2022 00:31:19 +0900
Message-Id: <20220725153124.467061-5-mailhol.vincent@wanadoo.fr>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220725153124.467061-1-mailhol.vincent@wanadoo.fr>
References: <20220725153124.467061-1-mailhol.vincent@wanadoo.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

The driver uses the string "softing" to populate platform_driver::name
and can_bittiming_const::name. Add a new macro DRV_NAME which
evaluates to "ems_ubs" and then use DRV_NAME and to get rid on the
hardcoded string names.

Signed-off-by: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
---
 drivers/net/can/softing/softing_main.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/net/can/softing/softing_main.c b/drivers/net/can/softing/softing_main.c
index 8d27ac66ca7f..d810fe6915a4 100644
--- a/drivers/net/can/softing/softing_main.c
+++ b/drivers/net/can/softing/softing_main.c
@@ -11,6 +11,7 @@
 
 #include "softing.h"
 
+#define DRV_NAME "softing"
 #define TX_ECHO_SKB_MAX (((TXMAX+1)/2)-1)
 
 /*
@@ -612,7 +613,7 @@ static const struct net_device_ops softing_netdev_ops = {
 };
 
 static const struct can_bittiming_const softing_btr_const = {
-	.name = "softing",
+	.name = DRV_NAME,
 	.tseg1_min = 1,
 	.tseg1_max = 16,
 	.tseg2_min = 1,
@@ -846,7 +847,7 @@ static int softing_pdev_probe(struct platform_device *pdev)
 
 static struct platform_driver softing_driver = {
 	.driver = {
-		.name = "softing",
+		.name = DRV_NAME,
 	},
 	.probe = softing_pdev_probe,
 	.remove = softing_pdev_remove,
-- 
2.35.1

