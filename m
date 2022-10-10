Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 685385FA3B8
	for <lists+linux-can@lfdr.de>; Mon, 10 Oct 2022 20:53:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229783AbiJJSx0 (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Mon, 10 Oct 2022 14:53:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229793AbiJJSxW (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Mon, 10 Oct 2022 14:53:22 -0400
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5EEA78BE8
        for <linux-can@vger.kernel.org>; Mon, 10 Oct 2022 11:53:20 -0700 (PDT)
Received: by mail-lj1-x231.google.com with SMTP id m14so14276140ljg.2
        for <linux-can@vger.kernel.org>; Mon, 10 Oct 2022 11:53:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kvaser.com; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Zf4ymhZbrdA58R2MaWZ38+YEzS78kngPel+A0uuw8RU=;
        b=F1X46BsJ2qazsqHi6C8FenZ3AtAW8daEFC3HgaqGrNSSjLpMMPB46YYot4M1kD9LeB
         ap4qSGxcFakyT3uZMnuuxnP+DmNJaZbyiOl5ZtJ1IHNpaPPelxldH1Ey8jpRWGFrTwTH
         6bwQx3FQth8vCtJM3Ba+NnKHr5gXaWwPfcawVim04bnENrR0xARa0SawF4H2GazDKg3K
         O4F1Zf7o4+HhY5nhzNqmXtJF6RZyH24Tsz4mXbU4h6kiTTZ75iPyHVnd0V8d2MDCY2Au
         V7DV78a8qkNDk/O+VV2IsELSG9zM9QiEAcsWST/j95DnTIo3aTyxdz3Md1VUT2Zp0ocI
         UwpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Zf4ymhZbrdA58R2MaWZ38+YEzS78kngPel+A0uuw8RU=;
        b=LEataZQDdfWn12dzlihYMg7RIzTeNqKC9ClfA1e6xeDSvyvVqofPvLJn9bl3WNHEmj
         Ia0jaSGdBLgZjuhU2ynxgkQSeFvLwIvVbnlZITulELfhEdZzi7mL4ZANZCKjTXvDzYbu
         Taut1HZvCl8HDZA+kkK69wzacpco1ApzPqGKox2Rjsjc7TWnQPvmnzSzF0Tdr3TwydsX
         Zt0U2V77bYFkwgpTVD4y7WJliZtLBN3ZjeMiDbrxqGGJ+COd4bvIOy9p3bCnRAtxeaz9
         sM4SkayOmnBg7MqKl0XpplUR9uuzHgOOF9coqO7DkyNaMGWNoXciuFjOPaVotlw1o7IL
         morQ==
X-Gm-Message-State: ACrzQf3Gdj1zffJorlRf/rdgWVcYfLQwk600TczXm2td2dacUVO7MGKZ
        v8zYZpbnFRZKPx/L97dONbMz+nzNQWfEFw==
X-Google-Smtp-Source: AMsMyM69Svo/88406ekdhtbQNSCoV95Z7PBtjtdV33ML9qIA4n9hFx8PoHZ1R3BmtzcA0ac/525tEw==
X-Received: by 2002:a2e:9b97:0:b0:26d:fdbf:b45b with SMTP id z23-20020a2e9b97000000b0026dfdbfb45bmr7487466lji.7.1665427998796;
        Mon, 10 Oct 2022 11:53:18 -0700 (PDT)
Received: from archyz.. (h-155-4-68-234.A785.priv.bahnhof.se. [155.4.68.234])
        by smtp.gmail.com with ESMTPSA id b4-20020a056512070400b004a2386b8ce6sm1517769lfs.207.2022.10.10.11.53.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Oct 2022 11:53:18 -0700 (PDT)
From:   Jimmy Assarsson <extja@kvaser.com>
To:     linux-can@vger.kernel.org, Marc Kleine-Budde <mkl@pengutronix.de>,
        Anssi Hannula <anssi.hannula@bitwise.fi>
Cc:     Jimmy Assarsson <jimmyassarsson@gmail.com>,
        Jimmy Assarsson <extja@kvaser.com>
Subject: [PATCH can-next v5 10/11] can: kvaser_usb: Add struct kvaser_usb_busparams
Date:   Mon, 10 Oct 2022 20:52:36 +0200
Message-Id: <20221010185237.319219-11-extja@kvaser.com>
X-Mailer: git-send-email 2.38.0
In-Reply-To: <20221010185237.319219-1-extja@kvaser.com>
References: <20221010185237.319219-1-extja@kvaser.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Add struct kvaser_usb_busparams containing the busparameters used in
CMD_{SET,GET}_BUSPARAMS* commands.

Tested-by: Anssi Hannula <anssi.hannula@bitwise.fi>
Signed-off-by: Jimmy Assarsson <extja@kvaser.com>
---
Changes in v5:
 - Split series and rebased on linux-can-next
 - Remove stable from CC

Changes in v4:
 - No changes

Changes in v3:
 - Rebased on 1d5eeda23f36 ("can: kvaser_usb: advertise timestamping capabilities and add ioctl support")
 - Add stable to CC
 - Add Tested-by Anssi Hannula

Changes in v2:
  - New in v2.

 drivers/net/can/usb/kvaser_usb/kvaser_usb.h   |  8 +++++
 .../net/can/usb/kvaser_usb/kvaser_usb_hydra.c | 32 +++++++------------
 .../net/can/usb/kvaser_usb/kvaser_usb_leaf.c  | 18 ++++-------
 3 files changed, 27 insertions(+), 31 deletions(-)

diff --git a/drivers/net/can/usb/kvaser_usb/kvaser_usb.h b/drivers/net/can/usb/kvaser_usb/kvaser_usb.h
index d9c5dd5da908..040885c7d0c4 100644
--- a/drivers/net/can/usb/kvaser_usb/kvaser_usb.h
+++ b/drivers/net/can/usb/kvaser_usb/kvaser_usb.h
@@ -76,6 +76,14 @@ struct kvaser_usb_tx_urb_context {
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
index 66f672ea631b..3319af181e0e 100644
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
@@ -1538,11 +1530,11 @@ static int kvaser_usb_hydra_set_bittiming(struct net_device *netdev)
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
@@ -1572,11 +1564,11 @@ static int kvaser_usb_hydra_set_data_bittiming(struct net_device *netdev)
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
index 3e31a9ebea88..bb59ee01a093 100644
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
@@ -1725,15 +1721,15 @@ static int kvaser_usb_leaf_set_bittiming(struct net_device *netdev)
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
2.38.0

