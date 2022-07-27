Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A846D5823F6
	for <lists+linux-can@lfdr.de>; Wed, 27 Jul 2022 12:17:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231205AbiG0KRJ (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Wed, 27 Jul 2022 06:17:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230179AbiG0KRH (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Wed, 27 Jul 2022 06:17:07 -0400
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD81B220DA
        for <linux-can@vger.kernel.org>; Wed, 27 Jul 2022 03:17:06 -0700 (PDT)
Received: by mail-pg1-x533.google.com with SMTP id bh13so15551696pgb.4
        for <linux-can@vger.kernel.org>; Wed, 27 Jul 2022 03:17:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=oBR2q0qE1t01X0e8u8RxP/CYSHsiBL5TzPp+O6mig+4=;
        b=OfwcJjbLSxdZ6JZy4GqTzjLOrc+Oib8juJUvQpftDUE6/p9s3JxBYRN1rvvLjVdIIS
         wFRaTZXqJwBPSr8fs/BPW4RhoDZO3ACA51qFWUQvc4WdJlZxc5Khfb0XqUsnU9qjpnyF
         FWUFCZmSlCPzjKZSIIe2TdIC5UTZ6R5XUjKDhlqN/7ggUktssE9PxXaAXjAtnGQzYE3l
         DLxKIFkVuh8vVg9F9sdBvbY7Y5kgYBXtkvs8vMHLFzbnl2d50hCVCpSIDnhuvvimefDK
         BLx17fU8gZad2gyN+Yee3eOrdH9R7T/GFZAJ+38ApuaohwCr9kFy12ymKUisVWSPo0Y0
         aJcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=oBR2q0qE1t01X0e8u8RxP/CYSHsiBL5TzPp+O6mig+4=;
        b=Vh7JPUagXVRO0/3g0n5SgL81d6pIZub06ZLO9ON+8II8cX8pHEbpOhkjcahCouKTVZ
         kkFB4hF84pNyz0uu8rO5cwdEv3Gspqu2AimP/Ontj5k0dKcvbpaxnoZziuDlwFLp/igY
         R74ubwLKXKBZN17uBMC5Gnvgva0OXX3nqbv5Rlily6c+55Lfa6oK0Ub82G3DDGyWXMSV
         qJBXA1lRThuMCWLmmwMvmbE+VNOIfwukKYvqP5wNTKP1VrtS/tTowVsNEeoa2n2bWzl1
         dyG9WD1hA26jLlCCqYVoaa137MFVtzG8VQLBvWcxftHPDAU3nuQw0j9gyO5YkbG9VJjI
         Y+Qg==
X-Gm-Message-State: AJIora9hasJWU1jl5VuidVTLajGSxabnPCUNElVUkIfD1AIdeBU/Ih2+
        0lf9E8IAVPDmX2sfRBQLoRMo9i7WAQac1g==
X-Google-Smtp-Source: AGRyM1tqIN3s8AhT3Rv3eG+w5uxVMn6GaXSWF8PikztS9cMCPSHVZfm1dtoH2qtX5PaBb+1zMXWpbA==
X-Received: by 2002:aa7:919a:0:b0:52a:eeef:3e65 with SMTP id x26-20020aa7919a000000b0052aeeef3e65mr21035951pfa.15.1658917025972;
        Wed, 27 Jul 2022 03:17:05 -0700 (PDT)
Received: from localhost.localdomain (124x33x176x97.ap124.ftth.ucom.ne.jp. [124.33.176.97])
        by smtp.gmail.com with ESMTPSA id w22-20020aa79556000000b005284e98304csm13260666pfq.205.2022.07.27.03.17.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Jul 2022 03:17:05 -0700 (PDT)
Sender: Vincent Mailhol <vincent.mailhol@gmail.com>
From:   Vincent Mailhol <mailhol.vincent@wanadoo.fr>
To:     linux-can@vger.kernel.org, Marc Kleine-Budde <mkl@pengutronix.de>
Cc:     Stephane Grosjean <s.grosjean@peak-system.com>,
        Jimmy Assarsson <extja@kvaser.com>,
        Oliver Hartkopp <socketcan@hartkopp.net>,
        Dario Binacchi <dario.binacchi@amarulasolutions.com>,
        Max Staudt <max@enpas.org>,
        Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Subject: [PATCH v4 02/14] can: janz-ican3: add software tx timestamp
Date:   Wed, 27 Jul 2022 19:16:29 +0900
Message-Id: <20220727101641.198847-3-mailhol.vincent@wanadoo.fr>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220727101641.198847-1-mailhol.vincent@wanadoo.fr>
References: <20220725133208.432176-1-mailhol.vincent@wanadoo.fr>
 <20220727101641.198847-1-mailhol.vincent@wanadoo.fr>
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

TX timestamps were added to the can_put_echo_skb() function of can_dev
modules in [1]. However, janz-ican3 does not rely on that function but
instead implements its own echo_skb logic. As such it does not offer
TX timestamping.

Add a call to skb_tx_timestamp() in the ican3_put_echo_skb() function
so that the module now supports TX software timestamps.

[1] commit 741b91f1b0ea ("can: dev: can_put_echo_skb(): add software
tx timestamps")
Link: https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=741b91f1b0ea34f00f6a7d4539b767c409291fcf

Signed-off-by: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
---
 drivers/net/can/janz-ican3.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/can/janz-ican3.c b/drivers/net/can/janz-ican3.c
index ccb5c5405224..78d9190a4220 100644
--- a/drivers/net/can/janz-ican3.c
+++ b/drivers/net/can/janz-ican3.c
@@ -1277,6 +1277,8 @@ static void ican3_put_echo_skb(struct ican3_dev *mod, struct sk_buff *skb)
 	if (!skb)
 		return;
 
+	skb_tx_timestamp(skb);
+
 	/* save this skb for tx interrupt echo handling */
 	skb_queue_tail(&mod->echoq, skb);
 }
-- 
2.35.1

