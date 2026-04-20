Return-Path: <linux-can+bounces-7380-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WHRFNOZa5mmtvAEAu9opvQ
	(envelope-from <linux-can+bounces-7380-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Mon, 20 Apr 2026 18:57:10 +0200
X-Original-To: lists+linux-can@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EBF43430440
	for <lists+linux-can@lfdr.de>; Mon, 20 Apr 2026 18:57:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 8DA0B309E89D
	for <lists+linux-can@lfdr.de>; Mon, 20 Apr 2026 15:23:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD5A22D8DC2;
	Mon, 20 Apr 2026 15:22:38 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87A17244661
	for <linux-can@vger.kernel.org>; Mon, 20 Apr 2026 15:22:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776698558; cv=none; b=mEYtCzk8B+JMCtmq+2vX648XicBdx7ekQxa8wfMGxgjVE8RPfGy4AQK8Nt6D6ykYE74Nfg9YcwXF+PK8sesbFQrNh/1Zr6mUGFW8Cq2D0JGAjbajfD0QBoU00iMHx2a7NhL6zvSOCFj6JPkjBi7MDK+jBHJ/EdalkwI2cu7PWM0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776698558; c=relaxed/simple;
	bh=BZpC3Kif4rGHp2DZw6xJowV+92gw6RThBMkSSqu/JTc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=K90XRTTdTxP0zVP0pk/JMzrkNRqQ3qgbDX1ouMgGHELGE3DyKg7FYe7AnkvCZUt8SqUTipKHOGDeWCUeBFPH+GWY753dXgwAIpmIhLS61rRHrze7zd0gusqi1HuPYAHO1kssiwRkvxcxVLPyZLsFl1AqVTo0mWU/HhVtew6YKMo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ore@pengutronix.de>)
	id 1wEqSE-0000bf-BC; Mon, 20 Apr 2026 17:22:30 +0200
Received: from dude04.red.stw.pengutronix.de ([2a0a:edc0:0:1101:1d::ac] helo=dude04)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1wEqSE-006MF1-0N;
	Mon, 20 Apr 2026 17:22:30 +0200
Received: from ore by dude04 with local (Exim 4.98.2)
	(envelope-from <ore@pengutronix.de>)
	id 1wEqSE-00000002RYL-051S;
	Mon, 20 Apr 2026 17:22:30 +0200
From: Oleksij Rempel <o.rempel@pengutronix.de>
To: Robin van der Gracht <robin@protonic.nl>,
	Oliver Hartkopp <socketcan@hartkopp.net>,
	Marc Kleine-Budde <mkl@pengutronix.de>
Cc: Oleksij Rempel <o.rempel@pengutronix.de>,
	kernel@pengutronix.de,
	linux-can@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v1 3/3] net: can: j1939: Add initial KUnit tests for socket and transport layers
