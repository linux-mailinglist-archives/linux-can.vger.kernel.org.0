Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 167815A96E1
	for <lists+linux-can@lfdr.de>; Thu,  1 Sep 2022 14:30:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233632AbiIAM3r (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Thu, 1 Sep 2022 08:29:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233654AbiIAM3a (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Thu, 1 Sep 2022 08:29:30 -0400
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F191F12DA26
        for <linux-can@vger.kernel.org>; Thu,  1 Sep 2022 05:28:33 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id bt10so24174051lfb.1
        for <linux-can@vger.kernel.org>; Thu, 01 Sep 2022 05:28:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kvaser.com; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=3DIbIh68o/anmm+/aJkEjWEUUfosSo9p7dyutkWjemo=;
        b=J5W+KcYb/nFZpqT+9mqKMzgrJw1CLoowBipMs3gRbfRlVdW5TtHKuTA6CcJDJeBn0V
         cFvmpE+Yk4mpdk6BdEnN5Ou69PEn23Uj5UpLMXN2nSqQVAG+nh0oB09pcwh4kBtG3+Ab
         vS3//oKq7X2gNIZkAPvt4zBennGy/O+3vUIOBVnm3fQwOyRHh+IotdtToIRUZSHWu44r
         6hs398LcDOJw8VkYwXtOqW7qikKT1Ap5wnAfXM2b0aFY6KVzjTTbAF3MjJkD2/2G8Wf5
         qV742DGrPlu01gbj9eHm/4gdRtrBTMzYrCzPrHQQI6CPwyRd/Ljfyaq3/H8R+b+AvFkZ
         5ksg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=3DIbIh68o/anmm+/aJkEjWEUUfosSo9p7dyutkWjemo=;
        b=ZCpTKRBERDaQYACdO25ODxog17Uvaq4ySOHgJTjFktc3H4obsJjonwZHWE3gd/hfdX
         jgbmwvYUEo1/j56hvN22vz5zcPrCV5BLUdAbZfRMaabsrYZSReeUm8t2cPAGB27Hwmlk
         6Eu+CAwn14BrV3pL55iIylPaRm0sSEC4V01hf0X/Nk464XI+fQrMNdI6GpCWnTTwk5BU
         kflwFsz4sV7kn1FDUsDkwalU8Ob5Kv/CkoEOLohsNf4eJ1Ji5/syJrx8dUa+IX1YBq1O
         FRHBGXiF3nZsu9k2XjLOwbXxB+E3uzOhp/7RepwR8Ak7n+6Sp1isXI4XXlECNsCsLJOF
         sx+Q==
X-Gm-Message-State: ACgBeo1kyw8aZGqRdqGz6m8BuI/FXr19Jfxf23cYFRKpUysKTK158aBl
        jUdYJG/dheix4kqdkOS1g5WwkICkg71u8g==
X-Google-Smtp-Source: AA6agR6Rn1CEmv1EzOz+FT2eP+uAXCTG9xGBe9luQSsqOg16Tlkp+akKg5b+sSofruStgdxxeWH2Cg==
X-Received: by 2002:a05:6512:1329:b0:492:e050:b0dc with SMTP id x41-20020a056512132900b00492e050b0dcmr11487756lfu.136.1662035309755;
        Thu, 01 Sep 2022 05:28:29 -0700 (PDT)
Received: from fb10a0c5d590.. (h-155-4-68-234.A785.priv.bahnhof.se. [155.4.68.234])
        by smtp.gmail.com with ESMTPSA id s12-20020a056512202c00b00492c2394ea5sm125935lfs.165.2022.09.01.05.28.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Sep 2022 05:28:29 -0700 (PDT)
From:   Jimmy Assarsson <extja@kvaser.com>
To:     linux-can@vger.kernel.org, Marc Kleine-Budde <mkl@pengutronix.de>,
        Anssi Hannula <anssi.hannula@bitwise.fi>
Cc:     Jimmy Assarsson <jimmyassarsson@gmail.com>, stable@vger.kernel.org,
        Jimmy Assarsson <extja@kvaser.com>
Subject: [PATCH v3 11/15] can: kvaser_usb_leaf: Fix wrong CAN state after stopping
Date:   Thu,  1 Sep 2022 14:27:25 +0200
Message-Id: <20220901122729.271-12-extja@kvaser.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20220901122729.271-1-extja@kvaser.com>
References: <20220901122729.271-1-extja@kvaser.com>
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

