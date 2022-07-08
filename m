Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D946056C254
	for <lists+linux-can@lfdr.de>; Sat,  9 Jul 2022 01:12:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239700AbiGHSsh (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Fri, 8 Jul 2022 14:48:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239741AbiGHSsg (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Fri, 8 Jul 2022 14:48:36 -0400
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BBD6B4A0
        for <linux-can@vger.kernel.org>; Fri,  8 Jul 2022 11:48:35 -0700 (PDT)
Received: by mail-lf1-x131.google.com with SMTP id a9so275427lfk.11
        for <linux-can@vger.kernel.org>; Fri, 08 Jul 2022 11:48:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kvaser.com; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=NCdrXXw4OIFVN2T2yq7UtG+zJ8BpWvZk3Tva/wkAXMM=;
        b=oyUmWb2U+W6Kf5eSkdf/PaCKsZgMwjbxesppqFvRVos7kKB7Y/WTRNyWy75p1xRNgY
         Tay6T3ESpCN1nga64OewMLU7n84BgDJqkRt3Xr3dXGCZQTenChCXXhhXdn0eGTx905LS
         0ZplMCSAkUYi+MPGzycaybjqYQDd0nRRzPtsrdbPAMC0fx8RwZwxNW8j6gRBgFRrQ2IB
         Swz+iz3QfSCM1SzdvEHilEMvKHfD1xLkHWyeO+9NrhKYXrjCfmViJz0cwn7y05ootKYo
         xVQk6mHk07/4FuEAtX18QTIsqh2TZQZqa+8A7VealE1jtgvvoVU2opBEytdYhbAmKBPy
         Qoxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=NCdrXXw4OIFVN2T2yq7UtG+zJ8BpWvZk3Tva/wkAXMM=;
        b=yAdQZrg60b4NycM+XYtdRkQTeGVeORXlbtssyC3yKYfQ7zTGx3TFF5yj8Km75M8YdP
         u7lOnhPEsrW0ElcCcnNzk5aOMiEf4DdqSbMiDhMZx5EPvPosWId3S9E0lvsM728K4Rlp
         lsDmQcdf+L15Po/ixGwCZSgKF7kVhP2zrAar4sd3IGIxOLVwuiGFkWacygx1ktagqGAz
         NkP9GVRNDETnd4GGKO5igr8QKDOQNsEe0dYriHOrKptmwmFSVUI49kFzttXSbLqgAnIf
         AgvlFFMz5xD4YmgSoBzLHMzWScYmH4CquzIZZbI5ZEsSfeD7sPfcGwaSEp2QIFuqiPZX
         u4PQ==
X-Gm-Message-State: AJIora8MBtXhNhn1ENZ6zdBtLoV05Ubt8l7TgYz7kgKtULJGMTXr/LXw
        ddpTUgP7567PHpZdWLdRUlYzLw==
X-Google-Smtp-Source: AGRyM1uMGSaoEW+MkCg7sQJFyiQeIdk+F/UYka5fX6N/3oLgpcO62efkAFTuULkbizz/sDTeEa8fXA==
X-Received: by 2002:a05:6512:11d2:b0:47f:7ca3:c533 with SMTP id h18-20020a05651211d200b0047f7ca3c533mr3186169lfr.388.1657306114587;
        Fri, 08 Jul 2022 11:48:34 -0700 (PDT)
Received: from freke.kvaser.se (rota.kvaser.com. [195.22.86.90])
        by smtp.gmail.com with ESMTPSA id u19-20020ac258d3000000b0048639c05ffdsm1618605lfo.107.2022.07.08.11.48.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Jul 2022 11:48:34 -0700 (PDT)
From:   Jimmy Assarsson <extja@kvaser.com>
To:     stable@vger.kernel.org, linux-can@vger.kernel.org,
        Marc Kleine-Budde <mkl@pengutronix.de>
Cc:     Jimmy Assarsson <jimmyassarsson@gmail.com>,
        Jimmy Assarsson <extja@kvaser.com>
Subject: [PATCH 5.10 0/3] can: kvaser_usb: CAN clock frequency regression
Date:   Fri,  8 Jul 2022 20:48:16 +0200
Message-Id: <20220708184819.281103-1-extja@kvaser.com>
X-Mailer: git-send-email 2.36.1
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

