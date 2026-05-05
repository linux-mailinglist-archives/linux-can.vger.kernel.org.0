Return-Path: <linux-can+bounces-7524-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cMlpL1LR+WlHEQMAu9opvQ
	(envelope-from <linux-can+bounces-7524-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Tue, 05 May 2026 13:15:30 +0200
X-Original-To: lists+linux-can@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CA384CC542
	for <lists+linux-can@lfdr.de>; Tue, 05 May 2026 13:15:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 245B2302F01B
	for <lists+linux-can@lfdr.de>; Tue,  5 May 2026 11:14:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 677AA41C31A;
	Tue,  5 May 2026 11:13:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b="HDmYpbHH"
X-Original-To: linux-can@vger.kernel.org
Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0008E368263;
	Tue,  5 May 2026 11:13:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.195.75.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777979595; cv=none; b=jdXszszvHlNKbrdq2el0Nis5xSkOjWvIAbZ9U9cNtZ0TKeWeIdlWjY/Ux+X8WF3lxwXpx6VwzItwac3uWLnEnkiG4b8+xsZUdxUdZFoZqViAbfAny+mD9ZnrOZ6b6NowQd9upJmJvtSnkk9TFStzdGimnNHYTN7RcrB/WC0cPkI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777979595; c=relaxed/simple;
	bh=PEiFTTvD5HbPowkM40xyoZftErVoXe3+8eFL12D9lSk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=DK77TVS3ltTbAd+/vLIgEI094S+j6X6oHj2p6iIMgxzUp7yyXaJUL/ZwnKLBd6hWHFc8gY9AlXolqvd5XPzkjY6eTbImKRo4mcURuBAAMsYdugz13ny2XjxOuNmaJGsJ6TgQw5CZoVUaj3YHKBgDBl+dUwgXd5/6WxDw71xMbso=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=HDmYpbHH; arc=none smtp.client-ip=82.195.75.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=debian.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:Cc:To:In-Reply-To:References:
	Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Reply-To:Content-ID:Content-Description;
	bh=B/UCBY8qkZL6VTVSrvN0oMYXSzmxSRwhsEudHIJA8lQ=; b=HDmYpbHHuNnN0PGeIM6uQhnokd
	VpXKm5pTM4hEqfH0wHmZbJXLbLanFMf3nYS2kCOXMqvdUVV1UGu183eCBnBcilVrpdZEYjbi1R4AB
	HPE5E0YUUSpurtu9259j4NWmR9LOi8mPfxZeXShKcmlOtB4cxf3tNgeA3ajGWusXZQgKewUwcRmw9
	09C+8C359LFj1D87EZC+qTqNmnXd4I374F3CwuHr2t5mdf9srtFDhA+h9nlJcioe2feIi3gLqHK82
	XvdVTessBMoVX2RdC9JuY/sL7B2Y7zVJWQH6Jyml8C0B5+PgWj2u4BAD+Fc/DK6VmJ469oJYiw9hQ
	n3DtIGOg==;
Received: from authenticated user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <leitao@debian.org>)
	id 1wKDi8-002lY9-1Z;
	Tue, 05 May 2026 11:13:08 +0000
