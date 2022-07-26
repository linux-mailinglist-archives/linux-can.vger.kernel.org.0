Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD6D0580EE8
	for <lists+linux-can@lfdr.de>; Tue, 26 Jul 2022 10:27:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237844AbiGZI13 (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Tue, 26 Jul 2022 04:27:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238139AbiGZI12 (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 26 Jul 2022 04:27:28 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12C1A2FFEB
        for <linux-can@vger.kernel.org>; Tue, 26 Jul 2022 01:27:27 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id o20-20020a17090aac1400b001f2da729979so3010814pjq.0
        for <linux-can@vger.kernel.org>; Tue, 26 Jul 2022 01:27:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=MuVq2p7SpFcxsu+6IJW8ewgsmSAq6MKIl//zy/itb4k=;
        b=cvPB9DgzujzEvYe+pmD5S7E9eGXsf3tX03yfLAVt6+MNGrT0eEVmatxqZt/1mWkhEa
         824F76J372D74/bCbKwXwMt3elQEPIW3d7Pv5NynG+4aDcEweNezE0wbCNvHOOX3085Q
         njvUDxbYj9hKGI0hW1vDP2QFLG4VlABas39y1Qx2fEOSPoAOdMckZ+9wM1Pn1JXOdGbK
         nGs1KLfECYRzI93ROq8p+AZoZSo4PF8KY136xqMlJAu7G1QNWIQHQben+I16gxKzEcx1
         BkdA9AD1mTs9+C6ffZRpIYXnqLGXHfIqHAW+AN1a9SxPTWZ0G1rC9i14TvwHnVXksTSb
         zsBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=MuVq2p7SpFcxsu+6IJW8ewgsmSAq6MKIl//zy/itb4k=;
        b=NzRIDPNnLI/4QEYqSrARV1IICpMMYYSoB39+iqzjW/pjXSe3HX/AScaNCEv10ANOFR
         D+ljZ6Sm4RokxsUWpo3yOkJ6v07A7kfnTgR4r9cPLgPSSBslGe5SM1JaQ8rm2zcUYPcp
         4z6yHDfqpeo52Fq0m0ySGyJ3Gz/0FmM0RDS7oKd1BBQTqHaeSkPo87wCQO4rAj+K714g
         WaRdyUDefExAKRkXvIoTFLO52H2y/4/cxvP4zGPLisqjPL22PvijDlRs2FYcjpoZYy7a
         jxVtWp8/+DIL3v088uOaZwrto34XXPp1XvBXFn6MB2vWJwO5OwpwrEzdmvvBPcok621d
         8fpA==
X-Gm-Message-State: AJIora8ZS35MGN1OEpT1j9a7LW9chtZchD33mu9ui0fvVn54l8eyfFzR
        SEfwxx40n+pcATxB0QlWHzLQGr8Eay6ViA==
X-Google-Smtp-Source: AGRyM1sseJW/0Z495ESc7o1ePTTSMRk68bQutoHEeXbzf2vQUuvTxX3fpI/m7gJrDCmpCOJr64sflg==
X-Received: by 2002:a17:90b:350b:b0:1f0:23d9:57eb with SMTP id ls11-20020a17090b350b00b001f023d957ebmr35195371pjb.17.1658824046525;
        Tue, 26 Jul 2022 01:27:26 -0700 (PDT)
Received: from localhost.localdomain (124x33x176x97.ap124.ftth.ucom.ne.jp. [124.33.176.97])
        by smtp.gmail.com with ESMTPSA id t17-20020a170902e1d100b0016bf10203d9sm10689751pla.144.2022.07.26.01.27.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Jul 2022 01:27:26 -0700 (PDT)
Sender: Vincent Mailhol <vincent.mailhol@gmail.com>
From:   Vincent Mailhol <mailhol.vincent@wanadoo.fr>
To:     linux-can@vger.kernel.org, Marc Kleine-Budde <mkl@pengutronix.de>
Cc:     Dario Binacchi <dario.binacchi@amarulasolutions.com>,
        Max Staudt <max@enpas.org>,
        Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Subject: [PATCH v2 04/10] can: softing: use KBUILD_MODNAME instead of hard coded names
Date:   Tue, 26 Jul 2022 17:27:01 +0900
Message-Id: <20220726082707.58758-5-mailhol.vincent@wanadoo.fr>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220726082707.58758-1-mailhol.vincent@wanadoo.fr>
References: <20220725153124.467061-1-mailhol.vincent@wanadoo.fr>
 <20220726082707.58758-1-mailhol.vincent@wanadoo.fr>
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
and can_bittiming_const::name. KBUILD_MODNAME also evaluates to
"softing". Use KBUILD_MODNAME and get rid on the hardcoded string
names.

Signed-off-by: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
---
 drivers/net/can/softing/softing_main.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/can/softing/softing_main.c b/drivers/net/can/softing/softing_main.c
index 8d27ac66ca7f..8cca6f07e7c3 100644
--- a/drivers/net/can/softing/softing_main.c
+++ b/drivers/net/can/softing/softing_main.c
@@ -612,7 +612,7 @@ static const struct net_device_ops softing_netdev_ops = {
 };
 
 static const struct can_bittiming_const softing_btr_const = {
-	.name = "softing",
+	.name = KBUILD_MODNAME,
 	.tseg1_min = 1,
 	.tseg1_max = 16,
 	.tseg2_min = 1,
@@ -846,7 +846,7 @@ static int softing_pdev_probe(struct platform_device *pdev)
 
 static struct platform_driver softing_driver = {
 	.driver = {
-		.name = "softing",
+		.name = KBUILD_MODNAME,
 	},
 	.probe = softing_pdev_probe,
 	.remove = softing_pdev_remove,
-- 
2.35.1

