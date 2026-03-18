Return-Path: <linux-can+bounces-7138-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aAjHGNDaummfcgIAu9opvQ
	(envelope-from <linux-can+bounces-7138-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Wed, 18 Mar 2026 18:03:12 +0100
X-Original-To: lists+linux-can@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DD572BFD99
	for <lists+linux-can@lfdr.de>; Wed, 18 Mar 2026 18:03:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 28B6B35C11B0
	for <lists+linux-can@lfdr.de>; Wed, 18 Mar 2026 16:54:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46B24262FE7;
	Wed, 18 Mar 2026 16:54:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="ZZzSVokX";
	dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="YUWujA+T"
X-Original-To: linux-can@vger.kernel.org
Received: from mo4-p02-ob.smtp.rzone.de (mo4-p02-ob.smtp.rzone.de [85.215.255.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6F75253359;
	Wed, 18 Mar 2026 16:54:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=85.215.255.82
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773852880; cv=pass; b=szFuJyOISeMux7KYly87zUnDIanSqYlLSR+L4fwKKzN8l2Y+ayiQXUDA6Jy6DHjF90nS5bLVcJIlFZnHAcQlKpF5ySnJjl0iPKg3IxS8n1hq88MBinKpljh+m5bfAk6qRU0h9ATQOSJOxWfJwbDDRpYEkyKjGsDoANYJrQkUxKg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773852880; c=relaxed/simple;
	bh=/k9DjZs9HuznrEsEgEnWrtTj3Q7mI6JrR369Z+5naec=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=k61Zonzw9u326w1bzIZ9X0vU3H9XWQVRHQKJRpAYLTnE/Tp+q/LubJxGh/bpb1pGgTavIJEi3gYsCDoXodUEVGVexBBYf3KEbOLfkU5evx55bafvOcQo9Nnvwtd1ga3ucZisuYFfeiulbH3IDQgNgueqswCruF/g5bzGfdrYsX8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net; spf=fail smtp.mailfrom=hartkopp.net; dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=ZZzSVokX; dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=YUWujA+T; arc=pass smtp.client-ip=85.215.255.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=hartkopp.net
ARC-Seal: i=1; a=rsa-sha256; t=1773852696; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=YSIIC/WoSwMWsFxSNLtmX0I1EDeCfBNB3I0mKbuuH6eqoDuqAXDlAn8R+Gj/GxMU1c
    HQDLeqkozuMGt2F0RAPP8KttVTkreoUgQPyuFumu0kjvhLCYyxmDjFKbEyIA5Q+Gw7X+
    Uc9ou9/3Qo3J54dEOwDD6lvReiAW+dlLIZc+ZVywwms+xOt+SEaEFozE6zj0T/hedvLs
    mN5csX6wkIQYqkBbDkVycrB0nxy2PbJNuQBrUjskPqs7GfnNJcjrewmDE1PYsIyxqcQ0
    0gz+TUjBhZzRKzisxcAkCGFbWLqrDZL1duiw144ew39SQGObtvt2K09lQZUIqzyoBrNy
    TU5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1773852696;
    s=strato-dkim-0002; d=strato.com;
    h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=OqP7gq/LowT7pcNzuhoIrzO3GvrxyRnB6oXUy5+oLp0=;
    b=iVsZn0pzjM1KC3+bsRe/O2eKakz65Dubux6/OgMbhXbjz0K3qDGsYNQImdo4GY5E3M
    lo4ovzQ1tNNff7nXB2ZINzymFhqLhtOri4XN3rXlCjqA9u3/qBipk9Ifo5+zKP8cXcqR
    THjnrpBrW49BSQ2lnQhazcWitfGU9yJh79xZ4YRcOfRpSs42kzZOHjfBzNJCSO95/23C
    JhxMA1ssEIVhLaqqKU3JbDD6wdnI+8mUfmQpKLh3MpWSLrfQGjwhUAHp/GNntzTisz42
    UBmoxxxzZD72Z6oN2/NsK8GRpiQHmdvAN+3SnIPAOJDxFg7mwwTe4KE9ZV0I+OI0aEK7
    ZlPQ==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo02
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1773852696;
    s=strato-dkim-0002; d=hartkopp.net;
    h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=OqP7gq/LowT7pcNzuhoIrzO3GvrxyRnB6oXUy5+oLp0=;
    b=ZZzSVokXviTubwTrWtgxM2bANetrRElAzsoELvu+9AuIEYQxNv2trawGq0hOKjI2qt
    fGtc81xbAjmnfCIFReR2N7yT2AhfBJrqSiNNLOegeUrbO4zxNYGpK2+APmuztQWwa3cT
    IuEEWbdDn1OH9PB08ixfkUOfrx4zc/ugSpI4WJVI+NNIzqc+bVZDUzvH+udIr5WkOVsA
    swBIVU0wzUjgf349I0lkhsnN2zJxGxgcMfj73Nw3+r7MCxpdND0TV6OI41qdr5vH3nwB
    jxYtq0Ge7iTfHIJTEfykMp8xiXVZdTAYUkXoE7HGiCpTzF8b09lN0TeMeZm6ASyZ8MQP
    sxWQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1773852696;
    s=strato-dkim-0003; d=hartkopp.net;
    h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=OqP7gq/LowT7pcNzuhoIrzO3GvrxyRnB6oXUy5+oLp0=;
    b=YUWujA+TLl4u7WlB9Gm73Ci0iZo0A9v4BHPwnTLytnMYebMZfz254OI16S3GzdVdof
    58svQ5HxdWsYDkuL4bAA==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjH4JKvMdQv2tTUsMrZpkO3Mw3lZ/t54cFxeFQ7s0ZDT0tksFSR+Aix0esQJVIAlZEg=="
Received: from lenov17.lan
    by smtp.strato.de (RZmta 55.0.1 AUTH)
    with ESMTPSA id Kba96d22IGpaozR
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Wed, 18 Mar 2026 17:51:36 +0100 (CET)
From: Oliver Hartkopp <socketcan@hartkopp.net>
To: linux-can@vger.kernel.org
Cc: Oliver Hartkopp <socketcan@hartkopp.net>,
	stable@vger.kernel.org,
	Ali Norouzi <ali.norouzi@keysight.com>
Subject: [PATCH 2/2] can: isotp: fix tx.buf use-after-free in isotp_sendmsg()
Date: Wed, 18 Mar 2026 17:51:20 +0100
Message-ID: <20260318165120.17560-2-socketcan@hartkopp.net>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260318165120.17560-1-socketcan@hartkopp.net>
References: <20260318165120.17560-1-socketcan@hartkopp.net>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[hartkopp.net:s=strato-dkim-0002,hartkopp.net:s=strato-dkim-0003];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-7138-lists,linux-can=lfdr.de];
	DKIM_TRACE(0.00)[hartkopp.net:+];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[socketcan@hartkopp.net,linux-can@vger.kernel.org];
	RCPT_COUNT_THREE(0.00)[4];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-can];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,hartkopp.net:dkim,hartkopp.net:email,hartkopp.net:mid,keysight.com:email]
