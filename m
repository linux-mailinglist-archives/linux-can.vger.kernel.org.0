Return-Path: <linux-can+bounces-7522-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eBy2Cj3W+WmDEgMAu9opvQ
	(envelope-from <linux-can+bounces-7522-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Tue, 05 May 2026 13:36:29 +0200
X-Original-To: lists+linux-can@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C06814CCC33
	for <lists+linux-can@lfdr.de>; Tue, 05 May 2026 13:36:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 097F5320B6EB
	for <lists+linux-can@lfdr.de>; Tue,  5 May 2026 11:13:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52FFB388371;
	Tue,  5 May 2026 11:13:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b="jS/E9p3u"
X-Original-To: linux-can@vger.kernel.org
Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3C5E3603D1;
	Tue,  5 May 2026 11:13:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.195.75.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777979592; cv=none; b=BIvtD8J05UYY1DXiALDd/xuUHoFv+IZBcGYrNVwk6juUbqNBVkjfoUrZAVg9tME/mbjejie+iTiCRT5UhgNpEcWRqGG+iKws4s/RSEw0kFjkc1yh3vJri5i6MJeHUByODL6oqxWksu2Bx7kXLWgEGbfo9fd17xhPDx+a92oSUi4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777979592; c=relaxed/simple;
	bh=Q4ba2KfkdI2NRlz65g0omXf9tdpZDQdN4/pOtUn4u1M=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=gZWVPZ/ZP09Q4VNgrRoIaURQ4Pd6oO1GfwWfVzK4SPbZiOJUekDN7cjDDJoUwgSC7Kzy8KnvlpImMl300yBqfNsqiBeVuEaUzkRMk0ZmJ9HmIYx0xcfWlRZkabHzmOCe4oWsnSmpkNSq5dYyvZNCCiyuLhx29QSX5nTNlM4YO8k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=jS/E9p3u; arc=none smtp.client-ip=82.195.75.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=debian.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:Cc:To:In-Reply-To:References:
	Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Reply-To:Content-ID:Content-Description;
	bh=H/qWYI4vjdK5EAO0/fYWz00DJA1aDMQsgecwuI16Hxg=; b=jS/E9p3usZoq8ci2SQ/7d2v7nA
	GKlXOFhLq+ZOgEAP1bzT32mdf+yI9XDMlsGNYeE+lbHy0diWCiwDG3kNKQ0XNq+Vuf5hm9ASa3AWO
	5C+Tlk6fObVwqivnMob2bVFWhizDdFExLFU2IpubzEX+zKJXMZvLieAiJQHZKnSXHiMBhKo4JJbQe
	6h+88Cpdvv+HrP3tFdyKD8GULQOPiTRO9e6hSuSuKI11f5GrifhyiNFn1LY2A7HJfGt5EkkAK73tA
	d2DD3xa9Rs2ciHxt3RemMl3PlXYE+I1OqdasuWYpMSI6E+3mV9ZeYL86kw3zQdMextn88G3xoHIPd
	603Vqiew==;
Received: from authenticated user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <leitao@debian.org>)
	id 1wKDi3-002lXo-1C;
	Tue, 05 May 2026 11:13:03 +0000
From: Breno Leitao <leitao@debian.org>
Date: Tue, 05 May 2026 04:12:39 -0700
Subject: [PATCH net-next 2/5] can: j1939: convert to getsockopt_iter
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260505-getsock_two-v1-2-4cb0738950e0@debian.org>
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
 Breno Leitao <leitao@debian.org>, kernel-team@meta.com
X-Mailer: b4 0.16-dev-453a6
X-Developer-Signature: v=1; a=openpgp-sha256; l=2654; i=leitao@debian.org;
 h=from:subject:message-id; bh=Q4ba2KfkdI2NRlz65g0omXf9tdpZDQdN4/pOtUn4u1M=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBp+dCv5MW9F91cjLsTu9OM5g3hpm0p0zWvIozGi
 8EaUprvUDiJAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCafnQrwAKCRA1o5Of/Hh3
 bXt1D/0eCdk7iz3fH21kEObVsK3qMbmJ8bdAuX7tHvC+NLaGgtzCCRja6kMgLLrI0x6uMXWMBjK
 +p2x39nR765wzLi6cYmJz3Oy3bN0LVOsjy3Ib5MhcSkvs35xcDvQnmQwED8RTKr5rqCfZwmtffj
 Tje7Od4lyFBoYQR8NBVsDZbB390gbsaVrk38D4VHBuXGB2UK8l7+GDbgB6BUFjwCoqMtOMy6/cW
 /DPtJV0qdOWizOzs6j3gZ6yS2Kcx73apqMW/HNY3d80NlJekHaSLAwcWNESEH3+jR56eZuJHbPx
 D7Gg9oPvCigkE6dMbtM5ECv4yk3wu67lMbDMBKM4RF9dMdSjvg2Xs2/bh8tsFxWP/cJ5bqlum65
 TX3YzAxaJmwYWA078DcCieZl9l23yAYjcO4t4S1kowHkXrbTuaSYnE52qG8s36gMq3AcXQuXweC
 /xTJfPyZISmvb/Af8HWEifxV8Bj0mOcC+Ii1PDo/H51vB2dUAfaW8kvZdZRrt34rx6cEplejVy2
 RQApt1EaZk6Q+cQbV/ZuLV8P8igWk7GJmOesYi+T5gEg+EOmxpNl4VwYd3beR6s90l1J+TeLhWS
 Gbe/Sg3wiNh0GtNuzrSVWb4eMQngwHj/Y/H47tVtrvb0uaz7ljGTII+HZT+RyFb/V0ULbzCCixB
 vIrqqi2pg985O9w==
