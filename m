Return-Path: <linux-can+bounces-7525-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GDXlNvjS+WlHEQMAu9opvQ
	(envelope-from <linux-can+bounces-7525-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Tue, 05 May 2026 13:22:32 +0200
X-Original-To: lists+linux-can@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 45F6B4CC818
	for <lists+linux-can@lfdr.de>; Tue, 05 May 2026 13:22:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AC1D8308CE0D
	for <lists+linux-can@lfdr.de>; Tue,  5 May 2026 11:14:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33C193822AE;
	Tue,  5 May 2026 11:13:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b="SdXHghg2"
X-Original-To: linux-can@vger.kernel.org
Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BABE6368263;
	Tue,  5 May 2026 11:13:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.195.75.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777979600; cv=none; b=uwGhAQNjaJCBBz4+lSEvVcHnYJiMQTUOw3Vq7x+mpRfAnNY6XtJwsHK8o/PXMGH3mkwafXEzxbAYvuOqR2b1Vlj+BImHp7DuKCvqmC9tBd+8NvfLtsjeJbUk/9B8HucwxHZ3g1PCVApSNyYXFVm8qsFdhX1hX3sH+ezXpaV6kKg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777979600; c=relaxed/simple;
	bh=3+pJulYqhN2DJgwm3IrymKKX3D4D4QQcgmk9P4CoziE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=FAG1jvO0oy+9NZtFGIQw43RNXOtuYVm/PfY7c4Fe+yP8zbfGL9uGb5AxAVizbRGjOQc5HjAiIcJP9sb7INI1fJMtjEeIrTbQwizX5v2DGTC6zjaP68cot4mQ/qCfflMP8ylyExhbycUpbdxlQrZ7TyupuTRdYc9j59WmR++Z0Yk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=SdXHghg2; arc=none smtp.client-ip=82.195.75.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=debian.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:Cc:To:In-Reply-To:References:
	Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Reply-To:Content-ID:Content-Description;
	bh=Oe2XxtaXgdji06bRrru3Wcj9UWgeOvaXKbGVkMEV2Xw=; b=SdXHghg2FZC89rw4QX21JhKOfQ
	WwKFQ+gncU7MuYx9wcK2HSDwHtCwU9/JZUixa+kCCrfbAJHtlq8tJlnmmXA44sbXGCtkNxsmcdcOR
	taFGxKre4tzmoOCUGBtCIRRmCOt81aak4YTW4RwzzHI1h0C7DHtcGZwirxnpXhdOPPuUxuYRDuDFr
	0hkenP4MgLRRE56+P3y6etpnt7T9zVoNjYTlmu3/EN1E/HZnpmlETfe/TFIJU6PAhJyhdGs1+jJL5
	r9rVQb6fyHimevH9UCFN5QfUPRFkhY/QN7rqVCkYW7gRiORXYXUkfNd3KseaeODJnFhviCkgRv71J
	E4xjANXA==;
Received: from authenticated user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <leitao@debian.org>)
	id 1wKDiD-002lYP-0v;
	Tue, 05 May 2026 11:13:13 +0000
From: Breno Leitao <leitao@debian.org>
Date: Tue, 05 May 2026 04:12:41 -0700
Subject: [PATCH net-next 4/5] llc: convert to getsockopt_iter
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260505-getsock_two-v1-4-4cb0738950e0@debian.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2196; i=leitao@debian.org;
 h=from:subject:message-id; bh=3+pJulYqhN2DJgwm3IrymKKX3D4D4QQcgmk9P4CoziE=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBp+dCvnkV6Y3s7HW4XmN7eVreL7EpA2mSMpa/Lv
 4Ss2YVXyASJAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCafnQrwAKCRA1o5Of/Hh3
 bVh0EACC9fiE9ZPb1S+MUb/TP/yi94h2Mw18seyfomFJGygKhdBziRKyVQFrIgbw8uqKob3inPC
 bH2hSd1tKj2ijgGxAXiyo5tLn7E4UOT5F/1QWXmcC9QcAZd2KI20Tn7Xqutw551u72SFEadHMQj
 d03w7jGZuyK8gh1Rt7jxgfF6q1SEZbxV6BpK4rydW9UPVSkOUY4VOxAOR8lE6xXwKFIA2/wsiej
 4L4a7OJJBlITFt4fEws91gUuiIMmubqYp+R+KxEVGCFw2J6iqe2Km7kODWAmoVw7kFqpN3ti9cd
 5tNbZLkPGP8WeUhmxUbFbjgA9NESx5/YHT0Ru+k6OdmIc7uljtu2ZOka83m7+V0wYMr+CzYalmn
 +kcdIdRciO59RGwnHIMwvHI7sxzFeOv5JW3HsmXGKb93T1FPJHWDJT/d6oj7YIoV8ci+vz/Kb+q
 QmMW5/C0UWOlUYOM33C/LyS3b5f52ArXRanFpOLHLiyrL2nEbynUUcdN69s3O0B3H2kizT0HaT+
 c+6ZRJ/5L58+l0fQCOHtwyfFhuKJv5tO/0TAP+XUg48YMgXegg03i0HINmbBy9yZYpH+MQ2vDFw
 fucrOMShhnB+QrN3sGZafBLQ1jlxQFfH5UzRTOyu+CH13F9AAU37aSssu3mpMmhcLGHa5umx374
 v3LHCk440SbSFqA==