X-Rspamd-Queue-Id: 4DD572BFD99
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

isotp_sendmsg() uses only cmpxchg() on so->tx.state to serialize access
to so->tx.buf. isotp_release() waits for ISOTP_IDLE via
wait_event_interruptible() and then calls kfree(so->tx.buf).

If a signal interrupts the wait_event_interruptible() inside close()
while tx.state is ISOTP_SENDING, the loop exits early and release
proceeds to force ISOTP_SHUTDOWN and continues to kfree(so->tx.buf)
while sendmsg may still be reading so->tx.buf for the final CAN frame
in isotp_fill_dataframe().

The so->tx.buf can be allocated once when the standard tx.buf length needs
to be extended. Move the kfree() of this potentially extended tx.buf to
sk_destruct time when either isotp_sendmsg() and isotp_release() are done.

Fixes: e057dd3fc20f ("can: add ISO 15765-2:2016 transport protocol")
Cc: stable@vger.kernel.org
Reported-by: Ali Norouzi <ali.norouzi@keysight.com>
Co-developed-by: Ali Norouzi <ali.norouzi@keysight.com>
Signed-off-by: Oliver Hartkopp <socketcan@hartkopp.net>
---
 net/can/isotp.c | 24 ++++++++++++++++++------
 1 file changed, 18 insertions(+), 6 deletions(-)

diff --git a/net/can/isotp.c b/net/can/isotp.c
index da3b72e7afcc..2770f43f4951 100644
--- a/net/can/isotp.c
+++ b/net/can/isotp.c
@@ -1246,16 +1246,10 @@ static int isotp_release(struct socket *sock)
 	hrtimer_cancel(&so->rxtimer);
 
 	so->ifindex = 0;
 	so->bound = 0;
 
-	if (so->rx.buf != so->rx.sbuf)
-		kfree(so->rx.buf);
-
-	if (so->tx.buf != so->tx.sbuf)
-		kfree(so->tx.buf);
-
 	sock_orphan(sk);
 	sock->sk = NULL;
 
 	release_sock(sk);
 	sock_prot_inuse_add(net, sk->sk_prot, -1);
@@ -1620,10 +1614,25 @@ static int isotp_notifier(struct notifier_block *nb, unsigned long msg,
 	isotp_busy_notifier = NULL;
 	spin_unlock(&isotp_notifier_lock);
 	return NOTIFY_DONE;
 }
 
+static void isotp_sock_destruct(struct sock *sk)
+{
+	struct isotp_sock *so = isotp_sk(sk);
+
+	/* do the standard CAN sock destruct work */
+	can_sock_destruct(sk);
+
+	/* free potential extended PDU buffers */
+	if (so->rx.buf != so->rx.sbuf)
+		kfree(so->rx.buf);
+
+	if (so->tx.buf != so->tx.sbuf)
+		kfree(so->tx.buf);
+}
+
 static int isotp_init(struct sock *sk)
 {
 	struct isotp_sock *so = isotp_sk(sk);
 
 	so->ifindex = 0;
@@ -1664,10 +1673,13 @@ static int isotp_init(struct sock *sk)
 
 	spin_lock(&isotp_notifier_lock);
 	list_add_tail(&so->notifier, &isotp_notifier_list);
 	spin_unlock(&isotp_notifier_lock);
 
+	/* re-assign default can_sock_destruct() reference */
+	sk->sk_destruct = isotp_sock_destruct;
+
 	return 0;
 }
 
 static __poll_t isotp_poll(struct file *file, struct socket *sock, poll_table *wait)
 {
-- 
2.51.0


