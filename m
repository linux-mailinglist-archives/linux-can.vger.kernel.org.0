Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF21756B910
	for <lists+linux-can@lfdr.de>; Fri,  8 Jul 2022 13:57:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238212AbiGHL5f (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Fri, 8 Jul 2022 07:57:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238295AbiGHL5d (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Fri, 8 Jul 2022 07:57:33 -0400
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDFE39A6B7
        for <linux-can@vger.kernel.org>; Fri,  8 Jul 2022 04:57:32 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id t19so35331667lfl.5
        for <linux-can@vger.kernel.org>; Fri, 08 Jul 2022 04:57:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kvaser.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=hMzhL3gyAtonu+XhjKI3qI5Id5lyHlv53kRqTglFu+k=;
        b=nNq6lxvK3C7b32MF4hlQ0U2qRvBfgmFP2Vd0tWoGsz7KaL9Ah2jSmRgdbI0q6oJwKN
         /K9jvg+7CoLK+k4BTSZ5rlnNsbQmlrtXhPjdwoPPAQX56y7Q93KYSnIkMCuAJUawpqEw
         GC/AHBldI+nbthbeNhfeS7bReZReh+RRFsJ/iyDyo8NUzKhhUetNR54e1ky6vIbYwPIB
         z9xXWUMFuIqnvb2ZyDRLMP/3KAJNNki1/X4h3/rd/VHAtqm9ym8GduJ8WoQu+3B5rnLI
         CGkcnaaj4YyXgjXkL5NOW8RxGqcDZx58O2HW5IefnhsbYY1bJ+VP6wq1yVAsFjeWMt6g
         CYUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=hMzhL3gyAtonu+XhjKI3qI5Id5lyHlv53kRqTglFu+k=;
        b=TTlryrDrw5zquMMSkaCzCnUaR1PZWKK4UqrNC7z7BRaxJI9xedbU/v6qLpwerDiNr/
         9QHJvvpFwmNJFsEE0Q2Dt0gSklictOFZBNha07hX20yCYnkfHOr2JQ0HWKUVceCJqjjd
         +ezKTn3VioI9QoT20kcdGpntXsPAK/eMiLIKfTVbFFgzrV+lL3cO7HulIJoTTQZ7MabM
         IwNWbq5x77e0BWcLtD6QI5P/I4/I6qujceRMsGZIKns1BgpJ/FRDHKwv8N+sowUvHax9
         ANDP7hXB+Qk5q23PD13JbJjCKWb/hUE1SAjF+11PSIsVU0nnKDn1wE5x2/JsIa/cyC+c
         /P1w==
X-Gm-Message-State: AJIora+K0mYjtLoEbiZw8lbqFV7IrbYdge3ZB771OTONZznYnhrxqhBc
        H3XjNQMOgAYRvV3WcBWAu+Sf5bCpchmfIA==
X-Google-Smtp-Source: AGRyM1vdj2z1iKf/hSWK8pZDQz31moVbyQ0RJYkix6wIXSnGaqvoXOvNCcsCtJYN75QEg8drYooF1Q==
X-Received: by 2002:a05:6512:2286:b0:47f:785a:3bc5 with SMTP id f6-20020a056512228600b0047f785a3bc5mr2100294lfu.252.1657281451295;
        Fri, 08 Jul 2022 04:57:31 -0700 (PDT)
Received: from freke.kvaser.se (rota.kvaser.com. [195.22.86.90])
        by smtp.gmail.com with ESMTPSA id h7-20020a2e9ec7000000b0025a724f2935sm7336199ljk.137.2022.07.08.04.57.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Jul 2022 04:57:31 -0700 (PDT)
From:   Jimmy Assarsson <extja@kvaser.com>
To:     linux-can@vger.kernel.org, Anssi Hannula <anssi.hannula@bitwise.fi>
Cc:     Jimmy Assarsson <jimmyassarsson@gmail.com>,
        Jimmy Assarsson <extja@kvaser.com>
Subject: [PATCH v2 02/15] can: kvaser_usb: Fix use of uninitialized completion
Date:   Fri,  8 Jul 2022 13:56:56 +0200
Message-Id: <20220708115709.232815-3-extja@kvaser.com>
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

Fixes: aec5fb2268b7 ("can: kvaser_usb: Add support for Kvaser USB hydra family")
Tested-by: Jimmy Assarsson <extja@kvaser.com>
Signed-off-by: Anssi Hannula <anssi.hannula@bitwise.fi>
---
Changes in v2:
  - Rebased on b3b6df2c56d8 ("can: kvaser_usb: kvaser_usb_leaf: fix bittiming limits")

 drivers/net/can/usb/kvaser_usb/kvaser_usb_core.c  | 1 +
 drivers/net/can/usb/kvaser_usb/kvaser_usb_hydra.c | 2 +-
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/can/usb/kvaser_usb/kvaser_usb_core.c b/drivers/net/can/usb/kvaser_usb/kvaser_usb_core.c
index f211bfcb1d97..5caf6e802fc9 100644
--- a/drivers/net/can/usb/kvaser_usb/kvaser_usb_core.c
+++ b/drivers/net/can/usb/kvaser_usb/kvaser_usb_core.c
@@ -712,6 +712,7 @@ static int kvaser_usb_init_one(struct kvaser_usb *dev, int channel)
 	init_usb_anchor(&priv->tx_submitted);
 	init_completion(&priv->start_comp);
 	init_completion(&priv->stop_comp);
+	init_completion(&priv->flush_comp);
 	priv->can.ctrlmode_supported = 0;
 
 	priv->dev = dev;
diff --git a/drivers/net/can/usb/kvaser_usb/kvaser_usb_hydra.c b/drivers/net/can/usb/kvaser_usb/kvaser_usb_hydra.c
index 5d70844ac030..46133993be86 100644
--- a/drivers/net/can/usb/kvaser_usb/kvaser_usb_hydra.c
+++ b/drivers/net/can/usb/kvaser_usb/kvaser_usb_hydra.c
@@ -1910,7 +1910,7 @@ static int kvaser_usb_hydra_flush_queue(struct kvaser_usb_net_priv *priv)
 {
 	int err;
 
-	init_completion(&priv->flush_comp);
+	reinit_completion(&priv->flush_comp);
 
 	err = kvaser_usb_hydra_send_simple_cmd(priv->dev, CMD_FLUSH_QUEUE,
 					       priv->channel);
-- 
2.36.1

