Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4850E6285A0
	for <lists+linux-can@lfdr.de>; Mon, 14 Nov 2022 17:40:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237905AbiKNQkt (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Mon, 14 Nov 2022 11:40:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237637AbiKNQkZ (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Mon, 14 Nov 2022 11:40:25 -0500
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAAA226F5
        for <linux-can@vger.kernel.org>; Mon, 14 Nov 2022 08:39:08 -0800 (PST)
Received: by mail-pg1-x530.google.com with SMTP id 62so2355809pgb.13
        for <linux-can@vger.kernel.org>; Mon, 14 Nov 2022 08:39:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=u91i7P8b9CR+9pe4/DYlTwISJ1GOKkKSIZWnGBJVncc=;
        b=ee2z/91kLPqbbQ0yKHY0zgPSXnBmucCYS+BvXn5RVmUCem6qE981FQ2z8p9WpnWmFT
         0+fmUeD7DZGsKazxr81DDBZaHpPzIZzSrzX4ra33ZYX43rrBMzS4noICjIF4i1EWTKqJ
         weSrxNScK//HtbyieBPEx5CO/nbkC2JUlDJjO/2Up5pni4yeK4cGkbu1QjsPHOmrn+iQ
         JGZArh4tcpTc/odQ+hjP2B7NMPuf+3KZ5tfjp4mO8+XuAotNopgdwj2xlLj3cvUC10mW
         bex2ivISgcTe5GcQ5bM2awnfDM+v8eMWC+B9IBpBpRqaIXRZTRITErrSYaaSzlr7bH4b
         gx2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=u91i7P8b9CR+9pe4/DYlTwISJ1GOKkKSIZWnGBJVncc=;
        b=SCGaw0hd1CkV4bhuLcHYWQNu8Im7vUN0sO5k4KqtQSNI1ZxonyYHwrNRjw1Jv+ewvN
         sPiSFKl0ov3wpLndGqFUgBO/5v//EVqdk/KQRjk5rAM3nf3ERDFYtbfqlvDILSzimtpi
         KHhdOucYYAOdbb+xlTXxcNVvSsymsL8xRgRW4MLwY8jCm7J5zlMqfNEsgvWlID+RfVyt
         tskS/9iiJ11MEDTeiiRaeWV5EU578YL2XQVxzwkFvifj5uCxvTxhWgllcrCMyutoB44y
         EFbRa845heLvgX9axrWLlfAPfHN3sKNUzN63C6TWZ27PkXf/i7HrnooRBE9oVkv1jWLE
         YQUw==
X-Gm-Message-State: ANoB5pkPT9fk6mVIwG4w6t8Sr4kIHlNXf/QVcXKmsXTZ3/Ng0pSsqL27
        wYcsp7QqsjgZ/82R/PxQeUCK+10wWthHkQ==
X-Google-Smtp-Source: AA0mqf5ZQ3GS35xxflk5qMNIrByjkb18tgTZFZSQ1r+yiZyKpB5mBgW6Uvh6SYIZHbHWH1Gx4q3Hew==
X-Received: by 2002:a63:e94c:0:b0:45f:bf86:c917 with SMTP id q12-20020a63e94c000000b0045fbf86c917mr12413028pgj.201.1668443948156;
        Mon, 14 Nov 2022 08:39:08 -0800 (PST)
Received: from localhost.localdomain (124x33x176x97.ap124.ftth.ucom.ne.jp. [124.33.176.97])
        by smtp.gmail.com with ESMTPSA id g190-20020a6252c7000000b0057255b82bd1sm807183pfb.217.2022.11.14.08.39.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Nov 2022 08:39:07 -0800 (PST)
Sender: Vincent Mailhol <vincent.mailhol@gmail.com>
From:   Vincent Mailhol <mailhol.vincent@wanadoo.fr>
To:     linux-can@vger.kernel.org
Cc:     Oliver Hartkopp <socketcan@hartkopp.net>,
        Marc Kleine-Budde <mkl@pengutronix.de>,
        Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Subject: [PATCH can-utils-dev v3 1/6] slcanpty: remove redundant asc2nibble()
Date:   Tue, 15 Nov 2022 01:38:43 +0900
Message-Id: <20221114163848.3398-2-mailhol.vincent@wanadoo.fr>
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

