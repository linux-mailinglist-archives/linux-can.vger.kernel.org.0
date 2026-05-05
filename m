Return-Path: <linux-can+bounces-7526-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mMIYFA3T+WlHEQMAu9opvQ
	(envelope-from <linux-can+bounces-7526-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Tue, 05 May 2026 13:22:53 +0200
X-Original-To: lists+linux-can@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C5EDB4CC83F
	for <lists+linux-can@lfdr.de>; Tue, 05 May 2026 13:22:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 190CB329800B
	for <lists+linux-can@lfdr.de>; Tue,  5 May 2026 11:14:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECC7938550C;
	Tue,  5 May 2026 11:13:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b="ENBkQrxD"
X-Original-To: linux-can@vger.kernel.org
Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E07D3845CB;
	Tue,  5 May 2026 11:13:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.195.75.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777979609; cv=none; b=CdVCJA8/cNVdDySnOGyRaVdBR3PXdyz7nbezzXDT8gqCmKQ48g1Jhnlvn1ElpBlqOCkpK1920COiXpkvSC8TUZC2OHT6/0KN4y/duPIRJk3AQy0AgQ97KL6zdCAzl5y9ckmPh4HlW/bjWRbBEEGabkmaF0uVy2Y4e62dsZ7B21c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777979609; c=relaxed/simple;
	bh=ZblwTyaegNe9+CouwbLgVpfsz7uOchguMNbgnleId9I=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=dKDsRZBLHUiGCVr8WAgE79JO+0qTjVDqlZ441ZWLEp+jqA0NEzvoNHcbrPSUKaKLagK1QX1aBxARA1R2KOWsNboelqOrg3tbTw0wt0AmA7LTZRgjM21VQucnklTntlukC9kWG1ehHgwseU7rszenCpTCcAudi5mXO8m8UaXayMA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=ENBkQrxD; arc=none smtp.client-ip=82.195.75.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=debian.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:Cc:To:In-Reply-To:References:
	Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Reply-To:Content-ID:Content-Description;
	bh=Bqe/zD7LskMy2G3eFF3zEJe6jOJIwijXS9A/g0YCPPE=; b=ENBkQrxDmJixq4mZe0ip0sELmv
	SDFmPrPrPNnJtHCPZwrj7bfEvk7H1R+62qziJdmsKK74AM74xV+l4SVJBLNmaRdX8gR5Yyazs/Lfk
	k+YrVq02UHeHrrsMz1C1n5ytYwGoOjQgBNXYO4fQnKjc2njsEE8dUeNtnr4q4I5OidMa3jlmmaTK4
	LhAsaa7i1WKMuGS/rvSgb/3KSrUxbxc2sL/3mFLmm6EFa+C12OqOSE1VoMLU78JsGxQgHpVKl10Iz
	xK9trx0Wm6rZ2JD8BpVrUgyGq9rDnOgp0dDZ9yJR/j16CuIK9gY/hjP3gfloS1dVOh+2k3VH8ZQoE
	ZVHBcIfQ==;
Received: from authenticated user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <leitao@debian.org>)
	id 1wKDiI-002lYr-1V;
	Tue, 05 May 2026 11:13:18 +0000
From: Breno Leitao <leitao@debian.org>
Date: Tue, 05 May 2026 04:12:42 -0700
Subject: [PATCH net-next 5/5] selftests: net: getsockopt_iter: address
 review nits
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260505-getsock_two-v1-5-4cb0738950e0@debian.org>
References: <20260505-getsock_two-v1-0-4cb0738950e0@debian.org>
In-Reply-To: <20260505-getsock_two-v1-0-4cb0738950e0@debian.org>
To: Oliver Hartkopp <socketcan@hartkopp.net>, 
 Marc Kleine-Budde <mkl@pengutronix.de>, 
 Robin van der Gracht <robin@protonic.nl>, 
 Oleksij Rempel <o.rempel@pengutronix.de>, kernel@pengutronix.de, 
 Jeremy Kerr <jk@codeconstruct.com.au>, 
 Matt Johnston <matt@codeconstruct.com.au>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, Shuah Khan <shuah@kernel.org>
Cc: linux-can@vger.kernel.org, linux-kernel@vger.kernel.org, 
 netdev@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 Breno Leitao <leitao@debian.org>, kernel-team@meta.com, 
 Stanislav Fomichev <sdf@fomichev.me>, 
 Bobby Eshleman <bobbyeshleman@meta.com>
