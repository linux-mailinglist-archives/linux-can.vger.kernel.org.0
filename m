Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6FFFE5A96E5
	for <lists+linux-can@lfdr.de>; Thu,  1 Sep 2022 14:30:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233602AbiIAM3q (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Thu, 1 Sep 2022 08:29:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233646AbiIAM33 (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Thu, 1 Sep 2022 08:29:29 -0400
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BD04128566
        for <linux-can@vger.kernel.org>; Thu,  1 Sep 2022 05:28:35 -0700 (PDT)
Received: by mail-lj1-x22c.google.com with SMTP id p18so14380072ljc.9
        for <linux-can@vger.kernel.org>; Thu, 01 Sep 2022 05:28:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kvaser.com; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=6/eEwst+sxe9movANk/wYh7oOTqUlZjBlLB1xTwzsow=;
        b=xHpozMNMNx/tLpWKhThKJseC9hNMD0fx3DSiSLiae5oOyFd8NUs66Q3uhAv/xnwCLv
         i2IKfRXHL971M6CUy6ndo2D3kqq6Ym3J/1RXsdxbMULvhTITa6zncJqjZVf5ddK5NhQt
         WhTMPZ1D8sp4w8PoafvCsL0iXiuECZ89WEAf/bwAHdWU+zA6XVZ2496y+JS+b/wMJhYk
         poayAQ/y8Hzuzm+FlQk+q+Z3G0lLeTCtFjECjwbF8hyPUkcSHbiQcCZ0wHRjCCS9J2St
         weFDa7i2a+PbrCYY+L2jxhah4WSFemfo1leVmqJl22yaiPFssKPjh11PfDer8cmcPusf
         u7Qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=6/eEwst+sxe9movANk/wYh7oOTqUlZjBlLB1xTwzsow=;
        b=d8qPs06nnBiqmeETmt6t15NZcnA9vZkTTN3t+JnGhIe+WH0Z80/8g1a9891lIDw+/+
         z3Ik49geH7AwABphAG2OwoKnSD3sI2QPAp9NY93ptnSABVbM79WKEhpYmZrqpyWnBFqJ
         LVFC9Qo6LlLO/ZYx60JX3sypsjrH1tTBsuOIStfZHkTaA5XD8w31EzLzO+hDjKJbqPF/
         7vs5MTbHcBNuz5aMyiYKEuczO9En0+1h9jRYK4y3cAMXbOg/urHeIS+j/G420eDV7BQp
         TcbNUdiU4MqYfAjLYMFRIY96v5uhWu/uTl505LaHGFiQuNmt035M7JhmEbsIah/uNmi6
         XS3w==
X-Gm-Message-State: ACgBeo3EhZ9/hNVvc+fnv4lqck2FU7zHaihpft7PeAGMV/FANPmfNQyX
        beA8LJAfpaUfaYbkM1TennHldQ05soScJw==
X-Google-Smtp-Source: AA6agR4zrmDgiio+/EU5AUtZR8xYHdPv0Jd/HumoP4otIhC0L3GGgr96oDqoqejKqPVes7Y5sSasHg==
X-Received: by 2002:a05:651c:179d:b0:260:576c:ddeb with SMTP id bn29-20020a05651c179d00b00260576cddebmr10241786ljb.514.1662035311287;
        Thu, 01 Sep 2022 05:28:31 -0700 (PDT)
Received: from fb10a0c5d590.. (h-155-4-68-234.A785.priv.bahnhof.se. [155.4.68.234])
        by smtp.gmail.com with ESMTPSA id s12-20020a056512202c00b00492c2394ea5sm125935lfs.165.2022.09.01.05.28.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Sep 2022 05:28:30 -0700 (PDT)
From:   Jimmy Assarsson <extja@kvaser.com>
To:     linux-can@vger.kernel.org, Marc Kleine-Budde <mkl@pengutronix.de>,
        Anssi Hannula <anssi.hannula@bitwise.fi>
Cc:     Jimmy Assarsson <jimmyassarsson@gmail.com>, stable@vger.kernel.org,
        Jimmy Assarsson <extja@kvaser.com>
Subject: [PATCH v3 13/15] can: kvaser_usb_leaf: Fix bogus restart events
Date:   Thu,  1 Sep 2022 14:27:27 +0200
Message-Id: <20220901122729.271-14-extja@kvaser.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20220901122729.271-1-extja@kvaser.com>
References: <20220901122729.271-1-extja@kvaser.com>
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

When auto-restart is enabled, the kvaser_usb_leaf driver considers
transition from any state >= CAN_STATE_BUS_OFF as a bus-off recovery
event (restart).

However, these events may occur at interface startup time before
kvaser_usb_open() has set the state to CAN_STATE_ERROR_ACTIVE, causing
restarts counter to increase and CAN_ERR_RESTARTED to be sent despite no
actual restart having occurred.

Fix that by making the auto-restart condition checks more strict so that
they only trigger when the interface was actually in the BUS_OFF state.

Cc: stable@vger.kernel.org
Fixes: 080f40a6fa28 ("can: kvaser_usb: Add support for Kvaser CAN/USB devices")
Tested-by: Jimmy Assarsson <extja@kvaser.com>
Signed-off-by: Anssi Hannula <anssi.hannula@bitwise.fi>
Signed-off-by: Jimmy Assarsson <extja@kvaser.com>
---
Changes in v3:
 - Rebased on 1d5eeda23f36 ("can: kvaser_usb: advertise timestamping capabilities and add ioctl support")
 - Add stable to CC
 - Add S-o-b

Changes in v2:
  - Rebased on b3b6df2c56d8 ("can: kvaser_usb: kvaser_usb_leaf: fix bittiming limits")

 drivers/net/can/usb/kvaser_usb/kvaser_usb_leaf.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/net/can/usb/kvaser_usb/kvaser_usb_leaf.c b/drivers/net/can/usb/kvaser_usb/kvaser_usb_leaf.c
index f8a12a285050..3e31a9ebea88 100644
--- a/drivers/net/can/usb/kvaser_usb/kvaser_usb_leaf.c
+++ b/drivers/net/can/usb/kvaser_usb/kvaser_usb_leaf.c
@@ -901,7 +901,7 @@ static void kvaser_usb_leaf_tx_acknowledge(const struct kvaser_usb *dev,
 	context = &priv->tx_contexts[tid % dev->max_tx_urbs];
 
 	/* Sometimes the state change doesn't come after a bus-off event */
-	if (priv->can.restart_ms && priv->can.state >= CAN_STATE_BUS_OFF) {
+	if (priv->can.restart_ms && priv->can.state == CAN_STATE_BUS_OFF) {
 		struct sk_buff *skb;
 		struct can_frame *cf;
 
@@ -1018,7 +1018,7 @@ kvaser_usb_leaf_rx_error_update_can_state(struct kvaser_usb_net_priv *priv,
 	}
 
 	if (priv->can.restart_ms &&
-	    cur_state >= CAN_STATE_BUS_OFF &&
+	    cur_state == CAN_STATE_BUS_OFF &&
 	    new_state < CAN_STATE_BUS_OFF)
 		priv->can.can_stats.restarts++;
 
@@ -1111,7 +1111,7 @@ static void kvaser_usb_leaf_rx_error(const struct kvaser_usb *dev,
 		}
 
 		if (priv->can.restart_ms &&
-		    old_state >= CAN_STATE_BUS_OFF &&
+		    old_state == CAN_STATE_BUS_OFF &&
 		    new_state < CAN_STATE_BUS_OFF) {
 			cf->can_id |= CAN_ERR_RESTARTED;
 			netif_carrier_on(priv->netdev);
-- 
2.37.3

