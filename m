Return-Path: <linux-can+bounces-7732-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UGpNB3jRHWqjewkAu9opvQ
	(envelope-from <linux-can+bounces-7732-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Mon, 01 Jun 2026 20:37:44 +0200
X-Original-To: lists+linux-can@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 87A37624191
	for <lists+linux-can@lfdr.de>; Mon, 01 Jun 2026 20:37:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8272930FEDE9
	for <lists+linux-can@lfdr.de>; Mon,  1 Jun 2026 18:20:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 735BF3E0087;
	Mon,  1 Jun 2026 18:19:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="XG4WqdIz";
	dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="DpGFPVMB"
X-Original-To: linux-can@vger.kernel.org
Received: from mo4-p00-ob.smtp.rzone.de (mo4-p00-ob.smtp.rzone.de [85.215.255.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FA0B3E1683
	for <linux-can@vger.kernel.org>; Mon,  1 Jun 2026 18:19:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=85.215.255.22
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780337975; cv=pass; b=DyktUEHNgY/xuu2p1Npm46LeCbsWStzUwS8uL+wqD+8M/ccl0pHwAiJHg9I5arkFGZMGEoCXQdV1xanw9sf2IcEAJSyWxXsE+UpXGlbV557LuJ8PV6PiWGbnGSG8/Wqn9udaEzOGeYhoaefSuG/9mzyIdXpDpnFX9n7f6xxpkoE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780337975; c=relaxed/simple;
	bh=12LiArOR7E91z34wNskZPRa0nzX3jUB+H8YPCF5N4aE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=fxrQX78RfZgXYHYGjbQGvuOxRVkQy2zSgkFllDNvow1gHkjSteTPi2kxNTKr83DhlJhTIDzBcBsKhr5JWo8qeefamWQXH5FkoJiO8SgOSLn/SIXx7ULAVpjN4109N+IxHe9x3tGfGqINOa2DfitzN7c1/rphRd+XgycNaCGoRL8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net; spf=fail smtp.mailfrom=hartkopp.net; dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=XG4WqdIz; dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=DpGFPVMB; arc=pass smtp.client-ip=85.215.255.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=hartkopp.net
ARC-Seal: i=1; a=rsa-sha256; t=1780337963; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=jJlw05bl1F6hWYJ9bsIzSbvzSlzXt6Qobe/GslCDwczXkL6hQ/8tLs3bw/JYniamxX
    cmcEeJ0eZtcP2CYpCJJUEZPkFh6xebP2F3FO9PEJ3KUtUj5wqUMf5HyNtrjD0cOcbTlp
    abrCA9Tbse4RptdLYTl2xeqvKMQaidJRHLzYGRCTgYx8wb1sboV/mKA+EtQnNC5cBKT2
    DbnUnnAFA1fmcxXTm18hRWhnzioOED9CVlQ2v95sEHnwABN29nIHas05q8F/KJheMifn
    ggArwOpsHzfLQCGN1xhxLoqbngC6zaltbIIq2cimPjRK15F0fXDwBqylR5xMSxtzExK/
    04qA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1780337963;
    s=strato-dkim-0002; d=strato.com;
    h=Message-ID:Date:Subject:Cc:To:From:Cc:Date:From:Subject:Sender;
    bh=v93syK4pl0cBpmyrTWtQPawikPlN9P6XPbfevuBR664=;
    b=deDN0BKy3X9gtAxEcoINNf0V9Ra+I9k2XfrFlVLrXGqC1z2e508cBgGxKSC6XaWleo
    zK9Ufoa+dpmKEzvAq9VPxL/ulSHiilROjaOsWB94mXMY4t2Z/LV7J2hz8mwTd5Uxhv/j
    w4OMJ8JzfrObFIlUZ1AW5OCmvH+tIJl8tCd0bogsoq0csRfhEVid+pCCqUVKbQ3pvpQ4
    OIoLWXr8YGf10z5uGJZUoaq1OHQxvqS93t0SS/e3HGt6ok4TsrLxYOFyUdcAzI303/xz
    e5JQ3qHcCBOBCTknptZIxXFlTsIRxgJzawC+bMsNM75AU066JXt6EifCtSCcaDS+3SO7
    j03g==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo00
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1780337963;
    s=strato-dkim-0002; d=hartkopp.net;
    h=Message-ID:Date:Subject:Cc:To:From:Cc:Date:From:Subject:Sender;
    bh=v93syK4pl0cBpmyrTWtQPawikPlN9P6XPbfevuBR664=;
    b=XG4WqdIzsfCLaNMbOhjMYIA5JOlVpOGtZYSalm0SjiS29iOM88WrdeHvo9JtFxegYH
    7VPfprAQYv1dg6bpBCNP75wE12UIMH6iFs7z5hr96AGVDSFT2kb4sbXA8irkwWlpv9VW
    xgVLqxTwOFccdwCbPOAZbnZ3DRpEkD0YkdS3xPghizkunzh35RUfdBndy9h0SosAcR1G
    3q2+qmH0efjRwJntm+UK8zQUN80EiwyZb9q9Iw2/a7r5O2ow4KytMgN1gMHpQCZOYoWl
    qgPhoDS8TqdFN7Ks5UGlrs/tgWlHRpbQ8ktmBm/Ye7Yarkdp8KKx9CJod1/RhS2lgNNS
    vaDg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1780337963;
    s=strato-dkim-0003; d=hartkopp.net;
    h=Message-ID:Date:Subject:Cc:To:From:Cc:Date:From:Subject:Sender;
    bh=v93syK4pl0cBpmyrTWtQPawikPlN9P6XPbfevuBR664=;
    b=DpGFPVMB41ATmr4MgqYHHl9/qHpSnYAg+mRHkltcQabx8paFhvvXVnmfTmWK8B0mPQ
    u9yRoBtPSi6fulfRdJDg==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjH4JKvMdQv2tTUsMrZpkO3Mw3lZ/t54cFxeEQ7s8YjX10Q=="
Received: from lenov17.lan
    by smtp.strato.de (RZmta 55.0.1 AUTH)
    with ESMTPSA id Kba96d251IJNEPX
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Mon, 1 Jun 2026 20:19:23 +0200 (CEST)
From: Oliver Hartkopp <socketcan@hartkopp.net>
To: linux-can@vger.kernel.org
Cc: Oliver Hartkopp <socketcan@hartkopp.net>,
	Ginger <ginger.jzllee@gmail.com>
Subject: [PATCH can-next] can: bcm: mark intentional lockless read of bo->bound for KCSAN
Date: Mon,  1 Jun 2026 20:19:15 +0200
Message-ID: <20260601181915.71862-1-socketcan@hartkopp.net>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="us-ascii"
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[hartkopp.net,reject];
	R_DKIM_ALLOW(-0.20)[hartkopp.net:s=strato-dkim-0002,hartkopp.net:s=strato-dkim-0003];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[hartkopp.net,gmail.com];
	DKIM_TRACE(0.00)[hartkopp.net:+];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-7732-lists,linux-can=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[socketcan@hartkopp.net,linux-can@vger.kernel.org];
	RCPT_COUNT_THREE(0.00)[3];
	NEURAL_HAM(-0.00)[-0.993];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-can];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 87A37624191
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

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
index a4bef2c48a55..57c2ac2cec7d 100644
--- a/net/can/bcm.c
+++ b/net/can/bcm.c
@@ -1376,11 +1376,12 @@ static int bcm_sendmsg(struct socket *sock, struct msghdr *msg, size_t size)
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
@@ -1510,11 +1511,11 @@ static void bcm_notify(struct bcm_sock *bo, unsigned long msg,
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


