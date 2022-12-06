Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 42E4A6442B1
	for <lists+linux-can@lfdr.de>; Tue,  6 Dec 2022 12:58:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235108AbiLFL6A (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Tue, 6 Dec 2022 06:58:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234857AbiLFL5o (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 6 Dec 2022 06:57:44 -0500
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3A1C642F
        for <linux-can@vger.kernel.org>; Tue,  6 Dec 2022 03:57:42 -0800 (PST)
Received: by mail-ej1-x636.google.com with SMTP id m18so4048237eji.5
        for <linux-can@vger.kernel.org>; Tue, 06 Dec 2022 03:57:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AsKoU9M+5cIpcCQPCOg/6Uvu2CSKHlAbnecsoPfhR2A=;
        b=S8E2gky0aD2LAAceaAf9+51yBgoDUwQ456G2qknYvpGcW+Lv1KIaqhFMZFAwnCxkyl
         mqYFr3NvLPQUJM8f5uQ+00DHBz5y9cw1EVN21AE5Mjg5n3j7GYGERfWykh5L5Q+epIrS
         iRxkfKU1jo2HLqGNC0K/ZUG7PbJrUxn1NPFJ3kYKaMlf9FWHnFPyI/IVhDDJ8pBX+9KJ
         Md/wa6c/nTFApV5QUcks/mV7ntMyjveqvnvIMgZDZRn9561Tktlawkq1bDl25OYYgGZn
         fs/oPsxBMD1bx1vwI/U1Op25szWAu96FHguNXJ4Fm36Zu2+t+1keu7i0nCwFSSiw7HZ1
         RAcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AsKoU9M+5cIpcCQPCOg/6Uvu2CSKHlAbnecsoPfhR2A=;
        b=hhFI7cVv5QbTV8rf6SdhyB13VsXhPuawTSuZpkohG2di+HO82o7OgyDnNRB7cOPjIU
         sfnumuhET7TWHEl8F8/poxt5A3nY+4iZl29fueilYZz4C/GYwiHjmP/hhSOoM3uWms1a
         2ORtUdLsdLE5Ceqic8DXYeRKpIcvDT6OfMp4kA5xM0BD5YV/jEoYjm1SDZ3U52OX3W9w
         No20ZbcpyIdMBFJdO43GeRpY/7QdpChtCF6rL98f5UwDjPo/BlcXap+RxGQRzX1sMSdc
         Sq0BeF/Hx66U1lEvkzRuRoLdM2u/K2XHikD3hRgm6xzwnpOp2N6wmsxopMJWUSG4pab0
         sLqw==
X-Gm-Message-State: ANoB5plUHNi7RRF/4dFe8WytlEko2RmTG2mZvibvQtSvG5iu2CEHtkpp
        TytU24TzR35e9VaBso0l/HTXCA==
X-Google-Smtp-Source: AA0mqf5EGw2ZYPiRp+1wOueTLChciZ1I3gaAecnWP7Tl3f1EVPz2ufk8vb8tJCbslJ98ULsN9W9cyA==
X-Received: by 2002:a17:906:6acc:b0:78d:b371:16e5 with SMTP id q12-20020a1709066acc00b0078db37116e5mr58056102ejs.456.1670327860866;
        Tue, 06 Dec 2022 03:57:40 -0800 (PST)
Received: from blmsp.fritz.box ([2001:4091:a245:805c:8713:84e4:2a9e:cbe8])
        by smtp.gmail.com with ESMTPSA id ky20-20020a170907779400b007c0ac4e6b6esm6472076ejc.143.2022.12.06.03.57.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Dec 2022 03:57:40 -0800 (PST)
From:   Markus Schneider-Pargmann <msp@baylibre.com>
To:     Chandrasekar Ramakrishnan <rcsekar@samsung.com>,
        Marc Kleine-Budde <mkl@pengutronix.de>,
        Wolfgang Grandegger <wg@grandegger.com>
Cc:     linux-can@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Markus Schneider-Pargmann <msp@baylibre.com>
Subject: [PATCH v2 06/11] can: m_can: Batch acknowledge transmit events
Date:   Tue,  6 Dec 2022 12:57:23 +0100
Message-Id: <20221206115728.1056014-7-msp@baylibre.com>
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

Transmit events from the txe fifo can be batch acknowledged by
acknowledging the last read txe fifo item. This will save txe_count
writes which is important for peripheral chips.

Signed-off-by: Markus Schneider-Pargmann <msp@baylibre.com>
---
 drivers/net/can/m_can/m_can.c | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/drivers/net/can/m_can/m_can.c b/drivers/net/can/m_can/m_can.c
index a0ae543d418c..5572a6b3b94c 100644
--- a/drivers/net/can/m_can/m_can.c
+++ b/drivers/net/can/m_can/m_can.c
@@ -1013,7 +1013,9 @@ static int m_can_echo_tx_event(struct net_device *dev)
 	u32 txe_count = 0;
 	u32 m_can_txefs;
 	u32 fgi = 0;
+	int ack_fgi = -1;
 	int i = 0;
+	int err = 0;
 	unsigned int msg_mark;
 
 	struct m_can_classdev *cdev = netdev_priv(dev);
@@ -1028,28 +1030,29 @@ static int m_can_echo_tx_event(struct net_device *dev)
 	/* Get and process all sent elements */
 	for (i = 0; i < txe_count; i++) {
 		u32 txe, timestamp = 0;
-		int err;
 
 		/* get message marker, timestamp */
 		err = m_can_txe_fifo_read(cdev, fgi, 4, &txe);
 		if (err) {
 			netdev_err(dev, "TXE FIFO read returned %d\n", err);
-			return err;
+			break;
 		}
 
 		msg_mark = FIELD_GET(TX_EVENT_MM_MASK, txe);
 		timestamp = FIELD_GET(TX_EVENT_TXTS_MASK, txe) << 16;
 
-		/* ack txe element */
-		m_can_write(cdev, M_CAN_TXEFA, FIELD_PREP(TXEFA_EFAI_MASK,
-							  fgi));
+		ack_fgi = fgi;
 		fgi = (++fgi >= cdev->mcfg[MRAM_TXE].num ? 0 : fgi);
 
 		/* update stats */
 		m_can_tx_update_stats(cdev, msg_mark, timestamp);
 	}
 
-	return 0;
+	if (ack_fgi != -1)
+		m_can_write(cdev, M_CAN_TXEFA, FIELD_PREP(TXEFA_EFAI_MASK,
+							  ack_fgi));
+
+	return err;
 }
 
 static irqreturn_t m_can_isr(int irq, void *dev_id)
-- 
2.38.1

