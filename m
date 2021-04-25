Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2F07F36A65A
	for <lists+linux-can@lfdr.de>; Sun, 25 Apr 2021 11:53:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229911AbhDYJxq (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Sun, 25 Apr 2021 05:53:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229668AbhDYJxq (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Sun, 25 Apr 2021 05:53:46 -0400
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 395B6C061574
        for <linux-can@vger.kernel.org>; Sun, 25 Apr 2021 02:53:06 -0700 (PDT)
Received: by mail-lf1-x12a.google.com with SMTP id g8so83878754lfv.12
        for <linux-can@vger.kernel.org>; Sun, 25 Apr 2021 02:53:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=flodin-me.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=dLiKSbWhlGZSUV+iRQ1/IADQ4m+lyxFqf/acvVJO7Ow=;
        b=R9xZj8rrHG3dgWOtGjP0GhSUVHHdkJGQC80qj4PQBNkNnEPfWQU396pFvqbd7/Q6MU
         Yuo4526G209AQorct9gyp5PzvWsrM6YsLE2BltIQVF0NGKfw/n4/sy3n71uN0sZpTC4R
         QoQ/T49fj8/hl4ssiNNHxxNz2t2qRoXqJTGC2/w9fvkUpRb7iOVCJKqveQNFEaG7FCma
         77/1PHb0ECjbgD9FGj0+fP80IJwgW88PKe0QFp3RJQCpuOne7UnqcQuL6T111G1eWqUo
         xS6Zx6p6LmB+HoFuy5OBZhotDvfaHKX6WF3ua0wDN65uHc/nK+LYdvcLmbcqfqAACwF/
         Df4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=dLiKSbWhlGZSUV+iRQ1/IADQ4m+lyxFqf/acvVJO7Ow=;
        b=YQTCZI8I/Pz/VZfNNHib0ZNoWKeEqI6xa0ZWNMETQeyHMkyc5bzVqNx8FtDDpDsrxs
         62Jr4+RGUiZ1Ho1F44ix8T6HzIDy4nzk+hdC3WnrvzAzB88sJez5wg8WI1CcqBNxlCQr
         sH5JDkKI2cCBBKDP9rztAjDVHbm/a9ncDQ/Tho2bo8FjyhGhfBUqLeCMs8+lTE4Jo0iZ
         IB0OwiY5x6KcRUdWVNQppI7ilwQg64JxHt7SLVh/HnLr0WMDHC/xoWCKby4IQG6TAk7o
         vlmjkFt1DmRjRD5lE2vZDxcHbEYPq+HsnEbVI4pcF748GLzYrs7ot7anlF6Kt1CKbOYi
         Ix3Q==
X-Gm-Message-State: AOAM533s3f2K44HlT5AHOcfiQv8Prrl4Lf3VRxxl4UJAgRwfSToFhKiu
        2eLwg1xn12hNH5L5WikfWcgBYw==
X-Google-Smtp-Source: ABdhPJwvWNz+OiL2ITuFiBhiru4qjxH3CNpJAkdK+pQ7UamPwP0KA4gyTF+N/wi4hLOq1EdauD4Qrw==
X-Received: by 2002:a05:6512:14a:: with SMTP id m10mr9270442lfo.74.1619344384761;
        Sun, 25 Apr 2021 02:53:04 -0700 (PDT)
Received: from trillian.bjorktomta.lan (h-158-174-77-132.NA.cust.bahnhof.se. [158.174.77.132])
        by smtp.gmail.com with ESMTPSA id x41sm1055669lfa.236.2021.04.25.02.53.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Apr 2021 02:53:04 -0700 (PDT)
From:   Erik Flodin <erik@flodin.me>
Cc:     Erik Flodin <erik@flodin.me>,
        Oliver Hartkopp <socketcan@hartkopp.net>,
        Marc Kleine-Budde <mkl@pengutronix.de>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>, linux-can@vger.kernel.org,
        netdev@vger.kernel.org
Subject: [PATCH] can: proc: fix rcvlist_* header alignment on 64-bit system
Date:   Sun, 25 Apr 2021 11:52:36 +0200
Message-Id: <20210425095249.177588-1-erik@flodin.me>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <20210425090751.2jqj4yqx5ztyqhvg@pengutronix.de>
References: <20210425090751.2jqj4yqx5ztyqhvg@pengutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Before this fix, the function and userdata columns weren't aligned:
  device   can_id   can_mask  function  userdata   matches  ident
   vcan0  92345678  9fffffff  0000000000000000  0000000000000000         0  raw
   vcan0     123    00000123  0000000000000000  0000000000000000         0  raw

After the fix they are:
  device   can_id   can_mask      function          userdata       matches  ident
   vcan0  92345678  9fffffff  0000000000000000  0000000000000000         0  raw
   vcan0     123    00000123  0000000000000000  0000000000000000         0  raw

Signed-off-by: Erik Flodin <erik@flodin.me>
---
 net/can/proc.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/net/can/proc.c b/net/can/proc.c
index 5ea8695f507e..9c341ccd097c 100644
--- a/net/can/proc.c
+++ b/net/can/proc.c
@@ -201,12 +201,14 @@ static void can_print_rcvlist(struct seq_file *m, struct hlist_head *rx_list,
 
 static void can_print_recv_banner(struct seq_file *m)
 {
+	const char *pad = sizeof(void *) == 8 ? "    " : "";
+
 	/*
 	 *                  can1.  00000000  00000000  00000000
 	 *                 .......          0  tp20
 	 */
-	seq_puts(m, "  device   can_id   can_mask  function"
-			"  userdata   matches  ident\n");
+	seq_printf(m, "  device   can_id   can_mask  %sfunction%s  %suserdata%s   matches  ident\n",
+		   pad, pad, pad, pad);
 }
 
 static int can_stats_proc_show(struct seq_file *m, void *v)
-- 
2.31.0

