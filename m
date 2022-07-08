Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE3DF56B915
	for <lists+linux-can@lfdr.de>; Fri,  8 Jul 2022 14:03:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238225AbiGHL56 (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Fri, 8 Jul 2022 07:57:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238257AbiGHL54 (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Fri, 8 Jul 2022 07:57:56 -0400
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70E379B182
        for <linux-can@vger.kernel.org>; Fri,  8 Jul 2022 04:57:54 -0700 (PDT)
Received: by mail-lj1-x235.google.com with SMTP id c15so25699797ljr.0
        for <linux-can@vger.kernel.org>; Fri, 08 Jul 2022 04:57:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kvaser.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=PTAkZg4SbpxSBJpeaGSULnATmnESHnbJaFesg0L25sM=;
        b=tO6UXEQRBlFAVALmhX6dp2JToLwuwW3CJK+VOsF2wkLkse2nz430hSkkPAIo1eLrim
         Iixc6GubtcC+imrYwXUYQ+wPQnpMcA8vz6TqJtVwu+o+iKrjg+SpQkLxoKaH2N2/4u4f
         Xvcf+PM3eLs7U66rpqwFqFClTDn/pfLOo435cxaqZBbMb4GD7YWm+pV+Nq9NXnr+r/Wn
         d82e/TvW5GO4KDKf8kNJWkvYXkjqLYHhGZjEoPKIjCZSEu7uPmbG4v8EvxBLxoQmPbfo
         pq2gyziOJJZ0XXyBOUo3Hed0kSH9PsAxN+3lwGOrqNW3egO8nMy556xxh4mhhbCIq34w
         ApZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=PTAkZg4SbpxSBJpeaGSULnATmnESHnbJaFesg0L25sM=;
        b=fwWZjnrx767iWJwDXzuMWK56Qs++XnrZ9LwtHKD1FinYmHeSERGxm69/55kJ+rE/Nl
         a38PZ+H9n1Dvk0nFZJD0qO2eiSG+sFn2n+hn4h6OCrg5tfCwm/FTtVrmntmwtzc7RttD
         ExJq89culKokRlzXn1zGDHDf+vFP4XecOSphbWbRIk43mchExfoK2YklIEzcKCQCPz30
         veAO04641g+5Qizwa9+RIQ/0/Iri5z4ongwvJnvP974ljiW/jLPqAWM/9W8AgPHs5t2O
         NGQkpaA+469xj2pFf7APdbjFNX4qBzxrQ7ZuxjNPsWabCse0FRZxETG+Qi6SigADpMbA
         qpfA==
X-Gm-Message-State: AJIora80TIRa7hbfEP2uIAMVjOUJU+eZGsd1eqABlKcjQjC2O+VMLVqV
        P+vveadZitVSyCU00GVGiZYuDq0pA/6lvA==
X-Google-Smtp-Source: AGRyM1sT7CHsHmSZaEukkVA3FKcG2dpFZoUTPt5hMykD97zkPPRA/jp9AErH+erF52fTZF8ra+Rqug==
X-Received: by 2002:a05:651c:a0f:b0:25b:c834:4604 with SMTP id k15-20020a05651c0a0f00b0025bc8344604mr1766161ljq.252.1657281472824;
        Fri, 08 Jul 2022 04:57:52 -0700 (PDT)
Received: from freke.kvaser.se (rota.kvaser.com. [195.22.86.90])
        by smtp.gmail.com with ESMTPSA id h7-20020a2e9ec7000000b0025a724f2935sm7336199ljk.137.2022.07.08.04.57.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Jul 2022 04:57:52 -0700 (PDT)
From:   Jimmy Assarsson <extja@kvaser.com>
To:     linux-can@vger.kernel.org, Anssi Hannula <anssi.hannula@bitwise.fi>
Cc:     Jimmy Assarsson <jimmyassarsson@gmail.com>,
        Jimmy Assarsson <extja@kvaser.com>
Subject: [PATCH v2 14/15] can: kvaser_usb: Add struct kvaser_usb_busparams
Date:   Fri,  8 Jul 2022 13:57:08 +0200
Message-Id: <20220708115709.232815-15-extja@kvaser.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220708115709.232815-1-extja@kvaser.com>
References: <20220708115709.232815-1-extja@kvaser.com>
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

Add struct kvaser_usb_busparams containing the busparameters used in
CMD_{SET,GET}_BUSPARAMS* commands.

Signed-off-by: Jimmy Assarsson <extja@kvaser.com>
---
Changes in v2:
  - New in v2.

 drivers/net/can/usb/kvaser_usb/kvaser_usb.h   |  8 +++++
 .../net/can/usb/kvaser_usb/kvaser_usb_hydra.c | 32 +++++++------------
 .../net/can/usb/kvaser_usb/kvaser_usb_leaf.c  | 18 ++++-------
 3 files changed, 27 insertions(+), 31 deletions(-)

diff --git a/drivers/net/can/usb/kvaser_usb/kvaser_usb.h b/drivers/net/can/usb/kvaser_usb/kvaser_usb.h
index 2d7430477319..d6a1725d8fcf 100644
--- a/drivers/net/can/usb/kvaser_usb/kvaser_usb.h
+++ b/drivers/net/can/usb/kvaser_usb/kvaser_usb.h
@@ -75,6 +75,14 @@ struct kvaser_usb_tx_urb_context {
 	u32 echo_index;
 };
 
+struct kvaser_usb_busparams {
+	__le32 bitrate;
+	u8 tseg1;
+	u8 tseg2;
+	u8 sjw;
+	u8 nsamples;
+};
+
 struct kvaser_usb {
 	struct usb_device *udev;
 	struct usb_interface *intf;
diff --git a/drivers/net/can/usb/kvaser_usb/kvaser_usb_hydra.c b/drivers/net/can/usb/kvaser_usb/kvaser_usb_hydra.c
index e469a7471719..8d26fe1b6f5c 100644
--- a/drivers/net/can/usb/kvaser_usb/kvaser_usb_hydra.c
+++ b/drivers/net/can/usb/kvaser_usb/kvaser_usb_hydra.c
@@ -196,17 +196,9 @@ struct kvaser_cmd_chip_state_event {
 #define KVASER_USB_HYDRA_BUS_MODE_CANFD_ISO	0x01
 #define KVASER_USB_HYDRA_BUS_MODE_NONISO	0x02
 struct kvaser_cmd_set_busparams {
-	__le32 bitrate;
-	u8 tseg1;
-	u8 tseg2;
-	u8 sjw;
-	u8 nsamples;
+	struct kvaser_usb_busparams busparams_arb;
 	u8 reserved0[4];
-	__le32 bitrate_d;
-	u8 tseg1_d;
-	u8 tseg2_d;
-	u8 sjw_d;
-	u8 nsamples_d;
+	struct kvaser_usb_busparams busparams_data;
 	u8 canfd_mode;
 	u8 reserved1[7];
 } __packed;
@@ -1532,11 +1524,11 @@ static int kvaser_usb_hydra_set_bittiming(struct net_device *netdev)
 		return -ENOMEM;
 
 	cmd->header.cmd_no = CMD_SET_BUSPARAMS_REQ;
-	cmd->set_busparams_req.bitrate = cpu_to_le32(bt->bitrate);
-	cmd->set_busparams_req.sjw = (u8)sjw;
-	cmd->set_busparams_req.tseg1 = (u8)tseg1;
-	cmd->set_busparams_req.tseg2 = (u8)tseg2;
-	cmd->set_busparams_req.nsamples = 1;
+	cmd->set_busparams_req.busparams_arb.bitrate = cpu_to_le32(bt->bitrate);
+	cmd->set_busparams_req.busparams_arb.sjw = (u8)sjw;
+	cmd->set_busparams_req.busparams_arb.tseg1 = (u8)tseg1;
+	cmd->set_busparams_req.busparams_arb.tseg2 = (u8)tseg2;
+	cmd->set_busparams_req.busparams_arb.nsamples = 1;
 
 	kvaser_usb_hydra_set_cmd_dest_he
 		(cmd, dev->card_data.hydra.channel_to_he[priv->channel]);
@@ -1566,11 +1558,11 @@ static int kvaser_usb_hydra_set_data_bittiming(struct net_device *netdev)
 		return -ENOMEM;
 
 	cmd->header.cmd_no = CMD_SET_BUSPARAMS_FD_REQ;
-	cmd->set_busparams_req.bitrate_d = cpu_to_le32(dbt->bitrate);
-	cmd->set_busparams_req.sjw_d = (u8)sjw;
-	cmd->set_busparams_req.tseg1_d = (u8)tseg1;
-	cmd->set_busparams_req.tseg2_d = (u8)tseg2;
-	cmd->set_busparams_req.nsamples_d = 1;
+	cmd->set_busparams_req.busparams_data.bitrate = cpu_to_le32(dbt->bitrate);
+	cmd->set_busparams_req.busparams_data.sjw = (u8)sjw;
+	cmd->set_busparams_req.busparams_data.tseg1 = (u8)tseg1;
+	cmd->set_busparams_req.busparams_data.tseg2 = (u8)tseg2;
+	cmd->set_busparams_req.busparams_data.nsamples = 1;
 
 	if (priv->can.ctrlmode & CAN_CTRLMODE_FD) {
 		if (priv->can.ctrlmode & CAN_CTRLMODE_FD_NON_ISO)
diff --git a/drivers/net/can/usb/kvaser_usb/kvaser_usb_leaf.c b/drivers/net/can/usb/kvaser_usb/kvaser_usb_leaf.c
index 5e325bf40c84..49a69dd03fb3 100644
--- a/drivers/net/can/usb/kvaser_usb/kvaser_usb_leaf.c
+++ b/drivers/net/can/usb/kvaser_usb/kvaser_usb_leaf.c
@@ -164,11 +164,7 @@ struct usbcan_cmd_softinfo {
 struct kvaser_cmd_busparams {
 	u8 tid;
 	u8 channel;
-	__le32 bitrate;
-	u8 tseg1;
-	u8 tseg2;
-	u8 sjw;
-	u8 no_samp;
+	struct kvaser_usb_busparams busparams;
 } __packed;
 
 struct kvaser_cmd_tx_can {
@@ -1722,15 +1718,15 @@ static int kvaser_usb_leaf_set_bittiming(struct net_device *netdev)
 	cmd->len = CMD_HEADER_LEN + sizeof(struct kvaser_cmd_busparams);
 	cmd->u.busparams.channel = priv->channel;
 	cmd->u.busparams.tid = 0xff;
-	cmd->u.busparams.bitrate = cpu_to_le32(bt->bitrate);
-	cmd->u.busparams.sjw = bt->sjw;
-	cmd->u.busparams.tseg1 = bt->prop_seg + bt->phase_seg1;
-	cmd->u.busparams.tseg2 = bt->phase_seg2;
+	cmd->u.busparams.busparams.bitrate = cpu_to_le32(bt->bitrate);
+	cmd->u.busparams.busparams.sjw = bt->sjw;
+	cmd->u.busparams.busparams.tseg1 = bt->prop_seg + bt->phase_seg1;
+	cmd->u.busparams.busparams.tseg2 = bt->phase_seg2;
 
 	if (priv->can.ctrlmode & CAN_CTRLMODE_3_SAMPLES)
-		cmd->u.busparams.no_samp = 3;
+		cmd->u.busparams.busparams.nsamples = 3;
 	else
-		cmd->u.busparams.no_samp = 1;
+		cmd->u.busparams.busparams.nsamples = 1;
 
 	rc = kvaser_usb_send_cmd(dev, cmd, cmd->len);
 
-- 
2.36.1

