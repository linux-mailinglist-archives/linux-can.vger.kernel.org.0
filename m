Return-Path: <linux-can+bounces-7546-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AEtTOS1e/Gm7OwAAu9opvQ
	(envelope-from <linux-can+bounces-7546-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Thu, 07 May 2026 11:41:01 +0200
X-Original-To: lists+linux-can@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 61D2F4E6217
	for <lists+linux-can@lfdr.de>; Thu, 07 May 2026 11:41:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 6C91F30062F6
	for <lists+linux-can@lfdr.de>; Thu,  7 May 2026 09:35:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B54773BED46;
	Thu,  7 May 2026 09:35:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b="CHIOszn/"
X-Original-To: linux-can@vger.kernel.org
Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D8773C3BF3;
	Thu,  7 May 2026 09:35:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.195.75.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778146511; cv=none; b=A3LZWgalLD0ExychA09xALlKe4qlIdF2cK97xRyPOy9AaVaA4XruMMBlW7JprpeQ05DT6kj30xp5uh+2tav6eXwSJTRctJiByo2qpdokiLMRwx+YL8S6n+Wrxe0eUF40geu1FA88RxTJHHQUyaDZU0ecPk9vmXUvfSG6C0Es9O8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778146511; c=relaxed/simple;
	bh=Q4ba2KfkdI2NRlz65g0omXf9tdpZDQdN4/pOtUn4u1M=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=QbelUWx0BnhtxmpeXRzUGurvOueogC9a1plslLZF0BvdHOMp4Tg48PwI2MEP2/Pp/j/lp+a+B1BflmKM8fFn67kfNqOcXAfRO5eGsogSYtBQrEQqYT3HddBhBGJqNJ5lUipVcJJN2tNjNQRhXpDn3q8Nz6SHzhGZZiJZWH+tS5M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=CHIOszn/; arc=none smtp.client-ip=82.195.75.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=debian.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:Cc:To:In-Reply-To:References:
	Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Reply-To:Content-ID:Content-Description;
	bh=H/qWYI4vjdK5EAO0/fYWz00DJA1aDMQsgecwuI16Hxg=; b=CHIOszn/tZpLpYJDjEVSAdS6/+
	wtjJyUTxFxnJeYcg7kIi+iYalVZLyL1xCiubb7fcZ/4eqd6e9X8h0TuBvpvMIUt1L3ULJSyYwRJDL
	GVAEt11Xm2+2oZXMoHCmKuZvLigD/Y8h7K/kaeSLwyywPbs8I3cVOgMwxJEhAfAKRIoMlVufzWoc6
	SYoxEb7O+Uj35jGqNiqB4AYX8bxs+AK5I84z34WSv7BvVc1M5JpJP4jsxLLXgQP6Wk+qrmPZ2aYos
	c5wj0Kd1ddtkXw+/UAzIMZLDUkkhaPOJyzNrVX+6ieZNeh3/pj6m6g74jbX8HHaD1rFdbRFuXYpPf
	pHsNPZbg==;
Received: from authenticated user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <leitao@debian.org>)
	id 1wKv8M-004Gv0-2k;
	Thu, 07 May 2026 09:35:07 +0000
From: Breno Leitao <leitao@debian.org>
Date: Thu, 07 May 2026 02:34:47 -0700
Subject: [PATCH net-next 1/2] can: j1939: convert to getsockopt_iter
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260507-getsock_two_can-v1-1-3c2ae9edfadc@debian.org>
References: <20260507-getsock_two_can-v1-0-3c2ae9edfadc@debian.org>
In-Reply-To: <20260507-getsock_two_can-v1-0-3c2ae9edfadc@debian.org>
To: Robin van der Gracht <robin@protonic.nl>, 
 Oleksij Rempel <o.rempel@pengutronix.de>, kernel@pengutronix.de, 
 Oliver Hartkopp <socketcan@hartkopp.net>, 
 Marc Kleine-Budde <mkl@pengutronix.de>
Cc: linux-can@vger.kernel.org, linux-kernel@vger.kernel.org, 
 kernel-team@meta.com, Breno Leitao <leitao@debian.org>
X-Mailer: b4 0.16-dev-453a6
X-Developer-Signature: v=1; a=openpgp-sha256; l=2654; i=leitao@debian.org;
 h=from:subject:message-id; bh=Q4ba2KfkdI2NRlz65g0omXf9tdpZDQdN4/pOtUn4u1M=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBp/FzEX1zuYb3L9yuoGUwX4WRNGZvIaK2xog6JH
 uTxcUcmx1yJAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCafxcxAAKCRA1o5Of/Hh3
 bbVTD/4hlMraIrjgpr0edwlybyWltNkpQ1oy/eDuyXlFpAwXa/zLBfYSKzNuiOybbUqaYL1NqQH
 +KtUVDz2YoiP4+gvJQmGxrIVOXSrjXxDlzJq2xyVTEkWGwNHrHQ+NPBsP4AqWTXsCo9PTfo1ITD
 reoMLmEtvUbqSermzz8md7bOMn/+zRtK1YwDv0ob6NNXHt6OS+dpd2snZG6mXIve3rmC30YQMF5
 2GU/nsZPWfxe7RWVbgZiRIeMHa/CtOFz4gZLDgukQnmX2mM7V16tm/kMe+svmPtaDNtU4oWriRV
 XUHFSL/Soe2T0cO0cCfZmYCXRV6Q3W45qFISU5BJPl9chFf4x7Uc4IP8p16ASQ6Sykzyijss4qH
 3PcO7IpambGz21HDsBW2oueIj1FnvGYDLBmEa74QUJ3YxS8ern+wzMPLqC6vxxqej+aG5cm16cW
 zuWn4Jupt+bSzkpAyISWFqI2Fe8QFPSrazk7/6+1BPfZEuOCEcUOKdEJSPTwFrnEL92iknDJdEn
 1uud0cQwVS9zHENzIgbLdpioZWkprgIKFlay3ijhYyDRUikHc119MRIV8yKhsghBPlswv+f2oQ/
 0L8wMaCVkxqYK0pdRzpcFZm63UgfdkJvFgP+y4/FSw/jC1mA4X2GprKeJro0nAOY/BSaRdzLHi+
 0L9nLWqisj0bYBA==
X-Developer-Key: i=leitao@debian.org; a=openpgp;
 fpr=AC8539A6E8F46702CA4A439B35A3939FFC78776D
X-Debian-User: leitao
X-Rspamd-Queue-Id: 61D2F4E6217
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[debian.org,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[debian.org:s=smtpauto.stravinsky];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-7546-lists,linux-can=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[9];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-can];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Action: no action

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


