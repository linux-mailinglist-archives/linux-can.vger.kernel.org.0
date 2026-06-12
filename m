Return-Path: <linux-can+bounces-7829-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id S/p4JuPoK2pdHgQAu9opvQ
	(envelope-from <linux-can+bounces-7829-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Fri, 12 Jun 2026 13:09:23 +0200
X-Original-To: lists+linux-can@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E7AC1678E10
	for <lists+linux-can@lfdr.de>; Fri, 12 Jun 2026 13:09:22 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=hartkopp.net header.s=strato-dkim-0002 header.b=Aw3HOI2W;
	dkim=pass header.d=hartkopp.net header.s=strato-dkim-0003 header.b=pqQo3nXK;
	spf=pass (mail.lfdr.de: domain of "linux-can+bounces-7829-lists+linux-can=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-can+bounces-7829-lists+linux-can=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=hartkopp.net;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7E92D31B691B
	for <lists+linux-can@lfdr.de>; Fri, 12 Jun 2026 11:08:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35E132E739C;
	Fri, 12 Jun 2026 11:08:45 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from mo4-p01-ob.smtp.rzone.de (mo4-p01-ob.smtp.rzone.de [81.169.146.164])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6DC3345731
	for <linux-can@vger.kernel.org>; Fri, 12 Jun 2026 11:08:42 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781262524; cv=pass; b=f0DHUsYgLEIYyG87IBjTc/aKDLZOp7aFl4N69FeRvgB2VtVJO3U5u7vIC46O71ws3wxOg+8WNRcRhixned1nFG18NB7oZ+LZIvPM7/Wg3hn7F0KTiXduy/o20xTi/YFRA99vkzDZCrpcjl0J8QI/Pm3PIEYVHfyVGuahL3PKS8g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781262524; c=relaxed/simple;
	bh=PpSNIsUyKA7F1y8ZYo6AHCPmEV8dcx9h7l04c5zOnU0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=d8iVSR0YU/m+fyMY+GmvoXRFLsQfTu9W43yOA11agMidIkQtPo0gaUCzu4Aegy6QaNreeEp9GzoDTIiM1/AVKsZySCbiOLA+2om4bYwwJCIEK3w5rnqc+f44mhrljRMAJJA2PiC0dpYMQbVMVgbbg6EDfCxvMSM2RxZjQSAo5gk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net; spf=fail smtp.mailfrom=hartkopp.net; dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=Aw3HOI2W; dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=pqQo3nXK; arc=pass smtp.client-ip=81.169.146.164
ARC-Seal: i=1; a=rsa-sha256; t=1781262336; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=Riz9Ahj6ToF0SM97mgAz7SslZwCisMFL6/t2sP4fb9agDMiIO3PzSGAsOalbMfnkhf
    dipq2U3jwX/ATeqv3haFSgWi6Ydt2v1upJkf/tNVmJoSupyZdiTORmsvD6EL+pYnXHxu
    1lniVvhV8XSw36n+mDhVHyCn+OByM9rxd+uqhoPLGrflJu7tcnHbFjtP/b2apS1OZtA/
    +Qu97D4Ew36LwyKvl4/eyXefGiwNWdDObBN4DbIpKRFDKPapezKNCRf63KVHc6AGy5kB
    b8V3X0/2YRy54WnByqblehRqrTOeTvRZ9azv90crTvouIVrg0UT1k++JCDYL23Y9MPuX
    CNUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1781262336;
    s=strato-dkim-0002; d=strato.com;
    h=Cc:To:In-Reply-To:References:Message-Id:Subject:Date:From:Cc:Date:
    From:Subject:Sender;
    bh=HeCKgGgX24k+9WVFduTSTb7qkuR4TaqBBaZSzVKw1Q0=;
    b=spgu+8RT99w/uLNFfiubL/xfKTP68Ro+90cPxMJSL60LDbFmETqdfs35MC9kq6nKVO
    4/7Z0w2Bv4EZydal47tfra6G0DiaEhpmc6sP4i3hEUs+aReoBhK6AztInjsRxeGtf6Z1
    p9A6TVym7iafU0O35RQxbOBwGMBgervpqUuo+eATefmmr92VUe0ggCZTbpgd3cXgJgq1
    bcH562qUfgp78W0/UqulZz0UqdcpBMJUhjNZvNAFlWqynhAuVUwzsX7FqTjX6D2G2dlC
    VhQSFZQEkeAg28RN3N9CnEdFVFivi88yr8X1WTUYB9pTOfJinGyvmvucN/kzOKdj0gfY
    ixIQ==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1781262336;
    s=strato-dkim-0002; d=hartkopp.net;
    h=Cc:To:In-Reply-To:References:Message-Id:Subject:Date:From:Cc:Date:
    From:Subject:Sender;
    bh=HeCKgGgX24k+9WVFduTSTb7qkuR4TaqBBaZSzVKw1Q0=;
    b=Aw3HOI2Wy45bk8VVchPFDvUY75stwbh8ZeO/stdBenfW5tpjZgnA6V4SEk4bCLnhla
    FSd7yTob2x0ZmNuHJF2aVQPsxel6sbfYqn7p2i1h0dCIPYYjhQBY3IPkDgf9RnR+53cI
    teqZTwbCpj0KxZ0rVEDG6ZyYNrCwsD5ayJmeOonMrY63HAddc/mwOp7QnJCpsV+Ov9OF
    cuevM9JSznq748fQQi64kQwAuK2TLQQ5weCuurdTB/iIQZEnOhZun/MLy6boNPcdnVc9
    BUp15rzmOFNUfFKFc5g2eqPzwFyuaJGsqnAEsIF9qScY6XHBlQwuI71Sc/jcFL5p0tBe
    iXhA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1781262336;
    s=strato-dkim-0003; d=hartkopp.net;
    h=Cc:To:In-Reply-To:References:Message-Id:Subject:Date:From:Cc:Date:
    From:Subject:Sender;
    bh=HeCKgGgX24k+9WVFduTSTb7qkuR4TaqBBaZSzVKw1Q0=;
    b=pqQo3nXKJH4SUUz+Up8bLlUR0c6QKNd/G3UoWAkklGvwdkdX6G7MqgMnH+K53/OVYx
    coK/cbY1u2YL4kDs07BA==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjH4JKvMdQv2tTUsMrZpkO3Mw3lZ/t54cFxeEQ7s8bDup0Q=="
Received: from [127.0.1.1]
    by smtp.strato.de (RZmta 55.0.1 AUTH)
    with ESMTPSA id Kba96d25CB5a8w8
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Fri, 12 Jun 2026 13:05:36 +0200 (CEST)
From: Oliver Hartkopp <socketcan@hartkopp.net>
Date: Fri, 12 Jun 2026 13:05:17 +0200
Subject: [PATCH 2/5] can: bcm: mark intentional lockless read of bo->bound
 for KCSAN
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260612-bcm_fixes-v1-2-ca2fa07ee70f@hartkopp.net>
References: <20260612-bcm_fixes-v1-0-ca2fa07ee70f@hartkopp.net>
In-Reply-To: <20260612-bcm_fixes-v1-0-ca2fa07ee70f@hartkopp.net>
To: linux-can@vger.kernel.org
Cc: Oliver Hartkopp <socketcan@hartkopp.net>, 
 Marc Kleine-Budde <mkl@pengutronix.de>, Ginger <ginger.jzllee@gmail.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1781262336; l=2963;
 i=socketcan@hartkopp.net; s=20260128; h=from:subject:message-id;
 bh=PpSNIsUyKA7F1y8ZYo6AHCPmEV8dcx9h7l04c5zOnU0=;
 b=xyU34ipRnCgkkxRRHlDTHqPqOmPB1otm3Lwyq2XhUAH0qqMCwLHwG1pCy7mvJ2Qkdu5IznFza
 VTHp9XcDrUYC5RiMVPcjak6V8a8ZrfSEMBPtBwu76BWOq0QDA0kKinp
X-Developer-Key: i=socketcan@hartkopp.net; a=ed25519;
 pk=/gU/7/wBqak3kTsTeFbCCqUi9dnh+1i6ITEkfPj/BvU=
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[hartkopp.net,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[hartkopp.net:s=strato-dkim-0002,hartkopp.net:s=strato-dkim-0003];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-7829-lists,linux-can=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:linux-can@vger.kernel.org,m:socketcan@hartkopp.net,m:mkl@pengutronix.de,m:ginger.jzllee@gmail.com,m:gingerjzllee@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[socketcan@hartkopp.net,linux-can@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[hartkopp.net,pengutronix.de,gmail.com];
	RCPT_COUNT_THREE(0.00)[4];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[socketcan@hartkopp.net,linux-can@vger.kernel.org];
	DKIM_TRACE(0.00)[hartkopp.net:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-can];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: E7AC1678E10

A static analyzer and KCSAN can detect a potential data race in
net/can/bcm.c between bcm_sendmsg() and bcm_notify().

bcm_sendmsg() reads bo->bound without holding the socket lock to
perform a fast-path check for unbound sockets before checking the
message length:

        /* Lockless fast-path check for bound socket */
        if (!bo->bound)
                return -ENOTCONN;

Concurrently, bcm_notify() can clear bo->bound under lock_sock(sk)
protection during a netdevice notification event:

        lock_sock(sk);
        ...
        bo->bound   = 0;
        bo->ifindex = 0;
        notify_enodev = 1;

This lockless read is intentional and functionally safe. If
bcm_sendmsg() passes the check while bcm_notify() is running, the
socket will block on the subsequent lock_sock(sk) call.

Once the lock is acquired, any subsequent attempts to configure BCM
jobs (like RX_SETUP) will safely fail because bcm_notify() has
already cleared bo->ifindex to 0. While a user-defined ifindex of 0
is normally a valid feature to listen on "all" CAN interfaces,
bcm_notify() only triggers for specific real CAN devices. In this
unregister context, the combination of bound=0 and ifindex=0 effectively
invalidates the socket binding. This prevents the registration of
stale CAN filters and drops downstream operations safely without any
memory corruption or stale state exploitation.

However, to comply with the Linux kernel memory model and to eliminate
false-positive warnings from concurrency sanitizers (KCSAN), annotate
this intentional data race using READ_ONCE() and WRITE_ONCE().

Reported-by: Ginger <ginger.jzllee@gmail.com>
Closes: https://lore.kernel.org/linux-can/CAGp+u1aBK8QVjsvAxM2Ldzep4rEbsP9x_pV3At4g=h1kVEtyhA@mail.gmail.com/
Signed-off-by: Oliver Hartkopp <socketcan@hartkopp.net>
---
 net/can/bcm.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/net/can/bcm.c b/net/can/bcm.c
index c49b09f3229f..9475758a6749 100644
--- a/net/can/bcm.c
+++ b/net/can/bcm.c
@@ -1391,11 +1391,12 @@ static int bcm_sendmsg(struct socket *sock, struct msghdr *msg, size_t size)
 	int ifindex = bo->ifindex; /* default ifindex for this bcm_op */
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
@@ -1525,11 +1526,11 @@ static void bcm_notify(struct bcm_sock *bo, unsigned long msg,
 			if (sock_net(sk)->can.bcmproc_dir && bo->bcm_proc_read) {
 				remove_proc_entry(bo->procname, sock_net(sk)->can.bcmproc_dir);
 				bo->bcm_proc_read = NULL;
 			}
 #endif
-			bo->bound   = 0;
+			WRITE_ONCE(bo->bound, 0);
 			bo->ifindex = 0;
 			notify_enodev = 1;
 		}
 
 		release_sock(sk);

-- 
2.53.0


