Return-Path: <linux-can+bounces-3659-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B6CEAC077B
	for <lists+linux-can@lfdr.de>; Thu, 22 May 2025 10:45:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 382401BC54F0
	for <lists+linux-can@lfdr.de>; Thu, 22 May 2025 08:43:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 621D628A1EA;
	Thu, 22 May 2025 08:41:50 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA462286D72
	for <linux-can@vger.kernel.org>; Thu, 22 May 2025 08:41:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747903310; cv=none; b=rnmPTNgm/swVIndLUEUyP9kODnJ8AfDKg9rl1qQsXKtoqZJPMpSAF/syHiIKhyzkbLNjQJ2wDbuhxpOxQ1aHVnBTgs12nSp6FgPu2F6UO2Ka+gvQKJ7EbRqRed4khXFLemnWpQgsFRZ/a1CxS5g657rfuMgVQOjC+GTv9gjul6A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747903310; c=relaxed/simple;
	bh=qsNMyKsxpvliV8HnG0KrMBbbKdQj0oxHuI/9A2KtnCA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aJueNfF4kL6p30Vc/bXSjMzuQcMossd+i+e9KKYnBU4MYI8n2dQuxm4geBqToZyQ/kj8KJP/NAaSsVdf4WizvTE9Rvc6ag6Z1hsd1sZ11SDbSNPmEGCrgcPO+PjIRX24SsPr7yjJHi9/NyLqVY1Dqo33mFCd6lP6C1TL/aT1bwQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1uI1Um-0006Id-CQ
	for linux-can@vger.kernel.org; Thu, 22 May 2025 10:41:44 +0200
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1uI1Uj-000hr7-1M
	for linux-can@vger.kernel.org;
	Thu, 22 May 2025 10:41:41 +0200
Received: from dspam.blackshift.org (localhost [127.0.0.1])
	by bjornoya.blackshift.org (Postfix) with SMTP id 21510417373
	for <linux-can@vger.kernel.org>; Thu, 22 May 2025 08:41:41 +0000 (UTC)
Received: from hardanger.blackshift.org (unknown [172.20.34.65])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by bjornoya.blackshift.org (Postfix) with ESMTPS id 50224417342;
	Thu, 22 May 2025 08:41:39 +0000 (UTC)
Received: from blackshift.org (localhost [::1])
	by hardanger.blackshift.org (OpenSMTPD) with ESMTP id c37479cb;
	Thu, 22 May 2025 08:41:31 +0000 (UTC)
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	linux-can@vger.kernel.org,
	kernel@pengutronix.de,
	Felix Maurer <fmaurer@redhat.com>,
	Vincent Mailhol <mailhol.vincent@wanadoo.fr>,
	Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH net-next 21/22] selftests: can: Import tst-filter from can-tests
Date: Thu, 22 May 2025 10:36:49 +0200
Message-ID: <20250522084128.501049-22-mkl@pengutronix.de>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250522084128.501049-1-mkl@pengutronix.de>
References: <20250522084128.501049-1-mkl@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org

From: Felix Maurer <fmaurer@redhat.com>

Tests for the can subsystem have been in the can-tests repository[1] so
far. Start moving the tests to kernel selftests by importing the current
tst-filter test. The test is now named test_raw_filter and is substantially
updated to be more aligned with the kernel selftests, follow the coding
style, and simplify the validation of received CAN frames. We also include
documentation of the test design. The test verifies that the single filters
on raw CAN sockets work as expected.

We intend to import more tests from can-tests and add additional test cases
in the future. The goal of moving the CAN selftests into the tree is to
align the tests more closely with the kernel, improve testing of CAN in
general, and to simplify running the tests automatically in the various
kernel CI systems.

[1]: https://github.com/linux-can/can-tests

