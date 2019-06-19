Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 313114B644
	for <lists+linux-can@lfdr.de>; Wed, 19 Jun 2019 12:35:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730826AbfFSKfn (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Wed, 19 Jun 2019 06:35:43 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:42618 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726826AbfFSKfn (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Wed, 19 Jun 2019 06:35:43 -0400
Received: by mail-ed1-f65.google.com with SMTP id z25so26432689edq.9
        for <linux-can@vger.kernel.org>; Wed, 19 Jun 2019 03:35:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=oebuXpgS/Qtj2AncfZvcdyTEM9afK7TuARys2vAn0rQ=;
        b=o9kWEYZSGkYIsKe6aKqF/uNfGd7mzDAgU2nu8VWHRhomvxGFBMLoTiy8cC4R+/O3fV
         2FwlqkRVM3URNl/NPKK2C0ubg47dV2Bd75tYwvhB9FrDyMkcUicFrmu09qnXtwB/zSOR
         iSmK8tokIswUXrHra8FxoB2K/E44Bq4eE2CnB4WjYTV2/bSfbx9XjX3H9i/lKKp4Pn+9
         egEtRKSRj5zLbLM5B5LVNg5LsEUc1/ke044lGAiy/CEHXvkRyUj0V7gpNBaFfeqBmTXs
         io9CuH9BXptHAalNXtXWMn5ZO1PUQbJNbAZSYkum5niu+sElmJyqSS8reQwEPbWYLC4E
         QG+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=oebuXpgS/Qtj2AncfZvcdyTEM9afK7TuARys2vAn0rQ=;
        b=OJVhH9okdN78KXBlC14KdUp0VrpBEIp8MEqBque2QRC1cKu19FN2i5nn71ewYdaTRq
         nsDRIu3mrmTM/Pz7KivaOS+E4TgSzEJHxI4P/Dx+iOPN22qc+f81lh8GlwmE3Heyu4u8
         50vRaDvLPf22NipwAewMeyrvaHdIpGmdZgHyHQGlZ5v2A0HMbLhO8VMdEvAVFih3Cmai
         hsEU+OvahDalmFot0BrqGbH/vv9agXJEcl+t8+GtXYLu6VJfi/gPmgEIJMa4ZtmTcIlT
         PrTSZRceoimT8ioEUVnrdfwNVN9Ilzj8kStNpt0lmWLkywnd/wwkzrqjXsVDk+GQvW9G
         xC2w==
X-Gm-Message-State: APjAAAVUDA9nrWHu+Rl8en1Sz+15qPQzDD9x1U7vayqHMGltXlDlAu41
        ord43MEygNB4cr5WFJheTPTrr0uw
X-Google-Smtp-Source: APXvYqxlqOXTXOCNCXzyuGyD+u1Bi4Y3fOHCdMz5QlSul0sYFpIGBzca+9XMdZotl8ePsS++SSepRA==
X-Received: by 2002:aa7:ca45:: with SMTP id j5mr33907624edt.217.1560940541533;
        Wed, 19 Jun 2019 03:35:41 -0700 (PDT)
Received: from development1.visionsystems.de (mail.visionsystems.de. [213.209.99.202])
        by smtp.gmail.com with ESMTPSA id m19sm3189155eje.30.2019.06.19.03.35.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 19 Jun 2019 03:35:40 -0700 (PDT)
From:   yegorslists@googlemail.com
To:     linux-can@vger.kernel.org
Cc:     mkl@pengutronix.de, Yegor Yefremov <yegorslists@googlemail.com>
Subject: [PATCH] Add SPDX identifiers
Date:   Wed, 19 Jun 2019 12:35:31 +0200
Message-Id: <20190619103531.21171-1-yegorslists@googlemail.com>
X-Mailer: git-send-email 2.17.0
Sender: linux-can-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

From: Yegor Yefremov <yegorslists@googlemail.com>

Signed-off-by: Yegor Yefremov <yegorslists@googlemail.com>
---
 include/can_netlink.h  | 1 +
 include/libsocketcan.h | 1 +
 src/libsocketcan.c     | 1 +
 3 files changed, 3 insertions(+)

diff --git a/include/can_netlink.h b/include/can_netlink.h
index 3e4323a..a816e45 100644
--- a/include/can_netlink.h
+++ b/include/can_netlink.h
@@ -1,3 +1,4 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
 /*
  * linux/can/netlink.h
  *
diff --git a/include/libsocketcan.h b/include/libsocketcan.h
index 1603a7b..d9ec398 100644
--- a/include/libsocketcan.h
+++ b/include/libsocketcan.h
@@ -1,3 +1,4 @@
+/* SPDX-License-Identifier: LGPL-2.1-or-later */
 /*
  * libsocketcan.h
  *
diff --git a/src/libsocketcan.c b/src/libsocketcan.c
index c802849..6951b22 100644
--- a/src/libsocketcan.c
+++ b/src/libsocketcan.c
@@ -1,3 +1,4 @@
+/* SPDX-License-Identifier: LGPL-2.1-or-later */
 /* libsocketcan.c
  *
  * (C) 2009 Luotao Fu <l.fu@pengutronix.de>
-- 
2.17.0

