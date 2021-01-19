Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 743DD2FB9E0
	for <lists+linux-can@lfdr.de>; Tue, 19 Jan 2021 15:55:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387557AbhASOi3 (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Tue, 19 Jan 2021 09:38:29 -0500
Received: from mx2.suse.de ([195.135.220.15]:48750 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387559AbhASJeB (ORCPT <rfc822;linux-can@vger.kernel.org>);
        Tue, 19 Jan 2021 04:34:01 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1611048791; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=pW9Dike2hAGxVs676V9ZqPMLNrVdbbKomWkGz8A04/E=;
        b=EQAnXgN/wKErTlE7gmpwJi8ZQz87nPHdI+gp6H8Y+/eFS+DMmos0am/+cjxPlHSPs1edJT
        BnlZkg4Jefu3FYDvxvS6pUE8alKK5h+E1Yfqes2EpxQ1d8ALN83g1hCRkT6572S/giJR8A
        qDRLcFIHDwk5CcCMrP3NDN1dbVNP/5c=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 401DFB3E8;
        Tue, 19 Jan 2021 09:33:11 +0000 (UTC)
From:   Richard Palethorpe <rpalethorpe@suse.com>
To:     ltp@lists.linux.it
Cc:     linux-can@vger.kernel.org,
        Oliver Hartkopp <socketcan@hartkopp.net>,
        Richard Palethorpe <rpalethorpe@suse.com>
Subject: [PATCH v2 4/6] can_recv_own_msgs: Convert to new library
Date:   Tue, 19 Jan 2021 09:31:41 +0000
Message-Id: <20210119093143.17222-5-rpalethorpe@suse.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210119093143.17222-1-rpalethorpe@suse.com>
References: <20210119093143.17222-1-rpalethorpe@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Behavior is approximately the same except for the following:

* Test will continue after non-fatal errors.
* We now check the return value of `setsocketopt` and that I/O
  completed the specified number of bytes.
* The command line arg, device name, must be prepended with `-D`

Signed-off-by: Richard Palethorpe <rpalethorpe@suse.com>
---
 .../can/filter-tests/can_rcv_own_msgs.c       | 273 ++++++------------
 1 file changed, 88 insertions(+), 185 deletions(-)

diff --git a/testcases/network/can/filter-tests/can_rcv_own_msgs.c b/testcases/network/can/filter-tests/can_rcv_own_msgs.c
index 8ad51d298..3726dd6f7 100644
--- a/testcases/network/can/filter-tests/can_rcv_own_msgs.c
+++ b/testcases/network/can/filter-tests/can_rcv_own_msgs.c
@@ -1,88 +1,31 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
- * tst-rcv-own-msgs.c
- *
- * Copyright (c) 2010 Volkswagen Group Electronic Research
- * All rights reserved.
- *
- * Redistribution and use in source and binary forms, with or without
- * modification, are permitted provided that the following conditions
- * are met:
- * 1. Redistributions of source code must retain the above copyright
- *    notice, this list of conditions and the following disclaimer.
- * 2. Redistributions in binary form must reproduce the above copyright
- *    notice, this list of conditions and the following disclaimer in the
- *    documentation and/or other materials provided with the distribution.
- * 3. Neither the name of Volkswagen nor the names of its contributors
- *    may be used to endorse or promote products derived from this software
- *    without specific prior written permission.
- *
- * Alternatively, provided that this notice is retained in full, this
- * software may be distributed under the terms of the GNU General
- * Public License ("GPL") version 2, in which case the provisions of the
- * GPL apply INSTEAD OF those given above.
- *
- * The provided data structures and external interfaces from this code
- * are not restricted to be used by modules with a GPL compatible license.
- *
- * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
- * "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
- * LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR
- * A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT
- * OWNER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
- * SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT
- * LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE,
- * DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY
- * THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
- * (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
- * OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH
- * DAMAGE.
- *
- * Send feedback to <socketcan-users@lists.berlios.de>
- *
+ * Copyright (c) 2011 Volkswagen Group Electronic Research
+ * Copyright (c) 2021 SUSE LLC
  */
 
-#include <stdio.h>
-#include <stdlib.h>
-#include <unistd.h>
-#include <string.h>
-
-#include <sys/types.h>
-#include <sys/socket.h>
-#include <sys/ioctl.h>
-#include <sys/time.h>
-#include <net/if.h>
 #include "config.h"
-#include "tst_res_flags.h"
-#include "tst_minmax.h"
+#include "tst_test.h"
 
 #ifdef HAVE_LINUX_CAN_H
 
-#include <linux/can.h>
-#include <linux/can/raw.h>
+#include "can_common.h"
+#include "tst_minmax.h"
 
-struct rxs {
-	int s;
-	int t;
-};
+static int s, t;
 
-struct rxs test_sockets(int s, int t, canid_t can_id)
+void test_sockets(canid_t can_id, int expect_rxs, int expect_rxt)
 {
 	fd_set rdfs;
 	struct timeval tv;
 	int m = MAX(s, t) + 1;
 	int have_rx = 1;
 	struct can_frame frame;
-	struct rxs rx;
-	int ret;
+	int rxs = 0, rxt = 0;
 
 	frame.can_id = can_id;
 	frame.can_dlc = 0;
-	if (write(s, &frame, sizeof(frame)) < 0) {
-		perror("write");
-		exit(1);
-	}
-
-	rx.s = rx.t = 0;
+	SAFE_WRITE(1, s, &frame, sizeof(frame));
 
 	while (have_rx) {
 
@@ -93,164 +36,124 @@ struct rxs test_sockets(int s, int t, canid_t can_id)
 		tv.tv_usec = 50000;	/* 50ms timeout */
 		have_rx = 0;
 
-		ret = select(m, &rdfs, NULL, NULL, &tv);
-		if (ret < 0) {
-			perror("select");
-			exit(1);
-		}
+		if (select(m, &rdfs, NULL, NULL, &tv) < 0)
+			tst_brk(TBROK | TERRNO, "select");
 
 		if (FD_ISSET(s, &rdfs)) {
 
 			have_rx = 1;
-			ret = read(s, &frame, sizeof(struct can_frame));
-			if (ret < 0) {
-				perror("read");
-				exit(1);
-			}
-			if (frame.can_id != can_id) {
-				fprintf(stderr, "received wrong can_id!\n");
-				exit(1);
-			}
-			rx.s++;
+			SAFE_READ(1, s, &frame, sizeof(struct can_frame));
+
+			if (frame.can_id != can_id)
+				tst_res(TFAIL, "received wrong can_id!");
+
+			rxs++;
 		}
 
 		if (FD_ISSET(t, &rdfs)) {
 
 			have_rx = 1;
-			ret = read(t, &frame, sizeof(struct can_frame));
-			if (ret < 0) {
-				perror("read");
-				exit(1);
-			}
-			if (frame.can_id != can_id) {
-				fprintf(stderr, "received wrong can_id!\n");
-				exit(1);
-			}
-			rx.t++;
+			SAFE_READ(1, t, &frame, sizeof(struct can_frame));
+
+			if (frame.can_id != can_id)
+				tst_res(TFAIL, "received wrong can_id!");
+
+			rxt++;
 		}
 	}
 
 	/* timeout */
 
-	return rx;
+	tst_res(rxs == expect_rxs && rxt == expect_rxt ? TPASS : TFAIL,
+		"s received %d of %d, t received %d of %d",
+		rxs, expect_rxs, rxt, expect_rxt);
 }
 
-void setopts(int s, int loopback, int recv_own_msgs)
+static void setopts(int loopback, int recv_own_msgs)
 {
-	setsockopt(s, SOL_CAN_RAW, CAN_RAW_LOOPBACK, &loopback,
-		   sizeof(loopback));
-	setsockopt(s, SOL_CAN_RAW, CAN_RAW_RECV_OWN_MSGS, &recv_own_msgs,
-		   sizeof(recv_own_msgs));
+	SAFE_SETSOCKOPT(s, SOL_CAN_RAW, CAN_RAW_LOOPBACK, &loopback,
+			sizeof(loopback));
+	SAFE_SETSOCKOPT(s, SOL_CAN_RAW, CAN_RAW_RECV_OWN_MSGS, &recv_own_msgs,
+			sizeof(recv_own_msgs));
 
-	printf("check loopback %d recv_own_msgs %d ... ", loopback,
-	       recv_own_msgs);
+	tst_res(TINFO, "set loopback = %d, recv_own_msgs = %d",
+		loopback, recv_own_msgs);
 }
 
-int main(int argc, char **argv)
+static void setup(void)
 {
-	int s, t;
 	struct sockaddr_can addr;
 	struct ifreq ifr;
-	struct rxs rx;
 
-	/* check command line options */
-	if (argc != 2) {
-		fprintf(stderr, "Usage: %s <device>\n", argv[0]);
-		return TFAIL;
-	}
+	can_setup_vcan();
 
-	s = socket(PF_CAN, SOCK_RAW, CAN_RAW);
-	if (s < 0) {
-		perror("socket");
-		return TFAIL;
-	}
-	t = socket(PF_CAN, SOCK_RAW, CAN_RAW);
-	if (t < 0) {
-		perror("socket");
-		return TFAIL;
-	}
+	s = SAFE_SOCKET(PF_CAN, SOCK_RAW, CAN_RAW);
+	t = SAFE_SOCKET(PF_CAN, SOCK_RAW, CAN_RAW);
+
+	strcpy(ifr.ifr_name, can_dev_name);
+	SAFE_IOCTL(s, SIOCGIFINDEX, &ifr);
 
-	strcpy(ifr.ifr_name, argv[1]);
-	if (ioctl(s, SIOCGIFINDEX, &ifr) < 0) {
-		perror("SIOCGIFINDEX");
-		return TFAIL;
-	}
 	addr.can_ifindex = ifr.ifr_ifindex;
 	addr.can_family = AF_CAN;
 
-	if (bind(s, (struct sockaddr *)&addr, sizeof(addr)) < 0) {
-		perror("bind");
-		return TFAIL;
-	}
-	if (bind(t, (struct sockaddr *)&addr, sizeof(addr)) < 0) {
-		perror("bind");
-		return TFAIL;
-	}
+	SAFE_BIND(s, (struct sockaddr *)&addr, sizeof(addr));
+	SAFE_BIND(t, (struct sockaddr *)&addr, sizeof(addr));
+}
 
-	printf("Starting PF_CAN frame flow test.\n");
-	printf("checking socket default settings ... ");
-	rx = test_sockets(s, t, 0x340);
-	if (rx.s == 0 && rx.t == 1)
-		printf("ok.\n");
-	else {
-		printf("failure!\n");
-		return TFAIL;
-	}
+static void cleanup(void)
+{
+	if (s)
+		SAFE_CLOSE(s);
+	if (t)
+		SAFE_CLOSE(t);
 
-	/* check loopback 0 recv_own_msgs 0 */
-	setopts(s, 0, 0);
-	rx = test_sockets(s, t, 0x341);
-	if (rx.s == 0 && rx.t == 0)
-		printf("ok.\n");
-	else {
-		printf("failure!\n");
-		return TFAIL;
-	}
+	can_cleanup_vcan();
+}
 
-	/* check loopback 0 recv_own_msgs 1 */
-	setopts(s, 0, 1);
-	rx = test_sockets(s, t, 0x342);
-	if (rx.s == 0 && rx.t == 0)
-		printf("ok.\n");
-	else {
-		printf("failure!\n");
-		return TFAIL;
-	}
+static void run(void)
+{
+	tst_res(TINFO, "Starting PF_CAN frame flow test.");
+	tst_res(TINFO, "checking socket default settings");
+	test_sockets(0x340, 0, 1);
 
-	/* check loopback 1 recv_own_msgs 0 */
-	setopts(s, 1, 0);
-	rx = test_sockets(s, t, 0x343);
-	if (rx.s == 0 && rx.t == 1)
-		printf("ok.\n");
-	else {
-		printf("failure!\n");
-		return TFAIL;
-	}
+	setopts(0, 0);
+	test_sockets(0x341, 0, 0);
 
-	/* check loopback 1 recv_own_msgs 1 */
-	setopts(s, 1, 1);
-	rx = test_sockets(s, t, 0x344);
-	if (rx.s == 1 && rx.t == 1)
-		printf("ok.\n");
-	else {
-		printf("failure!\n");
-		return TFAIL;
-	}
+	setopts(0, 1);
+	test_sockets(0x342, 0, 0);
 
-	printf("PF_CAN frame flow test was successful.\n");
+	setopts(1, 0);
+	test_sockets(0x343, 0, 1);
 
-	close(s);
-	close(t);
+	setopts(1, 1);
+	test_sockets(0x344, 1, 1);
 
-	return TPASS;
+	/* Return to defaults for when -i is used */
+	setopts(1, 0);
 }
 
+static struct tst_test test = {
+	.options = (struct tst_option[]) {
+		{"D:", &can_dev_name, "-D <device>	CAN device name"},
+		{}
+	},
+	.setup = setup,
+	.cleanup = cleanup,
+	.test_all = run,
+	.caps = (struct tst_cap []) {
+		TST_CAP(TST_CAP_REQ, CAP_NET_RAW),
+		TST_CAP(TST_CAP_DROP, CAP_SYS_ADMIN),
+		{}
+	},
+	.needs_drivers = (const char *const[]) {
+		"vcan",
+		"can-raw",
+		NULL
+	}
+};
+
 #else
 
-int main(void)
-{
-	printf("The linux/can.h was missing upon compilation.\n");
-	return TCONF;
-}
+TST_TEST_TCONF("The linux/can.h was missing upon compilation");
 
 #endif /* HAVE_LINUX_CAN_H */
-- 
2.29.2

