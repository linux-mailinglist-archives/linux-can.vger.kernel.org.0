Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 20570571F50
	for <lists+linux-can@lfdr.de>; Tue, 12 Jul 2022 17:33:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233553AbiGLPc4 (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Tue, 12 Jul 2022 11:32:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233859AbiGLPcp (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 12 Jul 2022 11:32:45 -0400
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3CA7B31F7
        for <linux-can@vger.kernel.org>; Tue, 12 Jul 2022 08:32:42 -0700 (PDT)
Received: by mail-pg1-x534.google.com with SMTP id g4so7924018pgc.1
        for <linux-can@vger.kernel.org>; Tue, 12 Jul 2022 08:32:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Cbe5r17Qr1Fi9psGEWZQvYF8XA4F/4TpxePpAGyYFLI=;
        b=UhsX6J4w0r9uz2+PaPDe6fq7dzhKeKvpjban2juo/vQAlN6BfZriYssFPY1vD3XP6f
         w+wDssT0qX7htP0Nb8RFj5lfmfDITGewUQsMvAo0A5B5FYKeQ1UZBxTzaWEzgKA0+7WU
         y4En9IQy6rIAKj/W5HTaF8EhDJMguxhJlVM+D3CMURN/rkbld3ead7LUiWlA3cX8edo6
         bU3UDl+lCbXMD36oETVsvoBq2w4VDcaaDxYAOc53L5KzEY6EpGdrqfyKBAxDNEEvWU7b
         3s+hP9pKjvCJ9KX9MbfJP/0+0SkcZ5zsGl0l7gJhmDmaB4pQOVgNX30IWYFs5f6eINkn
         544A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=Cbe5r17Qr1Fi9psGEWZQvYF8XA4F/4TpxePpAGyYFLI=;
        b=kEvUxkZoqy6qbgfJNF62O0sY6sFBU6BvB0pDQv2YkkzjdqRs9itG3PL5RFNyUAm9QJ
         zrIVrZHPIqOtba5YTyDtoKdEfbLaAAu9JtCRdiQTo/Z99hV7q9Vv9zuJJpTjacLCuIPZ
         pIBY1XyNZ3jydzyp0h1BaACVLtTKj3Ys+Kro90Vg7OU0HQCjf/fUATL6bwUsVosZ5ecO
         aGs2eJlf3LhZBYT5TYc65l8m8RacoNEK02QLZS/OF2Rl/1F9wPqhBCRVH3qwdl52JzFR
         n0PvDSrDlxS4X/O9tRp3Japn07gsmRqkjn7rfzXVLoEAFukdso3cEbGoa/jgfghLFFqI
         jdDQ==
X-Gm-Message-State: AJIora8BmNgK152ScMdDQNazDcoTRF2GvSkkBao/m1PtBQORZyHJiYYe
        7JNSxxANQQ+OSIF4f7rPvkl0QOUm3KPRpQ==
X-Google-Smtp-Source: AGRyM1u9EGmr2K4YZQcBqHRdGJ6tlsWrjT/085pobYHUwL04Ng+LijLvB0cAORfLTv8iBLkCb6q51w==
X-Received: by 2002:a63:2785:0:b0:413:655d:fb0 with SMTP id n127-20020a632785000000b00413655d0fb0mr21296176pgn.297.1657639961485;
        Tue, 12 Jul 2022 08:32:41 -0700 (PDT)
Received: from localhost.localdomain (124x33x176x97.ap124.ftth.ucom.ne.jp. [124.33.176.97])
        by smtp.gmail.com with ESMTPSA id c131-20020a621c89000000b005252defb016sm6891483pfc.122.2022.07.12.08.32.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Jul 2022 08:32:41 -0700 (PDT)
Sender: Vincent Mailhol <vincent.mailhol@gmail.com>
From:   Vincent Mailhol <mailhol.vincent@wanadoo.fr>
To:     linux-can@vger.kernel.org
Cc:     Marc Kleine-Budde <mkl@pengutronix.de>,
        Frank Jungclaus <frank.jungclaus@esd.eu>,
        Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Subject: [PATCH v1 11/12] can: add CAN_ERR_CNT flag to notify availability of error counter
Date:   Wed, 13 Jul 2022 00:31:56 +0900
Message-Id: <20220712153157.83847-12-mailhol.vincent@wanadoo.fr>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220712153157.83847-1-mailhol.vincent@wanadoo.fr>
References: <20220712153157.83847-1-mailhol.vincent@wanadoo.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_FILL_THIS_FORM_SHORT,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Add a dedicated flag in uapi/linux/can/error.h to notify the userland
that fields data[6] and data[7] of the CAN error frame were
respectively populated with the tx and rx error counters.

For all driver tree-wide, set up this flags whenever needed.

Signed-off-by: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
---
 drivers/net/can/c_can/c_can_main.c                | 6 +++---
 drivers/net/can/cc770/cc770.c                     | 1 +
 drivers/net/can/ctucanfd/ctucanfd_base.c          | 5 +++--
 drivers/net/can/grcan.c                           | 1 +
 drivers/net/can/ifi_canfd/ifi_canfd.c             | 4 ++--
 drivers/net/can/janz-ican3.c                      | 4 ++--
 drivers/net/can/kvaser_pciefd.c                   | 2 +-
 drivers/net/can/m_can/m_can.c                     | 4 ++--
 drivers/net/can/pch_can.c                         | 1 +
 drivers/net/can/peak_canfd/peak_canfd.c           | 6 +++---
 drivers/net/can/rcar/rcar_can.c                   | 1 +
 drivers/net/can/rcar/rcar_canfd.c                 | 4 ++--
 drivers/net/can/sja1000/sja1000.c                 | 1 +
 drivers/net/can/slcan/slcan-core.c                | 1 +
 drivers/net/can/spi/hi311x.c                      | 1 +
 drivers/net/can/spi/mcp251xfd/mcp251xfd-core.c    | 1 +
 drivers/net/can/sun4i_can.c                       | 1 +
 drivers/net/can/ti_hecc.c                         | 1 +
 drivers/net/can/usb/esd_usb.c                     | 3 ++-
 drivers/net/can/usb/kvaser_usb/kvaser_usb_hydra.c | 2 ++
 drivers/net/can/usb/kvaser_usb/kvaser_usb_leaf.c  | 1 +
 drivers/net/can/usb/peak_usb/pcan_usb.c           | 1 +
 drivers/net/can/usb/usb_8dev.c                    | 1 +
 drivers/net/can/xilinx_can.c                      | 1 +
 include/uapi/linux/can/error.h                    | 2 ++
 25 files changed, 38 insertions(+), 18 deletions(-)

diff --git a/drivers/net/can/c_can/c_can_main.c b/drivers/net/can/c_can/c_can_main.c
index a7362af0babb..0387626eb054 100644
--- a/drivers/net/can/c_can/c_can_main.c
+++ b/drivers/net/can/c_can/c_can_main.c
@@ -953,14 +953,14 @@ static int c_can_handle_state_change(struct net_device *dev,
 	switch (error_type) {
 	case C_CAN_NO_ERROR:
 		/* error warning state */
-		cf->can_id |= CAN_ERR_CRTL;
+		cf->can_id |= CAN_ERR_CRTL | CAN_ERR_CNT;
 		cf->data[1] = CAN_ERR_CRTL_ACTIVE;
 		cf->data[6] = bec.txerr;
 		cf->data[7] = bec.rxerr;
 		break;
 	case C_CAN_ERROR_WARNING:
 		/* error warning state */
-		cf->can_id |= CAN_ERR_CRTL;
+		cf->can_id |= CAN_ERR_CRTL | CAN_ERR_CNT;
 		cf->data[1] = (bec.txerr > bec.rxerr) ?
 			CAN_ERR_CRTL_TX_WARNING :
 			CAN_ERR_CRTL_RX_WARNING;
@@ -970,7 +970,7 @@ static int c_can_handle_state_change(struct net_device *dev,
 		break;
 	case C_CAN_ERROR_PASSIVE:
 		/* error passive state */
-		cf->can_id |= CAN_ERR_CRTL;
+		cf->can_id |= CAN_ERR_CRTL | CAN_ERR_CNT;
 		if (rx_err_passive)
 			cf->data[1] |= CAN_ERR_CRTL_RX_PASSIVE;
 		if (bec.txerr > 127)
diff --git a/drivers/net/can/cc770/cc770.c b/drivers/net/can/cc770/cc770.c
index bb7224cfc6ab..797a954bb1a0 100644
--- a/drivers/net/can/cc770/cc770.c
+++ b/drivers/net/can/cc770/cc770.c
@@ -512,6 +512,7 @@ static int cc770_err(struct net_device *dev, u8 status)
 
 	/* Use extended functions of the CC770 */
 	if (priv->control_normal_mode & CTRL_EAF) {
+		cf->can_id |= CAN_ERR_CNT;
 		cf->data[6] = cc770_read_reg(priv, tx_error_counter);
 		cf->data[7] = cc770_read_reg(priv, rx_error_counter);
 	}
diff --git a/drivers/net/can/ctucanfd/ctucanfd_base.c b/drivers/net/can/ctucanfd/ctucanfd_base.c
index 14ac7c0ee04c..6b281f6eb9b4 100644
--- a/drivers/net/can/ctucanfd/ctucanfd_base.c
+++ b/drivers/net/can/ctucanfd/ctucanfd_base.c
@@ -847,7 +847,7 @@ static void ctucan_err_interrupt(struct net_device *ndev, u32 isr)
 		case CAN_STATE_ERROR_PASSIVE:
 			priv->can.can_stats.error_passive++;
 			if (skb) {
-				cf->can_id |= CAN_ERR_CRTL;
+				cf->can_id |= CAN_ERR_CRTL | CAN_ERR_CNT;
 				cf->data[1] = (bec.rxerr > 127) ?
 						CAN_ERR_CRTL_RX_PASSIVE :
 						CAN_ERR_CRTL_TX_PASSIVE;
@@ -858,7 +858,7 @@ static void ctucan_err_interrupt(struct net_device *ndev, u32 isr)
 		case CAN_STATE_ERROR_WARNING:
 			priv->can.can_stats.error_warning++;
 			if (skb) {
-				cf->can_id |= CAN_ERR_CRTL;
+				cf->can_id |= CAN_ERR_CRTL | CAN_ERR_CNT;
 				cf->data[1] |= (bec.txerr > bec.rxerr) ?
 					CAN_ERR_CRTL_TX_WARNING :
 					CAN_ERR_CRTL_RX_WARNING;
@@ -867,6 +867,7 @@ static void ctucan_err_interrupt(struct net_device *ndev, u32 isr)
 			}
 			break;
 		case CAN_STATE_ERROR_ACTIVE:
+			cf->can_id |= CAN_ERR_CNT;
 			cf->data[1] = CAN_ERR_CRTL_ACTIVE;
 			cf->data[6] = bec.txerr;
 			cf->data[7] = bec.rxerr;
diff --git a/drivers/net/can/grcan.c b/drivers/net/can/grcan.c
index 76df4807d366..8229ca2ee389 100644
--- a/drivers/net/can/grcan.c
+++ b/drivers/net/can/grcan.c
@@ -671,6 +671,7 @@ static void grcan_err(struct net_device *dev, u32 sources, u32 status)
 				/* There are no others at this point */
 				break;
 			}
+			cf.can_id |= CAN_ERR_CNT;
 			cf.data[6] = txerr;
 			cf.data[7] = rxerr;
 			priv->can.state = state;
diff --git a/drivers/net/can/ifi_canfd/ifi_canfd.c b/drivers/net/can/ifi_canfd/ifi_canfd.c
index 968ed6d7316b..64e3be8b73af 100644
--- a/drivers/net/can/ifi_canfd/ifi_canfd.c
+++ b/drivers/net/can/ifi_canfd/ifi_canfd.c
@@ -492,7 +492,7 @@ static int ifi_canfd_handle_state_change(struct net_device *ndev,
 	switch (new_state) {
 	case CAN_STATE_ERROR_WARNING:
 		/* error warning state */
-		cf->can_id |= CAN_ERR_CRTL;
+		cf->can_id |= CAN_ERR_CRTL | CAN_ERR_CNT;
 		cf->data[1] = (bec.txerr > bec.rxerr) ?
 			CAN_ERR_CRTL_TX_WARNING :
 			CAN_ERR_CRTL_RX_WARNING;
@@ -501,7 +501,7 @@ static int ifi_canfd_handle_state_change(struct net_device *ndev,
 		break;
 	case CAN_STATE_ERROR_PASSIVE:
 		/* error passive state */
-		cf->can_id |= CAN_ERR_CRTL;
+		cf->can_id |= CAN_ERR_CRTL | CAN_ERR_CNT;
 		cf->data[1] |= CAN_ERR_CRTL_RX_PASSIVE;
 		if (bec.txerr > 127)
 			cf->data[1] |= CAN_ERR_CRTL_TX_PASSIVE;
diff --git a/drivers/net/can/janz-ican3.c b/drivers/net/can/janz-ican3.c
index 35bfb82d6929..ccb5c5405224 100644
--- a/drivers/net/can/janz-ican3.c
+++ b/drivers/net/can/janz-ican3.c
@@ -1127,7 +1127,7 @@ static int ican3_handle_cevtind(struct ican3_dev *mod, struct ican3_msg *msg)
 	/* bus error interrupt */
 	if (isrc == CEVTIND_BEI) {
 		mod->can.can_stats.bus_error++;
-		cf->can_id |= CAN_ERR_PROT | CAN_ERR_BUSERROR;
+		cf->can_id |= CAN_ERR_PROT | CAN_ERR_BUSERROR | CAN_ERR_CNT;
 
 		switch (ecc & ECC_MASK) {
 		case ECC_BIT:
@@ -1153,7 +1153,7 @@ static int ican3_handle_cevtind(struct ican3_dev *mod, struct ican3_msg *msg)
 
 	if (state != mod->can.state && (state == CAN_STATE_ERROR_WARNING ||
 					state == CAN_STATE_ERROR_PASSIVE)) {
-		cf->can_id |= CAN_ERR_CRTL;
+		cf->can_id |= CAN_ERR_CRTL | CAN_ERR_CNT;
 		if (state == CAN_STATE_ERROR_WARNING) {
 			mod->can.can_stats.error_warning++;
 			cf->data[1] = (txerr > rxerr) ?
diff --git a/drivers/net/can/kvaser_pciefd.c b/drivers/net/can/kvaser_pciefd.c
index 017f2d36ffc3..dcd2c9d50d5e 100644
--- a/drivers/net/can/kvaser_pciefd.c
+++ b/drivers/net/can/kvaser_pciefd.c
@@ -1306,7 +1306,7 @@ static int kvaser_pciefd_rx_error_frame(struct kvaser_pciefd_can *can,
 	shhwtstamps->hwtstamp =
 		ns_to_ktime(div_u64(p->timestamp * 1000,
 				    can->kv_pcie->freq_to_ticks_div));
-	cf->can_id |= CAN_ERR_BUSERROR;
+	cf->can_id |= CAN_ERR_BUSERROR | CAN_ERR_CNT;
 
 	cf->data[6] = bec.txerr;
 	cf->data[7] = bec.rxerr;
diff --git a/drivers/net/can/m_can/m_can.c b/drivers/net/can/m_can/m_can.c
index 4f90e17354f2..74efcde54c83 100644
--- a/drivers/net/can/m_can/m_can.c
+++ b/drivers/net/can/m_can/m_can.c
@@ -741,7 +741,7 @@ static int m_can_handle_state_change(struct net_device *dev,
 	switch (new_state) {
 	case CAN_STATE_ERROR_WARNING:
 		/* error warning state */
-		cf->can_id |= CAN_ERR_CRTL;
+		cf->can_id |= CAN_ERR_CRTL | CAN_ERR_CNT;
 		cf->data[1] = (bec.txerr > bec.rxerr) ?
 			CAN_ERR_CRTL_TX_WARNING :
 			CAN_ERR_CRTL_RX_WARNING;
@@ -750,7 +750,7 @@ static int m_can_handle_state_change(struct net_device *dev,
 		break;
 	case CAN_STATE_ERROR_PASSIVE:
 		/* error passive state */
-		cf->can_id |= CAN_ERR_CRTL;
+		cf->can_id |= CAN_ERR_CRTL | CAN_ERR_CNT;
 		ecr = m_can_read(cdev, M_CAN_ECR);
 		if (ecr & ECR_RP)
 			cf->data[1] |= CAN_ERR_CRTL_RX_PASSIVE;
diff --git a/drivers/net/can/pch_can.c b/drivers/net/can/pch_can.c
index 497ef77340ea..50f6719b3aa4 100644
--- a/drivers/net/can/pch_can.c
+++ b/drivers/net/can/pch_can.c
@@ -497,6 +497,7 @@ static void pch_can_error(struct net_device *ndev, u32 status)
 		priv->can.can_stats.bus_off++;
 		can_bus_off(ndev);
 	} else {
+		cf->can_id |= CAN_ERR_CNT;
 		cf->data[6] = errc & PCH_TEC;
 		cf->data[7] = (errc & PCH_REC) >> 8;
 	}
diff --git a/drivers/net/can/peak_canfd/peak_canfd.c b/drivers/net/can/peak_canfd/peak_canfd.c
index b2dea360813d..afb9adb3d5c2 100644
--- a/drivers/net/can/peak_canfd/peak_canfd.c
+++ b/drivers/net/can/peak_canfd/peak_canfd.c
@@ -373,7 +373,7 @@ static int pucan_handle_status(struct peak_canfd_priv *priv,
 		priv->can.state = CAN_STATE_ERROR_PASSIVE;
 		priv->can.can_stats.error_passive++;
 		if (skb) {
-			cf->can_id |= CAN_ERR_CRTL;
+			cf->can_id |= CAN_ERR_CRTL | CAN_ERR_CNT;
 			cf->data[1] = (priv->bec.txerr > priv->bec.rxerr) ?
 					CAN_ERR_CRTL_TX_PASSIVE :
 					CAN_ERR_CRTL_RX_PASSIVE;
@@ -386,7 +386,7 @@ static int pucan_handle_status(struct peak_canfd_priv *priv,
 		priv->can.state = CAN_STATE_ERROR_WARNING;
 		priv->can.can_stats.error_warning++;
 		if (skb) {
-			cf->can_id |= CAN_ERR_CRTL;
+			cf->can_id |= CAN_ERR_CRTL | CAN_ERR_CNT;
 			cf->data[1] = (priv->bec.txerr > priv->bec.rxerr) ?
 					CAN_ERR_CRTL_TX_WARNING :
 					CAN_ERR_CRTL_RX_WARNING;
@@ -430,7 +430,7 @@ static int pucan_handle_cache_critical(struct peak_canfd_priv *priv)
 		return -ENOMEM;
 	}
 
-	cf->can_id |= CAN_ERR_CRTL;
+	cf->can_id |= CAN_ERR_CRTL | CAN_ERR_CNT;
 	cf->data[1] = CAN_ERR_CRTL_RX_OVERFLOW;
 
 	cf->data[6] = priv->bec.txerr;
diff --git a/drivers/net/can/rcar/rcar_can.c b/drivers/net/can/rcar/rcar_can.c
index 24d7a71def6a..d11db2112a4a 100644
--- a/drivers/net/can/rcar/rcar_can.c
+++ b/drivers/net/can/rcar/rcar_can.c
@@ -334,6 +334,7 @@ static void rcar_can_error(struct net_device *ndev)
 		if (skb)
 			cf->can_id |= CAN_ERR_BUSOFF;
 	} else if (skb) {
+		cf->can_id |= CAN_ERR_CNT;
 		cf->data[6] = txerr;
 		cf->data[7] = rxerr;
 	}
diff --git a/drivers/net/can/rcar/rcar_canfd.c b/drivers/net/can/rcar/rcar_canfd.c
index 40a11445d021..a53804a9483a 100644
--- a/drivers/net/can/rcar/rcar_canfd.c
+++ b/drivers/net/can/rcar/rcar_canfd.c
@@ -1052,7 +1052,7 @@ static void rcar_canfd_error(struct net_device *ndev, u32 cerfl,
 		netdev_dbg(ndev, "Error warning interrupt\n");
 		priv->can.state = CAN_STATE_ERROR_WARNING;
 		priv->can.can_stats.error_warning++;
-		cf->can_id |= CAN_ERR_CRTL;
+		cf->can_id |= CAN_ERR_CRTL | CAN_ERR_CNT;
 		cf->data[1] = txerr > rxerr ? CAN_ERR_CRTL_TX_WARNING :
 			CAN_ERR_CRTL_RX_WARNING;
 		cf->data[6] = txerr;
@@ -1062,7 +1062,7 @@ static void rcar_canfd_error(struct net_device *ndev, u32 cerfl,
 		netdev_dbg(ndev, "Error passive interrupt\n");
 		priv->can.state = CAN_STATE_ERROR_PASSIVE;
 		priv->can.can_stats.error_passive++;
-		cf->can_id |= CAN_ERR_CRTL;
+		cf->can_id |= CAN_ERR_CRTL | CAN_ERR_CNT;
 		cf->data[1] = txerr > rxerr ? CAN_ERR_CRTL_TX_PASSIVE :
 			CAN_ERR_CRTL_RX_PASSIVE;
 		cf->data[6] = txerr;
diff --git a/drivers/net/can/sja1000/sja1000.c b/drivers/net/can/sja1000/sja1000.c
index 84adf8b5945e..bbfd5323fffb 100644
--- a/drivers/net/can/sja1000/sja1000.c
+++ b/drivers/net/can/sja1000/sja1000.c
@@ -424,6 +424,7 @@ static int sja1000_err(struct net_device *dev, uint8_t isrc, uint8_t status)
 			state = CAN_STATE_ERROR_ACTIVE;
 	}
 	if (state != CAN_STATE_BUS_OFF) {
+		cf->can_id |= CAN_ERR_CNT;
 		cf->data[6] = txerr;
 		cf->data[7] = rxerr;
 	}
diff --git a/drivers/net/can/slcan/slcan-core.c b/drivers/net/can/slcan/slcan-core.c
index d4137cd9cd97..fcbf6faa4eea 100644
--- a/drivers/net/can/slcan/slcan-core.c
+++ b/drivers/net/can/slcan/slcan-core.c
@@ -314,6 +314,7 @@ static void slc_bump_state(struct slcan *sl)
 	if (state == CAN_STATE_BUS_OFF) {
 		can_bus_off(dev);
 	} else if (skb) {
+		cf->can_id |= CAN_ERR_CNT;
 		cf->data[6] = txerr;
 		cf->data[7] = rxerr;
 	}
diff --git a/drivers/net/can/spi/hi311x.c b/drivers/net/can/spi/hi311x.c
index bfb7c4bb5bc3..167114aae6dd 100644
--- a/drivers/net/can/spi/hi311x.c
+++ b/drivers/net/can/spi/hi311x.c
@@ -680,6 +680,7 @@ static irqreturn_t hi3110_can_ist(int irq, void *dev_id)
 					break;
 				}
 			} else {
+				cf->can_id |= CAN_ERR_CNT;
 				cf->data[6] = txerr;
 				cf->data[7] = rxerr;
 			}
diff --git a/drivers/net/can/spi/mcp251xfd/mcp251xfd-core.c b/drivers/net/can/spi/mcp251xfd/mcp251xfd-core.c
index b21252390216..57c7282bc069 100644
--- a/drivers/net/can/spi/mcp251xfd/mcp251xfd-core.c
+++ b/drivers/net/can/spi/mcp251xfd/mcp251xfd-core.c
@@ -1098,6 +1098,7 @@ static int mcp251xfd_handle_cerrif(struct mcp251xfd_priv *priv)
 		err = mcp251xfd_get_berr_counter(priv->ndev, &bec);
 		if (err)
 			return err;
+		cf->can_id |= CAN_ERR_CNT;
 		cf->data[6] = bec.txerr;
 		cf->data[7] = bec.rxerr;
 	}
diff --git a/drivers/net/can/sun4i_can.c b/drivers/net/can/sun4i_can.c
index afe9b541f037..b90dfb429ccd 100644
--- a/drivers/net/can/sun4i_can.c
+++ b/drivers/net/can/sun4i_can.c
@@ -566,6 +566,7 @@ static int sun4i_can_err(struct net_device *dev, u8 isrc, u8 status)
 			state = CAN_STATE_ERROR_ACTIVE;
 	}
 	if (skb && state != CAN_STATE_BUS_OFF) {
+		cf->can_id |= CAN_ERR_CNT;
 		cf->data[6] = txerr;
 		cf->data[7] = rxerr;
 	}
diff --git a/drivers/net/can/ti_hecc.c b/drivers/net/can/ti_hecc.c
index debe17bfd0f0..afa38771520e 100644
--- a/drivers/net/can/ti_hecc.c
+++ b/drivers/net/can/ti_hecc.c
@@ -662,6 +662,7 @@ static void ti_hecc_change_state(struct net_device *ndev,
 	can_change_state(priv->ndev, cf, tx_state, rx_state);
 
 	if (max(tx_state, rx_state) != CAN_STATE_BUS_OFF) {
+		cf->can_id |= CAN_ERR_CNT;
 		cf->data[6] = hecc_read(priv, HECC_CANTEC);
 		cf->data[7] = hecc_read(priv, HECC_CANREC);
 	}
diff --git a/drivers/net/can/usb/esd_usb.c b/drivers/net/can/usb/esd_usb.c
index 8a4bf2961f3d..177ed33e08d9 100644
--- a/drivers/net/can/usb/esd_usb.c
+++ b/drivers/net/can/usb/esd_usb.c
@@ -265,7 +265,8 @@ static void esd_usb_rx_event(struct esd_usb_net_priv *priv,
 			priv->can.can_stats.bus_error++;
 			stats->rx_errors++;
 
-			cf->can_id |= CAN_ERR_PROT | CAN_ERR_BUSERROR;
+			cf->can_id |= CAN_ERR_PROT | CAN_ERR_BUSERROR |
+				      CAN_ERR_CNT;
 
 			switch (ecc & SJA1000_ECC_MASK) {
 			case SJA1000_ECC_BIT:
diff --git a/drivers/net/can/usb/kvaser_usb/kvaser_usb_hydra.c b/drivers/net/can/usb/kvaser_usb/kvaser_usb_hydra.c
index af27f0f9aca2..49be859cd742 100644
--- a/drivers/net/can/usb/kvaser_usb/kvaser_usb_hydra.c
+++ b/drivers/net/can/usb/kvaser_usb/kvaser_usb_hydra.c
@@ -918,6 +918,7 @@ static void kvaser_usb_hydra_update_state(struct kvaser_usb_net_priv *priv,
 		priv->can.can_stats.restarts++;
 
 	if (new_state != CAN_STATE_BUS_OFF) {
+		cf->can_id |= CAN_ERR_CNT;
 		cf->data[6] = bec->txerr;
 		cf->data[7] = bec->rxerr;
 	}
@@ -1072,6 +1073,7 @@ kvaser_usb_hydra_error_frame(struct kvaser_usb_net_priv *priv,
 
 	cf->can_id |= CAN_ERR_BUSERROR;
 	if (new_state != CAN_STATE_BUS_OFF) {
+		cf->can_id |= CAN_ERR_CNT;
 		cf->data[6] = bec.txerr;
 		cf->data[7] = bec.rxerr;
 	}
diff --git a/drivers/net/can/usb/kvaser_usb/kvaser_usb_leaf.c b/drivers/net/can/usb/kvaser_usb/kvaser_usb_leaf.c
index 088abeae30ad..91d3e8b4bccd 100644
--- a/drivers/net/can/usb/kvaser_usb/kvaser_usb_leaf.c
+++ b/drivers/net/can/usb/kvaser_usb/kvaser_usb_leaf.c
@@ -837,6 +837,7 @@ static void kvaser_usb_leaf_rx_error(const struct kvaser_usb *dev,
 	}
 
 	if (new_state != CAN_STATE_BUS_OFF) {
+		cf->can_id |= CAN_ERR_CNT;
 		cf->data[6] = es->txerr;
 		cf->data[7] = es->rxerr;
 	}
diff --git a/drivers/net/can/usb/peak_usb/pcan_usb.c b/drivers/net/can/usb/peak_usb/pcan_usb.c
index 091c631ebe23..d07b7ee79e3e 100644
--- a/drivers/net/can/usb/peak_usb/pcan_usb.c
+++ b/drivers/net/can/usb/peak_usb/pcan_usb.c
@@ -506,6 +506,7 @@ static int pcan_usb_decode_error(struct pcan_usb_msg_context *mc, u8 n,
 			/* Supply TX/RX error counters in case of
 			 * controller error.
 			 */
+			cf->can_id = CAN_ERR_CNT;
 			cf->data[6] = mc->pdev->bec.txerr;
 			cf->data[7] = mc->pdev->bec.rxerr;
 		}
diff --git a/drivers/net/can/usb/usb_8dev.c b/drivers/net/can/usb/usb_8dev.c
index 4d38dc90472a..8b7cd69e20b0 100644
--- a/drivers/net/can/usb/usb_8dev.c
+++ b/drivers/net/can/usb/usb_8dev.c
@@ -439,6 +439,7 @@ static void usb_8dev_rx_err_msg(struct usb_8dev_priv *priv,
 	if (rx_errors)
 		stats->rx_errors++;
 	if (priv->can.state != CAN_STATE_BUS_OFF) {
+		cf->can_id |= CAN_ERR_CNT;
 		cf->data[6] = txerr;
 		cf->data[7] = rxerr;
 	}
diff --git a/drivers/net/can/xilinx_can.c b/drivers/net/can/xilinx_can.c
index 393b2d9f9d2a..2c4a2975c338 100644
--- a/drivers/net/can/xilinx_can.c
+++ b/drivers/net/can/xilinx_can.c
@@ -965,6 +965,7 @@ static void xcan_set_error_state(struct net_device *ndev,
 	can_change_state(ndev, cf, tx_state, rx_state);
 
 	if (cf) {
+		cf->can_id |= CAN_ERR_CNT;
 		cf->data[6] = txerr;
 		cf->data[7] = rxerr;
 	}
diff --git a/include/uapi/linux/can/error.h b/include/uapi/linux/can/error.h
index 4eb7da568dde..a17ad25a01f9 100644
--- a/include/uapi/linux/can/error.h
+++ b/include/uapi/linux/can/error.h
@@ -57,6 +57,8 @@
 #define CAN_ERR_BUSOFF       0x00000040U /* bus off */
 #define CAN_ERR_BUSERROR     0x00000080U /* bus error (may flood!) */
 #define CAN_ERR_RESTARTED    0x00000100U /* controller restarted */
+#define CAN_ERR_CNT          0x00000200U /* TX error counter / data[6] */
+					 /* RX error counter / data[7] */
 
 /* arbitration lost in bit ... / data[0] */
 #define CAN_ERR_LOSTARB_UNSPEC   0x00 /* unspecified */
-- 
2.35.1

