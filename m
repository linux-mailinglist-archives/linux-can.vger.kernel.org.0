Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 76E6B7164BB
	for <lists+linux-can@lfdr.de>; Tue, 30 May 2023 16:47:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232317AbjE3Orn (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Tue, 30 May 2023 10:47:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229669AbjE3Ork (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 30 May 2023 10:47:40 -0400
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C742103;
        Tue, 30 May 2023 07:47:38 -0700 (PDT)
Received: by mail-pg1-x532.google.com with SMTP id 41be03b00d2f7-53fbf2c42bfso441687a12.3;
        Tue, 30 May 2023 07:47:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685458057; x=1688050057;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=G5x/T1gjjVFh7gahmvzfEftjIGWRBgFyhKjQXVhJh8w=;
        b=D/XiIQW8I92UEh/TzKXiijoKcF6jo4tapcHWGer5g1h1T2NT6u/vxDnz9OCNzFDUG8
         UmImh6/GwYVIIMEK9W9qZjMifnrXpJwSd6WKX569cHLa5Hsv7+6voZkhVbIMTOqvKrxy
         6dAPkh9YZYipePPx1+sqV0orXJ2XLvhfK4lPb/JaF6NM3D4tzwO1QGAzerpuZcfO4UBl
         3lmf3U3sxo3vyvgOCJxWYMTalIrdm5kanNX6mhhN+ASjlxTAUOiUvAYZlJnhAXxBPD5j
         k7VgQwFvoInUlviL7rIT0/ml5wpPrwQSE5N6YOzLsoGJRljCqOZBBhVLWU4RlV3IS05R
         5AGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685458057; x=1688050057;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=G5x/T1gjjVFh7gahmvzfEftjIGWRBgFyhKjQXVhJh8w=;
        b=Lh+uOruqvVkd5NiZ8SeLFyOH5y1iqiLtgIVke9tjrUoTkfKUqKPGqKBM3EbsQLOIGN
         7VucRQC/fvM3YB4oah8T5F/p9YhUFAWCPtf9VRVe/B1PIDEI5Cy+L7esweu0GB0C9FuS
         mjnM/lSFZ+gTlIJG7hxcWPFgun+vURg7twW5DeiGjhhFPM5/E31k2Dg7mcnmBLg/c+0L
         LTboDyhle72CkJn+z+RA7k4GwqF4S96Yj1fvJTPbVEmLiy7mmeDp/JGylRzEVcJgxXgY
         Tf4gIJsq4hbUbyTRfv94LUzge1WdsKJTuHERYV4vXuAK554BTygGyPatUrkxFdxLu8bW
         LeLw==
X-Gm-Message-State: AC+VfDzxJZYnYlVBGw3+GoGmCRcbAVX5NLX+7V/WbhAQFK/3zTj3BAQ1
        1SvXRSPqnTqf+UiGyPiAKKk=
X-Google-Smtp-Source: ACHHUZ6DKO2twrSz2AQbb44ZmT8CbBFJwANq0YoHMQPQcPhKYco/FaFEHOfsXFC+e3zg91aVYcyoeQ==
X-Received: by 2002:a05:6a20:7fa7:b0:105:8173:93a0 with SMTP id d39-20020a056a207fa700b00105817393a0mr3277898pzj.5.1685458057452;
        Tue, 30 May 2023 07:47:37 -0700 (PDT)
Received: from localhost.localdomain (124x33x176x97.ap124.ftth.ucom.ne.jp. [124.33.176.97])
        by smtp.gmail.com with ESMTPSA id e3-20020aa78c43000000b0063a04905379sm1703193pfd.137.2023.05.30.07.47.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 May 2023 07:47:37 -0700 (PDT)
Sender: Vincent Mailhol <vincent.mailhol@gmail.com>
From:   Vincent Mailhol <mailhol.vincent@wanadoo.fr>
To:     Marc Kleine-Budde <mkl@pengutronix.de>, linux-can@vger.kernel.org,
        Thomas.Kopp@microchip.com
Cc:     Oliver Hartkopp <socketcan@hartkopp.net>, netdev@vger.kernel.org,
        marex@denx.de, Simon Horman <simon.horman@corigine.com>,
        linux-kernel@vger.kernel.org,
        Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Subject: [PATCH v3 2/3] can: length: fix description of the RRS field
Date:   Tue, 30 May 2023 23:46:36 +0900
Message-Id: <20230530144637.4746-3-mailhol.vincent@wanadoo.fr>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20230530144637.4746-1-mailhol.vincent@wanadoo.fr>
References: <20230507155506.3179711-1-mailhol.vincent@wanadoo.fr>
 <20230530144637.4746-1-mailhol.vincent@wanadoo.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

The CAN-FD frames only have one reserved bit. The bit corresponding to
Classical CAN frame's RTR bit is called the "Remote Request
Substitution (RRS)" [1].

N.B. The RRS is not to be confused with the Substitute remote request
(SRR).

Fix the description in the CANFD_FRAME_OVERHEAD_SFF/EFF.

The total remains unchanged, so this is just a documentation fix.

In addition to the above add myself as copyright owner for 2020 (as
coauthor of the initial version, c.f. Fixes tag).

[1] ISO 11898-1:2015 paragraph 10.4.2.3 "Arbitration field":

  RSS bit [only in FD Frames]

    The RRS bit shall be transmitted in fD Frames at the position of
    the RTR bit in Classical Frames. The RRS bit shall be transmitted
    dominant, but receivers shall accept recessive and dominant RRS
    bits.

Fixes: 85d99c3e2a13 ("can: length: can_skb_get_frame_len(): introduce function to get data length of frame in data link layer")
Suggested-by: Thomas Kopp <Thomas.Kopp@microchip.com>
Signed-off-by: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
---
 include/linux/can/length.h | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/include/linux/can/length.h b/include/linux/can/length.h
index b8c12c83bc51..521fdbce2d69 100644
--- a/include/linux/can/length.h
+++ b/include/linux/can/length.h
@@ -1,6 +1,7 @@
 /* SPDX-License-Identifier: GPL-2.0 */
 /* Copyright (C) 2020 Oliver Hartkopp <socketcan@hartkopp.net>
  * Copyright (C) 2020 Marc Kleine-Budde <kernel@pengutronix.de>
+ * Copyright (C) 2020 Vincent Mailhol <mailhol.vincent@wanadoo.fr>
  */
 
 #ifndef _CAN_LENGTH_H
@@ -64,7 +65,7 @@
  * ---------------------------------------------------------
  * Start-of-frame			1
  * Identifier				11
- * Reserved bit (r1)			1
+ * Remote Request Substitution (RRS)	1
  * Identifier extension bit (IDE)	1
  * Flexible data rate format (FDF)	1
  * Reserved bit (r0)			1
@@ -95,7 +96,7 @@
  * Substitute remote request (SRR)	1
  * Identifier extension bit (IDE)	1
  * Identifier B				18
- * Reserved bit (r1)			1
+ * Remote Request Substitution (RRS)	1
  * Flexible data rate format (FDF)	1
  * Reserved bit (r0)			1
  * Bit Rate Switch (BRS)		1
-- 
2.39.3

