Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 00BF557FFDE
	for <lists+linux-can@lfdr.de>; Mon, 25 Jul 2022 15:32:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234594AbiGYNcm (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Mon, 25 Jul 2022 09:32:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235381AbiGYNck (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Mon, 25 Jul 2022 09:32:40 -0400
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC482E039
        for <linux-can@vger.kernel.org>; Mon, 25 Jul 2022 06:32:37 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id g17so10420560plh.2
        for <linux-can@vger.kernel.org>; Mon, 25 Jul 2022 06:32:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=lMdXzctjvecUvKvq+1rYZTs1jbZCEiaVtYgz0V7ZnDM=;
        b=mEj8jW32A3vqZM4xC2vcqDXRZpRwuOHCAo99VqOLpDQky/VGlS7WiCpBrof1NPDkGK
         AmkeIwe7oLKv4ErBkGBCbUtjsKH3CIv8PVqQxHRyn0rV3vy1eNx915wxssrB+hT3eEmQ
         yMh7jKGXSm9sk4GPUhy0Sw+kgeoUlc2PoI31gdney2GzBHFS1jufWCvnq824ykX5KJfi
         1RwNIX5xb3L7lSaW0ibbLOyu/w4yXuQrZDtjqWFWU1Dv5NCQuT7jQ+/QXtqRru6HJC4W
         SZfCaI/j6d5vC9OXNqUwLKkMCXvEJspFNFWXxGum9Uo5Hx1cgCQSkLfy42TOGyRZkPpO
         59jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=lMdXzctjvecUvKvq+1rYZTs1jbZCEiaVtYgz0V7ZnDM=;
        b=DfYn0M1y/zZiSJtU1BvMJ0tI8rwsxQuAIJMKJ3g/30U/h5qHi0QbLgt6ph6+il0fO4
         FKqCt7nlBI5Qfk71DH808yw0cF+7OoBRvu19wpCPs6OEPMrX5ktkrbAyfjpkhRCZRVII
         2uox7KuFITEIMNNnLx9U5ImxGNmkMVYz7Kpt1r2m/dA1aCgiq7kom7/W5ILw6vdR+iGA
         hLuSKizutt7craiRYOFCNOf/Wp48jLC91nvRKV3Z373vYY+S1jRaOlxt3DI0E1Uq5OJA
         W/5UhMUWNnPgwLL0jDBOTgm/Cbmb8zki9xioxedjtgrFMHS/2Q6dF8iTCFWjeSCQKIs0
         GcbA==
X-Gm-Message-State: AJIora8p3dOJH+tZl/ASW5QqASklqoyrIfYbNlokDfKrlttLB5hfKwzr
        Kx7+K9d0UULLoAJuqjBCRR02G6/HAnbkFA==
X-Google-Smtp-Source: AGRyM1u43KLl5upwU4L9vlceAxlQoAG6JTG1+QCYPo3YcRGA+1fqAiF3UBKyOAn7GAeM78aNS3Icgg==
X-Received: by 2002:a17:902:f606:b0:168:ecca:44e with SMTP id n6-20020a170902f60600b00168ecca044emr12401176plg.144.1658755957017;
        Mon, 25 Jul 2022 06:32:37 -0700 (PDT)
Received: from localhost.localdomain (124x33x176x97.ap124.ftth.ucom.ne.jp. [124.33.176.97])
        by smtp.gmail.com with ESMTPSA id i12-20020a170902c94c00b0016c16648213sm9406133pla.20.2022.07.25.06.32.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Jul 2022 06:32:36 -0700 (PDT)
Sender: Vincent Mailhol <vincent.mailhol@gmail.com>
From:   Vincent Mailhol <mailhol.vincent@wanadoo.fr>
To:     linux-can@vger.kernel.org, Marc Kleine-Budde <mkl@pengutronix.de>
Cc:     Stephane Grosjean <s.grosjean@peak-system.com>,
        Jimmy Assarsson <extja@kvaser.com>,
        Oliver Hartkopp <socketcan@hartkopp.net>,
        Dario Binacchi <dario.binacchi@amarulasolutions.com>,
        Max Staudt <max@enpas.org>,
        Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Subject: [PATCH v1 04/24] can: softing: add DRV_NAME to replace hardcoded names
Date:   Mon, 25 Jul 2022 22:31:48 +0900
Message-Id: <20220725133208.432176-5-mailhol.vincent@wanadoo.fr>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220725133208.432176-1-mailhol.vincent@wanadoo.fr>
References: <20220725133208.432176-1-mailhol.vincent@wanadoo.fr>
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

