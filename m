Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8E582456F79
	for <lists+linux-can@lfdr.de>; Fri, 19 Nov 2021 14:20:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234650AbhKSNXe (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Fri, 19 Nov 2021 08:23:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229554AbhKSNXe (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Fri, 19 Nov 2021 08:23:34 -0500
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FD5CC061574
        for <linux-can@vger.kernel.org>; Fri, 19 Nov 2021 05:20:32 -0800 (PST)
Received: by mail-lf1-x12e.google.com with SMTP id bu18so43614324lfb.0
        for <linux-can@vger.kernel.org>; Fri, 19 Nov 2021 05:20:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kvaser.com; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=WOZX+ATDrxMa2xtvR5Sp3aGVqqVRHee5LN1mFguSvF8=;
        b=T0Ny76N1iv210305c2HpZjH/qadGN9L3A/AwjiE6ZM6FU254MQh6+ErhuclzqYs4tD
         4ZU/P0UBPtIKIMwty4fLHdwBXrQnPa3I8W79xlXAfcZffi0qO+/kxSUlMSiXyc/OtJ10
         4p6Ix3M2cV+7Ld43sPShYmrdn2UrwvuNxYMoSyMBVohS9HRLiUgjRVdJ5ThHj+niwxhd
         jJVEpplsIJ5529B4NVOqXfB9PxHUGv+EJ1EmX7pT9lM9guPmXDcOehwBffgxR9PNqGB7
         Vs+hjtoP1UdnR+aKGjM4JoCRuDcPxsWLhTgvqUGNfW64vLH4W3g/bQv2q0Y4mIj6y0Tp
         bkJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=WOZX+ATDrxMa2xtvR5Sp3aGVqqVRHee5LN1mFguSvF8=;
        b=duqDMNmb0r8BBwJD3I3VBGglwIhUAbWopgajcYV3VKjbsPrR5IFqTYnFO1PpJwBvr4
         9iGw0Sv05gMWOsLFLPK6MKotnXlpLFos1fcIlWOtYLLFKrR2ZudMKxV/W0z01gjb1rdw
         KD+826qjfHzDDnN6WcciJ5sVElH0zLz9n3abPIHFyp/sNtrMVReN7PPLJ9J2/iiBLRcP
         n+u+WZFBIWhzwP9MnsRtIyQclrHGqkfxhCujNV3abG4P3NfjlgYtWCdDt2GMYnIRQh1J
         axizkkEwGwmC1kaXxDfsRjYFKK2vkgEdwQKdmN5MOVSwdaxLwwcIZnK1ejQ9vVW+3v6z
         f2+Q==
X-Gm-Message-State: AOAM530GN8up4oZ+BjcDrN+42DqBUQlnrvS0yZXtb+aq/kNhEvRZbt5n
        j9WedldE0Sd5UKQL31KUgtwG7v5QUrMaZlOk
X-Google-Smtp-Source: ABdhPJyoFU92zzp2CrWjWpg1HZ2ydmFUaAFO82O5PWXg08b9T2nypab+IiXeFZoS3/FhF6R0f/1NXQ==
X-Received: by 2002:a05:6512:398b:: with SMTP id j11mr33002840lfu.461.1637328030982;
        Fri, 19 Nov 2021 05:20:30 -0800 (PST)
Received: from localhost (h-155-4-68-234.A785.priv.bahnhof.se. [155.4.68.234])
        by smtp.gmail.com with UTF8SMTPSA id br24sm362304lfb.104.2021.11.19.05.20.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 19 Nov 2021 05:20:30 -0800 (PST)
From:   Jimmy Assarsson <extja@kvaser.com>
To:     linux-can@vger.kernel.org
Cc:     Jimmy Assarsson <jimmyassarsson@gmail.com>,
        Jimmy Assarsson <extja@kvaser.com>
Subject: [PATCH v1 0/5] kvaser_{pciefd,usb} fixes
Date:   Fri, 19 Nov 2021 14:19:10 +0100
Message-Id: <20211119131915.2033234-1-extja@kvaser.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

The first patches fix net_device_stats when receiving error frames.
The last two patches fix the CAN clock frequency for Kvaser Leaf devices.

Note that this series contains patches for both kvaser_usb and
kvaser_pciefd driver.

Jimmy Assarsson (5):
  can: kvaser_pciefd: Do not increase stats->rx_{packets,bytes} for
    error frames
  can: kvaser_pciefd: Increase correct stats->{rx,tx}_errors counter
  can: kvaser_usb: Do not increase stats->rx_{packets,bytes} for error
    frames
  can: kvaser_usb: Use CAN_MHZ define in assignment of frequency
  can: kvaser_usb: Get CAN clock frequency from device

 drivers/net/can/kvaser_pciefd.c               | 11 +--
 .../net/can/usb/kvaser_usb/kvaser_usb_hydra.c | 13 ++--
 .../net/can/usb/kvaser_usb/kvaser_usb_leaf.c  | 70 ++++++++++++++++---
 3 files changed, 72 insertions(+), 22 deletions(-)

-- 
2.31.1

