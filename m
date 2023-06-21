Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F1AF737FCD
	for <lists+linux-can@lfdr.de>; Wed, 21 Jun 2023 13:09:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231341AbjFUJYZ (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Wed, 21 Jun 2023 05:24:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231437AbjFUJYX (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Wed, 21 Jun 2023 05:24:23 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48ECA19AF
        for <linux-can@vger.kernel.org>; Wed, 21 Jun 2023 02:24:04 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id a640c23a62f3a-988c495f35fso378750766b.1
        for <linux-can@vger.kernel.org>; Wed, 21 Jun 2023 02:24:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20221208.gappssmtp.com; s=20221208; t=1687339442; x=1689931442;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LE1vT+gVNirEsJxbTiTmA/33w+JDDyn/z8+OkH6Uatg=;
        b=dh/Yscpx9g50WP8aUQec7esEdqkMVckT3xmVw5qZUmxNn8Lnkpby8IzbVZxOkbudQ1
         dR5a6nkp17Pn0vSgWzUsFeApujZpPlq8DvW9F6cn4SoKlOPPHmvyWvXo/XEgH/v1Xjhp
         d0gzl7pJo4T/8Ea7xeTevcKvSQAm4tg84t6Li6oi2XxrgDKYJKUrU5QO+OJZUmcn/pW8
         WgN3lJONfebk19tQqqGWv1PBAFnjqam9Hm3hhUp/V1h9hKt/3nybAv0+65aU0McJ3Sct
         U+MigjS8Fq7nIP9+sx1pDlBh59lrTSFdqy1cYRhDwwYdcIAfIhrkmUsd1f5G+ApwD6Ex
         LGTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687339442; x=1689931442;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LE1vT+gVNirEsJxbTiTmA/33w+JDDyn/z8+OkH6Uatg=;
        b=ixSKBjxRknWq1Cy1Mn8ROc6DqubyHZZfpKG5ZGAADG7BuKF0NY9OH4uzkFVfOXQH4R
         l5b9bvlz5QlQmXMxt8xPdHO1CVFDensv8Is8dF680YV7Qz3l3D+Bo79cW76R3Zy2wdjp
         PYroAvnP3p9qao2aMORVMjJlmCdCnn52X/cYLbtUPCCxJ2/VUfW+f6V1+v4x7N7pIyZq
         ErOPVMI1MIeMa7PCc6sbhq58XLYBCf0zT8Rco0woYdUPsm0ag0NHEZsh6uoUrwIbZvAD
         IN2rwz39lFGk6o2I8cTwLsJxdu346WskG/Fqb+EeSKYrqOKIVizZ6GXOW6iGqedA8TP8
         4ToA==
X-Gm-Message-State: AC+VfDyzk1oNlz6KH+2A2/Hr6MPtqD2KAtaFNvaeyhuTRYW1UhNO1vqP
        WLUvqFBHlBZXoNkfJVia2b69CA==
X-Google-Smtp-Source: ACHHUZ7IYIJzPl+IZdr+yo0zGtbLHILTndtfPgoJd1ib2x2wssIJxDu9j+PC5fysl1booVNBKkNFgA==
X-Received: by 2002:a17:906:58d2:b0:988:8a11:ab88 with SMTP id e18-20020a17090658d200b009888a11ab88mr8539198ejs.33.1687339442703;
        Wed, 21 Jun 2023 02:24:02 -0700 (PDT)
Received: from blmsp.fritz.box ([2001:4091:a247:82fa:b762:4f68:e1ed:5041])
        by smtp.gmail.com with ESMTPSA id i11-20020adffdcb000000b002fda1b12a0bsm4022115wrs.2.2023.06.21.02.24.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Jun 2023 02:24:02 -0700 (PDT)
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
Subject: [PATCH v4 06/12] can: m_can: Use u32 for putidx
Date:   Wed, 21 Jun 2023 11:23:44 +0200
Message-Id: <20230621092350.3130866-7-msp@baylibre.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230621092350.3130866-1-msp@baylibre.com>
References: <20230621092350.3130866-1-msp@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
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
index d1435d1466b2..6f8043636c54 100644
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
@@ -1698,7 +1698,7 @@ static netdev_tx_t m_can_tx_handler(struct m_can_classdev *cdev)
 	u32 cccr, fdflags;
 	u32 txfqs;
 	int err;
-	int putidx;
+	u32 putidx;
 
 	cdev->tx_skb = NULL;
 
-- 
2.40.1

