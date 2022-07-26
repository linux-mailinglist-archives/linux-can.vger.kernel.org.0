Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 98DDA581119
	for <lists+linux-can@lfdr.de>; Tue, 26 Jul 2022 12:25:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232824AbiGZKZj (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Tue, 26 Jul 2022 06:25:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238644AbiGZKZh (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 26 Jul 2022 06:25:37 -0400
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B05D101C2
        for <linux-can@vger.kernel.org>; Tue, 26 Jul 2022 03:25:36 -0700 (PDT)
Received: by mail-pf1-x431.google.com with SMTP id c3so12816905pfb.13
        for <linux-can@vger.kernel.org>; Tue, 26 Jul 2022 03:25:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=AxjWx6wqgIco2TQFNPCVmq77ltivpPoWUErAafGdsR0=;
        b=o4e1FaTAMlsWM0b7fi49/Zj3OjKWRWWXgzWRuafMj3b5BFKbnsSx7Ve+/daK9BSXYB
         iqNS9C8Mx8pYcgJxa4tGcJDiyJb79sF3nhPnZQwip7KD1VXNnztLBChJNe/2LOI7D1i5
         g3+qfsPxYSw6qLMIgioGJpAG8IkF8PIE+fTIzDnhbzk6O2VKnSmcPXI+qgDNQwEKXZi0
         f1Porh6awJJuoJ0rJBVJGwuC1MWgOswTOZu+sNgkbPbke8g3/Dzvv2gMLai+fdgXWpT4
         njPkOEyI1i3hOd4hPUtnEsYjGrHJkFWucwTdU1+IDi38aaWkWnWDpxrPv/Zs80n2niwO
         oOYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=AxjWx6wqgIco2TQFNPCVmq77ltivpPoWUErAafGdsR0=;
        b=qzRe022bZtXT7sOnDwqOaWLbGngc94docL4TCXL2QHKssLUBDe2pkp07RKTeCYCT9g
         UcG02aOIP1xYEM+Qfa8DGW0S8OrF2U0qPEg0PSYeVA7Cqd7nVWMCsJRIGpeE41dX7RXP
         lq2eBrXdS1ZofTpkrmdxynmZ9PNjVNwCxjHTj+BkbKGnqWszhTe6TJX08F4lOzliCPAx
         sSefbWimHh+wLbdD0Db85u9n1u23i780B6+5qI69p/U8G6qHv8IYM2GveNf875RHUGYg
         VKdxkZldM6W9QG9vT8AyGpGalfOWTBHEabHB5uWCRejTElIB7huIAf9tgsr+uvjQOeBo
         Awmw==
X-Gm-Message-State: AJIora80q2ZbPpVuBTEnCNGGGh+dzOfm97ffPfbuqUOFtrzk+bUbhKqs
        z6scYTjeYKcxF9qTwIuTUh1NmlDk+PbAUA==
X-Google-Smtp-Source: AGRyM1uN/1wRMa1KBlblLGUoeGZBDy5boteTzFhYHBxKA5crVFMTbJehxe9JPjPEc29qNmXXTpBG0A==
X-Received: by 2002:a63:b05:0:b0:41a:58f:f2ba with SMTP id 5-20020a630b05000000b0041a058ff2bamr14027859pgl.543.1658831135696;
        Tue, 26 Jul 2022 03:25:35 -0700 (PDT)
Received: from localhost.localdomain (124x33x176x97.ap124.ftth.ucom.ne.jp. [124.33.176.97])
        by smtp.gmail.com with ESMTPSA id y6-20020a655b46000000b00411bbcdfbf7sm9869894pgr.87.2022.07.26.03.25.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Jul 2022 03:25:35 -0700 (PDT)
Sender: Vincent Mailhol <vincent.mailhol@gmail.com>
From:   Vincent Mailhol <mailhol.vincent@wanadoo.fr>
To:     linux-can@vger.kernel.org, Marc Kleine-Budde <mkl@pengutronix.de>
Cc:     Stephane Grosjean <s.grosjean@peak-system.com>,
        Jimmy Assarsson <extja@kvaser.com>,
        Oliver Hartkopp <socketcan@hartkopp.net>,
        Dario Binacchi <dario.binacchi@amarulasolutions.com>,
        Max Staudt <max@enpas.org>,
        Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Subject: [PATCH v3 06/14] can: dev: add hardware TX timestamp
Date:   Tue, 26 Jul 2022 19:24:46 +0900
Message-Id: <20220726102454.95096-7-mailhol.vincent@wanadoo.fr>
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

