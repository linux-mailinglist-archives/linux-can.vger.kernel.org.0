Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B96B67BB29
	for <lists+linux-can@lfdr.de>; Wed, 25 Jan 2023 20:52:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236146AbjAYTwR (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Wed, 25 Jan 2023 14:52:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235973AbjAYTv4 (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Wed, 25 Jan 2023 14:51:56 -0500
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA86D5A81E
        for <linux-can@vger.kernel.org>; Wed, 25 Jan 2023 11:51:16 -0800 (PST)
Received: by mail-ej1-x631.google.com with SMTP id az20so50683189ejc.1
        for <linux-can@vger.kernel.org>; Wed, 25 Jan 2023 11:51:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=w2lrVaPRiH6uq0q+cTr4TOtwHEPWA0Tt42PRWTeXIWc=;
        b=11ddGa4oOpWRyKolQ6bWHrgxflSd66PqlC7gEHln8u92cm2fHxEDuXQnsx+GplqmBF
         O98ig0tyA/L45rH+GuTFcWtfDbEgD+DIofkW9Yv1Y+p+OYVE99xlTnoGYHRhsubVM9GX
         APR/+jZdxRoEsuYLoMfCHDXU6glernrMuzuGlfScC5AhjWtCCeLxyiYzKbAcfGPJkVvX
         iSepxLaqsVnFAx18JoK27x1Df0y9aBmXMPBpaHeWdb42GA45LZopnejDC7+hFCzos3m4
         fY+YAr3KM8xWcfNMQEp72xGoUmvZDhbFiwST4iYRWaSG8cdvRHWctuFDeizm4+O1J3Vz
         dADg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=w2lrVaPRiH6uq0q+cTr4TOtwHEPWA0Tt42PRWTeXIWc=;
        b=QMSVvsFgCr/y9gkL6dx3qSG+k4H5KvN6v0zBd8RhZwo/FxqwuUo2EbZIYwfjsZxWhY
         RLuCzNvnrLHSTmP6Os9WaJW/2qJYN0Z+ufJSmBkuwFjY3kcJoX8FoJgxuKZSHzeuBuDT
         eu6vTqaOH7rKOFibLZWSfRsLpTnuhpMPj/PQmZmLtqbhPbzTQsqrXoeQdE3zkSra1mDY
         kRi1fcGsHYcec4HnYPfax/94Q5gaEh+BH4fAxfAW/jyR+GkhX6X5sjlCsX4CtSP7ZDT+
         3OPbSV5J/CBW7Xm3f/ghMl4F8ji1t5R7dzi4LV51s0gDRti0gWjGEos40J5vdOsozvZe
         dlmQ==
X-Gm-Message-State: AFqh2kp0YzwIWD1eObtnn1T3Q//wNtmpKEu7n9iq/8aee+//swkJ+gQt
        AN6N4hGl6hvrFb4uThUYg855oA==
X-Google-Smtp-Source: AMrXdXsKqFoQtFT5QKMEzJwjEBP2mEGBaOHOXJLiv434pycDmYDvf+DLa5SP0e/79U8IGxiKztdNYw==
X-Received: by 2002:a17:907:9548:b0:84d:37d4:7533 with SMTP id ex8-20020a170907954800b0084d37d47533mr29992408ejc.0.1674676276031;
        Wed, 25 Jan 2023 11:51:16 -0800 (PST)
Received: from blmsp.fritz.box ([2001:4091:a247:815f:ef74:e427:628a:752c])
        by smtp.gmail.com with ESMTPSA id s15-20020a170906454f00b00872c0bccab2sm2778830ejq.35.2023.01.25.11.51.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Jan 2023 11:51:15 -0800 (PST)
From:   Markus Schneider-Pargmann <msp@baylibre.com>
To:     Marc Kleine-Budde <mkl@pengutronix.de>,
        Chandrasekar Ramakrishnan <rcsekar@samsung.com>,
        Wolfgang Grandegger <wg@grandegger.com>
Cc:     Vincent MAILHOL <mailhol.vincent@wanadoo.fr>,
        linux-can@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Markus Schneider-Pargmann <msp@baylibre.com>
Subject: [PATCH v2 13/18] can: m_can: Cache tx putidx
Date:   Wed, 25 Jan 2023 20:50:54 +0100
Message-Id: <20230125195059.630377-14-msp@baylibre.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230125195059.630377-1-msp@baylibre.com>
References: <20230125195059.630377-1-msp@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

m_can_tx_handler is the only place where data is written to the tx fifo.
We can calculate the putidx in the driver code here to avoid the
dependency on the txfqs register.

Signed-off-by: Markus Schneider-Pargmann <msp@baylibre.com>
---
 drivers/net/can/m_can/m_can.c | 8 +++++++-
 drivers/net/can/m_can/m_can.h | 3 +++
 2 files changed, 10 insertions(+), 1 deletion(-)

diff --git a/drivers/net/can/m_can/m_can.c b/drivers/net/can/m_can/m_can.c
index 9d2345f52ddc..83ffb4c0eb4c 100644
--- a/drivers/net/can/m_can/m_can.c
+++ b/drivers/net/can/m_can/m_can.c
@@ -1475,6 +1475,10 @@ static int m_can_start(struct net_device *dev)
 
 	m_can_enable_all_interrupts(cdev);
 
+	if (cdev->version > 30)
+		cdev->tx_fifo_putidx = FIELD_GET(TXFQS_TFQPI_MASK,
+						 m_can_read(cdev, M_CAN_TXFQS));
+
 	return 0;
 }
 
@@ -1764,7 +1768,7 @@ static netdev_tx_t m_can_tx_handler(struct m_can_classdev *cdev)
 		}
 
 		/* get put index for frame */
-		putidx = FIELD_GET(TXFQS_TFQPI_MASK, txfqs);
+		putidx = cdev->tx_fifo_putidx;
 
 		/* Construct DLC Field, with CAN-FD configuration.
 		 * Use the put index of the fifo as the message marker,
@@ -1797,6 +1801,8 @@ static netdev_tx_t m_can_tx_handler(struct m_can_classdev *cdev)
 
 		/* Enable TX FIFO element to start transfer  */
 		m_can_write(cdev, M_CAN_TXBAR, (1 << putidx));
+		cdev->tx_fifo_putidx = (++cdev->tx_fifo_putidx >= cdev->can.echo_skb_max ?
+					0 : cdev->tx_fifo_putidx);
 
 		/* stop network queue if fifo full */
 		if (m_can_tx_fifo_full(cdev) ||
diff --git a/drivers/net/can/m_can/m_can.h b/drivers/net/can/m_can/m_can.h
index 0721faae7886..4437085f63b8 100644
--- a/drivers/net/can/m_can/m_can.h
+++ b/drivers/net/can/m_can/m_can.h
@@ -102,6 +102,9 @@ struct m_can_classdev {
 	u32 tx_max_coalesced_frames_irq;
 	u32 tx_coalesce_usecs_irq;
 
+	// Store this internally to avoid fetch delays on peripheral chips
+	int tx_fifo_putidx;
+
 	struct mram_cfg mcfg[MRAM_CFG_NUM];
 };
 
-- 
2.39.0

