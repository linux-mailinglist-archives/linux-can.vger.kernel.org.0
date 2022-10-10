Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 195CC5FA3B4
	for <lists+linux-can@lfdr.de>; Mon, 10 Oct 2022 20:53:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229805AbiJJSxR (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Mon, 10 Oct 2022 14:53:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229793AbiJJSxP (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Mon, 10 Oct 2022 14:53:15 -0400
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B69D3786EA
        for <linux-can@vger.kernel.org>; Mon, 10 Oct 2022 11:53:14 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id f37so17840186lfv.8
        for <linux-can@vger.kernel.org>; Mon, 10 Oct 2022 11:53:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kvaser.com; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MxvvEJC5OH3hAsizaS1LYCco2re2iNEqQPJIVyXMxyY=;
        b=kPv1E4KXstfYI/XLjOHSDiKLqPeWOrBSHk3bg7JNfqbSxGDS/gcQepwBAUEFTdudwL
         znEwL63SnubqXgyjEzQXFDy5xYkuj9pel9r6UUZxHVCABjGWjk2HfLtIBSO0oFjhZu/I
         y/XNHJWFLdKQBfrH7STkX1HBbRWxXjvFAfSYTglD3F/qYLdiHQVbdmSY5zjdbTF8sMiR
         bEwJloZaSb1YljZ89jqLPsHIx83JqQWC2kZNPgddAwjDmHk8TyRmNTBvj6gfDkcJEQP2
         dc1PP8XvdFNFNMVu7f9FCkYn51kkbmyYTWh9b1ptHn871MhR0kfrzSdQ9gK9VxmwHFTW
         oxUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MxvvEJC5OH3hAsizaS1LYCco2re2iNEqQPJIVyXMxyY=;
        b=42LqLJ54Wu5CfGWhI7B9BMcC5ZZXZCWAc4BygVEawmODxiXDcTxX2rHlUFARq3hGgJ
         Mx3zZXAtHZNd9YgKlOge36ausXpMIttmvZfLjhHR8Gy1FUhbZyocjaFdvVm78ungL+vb
         oPcXPIb1v4vYkrexLBsxVmhoXFCLA5z01POjJ2skvda/2WwEVEbhcvpZDKfmNoM+w8Xf
         C98CH1A/mxbu5sFnyTF0YksbsbkaDdne5PxdRDAKh1bJNlzQ/pvImo1o7wyeln+PRF9R
         OfL94PjouRj/aJc6/PbZo4cmymJbo/C+0fladm5d6w7giAMNKdim/VEwaVXkPR9ifunz
         ZZIA==
X-Gm-Message-State: ACrzQf31xsBG0OLtyJAS2p06TWd4mWSxZ5RlvQ2OQVHn/RaVodwr9p19
        bbRroNTjXy9zqvprPg8yNm0/tUPCpNdbBw==
X-Google-Smtp-Source: AMsMyM4nn1LPufdJDIMleulxGZ6vPrLWn0OOPwjjpUq6pInS+of4oABADifYRxBFwIpg3Oj0Z3CCgg==
X-Received: by 2002:a05:6512:2350:b0:4a2:4523:cd08 with SMTP id p16-20020a056512235000b004a24523cd08mr7967822lfu.231.1665427993045;
        Mon, 10 Oct 2022 11:53:13 -0700 (PDT)
Received: from archyz.. (h-155-4-68-234.A785.priv.bahnhof.se. [155.4.68.234])
        by smtp.gmail.com with ESMTPSA id b4-20020a056512070400b004a2386b8ce6sm1517769lfs.207.2022.10.10.11.53.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Oct 2022 11:53:11 -0700 (PDT)
From:   Jimmy Assarsson <extja@kvaser.com>
To:     linux-can@vger.kernel.org, Marc Kleine-Budde <mkl@pengutronix.de>,
        Anssi Hannula <anssi.hannula@bitwise.fi>
Cc:     Jimmy Assarsson <jimmyassarsson@gmail.com>,
        Jimmy Assarsson <extja@kvaser.com>
Subject: [PATCH can-next v5 07/11] can: kvaser_usb_leaf: Fix wrong CAN state after stopping
Date:   Mon, 10 Oct 2022 20:52:33 +0200
Message-Id: <20221010185237.319219-8-extja@kvaser.com>
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

0bfd:0124 Kvaser Mini PCI Express 2xHS FW 4.18.778 sends a
CMD_CHIP_STATE_EVENT indicating bus-off after stopping the device,
causing a stopped device to appear as CAN_STATE_BUS_OFF instead of
CAN_STATE_STOPPED.

Fix that by not handling error events on stopped devices.

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
2.38.0

