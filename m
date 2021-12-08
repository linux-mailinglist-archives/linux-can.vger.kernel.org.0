Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C427546D1B0
	for <lists+linux-can@lfdr.de>; Wed,  8 Dec 2021 12:09:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229677AbhLHLN1 (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Wed, 8 Dec 2021 06:13:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229478AbhLHLN1 (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Wed, 8 Dec 2021 06:13:27 -0500
Received: from mail-lf1-x141.google.com (mail-lf1-x141.google.com [IPv6:2a00:1450:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04C18C061746
        for <linux-can@vger.kernel.org>; Wed,  8 Dec 2021 03:09:55 -0800 (PST)
Received: by mail-lf1-x141.google.com with SMTP id k37so4925424lfv.3
        for <linux-can@vger.kernel.org>; Wed, 08 Dec 2021 03:09:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kvaser.com; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=kDXYZPU9Seu9Tz6bOkb6n4y6+m/OXUKrCQUqOJP4QCg=;
        b=qClIzsag8pxw50DNvpuYczqrTY5ng9Cw4KNVJhyAAGqubRBJ3TEEmqWlq7lOjxOSu/
         AbjtYXUs8IwerBl7hlOmfz8WtNr4nMH7v2ajJOBPAa+ElZ8KOm1BMuZ6c9h0rQQNWPSQ
         uOgY+G5IgmtDjxEf0IgldpqlScprP9FNtRaV3dUDccEjB8GaprH1bUDcNNFHC+YyrZfy
         b6qurGNj1bQoD8tLNsW948E4HPy7Nz8l71z67KyO7TJxgDINoOlLPhQ8p5BYb8CPsLNU
         R67W/8KsDEjYgTdCLueXfuJDHq0smHBp8U3IfdqTDyw4hu0qMMpn3+6A4UzxATGngZy0
         gjhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=kDXYZPU9Seu9Tz6bOkb6n4y6+m/OXUKrCQUqOJP4QCg=;
        b=xvtAboqV2+Y15xYHbdQfbauUcXSb3SQLw2TQM9CJp3NhDwXZaMTEjOUe/MNoNNzJ2t
         msBpGN7HD8lR6BZ5I982oiCKrSHyJDdgh3zRhnGlfP3Xp4e7Qoaipo6WSeRbzmPGOlFl
         nhNyxhT7zu08Kbg5/Ego0APizJjjoGYEw+fuX1OKQ0T3HKKuEP0D87tmC1WVCibcp3vR
         CrKcHC9Q6rsUrspSr5kUqssiYzZMES7r2BCPAh0RfluaA/bHyiJ0LMTFoS4O6rMBp6c4
         yrO7XVEwvsNUbW6HBfH9tFRiZdk+cTrm7WC22+PaBAZH21G4qFTvZFqmSjj6UMugkVY3
         mEIw==
X-Gm-Message-State: AOAM531hFsUhQ2Dv3JJnnjC2XBTjYYvI5/hO9FFFqF5bq0Ma4mCcrIEb
        KzeHs8L/VvNjhaJFPs4KfcMNpX9UXAm5wnnC
X-Google-Smtp-Source: ABdhPJxF2pKaEjeoIm5BpBTFpff+ul3czU8eDQ7ZjTAvzxzxgEvad6LQkKbDR2PmN7WHnHXimXEYfQ==
X-Received: by 2002:a05:6512:b1f:: with SMTP id w31mr46659595lfu.240.1638961793303;
        Wed, 08 Dec 2021 03:09:53 -0800 (PST)
Received: from freke.kvaser.se (rota.kvaser.com. [195.22.86.90])
        by smtp.gmail.com with ESMTPSA id q6sm223786lfa.133.2021.12.08.03.09.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Dec 2021 03:09:52 -0800 (PST)
From:   Jimmy Assarsson <extja@kvaser.com>
To:     linux-can@vger.kernel.org
Cc:     Jimmy Assarsson <jimmyassarsson@gmail.com>,
        Jimmy Assarsson <extja@kvaser.com>
Subject: [PATCH v2 0/3] kvaser_{pciefd,usb} fixes
Date:   Wed,  8 Dec 2021 12:09:37 +0100
Message-Id: <20211208110940.185629-1-extja@kvaser.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

The first patch fix increase of the correct
net_device_stats {rx,tx}_errors counter, for kvaser_pciefd.
The last two patches fix the CAN clock frequency for Kvaser Leaf devices,
for kvaser_usb.

Note that this series contains patches for both kvaser_usb and
kvaser_pciefd driver.

Dropped patches;
[PATCH v1 1_5] can: kvaser_pciefd: Do not increase
stats->rx_{packets,bytes} for error frames
[PATCH v1 3_5] can: kvaser_usb: Do not increase
stats->rx_{packets,bytes} for error frames
and rebased on [PATCH v5 0/5] fix statistics and payload issues for
error [1] series.

[1]
https://lore.kernel.org/all/20211207121531.42941-1-mailhol.vincent@wanadoo.fr

Jimmy Assarsson (3):
  can: kvaser_pciefd: Increase correct stats->{rx,tx}_errors counter
  can: kvaser_usb: Use CAN_MHZ define in assignment of frequency
  can: kvaser_usb: Get CAN clock frequency from device

 drivers/net/can/kvaser_pciefd.c               |  8 ++-
 .../net/can/usb/kvaser_usb/kvaser_usb_hydra.c |  7 +-
 .../net/can/usb/kvaser_usb/kvaser_usb_leaf.c  | 70 ++++++++++++++++---
 3 files changed, 72 insertions(+), 13 deletions(-)

-- 
2.34.1

