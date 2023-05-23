Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B1C7A70D963
	for <lists+linux-can@lfdr.de>; Tue, 23 May 2023 11:45:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235175AbjEWJp1 (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Tue, 23 May 2023 05:45:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236238AbjEWJpW (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 23 May 2023 05:45:22 -0400
Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com [209.85.208.177])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EDED1A8
        for <linux-can@vger.kernel.org>; Tue, 23 May 2023 02:45:13 -0700 (PDT)
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-2af225e5b4bso53878201fa.3
        for <linux-can@vger.kernel.org>; Tue, 23 May 2023 02:45:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kvaser.com; s=google; t=1684835051; x=1687427051;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Oa7B8GEydmyfj0htsZqCe/cj3nA9mtvYayndQWD/16Y=;
        b=b1rraEaDRAgaPoQGPV+gaaGjYHGSTSWtIGE1nnwQKqaxVN/HvuGVBg+WRNWTSroTKp
         63DGG8EfTUCAvQnUdnAlnWK+2HLDCUiPQ/g8ISekq5QsbRXu+gmHmJqfs0xOy7cDjXsU
         GNbLUqpRP/5ajku7sFqFSRyiRPqEs7GLu5emhsJb6eLI7FtZlYj18nvaD5x3sxTZPVg/
         mItiatTMidrcEIX4yvqjj+4Y0ti/f09UZb2insUheE9AgG9Xywy/Il1cLIGxSVDRmXqq
         XGa2IJC9tzP1rCvnf2we9pU9us0TWgwitpf3B6SDhbhQvxZS0UGE1Tyue+A5nsPpUAGF
         LCKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684835051; x=1687427051;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Oa7B8GEydmyfj0htsZqCe/cj3nA9mtvYayndQWD/16Y=;
        b=YzPtDKAbGbpJQkmGU/rgD2qB4BGSc1GUlKjycII6bYE5ddCP9vU4jTLxOPcueaWXYl
         ZVFEUvIfGvTeSTDsMsjj1Z7SNLsnFoBN/j4XI7K3upzaZZNJEk6CXUB4nC7tVGGnXBOy
         sWS/byC04XpE/avNs04QEMAJN4ZncHKxs9qxT2Ma3djIz6qiguqf4hSyeBcWgKLs23Ir
         wPgVbBryas6LdgV3zeL4S0j+LGrtlsGG3g6c1Hzs50tkaAfJayRJg7xhPYxz6jY45x2B
         R4UivOactUDrchr5LyJ202YTzTxbh15ZZUPB+w3V+8uFwcrIOq12zoorlSsLapFycgT7
         VmVA==
X-Gm-Message-State: AC+VfDyoc9ajcwREjwdaSfhujvtAQmxI2+rF4Wb5fOfZTKK0qva81hnj
        bl/R9MJFZ9kb09dv6P0vmZ1gH5R3/MCfaTRsS0o=
X-Google-Smtp-Source: ACHHUZ7CHdSvsGWhTVnVaa1C89uCAvgtr8+aDEadSR8HJ2xquyXab3DwohS3NhHLIgN6B5tS6ADBTQ==
X-Received: by 2002:a2e:8092:0:b0:2ac:7973:6751 with SMTP id i18-20020a2e8092000000b002ac79736751mr5198759ljg.32.1684835051399;
        Tue, 23 May 2023 02:44:11 -0700 (PDT)
Received: from archyz.. (h-98-128-173-232.A785.priv.bahnhof.se. [98.128.173.232])
        by smtp.gmail.com with ESMTPSA id c16-20020a2e9490000000b002ac87c15fd4sm1535551ljh.95.2023.05.23.02.44.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 May 2023 02:44:10 -0700 (PDT)
From:   Jimmy Assarsson <extja@kvaser.com>
To:     linux-can@vger.kernel.org
Cc:     Jimmy Assarsson <jimmyassarsson@gmail.com>,
        Jimmy Assarsson <extja@kvaser.com>
Subject: [PATCH 10/12] can: kvaser_pciefd: Add len8_dlc support
Date:   Tue, 23 May 2023 11:43:48 +0200
Message-Id: <20230523094354.83792-11-extja@kvaser.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230523094354.83792-1-extja@kvaser.com>
References: <20230523094354.83792-1-extja@kvaser.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Add support for the Classical CAN raw DLC functionality to send and receive
DLC values from 9 .. 15.

Signed-off-by: Jimmy Assarsson <extja@kvaser.com>
---
 drivers/net/can/kvaser_pciefd.c | 15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

diff --git a/drivers/net/can/kvaser_pciefd.c b/drivers/net/can/kvaser_pciefd.c
index feef044c6b0a..3237c71afd2b 100644
--- a/drivers/net/can/kvaser_pciefd.c
+++ b/drivers/net/can/kvaser_pciefd.c
@@ -572,15 +572,19 @@ static int kvaser_pciefd_prepare_tx_packet(struct kvaser_pciefd_tx_packet *p,
 		p->header[0] |= KVASER_PCIEFD_RPACKET_IDE;
 
 	p->header[0] |= cf->can_id & CAN_EFF_MASK;
-	p->header[1] |= can_fd_len2dlc(cf->len) << KVASER_PCIEFD_RPACKET_DLC_SHIFT;
 	p->header[1] |= KVASER_PCIEFD_TPACKET_AREQ;
 
 	if (can_is_canfd_skb(skb)) {
+		p->header[1] |= can_fd_len2dlc(cf->len) << KVASER_PCIEFD_RPACKET_DLC_SHIFT;
 		p->header[1] |= KVASER_PCIEFD_RPACKET_FDF;
 		if (cf->flags & CANFD_BRS)
 			p->header[1] |= KVASER_PCIEFD_RPACKET_BRS;
 		if (cf->flags & CANFD_ESI)
 			p->header[1] |= KVASER_PCIEFD_RPACKET_ESI;
+	} else {
+		p->header[1] |= can_get_cc_dlc((struct can_frame *)cf,
+					       can->can.ctrlmode)
+				<< KVASER_PCIEFD_RPACKET_DLC_SHIFT;
 	}
 
 	p->header[1] |= seq & KVASER_PCIEFD_PACKET_SEQ_MSK;
@@ -816,7 +820,8 @@ static int kvaser_pciefd_setup_can_ctrls(struct kvaser_pciefd *pcie)
 
 		can->can.ctrlmode_supported = CAN_CTRLMODE_LISTENONLY |
 					      CAN_CTRLMODE_FD |
-					      CAN_CTRLMODE_FD_NON_ISO;
+					      CAN_CTRLMODE_FD_NON_ISO |
+					      CAN_CTRLMODE_CC_LEN8_DLC;
 
 		status = ioread32(can->reg_base + KVASER_PCIEFD_KCAN_STAT_REG);
 		if (!(status & KVASER_PCIEFD_KCAN_STAT_FD)) {
@@ -977,12 +982,14 @@ static int kvaser_pciefd_handle_data_packet(struct kvaser_pciefd *pcie,
 	struct can_priv *priv;
 	struct net_device_stats *stats;
 	u8 ch_id = (p->header[1] >> KVASER_PCIEFD_PACKET_CHID_SHIFT) & 0x7;
+	u8 dlc;
 
 	if (ch_id >= pcie->nr_channels)
 		return -EIO;
 
 	priv = &pcie->can[ch_id]->can;
 	stats = &priv->dev->stats;
+	dlc = (p->header[1] >> KVASER_PCIEFD_RPACKET_DLC_SHIFT) & 0xf;
 
 	if (p->header[1] & KVASER_PCIEFD_RPACKET_FDF) {
 		skb = alloc_canfd_skb(priv->dev, &cf);
@@ -991,6 +998,7 @@ static int kvaser_pciefd_handle_data_packet(struct kvaser_pciefd *pcie,
 			return -ENOMEM;
 		}
 
+		cf->len = can_fd_dlc2len(dlc);
 		if (p->header[1] & KVASER_PCIEFD_RPACKET_BRS)
 			cf->flags |= CANFD_BRS;
 
@@ -1002,14 +1010,13 @@ static int kvaser_pciefd_handle_data_packet(struct kvaser_pciefd *pcie,
 			stats->rx_dropped++;
 			return -ENOMEM;
 		}
+		can_frame_set_cc_len((struct can_frame *)cf, dlc, priv->ctrlmode);
 	}
 
 	cf->can_id = p->header[0] & CAN_EFF_MASK;
 	if (p->header[0] & KVASER_PCIEFD_RPACKET_IDE)
 		cf->can_id |= CAN_EFF_FLAG;
 
-	cf->len = can_fd_dlc2len(p->header[1] >> KVASER_PCIEFD_RPACKET_DLC_SHIFT);
-
 	if (p->header[0] & KVASER_PCIEFD_RPACKET_RTR) {
 		cf->can_id |= CAN_RTR_FLAG;
 	} else {
-- 
2.40.0