X-Developer-Key: i=leitao@debian.org; a=openpgp;
 fpr=AC8539A6E8F46702CA4A439B35A3939FFC78776D
X-Debian-User: leitao
X-Rspamd-Queue-Id: C06814CCC33
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
	TAGGED_FROM(0.00)[bounces-7522-lists,linux-can=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[19];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]

Convert CAN J1939 socket's getsockopt implementation to use the new
getsockopt_iter callback with sockopt_t.

Key changes:
- Replace (char __user *optval, int __user *optlen) with sockopt_t *opt
- Use opt->optlen for buffer length (input) and returned size (output)
- Use copy_to_iter() instead of copy_to_user()
- Restructure the chained if/else if (which depended on put_user() being
  an expression) into a nested if/else block now that opt->optlen = len
  is a statement
- Add linux/uio.h for copy_to_iter()

Signed-off-by: Breno Leitao <leitao@debian.org>
---
 net/can/j1939/socket.c | 21 +++++++++++++--------
 1 file changed, 13 insertions(+), 8 deletions(-)

diff --git a/net/can/j1939/socket.c b/net/can/j1939/socket.c
index 50a598ef5fd4a..d0c6ce607b0dc 100644
--- a/net/can/j1939/socket.c
+++ b/net/can/j1939/socket.c
@@ -17,6 +17,7 @@
 #include <linux/can/skb.h>
 #include <linux/errqueue.h>
 #include <linux/if_arp.h>
+#include <linux/uio.h>
 #include <net/can.h>
 
 #include "j1939-priv.h"
@@ -767,7 +768,7 @@ static int j1939_sk_setsockopt(struct socket *sock, int level, int optname,
 }
 
 static int j1939_sk_getsockopt(struct socket *sock, int level, int optname,
-			       char __user *optval, int __user *optlen)
+			       sockopt_t *opt)
 {
 	struct sock *sk = sock->sk;
 	struct j1939_sock *jsk = j1939_sk(sk);
@@ -779,8 +780,7 @@ static int j1939_sk_getsockopt(struct socket *sock, int level, int optname,
 
 	if (level != SOL_CAN_J1939)
 		return -EINVAL;
-	if (get_user(ulen, optlen))
-		return -EFAULT;
+	ulen = opt->optlen;
 	if (ulen < 0)
 		return -EINVAL;
 
@@ -804,11 +804,16 @@ static int j1939_sk_getsockopt(struct socket *sock, int level, int optname,
 	 * but most sockopt's are 'int' properties, and have 'len' & 'val'
 	 * left unchanged, but instead modified 'tmp'
 	 */
-	if (len > ulen)
-		ret = -EFAULT;
-	else if (put_user(len, optlen))
+	if (len > ulen) {
 		ret = -EFAULT;
-	else if (copy_to_user(optval, val, len))
+		goto no_copy;
+	}
+
+	opt->optlen = len;
+	/* Even if the copy below fails, we want to update optlen. This is
+	 * a bit confusing, but, it preserves the original behaviour
+	 */
+	if (copy_to_iter(val, len, &opt->iter_out) != len)
 		ret = -EFAULT;
 	else
 		ret = 0;
@@ -1385,7 +1390,7 @@ static const struct proto_ops j1939_ops = {
 	.listen = sock_no_listen,
 	.shutdown = sock_no_shutdown,
 	.setsockopt = j1939_sk_setsockopt,
-	.getsockopt = j1939_sk_getsockopt,
+	.getsockopt_iter = j1939_sk_getsockopt,
 	.sendmsg = j1939_sk_sendmsg,
 	.recvmsg = j1939_sk_recvmsg,
 	.mmap = sock_no_mmap,

-- 
2.52.0


