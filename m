Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C25C25823F7
	for <lists+linux-can@lfdr.de>; Wed, 27 Jul 2022 12:17:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231422AbiG0KRL (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Wed, 27 Jul 2022 06:17:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231466AbiG0KRJ (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Wed, 27 Jul 2022 06:17:09 -0400
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00D3642ADA
        for <linux-can@vger.kernel.org>; Wed, 27 Jul 2022 03:17:09 -0700 (PDT)
Received: by mail-pf1-x42c.google.com with SMTP id w205so12373216pfc.8
        for <linux-can@vger.kernel.org>; Wed, 27 Jul 2022 03:17:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=bzgyOo7BH7tFdrdKL3b8igSvwmrl7qlaltWraaOdaBw=;
        b=VAT28tTo++PXwyq8fw52qMxiEdzcQX6vihvDlrgTY6X9hfFOdKg7cYATuE1VFw2e4Y
         29+sAjcMfd8tuQEo2tUPcABKFQPRNb/FhjbxrqadRmDmwkK6M1ys0mkmkdY28rujyuUY
         QzpF9EN1/zBPVHQDRgKCARa9/+mh9rqfBmZEYsCbHDwBEAZ+t3JMGg8GLGddr5HSo5Ob
         n6ZbQ1YL5JAMRd5AWREde7J51yD1Z/+jOFvq06bC4HeXMegxVcz+Cs8AWj7U8x+/7UEt
         durGTnxI6Ua3avVgwTv5Z5NN1R/+jqFIOoKRq57qbWLW2MajScE3X9COpwFj2nRSTVor
         1PuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=bzgyOo7BH7tFdrdKL3b8igSvwmrl7qlaltWraaOdaBw=;
        b=vu8lR/SPkx/6orxAyCDDIWrBQqSbiaZKRFHSM3hIQVjEkujKomeqxrtheOPYW3JKK1
         sqmdiOLuaLwRaFw/+soIIFgsd/93wLYMTYN0rKPz5UqtVlqiwe32l71qlfkJ9Az0vWDT
         q5TVu8TocZN293yUm1Hp1LnuKkvMdS/wzms2sAJe4aVpWC58zPWGNbzsqFoX9zF59G63
         rVUTAWc265qzd7JQnQOgBvYG5ZhVInggoIYSx/dzyq3wvGFhZ2Rtqm6xZHnhssKm4UJb
         sRneIhEixUV17dtd5NhOi5G2anmqXjmG6OrWgaT0hcxD7E6uTjY6GNjD6GlAxbdnP3tH
         iGbA==
X-Gm-Message-State: AJIora+UXMGMqhdzXYItkX8fDla4tyAnBKSMeEFzxAQ7Xor7SbS4QCM2
        uWExGdHUNbNc7MGNqn+1CyBYAgSI1Xwu1w==
X-Google-Smtp-Source: AGRyM1uiBjh3wRpTu1PQnktKO6LC1IgXjj5Bg1vXlImeSUNAAQw79odQ7UQ7csjHhvWk6sSkJWXQ2w==
X-Received: by 2002:a63:f5b:0:b0:41a:f5f9:7d1d with SMTP id 27-20020a630f5b000000b0041af5f97d1dmr11854555pgp.570.1658917023484;
        Wed, 27 Jul 2022 03:17:03 -0700 (PDT)
Received: from localhost.localdomain (124x33x176x97.ap124.ftth.ucom.ne.jp. [124.33.176.97])
        by smtp.gmail.com with ESMTPSA id w22-20020aa79556000000b005284e98304csm13260666pfq.205.2022.07.27.03.17.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Jul 2022 03:17:03 -0700 (PDT)
Sender: Vincent Mailhol <vincent.mailhol@gmail.com>
From:   Vincent Mailhol <mailhol.vincent@wanadoo.fr>
To:     linux-can@vger.kernel.org, Marc Kleine-Budde <mkl@pengutronix.de>
Cc:     Stephane Grosjean <s.grosjean@peak-system.com>,
        Jimmy Assarsson <extja@kvaser.com>,
        Oliver Hartkopp <socketcan@hartkopp.net>,
        Dario Binacchi <dario.binacchi@amarulasolutions.com>,
        Max Staudt <max@enpas.org>,
        Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Subject: [PATCH v4 01/14] can: can327: add software tx timestamps
Date:   Wed, 27 Jul 2022 19:16:28 +0900
Message-Id: <20220727101641.198847-2-mailhol.vincent@wanadoo.fr>
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
modules in [1]. However, can327 does not rely on that function and as
such does not offer TX timestamping.

Add a call to skb_tx_timestamp() in the can327_netdev_start_xmit()
function so that the module now supports TX software timestamps.

[1] commit 741b91f1b0ea ("can: dev: can_put_echo_skb(): add software
tx timestamps")
Link: https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=741b91f1b0ea34f00f6a7d4539b767c409291fcf

Signed-off-by: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
---
 drivers/net/can/can327.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/can/can327.c b/drivers/net/can/can327.c
index 5da7778d92dc..88718d0cc569 100644
--- a/drivers/net/can/can327.c
+++ b/drivers/net/can/can327.c
@@ -836,6 +836,8 @@ static netdev_tx_t can327_netdev_start_xmit(struct sk_buff *skb,
 	dev->stats.tx_packets++;
 	dev->stats.tx_bytes += frame->can_id & CAN_RTR_FLAG ? 0 : frame->len;
 
+	skb_tx_timestamp(skb);
+
 out:
 	kfree_skb(skb);
 	return NETDEV_TX_OK;
-- 
2.35.1

