Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B71BC714A8F
	for <lists+linux-can@lfdr.de>; Mon, 29 May 2023 15:44:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229615AbjE2Noz (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Mon, 29 May 2023 09:44:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229899AbjE2Noz (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Mon, 29 May 2023 09:44:55 -0400
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C112A0
        for <linux-can@vger.kernel.org>; Mon, 29 May 2023 06:44:53 -0700 (PDT)
Received: by mail-lf1-x12e.google.com with SMTP id 2adb3069b0e04-4f122ff663eso3566056e87.2
        for <linux-can@vger.kernel.org>; Mon, 29 May 2023 06:44:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kvaser.com; s=google; t=1685367891; x=1687959891;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gFqle+aQr+WeC7JcKvfVVfPpkjYxj43P/KuYGKD2iOM=;
        b=szcPFlQq/niOgD0Y2q4s4PijkiGH6lnSw/ShkEOHBS9znxCNr0QwrIsTUYW7L1dbkH
         u/l4zhfi7TVXprvzwnn93/z+lopzg/HMZG79Qz7wO77q4XnvZ+QUOM+GolAPzSrl4oaE
         CI0Pw1r0LOHUdZ863QYoiNyrTL8v/g9FO1vaN0eTER0ubZkxo+0z8tiQvA9XlklHcuti
         m1fibWx3QNgBHTr7W+wscR0SrkmmmaXSGtCqi5Fy6O6r7CS2reGCJf44TEpAAGUfbD4w
         GpoISoRronG7l2OhTRBiq6Ke7t3K/fRaO+mkVReeOuFZTYA+RjC7uwN27oOjPBx3KESr
         P/eA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685367891; x=1687959891;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gFqle+aQr+WeC7JcKvfVVfPpkjYxj43P/KuYGKD2iOM=;
        b=hSEFQtqCmYqPUwxD44/68HQ7yA3X8090lp46jaJdr1gpvsfaSfIO+1SiuaN1ZJ52wZ
         bxo9bwtmFhCygf5kF/WksfjjkXx0sAMOv92VJ2StRdHKg1JsV7WHVtzF63Vn+EqyXddj
         lfzfxN2WSje0J4p0KLouPTiEx0aV5ItEorRfS4Ojx42LNlIjJtBeJNKvpMBKyXBrjasf
         ygyWnDQPT4MMgcCQNTFpSJQy95ufRiYiUYnTqQ4jZLBy9AqO5j1lfme8L+e6qWVaEN7C
         qCZFwz4uNmKRQx4NEraUS6FddjR0zabGujiWHXuFv/g4ugCYfBkAjpA49k/KgwzMYQ2I
         vyAA==
X-Gm-Message-State: AC+VfDxMWRLdPhPfQmL4qyjhxH4V+KgTW1O4qgi5QxX2w5eIHkXMmxyL
        KCOT6OqHu88fV9oFOS6+B0T666YdoTur2QEywsY=
X-Google-Smtp-Source: ACHHUZ7gII7uHhYgzeZCzgisJh8gnA5t+7ErVypD0pLb5JBMpIZ/Zk4HA7K97bW1N/7b7uL6tDZ9+Q==
X-Received: by 2002:ac2:51ac:0:b0:4f0:ff66:b4f1 with SMTP id f12-20020ac251ac000000b004f0ff66b4f1mr3771953lfk.22.1685367891443;
        Mon, 29 May 2023 06:44:51 -0700 (PDT)
Received: from freke.kvaser.se (h-98-128-173-232.A785.priv.bahnhof.se. [98.128.173.232])
        by smtp.gmail.com with ESMTPSA id s7-20020a19ad47000000b004ebae99cc1dsm580lfd.159.2023.05.29.06.44.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 May 2023 06:44:51 -0700 (PDT)
From:   Jimmy Assarsson <extja@kvaser.com>
To:     linux-can@vger.kernel.org,
        Vincent MAILHOL <mailhol.vincent@wanadoo.fr>
Cc:     Jimmy Assarsson <jimmyassarsson@gmail.com>,
        Jimmy Assarsson <extja@kvaser.com>
Subject: [PATCH v2 07/14] can: kvaser_pciefd: Sort includes in alphabetic order
Date:   Mon, 29 May 2023 15:42:41 +0200
Message-Id: <20230529134248.752036-8-extja@kvaser.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20230529134248.752036-1-extja@kvaser.com>
References: <20230529134248.752036-1-extja@kvaser.com>
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

Sort the includes in alphabetic order.

Signed-off-by: Jimmy Assarsson <extja@kvaser.com>
---
 drivers/net/can/kvaser_pciefd.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/net/can/kvaser_pciefd.c b/drivers/net/can/kvaser_pciefd.c
index e24a8e77aef1..8be27a7dc7e9 100644
--- a/drivers/net/can/kvaser_pciefd.c
+++ b/drivers/net/can/kvaser_pciefd.c
@@ -5,16 +5,16 @@
  *  - PEAK linux canfd driver
  */
 
+#include <linux/can/dev.h>
+#include <linux/device.h>
+#include <linux/ethtool.h>
+#include <linux/iopoll.h>
 #include <linux/kernel.h>
 #include <linux/minmax.h>
 #include <linux/module.h>
-#include <linux/device.h>
-#include <linux/ethtool.h>
+#include <linux/netdevice.h>
 #include <linux/pci.h>
-#include <linux/can/dev.h>
 #include <linux/timer.h>
-#include <linux/netdevice.h>
-#include <linux/iopoll.h>
 
 MODULE_LICENSE("Dual BSD/GPL");
 MODULE_AUTHOR("Kvaser AB <support@kvaser.com>");
-- 
2.40.0

