Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4113F7575ED
	for <lists+linux-can@lfdr.de>; Tue, 18 Jul 2023 09:58:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229847AbjGRH6O (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Tue, 18 Jul 2023 03:58:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231821AbjGRH5w (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 18 Jul 2023 03:57:52 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF3D319A8
        for <linux-can@vger.kernel.org>; Tue, 18 Jul 2023 00:57:19 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id ffacd0b85a97d-3159d75606dso5162643f8f.1
        for <linux-can@vger.kernel.org>; Tue, 18 Jul 2023 00:57:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20221208.gappssmtp.com; s=20221208; t=1689667038; x=1690271838;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9327qe/b1po3J/jl0WXk20AqdOJMkfPU+3V2iMfGkew=;
        b=OdkXVFjbgx2kyWt3mov4p/Sa0veTtmXN1u7IWvsYSoyzwWb3o0Gh8T980BAO661SR8
         3SpYwrL5p4u8xWvbE8crJEN9DFJcpDhG++pLKoswWp+RxwNtQSMnm/mFp/hmdbunhmkF
         11YpAPt90bWWllDvTMGkFio6PvkxSsIjxGyZCMi1TIUpMywcIMBa1lowMzQHqMeMN3ks
         2jrdmOJOw7jkuLlbdcuAqufg8g07QVkLLMGlFV5tozTDRA9ytZyZ/symrBb/vE+tVPUh
         Tjvv7gs1M4MHhcX2HqrBc14AZyLspvu3OFkIXyl9zy3r6bXqESdv0dvzHElnfEINvKqz
         UBpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689667038; x=1690271838;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9327qe/b1po3J/jl0WXk20AqdOJMkfPU+3V2iMfGkew=;
        b=fArC5UbVaMOvF7aVCK81MF3QToiBc+j/bW/jGV8htojTV8/WxIlysk+ESOKe5gCyHN
         WT1paB4DUKVqd6TkXI80QZob3hz2aHuiPiq3l7cXLBm7tib1JalWrwJBfqXEmH8s0x7U
         WQgEAaT02PZHNKM4dGjdS5q93OHfA6QdJ8nGCfLAb7TrA01xCxz025wAbS3dPkQYFMsJ
         SqhqlcWZVFuhx0Us0uXJKRA39cAqUN6ykhfFZ+2T97tDewYK+9jQMWVyiCeR8LjAX4sY
         d0Y7g7c7NiJMtY/xq7mTFAsskSIq7QxiU/g+g5J5tSj2iSAaPy57hWsdsbWQvT8VG2pS
         XbFQ==
X-Gm-Message-State: ABy/qLbfHS4fsnFkctyePR0htSG0bbk+eyMwGjqRukBPrfJIBkRTu0Qu
        jd4qBJx/oZjHkBhLLCUidHwsJQ==
X-Google-Smtp-Source: APBJJlHvPJsY7pGN2f/7pb0GBQLzzmt/nUI1Z8SrruT/sgroH/I5suRgGkS3Yp47fM3Rrq4KfvOySw==
X-Received: by 2002:a05:6000:87:b0:314:449e:8536 with SMTP id m7-20020a056000008700b00314449e8536mr11483857wrx.10.1689667037833;
        Tue, 18 Jul 2023 00:57:17 -0700 (PDT)
Received: from blmsp.fritz.box ([2001:4091:a247:82fa:b762:4f68:e1ed:5041])
        by smtp.gmail.com with ESMTPSA id x4-20020a5d54c4000000b003142439c7bcsm1585959wrv.80.2023.07.18.00.57.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Jul 2023 00:57:17 -0700 (PDT)
From:   Markus Schneider-Pargmann <msp@baylibre.com>
To:     Marc Kleine-Budde <mkl@pengutronix.de>,
        Chandrasekar Ramakrishnan <rcsekar@samsung.com>,
        Wolfgang Grandegger <wg@grandegger.com>
Cc:     Vincent MAILHOL <mailhol.vincent@wanadoo.fr>,
        Simon Horman <simon.horman@corigine.com>,
        "David S . Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, linux-can@vger.kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Julien Panis <jpanis@baylibre.com>,
        Markus Schneider-Pargmann <msp@baylibre.com>
Subject: [PATCH v5 06/12] can: m_can: Use u32 for putidx
Date:   Tue, 18 Jul 2023 09:57:02 +0200
Message-Id: <20230718075708.958094-7-msp@baylibre.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230718075708.958094-1-msp@baylibre.com>
References: <20230718075708.958094-1-msp@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

putidx is not an integer normally, it is an unsigned field used in
hardware registers. Use a u32 for it.

Signed-off-by: Markus Schneider-Pargmann <msp@baylibre.com>
---
 drivers/net/can/m_can/m_can.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/net/can/m_can/m_can.c b/drivers/net/can/m_can/m_can.c
index 6af5fa8c7eb3..6a815812ae38 100644
--- a/drivers/net/can/m_can/m_can.c
+++ b/drivers/net/can/m_can/m_can.c
@@ -467,7 +467,7 @@ static void m_can_clean(struct net_device *net)
 	struct m_can_classdev *cdev = netdev_priv(net);
 
 	if (cdev->tx_skb) {
-		int putidx = 0;
+		u32 putidx = 0;
 
 		net->stats.tx_errors++;
 		if (cdev->version > 30)
@@ -1673,12 +1673,12 @@ static int m_can_close(struct net_device *dev)
 	return 0;
 }
 
-static int m_can_next_echo_skb_occupied(struct net_device *dev, int putidx)
+static int m_can_next_echo_skb_occupied(struct net_device *dev, u32 putidx)
 {
 	struct m_can_classdev *cdev = netdev_priv(dev);
 	/*get wrap around for loopback skb index */
 	unsigned int wrap = cdev->can.echo_skb_max;
-	int next_idx;
+	u32 next_idx;
 
 	/* calculate next index */
 	next_idx = (++putidx >= wrap ? 0 : putidx);
@@ -1697,7 +1697,7 @@ static netdev_tx_t m_can_tx_handler(struct m_can_classdev *cdev)
 	u32 cccr, fdflags;
 	u32 txfqs;
 	int err;
-	int putidx;
+	u32 putidx;
 
 	cdev->tx_skb = NULL;
 
-- 
2.40.1

