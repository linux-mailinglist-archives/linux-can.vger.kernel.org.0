Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DDC1556B913
	for <lists+linux-can@lfdr.de>; Fri,  8 Jul 2022 13:57:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238226AbiGHL5t (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Fri, 8 Jul 2022 07:57:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238221AbiGHL5s (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Fri, 8 Jul 2022 07:57:48 -0400
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8ED489B18D
        for <linux-can@vger.kernel.org>; Fri,  8 Jul 2022 04:57:45 -0700 (PDT)
Received: by mail-lj1-x236.google.com with SMTP id a11so25647228ljb.5
        for <linux-can@vger.kernel.org>; Fri, 08 Jul 2022 04:57:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kvaser.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=a83WB1bgmqB4ScMQsfU6yrYuoCKyyTk+7A3rjF6bBb0=;
        b=Gopot5NxcDL7kR/s3eW2bBdTRJS97U0gGPZi4jv/TY1BUeefvE7kO3BeXccMVe2L+T
         m2nr72U541NeH4gWfP0D11fAhnY05QdkoFXDROWc6VEQ0qvS5N8neCBUhGTXo8O+H+Ji
         wZP87SKwcOij8AcS5YaqlSerq4owjhNusiypYdaxH1pQKisF5CyFMtplOkOlvT9dulFP
         5h0bOtNWDeX8wB2Xu1bgEJWkZB1N30Lw4TG5PWIC817MnI8axXvbf+5lK9FIVQvq6+Zt
         svwXfUwStfdWbk4AQvNcqn5blQG2bNcitH/c8y6f33mikt1VTqe++EGTAci8KirNKLzy
         AJ/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=a83WB1bgmqB4ScMQsfU6yrYuoCKyyTk+7A3rjF6bBb0=;
        b=PV+BEvGGWkkJ+JoUhY1dKecRQuOE3Y7EjJJes9oBSAmUVjprqXlw/ycQ3TrqWdfaym
         9tfTieVWXVGb6SM7jonfO3FKXTgdp3CbDLK8z6h6vrPNw6lJ2X/ExTS0t6dR1vJNgEOl
         bC0RYl6guGgn2Ll28V1LN7h6jg+5oV7HG6sR8DWIytVs1SrkC0642/Jh7t6iHDzUCKBA
         0ZJAKjJS+RS3f0d+Jc1a9Iio1CSiSfnrOhQ8H2YGBLKD3NzMa9qZ6q1Vg/t3G1RMKtq0
         0cPgVwPUT/SCtA17pW0snMecTdrEKnLnoXMjJ8WjLG76ddN9mZUSzDm1rNoD9s0gKgvp
         z29g==
X-Gm-Message-State: AJIora+Hwx+aNeAWpoOL4gaLH4rToigYdDIIsRnDXQuYb4at/b250rZr
        iCmuxf7/zwffbNikLgaDJTIIty7UhDvAjw==
X-Google-Smtp-Source: AGRyM1tdCwjtCUQea5VNUoIsCbC++W29pnBJnu1EMcGqpl5pQ7dfx3qK1ZZsJG4AyjtuyNUE1IPvWw==
X-Received: by 2002:a2e:96c4:0:b0:25d:3bdc:6fe6 with SMTP id d4-20020a2e96c4000000b0025d3bdc6fe6mr1815238ljj.242.1657281463880;
        Fri, 08 Jul 2022 04:57:43 -0700 (PDT)
Received: from freke.kvaser.se (rota.kvaser.com. [195.22.86.90])
        by smtp.gmail.com with ESMTPSA id h7-20020a2e9ec7000000b0025a724f2935sm7336199ljk.137.2022.07.08.04.57.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Jul 2022 04:57:43 -0700 (PDT)
From:   Jimmy Assarsson <extja@kvaser.com>
To:     linux-can@vger.kernel.org, Anssi Hannula <anssi.hannula@bitwise.fi>
Cc:     Jimmy Assarsson <jimmyassarsson@gmail.com>,
        Jimmy Assarsson <extja@kvaser.com>
Subject: [PATCH v2 08/15] can: kvaser_usb_leaf: Fix TX queue out of sync after restart
Date:   Fri,  8 Jul 2022 13:57:02 +0200
Message-Id: <20220708115709.232815-9-extja@kvaser.com>
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

From: Anssi Hannula <anssi.hannula@bitwise.fi>

The TX queue seems to be implicitly flushed by the hardware during
bus-off or bus-off recovery, but the driver does not reset the TX
bookkeeping.

Despite not resetting TX bookkeeping the driver still re-enables TX
queue unconditionally, leading to "cannot find free context" /
NETDEV_TX_BUSY errors if the TX queue was full at bus-off time.

Fix that by resetting TX bookkeeping on CAN restart.

Tested with 0bfd:0124 Kvaser Mini PCI Express 2xHS FW 4.18.778.

Fixes: 080f40a6fa28 ("can: kvaser_usb: Add support for Kvaser CAN/USB devices")
Tested-by: Jimmy Assarsson <extja@kvaser.com>
Signed-off-by: Anssi Hannula <anssi.hannula@bitwise.fi>
---
Changes in v2:
  - Rebased on b3b6df2c56d8 ("can: kvaser_usb: kvaser_usb_leaf: fix bittiming limits")
  - Removed explicit queue flush.

 drivers/net/can/usb/kvaser_usb/kvaser_usb.h      | 2 ++
 drivers/net/can/usb/kvaser_usb/kvaser_usb_core.c | 2 +-
 drivers/net/can/usb/kvaser_usb/kvaser_usb_leaf.c | 2 ++
 3 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/net/can/usb/kvaser_usb/kvaser_usb.h b/drivers/net/can/usb/kvaser_usb/kvaser_usb.h
index eefcbe3aadce..d018cb5adf83 100644
--- a/drivers/net/can/usb/kvaser_usb/kvaser_usb.h
+++ b/drivers/net/can/usb/kvaser_usb/kvaser_usb.h
@@ -177,6 +177,8 @@ struct kvaser_usb_dev_cfg {
 extern const struct kvaser_usb_dev_ops kvaser_usb_hydra_dev_ops;
 extern const struct kvaser_usb_dev_ops kvaser_usb_leaf_dev_ops;
 
+void kvaser_usb_unlink_tx_urbs(struct kvaser_usb_net_priv *priv);
+
 int kvaser_usb_recv_cmd(const struct kvaser_usb *dev, void *cmd, int len,
 			int *actual_len);
 
diff --git a/drivers/net/can/usb/kvaser_usb/kvaser_usb_core.c b/drivers/net/can/usb/kvaser_usb/kvaser_usb_core.c
index d1401a2d23e9..17d4bbcee831 100644
--- a/drivers/net/can/usb/kvaser_usb/kvaser_usb_core.c
+++ b/drivers/net/can/usb/kvaser_usb/kvaser_usb_core.c
@@ -461,7 +461,7 @@ static void kvaser_usb_reset_tx_urb_contexts(struct kvaser_usb_net_priv *priv)
 /* This method might sleep. Do not call it in the atomic context
  * of URB completions.
  */
-static void kvaser_usb_unlink_tx_urbs(struct kvaser_usb_net_priv *priv)
+void kvaser_usb_unlink_tx_urbs(struct kvaser_usb_net_priv *priv)
 {
 	usb_kill_anchored_urbs(&priv->tx_submitted);
 	kvaser_usb_reset_tx_urb_contexts(priv);
diff --git a/drivers/net/can/usb/kvaser_usb/kvaser_usb_leaf.c b/drivers/net/can/usb/kvaser_usb/kvaser_usb_leaf.c
index 8f9e2707998d..1bc0350d623b 100644
--- a/drivers/net/can/usb/kvaser_usb/kvaser_usb_leaf.c
+++ b/drivers/net/can/usb/kvaser_usb/kvaser_usb_leaf.c
@@ -1660,6 +1660,8 @@ static int kvaser_usb_leaf_set_mode(struct net_device *netdev,
 
 	switch (mode) {
 	case CAN_MODE_START:
+		kvaser_usb_unlink_tx_urbs(priv);
+
 		err = kvaser_usb_leaf_simple_cmd_async(priv, CMD_START_CHIP);
 		if (err)
 			return err;
-- 
2.36.1

