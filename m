Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B19E456C283
	for <lists+linux-can@lfdr.de>; Sat,  9 Jul 2022 01:13:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239707AbiGHSsL (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Fri, 8 Jul 2022 14:48:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239690AbiGHSsK (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Fri, 8 Jul 2022 14:48:10 -0400
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DE418239B
        for <linux-can@vger.kernel.org>; Fri,  8 Jul 2022 11:48:08 -0700 (PDT)
Received: by mail-lf1-x131.google.com with SMTP id a9so273654lfk.11
        for <linux-can@vger.kernel.org>; Fri, 08 Jul 2022 11:48:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kvaser.com; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=NCdrXXw4OIFVN2T2yq7UtG+zJ8BpWvZk3Tva/wkAXMM=;
        b=qFVgsCQ8StmDpewQRqAGeso0KsBcrAd2oUYl0VAwsceQyNuY6g48E82itlL4LKKCQX
         8Cw70h+1smITqLIi2aTFCKcAFuFHHK7nZ5gSMs7zWsE4Q9llG2G7BNGdcX0bNIecIaxd
         BC2fwkNlR4hXm73hQ5BaXn7fTw9IxpRR7h6PRskmuOJ/6FDww29gwgYd9Dld8U6hr/9D
         IyscKqhqzaGrOSIpMg80Y/Sq/2dDS86JdevLD/B7FvOsysgOZQj0yPm+6fuC0FP2+A9C
         p5Y8qfLjf4weRD4bnJhcHChetjKBL/fUhP+dkWC807B22rjlAENC6R657veHEwEcCKKn
         bodA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=NCdrXXw4OIFVN2T2yq7UtG+zJ8BpWvZk3Tva/wkAXMM=;
        b=PD4mPOThOMK+wcBhUWxjh2SP0Z6i1j2DNV+kGMW54jkO3A3nr4yDGexkOwet6/Q+n5
         JJ9kVgPxES9uTE87Cl1lEVTxTQFd0FvDEeszJp+S3VBcqW0q7KRctW/4bTC5DV3sJIYJ
         LzpqM8XMAubbjCe9Q17emyT5tjL5El6Hf7n/QG2c9miy+DwE75tWlb/S9yysj9ysd3v6
         iuw4TECGxstntF4dsJkLlrhzdkylBmeg1aaJCAYKmkYHv7d9l6zYa6irJlpuFEitn2MA
         d8Niquw66STJtF4MuWoEKzbPUJXU1LlUy+HAkFzNbzZLRTvORSYmyFBakHW12ltVDBqr
         WXQw==
X-Gm-Message-State: AJIora/uAnTRUXIbJ6GJt7ZjK5J51QvTt1AiaFpzvL2f+yssdX+ZmDxE
        nCb4pgyxVXxZ4/zCZlTjrPsnbA==
X-Google-Smtp-Source: AGRyM1vMhy1w8wGACLMLFU9u9wNTZs2gvSdMc72y346N8OXCn9K4TXlW2jwzew7tqtamqC64nFNSYA==
X-Received: by 2002:a05:6512:2387:b0:488:c3ca:16c4 with SMTP id c7-20020a056512238700b00488c3ca16c4mr3354688lfv.3.1657306086969;
        Fri, 08 Jul 2022 11:48:06 -0700 (PDT)
Received: from freke.kvaser.se (rota.kvaser.com. [195.22.86.90])
        by smtp.gmail.com with ESMTPSA id g6-20020a056512118600b0047f7b641951sm7548717lfr.272.2022.07.08.11.48.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Jul 2022 11:48:06 -0700 (PDT)
From:   Jimmy Assarsson <extja@kvaser.com>
To:     stable@vger.kernel.org, linux-can@vger.kernel.org,
        Marc Kleine-Budde <mkl@pengutronix.de>
Cc:     Jimmy Assarsson <jimmyassarsson@gmail.com>,
        Jimmy Assarsson <extja@kvaser.com>
Subject: [PATCH 5.4 0/3] can: kvaser_usb: CAN clock frequency regression
Date:   Fri,  8 Jul 2022 20:47:50 +0200
Message-Id: <20220708184753.281032-1-extja@kvaser.com>
X-Mailer: git-send-email 2.36.1
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

Backport of upstream patch series [1].

When fixing the CAN clock frequency,
fb12797ab1fe ("can: kvaser_usb: get CAN clock frequency from device"),
I introduced a regression.

For Leaf devices based on M32C, the firmware expects bittiming parameters
calculated for 16MHz clock. Regardless of the actual clock frequency.

This regression affects M32C based Leaf devices with non-16MHz clock.

Also correct the bittiming constants in kvaser_usb_leaf.c, where the
limits are different depending on which firmware/device being used.

[1]
https://lore.kernel.org/linux-can/20220603083820.800246-1-extja@kvaser.com/

Jimmy Assarsson (3):
  can: kvaser_usb: replace run-time checks with struct
    kvaser_usb_driver_info
  can: kvaser_usb: kvaser_usb_leaf: fix CAN clock frequency regression
  can: kvaser_usb: kvaser_usb_leaf: fix bittiming limits

 drivers/net/can/usb/kvaser_usb/kvaser_usb.h   |  25 +-
 .../net/can/usb/kvaser_usb/kvaser_usb_core.c  | 255 ++++++++++--------
 .../net/can/usb/kvaser_usb/kvaser_usb_hydra.c |   4 +-
 .../net/can/usb/kvaser_usb/kvaser_usb_leaf.c  | 119 ++++----
 4 files changed, 226 insertions(+), 177 deletions(-)

-- 
2.36.1

