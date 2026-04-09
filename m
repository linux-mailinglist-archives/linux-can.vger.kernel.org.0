Return-Path: <linux-can+bounces-7356-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EAQUD/+l12lfQwgAu9opvQ
	(envelope-from <linux-can+bounces-7356-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Thu, 09 Apr 2026 15:13:35 +0200
X-Original-To: lists+linux-can@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id A669E3CAD9D
	for <lists+linux-can@lfdr.de>; Thu, 09 Apr 2026 15:13:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C8B03300CFDF
	for <lists+linux-can@lfdr.de>; Thu,  9 Apr 2026 13:08:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D7563CFF40;
	Thu,  9 Apr 2026 13:08:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="Tp5plm+b";
	dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="nkJeO9CL"
X-Original-To: linux-can@vger.kernel.org
Received: from mo4-p00-ob.smtp.rzone.de (mo4-p00-ob.smtp.rzone.de [81.169.146.163])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6D3B3CE494;
	Thu,  9 Apr 2026 13:08:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=81.169.146.163
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775740121; cv=pass; b=mXU76gPXWxINmaFdTK6rdCCqA8E6IWmriQLTOcOkpX/bjieJTM1VqykwpyJD6A4k1K72vvhA7KeCOdnFPHJeA6yq7KLl8U81ZuTC78pjKr/CzvXysN3VypCaCQni5qIpaUbxhHKUOVhO/s4wIxIVailctiitV5ipM3GpQbHDbjI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775740121; c=relaxed/simple;
	bh=fp3X3u5KlLw8hurkqdi1TLRXvEcg0i8GZ6J8YSrWyAo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=jeDy3GSXXhYtYFNWtWhw8qoaLMFRgtg1Yi9ZsFLWr4B+JW5gWCVIu0zMsL6pYxTx7Hjz8R8D3dQEgI6DxJjvAWWKSXJoOMqe+sD5uwILid92o8lQpoqYqYpxyXrvHBqtFvzBOTDRn1h4Wb9feoVhTeFyg6/cZBgzz3qTUUYaHfE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net; spf=fail smtp.mailfrom=hartkopp.net; dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=Tp5plm+b; dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=nkJeO9CL; arc=pass smtp.client-ip=81.169.146.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=hartkopp.net
ARC-Seal: i=1; a=rsa-sha256; t=1775740110; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=HwNENedMAbFSI/fpPSc7AjdZrAHBq6R7mJEeVHB5PnitjEhr/5z0zgstgr+cyhYGDZ
    Fs4Vxivvnyt9QwyFSd7hQJiGW2pURTNLQh2GpuTdgtKfdK9foFmGN1o0U3wCN3v62fhA
    DOtNwh4/l0FbKZskwFwzvPrEjK6eX+5SiaAeHcaPUP61qGbjXGL+RyImjG5BPN26nlNp
    S/I3gfwaM4ynZlHKQnqFJMCQ6IzZ8MGxBmcmSquVNbfB0dxqlvmCHKxb0xvMlZMbdLXV
    QmAh+0wEN13wHWm8VFRvuawUjdV9foHMioEJdtGqdtyun3i54ytV+JGAti56QRRpVbYa
    0mLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1775740110;
    s=strato-dkim-0002; d=strato.com;
    h=Message-ID:Date:Subject:Cc:To:From:Cc:Date:From:Subject:Sender;
    bh=mc9VNk7Uu5L/Cxai0oM4Re6XXRI+AWhCrL8d5zIrUCA=;
    b=XPUGT2ZS53PMQhXdjaLnoGmLs8JrH+KNLsMR0TLUA25rqOQ0OIb4DKDaau2mZXJpqe
    vj/3Uokh3pSBiaAqLN3WY+uL/FghDlW3wDA6tzgVGb2kkJ8XKW3M80CY/6WDMdRl87Es
    dQy4Ti5Ide3TB9SwWaim5a9vaxCwB20ECFzJl8sBC/ygY3GL6gV/dU2PGHP/m2cewlp1
    O9/0+08GIimVbNwYIbIMPwUkob5bnVDvxWCGchCBRNzGti3Cvje268tjFHYHXqkaXvu7
    kVWqa0OaOW3a8t0k79QMFTpIJXb2/mRZKhosBFrizWqyGkdxwNatIQfynDHKjJZ6oSzN
    Qo7g==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo00
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1775740110;
    s=strato-dkim-0002; d=hartkopp.net;
    h=Message-ID:Date:Subject:Cc:To:From:Cc:Date:From:Subject:Sender;
    bh=mc9VNk7Uu5L/Cxai0oM4Re6XXRI+AWhCrL8d5zIrUCA=;
    b=Tp5plm+bB4cVVrghi4iH7s0NsZUoLMkRpPyAcMNcdofS938hb863bDLer3y9Zf+9c+
    fMJx7k4pk7IaGb3CzAYD4q3hqEFIs0732MCnfRUNMxrqnuyonj3IZ3ku99Rm15uhN7Yx
    UbZ5sWUQDoL9ZhO45EDiUva0SMhYsB/JoHeRG0tJgnKc3u290HKq4GuaK4m/arEa5A/S
    Gm9U1aXPfR31l1hCl8d3vBkhDl8OfBArz9to7/wrzYrIAxX+PA9/BBIQmpNWEkusu3Aj
    SRok2gDbWbFVLz6+EUpsUeh9BftVsm0KupE2D/+65rKcxAgl7K/sqkbghjrGOVh8i9wv
    NxzQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1775740110;
    s=strato-dkim-0003; d=hartkopp.net;
    h=Message-ID:Date:Subject:Cc:To:From:Cc:Date:From:Subject:Sender;
    bh=mc9VNk7Uu5L/Cxai0oM4Re6XXRI+AWhCrL8d5zIrUCA=;
    b=nkJeO9CLUS7qjv3Z6R87sBRveXcKaVGHP0VF/lFeJZbmiB0n0KjYwISGM43/LwAXFg
    t/86iySAhCJqfkF5l9CA==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjH4JKvMdQv2tTRsLs5FrPm8xWJP2FLGj7g=="
Received: from blue.home
    by smtp.strato.de (RZmta 55.0.1 AUTH)
    with ESMTPSA id Kba96d239D8UxJi
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Thu, 9 Apr 2026 15:08:30 +0200 (CEST)
From: Oliver Hartkopp <socketcan@hartkopp.net>
To: linux-can@vger.kernel.org
Cc: Samuel Page <sam@bynar.io>,
	stable@vger.kernel.org,
	Oliver Hartkopp <socketcan@hartkopp.net>
Subject: [PATCH] can: raw: fix ro->uniq use-after-free in raw_rcv()
Date: Thu,  9 Apr 2026 15:08:14 +0200
Message-ID: <20260409130814.72175-1-socketcan@hartkopp.net>
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
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[hartkopp.net,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[hartkopp.net:s=strato-dkim-0002,hartkopp.net:s=strato-dkim-0003];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[hartkopp.net:+];
	TAGGED_FROM(0.00)[bounces-7356-lists,linux-can=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[socketcan@hartkopp.net,linux-can@vger.kernel.org];
	RCPT_COUNT_THREE(0.00)[4];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-can];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: A669E3CAD9D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Samuel Page <sam@bynar.io>

raw_release() unregisters raw CAN receive filters via can_rx_unregister(),
but receiver deletion is deferred with call_rcu(). This leaves a window
where raw_rcv() may still be running in an RCU read-side critical section
after raw_release() frees ro->uniq, leading to a use-after-free of the
percpu uniq storage.

Move free_percpu(ro->uniq) out of raw_release() and into a raw-specific
socket destructor. can_rx_unregister() takes an extra reference to the
socket and only drops it from the RCU callback, so freeing uniq from
sk_destruct ensures the percpu area is not released until the relevant
callbacks have drained.

Fixes: 514ac99c64b2 ("can: fix multiple delivery of a single CAN frame for overlapping CAN filters")
Cc: stable@vger.kernel.org # v4.1+
Assisted-by: Bynario AI
Signed-off-by: Samuel Page <sam@bynar.io>
Acked-by: Oliver Hartkopp <socketcan@hartkopp.net>
---
 net/can/raw.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/net/can/raw.c b/net/can/raw.c
index eee244ffc31e..58a96e933deb 100644
--- a/net/can/raw.c
+++ b/net/can/raw.c
@@ -361,6 +361,14 @@ static int raw_notifier(struct notifier_block *nb, unsigned long msg,
 	return NOTIFY_DONE;
 }
 
+static void raw_sock_destruct(struct sock *sk)
+{
+	struct raw_sock *ro = raw_sk(sk);
+
+	free_percpu(ro->uniq);
+	can_sock_destruct(sk);
+}
+
 static int raw_init(struct sock *sk)
 {
 	struct raw_sock *ro = raw_sk(sk);
@@ -387,6 +395,8 @@ static int raw_init(struct sock *sk)
 	if (unlikely(!ro->uniq))
 		return -ENOMEM;
 
+	sk->sk_destruct = raw_sock_destruct;
+
 	/* set notifier */
 	spin_lock(&raw_notifier_lock);
 	list_add_tail(&ro->notifier, &raw_notifier_list);
@@ -436,7 +446,6 @@ static int raw_release(struct socket *sock)
 	ro->bound = 0;
 	ro->dev = NULL;
 	ro->count = 0;
-	free_percpu(ro->uniq);
 
 	sock_orphan(sk);
 	sock->sk = NULL;
-- 
2.53.0


