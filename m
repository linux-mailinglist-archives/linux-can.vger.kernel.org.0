Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 367005824CB
	for <lists+linux-can@lfdr.de>; Wed, 27 Jul 2022 12:50:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231616AbiG0KuA (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Wed, 27 Jul 2022 06:50:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231586AbiG0Kt7 (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Wed, 27 Jul 2022 06:49:59 -0400
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3DBD22BFC
        for <linux-can@vger.kernel.org>; Wed, 27 Jul 2022 03:49:58 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id x7so1895798pll.7
        for <linux-can@vger.kernel.org>; Wed, 27 Jul 2022 03:49:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=TxGQXTIfCy0v7uuBpjkbq7+s6pHtoO44iYJdtM2Ar8w=;
        b=d6ZJzLl1zgR5ADu5ajzF1OyFasqbsh1089/ori1pVVkkC8ANkBDoSlEMSKeZL/hKGV
         l9t3tv9nGDiapmqcBoBeQVP3K44N4l9O9b/REQCj934mLYtxOMud4TF6QciSOUZfNNOp
         r2GAq5/Pj05gLZo/LJK0wF7zhMzFHftcQJsepy9TjrCWFeEmQtBLQR2PhUAKdTSEOl1w
         9HunI7LORUAJAcxePTsrVWGipU0+o5nrtdj52at79Kx6uPUtQh991+ICXfg3iQENRprx
         gphznQ15SUusdYDKzY0+xS750WpmFcIqYy4hHE1VL8amJYfU0pMEmUiFLpRa5z2f4VdW
         PofA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=TxGQXTIfCy0v7uuBpjkbq7+s6pHtoO44iYJdtM2Ar8w=;
        b=GvkbokeLBk0BF5sUfe0GSbMibYW344PcrGecfDF7Go1F/4JycbM2oSjONfX1bnw7H5
         wKpSq9KrnHcd1IwG8E0ceK1d/fo9HcWGpOKXq7N4GAchXAqR/kWTRhwXVdlVthXolMIE
         TatzvnGPtChF7a9gQo966uDmr05Sx1yu+mgr8QVKJGWJPUgZJ84G8pAUrHGSAVNAZIwa
         j5ghULGBCxfzJHqj27zcKxR5lz6ae+vbCmoLa1e7sbaict/9LWLnDP7AbpdoegkqDW9I
         4c3y9zuGbHqUsn52n8y1lIlOZUwqGEtmc+BmC3XbBj5d9rFYITo7s34hvG5RBCazThtE
         PAXg==
X-Gm-Message-State: AJIora9rS1wh0ZlDRxKDOC07RhRyeBmnkgxBAdfiNYWZqi3GFjjxqeI1
        pLsiEK0Iv9Z6l0GNlf4D6CiMeox9uCQ=
X-Google-Smtp-Source: AGRyM1uaZIt1gRSttIJDrNWsMFgmKNBNps1UEXPYYU1ySyIIqMCGV8vxRgFFZxF43HqcOQU7JEC6hQ==
X-Received: by 2002:a17:90a:5d05:b0:1ef:91ab:de15 with SMTP id s5-20020a17090a5d0500b001ef91abde15mr3863340pji.85.1658918998201;
        Wed, 27 Jul 2022 03:49:58 -0700 (PDT)
Received: from localhost.localdomain (124x33x176x97.ap124.ftth.ucom.ne.jp. [124.33.176.97])
        by smtp.gmail.com with ESMTPSA id o19-20020aa79793000000b00525343b5047sm13526114pfp.76.2022.07.27.03.49.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Jul 2022 03:49:57 -0700 (PDT)
Sender: Vincent Mailhol <vincent.mailhol@gmail.com>
From:   Vincent Mailhol <mailhol.vincent@wanadoo.fr>
To:     linux-can@vger.kernel.org, Marc Kleine-Budde <mkl@pengutronix.de>
Cc:     Dario Binacchi <dario.binacchi@amarulasolutions.com>,
        Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Subject: [PATCH 3/3] can: flexcan: export flexcan_ethtool_ops and remove flexcan_set_ethtool_ops()
Date:   Wed, 27 Jul 2022 19:49:39 +0900
Message-Id: <20220727104939.279022-4-mailhol.vincent@wanadoo.fr>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220727104939.279022-1-mailhol.vincent@wanadoo.fr>
References: <20220727104939.279022-1-mailhol.vincent@wanadoo.fr>
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

The function flexcan_set_ethtool_ops() does one thing: populate
net_device::ethtool_ops. Instead, it is possible to directly assign
this field and remove one function call and slightly reduce the object
size. To do so, export flexcan_ethtool_ops so it becomes visible to
flexcan-core.c.

Signed-off-by: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
---
 drivers/net/can/flexcan/flexcan-core.c    | 2 +-
 drivers/net/can/flexcan/flexcan-ethtool.c | 7 +------
 drivers/net/can/flexcan/flexcan.h         | 2 +-
 3 files changed, 3 insertions(+), 8 deletions(-)

diff --git a/drivers/net/can/flexcan/flexcan-core.c b/drivers/net/can/flexcan/flexcan-core.c
index d060088047f1..f857968efed7 100644
--- a/drivers/net/can/flexcan/flexcan-core.c
+++ b/drivers/net/can/flexcan/flexcan-core.c
@@ -2113,7 +2113,7 @@ static int flexcan_probe(struct platform_device *pdev)
 	SET_NETDEV_DEV(dev, &pdev->dev);
 
 	dev->netdev_ops = &flexcan_netdev_ops;
-	flexcan_set_ethtool_ops(dev);
+	dev->ethtool_ops = &flexcan_ethtool_ops;
 	dev->irq = irq;
 	dev->flags |= IFF_ECHO;
 
diff --git a/drivers/net/can/flexcan/flexcan-ethtool.c b/drivers/net/can/flexcan/flexcan-ethtool.c
index 3ae535577700..f0873f3a2f34 100644
--- a/drivers/net/can/flexcan/flexcan-ethtool.c
+++ b/drivers/net/can/flexcan/flexcan-ethtool.c
@@ -100,15 +100,10 @@ static int flexcan_get_sset_count(struct net_device *netdev, int sset)
 	}
 }
 
-static const struct ethtool_ops flexcan_ethtool_ops = {
+const struct ethtool_ops flexcan_ethtool_ops = {
 	.get_ringparam = flexcan_get_ringparam,
 	.get_strings = flexcan_get_strings,
 	.get_priv_flags = flexcan_get_priv_flags,
 	.set_priv_flags = flexcan_set_priv_flags,
 	.get_sset_count = flexcan_get_sset_count,
 };
-
-void flexcan_set_ethtool_ops(struct net_device *netdev)
-{
-	netdev->ethtool_ops = &flexcan_ethtool_ops;
-}
diff --git a/drivers/net/can/flexcan/flexcan.h b/drivers/net/can/flexcan/flexcan.h
index 23fc09a7e10f..8621a8ea1dea 100644
--- a/drivers/net/can/flexcan/flexcan.h
+++ b/drivers/net/can/flexcan/flexcan.h
@@ -114,7 +114,7 @@ struct flexcan_priv {
 	void (*write)(u32 val, void __iomem *addr);
 };
 
-void flexcan_set_ethtool_ops(struct net_device *dev);
+extern const struct ethtool_ops flexcan_ethtool_ops;
 
 static inline bool
 flexcan_supports_rx_mailbox(const struct flexcan_priv *priv)
-- 
2.35.1

