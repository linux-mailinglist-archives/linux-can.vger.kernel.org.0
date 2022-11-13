Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F398626E9A
	for <lists+linux-can@lfdr.de>; Sun, 13 Nov 2022 09:53:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235271AbiKMIxk (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Sun, 13 Nov 2022 03:53:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235269AbiKMIxj (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Sun, 13 Nov 2022 03:53:39 -0500
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C106E62EB
        for <linux-can@vger.kernel.org>; Sun, 13 Nov 2022 00:53:37 -0800 (PST)
Received: by mail-pl1-x634.google.com with SMTP id io19so7605854plb.8
        for <linux-can@vger.kernel.org>; Sun, 13 Nov 2022 00:53:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4/BrYRH4Ma28+8BSdOZhJJhsy5Hsgefl2U0aSnTtlac=;
        b=dt47a9WD5rQFTYj3PlGtu9W5PfpSKjTr5Aiw4n3AqFBOVq6OsgxgbOOK8KwNQSE4TO
         GdjPNizQK80sqVHlIRg3XDKxkVUgwKsaTDSc4DfvUBT6fYxqFSjd6C27RrvsBwqIxF6y
         Fl7WioTE6vwJHHC+UxcQGlQaiE6leuha7U95DAOEaufjE+eq8EBaP/OsHnXKADWjqEnR
         1o5X71C/vetmqZS5EWoZSAGuSD3am05tJQSLCa0Mz0CDr7hJKDILkGGLjftCv+3oQ0/B
         xHvYdTk6m/Qw2h9VYavcpwNksctF+f55Y8jwxjTwIgd7Mx8W20opVFpjiOuygFQR0rNJ
         /t/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=4/BrYRH4Ma28+8BSdOZhJJhsy5Hsgefl2U0aSnTtlac=;
        b=HnQRFMJiBC68zpEmHfINP5W153FvolRvL6fpbnu87jQMe/H98mUVhDFqHOj+3F54kX
         clWt6cMChOZDCgSJxolqY1Ss6OKuYDXUSoJxYPTEONYAapSMQAnRtm1qo6H8S29zBV5G
         8PYJJWF2nGb8XGLO6JadswlmmKeYb97xe0+Qiu1xTh2evmJIUQwpBVjxtNI4jNIYZoFC
         XdhX2FKno7suKU+6WSGkbMlwSD1RZqSFhc1y8h7ce9thd0EFTfMAwjEUuges4BqvLch3
         YM7ivCE12cXUENOI83mqkwbia3wt1angmxTyvBq7aT4H8XIJzu0u+KKY4qclMKFWdFr7
         HfzQ==
X-Gm-Message-State: ANoB5pl9Ebnn9v836T0ZNgG1kDoqnWUl9mudP/Qnp0AKgp0ncdN2BEr8
        Ch2oqLWbjOc3BrLqNb2SZLn8XGqz+O99dA==
X-Google-Smtp-Source: AA0mqf5w+p8Vr3xPFL05BY0TPKlw8oLaOp0ATzVO23xtuZ1mQiwKV2YHYbXtefC9S3blys5iTG0khg==
X-Received: by 2002:a17:902:9a93:b0:17f:7d9a:4952 with SMTP id w19-20020a1709029a9300b0017f7d9a4952mr9432844plp.117.1668329617022;
        Sun, 13 Nov 2022 00:53:37 -0800 (PST)
Received: from localhost.localdomain (124x33x176x97.ap124.ftth.ucom.ne.jp. [124.33.176.97])
        by smtp.gmail.com with ESMTPSA id y1-20020a626401000000b00528a097aeffsm4372391pfb.118.2022.11.13.00.53.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Nov 2022 00:53:36 -0800 (PST)
Sender: Vincent Mailhol <vincent.mailhol@gmail.com>
From:   Vincent Mailhol <mailhol.vincent@wanadoo.fr>
To:     linux-can@vger.kernel.org
Cc:     Oliver Hartkopp <socketcan@hartkopp.net>,
        Marc Kleine-Budde <mkl@pengutronix.de>,
        Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Subject: [PATCH can-utils-dev 3/5] candump: add global variable progname
Date:   Sun, 13 Nov 2022 17:53:19 +0900
Message-Id: <20221113085321.87910-4-mailhol.vincent@wanadoo.fr>
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

