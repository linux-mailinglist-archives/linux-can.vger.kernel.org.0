Return-Path: <linux-can+bounces-7547-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4EXtBaJe/Gm7OwAAu9opvQ
	(envelope-from <linux-can+bounces-7547-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Thu, 07 May 2026 11:42:58 +0200
X-Original-To: lists+linux-can@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 662614E62D8
	for <lists+linux-can@lfdr.de>; Thu, 07 May 2026 11:42:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9FE4A305815D
	for <lists+linux-can@lfdr.de>; Thu,  7 May 2026 09:35:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 768913C660C;
	Thu,  7 May 2026 09:35:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b="LFCMU0/Q"
X-Original-To: linux-can@vger.kernel.org
Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F16CD3C6A5F;
	Thu,  7 May 2026 09:35:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.195.75.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778146514; cv=none; b=HEdvEmohEirD4jReCBIJ2U3jTc0kcWYzdo9jqLhBHV8THOLzIcr9uWPlhV7ynNRnXaLDUQpnAjsRnRpLbB13/+M/jjSVlH4BNW5Mgd5NrwYMAzTc7B4uPNEMTXNCiEAq4PsUSjQSBwGPGDEGrLjQGEvp3tE45xzw4ONoCOfIckI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778146514; c=relaxed/simple;
	bh=s++S4+7+3HDsqdxQF43+fczAWP/Ac/3nkjQRsEGRF2I=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=gYiuKtTK8QTrm8QeUnb/FeXcp+zhaTZ/rxaGy4gaEKz+ZnIYY4x/0SFtnyrI4YaEf7pmbmq8vlY1tLiAB33rK3rzD52/6e4xNkonAPRxMgyv18h5bQKpOb3Wlt0BLqW2CRSnOt3mvSERnZc7zBthvEvY99+s6m5X0t0lvGvCJQA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=LFCMU0/Q; arc=none smtp.client-ip=82.195.75.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=debian.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:Cc:To:In-Reply-To:References:
	Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Reply-To:Content-ID:Content-Description;
	bh=UZYasKQBgQxckJ+f8RkoYHHLU5axa9MRxgocc2c4+a4=; b=LFCMU0/QQdj7uJ+bMfUX3NeBz/
	vgwBsieEb46LMJnMkODeL+V7X9h8yzARpH2Sjv3RwObiaVvH7yHvhei2hwes/Spu6AY7M4FcythUe
	SR10rTMLIudcreOtrIlir2U691Ecb7jgwoofB8RB3CR4H4kw7Nnu1z2RZcrLF/iWMcphEm26KaPtO
	o36edUvFn/gcnG9rdyBqA0o++RHu2zZ3ccJmaBklBicE/oI7LW1Y9x8wB/zmuW25ZVaoR9EIkROQH
	gWiy8IHjoDEUp4UYV7xUCE57SXB5M/nmMvbEQKYUqKu5WXnM9slk3CkgbDIqzd5xKFjQqwLByEc/T
	eytAb14A==;
Received: from authenticated user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <leitao@debian.org>)
	id 1wKv8Q-004GvD-1s;
	Thu, 07 May 2026 09:35:10 +0000
From: Breno Leitao <leitao@debian.org>
Date: Thu, 07 May 2026 02:34:48 -0700
Subject: [PATCH net-next 2/2] can: isotp: convert to getsockopt_iter
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260507-getsock_two_can-v1-2-3c2ae9edfadc@debian.org>
References: <20260507-getsock_two_can-v1-0-3c2ae9edfadc@debian.org>
In-Reply-To: <20260507-getsock_two_can-v1-0-3c2ae9edfadc@debian.org>
To: Robin van der Gracht <robin@protonic.nl>, 
 Oleksij Rempel <o.rempel@pengutronix.de>, kernel@pengutronix.de, 
 Oliver Hartkopp <socketcan@hartkopp.net>, 
 Marc Kleine-Budde <mkl@pengutronix.de>
Cc: linux-can@vger.kernel.org, linux-kernel@vger.kernel.org, 
 kernel-team@meta.com, Breno Leitao <leitao@debian.org>
