Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB772653339
	for <lists+linux-can@lfdr.de>; Wed, 21 Dec 2022 16:26:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234698AbiLUP0E (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Wed, 21 Dec 2022 10:26:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234649AbiLUPZu (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Wed, 21 Dec 2022 10:25:50 -0500
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D90A766F
        for <linux-can@vger.kernel.org>; Wed, 21 Dec 2022 07:25:48 -0800 (PST)
Received: by mail-ed1-x529.google.com with SMTP id c17so22426359edj.13
        for <linux-can@vger.kernel.org>; Wed, 21 Dec 2022 07:25:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=25T5buiJct4F2Qt5zVUUN9CA8mwo1WMtnKkPLLIV3kA=;
        b=1c8AfhC3Ur9TqK1Z7HDC/dZOmCzNppS0f7O/CcrgO2/LQ/+vijBcIdwQfQ6Qo45kYG
         5WE7kHQv6QsDd0Uq0NQ4ahbqz9iG88Gc5xlruJpSdUIq3kPIzqWFa3o6hqpr/KbLUlf5
         /mgOQqbdxjH9H8BWr7Npz4LwNubw98FKQoLFciUVupsc1REtrExj9Jv3Zv6A/sLghqkI
         KopXHmPu1VX+N8H3uL3Ay6OUJyZOJgyZrD8mfx7+lTVS7qUtbsqu97nj09sxa1Ellv+x
         l4ysG8Gb2MYN7xwxly0O6bLfiI71HSGh9FY0s2xPfA8B2sTbhZ2C3LTaeLkdBI/NLd9b
         SxfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=25T5buiJct4F2Qt5zVUUN9CA8mwo1WMtnKkPLLIV3kA=;
        b=oYmUozRR0r88JnkFZO8szZz7Q1Yuu+haLwL4ZwysDLlN1KEqMB3bZ2mprMwCgJJ39B
         ZwTHXnQn3ywiJtYXTl1qkmewpadKUvA+ETmoA8sDiTLCN1tNK1b1sLRspdMJ9MwnpxVi
         7NeFD697xVfntF0ddGMHPZq2R5uDr+tXAKJigEZQD33WF5sT4J08PYl7PUgm8VnDXtA6
         +QnmIRZqGqA2QtrM18ps84urAbfcoOqCZ8gY3yDkneZR0HOTtzKEJP99iWfkFLH3sL4t
         8bQk0kWE+8SOAX6Nbg4OTFBegGPKiXKsOgqnSiO6LTMQGVznz1p8jYdtheJm0KClYNpO
         qQVA==
X-Gm-Message-State: AFqh2kolo82MoCN5SZXk3IKW8cKzxPlkxTWAC0mYu+bfUM0PifAc5VVJ
        UNU3I8AcTVUT/GFXX+VF8zVq3w==
X-Google-Smtp-Source: AMrXdXvpSUCVFTU6qxbEQy/CnU78qP0eUBwT3evnk/1igmMGRb7z8ZJJq250w8kXpFy1Fbw+QHr8Uw==
X-Received: by 2002:a05:6402:790:b0:470:1e5a:a333 with SMTP id d16-20020a056402079000b004701e5aa333mr1648304edy.34.1671636348039;
        Wed, 21 Dec 2022 07:25:48 -0800 (PST)
Received: from blmsp.fritz.box ([2001:4091:a245:805c:8713:84e4:2a9e:cbe8])
        by smtp.gmail.com with ESMTPSA id n19-20020aa7c793000000b0045cf4f72b04sm7105428eds.94.2022.12.21.07.25.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Dec 2022 07:25:47 -0800 (PST)
From:   Markus Schneider-Pargmann <msp@baylibre.com>
To:     Marc Kleine-Budde <mkl@pengutronix.de>,
        Chandrasekar Ramakrishnan <rcsekar@samsung.com>,
        Wolfgang Grandegger <wg@grandegger.com>
Cc:     Vincent MAILHOL <mailhol.vincent@wanadoo.fr>,
        linux-can@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Markus Schneider-Pargmann <msp@baylibre.com>
Subject: [PATCH 08/18] can: m_can: Write transmit header and data in one transaction
Date:   Wed, 21 Dec 2022 16:25:27 +0100
Message-Id: <20221221152537.751564-9-msp@baylibre.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221221152537.751564-1-msp@baylibre.com>
References: <20221221152537.751564-1-msp@baylibre.com>
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
index bcd3bcdc5123..9b5ad222aef7 100644
--- a/drivers/net/can/m_can/m_can.c
+++ b/drivers/net/can/m_can/m_can.c
@@ -1657,6 +1657,7 @@ static netdev_tx_t m_can_tx_handler(struct m_can_classdev *cdev)
 		m_can_write(cdev, M_CAN_TXBAR, 0x1);
 		/* End of xmit function for version 3.0.x */
 	} else {
+		char buf[TXB_ELEMENT_SIZE];
 		/* Transmit routine for version >= v3.1.x */
 
 		txfqs = m_can_read(cdev, M_CAN_TXFQS);
@@ -1696,12 +1697,11 @@ static netdev_tx_t m_can_tx_handler(struct m_can_classdev *cdev)
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
2.38.1