Signed-off-by: Felix Maurer <fmaurer@redhat.com>
Reviewed-by: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Link: https://patch.msgid.link/87d289f333cba7bbcc9d69173ea1c320e4b5c3b8.1747833283.git.fmaurer@redhat.com
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 MAINTAINERS                                   |   2 +
 tools/testing/selftests/Makefile              |   1 +
 tools/testing/selftests/net/can/.gitignore    |   2 +
 tools/testing/selftests/net/can/Makefile      |  11 +
 .../selftests/net/can/test_raw_filter.c       | 405 ++++++++++++++++++
 .../selftests/net/can/test_raw_filter.sh      |  37 ++
 6 files changed, 458 insertions(+)
 create mode 100644 tools/testing/selftests/net/can/.gitignore
 create mode 100644 tools/testing/selftests/net/can/Makefile
 create mode 100644 tools/testing/selftests/net/can/test_raw_filter.c
 create mode 100755 tools/testing/selftests/net/can/test_raw_filter.sh

diff --git a/MAINTAINERS b/MAINTAINERS
index c8e91820b527..f08378409e34 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -5267,6 +5267,7 @@ F:	include/uapi/linux/can/isotp.h
 F:	include/uapi/linux/can/raw.h
 F:	net/can/
 F:	net/sched/em_canid.c
+F:	tools/testing/selftests/net/can/
 
 CAN-J1939 NETWORK LAYER
 M:	Robin van der Gracht <robin@protonic.nl>
@@ -17042,6 +17043,7 @@ X:	net/ceph/
 X:	net/mac80211/
 X:	net/rfkill/
 X:	net/wireless/
+X:	tools/testing/selftests/net/can/
 
 NETWORKING [IPSEC]
 M:	Steffen Klassert <steffen.klassert@secunet.com>
diff --git a/tools/testing/selftests/Makefile b/tools/testing/selftests/Makefile
index a0a6ba47d600..a62bd8e3a52e 100644
--- a/tools/testing/selftests/Makefile
+++ b/tools/testing/selftests/Makefile
@@ -66,6 +66,7 @@ TARGETS += mseal_system_mappings
 TARGETS += nci
 TARGETS += net
 TARGETS += net/af_unix
+TARGETS += net/can
 TARGETS += net/forwarding
 TARGETS += net/hsr
 TARGETS += net/mptcp
