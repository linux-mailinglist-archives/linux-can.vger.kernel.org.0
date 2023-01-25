Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5196C67BB18
	for <lists+linux-can@lfdr.de>; Wed, 25 Jan 2023 20:51:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235541AbjAYTvf (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Wed, 25 Jan 2023 14:51:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235818AbjAYTv1 (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Wed, 25 Jan 2023 14:51:27 -0500
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D5C359748
        for <linux-can@vger.kernel.org>; Wed, 25 Jan 2023 11:51:11 -0800 (PST)
Received: by mail-ej1-x631.google.com with SMTP id ud5so50647798ejc.4
        for <linux-can@vger.kernel.org>; Wed, 25 Jan 2023 11:51:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gfSXrRwfX7neDYk1hRvs3xyY0TSXIO6TaVWNzYTFpJg=;
        b=scmdglR0kK6ToTgqQkU66fxS6xXrLK/8Z7gJfs3aCCx5gPWsq8u+p0MvW28eWc+aXq
         MJltcF7XaZBxK5C3wJ6SFp9gehas5nOhwaBIKXbUeE8u+3t7RkwpPO/YW9BY27ETA6D7
         WycJ84fgNAy+8iKl0z3rRm/9dfBkZV0VZCFO9uhn5wpguZc8IYV/InkMWwG0070ipcPZ
         lCZSWQsFS6vbEdgcNOs+ostp36ajh0pFB2SqR207lb8G7CjzrP9QgItNXdQWFaDJ0bwY
         7ssoeGE5MqD9EhcepVfA2k1lbeLCqSxaDO8P4n0mVBq8wsDluKTznWPsdoSM5Z2J7R7B
         QWHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gfSXrRwfX7neDYk1hRvs3xyY0TSXIO6TaVWNzYTFpJg=;
        b=Z2+V/HGiTnBbaoYJOQV5gDC6139PTqvvPZEPFcA8634NCJjPDbuMRln0vi7bEriR0X
         4Dn/K6HNGfWkxY8SNrGksBMDNg1WdPFULOQ/Fs+PwygQIB+prW7Os2jNcP0qMIHqW7YX
         lA2wtgCo+lcc1rUlChu8rqfbRWmAZdJWpGmVsfCpOZbPo5icDllcUOD8gz1h5YBro2s/
         hgkymM9fP1BJfIlu/yCxQVYd6H5QRUYHKH6Q7OcYIDK4eh+jwmiC6qPLQ101iMPTyB/H
         j5WgGegn1m+MQPeFsTs7GIs9ayWSP6Xpu+fEYu1fLorV+rijrgEHjNAT1pT8Cn7Rcfmr
         sRgg==
X-Gm-Message-State: AFqh2koQ0LIhAU69UvZ7XE+L3V7fHQCgSSWiGjIpQX0R1Wh+pu8qLhY6
        96+aDEXAPytXiZoVtn4LffJtbg==
X-Google-Smtp-Source: AMrXdXsVjTwOtJbo/huQ6lAbLqA66TVtdPhpFDTs0OYNMu5SyZgc9C+5z/qkt+30gzW8Ug7qi2kILA==
X-Received: by 2002:a17:907:6a98:b0:855:2c8e:ad52 with SMTP id ri24-20020a1709076a9800b008552c8ead52mr27221046ejc.29.1674676271506;
        Wed, 25 Jan 2023 11:51:11 -0800 (PST)
Received: from blmsp.fritz.box ([2001:4091:a247:815f:ef74:e427:628a:752c])
        by smtp.gmail.com with ESMTPSA id s15-20020a170906454f00b00872c0bccab2sm2778830ejq.35.2023.01.25.11.51.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Jan 2023 11:51:11 -0800 (PST)
From:   Markus Schneider-Pargmann <msp@baylibre.com>
To:     Marc Kleine-Budde <mkl@pengutronix.de>,
        Chandrasekar Ramakrishnan <rcsekar@samsung.com>,
        Wolfgang Grandegger <wg@grandegger.com>
Cc:     Vincent MAILHOL <mailhol.vincent@wanadoo.fr>,
        linux-can@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Markus Schneider-Pargmann <msp@baylibre.com>
Subject: [PATCH v2 08/18] can: m_can: Write transmit header and data in one transaction
Date:   Wed, 25 Jan 2023 20:50:49 +0100
Message-Id: <20230125195059.630377-9-msp@baylibre.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230125195059.630377-1-msp@baylibre.com>
References: <20230125195059.630377-1-msp@baylibre.com>
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

Combine header and data before writing to the transmit fifo to reduce
the overhead for peripheral chips.

Signed-off-by: Markus Schneider-Pargmann <msp@baylibre.com>
---
 drivers/net/can/m_can/m_can.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/net/can/m_can/m_can.c b/drivers/net/can/m_can/m_can.c
index 78f6ed744c36..440bc0536951 100644
--- a/drivers/net/can/m_can/m_can.c
+++ b/drivers/net/can/m_can/m_can.c
@@ -1681,6 +1681,7 @@ static netdev_tx_t m_can_tx_handler(struct m_can_classdev *cdev)
 		m_can_write(cdev, M_CAN_TXBAR, 0x1);
 		/* End of xmit function for version 3.0.x */
 	} else {
+		char buf[TXB_ELEMENT_SIZE];
 		/* Transmit routine for version >= v3.1.x */
 
 		txfqs = m_can_read(cdev, M_CAN_TXFQS);
@@ -1720,12 +1721,11 @@ static netdev_tx_t m_can_tx_handler(struct m_can_classdev *cdev)
 		fifo_header.dlc = FIELD_PREP(TX_BUF_MM_MASK, putidx) |
 			FIELD_PREP(TX_BUF_DLC_MASK, can_fd_len2dlc(cf->len)) |
 			fdflags | TX_BUF_EFC;
-		err = m_can_fifo_write(cdev, putidx, M_CAN_FIFO_ID, &fifo_header, 2);
-		if (err)
-			goto out_fail;
+		memcpy(buf, &fifo_header, 8);
+		memcpy(&buf[8], &cf->data, cf->len);
 
-		err = m_can_fifo_write(cdev, putidx, M_CAN_FIFO_DATA,
-				       cf->data, DIV_ROUND_UP(cf->len, 4));
+		err = m_can_fifo_write(cdev, putidx, M_CAN_FIFO_ID,
+				       buf, 8 + DIV_ROUND_UP(cf->len, 4));
 		if (err)
 			goto out_fail;
 
-- 
2.39.0

