Return-Path: <linux-can+bounces-8226-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id A+VHCx7kT2pPpwIAu9opvQ
	(envelope-from <linux-can+bounces-8226-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Thu, 09 Jul 2026 20:10:38 +0200
X-Original-To: lists+linux-can@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 125FC73424D
	for <lists+linux-can@lfdr.de>; Thu, 09 Jul 2026 20:10:37 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=nj5hBalG;
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	spf=pass (mail.lfdr.de: domain of "linux-can+bounces-8226-lists+linux-can=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="linux-can+bounces-8226-lists+linux-can=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 477713003834
	for <lists+linux-can@lfdr.de>; Thu,  9 Jul 2026 18:10:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B99A9399887;
	Thu,  9 Jul 2026 18:10:31 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 907194DB56B
	for <linux-can@vger.kernel.org>; Thu,  9 Jul 2026 18:10:30 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783620631; cv=none; b=lsUYtQbmVh3lbieiN+I+xMaIdahUaXOAntbm2kOKYm9wU1J+3DGHX68yENS9ET79nltfrpO4Uu9rDXEJvJ5Hdr9NyFlVIbiUgSxUuNsqSurjznrMVs3BkZiKgQXB0ctC9lR8EpBfNvU7ub3Hkhh3zzn/vinEE/b33EATbwvHvTE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783620631; c=relaxed/simple;
	bh=/WxjYUr0Bb8LaDQ3wVVHbgOdtOD137xW6Pg5EgKxEpY=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=op+cdbfyLEto7cNYNEAo72qXocwC9BEjB2Fxa+ri8NOJxIPohpqJfgAHVnLCgUo7642BcVY4PqpX7zgwQaSV0SH4BAZrWBcW4ZgQacw/5yv5/NCbTo2au6Wb1GKMeEX/DgNpsPzkQ56AjVZDxZJx0hzxZOATTKTRk5DOQbT22Lo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nj5hBalG; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CAEC31F000E9;
	Thu,  9 Jul 2026 18:10:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783620630;
	bh=CRyoVJwjD2g5oJhg/LP/CCpMe6ljCb5T2RYVqawKvI4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=nj5hBalGQYt3Gdw2x6JeZLLVONtWo3fP4jie2OwpxgXinRtjq/w9gOSgmAZcKN8PB
	 i7dHiFmbGIjhLQG3oEpGRUbOjAfQ8DsrOV2NFr51nf1nyToXR4YvsiPQk7BnmZfZUe
	 yWJMpwFcdLzfZ1czu5WgvapABy+TKFzALqylLQecWxWninR0Bsqm+zG7Pac4+FU2rY
	 MBworfK+5i0CP9aCBLIMTFvI/ZJHwy+LA/LM+lqg6J/OONrCfbec8UYUJvhpix2LVo
	 ffTF8h6hx39o91FEhM+Zt6OgpJN4Iuj5q9aN1V7lrJBTT7lNFXediCgzwr++WeW1BI
	 rg3klaVrAtVNA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v11 01/11] can: bcm: defer rx_op deallocation to
 workqueue to fix thrtimer UAF
Reply-To: sashiko-reviews@lists.linux.dev
To: "Oliver Hartkopp" <socketcan@hartkopp.net>
Cc: "Marc Kleine-Budde" <mkl@pengutronix.de>, "Vincent Mailhol" <mailhol@kernel.org>, "Oleksij
 Rempel" <o.rempel@pengutronix.de>, "Oliver Hartkopp" <socketcan@hartkopp.net>, linux-can@vger.kernel.org
In-Reply-To: <20260709-bcm_fixes-v11-1-067ba11bec5c@hartkopp.net>
References: <20260709-bcm_fixes-v11-0-067ba11bec5c@hartkopp.net>
 <20260709-bcm_fixes-v11-1-067ba11bec5c@hartkopp.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 09 Jul 2026 18:10:29 +0000
Message-Id: <20260709181029.CAEC31F000E9@smtp.kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-8226-lists,linux-can=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	REPLYTO_DN_EQ_FROM_DN(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,lists.linux.dev:replyto,smtp.kernel.org:mid];
	FORGED_SENDER(0.00)[sashiko-bot@kernel.org,linux-can@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:socketcan@hartkopp.net,m:mkl@pengutronix.de,m:mailhol@kernel.org,m:o.rempel@pengutronix.de,m:linux-can@vger.kernel.org,s:lists@lfdr.de];
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
X-Rspamd-Queue-Id: 125FC73424D

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Data race when updating CAN frames of an existing BCM RX operation
- [High] Missing RCU list primitives causes data races with lockless procfs=
 readers
--

--- Patch [1]: [PATCH v11 01/11] can: bcm: defer rx_op deallocation to work=
queue to fix thrtimer UAF ---
commit ae7bb166ff5dbe1bb7ad111fcf67c490882f4b51
Author: Lee Jones <lee@kernel.org>
can: bcm: defer rx_op deallocation to workqueue to fix thrtimer UAF

This commit fixes a thrtimer UAF during BCM RX operation teardown by
deferring timer cancellation and memory deallocation to a dedicated unbound
workqueue. It also retains a reference on op->sk until the deferred work
completes to ensure the socket is not freed prematurely.

> diff --git a/net/can/bcm.c b/net/can/bcm.c
> index a4bef2c48a559..bdf53241bd7b3 100644
> --- a/net/can/bcm.c
> +++ b/net/can/bcm.c

[ ... ]

> @@ -1221,6 +1243,7 @@ static int bcm_rx_setup(struct bcm_msg_head *msg_he=
ad, struct msghdr *msg,
> =20
>  		/* bcm_can_tx / bcm_tx_timeout_handler needs this */
>  		op->sk =3D sk;
> +		sock_hold(sk);
>  		op->ifindex =3D ifindex;
> =20
>  		/* ifindex for timeout events w/o previous frame reception */

[Severity: High]
This is a pre-existing issue, but does bcm_rx_setup() have a data race when
updating CAN frames for an existing BCM RX operation?

It appears memcpy_from_msg() copies directly from user space into op->frames
without holding op->bcm_rx_update_lock or using a staging buffer:

net/can/bcm.c:bcm_rx_setup() {
    ...
    err =3D memcpy_from_msg(op->frames, msg, msg_head->nframes * op->cfsiz);
    ...
    memset(op->last_frames, 0, msg_head->nframes * op->cfsiz);
    ...
}

Since memcpy_from_msg() can sleep, it cannot hold the lock, but this means
concurrent softirq readers like bcm_rx_handler() might observe partially
updated filter masks:

net/can/bcm.c:bcm_rx_handler() {
    ...
    if ((get_u64(op->frames, 0) & get_u64(rxframe, 0)) =3D=3D
    ...
}

Could this lead to valid CAN frames being incorrectly dropped or invalid
frames accepted?

[Severity: High]
This is a pre-existing issue, but does bcm_rx_setup() lack proper RCU list
primitives when inserting into bo->rx_ops?

It currently uses the non-RCU list_add() during setup:

net/can/bcm.c:bcm_rx_setup() {
    ...
    list_add(&op->list, &bo->rx_ops);
    ...
}

This lacks the smp_store_release() barrier needed for concurrent lockless
readers. For instance, bcm_proc_show() iterates these lists locklessly
under rcu_read_lock(), but it uses list_for_each_entry() instead of
list_for_each_entry_rcu():

net/can/bcm.c:bcm_proc_show() {
    ...
    list_for_each_entry(op, &bo->tx_ops, list) {
    ...
}

Can this lack of memory ordering and dependency barriers allow the compiler
to generate unsafe traversals, potentially leading to a NULL pointer
dereference or invalid list traversal for concurrent procfs readers of
/proc/net/can-bcm/*?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260709-bcm_fixes-=
v11-0-067ba11bec5c@hartkopp.net?part=3D1

