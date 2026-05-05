Return-Path: <linux-can+bounces-7521-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oPwoEjzW+WmDEgMAu9opvQ
	(envelope-from <linux-can+bounces-7521-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Tue, 05 May 2026 13:36:28 +0200
X-Original-To: lists+linux-can@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E0AE24CCC2D
	for <lists+linux-can@lfdr.de>; Tue, 05 May 2026 13:36:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C55C132012EC
	for <lists+linux-can@lfdr.de>; Tue,  5 May 2026 11:13:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDF76386C21;
	Tue,  5 May 2026 11:13:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b="qA3Je8S+"
X-Original-To: linux-can@vger.kernel.org
Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0ACFF386C39;
	Tue,  5 May 2026 11:13:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.195.75.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777979591; cv=none; b=P1bIpt81JZNSWNjjG5H5UehAbqeB6khl0+1noIeKVVsF47W41mBl5JusTmhJp+HNTUyBmZ0RQay1R2qM+62A3CE2ys6D02PbNivjEp8/6iyLJTAstUMNQJZx1kI/qBo/spRxyKMQ0FUAPY0tvh20nhZocDwhwMhjA7X8g86xS0E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777979591; c=relaxed/simple;
	bh=s++S4+7+3HDsqdxQF43+fczAWP/Ac/3nkjQRsEGRF2I=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ZdxvpXVsR0J+KAxRCzbrNwR39bIgT/oqbuKxTpVXc7/pggyt/bEt5LnFZgYdup4nZy5YYf9GjG6oUKpnV8GWoA0sVT1y7sJean/COMOQ0pISyViZY3r04gVINxrCXntimOhYJ3DnAFDPNPuc9ULp6T2CkKqYMACy/90n0wijOhY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=qA3Je8S+; arc=none smtp.client-ip=82.195.75.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=debian.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:Cc:To:In-Reply-To:References:
	Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Reply-To:Content-ID:Content-Description;
	bh=UZYasKQBgQxckJ+f8RkoYHHLU5axa9MRxgocc2c4+a4=; b=qA3Je8S+OmnRSd5P+tZI7Jzs0B
	CkmAd+a2U6TmeAxtxlSLLHauA9lXqAfSKVo6sTo82APNBOPvPrvEbVilXWRkM+0BJtasMlhNHERkB
	i+4oS1kIeP9HOKzis0kqp1OYBBqtukwocfcbm+TPI9bKkxkUafZ+3sggYY/Zsl/La3nnOea55m/pP
	RFdhC7/Vu7q2JfhLlUGkzMB5YoiyszmNAzgGFW9adN+KawJP85JXZ3TXOSDc8asT2SkjdulwDEYgt
	WYst7pVgQz3l78KMkTi1joMs3F29UDL6ZBpXIXnX/Zufwu7q13Fm5UoxWsWVmXKPixziDZ0xP3bT8
	3KTmNUfg==;
Received: from authenticated user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <leitao@debian.org>)
	id 1wKDhy-002lXm-1C;
	Tue, 05 May 2026 11:12:58 +0000
From: Breno Leitao <leitao@debian.org>
Date: Tue, 05 May 2026 04:12:38 -0700
Subject: [PATCH net-next 1/5] can: isotp: convert to getsockopt_iter
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260505-getsock_two-v1-1-4cb0738950e0@debian.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1871; i=leitao@debian.org;
 h=from:subject:message-id; bh=s++S4+7+3HDsqdxQF43+fczAWP/Ac/3nkjQRsEGRF2I=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBp+dCv2wyta0b5OFUiB9vDXiL7bAV1Zj7AOMQz7
 ewTW8T4XNqJAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCafnQrwAKCRA1o5Of/Hh3
 bar9D/wLUF0D35B57QMies44PNE4Xk8eH33xsifOY7gsP9cI8PakzUMgOkfuAh5yBmbeXiafYuK
 OT3BumeY6zXtmbzHVYquCCWQE6Olt8t+QtYoqL120Ux62pc28E9CaakhjROi3jGPQESgRTUe6kD
 0loJnyI8yQQBLBbq0zT4d+yFJrPsnoBY1+HAOkh2F/itpCyBtxVnPdiy1+M0Wo1YvvZ1/1DcOvz
 LutaEYViqhF3GeryaC/Oj1tjvVsO1ykEPrFDck0PtovraD/fKh7MUpXlwN9MOu3NKXn52/gaoyo
 vWDKHjXnb4FVs3fHV3PjAzipqCU/3VKs4Tgyl3xzB+VSnX1X8lAwJJ73yjKaVczJaRnsUU1Uxwm
 V/9n7oQqSxpHq3pwQhfNvsx48o9E9Owan8Qp+ds7Y68wH1zAB+SSYe42tOkQcqTefVh1c0aM2ZG
 cpm2gxmu4ej9pAhvvEQyZei+bdt1St8Oi62Loo+fU5FiKiRNuthZB/vWKx/XVTNH3liSrMKu276
 8RFyjB2KpR2EOFpGiW5TtLiXW7s2auNljsZoSbS4MF6DKeUzzBqZNS58IaB6Yf2kM1OZaQd78aZ
 csy9YlOsKmSJTdoFjkjkPim140mDcuGuNYR9H1WRhD1zHlq0HPxRVId6K35B8S2/iGzxU0+c+6q
 cKaA0M46S6iX7iA==
X-Developer-Key: i=leitao@debian.org; a=openpgp;
 fpr=AC8539A6E8F46702CA4A439B35A3939FFC78776D
X-Debian-User: leitao
X-Rspamd-Queue-Id: E0AE24CCC2D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[debian.org,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[debian.org:s=smtpauto.stravinsky];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-7521-lists,linux-can=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[19];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[leitao@debian.org,linux-can@vger.kernel.org];
	DKIM_TRACE(0.00)[debian.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-can];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]

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


