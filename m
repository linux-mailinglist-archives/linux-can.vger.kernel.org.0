Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1BE4C70D95F
	for <lists+linux-can@lfdr.de>; Tue, 23 May 2023 11:45:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236032AbjEWJpY (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Tue, 23 May 2023 05:45:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236147AbjEWJpV (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 23 May 2023 05:45:21 -0400
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8375B94
        for <linux-can@vger.kernel.org>; Tue, 23 May 2023 02:45:10 -0700 (PDT)
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-4f4b0a0b557so2206167e87.1
        for <linux-can@vger.kernel.org>; Tue, 23 May 2023 02:45:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kvaser.com; s=google; t=1684835049; x=1687427049;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gFqle+aQr+WeC7JcKvfVVfPpkjYxj43P/KuYGKD2iOM=;
        b=pkM1I53l+vcq68j2RB+nFk38FRUobKlw/MLY1q/yRlsM/tUj3fMeCLdKntV0w5mWga
         CmbxQ+FJflXDHBkUug587UAA6ZKC7woNu4ytdFfPJa/0O721qwD3T1oGK3qnTJ6uNdZO
         s+OTBr/xryvx/0wAVsm2eHhivx4v7d4jKEz0AOYHOFIsz8+PTAxxFnjJQGSmWopEZph1
         s1T1CkHDsF2wvs2YOtua7jN54SWgmK3AXtiqIMWzbTHEIG9bSM1eWLLrCC8KjU83fbWJ
         B5qF8KlEQ9IVHJ8Ib8OE2vTJI+nzoVYDLELRz1YTAlB9IyImoWKNpVxNPc6giXytr0s9
         F8dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684835049; x=1687427049;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gFqle+aQr+WeC7JcKvfVVfPpkjYxj43P/KuYGKD2iOM=;
        b=cEpnvCOP55MxvJl61SGDvCV85iIwF39OoYTr1ddkrOtnm57y17fH2b45Tjg2mJirJl
         Z0FSUBfw3tOC7F4RTCceeeQhkd17FBMCvJlZOgFtljQoi5u6A1obRm+d/i+JksBX++B5
         W+lpq5bL+Uxs7fmkn1YapNHisRFQNlIcT4a0maMQiqBMpNz0Oy/EBueQCl7WSvM/P6gL
         T9zRanJEexhAlYJoSrEsIghfUuUtXgW1ibAZpNZA4kigaZHztS8HHiot2JU7twEpakDd
         8CzRjFeekvy4WbUexeUzaKcKosr44B/JuNmBpYcjAHNBx152L5/VhZnICV8iW6xlwk9r
         bjJw==
X-Gm-Message-State: AC+VfDyNl/qEnl1L/Jfqw4wUQqIbN7SEos0ZC62Bqc8ZVhdMqnrOaZ+x
        kPQsk90KH8ewwsiPUBxZh6h25IC4GfnsT/iIxz8=
X-Google-Smtp-Source: ACHHUZ6z5cr9Df604Oc5oWgk9Xca/q8CVd43EnqP5FCfJyaOhpV4Kip100d8LmBUWfPUBKUCoyFwkA==
X-Received: by 2002:ac2:5a47:0:b0:4ef:d3f3:c421 with SMTP id r7-20020ac25a47000000b004efd3f3c421mr5184278lfn.4.1684835049045;
        Tue, 23 May 2023 02:44:09 -0700 (PDT)
Received: from archyz.. (h-98-128-173-232.A785.priv.bahnhof.se. [98.128.173.232])
        by smtp.gmail.com with ESMTPSA id c16-20020a2e9490000000b002ac87c15fd4sm1535551ljh.95.2023.05.23.02.44.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 May 2023 02:44:08 -0700 (PDT)
From:   Jimmy Assarsson <extja@kvaser.com>
To:     linux-can@vger.kernel.org
Cc:     Jimmy Assarsson <jimmyassarsson@gmail.com>,
        Jimmy Assarsson <extja@kvaser.com>
Subject: [PATCH 07/12] can: kvaser_pciefd: Sort includes in alphabetic order
Date:   Tue, 23 May 2023 11:43:45 +0200
Message-Id: <20230523094354.83792-8-extja@kvaser.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230523094354.83792-1-extja@kvaser.com>
References: <20230523094354.83792-1-extja@kvaser.com>
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

