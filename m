Return-Path: <linux-can+bounces-3565-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B7710AB17F1
	for <lists+linux-can@lfdr.de>; Fri,  9 May 2025 17:06:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 769A9188CE13
	for <lists+linux-can@lfdr.de>; Fri,  9 May 2025 15:06:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E318A23505D;
	Fri,  9 May 2025 15:06:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OmbZqjA1"
X-Original-To: linux-can@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 658BA2185BC
	for <linux-can@vger.kernel.org>; Fri,  9 May 2025 15:06:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746803195; cv=none; b=MCLMhjdDKaHdyMA8s/m9GGsZQ7kfeIRglaAE85v9QrhR7X8f9ZFFYdZMNUaHOJQo/Z39e/SmZhTmQumufLCZ9eBc/CZRFWBoYb+hs9wdN1Tln2kzgqRcm2xz7p+PoSubB480OEipvzvtlkvDO3sEps+KWl+ji9DTTI0e8qeRAIo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746803195; c=relaxed/simple;
	bh=8UlxgaMozipdLQyMDOrmjxfUNRn9I6YA5L7dLg97Y1Y=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=PSS0xbCG7uIYGcJX33I3cbmyx3mdejJIRPyHxY6ARkFQcwBB8kiYctNAxK6o1FkgbXtc9NKp3QZJXGW0IZxlVmVyaZrMfV8as8bICcQGbUXlD4ATu4oO6prL1HuYOAhko93wwFC5bw6WvHlbSx0UrlWRTvYuEt7MOd/bjbIb0c8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=OmbZqjA1; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1746803191;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=CGCLptpIZrZQIGNK6FOyTHYHs2ZgMnq84bkeU4R9aNo=;
	b=OmbZqjA1VhomlSD8rmBbTtXE1sPQblNZ8k1oGKiPk5K+E/AxlBiaBbkQUiovAaDE3qxwLu
	AOF7lhl7SWwy01vUw960CfeLLLIxxKrZl3r/96n6Kr2v1Cg/+9rePSb7l7QWdX0v9UIOKF
	D9ly6wVFz/hAkK409avelV+R1y0c938=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-371-0DgsP6liNGen1WzABM7Lgw-1; Fri,
 09 May 2025 11:06:27 -0400
X-MC-Unique: 0DgsP6liNGen1WzABM7Lgw-1
X-Mimecast-MFC-AGG-ID: 0DgsP6liNGen1WzABM7Lgw_1746803185
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 801C0180035C;
	Fri,  9 May 2025 15:06:24 +0000 (UTC)
Received: from thinkpad.redhat.com (unknown [10.44.33.37])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id CF2423000221;
	Fri,  9 May 2025 15:06:19 +0000 (UTC)
From: Felix Maurer <fmaurer@redhat.com>
To: socketcan@hartkopp.net,
	mkl@pengutronix.de
Cc: shuah@kernel.org,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	linux-can@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	dcaratti@redhat.com,
	fstornio@redhat.com,
	mailhol.vincent@wanadoo.fr
Subject: [PATCH v2] selftests: can: Import tst-filter from can-tests
Date: Fri,  9 May 2025 17:06:02 +0200
Message-ID: <dac10156eb550871c267bdfe199943e12610730b.1746801747.git.fmaurer@redhat.com>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

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
---

Notes:
    I keep netdev and its reviewers and maintainers in CC because of the
    changes to their paths in MAINTAINERS, even though Jakub acked them on
    v1. The change should be merged through linux-can-next and subsequent
    changes will not go to netdev anymore.
    
    I have removed the long form of the licenses in the beginning of the
    file during the import, as that is covered by the SPDX line anyways. The
    copyright is left as it was originally.
    
    Changes to v1:
    - link: https://lore.kernel.org/linux-can/cover.1745323279.git.fmaurer@redhat.com/
    - Squashed import and rewrite into a single commit
    - Simplified checking of the received flags
    - Pass the interface name through env (easier with the selftest
      framework than adding an argument)
    
    I have not updated test_raw_filter.sh to work with physical CAN
    interfaces so far because I don't have one to test this right now and
    don't think it's a priority for selftests for now.

 MAINTAINERS                                   |   2 +
 tools/testing/selftests/Makefile              |   1 +
 tools/testing/selftests/net/can/.gitignore    |   2 +
 tools/testing/selftests/net/can/Makefile      |  11 +
 .../selftests/net/can/test_raw_filter.c       | 395 ++++++++++++++++++
 .../selftests/net/can/test_raw_filter.sh      |  37 ++
 6 files changed, 448 insertions(+)
 create mode 100644 tools/testing/selftests/net/can/.gitignore
 create mode 100644 tools/testing/selftests/net/can/Makefile
 create mode 100644 tools/testing/selftests/net/can/test_raw_filter.c
 create mode 100755 tools/testing/selftests/net/can/test_raw_filter.sh

