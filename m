Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1373D56B916
	for <lists+linux-can@lfdr.de>; Fri,  8 Jul 2022 14:03:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238288AbiGHL55 (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Fri, 8 Jul 2022 07:57:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238237AbiGHL5x (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Fri, 8 Jul 2022 07:57:53 -0400
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A1689A6B2
        for <linux-can@vger.kernel.org>; Fri,  8 Jul 2022 04:57:50 -0700 (PDT)
Received: by mail-lj1-x236.google.com with SMTP id a11so25647531ljb.5
        for <linux-can@vger.kernel.org>; Fri, 08 Jul 2022 04:57:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kvaser.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=KtahKw9SQZSCY81tu1UrbJw75KhR2Mi2/YKn7R314rE=;
        b=Oi3t8PHd5GbeV0IGaV1E0L9StJVqD38VbcZsSLOOY+wr8utzckS9iRkKDtnHb6QNiC
         fkNbk5qOM/LLjqS4d20Rgz2NVlb+bLG2a/v9RW7dfgJP4Jfr3Dab6yVWOllG73KpiLMA
         tZ7W/PgiA4Pjln3o+kcrqjtNJMiTfWlgB9TZFHonI0EWxwQv53+iuYhO2ioVwiaSLUKR
         3kTr9bLBdTKoxP836zHxkMtB5CCxm49s1mhMf6Jo2pHKFAAlp/W3PvSfIROZB0aR7bjY
         T8sSrqsgVQQ9CR7xgH9r3/poMyvi+M1MoV4cdAJBeGLoW8BuBqoLvY0xh4GN/+3GNNdO
         AgLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=KtahKw9SQZSCY81tu1UrbJw75KhR2Mi2/YKn7R314rE=;
        b=HHSdjKA7FBIllaSrWoRLY1ilARVMbS9wDyfrga0QxnWT8gEVbLdd8Qn9RVGxUjLjlz
         7Xc2x+JKHeVyZ4x2KH8RH0SKrc0ORzaXAkmj9d5YxJRtgJURWc17zM3AV8A6aG1QdLbL
         eiULjZriXYQzYjZW9EDFmmm6QSuVldzkAOt09vBaoXubLb0rgcJ4AjP0K08V/yG3XY3I
         c/Fbkk860xldiwYFHzcVOUMc8SAV0XwDKStRwogmPq55pIaJWy2w+JzFLgrHcnJu9aET
         xISFVVU+A+8PaW7Ipe0r+eXS1O7uIO3bIA9l1Xw5x0O6Lh8wJebUX6P5Qf98nkPGcHBd
         b5oA==
X-Gm-Message-State: AJIora/UyLE0zMhlViSRJAJ0thfuH17JdmFi46B2Ykac2saRNmTLkS6Z
        5GE7xpOGSh8pLi7cIfBBs82/a23YnC1x2g==
X-Google-Smtp-Source: AGRyM1uLGA3Wlf5eAJuRzsLdmUwapxDGAxc9kcmRvOpVsapPdB8wspt3b33sLCZ2SpkuJGK6bA5p9A==
X-Received: by 2002:a05:651c:19aa:b0:25b:d22a:dfc7 with SMTP id bx42-20020a05651c19aa00b0025bd22adfc7mr1705689ljb.410.1657281470144;
        Fri, 08 Jul 2022 04:57:50 -0700 (PDT)
Received: from freke.kvaser.se (rota.kvaser.com. [195.22.86.90])
        by smtp.gmail.com with ESMTPSA id h7-20020a2e9ec7000000b0025a724f2935sm7336199ljk.137.2022.07.08.04.57.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Jul 2022 04:57:49 -0700 (PDT)
From:   Jimmy Assarsson <extja@kvaser.com>
To:     linux-can@vger.kernel.org, Anssi Hannula <anssi.hannula@bitwise.fi>
Cc:     Jimmy Assarsson <jimmyassarsson@gmail.com>,
        Jimmy Assarsson <extja@kvaser.com>
Subject: [PATCH v2 12/15] can: kvaser_usb_leaf: Ignore stale bus-off after start
Date:   Fri,  8 Jul 2022 13:57:06 +0200
Message-Id: <20220708115709.232815-13-extja@kvaser.com>
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

With 0bfd:0124 Kvaser Mini PCI Express 2xHS FW 4.18.778 it was observed
that if the device was bus-off when stopped, at next start (either via
interface down/up or manual bus-off restart) the initial
CMD_CHIP_STATE_EVENT received just after CMD_START_CHIP_REPLY will have
the M16C_STATE_BUS_OFF bit still set, causing the interface to
immediately go bus-off again.

The bit seems to internally clear quickly afterwards but we do not get
another CMD_CHIP_STATE_EVENT.

Fix the issue by ignoring any initial bus-off state until we see at
least one bus-on state. Also, poll the state periodically until that
occurs.

It is possible we lose one actual immediately occurring bus-off event
here in which case the HW will auto-recover and we see the recovery
event. We will then catch the next bus-off event, if any.

This issue did not reproduce with 0bfd:0017 Kvaser Memorator
Professional HS/HS FW 2.0.50.

Fixes: 71873a9b38d1 ("can: kvaser_usb: Add support for more Kvaser Leaf v2 devices")
Tested-by: Jimmy Assarsson <extja@kvaser.com>
Signed-off-by: Anssi Hannula <anssi.hannula@bitwise.fi>
---
Changes in v2:
  - Rebased on b3b6df2c56d8 ("can: kvaser_usb: kvaser_usb_leaf: fix bittiming limits")

 .../net/can/usb/kvaser_usb/kvaser_usb_leaf.c  | 31 ++++++++++++++++++-
 1 file changed, 30 insertions(+), 1 deletion(-)

diff --git a/drivers/net/can/usb/kvaser_usb/kvaser_usb_leaf.c b/drivers/net/can/usb/kvaser_usb/kvaser_usb_leaf.c
index 2e242340c4bc..dee3ae45a972 100644
--- a/drivers/net/can/usb/kvaser_usb/kvaser_usb_leaf.c
+++ b/drivers/net/can/usb/kvaser_usb/kvaser_usb_leaf.c
@@ -427,6 +427,9 @@ struct kvaser_usb_net_leaf_priv {
 	struct kvaser_usb_net_priv *net;
 
 	struct delayed_work chip_state_req_work;
+
+	/* started but not reported as bus-on yet */
+	bool joining_bus;
 };
 
 static const struct can_bittiming_const kvaser_usb_leaf_m16c_bittiming_const = {
@@ -966,6 +969,7 @@ kvaser_usb_leaf_rx_error_update_can_state(struct kvaser_usb_net_priv *priv,
 					const struct kvaser_usb_err_summary *es,
 					struct can_frame *cf)
 {
+	struct kvaser_usb_net_leaf_priv *leaf = priv->sub_priv;
 	struct kvaser_usb *dev = priv->dev;
 	struct net_device_stats *stats = &priv->netdev->stats;
 	enum can_state cur_state, new_state, tx_state, rx_state;
@@ -990,6 +994,22 @@ kvaser_usb_leaf_rx_error_update_can_state(struct kvaser_usb_net_priv *priv,
 		new_state = CAN_STATE_ERROR_ACTIVE;
 	}
 
+	/* 0bfd:0124 FW 4.18.778 was observed to send the initial
+	 * CMD_CHIP_STATE_EVENT after CMD_START_CHIP with M16C_STATE_BUS_OFF
+	 * bit set if the channel was bus-off when it was last stopped (even
+	 * across chip resets). This bit will clear shortly afterwards, without
+	 * triggering a second unsolicited chip state event.
+	 * Ignore this initial bus-off.
+	 */
+	if (leaf->joining_bus) {
+		if (new_state == CAN_STATE_BUS_OFF) {
+			netdev_dbg(priv->netdev, "ignoring bus-off during startup");
+			new_state = cur_state;
+		} else {
+			leaf->joining_bus = false;
+		}
+	}
+
 	if (new_state != cur_state) {
 		tx_state = (es->txerr >= es->rxerr) ? new_state : 0;
 		rx_state = (es->txerr <= es->rxerr) ? new_state : 0;
@@ -1065,9 +1085,12 @@ static void kvaser_usb_leaf_rx_error(const struct kvaser_usb *dev,
 
 	/* If there are errors, request status updates periodically as we do
 	 * not get automatic notifications of improved state.
+	 * Also request updates if we saw a stale BUS_OFF during startup
+	 * (joining_bus).
 	 */
 	if (new_state < CAN_STATE_BUS_OFF &&
-	    (es->rxerr || es->txerr || new_state == CAN_STATE_ERROR_PASSIVE))
+	    (es->rxerr || es->txerr || new_state == CAN_STATE_ERROR_PASSIVE ||
+	     leaf->joining_bus))
 		schedule_delayed_work(&leaf->chip_state_req_work,
 				      msecs_to_jiffies(500));
 
@@ -1584,8 +1607,11 @@ static int kvaser_usb_leaf_set_opt_mode(const struct kvaser_usb_net_priv *priv)
 
 static int kvaser_usb_leaf_start_chip(struct kvaser_usb_net_priv *priv)
 {
+	struct kvaser_usb_net_leaf_priv *leaf = priv->sub_priv;
 	int err;
 
+	leaf->joining_bus = true;
+
 	reinit_completion(&priv->start_comp);
 
 	err = kvaser_usb_leaf_send_simple_cmd(priv->dev, CMD_START_CHIP,
@@ -1716,12 +1742,15 @@ static int kvaser_usb_leaf_set_mode(struct net_device *netdev,
 				    enum can_mode mode)
 {
 	struct kvaser_usb_net_priv *priv = netdev_priv(netdev);
+	struct kvaser_usb_net_leaf_priv *leaf = priv->sub_priv;
 	int err;
 
 	switch (mode) {
 	case CAN_MODE_START:
 		kvaser_usb_unlink_tx_urbs(priv);
 
+		leaf->joining_bus = true;
+
 		err = kvaser_usb_leaf_simple_cmd_async(priv, CMD_START_CHIP);
 		if (err)
 			return err;
-- 
2.36.1

