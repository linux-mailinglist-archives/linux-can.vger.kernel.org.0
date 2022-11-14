Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B61156285A7
	for <lists+linux-can@lfdr.de>; Mon, 14 Nov 2022 17:40:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237977AbiKNQkw (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Mon, 14 Nov 2022 11:40:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237768AbiKNQk0 (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Mon, 14 Nov 2022 11:40:26 -0500
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 907105FEE
        for <linux-can@vger.kernel.org>; Mon, 14 Nov 2022 08:39:15 -0800 (PST)
Received: by mail-pl1-x636.google.com with SMTP id c2so10518917plz.11
        for <linux-can@vger.kernel.org>; Mon, 14 Nov 2022 08:39:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4/BrYRH4Ma28+8BSdOZhJJhsy5Hsgefl2U0aSnTtlac=;
        b=n6f6aTGaMqsmes7YgmMc8mh5MsFo626ZrGY7TuEuDj76QGEaloefjYFBxSL1ejXztY
         NLzhMCNgUAMkM6Ly5oYy8X//kAKD3M7N4RxEVbG6OwOjkqP/0FXAJNCroxqBt5odhK2J
         xv6oP5jBZpkhc+bqf5th9sLVdjoktBuE75ciDC1P4XDdWYQYyto9QnST7Xo1DX6C2hfZ
         ppK65WgzK1ZaBb9WosCAu7EbgrKUQaV8ZcDy19xJxQT8kF9XLThlRc82WPR4kHFpQFfl
         KsedOkHGfB82pT03V5vK+7/PiJZLHJmydEiecPTUV2pabwIil0qLfwPfz4AjJQD/nbpC
         UVtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=4/BrYRH4Ma28+8BSdOZhJJhsy5Hsgefl2U0aSnTtlac=;
        b=E5bqu6yNIj8UhMgqY24+c7WRQWravtZhL+ZwVqPowM6SoESKOUBPFpdmdvoogPf3EO
         U4Aix8HxiK3vKfkSZen7/5kGbcq82dlCnMMyfPDqRvkTpNf8c1YPzxHmco4pWgNnP7Gq
         iQ8yvnJRkMhQzghwIEAdB1TVkKwIyPgI9tV9uvBsbEvKC9Jse4r/AQV1UeRxGDmuo0nW
         J4QYBBJ5yKX3NIyL7/wNA1siaB6zZ0CsjaQ7kl85hSDCirHQDFQ3uNXaBjleQTw9BDFe
         i78nwNTD81mfCAdD6NkOKmiT+fqBPHasTxgYWKc54Bb6spUFS2/B+EXoMjmIr4w4hAZF
         gr0g==
X-Gm-Message-State: ANoB5pnRTCnyUGtmRSmXQ4g6+idhXU24CmQazpw1iNw+jWlp4CGc55kp
        QYoFQXdQ17U7c1V8J0fNac2yIKAeOrgSNQ==
X-Google-Smtp-Source: AA0mqf4RFE90dUNqtxNJYdlw9zmBIR6cMT02AC2NFt2dhhstW1zrWfHzp6EejY+BdHa21UX0FzJ7ag==
X-Received: by 2002:a17:902:ebd2:b0:186:a43a:d5e1 with SMTP id p18-20020a170902ebd200b00186a43ad5e1mr101672plg.77.1668443954842;
        Mon, 14 Nov 2022 08:39:14 -0800 (PST)
Received: from localhost.localdomain (124x33x176x97.ap124.ftth.ucom.ne.jp. [124.33.176.97])
        by smtp.gmail.com with ESMTPSA id g190-20020a6252c7000000b0057255b82bd1sm807183pfb.217.2022.11.14.08.39.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Nov 2022 08:39:14 -0800 (PST)
Sender: Vincent Mailhol <vincent.mailhol@gmail.com>
From:   Vincent Mailhol <mailhol.vincent@wanadoo.fr>
To:     linux-can@vger.kernel.org
Cc:     Oliver Hartkopp <socketcan@hartkopp.net>,
        Marc Kleine-Budde <mkl@pengutronix.de>,
        Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Subject: [PATCH can-utils-dev v3 5/6] candump: add global variable progname
Date:   Tue, 15 Nov 2022 01:38:47 +0900
Message-Id: <20221114163848.3398-6-mailhol.vincent@wanadoo.fr>
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

Instead of using argv[0] several time, make the progname a global
variable.

Signed-off-by: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
---
 candump.c | 37 ++++++++++++++++++++-----------------
 1 file changed, 20 insertions(+), 17 deletions(-)

diff --git a/candump.c b/candump.c
index 4a239e7..4abd2f6 100644
--- a/candump.c
+++ b/candump.c
@@ -108,6 +108,7 @@ struct if_info { /* bundled information per open socket */
 };
 static struct if_info sock_info[MAXSOCK];
 
+static char *progname;
 static char devname[MAXIFNAMES][IFNAMSIZ+1];
 static int dindex[MAXIFNAMES];
 static int max_devname_len; /* to prevent frazzled device name output */
@@ -121,11 +122,11 @@ extern int optind, opterr, optopt;
 
 static volatile int running = 1;
 
-static void print_usage(char *prg)
+static void print_usage(void)
 {
-	fprintf(stderr, "%s - dump CAN bus traffic.\n", prg);
-	fprintf(stderr, "\nUsage: %s [options] <CAN interface>+\n", prg);
-	fprintf(stderr, "  (use CTRL-C to terminate %s)\n\n", prg);
+	fprintf(stderr, "%s - dump CAN bus traffic.\n", progname);
+	fprintf(stderr, "\nUsage: %s [options] <CAN interface>+\n", progname);
+	fprintf(stderr, "  (use CTRL-C to terminate %s)\n\n", progname);
 	fprintf(stderr, "Options:\n");
 	fprintf(stderr, "         -t <type>   (timestamp: (a)bsolute/(d)elta/(z)ero/(A)bsolute w date)\n");
 	fprintf(stderr, "         -H          (read hardware timestamps instead of system timestamps)\n");
@@ -159,12 +160,12 @@ static void print_usage(char *prg)
 	fprintf(stderr, "Without any given filter all data frames are received ('0:0' default filter).\n");
 	fprintf(stderr, "\nUse interface name '%s' to receive from all CAN interfaces.\n", ANYDEV);
 	fprintf(stderr, "\nExamples:\n");
-	fprintf(stderr, "%s -c -c -ta can0,123:7FF,400:700,#000000FF can2,400~7F0 can3 can8\n\n", prg);
-	fprintf(stderr, "%s -l any,0~0,#FFFFFFFF\n         (log only error frames but no(!) data frames)\n", prg);
-	fprintf(stderr, "%s -l any,0:0,#FFFFFFFF\n         (log error frames and also all data frames)\n", prg);
-	fprintf(stderr, "%s vcan2,12345678:DFFFFFFF\n         (match only for extended CAN ID 12345678)\n", prg);
-	fprintf(stderr, "%s vcan2,123:7FF\n         (matches CAN ID 123 - including EFF and RTR frames)\n", prg);
-	fprintf(stderr, "%s vcan2,123:C00007FF\n         (matches CAN ID 123 - only SFF and non-RTR frames)\n", prg);
+	fprintf(stderr, "%s -c -c -ta can0,123:7FF,400:700,#000000FF can2,400~7F0 can3 can8\n\n", progname);
+	fprintf(stderr, "%s -l any,0~0,#FFFFFFFF\n         (log only error frames but no(!) data frames)\n", progname);
+	fprintf(stderr, "%s -l any,0:0,#FFFFFFFF\n         (log error frames and also all data frames)\n", progname);
+	fprintf(stderr, "%s vcan2,12345678:DFFFFFFF\n         (match only for extended CAN ID 12345678)\n", progname);
+	fprintf(stderr, "%s vcan2,123:7FF\n         (matches CAN ID 123 - including EFF and RTR frames)\n", progname);
+	fprintf(stderr, "%s vcan2,123:C00007FF\n         (matches CAN ID 123 - only SFF and non-RTR frames)\n", progname);
 	fprintf(stderr, "\n");
 }
 
@@ -322,6 +323,8 @@ int main(int argc, char **argv)
 	last_tv.tv_sec = 0;
 	last_tv.tv_usec = 0;
 
+	progname = basename(argv[0]);
+
 	while ((opt = getopt(argc, argv, "t:HciaSs:lDdxLf:n:r:he8T:?")) != -1) {
 		switch (opt) {
 		case 't':
@@ -330,7 +333,7 @@ int main(int argc, char **argv)
 			if ((timestamp != 'a') && (timestamp != 'A') &&
 			    (timestamp != 'd') && (timestamp != 'z')) {
 				fprintf(stderr, "%s: unknown timestamp mode '%c' - ignored\n",
-					basename(argv[0]), optarg[0]);
+					progname, optarg[0]);
 				timestamp = 0;
 			}
 			if ((logtimestamp != 'a') && (logtimestamp != 'z')) {
@@ -369,7 +372,7 @@ int main(int argc, char **argv)
 		case 's':
 			silent = atoi(optarg);
 			if (silent > SILENT_ON) {
-				print_usage(basename(argv[0]));
+				print_usage();
 				exit(1);
 			}
 			break;
@@ -402,7 +405,7 @@ int main(int argc, char **argv)
 		case 'n':
 			count = atoi(optarg);
 			if (count < 1) {
-				print_usage(basename(argv[0]));
+				print_usage();
 				exit(1);
 			}
 			break;
@@ -410,7 +413,7 @@ int main(int argc, char **argv)
 		case 'r':
 			rcvbuf_size = atoi(optarg);
 			if (rcvbuf_size < 1) {
-				print_usage(basename(argv[0]));
+				print_usage();
 				exit(1);
 			}
 			break;
@@ -419,19 +422,19 @@ int main(int argc, char **argv)
 			errno = 0;
 			timeout_ms = strtol(optarg, NULL, 0);
 			if (errno != 0) {
-				print_usage(basename(argv[0]));
+				print_usage();
 				exit(1);
 			}
 			break;
 		default:
-			print_usage(basename(argv[0]));
+			print_usage();
 			exit(1);
 			break;
 		}
 	}
 
 	if (optind == argc) {
-		print_usage(basename(argv[0]));
+		print_usage();
 		exit(0);
 	}
 
-- 
2.37.4

