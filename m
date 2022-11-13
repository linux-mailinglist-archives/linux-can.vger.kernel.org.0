Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 493FE62706D
	for <lists+linux-can@lfdr.de>; Sun, 13 Nov 2022 17:19:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233867AbiKMQTJ (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Sun, 13 Nov 2022 11:19:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235234AbiKMQTH (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Sun, 13 Nov 2022 11:19:07 -0500
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7259FD31
        for <linux-can@vger.kernel.org>; Sun, 13 Nov 2022 08:19:06 -0800 (PST)
Received: by mail-pl1-x62b.google.com with SMTP id p21so8057607plr.7
        for <linux-can@vger.kernel.org>; Sun, 13 Nov 2022 08:19:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EdM7zBh0MR88mFFrpvbchTmDl2Kn3Y4A0+JtXwGA8MU=;
        b=RiVmZRU7+Cx66rFEedwt+cwTEb2NddXFcZqlcgXWFQJnUMMDLjLxQRsZPl1MuZyy4o
         jQSXm4QbCtlskwrdp83LN3YeooveCa7tHujdgFDTuLHVPKnnpVNhwvJH6r89V71pyLxc
         w93lo8pHFDDKbF7QnrcvmqDdzaqr+99FEsY31aT9Utbf8pZkci7gUwChgOw3+s33AWGn
         5jCejkOs8gywPp1AB7rz143/TA/1W5TtDWCe/H2sDb4kNs7O76g+nPKLCYvy09H1Qw70
         WDwn+SgwUyzF+z2Yvc9usWTz3WwPLic3GgSzvc3eK0Magt3cCzUZjMQ4gVDErVIMHgUf
         H8+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=EdM7zBh0MR88mFFrpvbchTmDl2Kn3Y4A0+JtXwGA8MU=;
        b=4cOo8qUzM81/CQ0XRlWBMfnJB0k0jmQP2abpUC8F+IqG2upLaqTmRRoJCi/MgHQp8/
         0tk8yyPqVJ3QZS5DWDsIoROoq1A13+PxRHgIKVI79/nYIsVvOIn51qUO3txQN0eh0ABO
         L3PvZiUGnQbgk66b1dIl4vJ1dzuBLdR+PbjG9/v7jeM8LbtOmu9WZT0eHASTIjRpR72F
         7LSNbCy3Yrl1830rrpU0EulfAP6tvpd2F8aYIy9CYNwkXmHYhvIkpYRep0bbXYn4x72r
         G5ZhRTq9FWVYOYxM4qj/tFiU6fo0RV2vdJgoGeAfgIDob/u2mW5WM8Yj//nSpYYH9xnX
         89AQ==
X-Gm-Message-State: ANoB5pnr/DRIZlafzhJv1eJ+lvERai5mdMZ9Pbm4eekMGwA511jm4L7s
        J4exewrQ0XW2OnhjeTnkvRj82Q2LJL0FwA==
X-Google-Smtp-Source: AA0mqf7YA3BtkKxCVykxWAHE+lJPbxADfQ7V/5qVjZwq5Rwp0ZqD/6gwd+JIhQwpcDJAjcdleFZhEQ==
X-Received: by 2002:a17:902:db0a:b0:186:acb1:891d with SMTP id m10-20020a170902db0a00b00186acb1891dmr10270903plx.160.1668356346108;
        Sun, 13 Nov 2022 08:19:06 -0800 (PST)
Received: from localhost.localdomain (124x33x176x97.ap124.ftth.ucom.ne.jp. [124.33.176.97])
        by smtp.gmail.com with ESMTPSA id 192-20020a6217c9000000b0056c04dee930sm4863558pfx.120.2022.11.13.08.19.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Nov 2022 08:19:05 -0800 (PST)
Sender: Vincent Mailhol <vincent.mailhol@gmail.com>
From:   Vincent Mailhol <mailhol.vincent@wanadoo.fr>
To:     linux-can@vger.kernel.org
Cc:     Oliver Hartkopp <socketcan@hartkopp.net>,
        Marc Kleine-Budde <mkl@pengutronix.de>,
        Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Subject: [PATCH can-utils-dev v2 5/5] candump: use linux/net_tstamp.h instead of redefining values ourselves
Date:   Mon, 14 Nov 2022 01:18:31 +0900
Message-Id: <20221113161831.16388-6-mailhol.vincent@wanadoo.fr>
X-Mailer: git-send-email 2.37.4
In-Reply-To: <20221113161831.16388-1-mailhol.vincent@wanadoo.fr>
References: <20221113085321.87910-1-mailhol.vincent@wanadoo.fr>
 <20221113161831.16388-1-mailhol.vincent@wanadoo.fr>
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

No need to redefine values locally when available in header.

linux/net_tstamp.h is available since Linux 2.6.30 while socket CAN
was introduced in v2.6.25. These being old releases not maintained any
more for many years, dropping support is acceptable.

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

