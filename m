Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD0A1714A94
	for <lists+linux-can@lfdr.de>; Mon, 29 May 2023 15:45:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229910AbjE2NpH (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Mon, 29 May 2023 09:45:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229898AbjE2NpG (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Mon, 29 May 2023 09:45:06 -0400
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78889FD
        for <linux-can@vger.kernel.org>; Mon, 29 May 2023 06:44:58 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id 2adb3069b0e04-4f4b384c09fso3767654e87.3
        for <linux-can@vger.kernel.org>; Mon, 29 May 2023 06:44:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kvaser.com; s=google; t=1685367897; x=1687959897;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kTPqvtUJqRbhPHlEfxC7knYIsdJVRUe8322GnIsgI1c=;
        b=OjkUGCIPQGibw5H+6mk7GHI+kPIixBjEk8XzKWjoLkPM0ClV6+tPHDbIdumrLh8SGg
         5wq3VJubXaoGQ4y+liPVtDuWLfUwNwRkjWWYZ7zOoLG8xr98AeTGsuVKtiuEzBwJsnUH
         wsEsJOxgZl4Etpy2fc5t0Q+cVwxRGkRAMghFGQpCFRfeUz1QDDv/CwKqR/bO0Od70XTG
         f+TnBiIiBzIKcP9igLEr9FhsFjEjjfD/n1rtzrsSuGmiWgatXHca8szw/hBUatSUneSj
         FXsCfG9/Zt8VENAcsXww2KAwpri6bIXDcwWTv1HvBRILy+tmSvh7QqHMcRc2uM//AGSO
         bRwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685367897; x=1687959897;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kTPqvtUJqRbhPHlEfxC7knYIsdJVRUe8322GnIsgI1c=;
        b=TDYXAHAWuejAzA/9eFMeijtbHzQuPz1SwXQZ7stRTj0pb3tmxYjz1NcfxTzgS1d0AG
         ow7RJ8QrXrrD2RunDxf3eOGKtQUSwQ5Nl5rZjQ1e79xXcXvHqbV3UCvSGcmPuSRvGq6S
         v5fOuZ7jCEm9ZNhczOg/Y9bnrTAzMPUldYGtuWOB1dhn0Evp4T9Wt5IoutUTiGoTvudM
         GWsAkdIGwuOsIQXJaHHkbxHiIM0E1/4QA9XXIFqOBaR9mjjUCmAfuO+YnB+hfqc8Z6kC
         5LqZ/trjS5hAI0psBmB3zWjREDHlLzz1pgWlfJEQtgGQYcKD2y5neaV56Gtb3j/rSupB
         fBiA==
X-Gm-Message-State: AC+VfDy3pYs144OtTlcjdZrp1IlZJBFYmQ8oTMEFKhoIjG/vAT84cLem
        AvaErhxOOxMP0Jz+D23EzXoKqAhjPFblKnWzbOA=
X-Google-Smtp-Source: ACHHUZ5+RKMyaLHWnyMGF41YFLnCS4UeXm3KDBK8qDWk2eKXe7hbCFk+p2p3oJ25tbu9pbqms2SEYQ==
X-Received: by 2002:a19:c514:0:b0:4ef:eda6:c14 with SMTP id w20-20020a19c514000000b004efeda60c14mr3522545lfe.35.1685367896793;
        Mon, 29 May 2023 06:44:56 -0700 (PDT)
Received: from freke.kvaser.se (h-98-128-173-232.A785.priv.bahnhof.se. [98.128.173.232])
        by smtp.gmail.com with ESMTPSA id s7-20020a19ad47000000b004ebae99cc1dsm580lfd.159.2023.05.29.06.44.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 May 2023 06:44:56 -0700 (PDT)
From:   Jimmy Assarsson <extja@kvaser.com>
To:     linux-can@vger.kernel.org,
        Vincent MAILHOL <mailhol.vincent@wanadoo.fr>
Cc:     Jimmy Assarsson <jimmyassarsson@gmail.com>,
        Jimmy Assarsson <extja@kvaser.com>
Subject: [PATCH v2 12/14] can: kvaser_pciefd: Add len8_dlc support
Date:   Mon, 29 May 2023 15:42:46 +0200
Message-Id: <20230529134248.752036-13-extja@kvaser.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20230529134248.752036-1-extja@kvaser.com>
References: <20230529134248.752036-1-extja@kvaser.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Add support for the Classical CAN raw DLC functionality to send and receive
DLC values from 9 .. 15.

Signed-off-by: Jimmy Assarsson <extja@kvaser.com>
---
Changes in v2:
  - Use FIELD_{GET,PREP} instead of shifting

 drivers/net/can/kvaser_pciefd.c | 16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

diff --git a/drivers/net/can/kvaser_pciefd.c b/drivers/net/can/kvaser_pciefd.c
index 8779091c448c..e3d730264462 100644
--- a/drivers/net/can/kvaser_pciefd.c
+++ b/drivers/net/can/kvaser_pciefd.c
@@ -591,15 +591,20 @@ static int kvaser_pciefd_prepare_tx_packet(struct kvaser_pciefd_tx_packet *p,
 		p->header[0] |= KVASER_PCIEFD_RPACKET_IDE;
 
 	p->header[0] |= FIELD_PREP(KVASER_PCIEFD_RPACKET_ID_MASK, cf->can_id);
-	p->header[1] |= FIELD_PREP(KVASER_PCIEFD_RPACKET_DLC_MASK, can_fd_len2dlc(cf->len));
 	p->header[1] |= KVASER_PCIEFD_TPACKET_AREQ;
 
 	if (can_is_canfd_skb(skb)) {
+		p->header[1] |= FIELD_PREP(KVASER_PCIEFD_RPACKET_DLC_MASK,
+					   can_fd_len2dlc(cf->len));
 		p->header[1] |= KVASER_PCIEFD_RPACKET_FDF;
 		if (cf->flags & CANFD_BRS)
 			p->header[1] |= KVASER_PCIEFD_RPACKET_BRS;
 		if (cf->flags & CANFD_ESI)
 			p->header[1] |= KVASER_PCIEFD_RPACKET_ESI;
+	} else {
+		p->header[1] |=
+			FIELD_PREP(KVASER_PCIEFD_RPACKET_DLC_MASK,
+				   can_get_cc_dlc((struct can_frame *)cf, can->can.ctrlmode));
 	}
 
 	p->header[1] |= FIELD_PREP(KVASER_PCIEFD_PACKET_SEQ_MASK, seq);
@@ -834,7 +839,8 @@ static int kvaser_pciefd_setup_can_ctrls(struct kvaser_pciefd *pcie)
 
 		can->can.ctrlmode_supported = CAN_CTRLMODE_LISTENONLY |
 					      CAN_CTRLMODE_FD |
-					      CAN_CTRLMODE_FD_NON_ISO;
+					      CAN_CTRLMODE_FD_NON_ISO |
+					      CAN_CTRLMODE_CC_LEN8_DLC;
 
 		status = ioread32(can->reg_base + KVASER_PCIEFD_KCAN_STAT_REG);
 		if (!(status & KVASER_PCIEFD_KCAN_STAT_FD)) {
@@ -996,12 +1002,14 @@ static int kvaser_pciefd_handle_data_packet(struct kvaser_pciefd *pcie,
 	struct can_priv *priv;
 	struct net_device_stats *stats;
 	u8 ch_id = FIELD_GET(KVASER_PCIEFD_PACKET_CHID_MASK, p->header[1]);
+	u8 dlc;
 
 	if (ch_id >= pcie->nr_channels)
 		return -EIO;
 
 	priv = &pcie->can[ch_id]->can;
 	stats = &priv->dev->stats;
+	dlc = FIELD_GET(KVASER_PCIEFD_RPACKET_DLC_MASK, p->header[1]);
 
 	if (p->header[1] & KVASER_PCIEFD_RPACKET_FDF) {
 		skb = alloc_canfd_skb(priv->dev, &cf);
@@ -1010,6 +1018,7 @@ static int kvaser_pciefd_handle_data_packet(struct kvaser_pciefd *pcie,
 			return -ENOMEM;
 		}
 
+		cf->len = can_fd_dlc2len(dlc);
 		if (p->header[1] & KVASER_PCIEFD_RPACKET_BRS)
 			cf->flags |= CANFD_BRS;
 
@@ -1021,14 +1030,13 @@ static int kvaser_pciefd_handle_data_packet(struct kvaser_pciefd *pcie,
 			stats->rx_dropped++;
 			return -ENOMEM;
 		}
+		can_frame_set_cc_len((struct can_frame *)cf, dlc, priv->ctrlmode);
 	}
 
 	cf->can_id = FIELD_GET(KVASER_PCIEFD_RPACKET_ID_MASK, p->header[0]);
 	if (p->header[0] & KVASER_PCIEFD_RPACKET_IDE)
 		cf->can_id |= CAN_EFF_FLAG;
 
-	cf->len = can_fd_dlc2len(FIELD_GET(KVASER_PCIEFD_RPACKET_DLC_MASK, p->header[1]));
-
 	if (p->header[0] & KVASER_PCIEFD_RPACKET_RTR) {
 		cf->can_id |= CAN_RTR_FLAG;
 	} else {
-- 
2.40.0

