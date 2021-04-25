Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AC2BB36A70B
	for <lists+linux-can@lfdr.de>; Sun, 25 Apr 2021 14:14:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229906AbhDYMPU (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Sun, 25 Apr 2021 08:15:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229763AbhDYMPT (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Sun, 25 Apr 2021 08:15:19 -0400
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com [IPv6:2a00:1450:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CE8FC06175F
        for <linux-can@vger.kernel.org>; Sun, 25 Apr 2021 05:14:38 -0700 (PDT)
Received: by mail-lj1-x22e.google.com with SMTP id b38so19651521ljf.5
        for <linux-can@vger.kernel.org>; Sun, 25 Apr 2021 05:14:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=flodin-me.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Ui/oKByGj6/AJm7hu4VFd9WZLUmRk81ykuLYPnPSCVY=;
        b=QfR2dSBul9bd4vawyBhHnAhxghgs9zgb5zm9HQNdEKpvJF08HpKKwgdsxw/oFypow/
         iA6q9df2izTHyTKuVP8I5Ssmfve1clMRcR4kPXA8ScofYh15h1WpCN92rJPAROJwwE4v
         uPvacEfZGbL4ozFMtAguSTb2P6vrTde2voRA5xj8Zhz2QWgIo+6klPmRXvxmZjY5mL6P
         KqZgV9aArJsRx6Ytqp/GZC1lfMxs6to7CyhofTzawv0MmTLoNUCOlT/DILVakckIgveU
         pRXvKTkKe+GrxfYLHLvGE5XaT3HC/5afn6AoggxDJ7RY41YWoW37Qe2uefr0wByNktIL
         FuoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Ui/oKByGj6/AJm7hu4VFd9WZLUmRk81ykuLYPnPSCVY=;
        b=GC7NulKBkjpEyBeNh5g+wInpoXz+6hK/USv5rROqLP696o7hih77aqnOSECOfVoD7x
         p87P/0mQqNKYe0xY1MvaDHi+DZ/5oYiYvYny8khWHDIzlgbmUaa4EV0qI3xykd0o/z+f
         jO0dq8hqmsdF/Np6WS71k2W+QJv2i8iTSbr0FaczHFpFEH10vd9ps/bVBh7kUZIVoJuS
         uD8WHJqYScs6BQeuEVPTQszf29TB6ObXP/b2i66XOgQ9Utu59KyC6sisfpmmyDivnyqn
         47e2VvygPd9z4YevFd8CtDrwDBJHUsvCPAnOSoR8ttl3GrjK1PlFtmpEGeTgczkyu5Yu
         gMdA==
X-Gm-Message-State: AOAM5316qzXzFbvP7YePIqfd2hPLaMtP5McRP2ogK5I9H1Y4wJS7lYgt
        hI0mTtacjiHv9MyGL+xNPFsP7Q==
X-Google-Smtp-Source: ABdhPJysUMW1n1S3Gnnmo3ezhuxasYZ3BykSEP6aSrzva9nEPyssRGHfrrAzM+qFPgtsgJi0X1Ao1A==
X-Received: by 2002:a05:651c:106f:: with SMTP id y15mr9654599ljm.145.1619352876770;
        Sun, 25 Apr 2021 05:14:36 -0700 (PDT)
Received: from trillian.bjorktomta.lan (h-158-174-77-132.NA.cust.bahnhof.se. [158.174.77.132])
        by smtp.gmail.com with ESMTPSA id w16sm1120049lfu.160.2021.04.25.05.14.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Apr 2021 05:14:36 -0700 (PDT)
From:   Erik Flodin <erik@flodin.me>
To:     socketcan@hartkopp.net, mkl@pengutronix.de
Cc:     davem@davemloft.net, kuba@kernel.org, corbet@lwn.net,
        linux-can@vger.kernel.org, netdev@vger.kernel.org,
        linux-doc@vger.kernel.org, Erik Flodin <erik@flodin.me>
Subject: [PATCH 0/2] can: Add CAN_RAW_RECV_OWN_MSGS_ALL socket option
Date:   Sun, 25 Apr 2021 14:12:42 +0200
Message-Id: <20210425121244.217680-1-erik@flodin.me>
X-Mailer: git-send-email 2.31.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Add a socket option that works as CAN_RAW_RECV_OWN_MSGS but where reception
of a socket's own frame isn't subject to filtering. This way transmission
confirmation can more easily (or at all if CAN_RAW_JOIN_FILTERS is enabled)
be used in combination with filters.

Erik Flodin (2):
  can: add support for filtering own messages only
  can: raw: add CAN_RAW_RECV_OWN_MSGS_ALL socket option

 Documentation/networking/can.rst |   7 +++
 include/linux/can/core.h         |   4 +-
 include/uapi/linux/can/raw.h     |  18 +++---
 net/can/af_can.c                 |  50 ++++++++-------
 net/can/af_can.h                 |   1 +
 net/can/bcm.c                    |   9 ++-
 net/can/gw.c                     |   7 ++-
 net/can/isotp.c                  |   8 +--
 net/can/j1939/main.c             |   4 +-
 net/can/proc.c                   |   9 +--
 net/can/raw.c                    | 101 +++++++++++++++++++++++++------
 11 files changed, 152 insertions(+), 66 deletions(-)


base-commit: f40ddce88593482919761f74910f42f4b84c004b
-- 
2.31.0

