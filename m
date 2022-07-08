Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7948656B91E
	for <lists+linux-can@lfdr.de>; Fri,  8 Jul 2022 14:03:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238231AbiGHL5w (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Fri, 8 Jul 2022 07:57:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238225AbiGHL5v (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Fri, 8 Jul 2022 07:57:51 -0400
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FED99A6B7
        for <linux-can@vger.kernel.org>; Fri,  8 Jul 2022 04:57:49 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id i18so35942184lfu.8
        for <linux-can@vger.kernel.org>; Fri, 08 Jul 2022 04:57:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kvaser.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=W19VqfsLqJK8d02zETZ/vXS9gmNxiPRPSfldgFTJiCA=;
        b=wKCLC20u5wKqj6hIwdvrBqG4zDgBKGoX1XnWahxxUfbuZGmefvuQ2t2oiKYo+6PkLe
         I1YwnIbslLRVbXGQX97Ou0MAYeT+mKFLElhKYaAZGkxpt4dl9wDyK3mHXt+B5/+RnOyj
         +F0QjTbGrAz0QRNNr6dWI8Agp8FhO9Gv+m3bzL+jmCJQhTudH7BBRHwCdBda/2vOsCpY
         p71LB1kjl6hzdl+g8ZPV+VyrIH79PpU9I62z4AY9K0MChrctCoRC9VfDQdujRVC4kY0l
         xw29395VG7kPHi7Np+YgSfX104kI/30b407M28o1nAFgncGzxcZRWYqB6KnXaLoS1urS
         AY+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=W19VqfsLqJK8d02zETZ/vXS9gmNxiPRPSfldgFTJiCA=;
        b=M6qwuBqUIL9TYLepuuQXXYhn+koEm1yUn8sx5e6Wwww62U+6MpRO9wQElWZJW/Y8HU
         q0W4TfR09EDLebcHcPv09e45NC8jAavk+Khoojy46rK0PThP43iSBEaWXva4yW/Om4yB
         V6+398mPhz0sVKkqw5K4srr+UvehMvJbq85rBzZS2O5DEVOHf1Dj28JxLwMQoL5voKvi
         2l1up3avq+mpWKXivrf1KQttZBUl1IAQV6RpnMBhpC+MLiHR6vnpq+D0R+MYf/Dt6xkV
         8Zh03fv7axK9j8YdbfZ5Nfd3XesQbqNiEv/RwLvU5EN0C2xA24mjP33B/98tKvbNqBCt
         3qpA==
X-Gm-Message-State: AJIora/dB3qJtLMTBnLQ4jB6J8Q93rx3sRzEHGqoHVucwiEys93ol3a8
        thDNb1q/oWxsRu9FPeKusA8HbCfMLa5omA==
X-Google-Smtp-Source: AGRyM1tpdLQ+Onmk7NSHhTY+DaAx0qZudBxqD325BYogWx2vBAPxj5e2CGC0apMqDDCnpJN/44A0dA==
X-Received: by 2002:ac2:530b:0:b0:486:6982:5ab5 with SMTP id c11-20020ac2530b000000b0048669825ab5mr2264319lfh.138.1657281468579;
        Fri, 08 Jul 2022 04:57:48 -0700 (PDT)
Received: from freke.kvaser.se (rota.kvaser.com. [195.22.86.90])
        by smtp.gmail.com with ESMTPSA id h7-20020a2e9ec7000000b0025a724f2935sm7336199ljk.137.2022.07.08.04.57.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Jul 2022 04:57:48 -0700 (PDT)
From:   Jimmy Assarsson <extja@kvaser.com>
To:     linux-can@vger.kernel.org, Anssi Hannula <anssi.hannula@bitwise.fi>
Cc:     Jimmy Assarsson <jimmyassarsson@gmail.com>,
        Jimmy Assarsson <extja@kvaser.com>
Subject: [PATCH v2 11/15] can: kvaser_usb_leaf: Fix wrong CAN state after stopping
Date:   Fri,  8 Jul 2022 13:57:05 +0200
Message-Id: <20220708115709.232815-12-extja@kvaser.com>
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

0bfd:0124 Kvaser Mini PCI Express 2xHS FW 4.18.778 sends a
CMD_CHIP_STATE_EVENT indicating bus-off after stopping the device,
causing a stopped device to appear as CAN_STATE_BUS_OFF instead of
CAN_STATE_STOPPED.

Fix that by not handling error events on stopped devices.

Fixes: 080f40a6fa28 ("can: kvaser_usb: Add support for Kvaser CAN/USB devices")
Tested-by: Jimmy Assarsson <extja@kvaser.com>
Signed-off-by: Anssi Hannula <anssi.hannula@bitwise.fi>
---
Changes in v2:
  - Rebased on b3b6df2c56d8 ("can: kvaser_usb: kvaser_usb_leaf: fix bittiming limits")

 drivers/net/can/usb/kvaser_usb/kvaser_usb_leaf.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/net/can/usb/kvaser_usb/kvaser_usb_leaf.c b/drivers/net/can/usb/kvaser_usb/kvaser_usb_leaf.c
index 03f6b84c50ad..2e242340c4bc 100644
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
2.36.1

