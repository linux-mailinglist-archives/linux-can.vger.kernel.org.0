Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2461F36A7B7
	for <lists+linux-can@lfdr.de>; Sun, 25 Apr 2021 16:14:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230214AbhDYOP2 (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Sun, 25 Apr 2021 10:15:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229906AbhDYOP1 (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Sun, 25 Apr 2021 10:15:27 -0400
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com [IPv6:2a00:1450:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C20FC061756
        for <linux-can@vger.kernel.org>; Sun, 25 Apr 2021 07:14:47 -0700 (PDT)
Received: by mail-lj1-x22d.google.com with SMTP id b38so19844299ljf.5
        for <linux-can@vger.kernel.org>; Sun, 25 Apr 2021 07:14:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=flodin-me.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+0mM/qMNc4B4VYwhLsNdsBejrnT5u5kkfqn8D/fEEm4=;
        b=JC2rTxg6hoQHZJKsmrEYUaKmG7SdMVTg8/wZVh+AgD7ntzXCOfRFkfrkYkM+Xi+mLG
         SOIwxkIREJRO9C0RWS5OF8GYhusweD0cnoLqA0chF60XXR48pgQMqeMpcCkJUFvM68Ay
         oZsfoheYX0w9/qXwgbIr5kYl3fpmiZMAfJb2UaEh9FithSWHlYWT7xQVF2ryR/ugAzDw
         wF/nPvw1JK3P9GZvUavetRS6z92GCuQ7OjFbuLW88hkCRpChPO7LSvaFZNQ7fCRsLFsb
         /9O7vN4OKilhNUTIp7iicH7wAP9xDIZFgN7eNRWT+ji5cPVRkGuzFGPshgJV08vyCXMT
         IQBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+0mM/qMNc4B4VYwhLsNdsBejrnT5u5kkfqn8D/fEEm4=;
        b=bpo6tO9lEjVzw4Elp45L/ASAtXRSiW3s+pmLXnvroZDVovH1BW2dqd6KcOexfYQ8Vl
         1Ud2n4X835/zhct9q5j3ZyStrbQd9Gm52O+t6N75RtndRhZuo4FJNX0wcPAme0to49IA
         jp/RWcgRn7JPP43cNrwv/SsAK/zwLnXlmhW5GZU2KgccOAZwg6A6MCh3CGJg35hz6yKy
         l/MjecUGmeysRR/JwbVRwECCzPww7fOU9tktgfWQaYjGqmw+3gUIEOqVKA7hBNY98JcT
         Ia7sBE26KnKDRSTtEcM2bqr/6t70U9Ci4+7v0e6bPEwr8DA5rWGwYB3G917uwjRh05Fc
         R6oA==
X-Gm-Message-State: AOAM531mEm6gtlYve2c5G4f/0HO05JuwCZFgo2wTeU2nzG6l/TY2sAw5
        fGIyscpotK1dMOkT9hk/tC+kvQ==
X-Google-Smtp-Source: ABdhPJx2WuBZPzF4VftEf8Qg3Fy2IxTNbrRQ0BzNG12YPYlOgoCBzMcONkGlk7rVDY8tvC09q8CG8w==
X-Received: by 2002:a05:651c:88:: with SMTP id 8mr9612711ljq.268.1619360085736;
        Sun, 25 Apr 2021 07:14:45 -0700 (PDT)
Received: from trillian.bjorktomta.lan (h-158-174-77-132.NA.cust.bahnhof.se. [158.174.77.132])
        by smtp.gmail.com with ESMTPSA id s13sm1182655ljc.26.2021.04.25.07.14.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Apr 2021 07:14:45 -0700 (PDT)
From:   Erik Flodin <erik@flodin.me>
Cc:     Erik Flodin <erik@flodin.me>,
        Oliver Hartkopp <socketcan@hartkopp.net>,
        Marc Kleine-Budde <mkl@pengutronix.de>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>, linux-can@vger.kernel.org,
        netdev@vger.kernel.org
Subject: [PATCH] can: proc: fix rcvlist_* header alignment on 64-bit system
Date:   Sun, 25 Apr 2021 16:14:35 +0200
Message-Id: <20210425141440.229653-1-erik@flodin.me>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <20210425095249.177588-1-erik@flodin.me>
References: <20210425095249.177588-1-erik@flodin.me>
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
index 5ea8695f507e..ba00619cc3c0 100644
--- a/net/can/proc.c
+++ b/net/can/proc.c
@@ -205,8 +205,10 @@ static void can_print_recv_banner(struct seq_file *m)
 	 *                  can1.  00000000  00000000  00000000
 	 *                 .......          0  tp20
 	 */
-	seq_puts(m, "  device   can_id   can_mask  function"
-			"  userdata   matches  ident\n");
+	if (IS_ENABLED(CONFIG_64BIT))
+		seq_puts(m, "  device   can_id   can_mask      function          userdata       matches  ident\n");
+	else
+		seq_puts(m, "  device   can_id   can_mask  function  userdata   matches  ident\n");
 }
 
 static int can_stats_proc_show(struct seq_file *m, void *v)
-- 
2.31.0