diff --git a/tools/testing/selftests/net/can/.gitignore b/tools/testing/selftests/net/can/.gitignore
new file mode 100644
index 000000000000..764a53fc837f
--- /dev/null
+++ b/tools/testing/selftests/net/can/.gitignore
@@ -0,0 +1,2 @@
+# SPDX-License-Identifier: GPL-2.0-only
+test_raw_filter
diff --git a/tools/testing/selftests/net/can/Makefile b/tools/testing/selftests/net/can/Makefile
new file mode 100644
index 000000000000..5b82e60a03e7
--- /dev/null
+++ b/tools/testing/selftests/net/can/Makefile
@@ -0,0 +1,11 @@
+# SPDX-License-Identifier: GPL-2.0
+
+top_srcdir = ../../../../..
+
+CFLAGS += -Wall -Wl,--no-as-needed -O2 -g -I$(top_srcdir)/usr/include $(KHDR_INCLUDES)
+
+TEST_PROGS := test_raw_filter.sh
+
+TEST_GEN_FILES := test_raw_filter
+
+include ../../lib.mk
diff --git a/tools/testing/selftests/net/can/test_raw_filter.c b/tools/testing/selftests/net/can/test_raw_filter.c
new file mode 100644
index 000000000000..4101c36390fd
--- /dev/null
+++ b/tools/testing/selftests/net/can/test_raw_filter.c
@@ -0,0 +1,405 @@
+// SPDX-License-Identifier: (GPL-2.0-only OR BSD-3-Clause)
+/*
+ * Copyright (c) 2011 Volkswagen Group Electronic Research
+ * All rights reserved.
+ */
+
+#include <stdio.h>
+#include <stdlib.h>
+#include <unistd.h>
+#include <string.h>
+
+#include <sys/types.h>
+#include <sys/socket.h>
+#include <sys/ioctl.h>
+#include <sys/time.h>
+#include <net/if.h>
+#include <linux/if.h>
+
+#include <linux/can.h>
+#include <linux/can/raw.h>
+
+#include "../../kselftest_harness.h"
+
+#define ID 0x123
+
+char CANIF[IFNAMSIZ];
+
+static int send_can_frames(int sock, int testcase)
+{
+	struct can_frame frame;
+
+	frame.can_dlc = 1;
+	frame.data[0] = testcase;
+
+	frame.can_id = ID;
+	if (write(sock, &frame, sizeof(frame)) < 0)
+		goto write_err;
+
+	frame.can_id = (ID | CAN_RTR_FLAG);
+	if (write(sock, &frame, sizeof(frame)) < 0)
+		goto write_err;
+
+	frame.can_id = (ID | CAN_EFF_FLAG);
+	if (write(sock, &frame, sizeof(frame)) < 0)
+		goto write_err;
+
+	frame.can_id = (ID | CAN_EFF_FLAG | CAN_RTR_FLAG);
+	if (write(sock, &frame, sizeof(frame)) < 0)
+		goto write_err;
+
+	return 0;
+
+write_err:
+	perror("write");
+	return 1;
+}
+
+FIXTURE(can_filters) {
+	int sock;
+};
+
+FIXTURE_SETUP(can_filters)
+{
+	struct sockaddr_can addr;
+	struct ifreq ifr;
+	int recv_own_msgs = 1;
+	int s, ret;
+
+	s = socket(PF_CAN, SOCK_RAW, CAN_RAW);
+	ASSERT_GE(s, 0)
+		TH_LOG("failed to create CAN_RAW socket: %d", errno);
+
+	strncpy(ifr.ifr_name, CANIF, sizeof(ifr.ifr_name));
+	ret = ioctl(s, SIOCGIFINDEX, &ifr);
+	ASSERT_GE(ret, 0)
+		TH_LOG("failed SIOCGIFINDEX: %d", errno);
+
+	addr.can_family = AF_CAN;
+	addr.can_ifindex = ifr.ifr_ifindex;
+
+	setsockopt(s, SOL_CAN_RAW, CAN_RAW_RECV_OWN_MSGS,
+		   &recv_own_msgs, sizeof(recv_own_msgs));
+
+	ret = bind(s, (struct sockaddr *)&addr, sizeof(addr));
+	ASSERT_EQ(ret, 0)
+		TH_LOG("failed bind socket: %d", errno);
+
+	self->sock = s;
+}
+
+FIXTURE_TEARDOWN(can_filters)
+{
+	close(self->sock);
+}
+
+FIXTURE_VARIANT(can_filters) {
+	int testcase;
+	canid_t id;
+	canid_t mask;
+	int exp_num_rx;
+	canid_t exp_flags[];
+};
+
+/* Receive all frames when filtering for the ID in standard frame format */
+FIXTURE_VARIANT_ADD(can_filters, base) {
+	.testcase = 1,
+	.id = ID,
+	.mask = CAN_SFF_MASK,
+	.exp_num_rx = 4,
+	.exp_flags = {
+		0,
+		CAN_RTR_FLAG,
+		CAN_EFF_FLAG,
+		CAN_EFF_FLAG | CAN_RTR_FLAG,
+	},
+};
+
+/* Ignore EFF flag in filter ID if not covered by filter mask */
+FIXTURE_VARIANT_ADD(can_filters, base_eff) {
+	.testcase = 2,
+	.id = ID | CAN_EFF_FLAG,
+	.mask = CAN_SFF_MASK,
+	.exp_num_rx = 4,
+	.exp_flags = {
+		0,
+		CAN_RTR_FLAG,
+		CAN_EFF_FLAG,
+		CAN_EFF_FLAG | CAN_RTR_FLAG,
+	},
+};
+
+/* Ignore RTR flag in filter ID if not covered by filter mask */
+FIXTURE_VARIANT_ADD(can_filters, base_rtr) {
+	.testcase = 3,
+	.id = ID | CAN_RTR_FLAG,
+	.mask = CAN_SFF_MASK,
+	.exp_num_rx = 4,
+	.exp_flags = {
+		0,
+		CAN_RTR_FLAG,
+		CAN_EFF_FLAG,
+		CAN_EFF_FLAG | CAN_RTR_FLAG,
+	},
+};
+
+/* Ignore EFF and RTR flags in filter ID if not covered by filter mask */
+FIXTURE_VARIANT_ADD(can_filters, base_effrtr) {
+	.testcase = 4,
+	.id = ID | CAN_EFF_FLAG | CAN_RTR_FLAG,
+	.mask = CAN_SFF_MASK,
+	.exp_num_rx = 4,
+	.exp_flags = {
+		0,
+		CAN_RTR_FLAG,
+		CAN_EFF_FLAG,
+		CAN_EFF_FLAG | CAN_RTR_FLAG,
+	},
+};
+
+/* Receive only SFF frames when expecting no EFF flag */
+FIXTURE_VARIANT_ADD(can_filters, filter_eff) {
+	.testcase = 5,
+	.id = ID,
+	.mask = CAN_SFF_MASK | CAN_EFF_FLAG,
+	.exp_num_rx = 2,
+	.exp_flags = {
+		0,
+		CAN_RTR_FLAG,
+	},
+};
+
+/* Receive only EFF frames when filter id and filter mask include EFF flag */
+FIXTURE_VARIANT_ADD(can_filters, filter_eff_eff) {
+	.testcase = 6,
+	.id = ID | CAN_EFF_FLAG,
+	.mask = CAN_SFF_MASK | CAN_EFF_FLAG,
+	.exp_num_rx = 2,
+	.exp_flags = {
+		CAN_EFF_FLAG,
+		CAN_EFF_FLAG | CAN_RTR_FLAG,
+	},
+};
+
+/* Receive only SFF frames when expecting no EFF flag, ignoring RTR flag */
+FIXTURE_VARIANT_ADD(can_filters, filter_eff_rtr) {
+	.testcase = 7,
+	.id = ID | CAN_RTR_FLAG,
+	.mask = CAN_SFF_MASK | CAN_EFF_FLAG,
+	.exp_num_rx = 2,
+	.exp_flags = {
+		0,
+		CAN_RTR_FLAG,
+	},
+};
+
+/* Receive only EFF frames when filter id and filter mask include EFF flag,
+ * ignoring RTR flag
+ */
+FIXTURE_VARIANT_ADD(can_filters, filter_eff_effrtr) {
+	.testcase = 8,
+	.id = ID | CAN_EFF_FLAG | CAN_RTR_FLAG,
+	.mask = CAN_SFF_MASK | CAN_EFF_FLAG,
+	.exp_num_rx = 2,
+	.exp_flags = {
+		CAN_EFF_FLAG,
+		CAN_EFF_FLAG | CAN_RTR_FLAG,
+	},
+};
+
+/* Receive no remote frames when filtering for no RTR flag */
+FIXTURE_VARIANT_ADD(can_filters, filter_rtr) {
+	.testcase = 9,
+	.id = ID,
+	.mask = CAN_SFF_MASK | CAN_RTR_FLAG,
+	.exp_num_rx = 2,
+	.exp_flags = {
+		0,
+		CAN_EFF_FLAG,
+	},
+};
+
+/* Receive no remote frames when filtering for no RTR flag, ignoring EFF flag */
+FIXTURE_VARIANT_ADD(can_filters, filter_rtr_eff) {
+	.testcase = 10,
+	.id = ID | CAN_EFF_FLAG,
+	.mask = CAN_SFF_MASK | CAN_RTR_FLAG,
+	.exp_num_rx = 2,
+	.exp_flags = {
+		0,
+		CAN_EFF_FLAG,
+	},
+};
+
+/* Receive only remote frames when filter includes RTR flag */
+FIXTURE_VARIANT_ADD(can_filters, filter_rtr_rtr) {
+	.testcase = 11,
+	.id = ID | CAN_RTR_FLAG,
+	.mask = CAN_SFF_MASK | CAN_RTR_FLAG,
+	.exp_num_rx = 2,
+	.exp_flags = {
+		CAN_RTR_FLAG,
+		CAN_EFF_FLAG | CAN_RTR_FLAG,
+	},
+};
+
+/* Receive only remote frames when filter includes RTR flag, ignoring EFF
+ * flag
+ */
+FIXTURE_VARIANT_ADD(can_filters, filter_rtr_effrtr) {
+	.testcase = 12,
+	.id = ID | CAN_EFF_FLAG | CAN_RTR_FLAG,
+	.mask = CAN_SFF_MASK | CAN_RTR_FLAG,
+	.exp_num_rx = 2,
+	.exp_flags = {
+		CAN_RTR_FLAG,
+		CAN_EFF_FLAG | CAN_RTR_FLAG,
+	},
+};
+
+/* Receive only SFF data frame when filtering for no flags */
+FIXTURE_VARIANT_ADD(can_filters, filter_effrtr) {
+	.testcase = 13,
+	.id = ID,
+	.mask = CAN_SFF_MASK | CAN_EFF_FLAG | CAN_RTR_FLAG,
+	.exp_num_rx = 1,
+	.exp_flags = {
+		0,
+	},
+};
+
+/* Receive only EFF data frame when filtering for EFF but no RTR flag */
+FIXTURE_VARIANT_ADD(can_filters, filter_effrtr_eff) {
+	.testcase = 14,
+	.id = ID | CAN_EFF_FLAG,
+	.mask = CAN_SFF_MASK | CAN_EFF_FLAG | CAN_RTR_FLAG,
+	.exp_num_rx = 1,
+	.exp_flags = {
+		CAN_EFF_FLAG,
+	},
+};
+
+/* Receive only SFF remote frame when filtering for RTR but no EFF flag */
+FIXTURE_VARIANT_ADD(can_filters, filter_effrtr_rtr) {
+	.testcase = 15,
+	.id = ID | CAN_RTR_FLAG,
+	.mask = CAN_SFF_MASK | CAN_EFF_FLAG | CAN_RTR_FLAG,
+	.exp_num_rx = 1,
+	.exp_flags = {
+		CAN_RTR_FLAG,
+	},
+};
+
+/* Receive only EFF remote frame when filtering for EFF and RTR flag */
+FIXTURE_VARIANT_ADD(can_filters, filter_effrtr_effrtr) {
+	.testcase = 16,
+	.id = ID | CAN_EFF_FLAG | CAN_RTR_FLAG,
+	.mask = CAN_SFF_MASK | CAN_EFF_FLAG | CAN_RTR_FLAG,
+	.exp_num_rx = 1,
+	.exp_flags = {
+		CAN_EFF_FLAG | CAN_RTR_FLAG,
+	},
+};
+
+/* Receive only SFF data frame when filtering for no EFF flag and no RTR flag
+ * but based on EFF mask
+ */
+FIXTURE_VARIANT_ADD(can_filters, eff) {
+	.testcase = 17,
+	.id = ID,
+	.mask = CAN_EFF_MASK | CAN_EFF_FLAG | CAN_RTR_FLAG,
+	.exp_num_rx = 1,
+	.exp_flags = {
+		0,
+	},
+};
+
+/* Receive only EFF data frame when filtering for EFF flag and no RTR flag but
+ * based on EFF mask
+ */
+FIXTURE_VARIANT_ADD(can_filters, eff_eff) {
+	.testcase = 18,
+	.id = ID | CAN_EFF_FLAG,
+	.mask = CAN_EFF_MASK | CAN_EFF_FLAG | CAN_RTR_FLAG,
+	.exp_num_rx = 1,
+	.exp_flags = {
+		CAN_EFF_FLAG,
+	},
+};
+
+/* This test verifies that the raw CAN filters work, by checking if only frames
+ * with the expected set of flags are received. For each test case, the given
+ * filter (id and mask) is added and four CAN frames are sent with every
+ * combination of set/unset EFF/RTR flags.
+ */
+TEST_F(can_filters, test_filter)
+{
+	struct can_filter rfilter;
+	int ret;
+
+	rfilter.can_id = variant->id;
+	rfilter.can_mask = variant->mask;
+	setsockopt(self->sock, SOL_CAN_RAW, CAN_RAW_FILTER,
+		   &rfilter, sizeof(rfilter));
+
+	TH_LOG("filters: can_id = 0x%08X can_mask = 0x%08X",
+		rfilter.can_id, rfilter.can_mask);
+
+	ret = send_can_frames(self->sock, variant->testcase);
+	ASSERT_EQ(ret, 0)
+		TH_LOG("failed to send CAN frames");
+
+	for (int i = 0; i <= variant->exp_num_rx; i++) {
+		struct can_frame frame;
+		struct timeval tv = {
+			.tv_sec = 0,
+			.tv_usec = 50000, /* 50ms timeout */
+		};
+		fd_set rdfs;
+
+		FD_ZERO(&rdfs);
+		FD_SET(self->sock, &rdfs);
+
+		ret = select(self->sock + 1, &rdfs, NULL, NULL, &tv);
+		ASSERT_GE(ret, 0)
+			TH_LOG("failed select for frame %d, err: %d)", i, errno);
+
+		ret = FD_ISSET(self->sock, &rdfs);
+		if (i == variant->exp_num_rx) {
+			ASSERT_EQ(ret, 0)
+				TH_LOG("too many frames received");
+		} else {
+			ASSERT_NE(ret, 0)
+				TH_LOG("too few frames received");
+
+			ret = read(self->sock, &frame, sizeof(frame));
+			ASSERT_GE(ret, 0)
+				TH_LOG("failed to read frame %d, err: %d", i, errno);
+
+			TH_LOG("rx: can_id = 0x%08X rx = %d", frame.can_id, i);
+
+			ASSERT_EQ(ID, frame.can_id & CAN_SFF_MASK)
+				TH_LOG("received wrong can_id");
+			ASSERT_EQ(variant->testcase, frame.data[0])
+				TH_LOG("received wrong test case");
+
+			ASSERT_EQ(frame.can_id & ~CAN_ERR_MASK,
+				  variant->exp_flags[i])
+				TH_LOG("received unexpected flags");
+		}
+	}
+}
+
+int main(int argc, char **argv)
+{
+	char *ifname = getenv("CANIF");
+
+	if (!ifname) {
+		printf("CANIF environment variable must contain the test interface\n");
+		return KSFT_FAIL;
+	}
+
+	strncpy(CANIF, ifname, sizeof(CANIF) - 1);
+
+	return test_harness_run(argc, argv);
+}
diff --git a/tools/testing/selftests/net/can/test_raw_filter.sh b/tools/testing/selftests/net/can/test_raw_filter.sh
new file mode 100755
index 000000000000..2216134b431b
--- /dev/null
+++ b/tools/testing/selftests/net/can/test_raw_filter.sh
@@ -0,0 +1,37 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0
+
+ALL_TESTS="
+	test_raw_filter
+"
+
+net_dir=$(dirname $0)/..
+source $net_dir/lib.sh
+
+export CANIF=${CANIF:-"vcan0"}
+
+setup()
+{
+	ip link add name $CANIF type vcan || exit $ksft_skip
+	ip link set dev $CANIF up
+	pwd
+}
+
+cleanup()
+{
+	ip link delete $CANIF
+}
+
+test_raw_filter()
+{
+	./test_raw_filter
+	check_err $?
+	log_test "test_raw_filter"
+}
+
+trap cleanup EXIT
+setup
+
+tests_run
+
+exit $EXIT_STATUS
-- 
2.47.2



