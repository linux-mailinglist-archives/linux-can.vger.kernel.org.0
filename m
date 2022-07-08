Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1957256B921
	for <lists+linux-can@lfdr.de>; Fri,  8 Jul 2022 14:03:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238232AbiGHL5u (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Fri, 8 Jul 2022 07:57:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238231AbiGHL5u (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Fri, 8 Jul 2022 07:57:50 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CB5A9B181
        for <linux-can@vger.kernel.org>; Fri,  8 Jul 2022 04:57:47 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id d12so12636681lfq.12
        for <linux-can@vger.kernel.org>; Fri, 08 Jul 2022 04:57:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kvaser.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Z5wiG97vXVLxCPun/8B9QEf5cQAR5YOdm8jF0WrN9HA=;
        b=EYHfZSDqqDxEPSPRUfhL4N8d0+z4THAdC3oUg3/wxHG/NacH99MHwhZSOwMeWR2LTN
         +AJDQlPHIL3rRGFhJ3slUWpT1cZp6xTkF1hN9vDxmQbliTlvU6OAZf1Kf/z7kv6P90vE
         +uaJ2O9taybN4MTZ6AQonW1L6obI5MxK/yJc9mfEDccbuZskVAnKKn7SSNhwxeSMoEK/
         z1uGCuet4iHZ4sVuIYytvLeX1eSETSE6Shbqolc5AhHb6ZplAHkE6Zqw0tJgtvVtpLup
         DUDWFFvssMiUZHkoZJyE+TqGduizIRDa4WYxdyr28mVTl/pINazBDJ7Ky5vxsM1l7RhL
         BJWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Z5wiG97vXVLxCPun/8B9QEf5cQAR5YOdm8jF0WrN9HA=;
        b=hqHxBFQTq0Fwk7oH46OpOZCjjKbbpIhtB6GZbiCbeFqf+4A3nGqfIjVza1JDzM+yfm
         n59pBGaQIC/WaB9LKFpXNoW8j4SwXKQhzoGxAOh8LYLNHdXM7gaBdzF396HLqj44CgWZ
         is5ZrXYWmX0XkBFeOmsjRWCV2Ry61qpJ92TfFAMUfpGv/CCN3VQ+gFKEv4vuQslqqlP8
         QkN8DXwtVJrRpdTNN3TpZPC9zTRtHv3iLRZr61MX1dkBEP5m9a0ZBvu6Nu5fOrqu5PkM
         C516DmBQ3PfPvKX3iWtKS32YnoQzlkLGR23KHYPfskys5kiCcBnFZ6wVjWljBe7Ss6lP
         2o0g==
X-Gm-Message-State: AJIora9qfOn0S0nY5RySSc+P0bEZ00oX81k5fSIqb4wpzXf0bZISACLg
        WXRthFyRIELhvkNHu6Zq8n2HOF7uJ5iLZA==
X-Google-Smtp-Source: AGRyM1u0LM7nx3Yh6sFIim42+nd6hkqt+FnzXpVmSR4Op8EQb6XfYEzaxo1waHVw2APEN+5a6mFBSA==
X-Received: by 2002:a19:ad02:0:b0:483:2adc:a23a with SMTP id t2-20020a19ad02000000b004832adca23amr2165737lfc.534.1657281465794;
        Fri, 08 Jul 2022 04:57:45 -0700 (PDT)
Received: from freke.kvaser.se (rota.kvaser.com. [195.22.86.90])
        by smtp.gmail.com with ESMTPSA id h7-20020a2e9ec7000000b0025a724f2935sm7336199ljk.137.2022.07.08.04.57.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Jul 2022 04:57:45 -0700 (PDT)
From:   Jimmy Assarsson <extja@kvaser.com>
To:     linux-can@vger.kernel.org, Anssi Hannula <anssi.hannula@bitwise.fi>
Cc:     Jimmy Assarsson <jimmyassarsson@gmail.com>,
        Jimmy Assarsson <extja@kvaser.com>
Subject: [PATCH v2 09/15] can: kvaser_usb_leaf: Fix CAN state after restart
Date:   Fri,  8 Jul 2022 13:57:03 +0200
Message-Id: <20220708115709.232815-10-extja@kvaser.com>
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

can_restart() expects CMD_START_CHIP to set the error state to
ERROR_ACTIVE as it calls netif_carrier_on() immediately afterwards.

Otherwise the user may immediately trigger restart again and hit a
BUG_ON() in can_restart().

Fix kvaser_usb_leaf set_mode(CMD_START_CHIP) to set the expected state.

Fixes: 080f40a6fa28 ("can: kvaser_usb: Add support for Kvaser CAN/USB devices")
Tested-by: Jimmy Assarsson <extja@kvaser.com>
Signed-off-by: Anssi Hannula <anssi.hannula@bitwise.fi>
---
Changes in v2:
  - Rebased on b3b6df2c56d8 ("can: kvaser_usb: kvaser_usb_leaf: fix bittiming limits")

 drivers/net/can/usb/kvaser_usb/kvaser_usb_leaf.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/can/usb/kvaser_usb/kvaser_usb_leaf.c b/drivers/net/can/usb/kvaser_usb/kvaser_usb_leaf.c
index 1bc0350d623b..22deb74c7d42 100644
--- a/drivers/net/can/usb/kvaser_usb/kvaser_usb_leaf.c
+++ b/drivers/net/can/usb/kvaser_usb/kvaser_usb_leaf.c
@@ -1665,6 +1665,8 @@ static int kvaser_usb_leaf_set_mode(struct net_device *netdev,
 		err = kvaser_usb_leaf_simple_cmd_async(priv, CMD_START_CHIP);
 		if (err)
 			return err;
+
+		priv->can.state = CAN_STATE_ERROR_ACTIVE;
 		break;
 	default:
 		return -EOPNOTSUPP;
-- 
2.36.1

