Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 944025AC0B6
	for <lists+linux-can@lfdr.de>; Sat,  3 Sep 2022 20:26:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233227AbiICSZy (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Sat, 3 Sep 2022 14:25:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233318AbiICSZu (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Sat, 3 Sep 2022 14:25:50 -0400
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DCF21089
        for <linux-can@vger.kernel.org>; Sat,  3 Sep 2022 11:25:49 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id q7so7690610lfu.5
        for <linux-can@vger.kernel.org>; Sat, 03 Sep 2022 11:25:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kvaser.com; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=ymLBBFuhOLsBRT4ErhQpDkzXlZDqKPHH8YS+qWCI4Xs=;
        b=dsR+TRqL0opNJH+i2+cEKuAz9gHHtEJYQ26UNcc3tjL0y0k8OdCba/+ok0M5gTurpL
         mEZHoBQsRo6aYjBygLVZ8Vfowg56JQoOPzRBcUOtF+alonpsZKYVPnITcdEHGmU1kk+h
         pOcJclsQ61bdvePMPMx1q8Q0ZEzM7yR0NW4j5JbGVqJe3fHfIPxbuRl7cIiqSYMoEgZk
         JmApCaThsOh4pBPgrAJyr+k/KonbvS/1NnwIYOXvqLrAqEDyK5E2y9dtBI8YWoFGSOz8
         xDAq2GPTd4GW9Z5lVFGmB4MPefKrUVRjZowV6DG45IyMLuaBZd+99dNuoOi9/xggXXNk
         QTag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=ymLBBFuhOLsBRT4ErhQpDkzXlZDqKPHH8YS+qWCI4Xs=;
        b=gNrrvjjesIfMLwUdHceyCnKdY8LUOdRQCv7dy06UMPtDCmKDCtvD3xc5zbWStE+sus
         YCArEHIyXeEqZZ0AecJwu20y+cF17VXOzp4lJ/+1sIQNWaQjblvc2kI2juva6bbYVJQR
         zib69X+eB+AIlnDuZbAd86aA+rSNQXXR2LPcLmz6/z4WoGMKZbshJFfs7ULsANr0gLr1
         AHptk/bEg9ZMaa0h3ppvrONSOv/lmpy+YXNnysfYThnKjKSPxFXY/ZDAyMtIXzRZA4cK
         2XPWvZn8liwh58be4FYxaojarqnvmBK1F5g5NRBNTf5vEbvtHs8tiBX6F6JLNMXRhYUf
         qmfg==
X-Gm-Message-State: ACgBeo3yPGavvTilbLZ0H1JNClCg22cMGwV+BcCbCDGVPqkXyDyNVhMO
        NXCmhRG7z387nSdJLa2XPu0OYxMHL9zv1ISJ
X-Google-Smtp-Source: AA6agR5OurmJ8S4634DwFTpbuvP7Sx7DYISSZ/zFrkFvIZrE3GjgdAtjo/RCk+Yq7i+TaIjjKP9pww==
X-Received: by 2002:a05:6512:2350:b0:494:9925:f734 with SMTP id p16-20020a056512235000b004949925f734mr4383276lfu.97.1662229547560;
        Sat, 03 Sep 2022 11:25:47 -0700 (PDT)
Received: from f6a14fef6d45.. (h-155-4-68-234.A785.priv.bahnhof.se. [155.4.68.234])
        by smtp.gmail.com with ESMTPSA id u18-20020ac24c32000000b00492f6ddba59sm658330lfq.75.2022.09.03.11.25.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 03 Sep 2022 11:25:47 -0700 (PDT)
From:   Jimmy Assarsson <extja@kvaser.com>
To:     linux-can@vger.kernel.org, Marc Kleine-Budde <mkl@pengutronix.de>,
        Anssi Hannula <anssi.hannula@bitwise.fi>
Cc:     Jimmy Assarsson <jimmyassarsson@gmail.com>, stable@vger.kernel.org,
        Jimmy Assarsson <extja@kvaser.com>
Subject: [PATCH v4 11/15] can: kvaser_usb_leaf: Fix wrong CAN state after stopping
Date:   Sat,  3 Sep 2022 20:25:55 +0200
Message-Id: <20220903182559.189-11-extja@kvaser.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20220903182559.189-1-extja@kvaser.com>
References: <20220903182559.189-1-extja@kvaser.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

From: Anssi Hannula <anssi.hannula@bitwise.fi>

0bfd:0124 Kvaser Mini PCI Express 2xHS FW 4.18.778 sends a
CMD_CHIP_STATE_EVENT indicating bus-off after stopping the device,
causing a stopped device to appear as CAN_STATE_BUS_OFF instead of
CAN_STATE_STOPPED.

Fix that by not handling error events on stopped devices.

Cc: stable@vger.kernel.org
Fixes: 080f40a6fa28 ("can: kvaser_usb: Add support for Kvaser CAN/USB devices")
Tested-by: Jimmy Assarsson <extja@kvaser.com>
Signed-off-by: Anssi Hannula <anssi.hannula@bitwise.fi>
Signed-off-by: Jimmy Assarsson <extja@kvaser.com>
---
Changes in v4:
 - No changes

Changes in v3:
 - Rebased on 1d5eeda23f36 ("can: kvaser_usb: advertise timestamping capabilities and add ioctl support")
 - Add stable to CC
 - Add S-o-b

Changes in v2:
  - Rebased on b3b6df2c56d8 ("can: kvaser_usb: kvaser_usb_leaf: fix bittiming limits")

 drivers/net/can/usb/kvaser_usb/kvaser_usb_leaf.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/net/can/usb/kvaser_usb/kvaser_usb_leaf.c b/drivers/net/can/usb/kvaser_usb/kvaser_usb_leaf.c
index 993fcc19637d..4f9c76f4d0da 100644
--- a/drivers/net/can/usb/kvaser_usb/kvaser_usb_leaf.c
+++ b/drivers/net/can/usb/kvaser_usb/kvaser_usb_leaf.c
@@ -1045,6 +1045,10 @@ static void kvaser_usb_leaf_rx_error(const struct kvaser_usb *dev,
 	leaf = priv->sub_priv;
 	stats = &priv->netdev->stats;
 
+	/* Ignore e.g. state change to bus-off reported just after stopping */
+	if (!netif_running(priv->netdev))
+		return;
+
 	/* Update all of the CAN interface's state and error counters before
 	 * trying any memory allocation that can actually fail with -ENOMEM.
 	 *
-- 
2.37.3

