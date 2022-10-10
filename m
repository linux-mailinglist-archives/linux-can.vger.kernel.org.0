Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8184F5FA0E9
	for <lists+linux-can@lfdr.de>; Mon, 10 Oct 2022 17:09:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229964AbiJJPJK (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Mon, 10 Oct 2022 11:09:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229942AbiJJPJG (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Mon, 10 Oct 2022 11:09:06 -0400
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com [IPv6:2a00:1450:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 513046B64B
        for <linux-can@vger.kernel.org>; Mon, 10 Oct 2022 08:09:05 -0700 (PDT)
Received: by mail-lj1-x234.google.com with SMTP id bn8so13605051ljb.6
        for <linux-can@vger.kernel.org>; Mon, 10 Oct 2022 08:09:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kvaser.com; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2tNUCo9uNn6LaGT1MZJ6SaGzkvbkbba/rPH3jpX17po=;
        b=AhT7Tw/23+nqYUfSoamI0Xn1RdCgl3pAZQvYYGAqBL4kfoWVJns0EzjMhAbs1s3Edo
         /CJdllOGvBq8T+S4SIEYOkHUARTn6ln4DxB9DFhPrRm9oJi7PWr5kVJStHdE8TpwBgP4
         1V2PxeAAehSW+N2hUUWDHcZiS7BwA6g3NJkp0494+Rz3hO0kYTgRWSVMMYwQnXhja9dX
         XxdqpmjvoJGEO0ycKdSo0Gjjafxr6m9165hqs3MSKNS7ud65b/tYfAsuWfKNeQgvoefe
         iyCbBsfjqGAWeFCPvKMLi5oIeR1m+ZGJJY9CU3Fsu9BMawxR9RiOWK7A0j51SKIZRwy4
         uOBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2tNUCo9uNn6LaGT1MZJ6SaGzkvbkbba/rPH3jpX17po=;
        b=pUP2DuCTik6P/quQbZhhS9dSjo+pX+bofFHgKWRBsRBBRM9ZBdyiuhraZlsyNxG+3d
         uuPi8/vq+ixsyaGVq7UVrP1vuTdBXI6h8vVu4GFTyYbdHveuxM/AlKsnmp92Y/HzBIeK
         e3h1FHkpo3CET8/FMGAFoTBoeFlZUlKA+KzrTub1sXfeylxuTlXd2ohKjKm5qiW6PDM4
         MYAJqEOEqebQPuE28GsMVgeq28xRejXf6PwRhKBOv/p+ekJv74Vmh5cq0BqtgLRFQExi
         Pm2eRGtfwD3sVixFccp9LrkiCOUBUi2ndjdGQZAYtIANLw1OVyXybkRQhYZCp7zecyAr
         OgMA==
X-Gm-Message-State: ACrzQf1iEflit4afdG1ECnQbOqtzlyTOgIwLGUskwBiPaRqZhzgvpz3R
        PKC7Txm1lm4jHfu0QRwz+5+rZgpTYfM/Ag==
X-Google-Smtp-Source: AMsMyM5wYnJrSF1USPDxvbuYksHUDLqlsPGwe7DuNy1ATMjaRtmwX0Q58wFmBqkLsm+qy9k4eOin5Q==
X-Received: by 2002:a2e:b61c:0:b0:26c:c17:feeb with SMTP id r28-20020a2eb61c000000b0026c0c17feebmr7369122ljn.199.1665414543683;
        Mon, 10 Oct 2022 08:09:03 -0700 (PDT)
Received: from archyz.. (h-155-4-68-234.A785.priv.bahnhof.se. [155.4.68.234])
        by smtp.gmail.com with ESMTPSA id q7-20020ac24a67000000b0049ebc44994fsm1450280lfp.128.2022.10.10.08.08.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Oct 2022 08:08:59 -0700 (PDT)
From:   Jimmy Assarsson <extja@kvaser.com>
To:     linux-can@vger.kernel.org, Marc Kleine-Budde <mkl@pengutronix.de>,
        Anssi Hannula <anssi.hannula@bitwise.fi>
Cc:     Jimmy Assarsson <jimmyassarsson@gmail.com>, stable@vger.kernel.org,
        Jimmy Assarsson <extja@kvaser.com>
Subject: [PATCH v5 2/4] can: kvaser_usb: Fix use of uninitialized completion
Date:   Mon, 10 Oct 2022 17:08:27 +0200
Message-Id: <20221010150829.199676-3-extja@kvaser.com>
X-Mailer: git-send-email 2.38.0
In-Reply-To: <20221010150829.199676-1-extja@kvaser.com>
References: <20221010150829.199676-1-extja@kvaser.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

From: Anssi Hannula <anssi.hannula@bitwise.fi>

flush_comp is initialized when CMD_FLUSH_QUEUE is sent to the device and
completed when the device sends CMD_FLUSH_QUEUE_RESP.

This causes completion of uninitialized completion if the device sends
CMD_FLUSH_QUEUE_RESP before CMD_FLUSH_QUEUE is ever sent (e.g. as a
response to a flush by a previously bound driver, or a misbehaving
device).

Fix that by initializing flush_comp in kvaser_usb_init_one() like the
other completions.

This issue is only triggerable after RX URBs have been set up, i.e. the
interface has been opened at least once.

Cc: stable@vger.kernel.org
Fixes: aec5fb2268b7 ("can: kvaser_usb: Add support for Kvaser USB hydra family")
Tested-by: Jimmy Assarsson <extja@kvaser.com>
Signed-off-by: Anssi Hannula <anssi.hannula@bitwise.fi>
Signed-off-by: Jimmy Assarsson <extja@kvaser.com>
---
Changes in v5:
 - Split series and rebased

Changes in v4:
 - No changes

Changes in v3:
 - Rebased on 1d5eeda23f36 ("can: kvaser_usb: advertise timestamping capabilities and add ioctl support")
 - Add stable to CC
 - Add S-o-b

Changes in v2:
  - Rebased on b3b6df2c56d8 ("can: kvaser_usb: kvaser_usb_leaf: fix bittiming limits")

 drivers/net/can/usb/kvaser_usb/kvaser_usb_core.c  | 1 +
 drivers/net/can/usb/kvaser_usb/kvaser_usb_hydra.c | 2 +-
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/can/usb/kvaser_usb/kvaser_usb_core.c b/drivers/net/can/usb/kvaser_usb/kvaser_usb_core.c
index 824cab80aa02..c2bce6773adc 100644
--- a/drivers/net/can/usb/kvaser_usb/kvaser_usb_core.c
+++ b/drivers/net/can/usb/kvaser_usb/kvaser_usb_core.c
@@ -729,6 +729,7 @@ static int kvaser_usb_init_one(struct kvaser_usb *dev, int channel)
 	init_usb_anchor(&priv->tx_submitted);
 	init_completion(&priv->start_comp);
 	init_completion(&priv->stop_comp);
+	init_completion(&priv->flush_comp);
 	priv->can.ctrlmode_supported = 0;
 
 	priv->dev = dev;
diff --git a/drivers/net/can/usb/kvaser_usb/kvaser_usb_hydra.c b/drivers/net/can/usb/kvaser_usb/kvaser_usb_hydra.c
index 6871d474dabf..7b52fda73d82 100644
--- a/drivers/net/can/usb/kvaser_usb/kvaser_usb_hydra.c
+++ b/drivers/net/can/usb/kvaser_usb/kvaser_usb_hydra.c
@@ -1916,7 +1916,7 @@ static int kvaser_usb_hydra_flush_queue(struct kvaser_usb_net_priv *priv)
 {
 	int err;
 
-	init_completion(&priv->flush_comp);
+	reinit_completion(&priv->flush_comp);
 
 	err = kvaser_usb_hydra_send_simple_cmd(priv->dev, CMD_FLUSH_QUEUE,
 					       priv->channel);
-- 
2.38.0

