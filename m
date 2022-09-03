Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A82D5AC0A1
	for <lists+linux-can@lfdr.de>; Sat,  3 Sep 2022 20:25:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231550AbiICSZi (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Sat, 3 Sep 2022 14:25:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229493AbiICSZh (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Sat, 3 Sep 2022 14:25:37 -0400
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89B85419A8
        for <linux-can@vger.kernel.org>; Sat,  3 Sep 2022 11:25:36 -0700 (PDT)
Received: by mail-lj1-x22a.google.com with SMTP id z23so5353830ljk.1
        for <linux-can@vger.kernel.org>; Sat, 03 Sep 2022 11:25:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kvaser.com; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=Cg0NIcCvtzslUyLcrf2K7WXUgIMRr/24a//xXWzJSxs=;
        b=iMKhu2a5LNHpKQXrzkBoaIRLKBHiHS84QljgMuJCCXNGOft+tcSiWlhChg3V3X51Od
         6sfo7jfA33IdWeKQViyt86btTZLB7CK5h51vJFeYKJ0zkXuI59qHt0WKII07necXNX8I
         81Hz0WtT8FrkEvPVBp4Um8MVOXA1spFWTV6zFj6gTC67/KZZ9zuxX80AH9Tv0Ef7BBla
         Bo/zLYb0ybnBsJWcNCv7FRJZm00YC3Nd9tzRRia5R4dvk0w5IhY7FBNogEoZ76v8unHv
         eBNsdPVu90wRZpPRfEJFPWSsY9zi3YcknM12yGeL2T/OToM9LoCmEy8CSs8mnAk+dpjA
         AZqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=Cg0NIcCvtzslUyLcrf2K7WXUgIMRr/24a//xXWzJSxs=;
        b=rdJLv0GJaFzgmrcpFXgW/LNpIac0JDr3VAHdYaXxwm7bi5Ap09bYUnU9JlUH/Fcs36
         mmUtkZz4KGeDnWBZ43+ALl9F97DnHjImqaM8wKKB/3wr4ts/M1AQzwonz4BmFsEW/XR4
         Z41Qbi3gTMB/elkjxocFQmWcHBO1wyqi5QKEJKRsw3L8ZV/p+TQIyKWc5g48wF1mF1El
         Q9/JzVoLhtPgr/TeUlCmkVT5Js35mY4yI++pPJFqj1JSq5tCXien5rn84LfSyh0qgThr
         XY/1IX4qe6VYfmENP4GvwyQ/3kBN5/pgi9hG3VmnQxNkNLYm+3I7FNaXPd/ZLfW2tjRp
         /MJQ==
X-Gm-Message-State: ACgBeo3F87dMSbt8oj0MVX7ig0+7eWb4QC3JvUk3ZDZrFbKcAwdeSnKH
        ukAIt5zPzTvN02OJIyruDU2ZOIsJlfvUUTiQ
X-Google-Smtp-Source: AA6agR4Vvs43vnDRyOhJumkAIBncO0fEC4XrYbQH9yMv5sI6voMx4jRxvqfyv3HdIPUB0bYviyJzjg==
X-Received: by 2002:a2e:8443:0:b0:25e:21ef:952d with SMTP id u3-20020a2e8443000000b0025e21ef952dmr13209897ljh.403.1662229534947;
        Sat, 03 Sep 2022 11:25:34 -0700 (PDT)
Received: from f6a14fef6d45.. (h-155-4-68-234.A785.priv.bahnhof.se. [155.4.68.234])
        by smtp.gmail.com with ESMTPSA id u18-20020ac24c32000000b00492f6ddba59sm658330lfq.75.2022.09.03.11.25.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 03 Sep 2022 11:25:34 -0700 (PDT)
From:   Jimmy Assarsson <extja@kvaser.com>
To:     linux-can@vger.kernel.org, Marc Kleine-Budde <mkl@pengutronix.de>,
        Anssi Hannula <anssi.hannula@bitwise.fi>
Cc:     Jimmy Assarsson <jimmyassarsson@gmail.com>, stable@vger.kernel.org,
        Jimmy Assarsson <extja@kvaser.com>
Subject: [PATCH v4 02/15] can: kvaser_usb: Fix use of uninitialized completion
Date:   Sat,  3 Sep 2022 20:25:46 +0200
Message-Id: <20220903182559.189-2-extja@kvaser.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20220903182559.189-1-extja@kvaser.com>
References: <20220903182559.189-1-extja@kvaser.com>
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

Cc: stable@vger.kernel.org
Fixes: aec5fb2268b7 ("can: kvaser_usb: Add support for Kvaser USB hydra family")
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
index dd65c101bfb8..3dcd35979e6f 100644
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
2.37.3

