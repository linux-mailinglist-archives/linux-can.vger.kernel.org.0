Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C30017B3480
	for <lists+linux-can@lfdr.de>; Fri, 29 Sep 2023 16:13:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233118AbjI2ONb (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Fri, 29 Sep 2023 10:13:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233310AbjI2ONX (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Fri, 29 Sep 2023 10:13:23 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA19ECCC
        for <linux-can@vger.kernel.org>; Fri, 29 Sep 2023 07:13:20 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id 5b1f17b1804b1-405524e6740so123750075e9.1
        for <linux-can@vger.kernel.org>; Fri, 29 Sep 2023 07:13:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1695996799; x=1696601599; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GkCcF2KTU9N5lkXziHP+LXRrArD0pee4JR3G/zEvesA=;
        b=cjVZAZi70K0rgd+yj9PK5mhJkiGvhgOAyJpiizEzK22WoAeAwNZIC40co//x+Zw9xy
         dX4AFiaIoiTSNK2oVUI/p3R6rnSdhe7Oy0X63btpA4flVs4RUi1x+xrB8Oxolpzwk51B
         FP5S7NuKd+B1aSq29golbdWvcDcd107pDPukk/TRdMJweQJHFCC1rL6jQe9wur8Glp2f
         Ez83zmSblHM2pttcQCfWSIjZQe+yVHVBPPn30OxNJ1L0C5Ma+AX60nY04qdxemg9PG3p
         +43aFTM9vI/ohg2T6vgQfWnB/fdlHFEy0juhKyrR57esQLSvLdAuhW3Rf4R0yX7svgLR
         6WIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695996799; x=1696601599;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GkCcF2KTU9N5lkXziHP+LXRrArD0pee4JR3G/zEvesA=;
        b=n1CQGol66hgj8dPNkcRQRj3KIj3gkO8kcBpsozA+wcSs5NwP1U6QwYpEhdqSTAdCJR
         h1jd06bVjW1bp8mukv+5sYluW9PZTBDRLCL0AXmzEpAJ6P1TsIcrysXdOGBzP5untzIK
         r703qcrixbZ7/enjfnkmQwvGkoHbpTLQ48+qeh0/NxJuvO/pBM1ZF2G1GcuyNFtT+4dg
         7ITL74g8zbwmp14IXaI61Itn4CF5FzIH/bwqThPz7LnTQqEZBeAe/aufFZrn3XyvxKzt
         Ge+OelOilL7Gq/eij6uWmd6dhv9zh1czHPQAeMg10rZEycaxBwlh0W+Sg64SliA80ruX
         NO4Q==
X-Gm-Message-State: AOJu0Yzpzwjie07H79rsCeMZ/R5BMXPQGq6FA/EFAKyTZDhLD888ZAHA
        tfwS8kXgLzgGsHHTacwixJEOKQ==
X-Google-Smtp-Source: AGHT+IEFHl050mT4xpHekXYUX/+roBtcsDhNgR8Zd+Bg6bIiJyLUrZtUd7mL6LJND2UCb/uYOMfs+A==
X-Received: by 2002:a05:600c:2053:b0:406:478e:9e2d with SMTP id p19-20020a05600c205300b00406478e9e2dmr3754793wmg.26.1695996799447;
        Fri, 29 Sep 2023 07:13:19 -0700 (PDT)
Received: from blmsp.fritz.box ([2001:4091:a246:8222:dbda:9cd9:39cc:f174])
        by smtp.gmail.com with ESMTPSA id t25-20020a7bc3d9000000b00405391f485fsm1513068wmj.41.2023.09.29.07.13.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Sep 2023 07:13:19 -0700 (PDT)
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
        Julien Panis <jpanis@baylibre.com>, Judith Mendez <jm@ti.com>,
        Markus Schneider-Pargmann <msp@baylibre.com>
Subject: [PATCH v6 08/14] can: m_can: Use u32 for putidx
Date:   Fri, 29 Sep 2023 16:12:58 +0200
Message-Id: <20230929141304.3934380-9-msp@baylibre.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230929141304.3934380-1-msp@baylibre.com>
References: <20230929141304.3934380-1-msp@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

putidx is not an integer normally, it is an unsigned field used in
hardware registers. Use a u32 for it.

Signed-off-by: Markus Schneider-Pargmann <msp@baylibre.com>
Reviewed-by: Simon Horman <simon.horman@corigine.com>
---
 drivers/net/can/m_can/m_can.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/net/can/m_can/m_can.c b/drivers/net/can/m_can/m_can.c
index 1c021d99bae2..4e9e5c689b19 100644
--- a/drivers/net/can/m_can/m_can.c
+++ b/drivers/net/can/m_can/m_can.c
@@ -485,7 +485,7 @@ static void m_can_clean(struct net_device *net)
 	struct m_can_classdev *cdev = netdev_priv(net);
 
 	if (cdev->tx_skb) {
-		int putidx = 0;
+		u32 putidx = 0;
 
 		net->stats.tx_errors++;
 		if (cdev->version > 30)
@@ -1694,12 +1694,12 @@ static int m_can_close(struct net_device *dev)
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
@@ -1718,7 +1718,7 @@ static netdev_tx_t m_can_tx_handler(struct m_can_classdev *cdev)
 	u32 cccr, fdflags;
 	u32 txfqs;
 	int err;
-	int putidx;
+	u32 putidx;
 
 	cdev->tx_skb = NULL;
 
-- 
2.40.1

