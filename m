Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6406362706C
	for <lists+linux-can@lfdr.de>; Sun, 13 Nov 2022 17:19:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235231AbiKMQTH (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Sun, 13 Nov 2022 11:19:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235223AbiKMQTG (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Sun, 13 Nov 2022 11:19:06 -0500
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2908A101D0
        for <linux-can@vger.kernel.org>; Sun, 13 Nov 2022 08:19:05 -0800 (PST)
Received: by mail-pg1-x52d.google.com with SMTP id 136so8322998pga.1
        for <linux-can@vger.kernel.org>; Sun, 13 Nov 2022 08:19:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=W3grp5z/Xwm4jGUqsJHkNRd1U8+QZQQAXgv6dYfDIZA=;
        b=jnQe0doPzDbZKqnKDAcpXPgdAtsqolpcy+Ezq93v8LpVl0Zmw2UxTZM6oaCLyATWdC
         aB3Y95RRIvkKGbawkS88K2zQgIKpbbGNlPFWZhpa/TpE4ETGjDcY2bOLGB/rDcCMBnAG
         EZnSNR92TjBYJOZeu554evlsRJBaeQvRvUI5R0HyK19UgpknnAh2NhZlDyMryDd0TpDy
         4si5eyR/tj+Jqky55isJFkFuzFyebszvyUpU4bvl3CzjSkDxKz5VpuZQnv/OV8AlyzRh
         dlubEZ7N3aZwMNk4ph6hl5xHzgxiJ81qjA9Alvrt5DYxq3XeQZ445yWU4i1kBQUKwbHl
         P6+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=W3grp5z/Xwm4jGUqsJHkNRd1U8+QZQQAXgv6dYfDIZA=;
        b=waAX7Wf49GQSxeyiYxp4Yj8oUO4J2oiMJ5W8N1ztH8vB9zZ42DmDWzc5hxQFGYuBsm
         2Ml3FlaO2eCenjAEeM1qwxxq/vp25zxV0dfgU9DFRZBcfa6IsDv/EHcV43anZx0Efee/
         XdEeFbxVPDHxU7PeamSNp8n9T1gS/sblZlTPWINcZPqq3IfCyN0YStltDWsOUXkMERrY
         mXdZwCyzHWz424KasOedp4IyCKkCkZ7YgA0QDDkF3rAkG4rENl6Jgs6cVuko6Q1OugTF
         IyDfW4NkXRuVs6qW+Vo8EHLM9JHnwqClusna5mHjZFYuIzaV61MFlUHaG3AJbhTF2JJC
         S7Ig==
X-Gm-Message-State: ANoB5pnehnXjgI7S0nGnXqpL0TFFHoludRI1YBwr/PzLU630xqrgTr+6
        MdEIARBDOUO0Q/BTQERMd+s5udX3LcZhCw==
X-Google-Smtp-Source: AA0mqf4GQq08/yHnpn2QqPycudKU6e5B4eZMMHpDs48F5ujdWKVqvbxJFsMJoI8p5Lz78o5fJaVOlA==
X-Received: by 2002:a63:b52:0:b0:470:4320:ef39 with SMTP id a18-20020a630b52000000b004704320ef39mr8766098pgl.381.1668356344408;
        Sun, 13 Nov 2022 08:19:04 -0800 (PST)
Received: from localhost.localdomain (124x33x176x97.ap124.ftth.ucom.ne.jp. [124.33.176.97])
        by smtp.gmail.com with ESMTPSA id 192-20020a6217c9000000b0056c04dee930sm4863558pfx.120.2022.11.13.08.19.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Nov 2022 08:19:04 -0800 (PST)
Sender: Vincent Mailhol <vincent.mailhol@gmail.com>
From:   Vincent Mailhol <mailhol.vincent@wanadoo.fr>
To:     linux-can@vger.kernel.org
Cc:     Oliver Hartkopp <socketcan@hartkopp.net>,
        Marc Kleine-Budde <mkl@pengutronix.de>,
        Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Subject: [PATCH can-utils-dev v2 4/5] candump: add global variable progname
Date:   Mon, 14 Nov 2022 01:18:30 +0900
Message-Id: <20221113161831.16388-5-mailhol.vincent@wanadoo.fr>
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

Instead of using argv[0] several times, make the progname a global
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