diff --git a/MAINTAINERS b/MAINTAINERS
index 241ca9e260a2..55749b492ebb 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -5155,6 +5155,7 @@ F:	include/uapi/linux/can/isotp.h
 F:	include/uapi/linux/can/raw.h
 F:	net/can/
 F:	net/sched/em_canid.c
+F:	tools/testing/selftests/net/can/
 
 CAN-J1939 NETWORK LAYER
 M:	Robin van der Gracht <robin@protonic.nl>
@@ -16577,6 +16578,7 @@ X:	net/ceph/
 X:	net/mac80211/
 X:	net/rfkill/
 X:	net/wireless/
+X:	tools/testing/selftests/net/can/
 
 NETWORKING [IPSEC]
 M:	Steffen Klassert <steffen.klassert@secunet.com>
diff --git a/tools/testing/selftests/Makefile b/tools/testing/selftests/Makefile
index 8daac70c2f9d..e5c9ecd52b73 100644
--- a/tools/testing/selftests/Makefile
+++ b/tools/testing/selftests/Makefile
@@ -64,6 +64,7 @@ TARGETS += mqueue
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
index 000000000000..3c0e43cab1e8
--- /dev/null
+++ b/tools/testing/selftests/net/can/test_raw_filter.c
@@ -0,0 +1,395 @@
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
+char VCANIF[IFNAMSIZ];
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
+
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
+	ASSERT_LT(0, s)
+		TH_LOG("failed to create CAN_RAW socket: %d", errno);
+
+	strncpy(ifr.ifr_name, VCANIF, sizeof(ifr.ifr_name));
+	ret = ioctl(s, SIOCGIFINDEX, &ifr);
+	ASSERT_LE(0, ret)
+		TH_LOG("failed SIOCGIFINDEX: %d", errno);
+
+	addr.can_family = AF_CAN;
+	addr.can_ifindex = ifr.ifr_ifindex;
+
+	setsockopt(s, SOL_CAN_RAW, CAN_RAW_RECV_OWN_MSGS,
+		   &recv_own_msgs, sizeof(recv_own_msgs));
+
+	ret = bind(s, (struct sockaddr *)&addr, sizeof(addr));
+	ASSERT_EQ(0, ret)
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
+#define T_EFF (CAN_EFF_FLAG >> 28)
+#define T_RTR (CAN_RTR_FLAG >> 28)
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
+	ASSERT_EQ(0, ret)
+		TH_LOG("failed to send CAN frames");
+
+	for (int i = 0; i <= variant->exp_num_rx; i++) {
+		struct can_frame frame;
+		struct timeval tv;
+		fd_set rdfs;
+
+		FD_ZERO(&rdfs);
+		FD_SET(self->sock, &rdfs);
+		tv.tv_sec = 0;
+		tv.tv_usec = 50000; /* 50ms timeout */
+
+		ret = select(self->sock + 1, &rdfs, NULL, NULL, &tv);
+		ASSERT_LE(0, ret)
+			TH_LOG("failed select for frame %d, err: %d)", i, errno);
+
+		ret = FD_ISSET(self->sock, &rdfs);
+		if (i == variant->exp_num_rx) {
+			ASSERT_EQ(0, ret)
+				TH_LOG("too many frames received");
+		} else {
+			ASSERT_NE(0, ret)
+				TH_LOG("too few frames received");
+
+			ret = read(self->sock, &frame, sizeof(frame));
+			ASSERT_LE(0, ret)
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
+
+		}
+	}
+}
+
+int main(int argc, char **argv)
+{
+	char *ifname = getenv("VCANIF");
+
+	if (ifname) {
+		strncpy(VCANIF, ifname, sizeof(VCANIF) - 1);
+	} else {
+		printf("VCANIF environment variable must contain the test interface\n");
+		return KSFT_FAIL;
+	}
+
+	return test_harness_run(argc, argv);
+}
diff --git a/tools/testing/selftests/net/can/test_raw_filter.sh b/tools/testing/selftests/net/can/test_raw_filter.sh
new file mode 100755
index 000000000000..95f45c3c824b
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
+export VCANIF="vcan0"
+
+setup()
+{
+	ip link add name $VCANIF type vcan || exit $ksft_skip
+	ip link set dev $VCANIF up
+	pwd
+}
+
+cleanup()
+{
+	ip link delete $VCANIF
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
2.49.0


