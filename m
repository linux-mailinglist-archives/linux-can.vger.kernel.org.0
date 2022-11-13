Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2BF36627069
	for <lists+linux-can@lfdr.de>; Sun, 13 Nov 2022 17:19:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233793AbiKMQTD (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Sun, 13 Nov 2022 11:19:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231252AbiKMQTC (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Sun, 13 Nov 2022 11:19:02 -0500
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D794E005
        for <linux-can@vger.kernel.org>; Sun, 13 Nov 2022 08:19:00 -0800 (PST)
Received: by mail-pj1-x1036.google.com with SMTP id q1-20020a17090a750100b002139ec1e999so8582743pjk.1
        for <linux-can@vger.kernel.org>; Sun, 13 Nov 2022 08:19:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=u91i7P8b9CR+9pe4/DYlTwISJ1GOKkKSIZWnGBJVncc=;
        b=cY5neJSGROJgmN2lmDUpJau061EtKf8oP5FwEQ2tQv411b/D9C4fLuKuZKwGjl5qXd
         dscJUtO5StlDX2UzwccgiYjjWDJaONaa90s8i5KjMpfm8wDeWmRJaDJ2l5wnNCzg8BOZ
         de2+gT3BnFAzpnGKe5cSBLXEfbxIHWuCta0sJa+JC4q+T/yTgLoqLDu4Da30JdcyeB4Z
         nsO9WCHnQkUZDlBcBBxt5XpHx/LUPIlTyD5V5aaYJUdEIK4keeoXm9aP5jHz7Wum0AEq
         oAXrDmReVML4Y3uhVHE9p9c0g5LgjxBaOvpAsg4y/4S9yCRWJv4mNcrTgbSfKOOvlFQk
         MuLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=u91i7P8b9CR+9pe4/DYlTwISJ1GOKkKSIZWnGBJVncc=;
        b=labmf+wHeYr1H6qqbSP4bK2OgdhmJyOoroHxtAl62Gov21F9Slv6SQra8n+3kpULKd
         EcHGOY5WmYEjVm4Dv/chbmTQw3QPEq4JFykg/v8MPaT6TsM0vHSgmTcjke0Derxsuu/r
         PhWMmqkMpG6wzS0aElOOx7xWLNj/sVgfIR5/X2wAlLZVfBZ/m7jCd62wpgmzBfbYFyVP
         X9VPmJY2Xlj6HRBTguGhQQ+58EK9+XuT68d85OQjPtGHLvid89BDl29IUBH5rMXkndyT
         WqPIKC4GrXwBJ4NDw/nROk91dMq2WIEvh65aCrgSBKz7+sOPQnEJJMXQSO+2eLqfzt/T
         OnyQ==
X-Gm-Message-State: ANoB5pnpQIexNwzFhk8Y7NXVi4TqFHxCX0cpbpSJZqsZK6GwUB0vS9z3
        XEkknxml0/ScAPQ6SuX0mZoxoRYKCS286Q==
X-Google-Smtp-Source: AA0mqf5kDMmh48TwRAtSgiVq8naZHpqUdPU7lO58Tmma7b6A0OD+dGHxRTUA63CKFPUGFJVz7qlqjw==
X-Received: by 2002:a17:90a:8983:b0:210:3539:1c0a with SMTP id v3-20020a17090a898300b0021035391c0amr10522506pjn.204.1668356339366;
        Sun, 13 Nov 2022 08:18:59 -0800 (PST)
Received: from localhost.localdomain (124x33x176x97.ap124.ftth.ucom.ne.jp. [124.33.176.97])
        by smtp.gmail.com with ESMTPSA id 192-20020a6217c9000000b0056c04dee930sm4863558pfx.120.2022.11.13.08.18.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Nov 2022 08:18:58 -0800 (PST)
Sender: Vincent Mailhol <vincent.mailhol@gmail.com>
From:   Vincent Mailhol <mailhol.vincent@wanadoo.fr>
To:     linux-can@vger.kernel.org
Cc:     Oliver Hartkopp <socketcan@hartkopp.net>,
        Marc Kleine-Budde <mkl@pengutronix.de>,
        Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Subject: [PATCH can-utils-dev v2 1/5] slcanpty: remove redundant asc2nibble()
Date:   Mon, 14 Nov 2022 01:18:27 +0900
Message-Id: <20221113161831.16388-2-mailhol.vincent@wanadoo.fr>
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

asc2nibble() is already defined in lib.h. Include lib.h in slcnpty.c
so that asc2nibble() does not need to be redefined a second time and
adjust the Makefile accordingly.

Signed-off-by: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
---
 Makefile   |  2 ++
 slcanpty.c | 17 ++---------------
 2 files changed, 4 insertions(+), 15 deletions(-)

diff --git a/Makefile b/Makefile
index fb52643..cb67b66 100644
--- a/Makefile
+++ b/Makefile
@@ -119,6 +119,7 @@ canplayer.o:	lib.h
 cansend.o:	lib.h
 log2asc.o:	lib.h
 log2long.o:	lib.h
+slcanpty.o:	lib.h
 j1939acd.o:	libj1939.h
 j1939cat.o:	libj1939.h
 j1939spy.o:	libj1939.h
@@ -135,6 +136,7 @@ cansend:	cansend.o	lib.o
 cansequence:	cansequence.o	lib.o
 log2asc:	log2asc.o	lib.o
 log2long:	log2long.o	lib.o
+slcanpty:	slcanpty.o	lib.o
 j1939acd:	j1939acd.o	libj1939.o
 j1939cat:	j1939cat.o	libj1939.o
 j1939spy:	j1939spy.o	libj1939.o
diff --git a/slcanpty.c b/slcanpty.c
index e6f1efe..4ac9e8a 100644
--- a/slcanpty.c
+++ b/slcanpty.c
@@ -43,27 +43,14 @@
 #include <linux/can/raw.h>
 #include <linux/sockios.h>
 
+#include "lib.h"
+
 /* maximum rx buffer len: extended CAN frame with timestamp */
 #define SLC_MTU (sizeof("T1111222281122334455667788EA5F\r")+1)
 #define DEVICE_NAME_PTMX "/dev/ptmx"
 
 #define DEBUG
 
-static int asc2nibble(char c)
-{
-
-	if ((c >= '0') && (c <= '9'))
-		return c - '0';
-
-	if ((c >= 'A') && (c <= 'F'))
-		return c - 'A' + 10;
-
-	if ((c >= 'a') && (c <= 'f'))
-		return c - 'a' + 10;
-
-	return 16; /* error */
-}
-
 /* read data from pty, send CAN frames to CAN socket and answer commands */
 int pty2can(int pty, int socket, struct can_filter *fi,
 	    int *is_open, int *tstamp)
-- 
2.37.4

