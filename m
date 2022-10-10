Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC8B25FA0EC
	for <lists+linux-can@lfdr.de>; Mon, 10 Oct 2022 17:09:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229969AbiJJPJT (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Mon, 10 Oct 2022 11:09:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229971AbiJJPJR (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Mon, 10 Oct 2022 11:09:17 -0400
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 513076B64B
        for <linux-can@vger.kernel.org>; Mon, 10 Oct 2022 08:09:16 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id s20so17000190lfi.11
        for <linux-can@vger.kernel.org>; Mon, 10 Oct 2022 08:09:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kvaser.com; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YOUPzlpuR8ElHymCzhvlZOpr1K/a0a5K9CA1bW8RjXM=;
        b=ffnUko8BzlXPkp/Df73uyj3Zt8+b1AofrZJzaVibUmlwwPzJPW8yC4LoLH6cSdW4Yg
         T3+Nbj0+6P8onYow2EWJbi4ZySrog2Sd5tWp4CXkyQRtIRnubXx4jmZSacF9bfUA2wGc
         xLt3EypvU2jFn1b30q9V/e4Eph65CqXe2Gl/yEBcj3Y59xcsU3PC2xvLwIyvsmeA3EES
         +E0b+JfVoXhj/LsmfkEUwvp4noMiROHKSmXXRAvX8hVxPKrciC3Cqh89/WpD6XWZGMlF
         MfayBTqSGxTXGNZotsbgnIJonzNbqrZjeFeGaeIGbTh4M7QJsRsDfqkqmxwKDhNm0Uk+
         GzQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YOUPzlpuR8ElHymCzhvlZOpr1K/a0a5K9CA1bW8RjXM=;
        b=TgE4lMkecjaUgwYGVMnf1ezrGSVk5VzmurzSJRpF7ujzDWKsmYa34akvzedd/enMHq
         6eVl1vBtaUKM2vvcoyNmq2cUMhawMmPbetrVG+L+E7FRVBA5KvrYbkq63HaHZyLv/J4i
         NJI4YlIdNT00Gz6+YcjXD+lA+r/6dDLPzu8e8lvvyEenFwMR0b0TReB4PLtt+5iZRaBg
         psQSOXeskpwNOu9sBa17i278ex0ZN9udH63TaF6DTQDrmIdhwAXQ/ACafRmP4J2/YACi
         x2xWx47rDxSjuJ9+81H/AZBDmplqcJvcc3wxze8lXmjXYWvc7PK8pz7gs23VeXclhPYe
         O9bQ==
X-Gm-Message-State: ACrzQf2FDO1XUGWvz9CLWiCJq65zAfQmqoLUXm1fJs0WuY+ZpCwghtnp
        kNx1k4D1OmpKA86Cfu5Tn2JJwL+ILqI3+A==
X-Google-Smtp-Source: AMsMyM5/tdfR1Q9AHKJ+/N8mU8kbePRzA4iYvR4LLXFAVOv8ZARV1M57owkfUDogsGQa4Xf8eOEvJQ==
X-Received: by 2002:a05:6512:4011:b0:4a2:5148:9e48 with SMTP id br17-20020a056512401100b004a251489e48mr6505233lfb.337.1665414554700;
        Mon, 10 Oct 2022 08:09:14 -0700 (PDT)
Received: from archyz.. (h-155-4-68-234.A785.priv.bahnhof.se. [155.4.68.234])
        by smtp.gmail.com with ESMTPSA id q7-20020ac24a67000000b0049ebc44994fsm1450280lfp.128.2022.10.10.08.09.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Oct 2022 08:09:09 -0700 (PDT)
From:   Jimmy Assarsson <extja@kvaser.com>
To:     linux-can@vger.kernel.org, Marc Kleine-Budde <mkl@pengutronix.de>,
        Anssi Hannula <anssi.hannula@bitwise.fi>
Cc:     Jimmy Assarsson <jimmyassarsson@gmail.com>, stable@vger.kernel.org,
        Jimmy Assarsson <extja@kvaser.com>
Subject: [PATCH v5 4/4] can: kvaser_usb_leaf: Fix CAN state after restart
Date:   Mon, 10 Oct 2022 17:08:29 +0200
Message-Id: <20221010150829.199676-5-extja@kvaser.com>
X-Mailer: git-send-email 2.38.0
In-Reply-To: <20221010150829.199676-1-extja@kvaser.com>
References: <20221010150829.199676-1-extja@kvaser.com>
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

 drivers/net/can/usb/kvaser_usb/kvaser_usb_leaf.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/can/usb/kvaser_usb/kvaser_usb_leaf.c b/drivers/net/can/usb/kvaser_usb/kvaser_usb_leaf.c
index 59c220ef3049..50f2ac8319ff 100644
--- a/drivers/net/can/usb/kvaser_usb/kvaser_usb_leaf.c
+++ b/drivers/net/can/usb/kvaser_usb/kvaser_usb_leaf.c
@@ -1431,6 +1431,8 @@ static int kvaser_usb_leaf_set_mode(struct net_device *netdev,
 		err = kvaser_usb_leaf_simple_cmd_async(priv, CMD_START_CHIP);
 		if (err)
 			return err;
+
+		priv->can.state = CAN_STATE_ERROR_ACTIVE;
 		break;
 	default:
 		return -EOPNOTSUPP;
-- 
2.38.0