X-Mailer: b4 0.16-dev-453a6
X-Developer-Signature: v=1; a=openpgp-sha256; l=7234; i=leitao@debian.org;
 h=from:subject:message-id; bh=ZblwTyaegNe9+CouwbLgVpfsz7uOchguMNbgnleId9I=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBp+dCvklKzmA/XoAlwyLs6WEZJ0B3Dabm2YjToO
 7vlOqNdz0+JAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCafnQrwAKCRA1o5Of/Hh3
 bWCCD/9uesE3aSSTLMUl/SHCnrXCdgheJGARCGWP/i00L7JhSjC5AxwsitKqD+ltYMdcvSJqg39
 bpvxsqSoOa6JARHeCeavPp8BC+1heI840qggS1BoLYamF+fwqPIqW00136nT0hcRqzQp518RboY
 +0Ev16BnSRLt8sykpfcy/3XDk/bXtY/S+fbHSkiOdTw5SdRnOjuM8yImxu8AAA5KmUM5Y+WlK6l
 ZpQh+cCoo+qz6Zo6+smdJHnyXACa4jmDBqHMG3aikDpXwpbtkaQTkTV+bxzqTIz1ZN1Ay7Ftd5F
 +/oGfrTWGN70/BFWmru+7r/2wXyM9+n5GJVg+pgdY3AMXwjTwG6uDWssfvpckJh+I/Cu/HXcQRp
 l4xE9ggMOFy72rA5G9FBETAFGbT7NdskbG4QVdvgdppQ5E3jrElgD3U15EJmY8gRw1Nu8cE8A8R
 du+4Arv6GtTv3SBaVBXOmCrGjmCzPZ7IGkncZCQz+CmfVn6o/oVr29DM8q87n3UA70zDIgsLsgO
 d+W8/jZ0t+YC4EjDRbBUaQRuaFaYFnWF/J6S68kp7IEuDnvJdf345Sj5jbtBGAFs4EDxK5mn+h8
 3kCzcbfErmGnJr6x3pqBtLFWAlDI7HtPYCmpysAt5VZXLOcNlx7awjztVzC8v0LUhJzWuG4Z5O3
 HPjUpWCusMgDo0A==
X-Developer-Key: i=leitao@debian.org; a=openpgp;
 fpr=AC8539A6E8F46702CA4A439B35A3939FFC78776D