From: Breno Leitao <leitao@debian.org>
Date: Tue, 05 May 2026 04:12:40 -0700
Subject: [PATCH net-next 3/5] mctp: convert to getsockopt_iter
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260505-getsock_two-v1-3-4cb0738950e0@debian.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1952; i=leitao@debian.org;
 h=from:subject:message-id; bh=PEiFTTvD5HbPowkM40xyoZftErVoXe3+8eFL12D9lSk=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBp+dCvOPfHHkPxAYTcRmga6hVFebEKcNTgcvxi/
 HOYbk376HaJAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCafnQrwAKCRA1o5Of/Hh3
 bUihEACXnXgx132vJUNGNBx4LmvIQ3OEVUM+k3OnHB1P/DQXLUKWRCkfNar230rwLLtKkX2yN2x
 IS3D+polACeJduzaAiHj7HjGk+Ppobp+qTtvBup7vowYdZyy4C5F3Zu57VHyW+gwi1FXcqIAWwE
 J3mKH5JKDMuOsdRcXX9yohpHpq4w4S68vxjh+jO1iO2URTlNcUwvB7CJyDHs+Sju0opatVHCgAB
 GCoaby2V2Ada1dcEkyjtbXoZ1C4QhOgwN1hpSnmlKLHzT3+ZNim18CMB1cf3dSGr2mTAXK8xaGt
 ZKrIdQh02mmjvC9wfC/lNrvIyowXBx1mi5875as7LgbJ4yrNQ3Uwd4dZakezsvErRHFmINAAcc3
 kiIDRe/3tfgpe/AFvfavE7SPrevqqq8fdYokSwjt+da4khM/8hH5sJzWzBjXNjjaItk/lTzb+IA
 pbuzOTa8WUGfpM5I9OTYkcg51WG4j+zUj2QRVSYcwSGrimlP3AWDNxM5Xw/pauuZzJjcWtt1Pte
 LZDuk8b+A6P8IRxpPWDqswmNEp+mqnqKxQ5x0KcbDh+WuXp+suFjTChFhfGKwiOLQ3WvdyvY86E
 oUrlw7ybbYDxfzl/wQc6fuEqZbZxFQfWFw1rC+lOJBHNiAw8naJRRBYKJF+aZAAc7BAyf/tsony
 DwyEszHj8/kQh9A==
X-Developer-Key: i=leitao@debian.org; a=openpgp;
 fpr=AC8539A6E8F46702CA4A439B35A3939FFC78776D
X-Debian-User: leitao
X-Rspamd-Queue-Id: 5CA384CC542
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[debian.org,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[debian.org:s=smtpauto.stravinsky];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-7524-lists,linux-can=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[19];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[leitao@debian.org,linux-can@vger.kernel.org];
	DKIM_TRACE(0.00)[debian.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-can];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]

Convert MCTP socket's getsockopt implementation to use the new
getsockopt_iter callback with sockopt_t.

Key changes:
- Replace (char __user *optval, int __user *optlen) with sockopt_t *opt
- Use opt->optlen for buffer length (input)
- Use copy_to_iter() instead of copy_to_user()
- Add linux/uio.h for copy_to_iter()

Signed-off-by: Breno Leitao <leitao@debian.org>
---
 net/mctp/af_mctp.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/net/mctp/af_mctp.c b/net/mctp/af_mctp.c
index 209a963112e3a..8af5e2b3c8d12 100644
--- a/net/mctp/af_mctp.c
+++ b/net/mctp/af_mctp.c
@@ -12,6 +12,7 @@
 #include <linux/mctp.h>
 #include <linux/module.h>
 #include <linux/socket.h>
+#include <linux/uio.h>
 
 #include <net/mctp.h>
 #include <net/mctpdevice.h>
@@ -405,7 +406,7 @@ static int mctp_setsockopt(struct socket *sock, int level, int optname,
 }
 
 static int mctp_getsockopt(struct socket *sock, int level, int optname,
-			   char __user *optval, int __user *optlen)
+			   sockopt_t *opt)
 {
 	struct mctp_sock *msk = container_of(sock->sk, struct mctp_sock, sk);
 	int len, val;
@@ -413,14 +414,13 @@ static int mctp_getsockopt(struct socket *sock, int level, int optname,
 	if (level != SOL_MCTP)
 		return -EINVAL;
 
-	if (get_user(len, optlen))
-		return -EFAULT;
+	len = opt->optlen;
 
 	if (optname == MCTP_OPT_ADDR_EXT) {
 		if (len != sizeof(int))
 			return -EINVAL;
 		val = !!msk->addr_ext;
-		if (copy_to_user(optval, &val, len))
+		if (copy_to_iter(&val, len, &opt->iter_out) != len)
 			return -EFAULT;
 		return 0;
 	}
@@ -639,7 +639,7 @@ static const struct proto_ops mctp_dgram_ops = {
 	.listen		= sock_no_listen,
 	.shutdown	= sock_no_shutdown,
 	.setsockopt	= mctp_setsockopt,
-	.getsockopt	= mctp_getsockopt,
+	.getsockopt_iter = mctp_getsockopt,
 	.sendmsg	= mctp_sendmsg,
 	.recvmsg	= mctp_recvmsg,
 	.mmap		= sock_no_mmap,

-- 
2.52.0


