Return-Path: <linux-can+bounces-8392-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 7dnuMv4RVmoPywAAu9opvQ
	(envelope-from <linux-can+bounces-8392-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Tue, 14 Jul 2026 12:39:58 +0200
X-Original-To: lists+linux-can@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CAC6375378C
	for <lists+linux-can@lfdr.de>; Tue, 14 Jul 2026 12:39:57 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=iUKYuZux;
	spf=pass (mail.lfdr.de: domain of "linux-can+bounces-8392-lists+linux-can=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="linux-can+bounces-8392-lists+linux-can=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id D84783004D0A
	for <lists+linux-can@lfdr.de>; Tue, 14 Jul 2026 10:39:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24EBA368D5A;
	Tue, 14 Jul 2026 10:39:52 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB2E217A300
	for <linux-can@vger.kernel.org>; Tue, 14 Jul 2026 10:39:50 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784025592; cv=none; b=fipVHCZHiN5e9u6f6MES+R5bBlpg2hSvEGZJZIlGM73pxARXGEuvdjD5wQf35WvZ42kd+hSx4YopqFi7n0BWYZWhJ9D9Q0d7/IuWtXSsAI4Uz0qADjTIe69335DZAWdg2AsE2QxpWjnAVCtLSBbYcT6WYS0xYTbQFR7meNXNNWc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784025592; c=relaxed/simple;
	bh=ibkVjZPVUj/9EPhU0ZirLfA50mxle6KpqquMdzk8I4g=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=lN/VgMnTIJgdZdriKC8uHLwk02vpQpHPk7TMEmDItLWOWgoJKQMiv1AJuPzaPfsgSenBVur7vsj6QnwVIyRtAB9FUYehR3AJxMPje2hJEN4WiDIzaWnVa5YbiM5Jx/D1NwEDIZbpgGOfk4jdYtaXk+GVCZLT7a5svbVtkOG5snQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iUKYuZux; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 538C31F000E9;
	Tue, 14 Jul 2026 10:39:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784025590;
	bh=QfuAIYITMND5Pk3Z7Hx5NPNwgilzjIGmNQrqxbgnAew=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=iUKYuZuxz/x7oTREp1lx+IxNua/OYwIksQO8JtFQMADmRcuuElSpoesqU7UJjj9qF
	 D+b4ZO688zar9AipQM9Uq9yXJWKH6JAYI6BubUU8rNyZZSqmAYkAAAQJL80gd7YuOq
	 kyf814BhNmvBxgljv2SfzLNdehN6i6KJJoKRB6xGmT+YXGeNllt56vIIH6ydDvYrj2
	 EhAoXP6aZZWoQTcdRMD84+himTbueQFGmPKBEIE7vFkHuvHpTEz0E0t8TbIC4SPQ+h
	 juuxKMF+2T5GMePQ4/py/dinpuHdkiqm9iMisEB3hFKRNAynQrLHqlxWyRKbTDFRxD
	 /Ld/o7xiOb5ig==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v13 01/11] can: bcm: defer rx_op deallocation to
 workqueue to fix thrtimer UAF
Reply-To: sashiko-reviews@lists.linux.dev
To: "Oliver Hartkopp" <socketcan@hartkopp.net>
Cc: "Marc Kleine-Budde" <mkl@pengutronix.de>, "Oleksij Rempel" <o.rempel@pengutronix.de>, "Vincent
 Mailhol" <mailhol@kernel.org>, "Oliver Hartkopp" <socketcan@hartkopp.net>, linux-can@vger.kernel.org
In-Reply-To: <20260714-bcm_fixes-v13-1-fd667c61099a@hartkopp.net>
References: <20260714-bcm_fixes-v13-0-fd667c61099a@hartkopp.net>
 <20260714-bcm_fixes-v13-1-fd667c61099a@hartkopp.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 14 Jul 2026 10:39:49 +0000
Message-Id: <20260714103950.538C31F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.16 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	MISSING_MIME_VERSION(2.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-8392-lists,linux-can=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	REPLYTO_DN_EQ_FROM_DN(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,lists.linux.dev:replyto,sashiko.dev:url,smtp.kernel.org:mid];
	FORGED_SENDER(0.00)[sashiko-bot@kernel.org,linux-can@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:socketcan@hartkopp.net,m:mkl@pengutronix.de,m:o.rempel@pengutronix.de,m:mailhol@kernel.org,m:linux-can@vger.kernel.org,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashiko-bot@kernel.org,linux-can@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	TAGGED_RCPT(0.00)[linux-can];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	HAS_REPLYTO(0.00)[sashiko-reviews@lists.linux.dev];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_NO_DN(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: CAC6375378C

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

New issues:
- [High] Module exit sequence destroys the socket slab cache before flushin=
g the deferred workqueue, causing a kernel warning and slab cache leak.

Pre-existing issues:
- [High] Missing RCU-safe list primitives for rx_ops and tx_ops list modifi=
cations and traversals, causing potential crashes during procfs reads.
--

--- Patch [1]: [PATCH v13 01/11] can: bcm: defer rx_op deallocation to work=
queue to fix thrtimer UAF ---
commit 9beb61cd8491cca022797eead8556214843e4d99
Author: Lee Jones <lee@kernel.org>

can: bcm: defer rx_op deallocation to workqueue to fix thrtimer UAF

This commit fixes a use-after-free by deferring the deallocation of
bcm_op to a dedicated workqueue instead of using call_rcu(). It ensures
that hrtimer cancellation and memory freeing occur in a sleepable context.
It also takes a reference on the socket while the work is pending to
prevent the socket from being freed prematurely.

> diff --git a/net/can/bcm.c b/net/can/bcm.c
> index a4bef2c48a559..bdf53241bd7b3 100644
> --- a/net/can/bcm.c
> +++ b/net/can/bcm.c

[ ... ]

> @@ -1060,6 +1081,7 @@ static int bcm_tx_setup(struct bcm_msg_head *msg_he=
ad, struct msghdr *msg,
> =20
>  		/* bcm_can_tx / bcm_tx_timeout_handler needs this */
>  		op->sk =3D sk;
> +		sock_hold(sk);
>  		op->ifindex =3D ifindex;
> =20
>  		/* initialize uninitialized (kzalloc) structure */

[Severity: High]
This is a pre-existing issue, but can traversing the RCU-protected tx_ops
and rx_ops lists without RCU-safe primitives cause crashes during procfs
reads?

Looking at bcm_tx_setup() and bcm_rx_setup(), list_add() is used instead
of list_add_rcu(), which lacks the smp_store_release() memory barriers:

bcm_tx_setup() {
    ...
    /* add this bcm_op to the list of the tx_ops */
    list_add(&op->list, &bo->tx_ops);
    ...
}

Concurrently, if another thread reads /proc/net/can-bcm, bcm_proc_show()
traverses bo->tx_ops locklessly under rcu_read_lock() using the non-RCU
list_for_each_entry():

bcm_proc_show() {
    ...
    list_for_each_entry(op, &bo->tx_ops, list) {
    ...
}

Can weakly ordered CPUs reorder the initialization of the bcm_op structure
after its insertion, allowing lockless RCU readers to observe uninitialized
memory and crash?

[ ... ]

> @@ -1869,6 +1898,8 @@ static void __exit bcm_module_exit(void)
>  	can_proto_unregister(&bcm_can_proto);
>  	unregister_netdevice_notifier(&canbcm_notifier);
>  	unregister_pernet_subsys(&canbcm_pernet_ops);
> +	rcu_barrier();
> +	destroy_workqueue(bcm_wq);
>  }

[Severity: High]
Does this module exit sequence destroy the socket slab cache before flushing
the deferred workqueue?

Looking at bcm_free_op_work(), the deferred work item drops the final socket
reference:

bcm_free_op_work() {
    ...
    sock_put(op->sk);
    kfree(op);
}

If there are pending work items in bcm_wq during module unload,
can_proto_unregister() will call kmem_cache_destroy() on the protocol's
slab cache while sockets are still allocated.

Will this cause a kernel warning and a slab cache leak, since
destroy_workqueue() runs after can_proto_unregister() and will attempt to
free sockets into the destroyed slab?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260714-bcm_fixes-=
v13-0-fd667c61099a@hartkopp.net?part=3D1