X-Debian-User: leitao
X-Rspamd-Queue-Id: C5EDB4CC83F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[debian.org,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[debian.org:s=smtpauto.stravinsky];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-7526-lists,linux-can=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[21];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[leitao@debian.org,linux-can@vger.kernel.org];
	DKIM_TRACE(0.00)[debian.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-can];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[meta.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,fomichev.me:email]

Apply two cleanups suggested by Stanislav Fomichev on the original
selftest series:

- Reorder local variable declarations into reverse christmas-tree
  order (longest line first). Because that ordering puts socklen_t
  optlen before the variable whose size it stores, the
  "optlen = sizeof(...)" initializer is moved out of the declaration
  to a plain assignment in the test body, as Stanislav suggested.

- Add ASSERT_EQ(optlen, ...) on every error path so the value the
  kernel writes back to the userspace optlen is pinned down even
  when the syscall returns -1. With do_sock_getsockopt() now writing
  opt->optlen back to userspace unconditionally, asserting that the
  netlink/vsock error paths leave the original input length untouched
  guards against future regressions.

Bobby Eshleman pointed out that
SO_VM_SOCKETS_CONNECT_TIMEOUT_NEW/OLD return a sock_timeval-shaped
payload (16 bytes on 64-bit), which is wider than the u64 case
already covered. Add four tests that exercise this path:

- connect_timeout_new_exact         exact-size buffer
- connect_timeout_new_oversize_clamped  oversize buffer, clamped
- connect_timeout_new_undersize     undersize -> -EINVAL, optlen
                                    untouched
- connect_timeout_old_exact         exact-size buffer for OLD optname

Suggested-by: Stanislav Fomichev <sdf@fomichev.me>
Suggested-by: Bobby Eshleman <bobbyeshleman@meta.com>
Signed-off-by: Breno Leitao <leitao@debian.org>
---
 tools/testing/selftests/net/getsockopt_iter.c | 109 +++++++++++++++++++++++---
 1 file changed, 98 insertions(+), 11 deletions(-)

diff --git a/tools/testing/selftests/net/getsockopt_iter.c b/tools/testing/selftests/net/getsockopt_iter.c
index 179f9e84926fd..209569354d0e3 100644
--- a/tools/testing/selftests/net/getsockopt_iter.c
+++ b/tools/testing/selftests/net/getsockopt_iter.c
@@ -22,6 +22,7 @@
 #include <unistd.h>
 #include <linux/netlink.h>
 #include <linux/rtnetlink.h>
+#include <linux/time_types.h>
 #include <linux/vm_sockets.h>
 #include <sys/socket.h>
 #include "kselftest_harness.h"
@@ -61,8 +62,10 @@ FIXTURE_TEARDOWN(netlink)
 
 TEST_F(netlink, pktinfo_exact)
 {
+	socklen_t optlen;
 	int val = -1;
-	socklen_t optlen = sizeof(val);
+
+	optlen = sizeof(val);
 
 	ASSERT_EQ(0, getsockopt(self->fd, SOL_NETLINK, NETLINK_PKTINFO,
 				&val, &optlen));
@@ -73,7 +76,9 @@ TEST_F(netlink, pktinfo_exact)
 TEST_F(netlink, pktinfo_oversize_clamped)
 {
 	char buf[16] = {};
-	socklen_t optlen = sizeof(buf);
+	socklen_t optlen;
+
+	optlen = sizeof(buf);
 
 	ASSERT_EQ(0, getsockopt(self->fd, SOL_NETLINK, NETLINK_PKTINFO,
 				buf, &optlen));
@@ -83,11 +88,14 @@ TEST_F(netlink, pktinfo_oversize_clamped)
 TEST_F(netlink, pktinfo_undersize)
 {
 	char buf[2] = {};
-	socklen_t optlen = sizeof(buf);
+	socklen_t optlen;
+
+	optlen = sizeof(buf);
 
 	ASSERT_EQ(-1, getsockopt(self->fd, SOL_NETLINK, NETLINK_PKTINFO,
 				 buf, &optlen));
 	ASSERT_EQ(EINVAL, errno);
+	ASSERT_EQ(sizeof(buf), optlen);
 }
 
 TEST_F(netlink, list_memberships_size_discovery)
@@ -105,7 +113,9 @@ TEST_F(netlink, list_memberships_size_discovery)
 TEST_F(netlink, list_memberships_full_read)
 {
 	__u32 buf[64] = {};
-	socklen_t optlen = sizeof(buf);
+	socklen_t optlen;
+
+	optlen = sizeof(buf);
 
 	ASSERT_EQ(0, getsockopt(self->fd, SOL_NETLINK,
 				NETLINK_LIST_MEMBERSHIPS,
@@ -117,22 +127,28 @@ TEST_F(netlink, list_memberships_full_read)
 
 TEST_F(netlink, bad_level)
 {
+	socklen_t optlen;
 	int val;
-	socklen_t optlen = sizeof(val);
+
+	optlen = sizeof(val);
 
 	ASSERT_EQ(-1, getsockopt(self->fd, SOL_SOCKET + 1, NETLINK_PKTINFO,
 				 &val, &optlen));
 	ASSERT_EQ(ENOPROTOOPT, errno);
+	ASSERT_EQ(sizeof(val), optlen);
 }
 
 TEST_F(netlink, bad_optname)
 {
+	socklen_t optlen;
 	int val;
-	socklen_t optlen = sizeof(val);
+
+	optlen = sizeof(val);
 
 	ASSERT_EQ(-1, getsockopt(self->fd, SOL_NETLINK, 0x7fff,
 				 &val, &optlen));
 	ASSERT_EQ(ENOPROTOOPT, errno);
+	ASSERT_EQ(sizeof(val), optlen);
 }
 
 /* ---------- vsock ---------- */
@@ -157,8 +173,10 @@ FIXTURE_TEARDOWN(vsock)
 
 TEST_F(vsock, buffer_size_exact)
 {
+	socklen_t optlen;
 	uint64_t val = 0;
-	socklen_t optlen = sizeof(val);
+
+	optlen = sizeof(val);
 
 	ASSERT_EQ(0, getsockopt(self->fd, AF_VSOCK,
 				SO_VM_SOCKETS_BUFFER_SIZE,
@@ -170,7 +188,9 @@ TEST_F(vsock, buffer_size_exact)
 TEST_F(vsock, buffer_size_oversize_clamped)
 {
 	char buf[16] = {};
-	socklen_t optlen = sizeof(buf);
+	socklen_t optlen;
+
+	optlen = sizeof(buf);
 
 	ASSERT_EQ(0, getsockopt(self->fd, AF_VSOCK,
 				SO_VM_SOCKETS_BUFFER_SIZE,
@@ -181,33 +201,100 @@ TEST_F(vsock, buffer_size_oversize_clamped)
 TEST_F(vsock, buffer_size_undersize)
 {
 	char buf[4] = {};
-	socklen_t optlen = sizeof(buf);
+	socklen_t optlen;
+
+	optlen = sizeof(buf);
 
 	ASSERT_EQ(-1, getsockopt(self->fd, AF_VSOCK,
 				 SO_VM_SOCKETS_BUFFER_SIZE,
 				 buf, &optlen));
 	ASSERT_EQ(EINVAL, errno);
+	ASSERT_EQ(sizeof(buf), optlen);
 }
 
 TEST_F(vsock, bad_level)
 {
+	socklen_t optlen;
 	uint64_t val;
-	socklen_t optlen = sizeof(val);
+
+	optlen = sizeof(val);
 
 	ASSERT_EQ(-1, getsockopt(self->fd, SOL_SOCKET + 1,
 				 SO_VM_SOCKETS_BUFFER_SIZE,
 				 &val, &optlen));
 	ASSERT_EQ(ENOPROTOOPT, errno);
+	ASSERT_EQ(sizeof(val), optlen);
 }
 
 TEST_F(vsock, bad_optname)
 {
+	socklen_t optlen;
 	uint64_t val;
-	socklen_t optlen = sizeof(val);
+
+	optlen = sizeof(val);
 
 	ASSERT_EQ(-1, getsockopt(self->fd, AF_VSOCK, 0x7fff,
 				 &val, &optlen));
 	ASSERT_EQ(ENOPROTOOPT, errno);
+	ASSERT_EQ(sizeof(val), optlen);
+}
+
+/* SO_VM_SOCKETS_CONNECT_TIMEOUT_{NEW,OLD} return a sock_timeval-shaped
+ * payload, which is wider than u64 on 64-bit. They exercise the path
+ * where the protocol's reported lv (16 bytes) is larger than the
+ * common 8-byte u64 case covered above.
+ */
+TEST_F(vsock, connect_timeout_new_exact)
+{
+	struct __kernel_sock_timeval tv = {};
+	socklen_t optlen;
+
+	optlen = sizeof(tv);
+
+	ASSERT_EQ(0, getsockopt(self->fd, AF_VSOCK,
+				SO_VM_SOCKETS_CONNECT_TIMEOUT_NEW,
+				&tv, &optlen));
+	ASSERT_EQ(sizeof(tv), optlen);
+}
+
+TEST_F(vsock, connect_timeout_new_oversize_clamped)
+{
+	char buf[sizeof(struct __kernel_sock_timeval) * 2] = {};
+	socklen_t optlen;
+
+	optlen = sizeof(buf);
+
+	ASSERT_EQ(0, getsockopt(self->fd, AF_VSOCK,
+				SO_VM_SOCKETS_CONNECT_TIMEOUT_NEW,
+				buf, &optlen));
+	ASSERT_EQ(sizeof(struct __kernel_sock_timeval), optlen);
+}
+
+TEST_F(vsock, connect_timeout_new_undersize)
+{
+	socklen_t optlen;
+	uint64_t val;
+
+	optlen = sizeof(val);
+
+	ASSERT_EQ(-1, getsockopt(self->fd, AF_VSOCK,
+				 SO_VM_SOCKETS_CONNECT_TIMEOUT_NEW,
+				 &val, &optlen));
+	ASSERT_EQ(EINVAL, errno);
+	ASSERT_EQ(sizeof(val), optlen);
+}
+
+TEST_F(vsock, connect_timeout_old_exact)
+{
+	struct __kernel_old_timeval tv = {};
+	socklen_t optlen;
+
+	optlen = sizeof(tv);
+
+	ASSERT_EQ(0, getsockopt(self->fd, AF_VSOCK,
+				SO_VM_SOCKETS_CONNECT_TIMEOUT_OLD,
+				&tv, &optlen));
+	ASSERT_EQ(sizeof(tv), optlen);
 }
 
 TEST_HARNESS_MAIN

-- 
2.52.0


