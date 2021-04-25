Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EBEE636A5E0
	for <lists+linux-can@lfdr.de>; Sun, 25 Apr 2021 10:50:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229559AbhDYIuu (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Sun, 25 Apr 2021 04:50:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229543AbhDYIut (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Sun, 25 Apr 2021 04:50:49 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98C8FC061756
        for <linux-can@vger.kernel.org>; Sun, 25 Apr 2021 01:50:05 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id y4so43507879lfl.10
        for <linux-can@vger.kernel.org>; Sun, 25 Apr 2021 01:50:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=flodin-me.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ujKca+JTuVhPoMhmMDjrRFgqpHT2xUS8hTPaqNfVQbk=;
        b=d9lhczl3w/teld+CtLE7/6A5JlbDCkCfk35gVoI7EajXVuTY9M9jyd2lTBIPZHkLbv
         IvA9i31Z413j20D3Jx2itwQPZrgutd0kZDnr4bzDDpVCTSSYLTBYawvEYvfQYWkAkZzs
         rauUXGTJIZJAo6aroQtOXlquxa9OuFC22D4OngmZFYQuvLhXE4yfWBukIa04+XFfiJYL
         IyX/d/g7hSFoDN7P9KTve0LD/cyfr3t9IUyZ66GB2UZb4c0kTc4kbbjOidnTfHiPz3Zp
         5nhyYe5b7HQCFqvM2pSwHzRfEFJ0f9ZwmUimzqI92qwR5OtIzbBJ/DbNeW5QRlLigKLH
         u3Sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ujKca+JTuVhPoMhmMDjrRFgqpHT2xUS8hTPaqNfVQbk=;
        b=RmSmNAOfZbccLNpL02fPZm7eP9vykaCA29bWSkK2w2WU1ejZQJkTXQhhhGop28wJ5w
         pnnc+pXgQsT6pHZdmRDND5F95gWSW/B1PnCeAtyDGDlwJrHRIyy/PPDCXKzQzo26MqED
         7eQOqNy7iifJ+pijkhxEPwrDtCnqAZI5aPFqxVSdZmMQNcE+BRoqhmoM6nFGsM2t6muk
         DO37S+scN97q8k/7+eJYrRL9ThgtGYw5iilzm8aRtLhhE7w+Zj5OWgEzsSn21VVCXp9z
         QLdFrFh7nEYSa8wBvEZq2i1HtVYcOpqMG78djqOrzUoGLziLy3IXI3gZjcgv2IFs/b6G
         mwAw==
X-Gm-Message-State: AOAM5333FFAyFyA57jmCub4U1yas3DgBQgMqpd8IP5cUuL6SGnQF1YZL
        b2nsE7Mxae9zMQFU76WL8PJL+Q==
X-Google-Smtp-Source: ABdhPJyEFgEO40LQBZLQ1wGubsfRoX6hwUac66FyEFgBjq8gcw+EZPfv3dZH+MrDG77B+53EFo5f7w==
X-Received: by 2002:a05:6512:2287:: with SMTP id f7mr8966561lfu.143.1619340604023;
        Sun, 25 Apr 2021 01:50:04 -0700 (PDT)
Received: from trillian.bjorktomta.lan (h-158-174-77-132.NA.cust.bahnhof.se. [158.174.77.132])
        by smtp.gmail.com with ESMTPSA id u6sm1048433lfr.164.2021.04.25.01.50.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Apr 2021 01:50:03 -0700 (PDT)
From:   Erik Flodin <erik@flodin.me>
Cc:     Erik Flodin <erik@flodin.me>,
        Oliver Hartkopp <socketcan@hartkopp.net>,
        Marc Kleine-Budde <mkl@pengutronix.de>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>, linux-can@vger.kernel.org,
        netdev@vger.kernel.org
Subject: [PATCH] can: fix proc/can/net/rcvlist_* header alignment on 64-bit system
Date:   Sun, 25 Apr 2021 10:49:29 +0200
Message-Id: <20210425084950.171529-1-erik@flodin.me>
X-Mailer: git-send-email 2.31.0
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
 net/can/proc.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/net/can/proc.c b/net/can/proc.c
index 5ea8695f507e..97901e56c429 100644
--- a/net/can/proc.c
+++ b/net/can/proc.c
@@ -205,8 +205,11 @@ static void can_print_recv_banner(struct seq_file *m)
 	 *                  can1.  00000000  00000000  00000000
 	 *                 .......          0  tp20
 	 */
-	seq_puts(m, "  device   can_id   can_mask  function"
-			"  userdata   matches  ident\n");
+	const char *pad = sizeof(void *) == 8 ? "    " : "";
+
+	seq_printf(m, "  device   can_id   can_mask  %sfunction%s"
+		   "  %suserdata%s   matches  ident\n",
+		   pad, pad, pad, pad);
 }
 
 static int can_stats_proc_show(struct seq_file *m, void *v)
-- 
2.31.0

