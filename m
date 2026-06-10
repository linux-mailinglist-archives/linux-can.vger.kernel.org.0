Return-Path: <linux-can+bounces-7817-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id P/0PN7mYKWp7aQMAu9opvQ
	(envelope-from <linux-can+bounces-7817-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Wed, 10 Jun 2026 19:02:49 +0200
X-Original-To: lists+linux-can@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D6E166BCC5
	for <lists+linux-can@lfdr.de>; Wed, 10 Jun 2026 19:02:49 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b="keDdY/eR";
	spf=pass (mail.lfdr.de: domain of "linux-can+bounces-7817-lists+linux-can=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="linux-can+bounces-7817-lists+linux-can=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 6BC6F3045539
	for <lists+linux-can@lfdr.de>; Wed, 10 Jun 2026 16:55:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 772DB34107F;
	Wed, 10 Jun 2026 16:54:05 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9D463438A0
	for <linux-can@vger.kernel.org>; Wed, 10 Jun 2026 16:54:01 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781110445; cv=none; b=ppJog2wS1sFhwuiKPVD82VKkQNn2uiE4fv+VR973DpKlOmGXrWj3BJrUcNgW87axJi/uv8alQL+sTJs+3AhVkqvUFPEdf5i+HfFfYbGPs0IYvl6JUOLImQCkmcI1DdNSjuoUaSr/l3kty4ZSaZEm6YOMGJKwY/5Wk7POA8fju3U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781110445; c=relaxed/simple;
	bh=HDRBlj0iX6HSxBNognSgyhw5V7nAvkLT/7biOE544C4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=cQ8MMwoWWVXekPXNElLMxQCSEm61BFnt05c2nOg8IqWXCUXmaQDO/id5F4RICFAzuPkqdX42Xm+9ZiNkG3+CvxQuUohGUm2unljRxZ7NBPS0JoAfKFoQfnoBZERogOoeEK6QfVDzZVKOxLoHKTsh+9LAKjIjD1uSaNe1Eyt6BFM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=keDdY/eR; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 764431F00893;
	Wed, 10 Jun 2026 16:54:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781110441;
	bh=l5LXCLnDhIvnkG/3h2fKaaZbabH+VK+jzbj550cnf64=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=keDdY/eRyYykypCOABsYg+WZFW0KFpRBQe03IWTs6AQuwyAxpPg2gzvpEHHNlPbM+
	 vId6LRyMA2yIYN/GHXtZf7NsGGi/ZY5Pnqx1newEED/nltIPrvL8LwVMVyLs27AoVd
	 sjhbWORp504y/m2HZII7MD0xrfvRCVfRN7Z0Bq8RuXTRLHa38KMIfAmM1ImExzfy29
	 pQX0l28oIwembwrOxcnB1flSzkNyIsSibdinyLuNDOd7EKHa9nQk2yJIWZdPNk48/Y
	 m1bX0Yjmw3nNBZVNKROiuha8gDYI41dQ8/OSQc5Gah4grGtHbkmxIcbOI+9Rt8t3vB
	 Rt1Flvy9XP4+w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2] can: bcm: fix CAN frame rx/tx statistics
Reply-To: sashiko-reviews@lists.linux.dev
To: "Oliver Hartkopp" <socketcan@hartkopp.net>
Cc: "Vincent Mailhol" <mailhol@kernel.org>, "Oleksij Rempel" <o.rempel@pengutronix.de>, linux-can@vger.kernel.org, "Marc
 Kleine-Budde" <mkl@pengutronix.de>
In-Reply-To: <20260610163744.51980-1-socketcan@hartkopp.net>
References: <20260610163744.51980-1-socketcan@hartkopp.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 10 Jun 2026 16:53:59 +0000
Message-Id: <20260610165400.764431F00893@smtp.kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-7817-lists,linux-can=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	REPLYTO_DN_EQ_FROM_DN(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[hartkopp.net:email,smtp.kernel.org:mid,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,vger.kernel.org:from_smtp,sashiko.dev:url,lists.linux.dev:replyto];
	FORGED_SENDER(0.00)[sashiko-bot@kernel.org,linux-can@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:socketcan@hartkopp.net,m:mailhol@kernel.org,m:o.rempel@pengutronix.de,m:linux-can@vger.kernel.org,m:mkl@pengutronix.de,s:lists@lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_NO_DN(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	HAS_REPLYTO(0.00)[sashiko-reviews@lists.linux.dev]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 7D6E166BCC5

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:

New issues:
- [Medium] Lockless sequential resetting of related statistics creates a ra=
ce condition leading to invalid procfs output.

Pre-existing issues:
- [High] Missing synchronize_rcu() in bcm_delete_rx_op() causes Use-After-F=
ree of bcm_op due to concurrent timer re-arming.
- [High] Incomplete fix for concurrent rx data races leaves CAN frame paylo=
ad and timestamps vulnerable to corruption.
--

commit da9dc73034abe67929230960f0d96f1b0cc6b4c0
Author: Oliver Hartkopp <socketcan@hartkopp.net>

can: bcm: fix CAN frame rx/tx statistics

KCSAN detected a data race within the bcm_rx_handler() when two CAN frames
have been simultaneously received and processed in a single rx op by two
different CPUs. This patch uses atomic operations with (signed) long data
types to access the statistics in the hot path.

> diff --git a/net/can/bcm.c b/net/can/bcm.c
> index a4bef2c48a559..e7b1eb61918f5 100644
> --- a/net/can/bcm.c
> +++ b/net/can/bcm.c
[ ... ]
> @@ -249,9 +252,9 @@ static int bcm_proc_show(struct seq_file *m, void *v)
>  				   (long long)ktime_to_us(op->kt_ival2));
> =20
>  		seq_printf(m, "# recv %ld (%ld) =3D> reduction: ",
> -			   op->frames_filtered, op->frames_abs);
> +			   frames_filtered, frames_abs);
> =20
> -		reduction =3D 100 - (op->frames_filtered * 100) / op->frames_abs;
> +		reduction =3D 100 - (frames_filtered * 100) / frames_abs;
> =20
>  		seq_printf(m, "%s%ld%%\n",
>  			   (reduction =3D=3D 100) ? "near " : "", reduction);

[Severity: Medium]
Could this reduction calculation produce a wildly incorrect negative
percentage if the counters become desynchronized?

[ ... ]
> @@ -285,6 +289,15 @@ static int bcm_proc_show(struct seq_file *m, void *v)
>  }
>  #endif /* CONFIG_PROC_FS */
> =20
> +static void bcm_update_stats(struct bcm_op *op)
> +{
> +	/* prevent statistics overflow */
> +	if (atomic_long_inc_return(&op->frames_abs) > LONG_MAX / 100) {
> +		atomic_long_set(&op->frames_filtered, 0);
> +		atomic_long_set(&op->frames_abs, 0);
> +	}
> +}

[Severity: Medium]
Does sequentially resetting these atomic counters introduce a race window?

If a thread is preempted between resetting frames_filtered and frames_abs,
could another thread process numerous CAN frames and increment both counter=
s,
leaving frames_filtered at a large value when the delayed thread resumes and
resets only frames_abs?

[ ... ]
> @@ -723,7 +733,7 @@ static void bcm_rx_handler(struct sk_buff *skb, void =
*data)
>  	/* save originator for recvfrom() */
>  	op->rx_ifindex =3D skb->dev->ifindex;
>  	/* update statistics */
> -	op->frames_abs++;
> +	bcm_update_stats(op);

[Severity: High]
This isn't a bug introduced by this patch, but since bcm_rx_handler() can
execute concurrently on multiple CPUs, does this leave the rest of the
shared bcm_op state vulnerable?

Concurrent lockless writes to op->rx_stamp and op->rx_ifindex could cause
torn reads.

Additionally, bcm_rx_update_and_send() performs a non-atomic memcpy()
to shared memory:

net/can/bcm.c:bcm_rx_update_and_send() {
	...
	memcpy(lastdata, rxdata, op->cfsiz);
	lastdata->flags |=3D (RX_RECV|RX_THR);
	lastdata->flags |=3D traffic_flags;
	...
}

Can this corrupt the CAN frame payload delivered to userspace?

[Severity: High]
This is a pre-existing issue, but is there a use-after-free risk during
RX operation removal?

When bcm_delete_rx_op() removes an RX operation, it defers subscriber
removal to an RCU callback via can_rx_unregister(). It then calls
bcm_remove_op() which cancels timers and frees the bcm_op via call_rcu()
without waiting for existing readers:

net/can/bcm.c:bcm_delete_rx_op() {
	...
	can_rx_unregister(sock_net(op->sk), NULL, op->can_id,
			  REGMASK(op->can_id), bcm_rx_handler, op);
	list_del_rcu(&op->list);
	bcm_remove_op(op);
	...
}

Could a concurrently executing bcm_rx_handler() subsequently call
bcm_rx_update_and_send(), which unconditionally executes
hrtimer_start(&op->thrtimer, ...)?

Does this re-arm the timer after it was cancelled, causing a use-after-free
when the timer fires after the bcm_op memory is freed at the end of the RCU
grace period?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260610163744.5198=
0-1-socketcan@hartkopp.net?part=3D1

