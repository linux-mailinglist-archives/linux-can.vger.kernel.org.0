Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A0E45AC0AF
	for <lists+linux-can@lfdr.de>; Sat,  3 Sep 2022 20:25:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230333AbiICSZw (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Sat, 3 Sep 2022 14:25:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233287AbiICSZs (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Sat, 3 Sep 2022 14:25:48 -0400
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B71D1089
        for <linux-can@vger.kernel.org>; Sat,  3 Sep 2022 11:25:47 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id v26so7649571lfd.10
        for <linux-can@vger.kernel.org>; Sat, 03 Sep 2022 11:25:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kvaser.com; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=Opm1Gh+i0ZnGHSUzxPyi7bNCWNJS2k2uV+gp190oxyI=;
        b=N5+wwiF8m8/w7vzG/XjizdDP2VdolkeE05HEKTBRancL4+Zl4XK72HZmb73dZg1ye/
         gJEOu6uXqWw4h2J+L1p483tYGoUeY2QhRaaj/ofrwZJdwCVoPM2YgXYy2sKoPkvA41mv
         /cR3jV0Mp9VUe0TEKl6/RLtNRAQAGNdIhA++g30Om4MrTAQ3HlBxu2jtikoJ1lo1j8jb
         tzUM3hi/VRDgdIkECbwgGjfqedHgnK7K70F1MT+0Li7XxLufzbk32TD6NkeGhCTDYXP7
         N48BZ7G6jgsLNr0Q+UzTebUVXQ+Ykuszp3fDMFxh3YVKyx9yR0NOHOwLBHcAO87zfcZd
         2lpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=Opm1Gh+i0ZnGHSUzxPyi7bNCWNJS2k2uV+gp190oxyI=;
        b=TKqABW/USK3vm+HxLPAY60f2Ar6PBFE2x2n5M5xxSQLcw3Rt1zHCE7eut8iEQ/Sxs9
         flQzFivMABhalot7XRvH1LCHTYHDOhJzFAu8S2jFdDQesqyMPghtW54ecQDlu1D8wE/T
         g4D0SKgiQI/O53lCe7EuFkdz3SzO1Xoo9rMFFwd5xvIHIakrT2nfntrsP1JXLHq5lajC
         16qKsBGOW7tm3c5HD/jLceqHmsmrUQf0h2yvbxlJ25ZLsDmzv3mXTpyc8K8EuIys/DMg
         lpkFrPOjdB9/lNjK8NfekqOBBY8qvd1LliOg9wm2YheUDZ/8zCtYzyBUBbCSJmsXgYuZ
         D+hQ==
X-Gm-Message-State: ACgBeo39n1EEATOZ9/4OEY1pDODzmwyceEKee3NwZom7gNxbzdmFYjVJ
        SiWUj/WbAYAbWeOWsG3yLiochPR/R9QJeEnI
X-Google-Smtp-Source: AA6agR7H6uviaRHICwHvLrx5a6R/CGg0GEh5AZ7V+nik2ahvwLu3pjqm6mlO86u/6PAg+JQuxJQ+zQ==
X-Received: by 2002:a05:6512:39c6:b0:48b:9d1d:fd9c with SMTP id k6-20020a05651239c600b0048b9d1dfd9cmr15401170lfu.633.1662229545691;
        Sat, 03 Sep 2022 11:25:45 -0700 (PDT)
Received: from f6a14fef6d45.. (h-155-4-68-234.A785.priv.bahnhof.se. [155.4.68.234])
        by smtp.gmail.com with ESMTPSA id u18-20020ac24c32000000b00492f6ddba59sm658330lfq.75.2022.09.03.11.25.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 03 Sep 2022 11:25:45 -0700 (PDT)
From:   Jimmy Assarsson <extja@kvaser.com>
To:     linux-can@vger.kernel.org, Marc Kleine-Budde <mkl@pengutronix.de>,
        Anssi Hannula <anssi.hannula@bitwise.fi>
Cc:     Jimmy Assarsson <jimmyassarsson@gmail.com>, stable@vger.kernel.org,
        Jimmy Assarsson <extja@kvaser.com>
Subject: [PATCH v4 09/15] can: kvaser_usb_leaf: Fix CAN state after restart
Date:   Sat,  3 Sep 2022 20:25:53 +0200
Message-Id: <20220903182559.189-9-extja@kvaser.com>
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

can_restart() expects CMD_START_CHIP to set the error state to
ERROR_ACTIVE as it calls netif_carrier_on() immediately afterwards.

Otherwise the user may immediately trigger restart again and hit a
BUG_ON() in can_restart().

Fix kvaser_usb_leaf set_mode(CMD_START_CHIP) to set the expected state.

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

 drivers/net/can/usb/kvaser_usb/kvaser_usb_leaf.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/can/usb/kvaser_usb/kvaser_usb_leaf.c b/drivers/net/can/usb/kvaser_usb/kvaser_usb_leaf.c
index 48b8a0f0b362..a6a26085bc15 100644
--- a/drivers/net/can/usb/kvaser_usb/kvaser_usb_leaf.c
+++ b/drivers/net/can/usb/kvaser_usb/kvaser_usb_leaf.c
@@ -1668,6 +1668,8 @@ static int kvaser_usb_leaf_set_mode(struct net_device *netdev,
 		err = kvaser_usb_leaf_simple_cmd_async(priv, CMD_START_CHIP);
 		if (err)
 			return err;
+
+		priv->can.state = CAN_STATE_ERROR_ACTIVE;
 		break;
 	default:
 		return -EOPNOTSUPP;
-- 
2.37.3

