Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D1DC5FA3B9
	for <lists+linux-can@lfdr.de>; Mon, 10 Oct 2022 20:53:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229768AbiJJSxi (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Mon, 10 Oct 2022 14:53:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229827AbiJJSxY (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Mon, 10 Oct 2022 14:53:24 -0400
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C7D678BD5
        for <linux-can@vger.kernel.org>; Mon, 10 Oct 2022 11:53:19 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id s20so17830773lfi.11
        for <linux-can@vger.kernel.org>; Mon, 10 Oct 2022 11:53:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kvaser.com; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1HINvVPmb4X8L2XOdga6ODOXBdEVC8AGfMsIYSfWjDU=;
        b=ZpjdB9/TnD18nH23VpyOJ+2TAsgqiXr8dK91PZCibqQBBo5uzF4Biq37axbVFOx4Os
         jXBrYPf+49BmgcxRjkzSEzpIUTJLox1cUlPlnjSvEwm4CmCZhKcEW/3iFbn/ECHYe41O
         4gZJxHVPl40aW5j4dIg9mVY8DvXiiAkHp2Jml4MgxzKavGl1NYRYwAY4OdmkYI0qF+xz
         JshPbpsHWdW+XyG3Dm4+LPohY0uN/RF6lqO8G15DocXX/rvTEVCnBuxD6hJsT2Va42HD
         NZ0ieuKJXRSoFl/zG5NyMT0k1u4C9la+ePDhGuUjQcxDymQhY98BrRkPeBJEr7DprxVL
         Suhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1HINvVPmb4X8L2XOdga6ODOXBdEVC8AGfMsIYSfWjDU=;
        b=t5q4b7NMFylmrb7zulXDMqFWgL+yS3pI2/SoCOBrOHaYaITqtGlfZDdAU6s2xeflI9
         ozu03o3MgJDKyY3vlyWmdVIzaQIu5cp+IGHfqmbVf7Q5rv0xGtMdOKxshjxx1D93DUYP
         xUAi2JaBsk33vy/TL8TE9ZkV1MOxHWKWqMeR9KcET4VDqbKJWs8kesqimD+cZVXyw+SQ
         sAr+etId9gUB8+Fn1SUdRwwJSNPPAsQGSZk3VtF0Pt17J9fSUNO5qRFmkYvi1jIn6CsK
         2lV+xpdON79mcNP8H4ew3pVKMkOs9bja6TmYjrlTinj+YFlvMEb5IHaAq9RxlNasH5zN
         5irw==
X-Gm-Message-State: ACrzQf2klRFrJAS18pWz40LARmybzA7Ww9/J3h4otzNhnjcTHyNXNxis
        sOzvR48x8jmyUWVjUEbqv+J5qzl2X6oLCg==
X-Google-Smtp-Source: AMsMyM5azU2UTH4jbh35A5ralSiaA0aKjSkPOxgk8M7Gcd565kJ+xWqz879cCph9YZsL2dwTJ655LQ==
X-Received: by 2002:ac2:4e88:0:b0:4a2:2fa8:9bd8 with SMTP id o8-20020ac24e88000000b004a22fa89bd8mr6709590lfr.621.1665427997054;
        Mon, 10 Oct 2022 11:53:17 -0700 (PDT)
Received: from archyz.. (h-155-4-68-234.A785.priv.bahnhof.se. [155.4.68.234])
        by smtp.gmail.com with ESMTPSA id b4-20020a056512070400b004a2386b8ce6sm1517769lfs.207.2022.10.10.11.53.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Oct 2022 11:53:16 -0700 (PDT)
From:   Jimmy Assarsson <extja@kvaser.com>
To:     linux-can@vger.kernel.org, Marc Kleine-Budde <mkl@pengutronix.de>,
        Anssi Hannula <anssi.hannula@bitwise.fi>
Cc:     Jimmy Assarsson <jimmyassarsson@gmail.com>,
        Jimmy Assarsson <extja@kvaser.com>
Subject: [PATCH can-next v5 09/11] can: kvaser_usb_leaf: Fix bogus restart events
Date:   Mon, 10 Oct 2022 20:52:35 +0200
Message-Id: <20221010185237.319219-10-extja@kvaser.com>
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

When auto-restart is enabled, the kvaser_usb_leaf driver considers
transition from any state >= CAN_STATE_BUS_OFF as a bus-off recovery
event (restart).

However, these events may occur at interface startup time before
kvaser_usb_open() has set the state to CAN_STATE_ERROR_ACTIVE, causing
restarts counter to increase and CAN_ERR_RESTARTED to be sent despite no
actual restart having occurred.

Fix that by making the auto-restart condition checks more strict so that
they only trigger when the interface was actually in the BUS_OFF state.

Fixes: 080f40a6fa28 ("can: kvaser_usb: Add support for Kvaser CAN/USB devices")
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
2.38.0

