Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CE648308AE9
	for <lists+linux-can@lfdr.de>; Fri, 29 Jan 2021 18:09:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231426AbhA2RFD (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Fri, 29 Jan 2021 12:05:03 -0500
Received: from mx2.suse.de ([195.135.220.15]:50004 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231156AbhA2REn (ORCPT <rfc822;linux-can@vger.kernel.org>);
        Fri, 29 Jan 2021 12:04:43 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1611939835; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=yJMJzxmzdfbppjTNuISv47ufBhOcZ9rtOQRc9uJYO4k=;
        b=CY0W/OX7YrDW1K2BoaHAx9NV8EXBEVet40+3RmNltwiD0zwWUv1litf9zZF+N0JCUHKMPv
        BQgAfGlrKgu0e1i9H6r9WajHDI3XyAXA4lLusUaplTRk9il2oh5oqnH7vURg7JBbNV5o5f
        ImkqX7ChdWtvk264wrnxp430We3bD2I=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id E2A12AD6A;
        Fri, 29 Jan 2021 17:03:54 +0000 (UTC)
From:   Richard Palethorpe <rpalethorpe@suse.com>
To:     ltp@lists.linux.it
Cc:     linux-can@vger.kernel.org,
        Oliver Hartkopp <socketcan@hartkopp.net>,
        Richard Palethorpe <rpalethorpe@suse.com>,
        Cyril Hrubis <chrubis@suse.cz>, Petr Vorel <pvorel@suse.cz>
Subject: [PATCH v4 4/7] can_filter: Convert to new library
Date:   Fri, 29 Jan 2021 17:03:02 +0000
Message-Id: <20210129170305.27383-5-rpalethorpe@suse.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210129170305.27383-1-rpalethorpe@suse.com>
References: <20210129170305.27383-1-rpalethorpe@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Behavior is mostly the same, but on some errors we print fail and
continue instead of exiting immediately. It appears this would result
in more information being printed if there is a failure.

Signed-off-by: Richard Palethorpe <rpalethorpe@suse.com>
Reviewed-by: Cyril Hrubis <chrubis@suse.cz>
Reviewed-by: Petr Vorel <pvorel@suse.cz>
Acked-by: Oliver Hartkopp <socketcan@hartkopp.net>
---
 .../network/can/filter-tests/can_filter.c     | 317 +++++++-----------
 1 file changed, 124 insertions(+), 193 deletions(-)

diff --git a/testcases/network/can/filter-tests/can_filter.c b/testcases/network/can/filter-tests/can_filter.c
index db017451a..7377556cb 100644
--- a/testcases/network/can/filter-tests/can_filter.c
+++ b/testcases/network/can/filter-tests/can_filter.c
@@ -1,63 +1,15 @@
+// SPDX-License-Identifier: (GPL-2.0-only OR BSD-3-Clause)
 /*
- * tst-filter.c
- *
  * Copyright (c) 2011 Volkswagen Group Electronic Research
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
+#include "tst_test.h"
 
 #ifdef HAVE_LINUX_CAN_H
 
-#include <linux/can.h>
-#include <linux/can/raw.h>
+#include "can_common.h"
 
 #define ID 0x123
 #define TC 18			/* # of testcases */
@@ -66,7 +18,9 @@ const int rx_res[TC] = { 4, 4, 4, 4, 2, 2, 2, 2, 2, 2, 2, 2, 1, 1, 1, 1, 1, 1 };
 const int rxbits_res[TC] = { 4369, 4369, 4369, 4369, 17, 4352, 17, 4352, 257,
 			     257, 4112, 4112, 1, 256, 16, 4096, 1, 256 };
 
-canid_t calc_id(int testcase)
+static int s;
+
+static canid_t calc_id(int testcase)
 {
 	canid_t id = ID;
 
@@ -78,7 +32,7 @@ canid_t calc_id(int testcase)
 	return id;
 }
 
-canid_t calc_mask(int testcase)
+static canid_t calc_mask(int testcase)
 {
 	canid_t mask = CAN_SFF_MASK;
 
@@ -93,174 +47,151 @@ canid_t calc_mask(int testcase)
 	return mask;
 }
 
-int main(int argc, char **argv)
+static void setup(void)
 {
-	fd_set rdfs;
-	struct timeval tv;
-	int s;
 	struct sockaddr_can addr;
-	struct can_filter rfilter;
-	struct can_frame frame;
-	int testcase;
-	int have_rx;
-	int rx;
-	int rxbits, rxbitval;
-	int ret;
-	int recv_own_msgs = 1;
 	struct ifreq ifr;
+	int recv_own_msgs = 1;
 
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
+	s = SAFE_SOCKET(PF_CAN, SOCK_RAW, CAN_RAW);
+
+	strcpy(ifr.ifr_name, can_dev_name);
+	SAFE_IOCTL(s, SIOCGIFINDEX, &ifr);
 
-	strcpy(ifr.ifr_name, argv[1]);
-	if (ioctl(s, SIOCGIFINDEX, &ifr) < 0) {
-		perror("SIOCGIFINDEX");
-		return TFAIL;
-	}
 	addr.can_family = AF_CAN;
 	addr.can_ifindex = ifr.ifr_ifindex;
 
-	setsockopt(s, SOL_CAN_RAW, CAN_RAW_RECV_OWN_MSGS,
-		   &recv_own_msgs, sizeof(recv_own_msgs));
+	SAFE_SETSOCKOPT(s, SOL_CAN_RAW, CAN_RAW_RECV_OWN_MSGS,
+			&recv_own_msgs, sizeof(recv_own_msgs));
 
-	if (bind(s, (struct sockaddr *)&addr, sizeof(addr)) < 0) {
-		perror("bind");
-		return TFAIL;
-	}
+	SAFE_BIND(s, (struct sockaddr *)&addr, sizeof(addr));
+}
 
-	printf("---\n");
+static void cleanup(void)
+{
+	if (s)
+		SAFE_CLOSE(s);
 
-	for (testcase = 0; testcase < TC; testcase++) {
+	can_cleanup_vcan();
+}
 
-		rfilter.can_id = calc_id(testcase);
-		rfilter.can_mask = calc_mask(testcase);
-		setsockopt(s, SOL_CAN_RAW, CAN_RAW_FILTER,
-			   &rfilter, sizeof(rfilter));
+static void run(unsigned int n)
+{
+	fd_set rdfs;
+	struct timeval tv;
+	struct can_frame frame;
+	static struct can_filter rfilter;
+	int testcase = n;
+	int have_rx = 1;
+	int rx = 0;
+	int rxbits = 0, rxbitval;
 
-		printf("testcase %2d filters : can_id = 0x%08X can_mask = "
-		       "0x%08X\n", testcase, rfilter.can_id, rfilter.can_mask);
+	rfilter.can_id = calc_id(testcase);
+	rfilter.can_mask = calc_mask(testcase);
+	SAFE_SETSOCKOPT(s, SOL_CAN_RAW, CAN_RAW_FILTER,
+			&rfilter, sizeof(rfilter));
 
-		printf("testcase %2d sending patterns ... ", testcase);
+	tst_res(TINFO, "testcase %2d filters : can_id = 0x%08X can_mask = "
+	       "0x%08X", testcase, rfilter.can_id, rfilter.can_mask);
 
-		frame.can_dlc = 1;
-		frame.data[0] = testcase;
+	tst_res(TINFO, "testcase %2d sending patterns ... ", testcase);
 
-		frame.can_id = ID;
-		if (write(s, &frame, sizeof(frame)) < 0) {
-			perror("write");
-			exit(1);
-		}
-		frame.can_id = (ID | CAN_RTR_FLAG);
-		if (write(s, &frame, sizeof(frame)) < 0) {
-			perror("write");
-			exit(1);
-		}
-		frame.can_id = (ID | CAN_EFF_FLAG);
-		if (write(s, &frame, sizeof(frame)) < 0) {
-			perror("write");
-			exit(1);
-		}
-		frame.can_id = (ID | CAN_EFF_FLAG | CAN_RTR_FLAG);
-		if (write(s, &frame, sizeof(frame)) < 0) {
-			perror("write");
-			exit(1);
-		}
+	frame.can_dlc = 1;
+	frame.data[0] = testcase;
 
-		printf("ok\n");
+	frame.can_id = ID;
+	SAFE_WRITE(1, s, &frame, sizeof(frame));
 
-		have_rx = 1;
-		rx = 0;
-		rxbits = 0;
+	frame.can_id = (ID | CAN_RTR_FLAG);
+	SAFE_WRITE(1, s, &frame, sizeof(frame));
 
-		while (have_rx) {
+	frame.can_id = (ID | CAN_EFF_FLAG);
+	SAFE_WRITE(1, s, &frame, sizeof(frame));
 
-			have_rx = 0;
-			FD_ZERO(&rdfs);
-			FD_SET(s, &rdfs);
-			tv.tv_sec = 0;
-			tv.tv_usec = 50000;	/* 50ms timeout */
+	frame.can_id = (ID | CAN_EFF_FLAG | CAN_RTR_FLAG);
+	SAFE_WRITE(1, s, &frame, sizeof(frame));
 
-			ret = select(s + 1, &rdfs, NULL, NULL, &tv);
-			if (ret < 0) {
-				perror("select");
-				exit(1);
-			}
+	tst_res(TPASS, "testcase %2d Sent patterns", testcase);
+
+	while (have_rx) {
+
+		have_rx = 0;
+		FD_ZERO(&rdfs);
+		FD_SET(s, &rdfs);
+		tv.tv_sec = 0;
+		tv.tv_usec = 50000;	/* 50ms timeout */
+
+		if (select(s + 1, &rdfs, NULL, NULL, &tv) < 0)
+			tst_brk(TBROK | TERRNO, "select");
 
-			if (FD_ISSET(s, &rdfs)) {
-				have_rx = 1;
-				ret = read(s, &frame, sizeof(struct can_frame));
-				if (ret < 0) {
-					perror("read");
-					exit(1);
-				}
-				if ((frame.can_id & CAN_SFF_MASK) != ID) {
-					fprintf(stderr,
-						"received wrong can_id!\n");
-					exit(1);
-				}
-				if (frame.data[0] != testcase) {
-					fprintf(stderr,
-						"received wrong testcase!\n");
-					exit(1);
-				}
-
-				/* test & calc rxbits */
-				rxbitval = 1 << ((frame.can_id &
-						 (CAN_EFF_FLAG | CAN_RTR_FLAG |
-						  CAN_ERR_FLAG)) >> 28);
-
-				/* only receive a rxbitval once */
-				if ((rxbits & rxbitval) == rxbitval) {
-					fprintf(stderr,
-						"received rxbitval %d twice!\n",
-						rxbitval);
-					exit(1);
-				}
-				rxbits |= rxbitval;
-				rx++;
-
-				printf("testcase %2d rx : can_id = 0x%08X rx = "
-				       "%d rxbits = %d\n", testcase,
-				       frame.can_id, rx, rxbits);
+		if (FD_ISSET(s, &rdfs)) {
+			have_rx = 1;
+			SAFE_READ(1, s, &frame, sizeof(struct can_frame));
+
+			if ((frame.can_id & CAN_SFF_MASK) != ID)
+				tst_res(TFAIL, "received wrong can_id!");
+
+			if (frame.data[0] != testcase)
+				tst_res(TFAIL, "received wrong testcase!");
+
+			/* test & calc rxbits */
+			rxbitval = 1 << ((frame.can_id &
+					  (CAN_EFF_FLAG | CAN_RTR_FLAG |
+					   CAN_ERR_FLAG)) >> 28);
+
+			/* only receive a rxbitval once */
+			if ((rxbits & rxbitval) == rxbitval) {
+				tst_res(TFAIL, "received rxbitval %d twice!",
+					rxbitval);
 			}
+			rxbits |= rxbitval;
+			rx++;
+
+			tst_res(TINFO, "testcase %2d rx : can_id = 0x%08X rx = "
+			       "%d rxbits = %d", testcase,
+			       frame.can_id, rx, rxbits);
 		}
-		/* rx timed out -> check the received results */
-		if (rx_res[testcase] != rx) {
-			fprintf(stderr,
-				"wrong rx value in testcase %d : %d (expected "
-				"%d)\n", testcase, rx, rx_res[testcase]);
-			exit(1);
-		}
-		if (rxbits_res[testcase] != rxbits) {
-			fprintf(stderr,
-				"wrong rxbits value in testcase %d : %d "
-				"(expected %d)\n", testcase, rxbits,
-				rxbits_res[testcase]);
-			exit(1);
-		}
-		printf("testcase %2d ok\n---\n", testcase);
 	}
-
-	close(s);
-
-	return TPASS;
+	/* rx timed out -> check the received results */
+	if (rx_res[testcase] != rx) {
+		tst_brk(TBROK,
+			"wrong rx value in testcase %d : %d (expected "
+			"%d)", testcase, rx, rx_res[testcase]);
+	}
+	if (rxbits_res[testcase] != rxbits) {
+		tst_brk(TBROK,
+			"wrong rxbits value in testcase %d : %d "
+			"(expected %d)", testcase, rxbits,
+			rxbits_res[testcase]);
+	}
+	tst_res(TPASS, "testcase %2d ok", testcase);
 }
 
+static struct tst_test test = {
+	.tcnt = TC,
+	.options = (struct tst_option[]) {
+		{"D:", &can_dev_name, "-D <device>	CAN device name"},
+		{}
+	},
+	.setup = setup,
+	.cleanup = cleanup,
+	.test = run,
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
2.30.0

