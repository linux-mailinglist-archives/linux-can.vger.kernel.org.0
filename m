Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B247A5FA3B5
	for <lists+linux-can@lfdr.de>; Mon, 10 Oct 2022 20:53:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229809AbiJJSxV (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Mon, 10 Oct 2022 14:53:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229768AbiJJSxT (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Mon, 10 Oct 2022 14:53:19 -0400
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DA77786F8
        for <linux-can@vger.kernel.org>; Mon, 10 Oct 2022 11:53:17 -0700 (PDT)
Received: by mail-lj1-x22c.google.com with SMTP id m14so14276008ljg.2
        for <linux-can@vger.kernel.org>; Mon, 10 Oct 2022 11:53:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kvaser.com; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yGq26Yh55/MysQq7c2Yu3fFfQ/GeuLfaZjdxgq0B6ms=;
        b=n/KcW3S1BnCfEZ0v4yMOdg1DBeY+QG+DCAci5tEEicrFYZ3TqtlPkuu5HJOxYEmYer
         Y3u1O6cEEyPyIqpOdsgKplo5c9mlQ+GaMoaZ7laWHvfYXIvfBPv2c3mGxDmAdiOU0saw
         C7b13ESRKrqtQoDr1witdhBkl45wl0QOHGu78IjqlnbvHZ3hwmzu4KLgaLGrOGfSMOM7
         6OSwi/aWT7VPXjyl7Jnr89YytU+qFZa7yNrqSToPsGJJktcx/Qf6C1e8UjJVkyEL2K6G
         +dzcfw7CBS+tfeG6zGYJWfJJo+24YsKw1v2nEPh4S6ZZ8xHh5AqGOtdyor9lh06mR+RR
         v0ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yGq26Yh55/MysQq7c2Yu3fFfQ/GeuLfaZjdxgq0B6ms=;
        b=cc5MFdHEEN9RQSolO694IkZxrmq2oSkJc+jq3CfeSm4K/oDpskBicz9Rb1Znu+CJIr
         Fa5VAnMe3EY7k9ljxm5cNcWJ+Yy1wFH7bBv3u4Z38K9ZtTUvA3zFuR/Dq1NVpYAXROT4
         4pQSzsqbXqlJN0KxXQfKPpj3+HtPL2HdeZPbZpdm/p1Y5Z9OSZM10ggT9c4lSKYiakFD
         jocWCYBQ3t5oa8xwtSpC6rmyWe4Z6jR4kVCvrE+mshdNP+LP99N4dzjBsd2eBZxEISJ7
         YOQiyD8uAFYfBe8lE+HoE7/8vkYlUUMktyyeuw2ioHus4Q6N/OQTUAod0uQPJ6y+jVXH
         eYnA==
X-Gm-Message-State: ACrzQf38cKmjko4w3aDVpVHJ0EX7iR1H6IX+LC1DFLIaMGQgSgogjJGO
        gw42FrnBMDd/b/no5b79FSbSoEVoag3Haw==
X-Google-Smtp-Source: AMsMyM4L0IQJgJXf8HEua/5vdr/s6WhrvAo/Z73Bk9X5KNOL4hBeT1QDe6ATiygA2DJnLovyv7gwiA==
X-Received: by 2002:a05:651c:505:b0:26c:5815:5519 with SMTP id o5-20020a05651c050500b0026c58155519mr7527726ljp.316.1665427995469;
        Mon, 10 Oct 2022 11:53:15 -0700 (PDT)
Received: from archyz.. (h-155-4-68-234.A785.priv.bahnhof.se. [155.4.68.234])
        by smtp.gmail.com with ESMTPSA id b4-20020a056512070400b004a2386b8ce6sm1517769lfs.207.2022.10.10.11.53.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Oct 2022 11:53:14 -0700 (PDT)
From:   Jimmy Assarsson <extja@kvaser.com>
To:     linux-can@vger.kernel.org, Marc Kleine-Budde <mkl@pengutronix.de>,
        Anssi Hannula <anssi.hannula@bitwise.fi>
Cc:     Jimmy Assarsson <jimmyassarsson@gmail.com>,
        Jimmy Assarsson <extja@kvaser.com>
Subject: [PATCH can-next v5 08/11] can: kvaser_usb_leaf: Ignore stale bus-off after start
Date:   Mon, 10 Oct 2022 20:52:34 +0200
Message-Id: <20221010185237.319219-9-extja@kvaser.com>
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
 - Add S-o-b

Changes in v2:
  - Rebased on b3b6df2c56d8 ("can: kvaser_usb: kvaser_usb_leaf: fix bittiming limits")

 .../net/can/usb/kvaser_usb/kvaser_usb_leaf.c  | 31 ++++++++++++++++++-
 1 file changed, 30 insertions(+), 1 deletion(-)

diff --git a/drivers/net/can/usb/kvaser_usb/kvaser_usb_leaf.c b/drivers/net/can/usb/kvaser_usb/kvaser_usb_leaf.c
index 4f9c76f4d0da..f8a12a285050 100644
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
 
@@ -1587,8 +1610,11 @@ static int kvaser_usb_leaf_set_opt_mode(const struct kvaser_usb_net_priv *priv)
 
 static int kvaser_usb_leaf_start_chip(struct kvaser_usb_net_priv *priv)
 {
+	struct kvaser_usb_net_leaf_priv *leaf = priv->sub_priv;
 	int err;
 
+	leaf->joining_bus = true;
+
 	reinit_completion(&priv->start_comp);
 
 	err = kvaser_usb_leaf_send_simple_cmd(priv->dev, CMD_START_CHIP,
@@ -1719,12 +1745,15 @@ static int kvaser_usb_leaf_set_mode(struct net_device *netdev,
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
2.38.0