Date: Mon, 20 Apr 2026 17:22:27 +0200
Message-ID: <20260420152228.581421-4-o.rempel@pengutronix.de>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260420152228.581421-1-o.rempel@pengutronix.de>
References: <20260420152228.581421-1-o.rempel@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ore@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org
X-Spamd-Result: default: False [0.04 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-7380-lists,linux-can=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_NA(0.00)[pengutronix.de];
	TAGGED_RCPT(0.00)[linux-can];
	RCPT_COUNT_SEVEN(0.00)[7];
	FROM_NEQ_ENVFROM(0.00)[o.rempel@pengutronix.de,linux-can@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_COUNT_FIVE(0.00)[6];
	R_DKIM_NA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,pengutronix.de:mid,pengutronix.de:email]
X-Rspamd-Queue-Id: EBF43430440
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Add initial KUnit test coverage for J1939 socket and transport layer
functions. These tests scratch the surface of the existing code and
catch low-hanging fruit in validation logic.

Tests cover priority conversion, PGN validation, address sanity checks,
socket-to-sockaddr conversion, abort code handling, control message
parsing, and broadcast detection.

Export internal functions with VISIBLE_IF_KUNIT/EXPORT_SYMBOL_IF_KUNIT
to enable testing. Tests validate both correct inputs and defensive
handling of invalid values (NULL pointers, out-of-range, wrong families)
to prevent kernel crashes.

Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
---
 net/can/j1939/Kconfig                |  12 +
 net/can/j1939/Makefile               |   2 +
 net/can/j1939/j1939-test.h           |  69 ++++
 net/can/j1939/socket.c               |  41 ++-
 net/can/j1939/tests/.kunitconfig     |   5 +
 net/can/j1939/tests/Makefile         |   4 +
 net/can/j1939/tests/socket_test.c    | 301 +++++++++++++++
 net/can/j1939/tests/transport_test.c | 533 +++++++++++++++++++++++++++
 net/can/j1939/transport.c            |  51 ++-
 9 files changed, 1008 insertions(+), 10 deletions(-)
 create mode 100644 net/can/j1939/j1939-test.h
 create mode 100644 net/can/j1939/tests/.kunitconfig
 create mode 100644 net/can/j1939/tests/Makefile
 create mode 100644 net/can/j1939/tests/socket_test.c
 create mode 100644 net/can/j1939/tests/transport_test.c

diff --git a/net/can/j1939/Kconfig b/net/can/j1939/Kconfig
index 2998298b71ec..8a3ee0370d33 100644
--- a/net/can/j1939/Kconfig
+++ b/net/can/j1939/Kconfig
@@ -13,3 +13,15 @@ config CAN_J1939
 	  The relevant parts in kernel are
 	  SAE j1939-21 (datalink & transport protocol)
 	  & SAE j1939-81 (network management).
+
+config CAN_J1939_KUNIT_TEST
+	tristate "KUnit tests for CAN J1939 sockets" if !KUNIT_ALL_TESTS
+	depends on KUNIT && CAN_J1939
+	default KUNIT_ALL_TESTS
+	help
+	  This builds unit tests for the J1939 socket utility functions.
+
+	  For more information on KUnit and unit tests in general, please refer
+	  to the KUnit documentation in Documentation/dev-tools/kunit/.
+
+	  If unsure, say N.
diff --git a/net/can/j1939/Makefile b/net/can/j1939/Makefile
index 19181bdae173..18979ae11c98 100644
--- a/net/can/j1939/Makefile
+++ b/net/can/j1939/Makefile
@@ -8,3 +8,5 @@ can-j1939-objs := \
 	main.o \
 	socket.o \
 	transport.o
+
+obj-$(CONFIG_CAN_J1939_KUNIT_TEST) += tests/
diff --git a/net/can/j1939/j1939-test.h b/net/can/j1939/j1939-test.h
new file mode 100644
index 000000000000..60169571c19e
--- /dev/null
+++ b/net/can/j1939/j1939-test.h
@@ -0,0 +1,69 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * J1939 test-visible functions
+ *
+ * This header exposes internal functions for KUnit testing.
+ *
+ * Safe to include unconditionally - empty when CONFIG_KUNIT=n.
+ * Functions are static (via VISIBLE_IF_KUNIT) when testing disabled.
+ */
+
+#ifndef _J1939_TEST_H_
+#define _J1939_TEST_H_
+
+#if IS_ENABLED(CONFIG_KUNIT)
+
+#include <linux/types.h>
+#include <linux/stddef.h>
+#include <linux/can/j1939.h>
+#include <linux/can.h>
+#include <linux/can/core.h>
+
+/* From socket.c - exposed for KUnit testing via wrapper functions
+ * The actual implementations are static inline for performance; these wrappers
+ * allow testing without impacting production code.
+ */
+
+priority_t j1939_prio_wrapper(u32 sk_priority);
+u32 j1939_to_sk_priority_wrapper(priority_t prio);
+bool j1939_pgn_is_valid_wrapper(pgn_t pgn);
+bool j1939_pgn_is_clean_pdu_wrapper(pgn_t pgn);
+int j1939_sk_sanity_check(struct sockaddr_can *addr, int len);
+
+struct j1939_sock;
+void j1939_sk_sock2sockaddr_can(struct sockaddr_can *addr,
+				const struct j1939_sock *jsk, int peer);
+
+enum j1939_sk_errqueue_type;
+size_t j1939_sk_opt_stats_get_size(enum j1939_sk_errqueue_type type);
+
+/* From transport.c - exposed for KUnit testing
+ * Functions with _wrapper suffix are non-inline wrappers around static inline
+ * implementations to avoid performance impact on production code.
+ */
+
+/* Forward declarations for structures (full definitions in j1939-priv.h) */
+struct j1939_priv;
+struct j1939_sk_buff_cb;
+struct j1939_addr;
+
+/* enum j1939_xtp_abort is defined in j1939-priv.h */
+
+/* Non-inline functions exported directly */
+const char *j1939_xtp_abort_to_str(enum j1939_xtp_abort abort);
+int j1939_xtp_abort_to_errno(struct j1939_priv *priv,
+			      enum j1939_xtp_abort abort);
+bool j1939_session_match(struct j1939_addr *se_addr,
+			 struct j1939_addr *sk_addr, bool reverse);
+void j1939_skbcb_swap(struct j1939_sk_buff_cb *skcb);
+
+/* Wrappers for hot-path inline functions */
+bool j1939_cb_is_broadcast_wrapper(const struct j1939_sk_buff_cb *skcb);
+pgn_t j1939_xtp_ctl_to_pgn_wrapper(const u8 *dat);
+unsigned int j1939_tp_ctl_to_size_wrapper(const u8 *dat);
+unsigned int j1939_etp_ctl_to_packet_wrapper(const u8 *dat);
+unsigned int j1939_etp_ctl_to_size_wrapper(const u8 *dat);
+
+#endif /* IS_ENABLED(CONFIG_KUNIT) */
+
+#endif /* _J1939_TEST_H_ */
diff --git a/net/can/j1939/socket.c b/net/can/j1939/socket.c
index 2191bfe117dc..24b2f7177092 100644
--- a/net/can/j1939/socket.c
+++ b/net/can/j1939/socket.c
@@ -18,8 +18,10 @@
 #include <linux/errqueue.h>
 #include <linux/if_arp.h>
 #include <net/can.h>
+#include <kunit/visibility.h>
 
 #include "j1939-priv.h"
+#include "j1939-test.h"
 
 /* conversion function between struct sock::sk_priority from linux and
  * j1939 priority field
@@ -51,6 +53,33 @@ static inline bool j1939_pgn_is_clean_pdu(pgn_t pgn)
 		return true;
 }
 
+#if IS_ENABLED(CONFIG_KUNIT)
+/* Wrappers for testing inline functions - no production overhead */
+VISIBLE_IF_KUNIT priority_t j1939_prio_wrapper(u32 sk_priority)
+{
+	return j1939_prio(sk_priority);
+}
+EXPORT_SYMBOL_IF_KUNIT(j1939_prio_wrapper);
+
+VISIBLE_IF_KUNIT u32 j1939_to_sk_priority_wrapper(priority_t prio)
+{
+	return j1939_to_sk_priority(prio);
+}
+EXPORT_SYMBOL_IF_KUNIT(j1939_to_sk_priority_wrapper);
+
+VISIBLE_IF_KUNIT bool j1939_pgn_is_valid_wrapper(pgn_t pgn)
+{
+	return j1939_pgn_is_valid(pgn);
+}
+EXPORT_SYMBOL_IF_KUNIT(j1939_pgn_is_valid_wrapper);
+
+VISIBLE_IF_KUNIT bool j1939_pgn_is_clean_pdu_wrapper(pgn_t pgn)
+{
+	return j1939_pgn_is_clean_pdu(pgn);
+}
+EXPORT_SYMBOL_IF_KUNIT(j1939_pgn_is_clean_pdu_wrapper);
+#endif
+
 static inline void j1939_sock_pending_add(struct sock *sk)
 {
 	struct j1939_sock *jsk = j1939_sk(sk);
@@ -422,7 +451,7 @@ static int j1939_sk_init(struct sock *sk)
 	return 0;
 }
 
-static int j1939_sk_sanity_check(struct sockaddr_can *addr, int len)
+VISIBLE_IF_KUNIT int j1939_sk_sanity_check(struct sockaddr_can *addr, int len)
 {
 	if (!addr)
 		return -EDESTADDRREQ;
@@ -438,6 +467,7 @@ static int j1939_sk_sanity_check(struct sockaddr_can *addr, int len)
 
 	return 0;
 }
+EXPORT_SYMBOL_IF_KUNIT(j1939_sk_sanity_check);
 
 static int j1939_sk_bind(struct socket *sock, struct sockaddr_unsized *uaddr, int len)
 {
@@ -587,8 +617,9 @@ static int j1939_sk_connect(struct socket *sock, struct sockaddr_unsized *uaddr,
 	return ret;
 }
 
-static void j1939_sk_sock2sockaddr_can(struct sockaddr_can *addr,
-				       const struct j1939_sock *jsk, int peer)
+VISIBLE_IF_KUNIT void j1939_sk_sock2sockaddr_can(struct sockaddr_can *addr,
+						 const struct j1939_sock *jsk,
+						 int peer)
 {
 	/* There are two holes (2 bytes and 3 bytes) to clear to avoid
 	 * leaking kernel information to user space.
@@ -606,6 +637,7 @@ static void j1939_sk_sock2sockaddr_can(struct sockaddr_can *addr,
 		addr->can_addr.j1939.addr = jsk->addr.sa;
 	}
 }
+EXPORT_SYMBOL_IF_KUNIT(j1939_sk_sock2sockaddr_can);
 
 static int j1939_sk_getname(struct socket *sock, struct sockaddr *uaddr,
 			    int peer)
@@ -937,7 +969,7 @@ static struct sk_buff *j1939_sk_alloc_skb(struct net_device *ndev,
 	return NULL;
 }
 
-static size_t j1939_sk_opt_stats_get_size(enum j1939_sk_errqueue_type type)
+VISIBLE_IF_KUNIT size_t j1939_sk_opt_stats_get_size(enum j1939_sk_errqueue_type type)
 {
 	switch (type) {
 	case J1939_ERRQUEUE_RX_RTS:
@@ -955,6 +987,7 @@ static size_t j1939_sk_opt_stats_get_size(enum j1939_sk_errqueue_type type)
 			0;
 	}
 }
+EXPORT_SYMBOL_IF_KUNIT(j1939_sk_opt_stats_get_size);
 
 static struct sk_buff *
 j1939_sk_get_timestamping_opt_stats(struct j1939_session *session,
diff --git a/net/can/j1939/tests/.kunitconfig b/net/can/j1939/tests/.kunitconfig
new file mode 100644
index 000000000000..9af97231cff7
--- /dev/null
+++ b/net/can/j1939/tests/.kunitconfig
@@ -0,0 +1,5 @@
+CONFIG_KUNIT=y
+CONFIG_NET=y
+CONFIG_CAN=y
+CONFIG_CAN_J1939=y
+CONFIG_CAN_J1939_KUNIT_TEST=y
diff --git a/net/can/j1939/tests/Makefile b/net/can/j1939/tests/Makefile
new file mode 100644
index 000000000000..eb69872b1c11
--- /dev/null
+++ b/net/can/j1939/tests/Makefile
@@ -0,0 +1,4 @@
+# SPDX-License-Identifier: GPL-2.0
+
+obj-$(CONFIG_CAN_J1939_KUNIT_TEST) += socket_test.o
+obj-$(CONFIG_CAN_J1939_KUNIT_TEST) += transport_test.o
diff --git a/net/can/j1939/tests/socket_test.c b/net/can/j1939/tests/socket_test.c
new file mode 100644
index 000000000000..2803ee339f28
--- /dev/null
+++ b/net/can/j1939/tests/socket_test.c
@@ -0,0 +1,301 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * KUnit tests for J1939 socket utility functions
+ *
+ * Copyright (c) 2026 Pengutronix,
+ *                    Oleksij Rempel <kernel@pengutronix.de>
+ */
+
+#include <kunit/test.h>
+#include <linux/can/j1939.h>
+#include "../j1939-priv.h"
+#include "../j1939-test.h"
+
+/*
+ * Priority conversion: J1939 prio (0=high, 7=low) <-> sk_priority
+ * (7=high, 0=low)
+ */
+static void j1939_test_prio_conversion_roundtrip(struct kunit *test)
+{
+	int i;
+
+	for (i = 0; i <= 7; i++) {
+		u32 sk_prio = j1939_to_sk_priority_wrapper(i);
+		priority_t j1939_p = j1939_prio_wrapper(sk_prio);
+
+		KUNIT_EXPECT_EQ(test, j1939_p, i);
+	}
+}
+
+/*
+ * Out-of-range sk_priority values must clamp to 0 (highest) to prevent
+ * 3-bit wraparound. High UNIX priority (>7) = high importance = J1939 prio 0.
+ */
+static void j1939_test_prio_clamping(struct kunit *test)
+{
+	KUNIT_EXPECT_EQ(test, j1939_prio_wrapper(8), 0);
+	KUNIT_EXPECT_EQ(test, j1939_prio_wrapper(100), 0);
+	KUNIT_EXPECT_EQ(test, j1939_prio_wrapper(UINT_MAX), 0);
+}
+
+/* PGN (Parameter Group Number) validation: 18-bit identifier (0x00000-0x3FFFF) */
+static void j1939_test_pgn_valid_range(struct kunit *test)
+{
+	KUNIT_EXPECT_TRUE(test, j1939_pgn_is_valid_wrapper(0));
+	KUNIT_EXPECT_TRUE(test, j1939_pgn_is_valid_wrapper(J1939_PGN_MAX));
+	KUNIT_EXPECT_FALSE(test, j1939_pgn_is_valid_wrapper(J1939_PGN_MAX + 1));
+	KUNIT_EXPECT_FALSE(test, j1939_pgn_is_valid_wrapper(0xFFFFFFFF));
+}
+
+static void j1939_test_pgn_valid_common(struct kunit *test)
+{
+	KUNIT_EXPECT_TRUE(test, j1939_pgn_is_valid_wrapper(0xEF00));
+	KUNIT_EXPECT_TRUE(test, j1939_pgn_is_valid_wrapper(0xFECA)); /* DM1 */
+	KUNIT_EXPECT_TRUE(test, j1939_pgn_is_valid_wrapper(0xFEEC));
+	KUNIT_EXPECT_TRUE(test, j1939_pgn_is_valid_wrapper(0xF004));
+}
+
+/*
+ * Clean PDU tests: PDU1 (<0xF000) requires DA bits clear;
+ * PDU2 (>=0xF000) always clean.
+ * "Dirty" PDU1 (non-zero DA) causes addressing ambiguity.
+ */
+static void j1939_test_clean_pdu_pdu1_format(struct kunit *test)
+{
+	/* PDU1 with DA bits clear - clean */
+	KUNIT_EXPECT_TRUE(test, j1939_pgn_is_clean_pdu_wrapper(0xEF00));
+	KUNIT_EXPECT_TRUE(test, j1939_pgn_is_clean_pdu_wrapper(0xEA00));
+	KUNIT_EXPECT_TRUE(test, j1939_pgn_is_clean_pdu_wrapper(0x0000));
+
+	/* PDU1 with DA bits set - dirty */
+	KUNIT_EXPECT_FALSE(test, j1939_pgn_is_clean_pdu_wrapper(0xEF01));
+	KUNIT_EXPECT_FALSE(test, j1939_pgn_is_clean_pdu_wrapper(0xEF12));
+	KUNIT_EXPECT_FALSE(test, j1939_pgn_is_clean_pdu_wrapper(0xEAFF));
+	KUNIT_EXPECT_FALSE(test, j1939_pgn_is_clean_pdu_wrapper(0x00FF));
+}
+
+static void j1939_test_clean_pdu_pdu2_format(struct kunit *test)
+{
+	/* PDU2 - always clean, lower 8 bits are Group Extension, not DA */
+	KUNIT_EXPECT_TRUE(test, j1939_pgn_is_clean_pdu_wrapper(0xF000));
+	KUNIT_EXPECT_TRUE(test, j1939_pgn_is_clean_pdu_wrapper(0xF0FF));
+	KUNIT_EXPECT_TRUE(test, j1939_pgn_is_clean_pdu_wrapper(0xFECA)); /* DM1 */
+	KUNIT_EXPECT_TRUE(test, j1939_pgn_is_clean_pdu_wrapper(0xFEEC));
+	KUNIT_EXPECT_TRUE(test, j1939_pgn_is_clean_pdu_wrapper(0xFFFF));
+}
+
+/*
+ * Socket address sanity checks catch errors early: NULL, short length, wrong
+ * family, etc.
+ */
+static void j1939_test_sanity_check_null_addr(struct kunit *test)
+{
+	int ret;
+
+	ret = j1939_sk_sanity_check(NULL, 0);
+	KUNIT_EXPECT_EQ(test, ret, -EDESTADDRREQ);
+}
+
+static void j1939_test_sanity_check_short_length(struct kunit *test)
+{
+	struct sockaddr_can addr = {};
+	int ret;
+
+	ret = j1939_sk_sanity_check(&addr, J1939_MIN_NAMELEN - 1);
+	KUNIT_EXPECT_EQ(test, ret, -EINVAL);
+}
+
+static void j1939_test_sanity_check_wrong_family(struct kunit *test)
+{
+	struct sockaddr_can addr = {
+		.can_family = AF_INET,
+		.can_ifindex = 1,
+	};
+	int ret;
+
+	ret = j1939_sk_sanity_check(&addr, J1939_MIN_NAMELEN);
+	KUNIT_EXPECT_EQ(test, ret, -EINVAL);
+}
+
+static void j1939_test_sanity_check_no_ifindex(struct kunit *test)
+{
+	struct sockaddr_can addr = {
+		.can_family = AF_CAN,
+		.can_ifindex = 0,
+	};
+	int ret;
+
+	ret = j1939_sk_sanity_check(&addr, J1939_MIN_NAMELEN);
+	KUNIT_EXPECT_EQ(test, ret, -ENODEV);
+}
+
+static void j1939_test_sanity_check_dirty_pdu1_pgn(struct kunit *test)
+{
+	struct sockaddr_can addr = {
+		.can_family = AF_CAN,
+		.can_ifindex = 1,
+		.can_addr.j1939.pgn = 0xEF12, /* PDU1 with DA bits set */
+	};
+	int ret;
+
+	ret = j1939_sk_sanity_check(&addr, J1939_MIN_NAMELEN);
+	KUNIT_EXPECT_EQ(test, ret, -EINVAL);
+}
+
+static void j1939_test_sanity_check_valid(struct kunit *test)
+{
+	struct sockaddr_can addr;
+	int ret;
+
+	/* Valid PDU2 with full fields */
+	addr = (struct sockaddr_can){
+		.can_family = AF_CAN,
+		.can_ifindex = 1,
+		.can_addr.j1939.pgn = 0xFECA,
+		.can_addr.j1939.name = 0x1234567890ABCDEF,
+		.can_addr.j1939.addr = 0x80,
+	};
+	ret = j1939_sk_sanity_check(&addr, J1939_MIN_NAMELEN);
+	KUNIT_EXPECT_EQ(test, ret, 0);
+
+	/* Valid clean PDU1 */
+	addr.can_addr.j1939.pgn = 0xEF00;
+	ret = j1939_sk_sanity_check(&addr, J1939_MIN_NAMELEN);
+	KUNIT_EXPECT_EQ(test, ret, 0);
+
+	/* Valid J1939_NO_PGN wildcard */
+	addr.can_addr.j1939.pgn = J1939_NO_PGN;
+	ret = j1939_sk_sanity_check(&addr, J1939_MIN_NAMELEN);
+	KUNIT_EXPECT_EQ(test, ret, 0);
+}
+
+/* Socket-to-sockaddr conversion for getname(): peer=0 (local), peer=1 (remote) */
+static void j1939_test_sock2sockaddr_local(struct kunit *test)
+{
+	struct sockaddr_can addr;
+	struct j1939_sock jsk = {
+		.ifindex = 5,
+		.addr = {
+			.src_name = 0x1234567890ABCDEF,
+			.dst_name = 0xFEDCBA0987654321,
+			.pgn = 0xFECA,
+			.sa = 0x25,
+			.da = 0x30,
+		},
+	};
+
+	memset(&addr, 0xFF, sizeof(addr));
+	j1939_sk_sock2sockaddr_can(&addr, &jsk, 0);
+
+	KUNIT_EXPECT_EQ(test, addr.can_family, AF_CAN);
+	KUNIT_EXPECT_EQ(test, addr.can_ifindex, 5);
+	KUNIT_EXPECT_EQ(test, addr.can_addr.j1939.name, 0x1234567890ABCDEF);
+	KUNIT_EXPECT_EQ(test, addr.can_addr.j1939.addr, 0x25);
+	KUNIT_EXPECT_EQ(test, addr.can_addr.j1939.pgn, 0xFECA);
+}
+
+static void j1939_test_sock2sockaddr_peer(struct kunit *test)
+{
+	struct sockaddr_can addr;
+	struct j1939_sock jsk = {
+		.ifindex = 5,
+		.addr = {
+			.src_name = 0x1234567890ABCDEF,
+			.dst_name = 0xFEDCBA0987654321,
+			.pgn = 0xFECA,
+			.sa = 0x25,
+			.da = 0x30,
+		},
+	};
+
+	memset(&addr, 0xFF, sizeof(addr));
+	j1939_sk_sock2sockaddr_can(&addr, &jsk, 1);
+
+	KUNIT_EXPECT_EQ(test, addr.can_family, AF_CAN);
+	KUNIT_EXPECT_EQ(test, addr.can_ifindex, 5);
+	KUNIT_EXPECT_EQ(test, addr.can_addr.j1939.name, 0xFEDCBA0987654321);
+	KUNIT_EXPECT_EQ(test, addr.can_addr.j1939.addr, 0x30);
+	KUNIT_EXPECT_EQ(test, addr.can_addr.j1939.pgn, 0xFECA);
+}
+
+/* Verify padding is zeroed to prevent kernel info leak */
+static void j1939_test_sock2sockaddr_zeroes_padding(struct kunit *test)
+{
+	struct sockaddr_can addr;
+	struct j1939_sock jsk = {
+		.ifindex = 1,
+		.addr = {
+			.src_name = 0,
+			.dst_name = 0,
+			.pgn = 0,
+			.sa = 0,
+			.da = 0,
+		},
+	};
+
+	memset(&addr, 0xAA, sizeof(addr));
+	j1939_sk_sock2sockaddr_can(&addr, &jsk, 0);
+
+	KUNIT_EXPECT_EQ(test, addr.can_addr.j1939.name, 0ULL);
+	KUNIT_EXPECT_EQ(test, addr.can_addr.j1939.addr, 0);
+	KUNIT_EXPECT_EQ(test, addr.can_addr.j1939.pgn, 0U);
+}
+
+/* Error queue buffer size for transport statistics (MSG_ERRQUEUE) */
+
+static void j1939_test_errqueue_size_consistency(struct kunit *test)
+{
+	size_t rx_rts = j1939_sk_opt_stats_get_size(J1939_ERRQUEUE_RX_RTS);
+	size_t tx_ack = j1939_sk_opt_stats_get_size(J1939_ERRQUEUE_TX_ACK);
+
+	/* RX_RTS should be larger (more fields) */
+	KUNIT_EXPECT_GT(test, rx_rts, tx_ack);
+	KUNIT_EXPECT_GT(test, tx_ack, 0);
+
+	/* All non-RX_RTS types should have same size (default case) */
+	KUNIT_EXPECT_EQ(test, tx_ack,
+			j1939_sk_opt_stats_get_size(J1939_ERRQUEUE_TX_SCHED));
+	KUNIT_EXPECT_EQ(test, tx_ack,
+			j1939_sk_opt_stats_get_size(J1939_ERRQUEUE_TX_ABORT));
+	KUNIT_EXPECT_EQ(test, tx_ack,
+			j1939_sk_opt_stats_get_size(J1939_ERRQUEUE_RX_DPO));
+	KUNIT_EXPECT_EQ(test, tx_ack,
+			j1939_sk_opt_stats_get_size(J1939_ERRQUEUE_RX_ABORT));
+}
+
+static struct kunit_case j1939_socket_test_cases[] = {
+	KUNIT_CASE(j1939_test_prio_conversion_roundtrip),
+	KUNIT_CASE(j1939_test_prio_clamping),
+
+	KUNIT_CASE(j1939_test_pgn_valid_range),
+	KUNIT_CASE(j1939_test_pgn_valid_common),
+
+	KUNIT_CASE(j1939_test_clean_pdu_pdu1_format),
+	KUNIT_CASE(j1939_test_clean_pdu_pdu2_format),
+
+	KUNIT_CASE(j1939_test_sanity_check_null_addr),
+	KUNIT_CASE(j1939_test_sanity_check_short_length),
+	KUNIT_CASE(j1939_test_sanity_check_wrong_family),
+	KUNIT_CASE(j1939_test_sanity_check_no_ifindex),
+	KUNIT_CASE(j1939_test_sanity_check_dirty_pdu1_pgn),
+	KUNIT_CASE(j1939_test_sanity_check_valid),
+
+	KUNIT_CASE(j1939_test_sock2sockaddr_local),
+	KUNIT_CASE(j1939_test_sock2sockaddr_peer),
+	KUNIT_CASE(j1939_test_sock2sockaddr_zeroes_padding),
+
+	KUNIT_CASE(j1939_test_errqueue_size_consistency),
+	{}
+};
+
+static struct kunit_suite j1939_socket_test_suite = {
+	.name = "j1939-socket",
+	.test_cases = j1939_socket_test_cases,
+};
+
+kunit_test_suite(j1939_socket_test_suite);
+
+MODULE_IMPORT_NS("EXPORTED_FOR_KUNIT_TESTING");
+MODULE_LICENSE("GPL");
+MODULE_DESCRIPTION("KUnit tests for J1939 socket utilities");
+MODULE_AUTHOR("Oleksij Rempel <kernel@pengutronix.de>");
diff --git a/net/can/j1939/tests/transport_test.c b/net/can/j1939/tests/transport_test.c
new file mode 100644
index 000000000000..493a3f4b3f40
--- /dev/null
+++ b/net/can/j1939/tests/transport_test.c
@@ -0,0 +1,533 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * KUnit tests for J1939 transport layer functions
+ *
+ * Copyright (c) 2026 Pengutronix,
+ *                    Oleksij Rempel <kernel@pengutronix.de>
+ */
+
+#include <kunit/test.h>
+#include <linux/can/j1939.h>
+#include "../j1939-priv.h"
+#include "../j1939-test.h"
+
+/* Abort code to errno conversion for userspace error reporting */
+
+struct abort_errno_map {
+	u8 abort_code;
+	int expected_errno;
+};
+
+static void j1939_test_abort_to_errno(struct kunit *test)
+{
+	static const struct abort_errno_map tests[] = {
+		{ J1939_XTP_ABORT_BUSY, EALREADY },
+		{ J1939_XTP_ABORT_RESOURCE, EMSGSIZE },
+		{ J1939_XTP_ABORT_TIMEOUT, EHOSTUNREACH },
+		{ J1939_XTP_ABORT_GENERIC, EBADMSG },
+		{ J1939_XTP_ABORT_FAULT, ENOTRECOVERABLE },
+		{ J1939_XTP_ABORT_UNEXPECTED_DATA, ENOTCONN },
+		{ J1939_XTP_ABORT_BAD_SEQ, EILSEQ },
+		{ J1939_XTP_ABORT_DUP_SEQ, EPROTO },
+		{ J1939_XTP_ABORT_EDPO_UNEXPECTED, EPROTO },
+		{ J1939_XTP_ABORT_BAD_EDPO_PGN, EPROTO },
+		{ J1939_XTP_ABORT_EDPO_OUTOF_CTS, EPROTO },
+		{ J1939_XTP_ABORT_BAD_EDPO_OFFSET, EPROTO },
+		{ J1939_XTP_ABORT_ECTS_UNXPECTED_PGN, EPROTO },
+		{ J1939_XTP_ABORT_ECTS_TOO_BIG, EPROTO },
+		{ J1939_XTP_ABORT_OTHER, EPROTO },
+		{ 99, EPROTO },  /* unknown */
+		{ 200, EPROTO }, /* unknown */
+	};
+	struct j1939_priv *priv;
+	struct net_device *ndev;
+	int i;
+
+	/* Zero-init safe: netdev_warn only accesses dev->name inline array */
+	ndev = kunit_kzalloc(test, sizeof(*ndev), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, ndev);
+
+	priv = kunit_kzalloc(test, sizeof(*priv), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, priv);
+	priv->ndev = ndev;
+
+	for (i = 0; i < ARRAY_SIZE(tests); i++) {
+		int err = j1939_xtp_abort_to_errno(priv, tests[i].abort_code);
+
+		KUNIT_EXPECT_EQ_MSG(test, err, tests[i].expected_errno,
+				    "abort_code=0x%02x", tests[i].abort_code);
+	}
+}
+
+/* Abort code to string conversion for debug logging */
+
+static void j1939_test_abort_to_str_all_codes(struct kunit *test)
+{
+	const char *str;
+	const char *expected;
+
+	str = j1939_xtp_abort_to_str(J1939_XTP_ABORT_BUSY);
+	expected = "Already in one or more connection managed sessions and cannot support another.";
+	KUNIT_EXPECT_STREQ(test, str, expected);
+
+	str = j1939_xtp_abort_to_str(J1939_XTP_ABORT_RESOURCE);
+	expected = "System resources were needed for another task so this connection managed session was terminated.";
+	KUNIT_EXPECT_STREQ(test, str, expected);
+
+	str = j1939_xtp_abort_to_str(J1939_XTP_ABORT_TIMEOUT);
+	expected = "A timeout occurred and this is the connection abort to close the session.";
+	KUNIT_EXPECT_STREQ(test, str, expected);
+
+	str = j1939_xtp_abort_to_str(J1939_XTP_ABORT_GENERIC);
+	expected = "CTS messages received when data transfer is in progress";
+	KUNIT_EXPECT_STREQ(test, str, expected);
+
+	str = j1939_xtp_abort_to_str(J1939_XTP_ABORT_FAULT);
+	expected = "Maximal retransmit request limit reached";
+	KUNIT_EXPECT_STREQ(test, str, expected);
+
+	str = j1939_xtp_abort_to_str(J1939_XTP_ABORT_UNEXPECTED_DATA);
+	expected = "Unexpected data transfer packet";
+	KUNIT_EXPECT_STREQ(test, str, expected);
+
+	str = j1939_xtp_abort_to_str(J1939_XTP_ABORT_BAD_SEQ);
+	expected = "Bad sequence number (and software is not able to recover)";
+	KUNIT_EXPECT_STREQ(test, str, expected);
+
+	str = j1939_xtp_abort_to_str(J1939_XTP_ABORT_DUP_SEQ);
+	expected = "Duplicate sequence number (and software is not able to recover)";
+	KUNIT_EXPECT_STREQ(test, str, expected);
+
+	str = j1939_xtp_abort_to_str(J1939_XTP_ABORT_OTHER);
+	expected = "Any other reason (if a Connection Abort reason is identified that is not listed in the table use code 250)";
+	KUNIT_EXPECT_STREQ(test, str, expected);
+}
+
+static void j1939_test_abort_to_str_unknown(struct kunit *test)
+{
+	const char *str;
+
+	str = j1939_xtp_abort_to_str(99);
+	KUNIT_EXPECT_STREQ(test, str, "<unknown>");
+
+	str = j1939_xtp_abort_to_str(255);
+	KUNIT_EXPECT_STREQ(test, str, "<unknown>");
+}
+
+/* Control message field extraction from 8-byte transport protocol messages */
+
+static void j1939_test_tp_ctl_to_size(struct kunit *test)
+{
+	u8 dat[8];
+
+	memset(dat, 0, sizeof(dat));
+	dat[1] = 0x00;
+	dat[2] = 0x00;
+	KUNIT_EXPECT_EQ(test, j1939_tp_ctl_to_size_wrapper(dat), 0);
+
+	dat[1] = 0x01;
+	dat[2] = 0x00;
+	KUNIT_EXPECT_EQ(test, j1939_tp_ctl_to_size_wrapper(dat), 1);
+
+	dat[1] = 0xFF;
+	dat[2] = 0x00;
+	KUNIT_EXPECT_EQ(test, j1939_tp_ctl_to_size_wrapper(dat), 255);
+
+	dat[1] = 0x00;
+	dat[2] = 0x01;
+	KUNIT_EXPECT_EQ(test, j1939_tp_ctl_to_size_wrapper(dat), 256);
+
+	dat[1] = 0xF9;
+	dat[2] = 0x06;
+	KUNIT_EXPECT_EQ(test, j1939_tp_ctl_to_size_wrapper(dat), 1785); /* max TP */
+
+	dat[1] = 0xFF;
+	dat[2] = 0xFF;
+	KUNIT_EXPECT_EQ(test, j1939_tp_ctl_to_size_wrapper(dat), 65535);
+}
+
+static void j1939_test_etp_ctl_to_size(struct kunit *test)
+{
+	u8 dat[8];
+
+	memset(dat, 0, sizeof(dat));
+	KUNIT_EXPECT_EQ(test, j1939_etp_ctl_to_size_wrapper(dat), 0);
+
+	dat[1] = 0xFA;
+	dat[2] = 0x06;
+	dat[3] = 0x00;
+	dat[4] = 0x00;
+	KUNIT_EXPECT_EQ(test, j1939_etp_ctl_to_size_wrapper(dat), 1786); /* min ETP */
+
+	dat[1] = 0x00;
+	dat[2] = 0x00;
+	dat[3] = 0x01;
+	dat[4] = 0x00;
+	KUNIT_EXPECT_EQ(test, j1939_etp_ctl_to_size_wrapper(dat), 65536);
+
+	dat[1] = 0xF9;
+	dat[2] = 0xFF;
+	dat[3] = 0xFF;
+	dat[4] = 0x06;
+	KUNIT_EXPECT_EQ(test, j1939_etp_ctl_to_size_wrapper(dat), 117440505); /* max ETP */
+
+	dat[1] = 0xFF;
+	dat[2] = 0xFF;
+	dat[3] = 0xFF;
+	dat[4] = 0xFF;
+	KUNIT_EXPECT_EQ(test, j1939_etp_ctl_to_size_wrapper(dat), 0xFFFFFFFF);
+}
+
+static void j1939_test_etp_ctl_to_packet(struct kunit *test)
+{
+	u8 dat[8];
+
+	memset(dat, 0, sizeof(dat));
+	KUNIT_EXPECT_EQ(test, j1939_etp_ctl_to_packet_wrapper(dat), 0);
+
+	dat[2] = 0x01;
+	dat[3] = 0x00;
+	dat[4] = 0x00;
+	KUNIT_EXPECT_EQ(test, j1939_etp_ctl_to_packet_wrapper(dat), 1);
+
+	dat[2] = 0x00;
+	dat[3] = 0x01;
+	dat[4] = 0x00;
+	KUNIT_EXPECT_EQ(test, j1939_etp_ctl_to_packet_wrapper(dat), 256);
+
+	dat[2] = 0x00;
+	dat[3] = 0x00;
+	dat[4] = 0x01;
+	KUNIT_EXPECT_EQ(test, j1939_etp_ctl_to_packet_wrapper(dat), 65536);
+
+	dat[2] = 0xFF;
+	dat[3] = 0xFF;
+	dat[4] = 0xFF;
+	KUNIT_EXPECT_EQ(test, j1939_etp_ctl_to_packet_wrapper(dat), 0xFFFFFF);
+}
+
+/*
+ * PGN extraction: PDU1 (<0xF000) masks DA bits, PDU2 (>=0xF000) preserves
+ * all bits
+ */
+static void j1939_test_xtp_ctl_to_pgn_pdu1(struct kunit *test)
+{
+	u8 dat[8];
+
+	memset(dat, 0, sizeof(dat));
+	dat[5] = 0x00;
+	dat[6] = 0xEF;
+	dat[7] = 0x00;
+	KUNIT_EXPECT_EQ(test, j1939_xtp_ctl_to_pgn_wrapper(dat), 0xEF00);
+
+	dat[5] = 0x25; /* DA should be masked */
+	dat[6] = 0xEF;
+	dat[7] = 0x00;
+	KUNIT_EXPECT_EQ(test, j1939_xtp_ctl_to_pgn_wrapper(dat), 0xEF00);
+
+	dat[5] = 0xFF;
+	dat[6] = 0xEA;
+	dat[7] = 0x00;
+	KUNIT_EXPECT_EQ(test, j1939_xtp_ctl_to_pgn_wrapper(dat), 0xEA00);
+
+	dat[5] = 0x00;
+	dat[6] = 0x00;
+	dat[7] = 0x00;
+	KUNIT_EXPECT_EQ(test, j1939_xtp_ctl_to_pgn_wrapper(dat), 0x0000);
+}
+
+static void j1939_test_xtp_ctl_to_pgn_pdu2(struct kunit *test)
+{
+	u8 dat[8];
+
+	memset(dat, 0, sizeof(dat));
+	dat[5] = 0x00;
+	dat[6] = 0xF0;
+	dat[7] = 0x00;
+	KUNIT_EXPECT_EQ(test, j1939_xtp_ctl_to_pgn_wrapper(dat), 0xF000);
+
+	dat[5] = 0xCA; /* GE preserved */
+	dat[6] = 0xFE;
+	dat[7] = 0x00;
+	KUNIT_EXPECT_EQ(test, j1939_xtp_ctl_to_pgn_wrapper(dat), 0xFECA);
+
+	dat[5] = 0xEC;
+	dat[6] = 0xFE;
+	dat[7] = 0x00;
+	KUNIT_EXPECT_EQ(test, j1939_xtp_ctl_to_pgn_wrapper(dat), 0xFEEC);
+
+	dat[5] = 0xFF;
+	dat[6] = 0xFF;
+	dat[7] = 0x03;
+	KUNIT_EXPECT_EQ(test, j1939_xtp_ctl_to_pgn_wrapper(dat), 0x3FFFF);
+}
+
+/* Broadcast detection: dst_name=0 and da=0xFF */
+
+static void j1939_test_cb_is_broadcast_true(struct kunit *test)
+{
+	struct j1939_sk_buff_cb skcb = {
+		.addr = {
+			.dst_name = 0,
+			.da = 0xFF,
+		},
+	};
+
+	KUNIT_EXPECT_TRUE(test, j1939_cb_is_broadcast_wrapper(&skcb));
+}
+
+static void j1939_test_cb_is_broadcast_unicast_addr(struct kunit *test)
+{
+	struct j1939_sk_buff_cb skcb = {
+		.addr = {
+			.dst_name = 0,
+			.da = 0x25,
+		},
+	};
+
+	KUNIT_EXPECT_FALSE(test, j1939_cb_is_broadcast_wrapper(&skcb));
+}
+
+static void j1939_test_cb_is_broadcast_unicast_name(struct kunit *test)
+{
+	struct j1939_sk_buff_cb skcb = {
+		.addr = {
+			.dst_name = 0x1234567890ABCDEF,
+			.da = 0xFF,
+		},
+	};
+
+	KUNIT_EXPECT_FALSE(test, j1939_cb_is_broadcast_wrapper(&skcb));
+}
+
+/*
+ * SKB control buffer swap for reply messages: swaps src<->dst addresses and
+ * flags
+ */
+static void j1939_test_skbcb_swap_addresses(struct kunit *test)
+{
+	struct j1939_sk_buff_cb skcb = {
+		.addr = {
+			.src_name = 0x1111111111111111,
+			.dst_name = 0x2222222222222222,
+			.sa = 0x10,
+			.da = 0x20,
+		},
+	};
+
+	j1939_skbcb_swap(&skcb);
+
+	KUNIT_EXPECT_EQ(test, skcb.addr.src_name, 0x2222222222222222ULL);
+	KUNIT_EXPECT_EQ(test, skcb.addr.dst_name, 0x1111111111111111ULL);
+	KUNIT_EXPECT_EQ(test, skcb.addr.sa, 0x20);
+	KUNIT_EXPECT_EQ(test, skcb.addr.da, 0x10);
+}
+
+static void j1939_test_skbcb_swap_flags(struct kunit *test)
+{
+	struct j1939_sk_buff_cb skcb;
+
+	skcb.flags = J1939_ECU_LOCAL_SRC;
+	j1939_skbcb_swap(&skcb);
+	KUNIT_EXPECT_EQ(test, skcb.flags & J1939_ECU_LOCAL_DST,
+			J1939_ECU_LOCAL_DST);
+	KUNIT_EXPECT_EQ(test, skcb.flags & J1939_ECU_LOCAL_SRC, 0);
+
+	skcb.flags = J1939_ECU_LOCAL_DST;
+	j1939_skbcb_swap(&skcb);
+	KUNIT_EXPECT_EQ(test, skcb.flags & J1939_ECU_LOCAL_SRC,
+			J1939_ECU_LOCAL_SRC);
+	KUNIT_EXPECT_EQ(test, skcb.flags & J1939_ECU_LOCAL_DST, 0);
+
+	skcb.flags = J1939_ECU_LOCAL_SRC | J1939_ECU_LOCAL_DST;
+	j1939_skbcb_swap(&skcb);
+	KUNIT_EXPECT_EQ(test, skcb.flags & (J1939_ECU_LOCAL_SRC |
+					    J1939_ECU_LOCAL_DST),
+			J1939_ECU_LOCAL_SRC | J1939_ECU_LOCAL_DST);
+
+	skcb.flags = 0;
+	j1939_skbcb_swap(&skcb);
+	KUNIT_EXPECT_EQ(test,
+			skcb.flags & (J1939_ECU_LOCAL_SRC |
+				      J1939_ECU_LOCAL_DST), 0);
+}
+
+static void j1939_test_skbcb_swap_preserves_other_flags(struct kunit *test)
+{
+	struct j1939_sk_buff_cb skcb;
+
+	skcb.flags = J1939_ECU_LOCAL_SRC | 0xF0;
+	j1939_skbcb_swap(&skcb);
+
+	KUNIT_EXPECT_EQ(test, skcb.flags & 0xF0, 0xF0);
+	KUNIT_EXPECT_EQ(test, skcb.flags & J1939_ECU_LOCAL_DST,
+			J1939_ECU_LOCAL_DST);
+	KUNIT_EXPECT_EQ(test, skcb.flags & J1939_ECU_LOCAL_SRC, 0);
+}
+
+/* Session matching for finding active sessions: by type, name, or address */
+
+static void j1939_test_session_match_exact(struct kunit *test)
+{
+	struct j1939_addr se_addr = {
+		.type = J1939_TP,
+		.src_name = 0x1111111111111111,
+		.dst_name = 0x2222222222222222,
+		.sa = 0x10,
+		.da = 0x20,
+	};
+	struct j1939_addr sk_addr = {
+		.type = J1939_TP,
+		.src_name = 0x1111111111111111,
+		.dst_name = 0x2222222222222222,
+		.sa = 0x10,
+		.da = 0x20,
+	};
+
+	KUNIT_EXPECT_TRUE(test, j1939_session_match(&se_addr, &sk_addr, false));
+}
+
+static void j1939_test_session_match_reverse(struct kunit *test)
+{
+	struct j1939_addr se_addr = {
+		.type = J1939_TP,
+		.src_name = 0x1111111111111111,
+		.dst_name = 0x2222222222222222,
+		.sa = 0x10,
+		.da = 0x20,
+	};
+	struct j1939_addr sk_addr = {
+		.type = J1939_TP,
+		.src_name = 0x2222222222222222,
+		.dst_name = 0x1111111111111111,
+		.sa = 0x20,
+		.da = 0x10,
+	};
+
+	KUNIT_EXPECT_TRUE(test, j1939_session_match(&se_addr, &sk_addr, true));
+	KUNIT_EXPECT_FALSE(test,
+			   j1939_session_match(&se_addr, &sk_addr, false));
+}
+
+static void j1939_test_session_match_type_mismatch(struct kunit *test)
+{
+	struct j1939_addr se_addr = {
+		.type = J1939_TP,
+		.src_name = 0x1111111111111111,
+		.dst_name = 0x2222222222222222,
+		.sa = 0x10,
+		.da = 0x20,
+	};
+	struct j1939_addr sk_addr = {
+		.type = J1939_ETP,
+		.src_name = 0x1111111111111111,
+		.dst_name = 0x2222222222222222,
+		.sa = 0x10,
+		.da = 0x20,
+	};
+
+	KUNIT_EXPECT_FALSE(test, j1939_session_match(&se_addr, &sk_addr, false));
+}
+
+/* NAME matching takes priority over address (NAME is stable, address can change) */
+static void j1939_test_session_match_name_priority(struct kunit *test)
+{
+	struct j1939_addr se_addr = {
+		.type = J1939_TP,
+		.src_name = 0x1111111111111111,
+		.dst_name = 0x2222222222222222,
+		.sa = 0x10,
+		.da = 0x20,
+	};
+	struct j1939_addr sk_addr = {
+		.type = J1939_TP,
+		.src_name = 0x1111111111111111,
+		.dst_name = 0x2222222222222222,
+		.sa = 0x99,
+		.da = 0x88,
+	};
+
+	KUNIT_EXPECT_TRUE(test, j1939_session_match(&se_addr, &sk_addr, false));
+}
+
+static void j1939_test_session_match_addr_fallback(struct kunit *test)
+{
+	struct j1939_addr se_addr = {
+		.type = J1939_TP,
+		.src_name = 0,
+		.dst_name = 0,
+		.sa = 0x10,
+		.da = 0x20,
+	};
+	struct j1939_addr sk_addr = {
+		.type = J1939_TP,
+		.src_name = 0,
+		.dst_name = 0,
+		.sa = 0x10,
+		.da = 0x20,
+	};
+
+	KUNIT_EXPECT_TRUE(test, j1939_session_match(&se_addr, &sk_addr, false));
+}
+
+static void j1939_test_session_match_addr_mismatch(struct kunit *test)
+{
+	struct j1939_addr se_addr = {
+		.type = J1939_TP,
+		.src_name = 0,
+		.dst_name = 0,
+		.sa = 0x10,
+		.da = 0x20,
+	};
+	struct j1939_addr sk_addr = {
+		.type = J1939_TP,
+		.src_name = 0,
+		.dst_name = 0,
+		.sa = 0x11,
+		.da = 0x20,
+	};
+
+	KUNIT_EXPECT_FALSE(test, j1939_session_match(&se_addr, &sk_addr, false));
+}
+
+static struct kunit_case j1939_transport_test_cases[] = {
+	KUNIT_CASE(j1939_test_abort_to_errno),
+
+	KUNIT_CASE(j1939_test_abort_to_str_all_codes),
+	KUNIT_CASE(j1939_test_abort_to_str_unknown),
+
+	KUNIT_CASE(j1939_test_tp_ctl_to_size),
+	KUNIT_CASE(j1939_test_etp_ctl_to_size),
+	KUNIT_CASE(j1939_test_etp_ctl_to_packet),
+	KUNIT_CASE(j1939_test_xtp_ctl_to_pgn_pdu1),
+	KUNIT_CASE(j1939_test_xtp_ctl_to_pgn_pdu2),
+
+	KUNIT_CASE(j1939_test_cb_is_broadcast_true),
+	KUNIT_CASE(j1939_test_cb_is_broadcast_unicast_addr),
+	KUNIT_CASE(j1939_test_cb_is_broadcast_unicast_name),
+
+	KUNIT_CASE(j1939_test_skbcb_swap_addresses),
+	KUNIT_CASE(j1939_test_skbcb_swap_flags),
+	KUNIT_CASE(j1939_test_skbcb_swap_preserves_other_flags),
+
+	KUNIT_CASE(j1939_test_session_match_exact),
+	KUNIT_CASE(j1939_test_session_match_reverse),
+	KUNIT_CASE(j1939_test_session_match_type_mismatch),
+	KUNIT_CASE(j1939_test_session_match_name_priority),
+	KUNIT_CASE(j1939_test_session_match_addr_fallback),
+	KUNIT_CASE(j1939_test_session_match_addr_mismatch),
+
+	{}
+};
+
+static struct kunit_suite j1939_transport_test_suite = {
+	.name = "j1939-transport",
+	.test_cases = j1939_transport_test_cases,
+};
+
+kunit_test_suite(j1939_transport_test_suite);
+
+MODULE_IMPORT_NS("EXPORTED_FOR_KUNIT_TESTING");
+MODULE_LICENSE("GPL");
+MODULE_DESCRIPTION("KUnit tests for J1939 transport layer");
+MODULE_AUTHOR("Oleksij Rempel <kernel@pengutronix.de>");
diff --git a/net/can/j1939/transport.c b/net/can/j1939/transport.c
index 46540da76ca9..8cd95d5fc387 100644
--- a/net/can/j1939/transport.c
+++ b/net/can/j1939/transport.c
@@ -10,8 +10,10 @@
 
 #include <linux/can/skb.h>
 #include <net/can.h>
+#include <kunit/visibility.h>
 
 #include "j1939-priv.h"
+#include "j1939-test.h"
 
 #define J1939_XTP_TX_RETRY_LIMIT 100
 
@@ -37,7 +39,7 @@ static unsigned int j1939_tp_packet_delay;
 static unsigned int j1939_tp_padding = 1;
 
 /* helpers */
-static const char *j1939_xtp_abort_to_str(enum j1939_xtp_abort abort)
+VISIBLE_IF_KUNIT const char *j1939_xtp_abort_to_str(enum j1939_xtp_abort abort)
 {
 	switch (abort) {
 	case J1939_XTP_ABORT_BUSY:
@@ -76,9 +78,10 @@ static const char *j1939_xtp_abort_to_str(enum j1939_xtp_abort abort)
 		return "<unknown>";
 	}
 }
+EXPORT_SYMBOL_IF_KUNIT(j1939_xtp_abort_to_str);
 
-static int j1939_xtp_abort_to_errno(struct j1939_priv *priv,
-				    enum j1939_xtp_abort abort)
+VISIBLE_IF_KUNIT int j1939_xtp_abort_to_errno(struct j1939_priv *priv,
+					       enum j1939_xtp_abort abort)
 {
 	int err;
 
@@ -142,6 +145,7 @@ static int j1939_xtp_abort_to_errno(struct j1939_priv *priv,
 
 	return err;
 }
+EXPORT_SYMBOL_IF_KUNIT(j1939_xtp_abort_to_errno);
 
 static inline void j1939_session_list_lock(struct j1939_priv *priv)
 {
@@ -375,14 +379,47 @@ static inline unsigned int j1939_etp_ctl_to_size(const u8 *dat)
 		(dat[2] << 8) | (dat[1] << 0);
 }
 
+#if IS_ENABLED(CONFIG_KUNIT)
+/* Wrappers for testing inline functions - no production overhead */
+VISIBLE_IF_KUNIT bool j1939_cb_is_broadcast_wrapper(const struct j1939_sk_buff_cb *skcb)
+{
+	return j1939_cb_is_broadcast(skcb);
+}
+EXPORT_SYMBOL_IF_KUNIT(j1939_cb_is_broadcast_wrapper);
+
+VISIBLE_IF_KUNIT pgn_t j1939_xtp_ctl_to_pgn_wrapper(const u8 *dat)
+{
+	return j1939_xtp_ctl_to_pgn(dat);
+}
+EXPORT_SYMBOL_IF_KUNIT(j1939_xtp_ctl_to_pgn_wrapper);
+
+VISIBLE_IF_KUNIT unsigned int j1939_tp_ctl_to_size_wrapper(const u8 *dat)
+{
+	return j1939_tp_ctl_to_size(dat);
+}
+EXPORT_SYMBOL_IF_KUNIT(j1939_tp_ctl_to_size_wrapper);
+
+VISIBLE_IF_KUNIT unsigned int j1939_etp_ctl_to_packet_wrapper(const u8 *dat)
+{
+	return j1939_etp_ctl_to_packet(dat);
+}
+EXPORT_SYMBOL_IF_KUNIT(j1939_etp_ctl_to_packet_wrapper);
+
+VISIBLE_IF_KUNIT unsigned int j1939_etp_ctl_to_size_wrapper(const u8 *dat)
+{
+	return j1939_etp_ctl_to_size(dat);
+}
+EXPORT_SYMBOL_IF_KUNIT(j1939_etp_ctl_to_size_wrapper);
+#endif
+
 /* find existing session:
  * reverse: swap cb's src & dst
  * there is no problem with matching broadcasts, since
  * broadcasts (no dst, no da) would never call this
  * with reverse == true
  */
-static bool j1939_session_match(struct j1939_addr *se_addr,
-				struct j1939_addr *sk_addr, bool reverse)
+VISIBLE_IF_KUNIT bool j1939_session_match(struct j1939_addr *se_addr,
+					  struct j1939_addr *sk_addr, bool reverse)
 {
 	if (se_addr->type != sk_addr->type)
 		return false;
@@ -419,6 +456,7 @@ static bool j1939_session_match(struct j1939_addr *se_addr,
 
 	return true;
 }
+EXPORT_SYMBOL_IF_KUNIT(j1939_session_match);
 
 static struct
 j1939_session *j1939_session_get_by_addr_locked(struct j1939_priv *priv,
@@ -478,7 +516,7 @@ j1939_session *j1939_session_get_by_addr(struct j1939_priv *priv,
 	return session;
 }
 
-static void j1939_skbcb_swap(struct j1939_sk_buff_cb *skcb)
+VISIBLE_IF_KUNIT void j1939_skbcb_swap(struct j1939_sk_buff_cb *skcb)
 {
 	u8 tmp = 0;
 
@@ -493,6 +531,7 @@ static void j1939_skbcb_swap(struct j1939_sk_buff_cb *skcb)
 	skcb->flags &= ~(J1939_ECU_LOCAL_SRC | J1939_ECU_LOCAL_DST);
 	skcb->flags |= tmp;
 }
+EXPORT_SYMBOL_IF_KUNIT(j1939_skbcb_swap);
 
 static struct
 sk_buff *j1939_tp_tx_dat_new(struct j1939_priv *priv,
-- 
2.47.3


