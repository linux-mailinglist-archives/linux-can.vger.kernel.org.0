Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C481F373176
	for <lists+linux-can@lfdr.de>; Tue,  4 May 2021 22:36:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232854AbhEDUhB (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Tue, 4 May 2021 16:37:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232169AbhEDUhA (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 4 May 2021 16:37:00 -0400
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4B7AC061574
        for <linux-can@vger.kernel.org>; Tue,  4 May 2021 13:36:02 -0700 (PDT)
Received: by mail-lj1-x22a.google.com with SMTP id o16so12875866ljp.3
        for <linux-can@vger.kernel.org>; Tue, 04 May 2021 13:36:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=flodin-me.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=0axzc7no5h3INRXc+5xP0BDp3d4xOPiiJKbi/m2zvG0=;
        b=nA0Vd3HsV37YAgXFnWawSi/QUAI712ahgzw7ZE2JNmqbv+UnWLJRodeqdyIeeZ++3k
         gY05zrgmnKAD4gTH55N25Nxqs4X7Fgi6yHs5E1TWCHQQ8A9605fzRpeHhBa22c/7JFC8
         zSY+5WtwB9XPqxTwg2ZYYIGqvYca1Ewh6b4dzjPC/vXByy3iuCzg8ORm9gmK9w/FGoU8
         GjkLfboxu3CBKVgTbV4dMWy/FdxOgS6DxwmnesgNXQP62L7H99LcYbjk04xpjkqWVHHL
         9wXS9Rch6nFZbtncdiIa9XJWa4Xs6AYEHaw9bz+D0IFiUUE1LrQoLPgsuj4bQr0o67jn
         /Khg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=0axzc7no5h3INRXc+5xP0BDp3d4xOPiiJKbi/m2zvG0=;
        b=SDoghjQlNSAojfY6lEbz71eO+X0tk2MffNvVA2q53UnoI5hpmZq+Magck4ExvuYcJQ
         N5y3pDAoYDdMO0dMqsuDXEjl06n6yI/zt7d3vSBffPweGvY/HIPZo5uIkl7wL2Polez8
         jAirjZ/7NOZv+nabfoDaOXrT75O4jVjuPXYPobYHWinjh1xLhAuhNqdMA+2lw5LQSBWD
         00/bumpJNqNw/7s2Hx6IZNKRRNiVDoThZbe19cpgaw99cmMNA4GRBi4GZ1CTxVt3ajcq
         9aYjI2jyP1kexwbnizgSJyFHerWnn7+g12zOq8DThuRZy8Ce6A3SJ0eam7tuhzEdcHUC
         VRww==
X-Gm-Message-State: AOAM533aWw2dI96O8EoK3IJGtFAsVnvhhQ+OQs5pft8Yh4ruQgISye7G
        y26J1EDYDKOdTSLhtxf+ksVpLQ==
X-Google-Smtp-Source: ABdhPJyUeoCJBYXqXV0qacfH28GoiRJuTtvPEt6/vftDe5OL79M2MJx9P5fHe1QdpXiP6+KjgToevw==
X-Received: by 2002:a2e:2c01:: with SMTP id s1mr3082191ljs.17.1620160561169;
        Tue, 04 May 2021 13:36:01 -0700 (PDT)
Received: from trillian.bjorktomta.lan (h-158-174-77-132.NA.cust.bahnhof.se. [158.174.77.132])
        by smtp.gmail.com with ESMTPSA id v1sm1792222ljj.77.2021.05.04.13.35.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 May 2021 13:36:00 -0700 (PDT)
From:   Erik Flodin <erik@flodin.me>
To:     socketcan@hartkopp.net, mkl@pengutronix.de
Cc:     davem@davemloft.net, kuba@kernel.org, corbet@lwn.net,
        linux-can@vger.kernel.org, netdev@vger.kernel.org,
        linux-doc@vger.kernel.org, Erik Flodin <erik@flodin.me>
Subject: [PATCH v2 0/2] can: Add CAN_RAW_RECV_OWN_MSGS_ALL socket option
Date:   Tue,  4 May 2021 22:35:44 +0200
Message-Id: <20210504203546.115734-1-erik@flodin.me>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Add a socket option that works as CAN_RAW_RECV_OWN_MSGS but where reception
of a socket's own frame isn't subject to filtering. This way transmission
confirmation can more easily (or at all if CAN_RAW_JOIN_FILTERS is enabled)
be used in combination with filters.

Changes since v1:
- Rebase on top of can-next/master.

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
 net/can/proc.c                   |  11 ++--
 net/can/raw.c                    | 101 +++++++++++++++++++++++++------
 11 files changed, 153 insertions(+), 67 deletions(-)


base-commit: 9d31d2338950293ec19d9b095fbaa9030899dcb4
-- 
2.31.1

