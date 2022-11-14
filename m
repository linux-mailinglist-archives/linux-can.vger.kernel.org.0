Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2896A6285A8
	for <lists+linux-can@lfdr.de>; Mon, 14 Nov 2022 17:40:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237953AbiKNQkx (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Mon, 14 Nov 2022 11:40:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237870AbiKNQk1 (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Mon, 14 Nov 2022 11:40:27 -0500
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4480F2AC3
        for <linux-can@vger.kernel.org>; Mon, 14 Nov 2022 08:39:17 -0800 (PST)
Received: by mail-pf1-x42e.google.com with SMTP id 140so10047362pfz.6
        for <linux-can@vger.kernel.org>; Mon, 14 Nov 2022 08:39:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JqnGXu8WmFm66ih/ED4RTVSUPR3uLmgj5GP/u8tXnLE=;
        b=mq/eJ/2ZMvvtfdvXDS/OOVH3BLXk63GbvXrCANjJIeuQEQBFXo3disaYSOU3Avn1vq
         0UOLTvDS5SCaKZVR/B7PHPJfx40vcj7dL1F7kX7W26v28TrJqkzCceT9+JtzPGulx8sl
         mvix+Hnq3dl1zmV307s9XXJtzwixVKkc88HgLXVvSHfWAduWSuE0NXwxa+I/9HvMEyG8
         Rv0Cfmvgkh4cyt71IW9dvD8y3d+baJCjkSatvy+iPydt4AIwKuBr54DjSt7GOxMQGaUN
         88XdtCTw6JxjSGZYJ0L+QY5wvH2zKe72yxhGUfSViYZaVm5ttf8Is685q4h7BgC4pSXL
         10uA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=JqnGXu8WmFm66ih/ED4RTVSUPR3uLmgj5GP/u8tXnLE=;
        b=BYSlJK5iDgfQ1yLtOI8aOuccGoUqWokgd1SyKNeSdmKuMVbdsEXjjupjEE1LIm6ryl
         V5mM9Ic50VZWpAJ6tpaFKD7XPtFRO39fD/w3SLPmReLFVK8dMXddrApiKFOlAHfJ+GWM
         Aug9bsH2Tvglf2IuuSNmg7AUHfcYyM7qE/dGqRUpcV/pG55yuY5PbmDuuJKeXcJUEvIk
         XVy1MkUFsYGgfgkmhdD5tUNLq0FvYRJivv/iCrNXJnBmvNv6B3uFhu2nsyZq82vSmrKf
         tAbtcPb0kV+RhqXA+I3bcELq6GYcRzLJXvRdyjXx6anhuUZRbH2GLYaUvE2HktSzQbG0
         hNGw==
X-Gm-Message-State: ANoB5pmETjPmrRAj0B1jd0PnM2lq/BODyWbkMladx/SwIcyhM7CDbksS
        pUcCy2K0Y0/brxQa4t2JyqAYnNYUocFxQA==
X-Google-Smtp-Source: AA0mqf5o5GC1YL+D2J2ANVFHmDOcsSUYpfsfFADCt/rgphOfC20r8EFlrrZhwBan4PsVQ7Co10tPxQ==
X-Received: by 2002:aa7:8d1a:0:b0:56d:d08c:baf0 with SMTP id j26-20020aa78d1a000000b0056dd08cbaf0mr14840224pfe.72.1668443956521;
        Mon, 14 Nov 2022 08:39:16 -0800 (PST)
Received: from localhost.localdomain (124x33x176x97.ap124.ftth.ucom.ne.jp. [124.33.176.97])
        by smtp.gmail.com with ESMTPSA id g190-20020a6252c7000000b0057255b82bd1sm807183pfb.217.2022.11.14.08.39.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Nov 2022 08:39:16 -0800 (PST)
Sender: Vincent Mailhol <vincent.mailhol@gmail.com>
From:   Vincent Mailhol <mailhol.vincent@wanadoo.fr>
To:     linux-can@vger.kernel.org
Cc:     Oliver Hartkopp <socketcan@hartkopp.net>,
        Marc Kleine-Budde <mkl@pengutronix.de>,
        Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Subject: [PATCH can-utils-dev v3 6/6] candump: use linux/net_tstamp.h instead of redefining values ourselves
Date:   Tue, 15 Nov 2022 01:38:48 +0900
Message-Id: <20221114163848.3398-7-mailhol.vincent@wanadoo.fr>
X-Mailer: git-send-email 2.37.4
In-Reply-To: <20221114163848.3398-1-mailhol.vincent@wanadoo.fr>
References: <20221113085321.87910-1-mailhol.vincent@wanadoo.fr>
 <20221114163848.3398-1-mailhol.vincent@wanadoo.fr>
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

The project contains a local copy of the timestamp header at
include/linux/net_tstamp.h. However, candump.c redefines the
net_tstamp.h values instead of relying on the header.

Replace these by a "include <linux/net_tstamp.h>".

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

