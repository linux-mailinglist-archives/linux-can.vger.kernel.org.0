Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 98C766442AC
	for <lists+linux-can@lfdr.de>; Tue,  6 Dec 2022 12:58:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235257AbiLFL55 (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Tue, 6 Dec 2022 06:57:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234606AbiLFL5o (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 6 Dec 2022 06:57:44 -0500
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C50D95B3
        for <linux-can@vger.kernel.org>; Tue,  6 Dec 2022 03:57:41 -0800 (PST)
Received: by mail-ej1-x636.google.com with SMTP id kw15so2151566ejc.10
        for <linux-can@vger.kernel.org>; Tue, 06 Dec 2022 03:57:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LBqwKcCdNszQ4mwUTsccWY77ZqBMhKPDh+uspgjRsrc=;
        b=DPqqNGeJB+CLzaOy8DcBdvQ4jz5mShTjsBsQBiKtpJutZ9pt4futlXIv7BoIoLxKe1
         ikRhLz4m7cQ7T/l7BPYX0zBg6Cp/hp+OmXJU5HpZpP3uN7z10J7635BmX25nND0MK2Tt
         ETAsPvi5kdq5jXRVH1OfPi+3HJHP6RfuZU3hqfrKBWZyC4zngg96khNNLz2iKp+fWlPu
         /DW905aQp3qfroPlS0pWoDMY+fczDnQXUTEJmd18IHZ1e5ByrTF/YqizF7kWto6RKrSo
         U5Nxdv5WjyxypVZbti2mw4Eofk4Y/wAOxrrqLim6nMpKVEWYndu5AuE4fI/Xrfx7MCrq
         yhbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LBqwKcCdNszQ4mwUTsccWY77ZqBMhKPDh+uspgjRsrc=;
        b=NUpvW/mxZY1tVcyzcxPpuAUNUrX92UCBJbOFr4B3j1ppbZP1d1tOE6Vp9fV0ize9pU
         9gNnlCfgFHfOKh//auU0DrfDvvt9anKdT2xoIn8AyZEaVHAWb4dYO4u8RfmA4ImIX5ws
         6QKfnG6V3P0y2F4BSugeUC7w99P6i7X6+gFmdmB7iRwD5RCROx5a5hoh/SwfShLnOra8
         Uc5D4WwQhsFkzISnIoYPt6X+N60s1+PWmQL8WBgOLW7rW21QRz9Tjnc4bUKCyJM4tKcO
         Uw0DPNLnqynj40DYFs63MzKBrr5AdY7n3KKlcSkZ0V0J0o8J3GL8jjDopE33qZ/sINu5
         TtuA==
X-Gm-Message-State: ANoB5pmFO3bfaZ3e7uVB3C/99BY9JwFf+dhprXVdV4JxKUch4JWHPgXH
        rMwVBL1XPwBF5eQarQNCbVbNQA==
X-Google-Smtp-Source: AA0mqf47x0bv/bx0CdJ4booRAhJIul6kiSx0Wgt7a/P3vRxUPTwsqwUNqSNrfwYI9fJ+L1nGhmitIw==
X-Received: by 2002:a17:906:ad86:b0:7c0:7e90:ec98 with SMTP id la6-20020a170906ad8600b007c07e90ec98mr3823617ejb.537.1670327860065;
        Tue, 06 Dec 2022 03:57:40 -0800 (PST)
Received: from blmsp.fritz.box ([2001:4091:a245:805c:8713:84e4:2a9e:cbe8])
        by smtp.gmail.com with ESMTPSA id ky20-20020a170907779400b007c0ac4e6b6esm6472076ejc.143.2022.12.06.03.57.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Dec 2022 03:57:39 -0800 (PST)
From:   Markus Schneider-Pargmann <msp@baylibre.com>
To:     Chandrasekar Ramakrishnan <rcsekar@samsung.com>,
        Marc Kleine-Budde <mkl@pengutronix.de>,
        Wolfgang Grandegger <wg@grandegger.com>
Cc:     linux-can@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Markus Schneider-Pargmann <msp@baylibre.com>
Subject: [PATCH v2 05/11] can: m_can: Count read getindex in the driver
Date:   Tue,  6 Dec 2022 12:57:22 +0100
Message-Id: <20221206115728.1056014-6-msp@baylibre.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221206115728.1056014-1-msp@baylibre.com>
References: <20221206115728.1056014-1-msp@baylibre.com>
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

The getindex gets increased by one every time. We can calculate the
correct getindex in the driver and avoid the additional reads of rxfs.

Signed-off-by: Markus Schneider-Pargmann <msp@baylibre.com>
---
 drivers/net/can/m_can/m_can.c | 17 ++++++++++-------
 1 file changed, 10 insertions(+), 7 deletions(-)

diff --git a/drivers/net/can/m_can/m_can.c b/drivers/net/can/m_can/m_can.c
index a133f15fb90a..a0ae543d418c 100644
--- a/drivers/net/can/m_can/m_can.c
+++ b/drivers/net/can/m_can/m_can.c
@@ -476,19 +476,16 @@ static void m_can_receive_skb(struct m_can_classdev *cdev,
 	}
 }
 
-static int m_can_read_fifo(struct net_device *dev, u32 rxfs)
+static int m_can_read_fifo(struct net_device *dev, u32 fgi)
 {
 	struct net_device_stats *stats = &dev->stats;
 	struct m_can_classdev *cdev = netdev_priv(dev);
 	struct canfd_frame *cf;
 	struct sk_buff *skb;
 	struct id_and_dlc fifo_header;
-	u32 fgi;
 	u32 timestamp = 0;
 	int err;
 
-	/* calculate the fifo get index for where to read data */
-	fgi = FIELD_GET(RXFS_FGI_MASK, rxfs);
 	err = m_can_fifo_read(cdev, fgi, M_CAN_FIFO_ID, &fifo_header, 2);
 	if (err)
 		goto out_fail;
@@ -553,6 +550,9 @@ static int m_can_do_rx_poll(struct net_device *dev, int quota)
 	struct m_can_classdev *cdev = netdev_priv(dev);
 	u32 pkts = 0;
 	u32 rxfs;
+	u32 rx_count;
+	u32 fgi;
+	int i;
 	int err;
 
 	rxfs = m_can_read(cdev, M_CAN_RXF0S);
@@ -561,14 +561,17 @@ static int m_can_do_rx_poll(struct net_device *dev, int quota)
 		return 0;
 	}
 
-	while ((rxfs & RXFS_FFL_MASK) && (quota > 0)) {
-		err = m_can_read_fifo(dev, rxfs);
+	rx_count = FIELD_GET(RXFS_FFL_MASK, rxfs);
+	fgi = FIELD_GET(RXFS_FGI_MASK, rxfs);
+
+	for (i = 0; i < rx_count && quota > 0; ++i) {
+		err = m_can_read_fifo(dev, fgi);
 		if (err)
 			return err;
 
 		quota--;
 		pkts++;
-		rxfs = m_can_read(cdev, M_CAN_RXF0S);
+		fgi = (++fgi >= cdev->mcfg[MRAM_RXF0].num ? 0 : fgi);
 	}
 
 	return pkts;
-- 
2.38.1