X-Developer-Key: i=leitao@debian.org; a=openpgp;
 fpr=AC8539A6E8F46702CA4A439B35A3939FFC78776D
X-Debian-User: leitao
X-Rspamd-Queue-Id: 45F6B4CC818
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
	TAGGED_FROM(0.00)[bounces-7525-lists,linux-can=lfdr.de];
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

Convert LLC socket's getsockopt implementation to use the new
getsockopt_iter callback with sockopt_t.

Key changes:
- Replace (char __user *optval, int __user *optlen) with sockopt_t *opt
- Use opt->optlen for buffer length (input) and returned size (output)
- Use copy_to_iter() instead of put_user()/copy_to_user()
- Add linux/uio.h for copy_to_iter()

Signed-off-by: Breno Leitao <leitao@debian.org>
---
 net/llc/af_llc.c | 15 +++++++--------
 1 file changed, 7 insertions(+), 8 deletions(-)

diff --git a/net/llc/af_llc.c b/net/llc/af_llc.c
index 1b210db3119e8..7d723f0bd26c2 100644
--- a/net/llc/af_llc.c
+++ b/net/llc/af_llc.c
@@ -27,6 +27,7 @@
 #include <linux/init.h>
 #include <linux/slab.h>
 #include <linux/sched/signal.h>
+#include <linux/uio.h>
 
 #include <net/llc.h>
 #include <net/llc_sap.h>
@@ -1172,19 +1173,16 @@ static int llc_ui_setsockopt(struct socket *sock, int level, int optname,
  *	Get connection specific socket information.
  */
 static int llc_ui_getsockopt(struct socket *sock, int level, int optname,
-			     char __user *optval, int __user *optlen)
+			     sockopt_t *opt)
 {
 	struct sock *sk = sock->sk;
 	struct llc_sock *llc = llc_sk(sk);
-	int val = 0, len = 0, rc = -EINVAL;
+	int val = 0, len, rc = -EINVAL;
 
 	lock_sock(sk);
 	if (unlikely(level != SOL_LLC))
 		goto out;
-	rc = get_user(len, optlen);
-	if (rc)
-		goto out;
-	rc = -EINVAL;
+	len = opt->optlen;
 	if (len != sizeof(int))
 		goto out;
 	switch (optname) {
@@ -1212,7 +1210,8 @@ static int llc_ui_getsockopt(struct socket *sock, int level, int optname,
 		goto out;
 	}
 	rc = 0;
-	if (put_user(len, optlen) || copy_to_user(optval, &val, len))
+	opt->optlen = len;
+	if (copy_to_iter(&val, len, &opt->iter_out) != len)
 		rc = -EFAULT;
 out:
 	release_sock(sk);
@@ -1239,7 +1238,7 @@ static const struct proto_ops llc_ui_ops = {
 	.listen      = llc_ui_listen,
 	.shutdown    = llc_ui_shutdown,
 	.setsockopt  = llc_ui_setsockopt,
-	.getsockopt  = llc_ui_getsockopt,
+	.getsockopt_iter = llc_ui_getsockopt,
 	.sendmsg     = llc_ui_sendmsg,
 	.recvmsg     = llc_ui_recvmsg,
 	.mmap	     = sock_no_mmap,

-- 
2.52.0


