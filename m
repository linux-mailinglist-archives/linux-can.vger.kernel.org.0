Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F1FA0626E9C
	for <lists+linux-can@lfdr.de>; Sun, 13 Nov 2022 09:53:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235249AbiKMIxo (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Sun, 13 Nov 2022 03:53:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232676AbiKMIxn (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Sun, 13 Nov 2022 03:53:43 -0500
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6276364DA
        for <linux-can@vger.kernel.org>; Sun, 13 Nov 2022 00:53:39 -0800 (PST)
Received: by mail-pf1-x435.google.com with SMTP id g62so8478653pfb.10
        for <linux-can@vger.kernel.org>; Sun, 13 Nov 2022 00:53:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+SZ9UDp16eDIf3HptjqMyvI6uWN0laN21YFMx+ojbkE=;
        b=F+N3Enb1eO/ejJ77lUii7fT9rBiMPozlaWZrcYC3GEYRR5HnDWeqWAUD1YJiAWDwvn
         rgdOKY5H6uDxbfx1MSgw60duUFKDFwS8pILK7335zkByfPdiRI+jId/T0JQYMNNyp5Kk
         EKS4Zswg5tV9YQH3OcuP7SDMTfG77zpUnkq0KjKZ5rt4S0tU91yMt3i1ltUvF/7kDPaC
         5u9+/LACrwliLb77AZs4gyTSkvjrkkCTXcxgCKTCF9kwSfr/f4aRx1S9tud+3mKxMp40
         z/ADkJydzNlBU3rSKTUM92KZlYUh7FZz3vXVEf20MSBpc5vKZKr29psIhH1McEfPK4J7
         yldQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=+SZ9UDp16eDIf3HptjqMyvI6uWN0laN21YFMx+ojbkE=;
        b=oANcKjP7YsoVzRqgYCqmiLYoLzmBjiPW/hiz/UrzstQ6WOGCnrGPqNOlSTckvKm9iH
         L1KBVqfPAf++sz6fVFHhlnLWNTIYi6iykjMflQa8wR7q7CCHxwrJLfTmD8qvdHQTTooA
         uwXTvfB9Q/qtWqRzXVD2jDVc62/UsdOmXLHXQ011kCvuuXECvXewV0t0Mv37Vu5JIRyR
         PHzDZeyGLKiLsRqkK9U0j4IcGBdYBiE2XxUcA2lWvyYRhwpOspCiY+irAoOvbnHNVPEY
         Ug8zGrqrnAnmvJte4ghCnxwqD72TbOAq9Uq+hG0OKxRz0OnKL9lqqKg9F0SRiAri2JO3
         S3dQ==
X-Gm-Message-State: ANoB5pnxju/2AN91Ah3h3nagA2Tx/GJjOT0K8WVJeABcAIr1iYddaYSY
        ipTrqHivrWHSRbwiusQrs85aqvaWRpqQBQ==
X-Google-Smtp-Source: AA0mqf489NXqSsCx0/Z8KwrueZdebaPXTSy0X3LvBulADrW0I45Rr/HqmR7IJGV0L+ZfRkxkDYYbzg==
X-Received: by 2002:aa7:81da:0:b0:565:a1c9:194b with SMTP id c26-20020aa781da000000b00565a1c9194bmr9472015pfn.26.1668329618644;
        Sun, 13 Nov 2022 00:53:38 -0800 (PST)
Received: from localhost.localdomain (124x33x176x97.ap124.ftth.ucom.ne.jp. [124.33.176.97])
        by smtp.gmail.com with ESMTPSA id y1-20020a626401000000b00528a097aeffsm4372391pfb.118.2022.11.13.00.53.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Nov 2022 00:53:38 -0800 (PST)
Sender: Vincent Mailhol <vincent.mailhol@gmail.com>
From:   Vincent Mailhol <mailhol.vincent@wanadoo.fr>
To:     linux-can@vger.kernel.org
Cc:     Oliver Hartkopp <socketcan@hartkopp.net>,
        Marc Kleine-Budde <mkl@pengutronix.de>,
        Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Subject: [PATCH can-utils-dev 4/5] candump: use linux/net_tstamp.h instead of redefining values ourselves
Date:   Sun, 13 Nov 2022 17:53:20 +0900
Message-Id: <20221113085321.87910-5-mailhol.vincent@wanadoo.fr>
X-Mailer: git-send-email 2.37.4
In-Reply-To: <20221113085321.87910-1-mailhol.vincent@wanadoo.fr>
References: <20221113085321.87910-1-mailhol.vincent@wanadoo.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

No need to redefine values when available in header.

linux/net_tstamp.h is available since Linux 2.6.30 while socket CAN
was introduced in v2.6.25. These being old releases not being
maintained any more for many years, dropping support is
acceptable.

Regardless, candump already relies on some other macros defined in
more recent kernel version (e.g. CAN_RAW_ERR_FILTER) meaning that it
would not build on old linux kernel environments.

Signed-off-by: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
---
 candump.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/candump.c b/candump.c
index 4abd2f6..8f0ca46 100644
--- a/candump.c
+++ b/candump.c
@@ -63,6 +63,7 @@
 
 #include <linux/can.h>
 #include <linux/can/raw.h>
+#include <linux/net_tstamp.h>
 
 #include "terminal.h"
 #include "lib.h"
@@ -72,10 +73,6 @@
 #define SO_TIMESTAMPING 37
 #endif
 
-/* from #include <linux/net_tstamp.h> - since Linux 2.6.30 */
-#define SOF_TIMESTAMPING_SOFTWARE (1 << 4)
-#define SOF_TIMESTAMPING_RX_SOFTWARE (1 << 3)
-#define SOF_TIMESTAMPING_RAW_HARDWARE (1 << 6)
 #define TIMESTAMPSZ 50 /* string 'absolute with date' requires max 49 bytes */
 
 #define MAXSOCK 16    /* max. number of CAN interfaces given on the cmdline */
-- 
2.37.4

