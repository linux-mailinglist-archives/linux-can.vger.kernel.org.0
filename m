Return-Path: <linux-can+bounces-8089-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id wW82JrQWTWp8uwEAu9opvQ
	(envelope-from <linux-can+bounces-8089-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Tue, 07 Jul 2026 17:09:40 +0200
X-Original-To: lists+linux-can@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E691071D07E
	for <lists+linux-can@lfdr.de>; Tue, 07 Jul 2026 17:09:39 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=fw8aSxrQ;
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	spf=pass (mail.lfdr.de: domain of "linux-can+bounces-8089-lists+linux-can=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-can+bounces-8089-lists+linux-can=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E5DE932102A4
	for <lists+linux-can@lfdr.de>; Tue,  7 Jul 2026 14:48:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FEE334B1A6;
	Tue,  7 Jul 2026 14:47:40 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2ADE7305669
	for <linux-can@vger.kernel.org>; Tue,  7 Jul 2026 14:47:38 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783435660; cv=none; b=TbR1LUS2WGFJbs/Hs5df6ZFjdnL0XG3jTLvZzCAjwmdJaAObCdrdmcY+6jO74hGg8dED/8RvE3EEtwwdKrbSHIZlFKbJmP4tPHw3Ap+JcCAABwWM7Ggb0VGh9L9D3XcB+bdzmnKOA6bNqY/wtefGkyhmS76tSge9qnhmzS7VkX8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783435660; c=relaxed/simple;
	bh=U2qCjzmIWTLhsKQ4ced5vlppAezraALGxV0+O2+O9KA=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=I53YSupSXEgeneBInFrGpESTVdTgJtntn1ne6NcAkm/V2MNxSZ6M1euGbN8sRg7c78dFxBcG5ny1ogtBIUJAKPALQkE9ADksx/8/QoYgawWOh62niDpC9QGRUyjHrw7+fRg/ewJJsTLXimRlEnI404B7TlhJvsarkulafbfTWR0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fw8aSxrQ; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 735321F00A3F;
	Tue,  7 Jul 2026 14:47:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783435658;
	bh=zBKhJ+AQ2j8+UYq/206u9PU6DC5knbJVwu2hey1SZOE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=fw8aSxrQWuuDKwfP/IfIlmjuoL8vSqTybNU27WyLnCS5kAxsvSrJFp27mZmWXJMcc
	 QrtXW+GKzMyl62NFLWw3BtvZeSRpcER1YlylFU6bGGTPXZEzTJG0NPtfqzx54IhcAu
	 c5/LtqxBUcw2nMmVg1g/2bspPyJQjqUhtk+29OXtSTBFrL2im1wpC5IwM/5UXP82tP
	 3JoP0PQHIoGwEs6S5iSbiFUEy05igpB89zBR1wsF7o6kI+GzW/1hUyJ/yaOAxzGrED
	 aKMP5YbpoapUZcnihmvWqBnSvj0n9GMB1qyT+lZZ9bHJ+Dacf3OB+Gp5LFx+8qah2Q
	 LkacKQmxIJWHw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 1/7] can: bcm: defer rx_op deallocation to workqueue
 to fix thrtimer UAF
Reply-To: sashiko-reviews@lists.linux.dev
To: "Oliver Hartkopp" <socketcan@hartkopp.net>
Cc: "Oliver Hartkopp" <socketcan@hartkopp.net>, linux-can@vger.kernel.org, "Marc
 Kleine-Budde" <mkl@pengutronix.de>, "Vincent Mailhol" <mailhol@kernel.org>, "Oleksij
 Rempel" <o.rempel@pengutronix.de>
In-Reply-To: <20260707-bcm_fixes-v4-1-aa87b8b9d33f@hartkopp.net>
References: <20260707-bcm_fixes-v4-0-aa87b8b9d33f@hartkopp.net>
 <20260707-bcm_fixes-v4-1-aa87b8b9d33f@hartkopp.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 07 Jul 2026 14:47:38 +0000
Message-Id: <20260707144738.735321F00A3F@smtp.kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-8089-lists,linux-can=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	REPLYTO_DN_EQ_FROM_DN(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sashiko.dev:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,smtp.kernel.org:mid,vger.kernel.org:from_smtp,lists.linux.dev:replyto];
	FORGED_SENDER(0.00)[sashiko-bot@kernel.org,linux-can@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:socketcan@hartkopp.net,m:linux-can@vger.kernel.org,m:mkl@pengutronix.de,m:mailhol@kernel.org,m:o.rempel@pengutronix.de,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashiko-bot@kernel.org,linux-can@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[linux-can];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_NO_DN(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	HAS_REPLYTO(0.00)[sashiko-reviews@lists.linux.dev]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: E691071D07E

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Concurrent procfs reads can crash the kernel due to unsafe lockles=
s list operations on `bo->rx_ops` and `bo->tx_ops`.
--

--- Patch [1]: [PATCH v4 1/7] can: bcm: defer rx_op deallocation to workque=
ue to fix thrtimer UAF ---
commit 784fd8a5d6989051af26ae5075b37f80eb5ecce7
Author: Lee Jones <lee@kernel.org>

can: bcm: defer rx_op deallocation to workqueue to fix thrtimer UAF

This commit resolves a use-after-free issue by deferring the cancellation
of timers and the deallocation of BCM operations to an unbound workqueue.
It takes an additional socket reference to ensure the socket outlives the
deferred work.

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
This is a pre-existing issue, but can concurrent procfs reads crash the ker=
nel
due to unsafe lockless list operations on bo->tx_ops?

Later in bcm_tx_setup(), the new op is added to the list:

    list_add(&op->list, &bo->tx_ops);

However, bcm_proc_show() locklessly iterates bo->tx_ops using the non-RCU
macro list_for_each_entry() instead of list_for_each_entry_rcu(), and
bcm_tx_setup() uses list_add() instead of list_add_rcu(). Because list_add()
lacks the smp_store_release() memory barrier of list_add_rcu(), and because
the tx_ops traversal lacks rcu_dereference() to enforce data dependencies,
the reader CPU can observe the new list node before its fields or next
pointer are initialized.

Could this lead to dereferencing uninitialized memory or a corrupted next
pointer if a local user repeatedly reads /proc/net/can-bcm/<inode> while a
thread creates new TX operations via sendmsg()?

[ ... ]

> @@ -1221,6 +1243,7 @@ static int bcm_rx_setup(struct bcm_msg_head *msg_he=
ad, struct msghdr *msg,
> =20
>  		/* bcm_can_tx / bcm_tx_timeout_handler needs this */
>  		op->sk =3D sk;
> +		sock_hold(sk);
>  		op->ifindex =3D ifindex;

[Severity: High]
This is also a pre-existing issue, but a similar hazard exists for bo->rx_o=
ps.

Later in bcm_rx_setup(), the code inserts into the list without RCU barrier=
s:

    list_add(&op->list, &bo->rx_ops);

While bcm_proc_show() does use list_for_each_entry_rcu() for rx_ops (unlike
tx_ops), bcm_rx_setup() still uses list_add() instead of list_add_rcu().
Without the smp_store_release() memory barrier provided by list_add_rcu(),
concurrent procfs reads can still observe the new node before its contents
are fully initialized.

Should these insertions be upgraded to use list_add_rcu() to match the
lockless RCU iteration in procfs?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260707-bcm_fixes-=
v4-0-aa87b8b9d33f@hartkopp.net?part=3D1

