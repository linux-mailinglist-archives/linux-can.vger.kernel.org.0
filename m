Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4FFF0704E2B
	for <lists+linux-can@lfdr.de>; Tue, 16 May 2023 14:54:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232378AbjEPMyP (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Tue, 16 May 2023 08:54:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231878AbjEPMyO (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 16 May 2023 08:54:14 -0400
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF6DD527B
        for <linux-can@vger.kernel.org>; Tue, 16 May 2023 05:54:00 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id 2adb3069b0e04-4f1411e8111so16270303e87.1
        for <linux-can@vger.kernel.org>; Tue, 16 May 2023 05:54:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kvaser.com; s=google; t=1684241639; x=1686833639;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=gqTSA5dxNmyOozjrwEAz+B63/gsO+95tgk0FW+23SfM=;
        b=g6Ungqb3umDChgnojAI4yc8Mn3FngITkxIxAnUy9uroRxSBtluIaQyLhhWz5kcDeNt
         6towdjWZmeDiBrmrZcwoccUZRm0h5DeZoWSsaSlJlA5WbPgOA5637sWrPi5oGkoIsFf+
         Vm0e8XM9DltJtV3+kknnkaruiq5sxuiPWo9lFjIzDcfZXEunzZukFGJQyFaNQ/fQkSOg
         6L2CXyB1hEpOswiuGvfWA6+R9F+w+McMqb9moP8TcUL/+JKa69IdJM5CMo3+wpha4ooo
         H1BvzHJbA42P4YKKelv3QNbb2nc4LqTqFgFJxTAscOJfdlcJy9fHgziPV8M+Jkgz5d1/
         MuYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684241639; x=1686833639;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gqTSA5dxNmyOozjrwEAz+B63/gsO+95tgk0FW+23SfM=;
        b=HyK19dFgsx2nfq0Yeu6Y4Wkewi9aINzrWXT6bxNQFnxWcUzxALnd8SZ2oqY+a3HLZo
         jc/cTGQJp2mZeCG4rHmprwi0cbSPiKSmbBwnSIx5qD8FklekSDb4yGs+rg8J7SfQMkeD
         p+QPlW7qYafnk+Ob2EZZTCEQCI8AfUpYKAKC+1xkX0n4H/IlUms3KzYTOupJeuByL0j2
         NzcYB5REllc4lNDboO2HeHeJw6HdWLgD38maeGP/I/Gz3IkJgZTJPT2f0lXnvV6Jy/53
         UaFvwD2owdXBhSsqGOjTHYsMpNkd8yFsMh6uHy5Xyvz3Np3pV5NVKAvZZpVouQyRGdH/
         Ksew==
X-Gm-Message-State: AC+VfDwOqphuTQDjnwy2ssg87TuPBeApb08BV0NOwL/r+qgyAxIiqTWT
        xv6UTm0hmPw1t1qEarN3zFdjv+Tm9WCRDfK4VBwMZQ==
X-Google-Smtp-Source: ACHHUZ7KXywt6Sm8eP37qY0wnAWeEmcNpXVYgDDDbRpIkRJrjKFKfeLnQPPXpvdjMe4d2cnCZja47Q==
X-Received: by 2002:a05:6512:21a:b0:4f1:1de7:1ab6 with SMTP id a26-20020a056512021a00b004f11de71ab6mr7415644lfo.20.1684241638958;
        Tue, 16 May 2023 05:53:58 -0700 (PDT)
Received: from archyz.. (h-98-128-173-232.A785.priv.bahnhof.se. [98.128.173.232])
        by smtp.gmail.com with ESMTPSA id w4-20020ac25d44000000b004f139712835sm2953395lfd.293.2023.05.16.05.53.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 May 2023 05:53:58 -0700 (PDT)
From:   Jimmy Assarsson <extja@kvaser.com>
To:     linux-can@vger.kernel.org,
        Carsten Schmidt <carsten.schmidt-achim@t-online.de>
Cc:     Jimmy Assarsson <jimmyassarsson@gmail.com>,
        Oliver Hartkopp <socketcan@hartkopp.net>,
        Marc Kleine-Budde <mkl@pengutronix.de>,
        Vincent Mailhol <mailhol.vincent@wanadoo.fr>,
        Jimmy Assarsson <extja@kvaser.com>
Subject: [PATCH v2] can: kvaser_usb: Add len8_dlc support
Date:   Tue, 16 May 2023 14:53:32 +0200
Message-Id: <20230516125332.82894-1-extja@kvaser.com>
X-Mailer: git-send-email 2.40.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

From: Carsten Schmidt <carsten.schmidt-achim@t-online.de>

Add support for the Classical CAN raw DLC functionality to send and receive
DLC values from 9 .. 15.

Signed-off-by: Carsten Schmidt <carsten.schmidt-achim@t-online.de>
Tested-by: Jimmy Assarsson <extja@kvaser.com>
Signed-off-by: Jimmy Assarsson <extja@kvaser.com>
---
This patch was originally posted as
[PATCH] can: kvaser_usb_leaf: Implement CAN 2.0 raw DLC functionality
by Carsten Schmidt <carsten.schmidt-achim@t-online.de>
https://lore.kernel.org/linux-can/a81e55c3-66b9-1f84-b1a3-dd5184478da3@kvaser.com/T/#md546eb98c84099a46204a21b64aa547adc62dd34

Changes in v2:
  - Update subject and add commit message
  - Add len8_dlc support for Kvaser Hydra devices
  - Move assignment of can.ctrlmode_supported = CAN_CTRLMODE_CC_LEN8_DLC
    from kvaser_usb_leaf.c to kvaser_usb_core.c

 drivers/net/can/usb/kvaser_usb/kvaser_usb_core.c  |  2 +-
 drivers/net/can/usb/kvaser_usb/kvaser_usb_hydra.c | 13 +++++++++----
 drivers/net/can/usb/kvaser_usb/kvaser_usb_leaf.c  |  6 +++---
 3 files changed, 13 insertions(+), 8 deletions(-)

diff --git a/drivers/net/can/usb/kvaser_usb/kvaser_usb_core.c b/drivers/net/can/usb/kvaser_usb/kvaser_usb_core.c
index 7135ec851341..71ef4db5c09f 100644
--- a/drivers/net/can/usb/kvaser_usb/kvaser_usb_core.c
+++ b/drivers/net/can/usb/kvaser_usb/kvaser_usb_core.c
@@ -816,7 +816,7 @@ static int kvaser_usb_init_one(struct kvaser_usb *dev, int channel)
 	init_completion(&priv->stop_comp);
 	init_completion(&priv->flush_comp);
 	init_completion(&priv->get_busparams_comp);
-	priv->can.ctrlmode_supported = 0;
+	priv->can.ctrlmode_supported = CAN_CTRLMODE_CC_LEN8_DLC;
 
 	priv->dev = dev;
 	priv->netdev = netdev;
diff --git a/drivers/net/can/usb/kvaser_usb/kvaser_usb_hydra.c b/drivers/net/can/usb/kvaser_usb/kvaser_usb_hydra.c
index ef341c4254fc..c7ba768dfe17 100644
--- a/drivers/net/can/usb/kvaser_usb/kvaser_usb_hydra.c
+++ b/drivers/net/can/usb/kvaser_usb/kvaser_usb_hydra.c
@@ -1263,7 +1263,7 @@ static void kvaser_usb_hydra_rx_msg_std(const struct kvaser_usb *dev,
 	if (flags & KVASER_USB_HYDRA_CF_FLAG_OVERRUN)
 		kvaser_usb_can_rx_over_error(priv->netdev);
 
-	cf->len = can_cc_dlc2len(cmd->rx_can.dlc);
+	can_frame_set_cc_len((struct can_frame *)cf, cmd->rx_can.dlc, priv->can.ctrlmode);
 
 	if (flags & KVASER_USB_HYDRA_CF_FLAG_REMOTE_FRAME) {
 		cf->can_id |= CAN_RTR_FLAG;
@@ -1342,7 +1342,7 @@ static void kvaser_usb_hydra_rx_msg_ext(const struct kvaser_usb *dev,
 		if (flags & KVASER_USB_HYDRA_CF_FLAG_ESI)
 			cf->flags |= CANFD_ESI;
 	} else {
-		cf->len = can_cc_dlc2len(dlc);
+		can_frame_set_cc_len((struct can_frame *)cf, dlc, priv->can.ctrlmode);
 	}
 
 	if (flags & KVASER_USB_HYDRA_CF_FLAG_REMOTE_FRAME) {
@@ -1442,7 +1442,7 @@ kvaser_usb_hydra_frame_to_cmd_ext(const struct kvaser_usb_net_priv *priv,
 	struct kvaser_usb *dev = priv->dev;
 	struct kvaser_cmd_ext *cmd;
 	struct canfd_frame *cf = (struct canfd_frame *)skb->data;
-	u8 dlc = can_fd_len2dlc(cf->len);
+	u8 dlc;
 	u8 nbr_of_bytes = cf->len;
 	u32 flags;
 	u32 id;
@@ -1467,6 +1467,11 @@ kvaser_usb_hydra_frame_to_cmd_ext(const struct kvaser_usb_net_priv *priv,
 
 	cmd->len = cpu_to_le16(*cmd_len);
 
+	if (can_is_canfd_skb(skb))
+		dlc = can_fd_len2dlc(cf->len);
+	else
+		dlc = can_get_cc_dlc((struct can_frame *)cf, priv->can.ctrlmode);
+
 	cmd->tx_can.databytes = nbr_of_bytes;
 	cmd->tx_can.dlc = dlc;
 
@@ -1542,7 +1547,7 @@ kvaser_usb_hydra_frame_to_cmd_std(const struct kvaser_usb_net_priv *priv,
 		id = cf->can_id & CAN_SFF_MASK;
 	}
 
-	cmd->tx_can.dlc = cf->len;
+	cmd->tx_can.dlc = can_get_cc_dlc(cf, priv->can.ctrlmode);
 
 	flags = (cf->can_id & CAN_EFF_FLAG ?
 		 KVASER_USB_HYDRA_CF_FLAG_EXTENDED_ID : 0);
diff --git a/drivers/net/can/usb/kvaser_usb/kvaser_usb_leaf.c b/drivers/net/can/usb/kvaser_usb/kvaser_usb_leaf.c
index 1c2f99ce4c6c..23bd7574b1c7 100644
--- a/drivers/net/can/usb/kvaser_usb/kvaser_usb_leaf.c
+++ b/drivers/net/can/usb/kvaser_usb/kvaser_usb_leaf.c
@@ -573,7 +573,7 @@ kvaser_usb_leaf_frame_to_cmd(const struct kvaser_usb_net_priv *priv,
 			cmd->u.tx_can.data[1] = cf->can_id & 0x3f;
 		}
 
-		cmd->u.tx_can.data[5] = cf->len;
+		cmd->u.tx_can.data[5] = can_get_cc_dlc(cf, priv->can.ctrlmode);
 		memcpy(&cmd->u.tx_can.data[6], cf->data, cf->len);
 
 		if (cf->can_id & CAN_RTR_FLAG)
@@ -1349,7 +1349,7 @@ static void kvaser_usb_leaf_rx_can_msg(const struct kvaser_usb *dev,
 		else
 			cf->can_id &= CAN_SFF_MASK;
 
-		cf->len = can_cc_dlc2len(cmd->u.leaf.log_message.dlc);
+		can_frame_set_cc_len(cf, cmd->u.leaf.log_message.dlc & 0xF, priv->can.ctrlmode);
 
 		if (cmd->u.leaf.log_message.flags & MSG_FLAG_REMOTE_FRAME)
 			cf->can_id |= CAN_RTR_FLAG;
@@ -1367,7 +1367,7 @@ static void kvaser_usb_leaf_rx_can_msg(const struct kvaser_usb *dev,
 			cf->can_id |= CAN_EFF_FLAG;
 		}
 
-		cf->len = can_cc_dlc2len(rx_data[5]);
+		can_frame_set_cc_len(cf, rx_data[5] & 0xF, priv->can.ctrlmode);
 
 		if (cmd->u.rx_can_header.flag & MSG_FLAG_REMOTE_FRAME)
 			cf->can_id |= CAN_RTR_FLAG;
-- 
2.40.0

