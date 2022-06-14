Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7AA9054B12B
	for <lists+linux-can@lfdr.de>; Tue, 14 Jun 2022 14:38:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235874AbiFNMbR (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Tue, 14 Jun 2022 08:31:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243230AbiFNM2h (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 14 Jun 2022 08:28:37 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3647938199
        for <linux-can@vger.kernel.org>; Tue, 14 Jun 2022 05:28:29 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id kq6so16809541ejb.11
        for <linux-can@vger.kernel.org>; Tue, 14 Jun 2022 05:28:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=bs1pDxoqSwxHo6PhPuLte63s3qeUlbVxYb0CgUg+DU4=;
        b=c010hK3+ahAHRLBDp/YkH7ue/xhQVFHLKxwyUX7pT4nvITXGSPVRQWGtNe4e8BJlHw
         ShM/jdfA3dXz598QFtXn7PbLhrOdrk2wdQNOIpY9KXOhlDj4q93DryPdDogflmTdjgcy
         m2S75F2hujDTdCnjubcb0QdWgXbpIRBVFb6Cc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=bs1pDxoqSwxHo6PhPuLte63s3qeUlbVxYb0CgUg+DU4=;
        b=4jX7Gmsc+8DSixYj/wPOUSJ/EGqvEaMg9zzPjBVFrfo2zunMYQh/tadx9yalxjTI8Y
         qOUpBn0wSKH/6iPad8tq4Y11Lgu6q8XqPgepcZ+l+PWWJcr7BX6UevJ0wSlOO0UW7Y/x
         gGRyEOJZV5UabukZhmdxZrQSzNDNog3ikcwcrNqhTA5I9nInl9BtY7iu+PYbYgVHOTeA
         J30BywCfYlxxqsqPsYoheZUkL8hM//lfjwBv588voNUqlGqqqELqOSp8kSaq2rRAoS3V
         hHt0464SF46hTwDBAa/smWZ97u02gBsqlI1ZnyHfvvICMrFTwsnMTB13r+mm6vkYdJ+U
         QoaQ==
X-Gm-Message-State: AOAM531CR/HmSMGposamvOcOcuIZPjs7aq7FnxXG6D/kXJJ/hzs9NPff
        1M+1CEmV+uFAWd2Ldp2VxxH9fw==
X-Google-Smtp-Source: ABdhPJyxoOzRWB1wnGAo214wBBP18qanXSZdV8l0hMrYApMdvZlin/orDEjVUZjgRmC43b03fTLNHg==
X-Received: by 2002:a17:907:1c07:b0:711:c966:f02e with SMTP id nc7-20020a1709071c0700b00711c966f02emr4194683ejc.221.1655209707627;
        Tue, 14 Jun 2022 05:28:27 -0700 (PDT)
Received: from dario-ThinkPad-T14s-Gen-2i.amarulasolutions.com (host-80-116-90-174.pool80116.interbusiness.it. [80.116.90.174])
        by smtp.gmail.com with ESMTPSA id z22-20020a17090655d600b006f3ef214e2csm5087043ejp.146.2022.06.14.05.28.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jun 2022 05:28:27 -0700 (PDT)
From:   Dario Binacchi <dario.binacchi@amarulasolutions.com>
To:     linux-kernel@vger.kernel.org
Cc:     Amarula patchwork <linux-amarula@amarulasolutions.com>,
        Oliver Hartkopp <socketcan@hartkopp.net>,
        michael@amarulasolutions.com,
        Dario Binacchi <dario.binacchi@amarulasolutions.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Marc Kleine-Budde <mkl@pengutronix.de>,
        Paolo Abeni <pabeni@redhat.com>,
        Wolfgang Grandegger <wg@grandegger.com>,
        linux-can@vger.kernel.org, netdev@vger.kernel.org
Subject: [PATCH v4 01/12] can: slcan: use the BIT() helper
Date:   Tue, 14 Jun 2022 14:28:10 +0200
Message-Id: <20220614122821.3646071-2-dario.binacchi@amarulasolutions.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220614122821.3646071-1-dario.binacchi@amarulasolutions.com>
References: <20220614122821.3646071-1-dario.binacchi@amarulasolutions.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Use the BIT() helper instead of an explicit shift.

Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>
---

(no changes since v1)

 drivers/net/can/slcan.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/can/slcan.c b/drivers/net/can/slcan.c
index 64a3aee8a7da..b37d35c2a23a 100644
--- a/drivers/net/can/slcan.c
+++ b/drivers/net/can/slcan.c
@@ -413,7 +413,7 @@ static int slc_open(struct net_device *dev)
 	if (sl->tty == NULL)
 		return -ENODEV;
 
-	sl->flags &= (1 << SLF_INUSE);
+	sl->flags &= BIT(SLF_INUSE);
 	netif_start_queue(dev);
 	return 0;
 }
-- 
2.32.0

