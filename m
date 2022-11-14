Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C0DC26285A4
	for <lists+linux-can@lfdr.de>; Mon, 14 Nov 2022 17:40:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237840AbiKNQkv (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Mon, 14 Nov 2022 11:40:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237833AbiKNQk0 (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Mon, 14 Nov 2022 11:40:26 -0500
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F027F5FC8
        for <linux-can@vger.kernel.org>; Mon, 14 Nov 2022 08:39:13 -0800 (PST)
Received: by mail-pf1-x430.google.com with SMTP id k15so11531820pfg.2
        for <linux-can@vger.kernel.org>; Mon, 14 Nov 2022 08:39:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/MgiQmPlf3s15cSQPNeyAp64Pun4oKgxRr1xwh7ytgQ=;
        b=bZcmEV70RJ6Gwd70a/7nyHpMsmWAFWJ7vI+KtJgDMkZUbZYYbDtxCzR5p8iCTneU8C
         7PbVGL2atmU+81O8PP0dhjjGwwR3/bJndDKpxDWV95VBBL4rYODBlM8S9YqP6nTSdRco
         V3EOb299rBFHdJGY0x9xzLW7Kd7jsr4leSJbFdTXzi4sdQGNlFGDCjQbv6SIZ6i9rjbo
         HjwxDeluERjhCFSw15/E/olfrbO9ap3BeXgBG6JoweH3riM0tQA536YONGkjiFgFTqYv
         eq4X+2HHDW3yH/XDaj84n0V5404n2v3jBwrB7+cA3E6BmUb9xuadG75P1tkGxjLnJ7IE
         01Vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=/MgiQmPlf3s15cSQPNeyAp64Pun4oKgxRr1xwh7ytgQ=;
        b=nQC+6Dfab4XNkCyraM9drS0nrLcVvOYvdcNMWgzcg/a6tEUYkfqvTpoY9Vs0ngONt2
         9sFGVW0kiayV41r25Ludel44ur/BbhEtJoxTlz5yrngRCHMBwHvbumCwbrdehfnOLMF5
         bn0zvGEgUIZkJpMEolgs47CNKnUmACfjLpa1uHDNjb+xLP2sPJlmViZTjbveB8KGHt1m
         uJxtC35nZeAgLRE8hBKp4BpNl6IU/W4vAIpGgXXc7HYAmPLYac6P8GBSeCV+1F5JE3N1
         OSrqdsMhSqqO6xztRoV7hjWbGvAvlUDxv03tTlHFnIVDl0F5CsXgXa8ZQtV3aCJ2grj8
         KaXg==
X-Gm-Message-State: ANoB5pkIv4MAIfAVZ2Ybd6kYJ7NhKPNe8M3iV6ttcRaE1EHF21BsmHOh
        1TACkK5Ljbd1tLMEbkzJePUSLEO2WrWAWQ==
X-Google-Smtp-Source: AA0mqf4d+CBdbiXIfiOsAE8gG9LZKNng/gT3BdqQpyzqMl/2PgiIwumImxjWWA+Gb2yeHcsoXdJx1w==
X-Received: by 2002:a63:cf50:0:b0:470:4522:f317 with SMTP id b16-20020a63cf50000000b004704522f317mr12322886pgj.129.1668443953130;
        Mon, 14 Nov 2022 08:39:13 -0800 (PST)
Received: from localhost.localdomain (124x33x176x97.ap124.ftth.ucom.ne.jp. [124.33.176.97])
        by smtp.gmail.com with ESMTPSA id g190-20020a6252c7000000b0057255b82bd1sm807183pfb.217.2022.11.14.08.39.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Nov 2022 08:39:12 -0800 (PST)
Sender: Vincent Mailhol <vincent.mailhol@gmail.com>
From:   Vincent Mailhol <mailhol.vincent@wanadoo.fr>
To:     linux-can@vger.kernel.org
Cc:     Oliver Hartkopp <socketcan@hartkopp.net>,
        Marc Kleine-Budde <mkl@pengutronix.de>,
        Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Subject: [PATCH can-utils-dev v3 4/6] lib: add pr_debug() macro
Date:   Tue, 15 Nov 2022 01:38:46 +0900
Message-Id: <20221114163848.3398-5-mailhol.vincent@wanadoo.fr>
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

Add the pr_debug() macro so that:

  #ifdef DEBUG
  	printf("foo");
  #endif

can be replaced by:

  	pr_debug("foo");

Apply the pr_debug() macro wherever relevant.

Currently, there is no consensus whether debug messages should be
printed on stdout or stderr. Most of the modules: canbusload.c,
candump.c and canlogserver.c use stdout but
mcp251xfd/mcp251xfd-dev-coredump.c uses stderr. Harmonize the behavior
by following the major trend and make
mcp251xfd/mcp251xfd-dev-coredump.c also output to stdout.

slcanpty.c does a #define DEBUG, meaning that debug is always turned
on for this file. Remove this and make debug an option like every
other files.

Signed-off-by: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
---
 canbusload.c                       |  9 +++------
 candump.c                          | 16 ++++------------
 canlogserver.c                     | 12 ++++--------
 lib.h                              |  7 +++++++
 mcp251xfd/mcp251xfd-dev-coredump.c | 10 +---------
 slcanpty.c                         | 10 +++-------
 6 files changed, 22 insertions(+), 42 deletions(-)

diff --git a/canbusload.c b/canbusload.c
index e4dfc02..47b62fd 100644
--- a/canbusload.c
+++ b/canbusload.c
@@ -61,6 +61,7 @@
 #include <linux/can.h>
 #include <linux/can/raw.h>
 
+#include "lib.h"
 #include "terminal.h"
 #include "canframelen.h"
 
@@ -310,9 +311,7 @@ int main(int argc, char **argv)
 			return 1;
 		}
 
-#ifdef DEBUG
-		printf("open %d '%s'.\n", i, ptr);
-#endif
+		pr_debug("open %d '%s'.\n", i, ptr);
 
 		s[i] = socket(PF_CAN, SOCK_RAW, CAN_RAW);
 		if (s[i] < 0) {
@@ -358,10 +357,8 @@ int main(int argc, char **argv)
 		if (nbytes > max_bitrate_len)
 			max_bitrate_len = nbytes; /* for nice printing */
 
+		pr_debug("using interface name '%s'.\n", ifr.ifr_name);
 
-#ifdef DEBUG
-		printf("using interface name '%s'.\n", ifr.ifr_name);
-#endif
 		/* try to switch the socket into CAN FD mode */
 		const int canfd_on = 1;
 		setsockopt(s[i], SOL_CAN_RAW, CAN_RAW_FD_FRAMES, &canfd_on, sizeof(canfd_on));
diff --git a/candump.c b/candump.c
index 6fe30bb..4a239e7 100644
--- a/candump.c
+++ b/candump.c
@@ -216,9 +216,7 @@ static int idx2dindex(int ifidx, int socket)
 
 	strcpy(devname[i], ifr.ifr_name);
 
-#ifdef DEBUG
-	printf("new index %d (%s)\n", i, devname[i]);
-#endif
+	pr_debug("new index %d (%s)\n", i, devname[i]);
 
 	return i;
 }
@@ -474,9 +472,7 @@ int main(int argc, char **argv)
 		ptr = argv[optind+i];
 		nptr = strchr(ptr, ',');
 
-#ifdef DEBUG
-		printf("open %d '%s'.\n", i, ptr);
-#endif
+		pr_debug("open %d '%s'.\n", i, ptr);
 
 		obj->s = socket(PF_CAN, SOCK_RAW, CAN_RAW);
 		if (obj->s < 0) {
@@ -510,9 +506,7 @@ int main(int argc, char **argv)
 		memset(&ifr.ifr_name, 0, sizeof(ifr.ifr_name));
 		strncpy(ifr.ifr_name, ptr, nbytes);
 
-#ifdef DEBUG
-		printf("using interface name '%s'.\n", ifr.ifr_name);
-#endif
+		pr_debug("using interface name '%s'.\n", ifr.ifr_name);
 
 		if (strcmp(ANYDEV, ifr.ifr_name) != 0) {
 			if (ioctl(obj->s, SIOCGIFINDEX, &ifr) < 0) {
@@ -602,9 +596,7 @@ int main(int argc, char **argv)
 			/* try SO_RCVBUFFORCE first, if we run with CAP_NET_ADMIN */
 			if (setsockopt(obj->s, SOL_SOCKET, SO_RCVBUFFORCE,
 				       &rcvbuf_size, sizeof(rcvbuf_size)) < 0) {
-#ifdef DEBUG
-				printf("SO_RCVBUFFORCE failed so try SO_RCVBUF ...\n");
-#endif
+				pr_debug("SO_RCVBUFFORCE failed so try SO_RCVBUF ...\n");
 				if (setsockopt(obj->s, SOL_SOCKET, SO_RCVBUF,
 					       &rcvbuf_size, sizeof(rcvbuf_size)) < 0) {
 					perror("setsockopt SO_RCVBUF");
diff --git a/canlogserver.c b/canlogserver.c
index 6425ca4..51d548f 100644
--- a/canlogserver.c
+++ b/canlogserver.c
@@ -145,9 +145,7 @@ int idx2dindex(int ifidx, int socket)
 
 	strcpy(devname[i], ifr.ifr_name);
 
-#ifdef DEBUG
-	printf("new index %d (%s)\n", i, devname[i]);
-#endif
+	pr_debug("new index %d (%s)\n", i, devname[i]);
 
 	return i;
 }
@@ -310,11 +308,9 @@ int main(int argc, char **argv)
 
 	for (i=0; i<currmax; i++) {
 
-#ifdef DEBUG
-		printf("open %d '%s' m%08X v%08X i%d e%d.\n",
-		       i, argv[optind+i], mask[i], value[i],
-		       inv_filter[i], err_mask[i]);
-#endif
+		pr_debug("open %d '%s' m%08X v%08X i%d e%d.\n",
+		      i, argv[optind+i], mask[i], value[i],
+		      inv_filter[i], err_mask[i]);
 
 		if ((s[i] = socket(PF_CAN, SOCK_RAW, CAN_RAW)) < 0) {
 			perror("socket");
diff --git a/lib.h b/lib.h
index a4d3ce5..6cc58a2 100644
--- a/lib.h
+++ b/lib.h
@@ -47,6 +47,13 @@
 
 #include <stdio.h>
 
+#ifdef DEBUG
+#define pr_debug(fmt, args...) printf(fmt, ##args)
+#else
+__attribute__((format (printf, 1, 2)))
+static inline int pr_debug(const char* fmt, ...) {return 0;}
+#endif
+
 /* buffer sizes for CAN frame string representations */
 
 #define CL_ID (sizeof("12345678##1"))
diff --git a/mcp251xfd/mcp251xfd-dev-coredump.c b/mcp251xfd/mcp251xfd-dev-coredump.c
index 5874d24..422900f 100644
--- a/mcp251xfd/mcp251xfd-dev-coredump.c
+++ b/mcp251xfd/mcp251xfd-dev-coredump.c
@@ -17,18 +17,10 @@
 
 #include <linux/kernel.h>
 
+#include "../lib.h"
 #include "mcp251xfd.h"
 #include "mcp251xfd-dump-userspace.h"
 
-#define pr_err(fmt, args...)    fprintf(stderr, fmt, ##args)
-#define pr_no(fmt, args...)     while (0) { fprintf(stdout, fmt, ##args); }
-
-#ifdef DEBUG
-#define pr_debug(fmt, args...) pr_err(fmt, ##args)
-#else
-#define pr_debug(fmt, args...) pr_no(fmt, ##args)
-#endif
-
 
 struct mcp251xfd_dump_iter {
 	const void *start;
diff --git a/slcanpty.c b/slcanpty.c
index 4ac9e8a..fa97cd6 100644
--- a/slcanpty.c
+++ b/slcanpty.c
@@ -49,8 +49,6 @@
 #define SLC_MTU (sizeof("T1111222281122334455667788EA5F\r")+1)
 #define DEVICE_NAME_PTMX "/dev/ptmx"
 
-#define DEBUG
-
 /* read data from pty, send CAN frames to CAN socket and answer commands */
 int pty2can(int pty, int socket, struct can_filter *fi,
 	    int *is_open, int *tstamp)
@@ -106,14 +104,12 @@ rx_restart:
 	cmd = buf[0];
 	buf[nbytes] = 0;
 
-#ifdef DEBUG
 	for (tmp = 0; tmp < nbytes; tmp++)
 		if (buf[tmp] == '\r')
-			putchar('@');
+			pr_debug("@");
 		else
-			putchar(buf[tmp]);
-	printf("\n");
-#endif
+			pr_debug("%c", buf[tmp]);
+	pr_debug("\n");
 
 	/* check for filter configuration commands */
 	if (cmd == 'm' || cmd == 'M') {
-- 
2.37.4

