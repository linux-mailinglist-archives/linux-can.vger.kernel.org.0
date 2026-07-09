Return-Path: <linux-can+bounces-8216-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id i6JpGOvgT2qOpgIAu9opvQ
	(envelope-from <linux-can+bounces-8216-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Thu, 09 Jul 2026 19:56:59 +0200
X-Original-To: lists+linux-can@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FFFA7340E7
	for <lists+linux-can@lfdr.de>; Thu, 09 Jul 2026 19:56:58 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20201202 header.b=Zpbc29zq;
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	spf=pass (mail.lfdr.de: domain of "linux-can+bounces-8216-lists+linux-can=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="linux-can+bounces-8216-lists+linux-can=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id EAF4A30228B0
	for <lists+linux-can@lfdr.de>; Thu,  9 Jul 2026 17:56:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 634624DB547;
	Thu,  9 Jul 2026 17:56:22 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 389244DA55C
	for <linux-can@vger.kernel.org>; Thu,  9 Jul 2026 17:56:22 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783619782; cv=none; b=BeAoygon5er+iz12FLp8prixX9BHmHVlnlunsLM+JFecSqdRoRAVi0iUcKVufCRKHOI7qpdBEyPUJvIkuhFkAkc5Cq6ZPr8rIcnNzc4vaVDgsboaUgP1EjUuS6SV+RQn5JGCUY5F76nGbBAha+Vxvy0g59bY32sNJAS6bDs1/P0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783619782; c=relaxed/simple;
	bh=N6IRfAhSRTf9fvNTpE0sRBO4gANfqERYL1AuQuhpH8k=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=T0UjhQlmdP+7K7plcbbuOWMjiTNIsSqsokzc08mbdSP2hbmZrsLk2pI7kYPyMDreBpO7UlywAxrSAwlwKDNilTDX1f/Q/zMiN3j6qtekjlsS6X3hjTfdXpp608Qo/ZLgycCsNuLUOBLPvn93tR289fTHiBR8wnZ8e3rlAoJOQ3U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Zpbc29zq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id E2482C2BCF4;
	Thu,  9 Jul 2026 17:56:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1783619781;
	bh=N6IRfAhSRTf9fvNTpE0sRBO4gANfqERYL1AuQuhpH8k=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=Zpbc29zq8VoY0FfeuJPXj1w7D32NhUcdGHkjanjhfs6NN8hVVkL0WE0sYGBMujIYW
	 lNgvF7Mdye5WjY/J+no6UM3SgvWoaOwmVtdkZ9gpuyOP+w3ST1dQlh6BziB7lkXOwv
	 ZSgOF8Ebu2Q+5/CzywS3PiviRULsETF/SK2YeLN0gwQeqgFyTDGfsUlLStg+Wt9xkU
	 eun2OttqARoyjCStWOc6updn18lAQzAijZuQzYMm6LKgqiLbanEfx6Fkwy45665xtA
	 W6iuWdFevZ15WGl21OuAIn8jSsSik7wG9rtRtQ6hwnqzlEBtooblDa+0OgSE43BufF
	 JNQ02jQgg1ONA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3023C43458;
	Thu,  9 Jul 2026 17:56:21 +0000 (UTC)
From: Oliver Hartkopp via B4 Relay <devnull+socketcan.hartkopp.net@kernel.org>
Date: Thu, 09 Jul 2026 19:56:16 +0200
Subject: [PATCH v11 02/11] can: bcm: fix lockless bound/ifindex race and
 silent RX_SETUP failure
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260709-bcm_fixes-v11-2-067ba11bec5c@hartkopp.net>
References: <20260709-bcm_fixes-v11-0-067ba11bec5c@hartkopp.net>
In-Reply-To: <20260709-bcm_fixes-v11-0-067ba11bec5c@hartkopp.net>
To: linux-can@vger.kernel.org
Cc: Oliver Hartkopp <socketcan@hartkopp.net>, 
 Marc Kleine-Budde <mkl@pengutronix.de>, Ginger <ginger.jzllee@gmail.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1783619780; l=6333;
 i=socketcan@hartkopp.net; s=20260128; h=from:subject:message-id;
 bh=HIW+pKj5D5r7xsCPM7j7rI6N34B4YynpNZPg4LXJ6YI=;
 b=USCb0fYr9JmPOC0SMJks6NZ1MK5FNSPOjqsnG4eVNXcvHQWBkwtR8lQtKebsaOl1jYVUFzyqy
 MVBszeoiPnKDmHqMaKhIYzinFipSX6wAMaXGq7cLKjiDH2kRxIy2ols
X-Developer-Key: i=socketcan@hartkopp.net; a=ed25519;
 pk=/gU/7/wBqak3kTsTeFbCCqUi9dnh+1i6ITEkfPj/BvU=
X-Endpoint-Received: by B4 Relay for socketcan@hartkopp.net/20260128 with
 auth_id=620
X-Original-From: Oliver Hartkopp <socketcan@hartkopp.net>
Reply-To: socketcan@hartkopp.net
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-8216-lists,linux-can=lfdr.de,socketcan.hartkopp.net];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:linux-can@vger.kernel.org,m:socketcan@hartkopp.net,m:mkl@pengutronix.de,m:ginger.jzllee@gmail.com,m:gingerjzllee@gmail.com,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[devnull@kernel.org,linux-can@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	ALIAS_RESOLVED(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[devnull@kernel.org,linux-can@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	FREEMAIL_CC(0.00)[hartkopp.net,pengutronix.de,gmail.com];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	HAS_REPLYTO(0.00)[socketcan@hartkopp.net];
	TAGGED_RCPT(0.00)[linux-can];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCPT_COUNT_THREE(0.00)[4];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,hartkopp.net:replyto,hartkopp.net:mid,hartkopp.net:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 4FFFA7340E7

From: Oliver Hartkopp <socketcan@hartkopp.net>

bcm_sendmsg() reads bo->ifindex and checks bo->bound before taking
lock_sock(), while bcm_notify(), bcm_connect() and bcm_release() all
mutate both fields under that same lock. Because the lockless reads
and the locked writes are unordered with respect to each other, a
racing bcm_notify() (device unregister) or bcm_connect() (concurrent
bind on another thread sharing the socket) can make bcm_sendmsg()
observe an inconsistent combination, e.g. a stale bound=1 together
with the now-cleared ifindex=0, silently turning a socket bound to a
specific CAN interface into one that also matches "any" interface.

Keep the lockless bo->bound check purely as a fast-path reject, and
move the ifindex read (and a bo->bound re-check) into the locked
section, where every writer already serializes. This removes the
possibility of observing the two fields torn against each other,
rather than trying to fix it with more READ_ONCE()/WRITE_ONCE() pairs
on two independently updated fields. Annotate the now-purely-lockless
bo->bound accesses consistently across all its write sites.

Also fix bcm_rx_setup() silently returning success when the target
device disappears concurrently instead of reporting -ENODEV, so a
broken RX op is no longer left registered as if it had succeeded.

Fixes: ffd980f976e7 ("[CAN]: Add broadcast manager (bcm) protocol")
Reported-by: Ginger <ginger.jzllee@gmail.com>
Closes: https://lore.kernel.org/linux-can/CAGp+u1aBK8QVjsvAxM2Ldzep4rEbsP9x_pV3At4g=h1kVEtyhA@mail.gmail.com/
Signed-off-by: Oliver Hartkopp <socketcan@hartkopp.net>
---
 net/can/bcm.c | 65 ++++++++++++++++++++++++++++++++++++++++++++++-------------
 1 file changed, 51 insertions(+), 14 deletions(-)

diff --git a/net/can/bcm.c b/net/can/bcm.c
index bdf53241bd7b..b612135b017d 100644
--- a/net/can/bcm.c
+++ b/net/can/bcm.c
@@ -1321,10 +1321,15 @@ static int bcm_rx_setup(struct bcm_msg_head *msg_head, struct msghdr *msg,
 						      bcm_rx_handler, op,
 						      "bcm", sk);
 
 				op->rx_reg_dev = dev;
 				dev_put(dev);
+			} else {
+				/* the requested device is gone - do not
+				 * silently succeed without registering
+				 */
+				err = -ENODEV;
 			}
 
 		} else
 			err = can_rx_register(sock_net(sk), NULL, op->can_id,
 					      REGMASK(op->can_id),
@@ -1394,16 +1399,17 @@ static int bcm_tx_send(struct msghdr *msg, int ifindex, struct sock *sk,
  */
 static int bcm_sendmsg(struct socket *sock, struct msghdr *msg, size_t size)
 {
 	struct sock *sk = sock->sk;
 	struct bcm_sock *bo = bcm_sk(sk);
-	int ifindex = bo->ifindex; /* default ifindex for this bcm_op */
+	int ifindex;
 	struct bcm_msg_head msg_head;
 	int cfsiz;
 	int ret; /* read bytes or error codes as return value */
 
-	if (!bo->bound)
+	/* Lockless fast-path check for bound socket */
+	if (!READ_ONCE(bo->bound))
 		return -ENOTCONN;
 
 	/* check for valid message length from userspace */
 	if (size < MHSIZ)
 		return -EINVAL;
@@ -1415,43 +1421,65 @@ static int bcm_sendmsg(struct socket *sock, struct msghdr *msg, size_t size)
 
 	cfsiz = CFSIZ(msg_head.flags);
 	if ((size - MHSIZ) % cfsiz)
 		return -EINVAL;
 
+	lock_sock(sk);
+
+	/* Re-validate under the socket lock: a concurrent bcm_notify()
+	 * may have unbound this socket (device removal) after the
+	 * lockless fast-path check above. bo->ifindex is only ever
+	 * mutated under lock_sock(), so reading it here - instead of
+	 * before taking the lock - guarantees it can't be observed
+	 * torn against bo->bound.
+	 */
+	if (!bo->bound) {
+		ret = -ENOTCONN;
+		goto out_release;
+	}
+
+	/* default ifindex for this bcm_op */
+	ifindex = bo->ifindex;
+
 	/* check for alternative ifindex for this bcm_op */
 
 	if (!ifindex && msg->msg_name) {
 		/* no bound device as default => check msg_name */
 		DECLARE_SOCKADDR(struct sockaddr_can *, addr, msg->msg_name);
 
-		if (msg->msg_namelen < BCM_MIN_NAMELEN)
-			return -EINVAL;
+		if (msg->msg_namelen < BCM_MIN_NAMELEN) {
+			ret = -EINVAL;
+			goto out_release;
+		}
 
-		if (addr->can_family != AF_CAN)
-			return -EINVAL;
+		if (addr->can_family != AF_CAN) {
+			ret = -EINVAL;
+			goto out_release;
+		}
 
 		/* ifindex from sendto() */
 		ifindex = addr->can_ifindex;
 
 		if (ifindex) {
 			struct net_device *dev;
 
 			dev = dev_get_by_index(sock_net(sk), ifindex);
-			if (!dev)
-				return -ENODEV;
+			if (!dev) {
+				ret = -ENODEV;
+				goto out_release;
+			}
 
 			if (dev->type != ARPHRD_CAN) {
 				dev_put(dev);
-				return -ENODEV;
+				ret = -ENODEV;
+				goto out_release;
 			}
 
 			dev_put(dev);
 		}
 	}
 
-	lock_sock(sk);
-
 	switch (msg_head.opcode) {
 
 	case TX_SETUP:
 		ret = bcm_tx_setup(&msg_head, msg, ifindex, sk);
 		break;
@@ -1497,10 +1525,11 @@ static int bcm_sendmsg(struct socket *sock, struct msghdr *msg, size_t size)
 	default:
 		ret = -EINVAL;
 		break;
 	}
 
+out_release:
 	release_sock(sk);
 
 	return ret;
 }
 
@@ -1533,11 +1562,16 @@ static void bcm_notify(struct bcm_sock *bo, unsigned long msg,
 			if (sock_net(sk)->can.bcmproc_dir && bo->bcm_proc_read) {
 				remove_proc_entry(bo->procname, sock_net(sk)->can.bcmproc_dir);
 				bo->bcm_proc_read = NULL;
 			}
 #endif
-			bo->bound   = 0;
+			/* Paired with the lockless fast-path check in
+			 * bcm_sendmsg(); bo->ifindex itself is only ever
+			 * accessed under lock_sock() so it needs no
+			 * annotation.
+			 */
+			WRITE_ONCE(bo->bound, 0);
 			bo->ifindex = 0;
 			notify_enodev = 1;
 		}
 
 		release_sock(sk);
@@ -1674,11 +1708,11 @@ static int bcm_release(struct socket *sock)
 	list_for_each_entry_safe(op, next, &bo->rx_ops, list)
 		bcm_remove_op(op);
 
 	/* remove device reference */
 	if (bo->bound) {
-		bo->bound   = 0;
+		WRITE_ONCE(bo->bound, 0);
 		bo->ifindex = 0;
 	}
 
 	sock_orphan(sk);
 	sock->sk = NULL;
@@ -1744,11 +1778,14 @@ static int bcm_connect(struct socket *sock, struct sockaddr_unsized *uaddr, int
 			goto fail;
 		}
 	}
 #endif /* CONFIG_PROC_FS */
 
-	bo->bound = 1;
+	/* bo->ifindex above is fully assigned before this point; pairs
+	 * with the lockless fast-path check in bcm_sendmsg()
+	 */
+	WRITE_ONCE(bo->bound, 1);
 
 fail:
 	release_sock(sk);
 
 	return ret;

-- 
2.53.0



