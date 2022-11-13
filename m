Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A3DB626E98
	for <lists+linux-can@lfdr.de>; Sun, 13 Nov 2022 09:53:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235267AbiKMIxj (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Sun, 13 Nov 2022 03:53:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235272AbiKMIxg (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Sun, 13 Nov 2022 03:53:36 -0500
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 584825F7A
        for <linux-can@vger.kernel.org>; Sun, 13 Nov 2022 00:53:34 -0800 (PST)
Received: by mail-pg1-x531.google.com with SMTP id 6so7833705pgm.6
        for <linux-can@vger.kernel.org>; Sun, 13 Nov 2022 00:53:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=u91i7P8b9CR+9pe4/DYlTwISJ1GOKkKSIZWnGBJVncc=;
        b=R2bgnTybxNloECKq0Q33DXEdpPQIESaUKDblf+xJ3fK19koNs7olDRBLJ9egG1RL4X
         XTXigKO75/pokRDtV3Hcb2OmyNkXupIKBduK+mVDWoU2a2X6TzZyszTPjA5NO/WfZY+C
         ITUup/ddxnPliyQuNWM6urnltHjloWs4yYK28j1DJMIBklblmHcTQEK9rIb/pauVswDz
         jxWw91jhInL6I69lRXhWKMhXS/gAPly0GCSTyBZA1CFZWoiDj5OJwW2no1mUz3/UEyfU
         rV7Crv/gdlxxkPVOf1DgsI/yQCW5N9XBUmaO0C+gKfGGtFXZXZTlQ5evCKneil3sdaDT
         UFrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=u91i7P8b9CR+9pe4/DYlTwISJ1GOKkKSIZWnGBJVncc=;
        b=rN19imIEPQvBxdmMTUkYu1u4tvuzU4SmMJwxDRtjQYmpQzh2y37L+jFJTaBqYVDU3B
         YIWKpNYxBQGwotIHBinb8xrhaZC6pTnlXJDcia9Tx1l7GtuD1Wp+NU4u+BT+SZnZvJHM
         JTpwn4pdYRjmAJYQ3l9dUbqw4xIXXsG5mfDBSz9Yq8m8WtxaaUCoNH4XWK41UcrZMosP
         48TKaeXeRDn7KlZRgO9TR8Ac8AjWEUmXvZa5UXfQv6O971psq2fanv/62xBNtAHlQ8NF
         JVG4b5FsxLalNruqyQrBLe1wXc3qaElVB3t505v7jW4FCSPyIOot+R1mdd+zrOTv4EFH
         u18Q==
X-Gm-Message-State: ANoB5plahV8PqVUSFRZQVHUIKI0jN+s1j7Illwe2UIwLjX87IKCLfMv9
        wx/KLKb6N0hGZErom++xcVpTqCPWF/sS2Q==
X-Google-Smtp-Source: AA0mqf6GIHP6AIYS/kuNLjPfXLNQrlRT/B1oJ8EoCg0cFEILaqlD5x+/GLyqenJ/8BgU++RTJ1cScw==
X-Received: by 2002:a63:1d0a:0:b0:46f:8976:c7d2 with SMTP id d10-20020a631d0a000000b0046f8976c7d2mr8026193pgd.7.1668329613609;
        Sun, 13 Nov 2022 00:53:33 -0800 (PST)
Received: from localhost.localdomain (124x33x176x97.ap124.ftth.ucom.ne.jp. [124.33.176.97])
        by smtp.gmail.com with ESMTPSA id y1-20020a626401000000b00528a097aeffsm4372391pfb.118.2022.11.13.00.53.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Nov 2022 00:53:33 -0800 (PST)
Sender: Vincent Mailhol <vincent.mailhol@gmail.com>
From:   Vincent Mailhol <mailhol.vincent@wanadoo.fr>
To:     linux-can@vger.kernel.org
Cc:     Oliver Hartkopp <socketcan@hartkopp.net>,
        Marc Kleine-Budde <mkl@pengutronix.de>,
        Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Subject: [PATCH can-utils-dev 1/5] slcanpty: remove redundant asc2nibble()
Date:   Sun, 13 Nov 2022 17:53:17 +0900
Message-Id: <20221113085321.87910-2-mailhol.vincent@wanadoo.fr>
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

