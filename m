Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0CBF270D959
	for <lists+linux-can@lfdr.de>; Tue, 23 May 2023 11:45:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232887AbjEWJpF (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Tue, 23 May 2023 05:45:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235175AbjEWJpE (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 23 May 2023 05:45:04 -0400
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62BE0126
        for <linux-can@vger.kernel.org>; Tue, 23 May 2023 02:45:02 -0700 (PDT)
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-4f3b5881734so4079800e87.0
        for <linux-can@vger.kernel.org>; Tue, 23 May 2023 02:45:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kvaser.com; s=google; t=1684835041; x=1687427041;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=QjpW9ahG+/8q9jsJ1vhDrawaCPOvaqpaxRQ3/3mMpV4=;
        b=YBS0piTMtS14hDz/0Xgmd6oRsPmwxRJYdwNbnsRB3Xc8oabQGSyg6YM+pfuBOXox32
         ZvgyHWhQHliHTeKEj3MO9LAop6ZdU6QeSyuvsW8+W3oZs2lTtzObR2zxQgQGn/Odh2Kx
         +bJQLPpEdhHXPeVX9ehp+6V2N0YmICNVgFCasO/0NgodXUeCM9Gvu8nw7RVzJRJazHgy
         AF0AYbiKtcOcJ6q9/8mpbL3t2io+VKQ+psjWbxtA8HRmTBctyqL5v/eiAwLHtKkiNvSK
         UQEBrBeptGgebCgbAfKSxyEVlpsaqbKNSrCM1f0gWul5A+Lz8cZldkulvobjHMGn9mIN
         Horg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684835041; x=1687427041;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QjpW9ahG+/8q9jsJ1vhDrawaCPOvaqpaxRQ3/3mMpV4=;
        b=efM6dxR6mZo0S0C60X9o7Az43ACM2AEy4FMo3Kogorp/aiuMXGW3lnVkervdZ8ByBH
         42syZW3EV4pRL5wBZsVmvq8/A8+sP6TUr22FtTAB7TG2+yHYTC9rC088/pCy/D+EQ7VM
         O5DJ3neI7WdzbI4Qwh7pzW64Ay8mXmX23GQMCg9OqCyMWH7XEGy7iBvI/lkviYWNY8nU
         PvqB+u3QN6tYAv47t4nMiJ1br6UiRsY4s9He1DjNfdg5dXFNZIrYDBs0CFThZ1pQTa5K
         xrBnBBFWV0sVk8b0lbjwbeZYOl1Lrv46t1fEX9bhoPsTphqwhD/4SmGpBZcH8lTuVukt
         +6uQ==
X-Gm-Message-State: AC+VfDxpCSf5WdirCjFIHJttuYiuMdC9zEWus8oYRVN5KHoPBgjetJqx
        28vwDLjeupLFt8EXNUUH2jqBKbtNp99BwPvYZgc=
X-Google-Smtp-Source: ACHHUZ7XwBbdqBF8eNnxRxO17LVbyfZSUjSEXfhhdPQ3Lx92+3Qbw7Vb+Ytdv6oXlX7RBDQ4EUWH+w==
X-Received: by 2002:ac2:489c:0:b0:4f2:4d0a:7bde with SMTP id x28-20020ac2489c000000b004f24d0a7bdemr4002920lfc.31.1684835040714;
        Tue, 23 May 2023 02:44:00 -0700 (PDT)
Received: from archyz.. (h-98-128-173-232.A785.priv.bahnhof.se. [98.128.173.232])
        by smtp.gmail.com with ESMTPSA id c16-20020a2e9490000000b002ac87c15fd4sm1535551ljh.95.2023.05.23.02.43.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 May 2023 02:44:00 -0700 (PDT)
From:   Jimmy Assarsson <extja@kvaser.com>
To:     linux-can@vger.kernel.org
Cc:     Jimmy Assarsson <jimmyassarsson@gmail.com>,
        Jimmy Assarsson <extja@kvaser.com>
Subject: [PATCH 00/12] can: kvaser_pciefd: Fixes and improvments
Date:   Tue, 23 May 2023 11:43:38 +0200
Message-Id: <20230523094354.83792-1-extja@kvaser.com>
X-Mailer: git-send-email 2.40.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

This patch series contains various non critical fixes and improvments for
the kvaser_pciefd driver.

Jimmy Assarsson (12):
  can: kvaser_pciefd: Remove useless write to interrupt register
  can: kvaser_pciefd: Remove handler for unused
    KVASER_PCIEFD_PACK_TYPE_EFRAME_ACK
  can: kvaser_pciefd: Add function to set skb hwtstamps
  can: kvaser_pciefd: Set hardware timestamp on transmitted packets
  can: kvaser_pciefd: Define unsigned constants with type suffix 'U'
  can: kvaser_pciefd: Remove SPI flash parameter read functionality
  can: kvaser_pciefd: Sort includes in alphabetic order
  can: kvaser_pciefd: Rename device ID defines
  can: kvaser_pciefd: Change return type for
    kvaser_pciefd_{receive,transmit,set_tx}_irq()
  can: kvaser_pciefd: Add len8_dlc support
  can: kvaser_pciefd: Refactor code
  can: kvaser_pciefd: Use TX FIFO size read from CAN controller

 drivers/net/can/Kconfig         |   3 +-
 drivers/net/can/kvaser_pciefd.c | 622 +++++++++-----------------------
 2 files changed, 168 insertions(+), 457 deletions(-)

-- 
2.40.0

