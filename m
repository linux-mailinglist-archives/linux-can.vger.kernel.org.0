Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F2DDB581114
	for <lists+linux-can@lfdr.de>; Tue, 26 Jul 2022 12:25:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233207AbiGZKZe (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Tue, 26 Jul 2022 06:25:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233191AbiGZKZc (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 26 Jul 2022 06:25:32 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28B0E3244E
        for <linux-can@vger.kernel.org>; Tue, 26 Jul 2022 03:25:29 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id o5-20020a17090a3d4500b001ef76490983so12822250pjf.2
        for <linux-can@vger.kernel.org>; Tue, 26 Jul 2022 03:25:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=mUfBhfopMVBb3MFwSEXJ1qSIyFCctmXAqcvt99jbLEk=;
        b=UFHk4eoMyR4lQw9cy4BGUnIN9HmiE9YTzriMrh5q/aQTBGnwcTvVqS1dqvH1Qz/RDC
         hE2IYZfwj6fmxiZV5XaJikEbxeUya6vWi9kB9FnGNXIx5iXX5/37erkAMbHodGrN+HvY
         sOrFN6zYojOAWF8ekI8kMKd1jNypQdxvsEGzYJVtdnv8pq6Y421z50AuaxuJ9QWowJFW
         +yG8mGeYXnZMUuvNalcui8x0woqznUgZjqlGbb8StJaDBMRjIOuVu0AjumWI/clB9BX8
         UTZOQFrDZug0hMNNce8KenKL9dyCRcbpuMlW2znhNyElIxiOqa1caCf3qir7X6gJjXiA
         YDyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=mUfBhfopMVBb3MFwSEXJ1qSIyFCctmXAqcvt99jbLEk=;
        b=E7LKRSWkwItZIGZ2EgjQ9j1NnmmSS8aUZD3HTYWpNv458mX5Kjv18EsT2Vj8I/NRI6
         bT5U0XXzyEW+fdr+hz72NJ2UAZkPKQ1Eh93CmL7LRjEA6yjjZmz8b7py1zrVTYHllsud
         tkxGaA8QEnd+p8eNQx67IjeOjZ1IiiNoHsPNUutKlJrf1rBYgeFSFMIo9HdhaVy6Ks1A
         6xc8cMiuoU/nvpoxFcWmHri4T+63IobPPKC4mavgT5MJcO1XbfaiGZQI0auQQvTVBAyZ
         ZGpr1XWpwMRmgS9s3d+3Q3NEtcHuEC9YC4dgDHf0PWVffmMR7aFGbqndrIK3NqnSP0/C
         p+yA==
X-Gm-Message-State: AJIora8oFZq0rfr5f0c9Rp4Yj7cRsk6iilfEMEVd61jYHTdrZml+zoed
        xoCQMvIrnO5vrGHDcvBYSSsJPQV3DEG3GA==
X-Google-Smtp-Source: AGRyM1va+RWDFAz8AhstBy2/+xdLOdXyp1He/MfthieO5aGfz9mExYPFY9KErGDMQjQTu0QCZMHSgg==
X-Received: by 2002:a17:903:41cd:b0:16d:2f11:cf18 with SMTP id u13-20020a17090341cd00b0016d2f11cf18mr13784657ple.62.1658831128339;
        Tue, 26 Jul 2022 03:25:28 -0700 (PDT)
Received: from localhost.localdomain (124x33x176x97.ap124.ftth.ucom.ne.jp. [124.33.176.97])
        by smtp.gmail.com with ESMTPSA id y6-20020a655b46000000b00411bbcdfbf7sm9869894pgr.87.2022.07.26.03.25.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Jul 2022 03:25:27 -0700 (PDT)
Sender: Vincent Mailhol <vincent.mailhol@gmail.com>
From:   Vincent Mailhol <mailhol.vincent@wanadoo.fr>
To:     linux-can@vger.kernel.org, Marc Kleine-Budde <mkl@pengutronix.de>
Cc:     Stephane Grosjean <s.grosjean@peak-system.com>,
        Jimmy Assarsson <extja@kvaser.com>,
        Oliver Hartkopp <socketcan@hartkopp.net>,
        Dario Binacchi <dario.binacchi@amarulasolutions.com>,
        Max Staudt <max@enpas.org>,
        Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Subject: [PATCH v3 03/14] can: slcan: add software tx timestamps
Date:   Tue, 26 Jul 2022 19:24:43 +0900
Message-Id: <20220726102454.95096-4-mailhol.vincent@wanadoo.fr>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220726102454.95096-1-mailhol.vincent@wanadoo.fr>
References: <20220725133208.432176-1-mailhol.vincent@wanadoo.fr>
 <20220726102454.95096-1-mailhol.vincent@wanadoo.fr>
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
modules in [1]. However, slcan does not rely on that function and as
such does not offer TX timestamping.

Add a call to skb_tx_timestamp() in the slc_xmit() function so that
the module now supports TX software timestamps.

[1] commit 741b91f1b0ea ("can: dev: can_put_echo_skb(): add software
tx timestamps")
Link: https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=741b91f1b0ea34f00f6a7d4539b767c409291fcf

CC: Dario Binacchi <dario.binacchi@amarulasolutions.com>
Signed-off-by: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
---
 drivers/net/can/slcan/slcan-core.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/can/slcan/slcan-core.c b/drivers/net/can/slcan/slcan-core.c
index dc28e715bbe1..d4dbeb849432 100644
--- a/drivers/net/can/slcan/slcan-core.c
+++ b/drivers/net/can/slcan/slcan-core.c
@@ -626,6 +626,8 @@ static netdev_tx_t slc_xmit(struct sk_buff *skb, struct net_device *dev)
 	slc_encaps(sl, (struct can_frame *)skb->data); /* encaps & send */
 	spin_unlock(&sl->lock);
 
+	skb_tx_timestamp(skb);
+
 out:
 	kfree_skb(skb);
 	return NETDEV_TX_OK;
-- 
2.35.1

