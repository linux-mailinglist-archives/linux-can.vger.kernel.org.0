Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B211262CB99
	for <lists+linux-can@lfdr.de>; Wed, 16 Nov 2022 21:54:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234780AbiKPUyV (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Wed, 16 Nov 2022 15:54:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238019AbiKPUxx (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Wed, 16 Nov 2022 15:53:53 -0500
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B5C563DA
        for <linux-can@vger.kernel.org>; Wed, 16 Nov 2022 12:53:32 -0800 (PST)
Received: by mail-ej1-x634.google.com with SMTP id n20so99388ejh.0
        for <linux-can@vger.kernel.org>; Wed, 16 Nov 2022 12:53:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=35Qy5T8b8nZe0+fVvuZXlmUhh51OUfHfDykDW4uao6I=;
        b=aNitAnr3LnNKd7Q5VxgwDVTqryOo8InS88hIhNw4Tb7wa4GDJxed7sbIf24+anq4l9
         q75Js/1GYwp0hJcvNZkTAhj8RGqxK412V4pEGKnVo/d+10Y3oqGoHdJUIIvtzJJQrHfr
         rBL2myiZiFe/ZOusjxXo/+EAVDyAIr+Mh2eiH8yCdDy88lcjpKV87JePE/ondWp2B0ev
         uIUFFxsd/up3e5nTvGwZeRIoR59QxqDO7kVLH1BcORpYporP5mYi/uxrVsvBGNUb05IV
         JYlrYmwHf6bBuWaI/zaH52ZZX0SxFLQYkg4ghpknehpiYMJ7rYplySv0WsZpTswEt2FG
         ilIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=35Qy5T8b8nZe0+fVvuZXlmUhh51OUfHfDykDW4uao6I=;
        b=0zxcxQ1NfpSZVvAhKMpJDRZ/yzMIbR7jPR1s/5s4eGH4eBcrW1xM8x6hrNEwIYwHcC
         tL7N3/0mHOfnUhqNldujLlLu17wpCJzqLcNqMyot1ky8QYRRy03J5lbci43h8h5AXgFe
         x7qqx4oUyPS0jGJtkwMKqHXVaKqKDqaq+d34wk4zAIZu2vzhEFsWypRKnSrvzNILBuZl
         UPZ9Dgmq/SaFOG5f5mW4TAcuYbes6ACjJ3l8qSTiP/ObRRjPnX7/p4kV8Eb2vMXtCoYE
         Q1FzGCMi0MpUqP7s6etnfSs6WEx/n0Sb/+tuDAQI9jLTfWPLhLyvkKAZS4pro2YOxoG2
         74cQ==
X-Gm-Message-State: ANoB5pnHIj8iBKkDUJSkgnGmbBA2wvu8vdX/+kFN5GJ+yplt8hDV8Nwe
        jfzSAEvNcWiPFHUb45aVjydfKQ==
X-Google-Smtp-Source: AA0mqf7HY2USkPn+3T0jpTrYPnSr3gpyyheImn6zrscu4e9KMIjSwXBQbBlka7in7jHTRm4kWy7E2Q==
X-Received: by 2002:a17:907:98b6:b0:7ad:c0ec:7ad4 with SMTP id ju22-20020a17090798b600b007adc0ec7ad4mr18535259ejc.585.1668632012051;
        Wed, 16 Nov 2022 12:53:32 -0800 (PST)
Received: from blmsp.fritz.box ([2001:4090:a244:804b:353b:565:addf:3aa7])
        by smtp.gmail.com with ESMTPSA id kv17-20020a17090778d100b007aece68483csm6782828ejc.193.2022.11.16.12.53.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Nov 2022 12:53:31 -0800 (PST)
From:   Markus Schneider-Pargmann <msp@baylibre.com>
To:     Chandrasekar Ramakrishnan <rcsekar@samsung.com>,
        Marc Kleine-Budde <mkl@pengutronix.de>,
        Wolfgang Grandegger <wg@grandegger.com>
Cc:     linux-can@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Markus Schneider-Pargmann <msp@baylibre.com>
Subject: [PATCH 10/15] can: m_can: Batch acknowledge rx fifo
Date:   Wed, 16 Nov 2022 21:53:03 +0100
Message-Id: <20221116205308.2996556-11-msp@baylibre.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221116205308.2996556-1-msp@baylibre.com>
References: <20221116205308.2996556-1-msp@baylibre.com>
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

Instead of acknowledging every item of the fifo, only acknowledge the
last item read. This behavior is documented in the datasheet. The new
getindex will be the acknowledged item + 1.

Signed-off-by: Markus Schneider-Pargmann <msp@baylibre.com>
---
 drivers/net/can/m_can/m_can.c | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/drivers/net/can/m_can/m_can.c b/drivers/net/can/m_can/m_can.c
index 02fd7fe4e9f8..6179b9e815ed 100644
--- a/drivers/net/can/m_can/m_can.c
+++ b/drivers/net/can/m_can/m_can.c
@@ -530,9 +530,6 @@ static int m_can_read_fifo(struct net_device *dev, u32 fgi)
 	}
 	stats->rx_packets++;
 
-	/* acknowledge rx fifo 0 */
-	m_can_write(cdev, M_CAN_RXF0A, fgi);
-
 	timestamp = FIELD_GET(RX_BUF_RXTS_MASK, fifo_header.dlc) << 16;
 
 	m_can_receive_skb(cdev, skb, timestamp);
@@ -553,8 +550,9 @@ static int m_can_do_rx_poll(struct net_device *dev, int quota)
 	u32 rxfs;
 	u32 rx_count;
 	u32 fgi;
+	int ack_fgi = -1;
 	int i;
-	int err;
+	int err = 0;
 
 	rxfs = m_can_read(cdev, M_CAN_RXF0S);
 	if (!(rxfs & RXFS_FFL_MASK)) {
@@ -568,13 +566,20 @@ static int m_can_do_rx_poll(struct net_device *dev, int quota)
 	for (i = 0; i < rx_count && quota > 0; ++i) {
 		err = m_can_read_fifo(dev, fgi);
 		if (err)
-			return err;
+			break;
 
 		quota--;
 		pkts++;
+		ack_fgi = fgi;
 		fgi = (++fgi >= cdev->mcfg[MRAM_RXF0].num ? 0 : fgi);
 	}
 
+	if (ack_fgi != -1)
+		m_can_write(cdev, M_CAN_RXF0A, ack_fgi);
+
+	if (err)
+		return err;
+
 	return pkts;
 }
 
-- 
2.38.1

