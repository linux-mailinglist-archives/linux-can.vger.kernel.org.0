Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F02E75823FB
	for <lists+linux-can@lfdr.de>; Wed, 27 Jul 2022 12:17:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231421AbiG0KRU (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Wed, 27 Jul 2022 06:17:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231523AbiG0KRR (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Wed, 27 Jul 2022 06:17:17 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AA3A42ADA
        for <linux-can@vger.kernel.org>; Wed, 27 Jul 2022 03:17:16 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id o20-20020a17090aac1400b001f2da729979so1749470pjq.0
        for <linux-can@vger.kernel.org>; Wed, 27 Jul 2022 03:17:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=AxjWx6wqgIco2TQFNPCVmq77ltivpPoWUErAafGdsR0=;
        b=N+ET7BP8DTjGhPKJHfKk7ceoqVpsQRHKDZ7DsJofZwQ7WL1dS2PyW8T7kLG+9iIXrb
         3ysvcdcCuoUQT//On41cvCnj7RpEwJR57p6DGTaz/7tAaBM5whdlyNpBraQN9P7MTai+
         YPhBZgZUdQDWfyiekl0eQmt/9RQaCU9n0d1wYLNYMkmtk4XMYVsWDu6Ajw7UyFcBfaaG
         RcW4fkhB2esq9bD9F9r0wP+AgEDeqN9wGBm8bRu8MpSFsP4JL1nRO6Tj0EkA3ZebBvEt
         BLqOJGBIOLeUMS0XTqMrh1GdTB1NGWf6IIAn695+nZTzW2rSga0wclBoyoBw/G70SiOX
         AQWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=AxjWx6wqgIco2TQFNPCVmq77ltivpPoWUErAafGdsR0=;
        b=iQpWeB8G6ap/+IJ6PmOX1JNzp2e4IyZv2JbEeQkZUXTzMOHDi8wG9DhvhkWeobQMOL
         n3TRFQp3elS3Q4j7OMPVK3Qtl0TRnpnXcBGINphz3yhIkUoZJ+Tv3MzDt85GPjZflnN6
         g12EyoJMVlJmQfS8TrxLlIcH6PD+ToPDufa7avSgmnE9LTuDyjqZYCmF2rWz1V3aC/GZ
         xYrTIhbJSiG6IWsbZ/T0xrLCs1c8OrUp2oHgwZ+X6VqXlrrLsYDLQDibazN8nygryrDe
         YOWQ78SmNA8UrZmq+pTrEY/V6BvM0rfoH6qlhXcVgwz0Jfv2wxUeSYFZP7DlYk3JZ9Hn
         /Y8w==
X-Gm-Message-State: AJIora8P79JdV61F2LbsF5lmJtnOQwPVch4gKAT8U1ZCowexFKo04Oxj
        vwi2WSsXqLnftgHApsQGlxA6cbkq33Hbng==
X-Google-Smtp-Source: AGRyM1t/c/3XGThwx0KNcEMPCGs0YKRsWd68Evq8Zz61++imQhr1WVeA/60tF55qBTWE3uUtJLdPtw==
X-Received: by 2002:a17:902:db04:b0:16d:82e7:72c2 with SMTP id m4-20020a170902db0400b0016d82e772c2mr11472137plx.100.1658917035785;
        Wed, 27 Jul 2022 03:17:15 -0700 (PDT)
Received: from localhost.localdomain (124x33x176x97.ap124.ftth.ucom.ne.jp. [124.33.176.97])
        by smtp.gmail.com with ESMTPSA id w22-20020aa79556000000b005284e98304csm13260666pfq.205.2022.07.27.03.17.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Jul 2022 03:17:15 -0700 (PDT)
Sender: Vincent Mailhol <vincent.mailhol@gmail.com>
From:   Vincent Mailhol <mailhol.vincent@wanadoo.fr>
To:     linux-can@vger.kernel.org, Marc Kleine-Budde <mkl@pengutronix.de>
Cc:     Stephane Grosjean <s.grosjean@peak-system.com>,
        Jimmy Assarsson <extja@kvaser.com>,
        Oliver Hartkopp <socketcan@hartkopp.net>,
        Dario Binacchi <dario.binacchi@amarulasolutions.com>,
        Max Staudt <max@enpas.org>,
        Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Subject: [PATCH v4 06/14] can: dev: add hardware TX timestamp
Date:   Wed, 27 Jul 2022 19:16:33 +0900
Message-Id: <20220727101641.198847-7-mailhol.vincent@wanadoo.fr>
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

Because of the loopback feature of socket CAN, hardware TX timestamps
are nothing else than the hardware RX timespamp of the corresponding
loopback packet. This patch simply reuses the hardware RX timestamp.

The rationale to clone this timestamp value is that existing tools
which rely of libpcap (such as tcpdump) expect support for both TX and
RX hardware timestamps in order to activate the feature (i.e. no
granular control to activate either of TX or RX hardware timestamps).

Signed-off-by: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
---
 drivers/net/can/dev/skb.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/net/can/dev/skb.c b/drivers/net/can/dev/skb.c
index 8bb62dd864c8..07e0feac8629 100644
--- a/drivers/net/can/dev/skb.c
+++ b/drivers/net/can/dev/skb.c
@@ -72,6 +72,9 @@ int can_put_echo_skb(struct sk_buff *skb, struct net_device *dev,
 		/* save frame_len to reuse it when transmission is completed */
 		can_skb_prv(skb)->frame_len = frame_len;
 
+		if (skb_shinfo(skb)->tx_flags & SKBTX_HW_TSTAMP)
+			skb_shinfo(skb)->tx_flags |= SKBTX_IN_PROGRESS;
+
 		skb_tx_timestamp(skb);
 
 		/* save this skb for tx interrupt echo handling */
@@ -107,6 +110,9 @@ __can_get_echo_skb(struct net_device *dev, unsigned int idx, u8 *len_ptr,
 		struct can_skb_priv *can_skb_priv = can_skb_prv(skb);
 		struct canfd_frame *cf = (struct canfd_frame *)skb->data;
 
+		if (skb_shinfo(skb)->tx_flags & SKBTX_IN_PROGRESS)
+			skb_tstamp_tx(skb, skb_hwtstamps(skb));
+
 		/* get the real payload length for netdev statistics */
 		if (cf->can_id & CAN_RTR_FLAG)
 			*len_ptr = 0;
-- 
2.35.1