X-Mailer: b4 0.16-dev-453a6
X-Developer-Signature: v=1; a=openpgp-sha256; l=1871; i=leitao@debian.org;
 h=from:subject:message-id; bh=s++S4+7+3HDsqdxQF43+fczAWP/Ac/3nkjQRsEGRF2I=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBp/FzEbBNu0E0Uv2+xnCtuwhi9UoHrJONpnb41S
 Z0aJK4DdeyJAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCafxcxAAKCRA1o5Of/Hh3
 beX+D/0dNNEbuh2Vk6Ee3/uqB8JC/Tku5CN/DLMh9DRRfz49hu0i6jDCzeTFipzllhhKN81mW2J
 JRTkh644ebBn7DlR4wQpWF9Z4+NkNF5SlaktrDjq2EZA1xQc4vyj/5U2U3SqYUBaGM5rvih9f6/
 89o5La7+Uo4jERykiIAXX4bET23uqACU0v4xu6PS4XL6Lnr/nS6JnRNVurMcxMzTAY9ivP37+h7
 umnCgH4s2enCLGNsyjQAXiGK4Km00NFC66KUsFAsnp3vc1l3gKuFpJzXomAXGN5dKqJOdXJhJqj
 5iAIv3O+kDkdDNte+gt5hVj6XvfJ91wkF4+AiKWcymWWyyJLGl6ANDgXzYokQr4B0W6Wd7ozZR0
 CWj8HicUH321PdoidnfH7B8H2Uc3pcebNm01Ap1zI+Y3UWLGKctwJeEb6oU/xyNAuPQW/Pt0W2q
 x/lDEWiF1kC8+qJevapS5ysvcrLVYzZX25I+mHU4UpUwgwCG+gaW6ToNfupn6zv+hFjnx0MYJiF
 azVPjOlv+7XgGfBkVV3H9bgWdUAaqoc/ZVKMj0N6GZzU7uAoi97TgubvXb5iPbn8trgJQNP8cco
 xxv+pf4T92Xoq6enTXSfFiTxQM1vpUYzKKoMUifxXjt1FptzY126Vh1hXE5UTe5lLsg+cnRTYN/
 +zMgsgUiyCK5+IQ==
X-Developer-Key: i=leitao@debian.org; a=openpgp;
 fpr=AC8539A6E8F46702CA4A439B35A3939FFC78776D
X-Debian-User: leitao
X-Rspamd-Queue-Id: 662614E62D8
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[debian.org,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	R_DKIM_ALLOW(-0.20)[debian.org:s=smtpauto.stravinsky];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-7547-lists,linux-can=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[debian.org:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[leitao@debian.org,linux-can@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[9];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-can];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action

Convert CAN ISO-TP socket's getsockopt implementation to use the new
getsockopt_iter callback with sockopt_t.

Key changes:
- Replace (char __user *optval, int __user *optlen) with sockopt_t *opt
- Use opt->optlen for buffer length (input) and returned size (output)
- Use copy_to_iter() instead of put_user()/copy_to_user()

Signed-off-by: Breno Leitao <leitao@debian.org>
---
 net/can/isotp.c | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/net/can/isotp.c b/net/can/isotp.c
index c48b4a818297e..1c33f09fbd338 100644
--- a/net/can/isotp.c
+++ b/net/can/isotp.c
@@ -1500,7 +1500,7 @@ static int isotp_setsockopt(struct socket *sock, int level, int optname,
 }
 
 static int isotp_getsockopt(struct socket *sock, int level, int optname,
-			    char __user *optval, int __user *optlen)
+			    sockopt_t *opt)
 {
 	struct sock *sk = sock->sk;
 	struct isotp_sock *so = isotp_sk(sk);
@@ -1509,8 +1509,7 @@ static int isotp_getsockopt(struct socket *sock, int level, int optname,
 
 	if (level != SOL_CAN_ISOTP)
 		return -EINVAL;
-	if (get_user(len, optlen))
-		return -EFAULT;
+	len = opt->optlen;
 	if (len < 0)
 		return -EINVAL;
 
@@ -1544,9 +1543,8 @@ static int isotp_getsockopt(struct socket *sock, int level, int optname,
 		return -ENOPROTOOPT;
 	}
 
-	if (put_user(len, optlen))
-		return -EFAULT;
-	if (copy_to_user(optval, val, len))
+	opt->optlen = len;
+	if (copy_to_iter(val, len, &opt->iter_out) != len)
 		return -EFAULT;
 	return 0;
 }
@@ -1718,7 +1716,7 @@ static const struct proto_ops isotp_ops = {
 	.listen = sock_no_listen,
 	.shutdown = sock_no_shutdown,
 	.setsockopt = isotp_setsockopt,
-	.getsockopt = isotp_getsockopt,
+	.getsockopt_iter = isotp_getsockopt,
 	.sendmsg = isotp_sendmsg,
 	.recvmsg = isotp_recvmsg,
 	.mmap = sock_no_mmap,

-- 
2.52.0


