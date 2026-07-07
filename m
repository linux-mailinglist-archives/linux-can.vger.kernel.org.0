Return-Path: <linux-can+bounces-8033-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id VyDEDsG0TGrjoQEAu9opvQ
	(envelope-from <linux-can+bounces-8033-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Tue, 07 Jul 2026 10:11:45 +0200
X-Original-To: lists+linux-can@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B4AD718F22
	for <lists+linux-can@lfdr.de>; Tue, 07 Jul 2026 10:11:44 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=H42KxepQ;
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	spf=pass (mail.lfdr.de: domain of "linux-can+bounces-8033-lists+linux-can=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-can+bounces-8033-lists+linux-can=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 79F643046376
	for <lists+linux-can@lfdr.de>; Tue,  7 Jul 2026 07:59:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD1962EA154;
	Tue,  7 Jul 2026 07:59:38 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A93552F12A1
	for <linux-can@vger.kernel.org>; Tue,  7 Jul 2026 07:59:37 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783411178; cv=none; b=bgDbRqNiEp5NW6eOSUlnqoDsExP1IB+FhLUK8YYM+W4eewZwXWZIowy1aoh+whldbSYcWhzD6JTQ6jOe9LGJtqkGljaxWVh6emYuUFUlpnfQoCACxBszPQscVBPqJlSJB3f21uoARCSyFU1nsrshjUtOtMXg0cImgIV6szIPQsw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783411178; c=relaxed/simple;
	bh=XPvG3A/+N88vDIFjVnadVtrKI8AX2xZS/3E/Fx6GKDQ=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=b0sPb7LP00ZipwFziNDqpNt+rqzgt3/dtf2ZSMl0QoW3ozPzPgQyFNp8DsdyCetWsEQGtvi+uNJhUpTcYOr9cVpgIWwt33VekMLt5+YfTt7ZPM8MsVzkk9tzXQWqJYGzHqCP+j5WC07b2j1z2Olw5fUNDqNqGjBcmcg/N/QDZKw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=H42KxepQ; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB93B1F000E9;
	Tue,  7 Jul 2026 07:59:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783411177;
	bh=ehG9/3eHpQcN9nUemA+0ZjW54EhsvJbW7CCAQfEU1v4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=H42KxepQVtlT0PnfhCPCaZRLZZqpKnD9F7+5qKwq34RaAqBUwc7xPjuy1HHuH5wBk
	 OXrJm/1mnRC3hbfDyaLJn7AWcLz6l3ZXtQx3UNX0BmhbIq9kjlkMfA2QaJ9zEZl8UP
	 /60YxZ73+F78Jwrn/Qjf4SfMDERr0GSZuxxL8dUS9FLI8lImFn/4mjTLZXtXxlhpSX
	 WMWU3K9yw9CT1BpOF/BaSmshCodfHfZ2wOh5e7nrEJQ7jQ64lgmsWizuvmJUo3qi1a
	 4R9J96DgVvLkQJoUb5KeOo5PC48hx7qj7jxtgNdmJkgerj8Mn/nt5XI4rStZMVYDMG
	 bV77cN7FZEW0w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 1/6] can: bcm: defer rx_op deallocation to workqueue
 to fix thrtimer UAF
Reply-To: sashiko-reviews@lists.linux.dev
To: "Oliver Hartkopp" <socketcan@hartkopp.net>
Cc: "Vincent Mailhol" <mailhol@kernel.org>, "Oliver Hartkopp" <socketcan@hartkopp.net>, linux-can@vger.kernel.org, "Oleksij
 Rempel" <o.rempel@pengutronix.de>, "Marc Kleine-Budde" <mkl@pengutronix.de>
In-Reply-To: <20260707-bcm_fixes-v2-1-96620c534b75@hartkopp.net>
References: <20260707-bcm_fixes-v2-0-96620c534b75@hartkopp.net>
 <20260707-bcm_fixes-v2-1-96620c534b75@hartkopp.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 07 Jul 2026 07:59:36 +0000
Message-Id: <20260707075936.EB93B1F000E9@smtp.kernel.org>
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
	TAGGED_FROM(0.00)[bounces-8033-lists,linux-can=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	REPLYTO_DN_EQ_FROM_DN(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sashiko.dev:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp,lists.linux.dev:replyto,smtp.kernel.org:mid];
	FORGED_SENDER(0.00)[sashiko-bot@kernel.org,linux-can@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:socketcan@hartkopp.net,m:mailhol@kernel.org,m:linux-can@vger.kernel.org,m:o.rempel@pengutronix.de,m:mkl@pengutronix.de,s:lists@lfdr.de];
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
X-Rspamd-Queue-Id: 7B4AD718F22

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Missing list_add_rcu() when inserting into tx_ops and rx_ops cause=
s RCU publish/subscribe rules violation, leading to data races and potentia=
l kernel panics with concurrent procfs readers.
- [High] Lockless updates to 64-bit ktime_t fields can cause torn reads on =
32-bit architectures, leading to wildly incorrect timer timeouts.
- [High] Unprotected concurrent modification of `op->frames` via `memcpy_fr=
om_msg` in `bcm_rx_setup` and `bcm_tx_setup`.
--

--- Patch [1]: [PATCH v2 1/6] can: bcm: defer rx_op deallocation to workque=
ue to fix thrtimer UAF ---
commit 66477b55911323fb4b8a9cc14c9ed91e1fa4bfa5
Author: Lee Jones <lee@kernel.org>

can: bcm: defer rx_op deallocation to workqueue to fix thrtimer UAF

Commit f1b4e32aca08 replaced synchronize_rcu() with call_rcu() but omitted =
a=20
flag check in the fast-path, causing a use-after-free when thrtimer fires.=
=20
This patch defers timer cancellation and memory deallocation to a dedicated=
=20
unbound workqueue to safely sleep and drop socket references.

Fixes: f1b4e32aca08 ("can: bcm: use call_rcu() instead of costly synchroniz=
e_rcu()")

> ---
> net/can/bcm.c | 37 ++++++++++++++++++++++++++++++++++---
>  1 file changed, 34 insertions(+), 3 deletions(-)
>=20
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
This is a pre-existing issue, but does the list insertion in bcm_tx_setup()=
=20
and bcm_rx_setup() use list_add() instead of list_add_rcu()?

If a local unprivileged user repeatedly adds new TX/RX operations while=20
concurrently reading /proc/net/can-bcm/<inode>, can bcm_proc_show() observe=
=20
partially initialized bcm_op entries?=20

bcm_proc_show() iterates over rx_ops using list_for_each_entry_rcu() and=20
tx_ops using list_for_each_entry() without holding the socket lock. Could=20
the missing smp_store_release() barrier in list_add() lead to torn reads of=
=20
uninitialized list pointers and potential kernel panics?

[Severity: High]
This isn't a bug introduced by this patch, but are the 64-bit ktime_t=20
fields (op->kt_ival1 and op->kt_ival2) updated locklessly in bcm_tx_setup()=
=20
and bcm_rx_setup()?

On 32-bit architectures, can these lockless updates cause torn reads when=20
bcm_tx_timeout_handler() or bcm_rx_timeout_handler() concurrently read=20
these fields in softirq context to arm the hrtimer?=20

Could this lead to wildly incorrect timer expirations, potentially stalling=
=20
CAN transmissions indefinitely or flooding the bus?

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
This is a pre-existing issue, but is it safe to write directly into the=20
active op->frames using memcpy_from_msg() without holding a lock?

When updating an existing BCM operation, bcm_tx_setup() and bcm_rx_setup()=
=20
appear to copy user data directly into op->frames locklessly. Because=20
memcpy_from_msg() can sleep on user faults, is there a significant race=20
window here?

Concurrently, bcm_can_tx() reads op->frames to transmit data, and=20
bcm_rx_cmp_to_index() reads op->frames to filter incoming packets. Could=20
this allow partially updated or torn CAN frames to be transmitted onto the=
=20
physical CAN bus?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260707-bcm_fixes-=
v2-0-96620c534b75@hartkopp.net?part=3D1

