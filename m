Return-Path: <linux-can+bounces-7835-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 1LOlDb3zK2rBIQQAu9opvQ
	(envelope-from <linux-can+bounces-7835-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Fri, 12 Jun 2026 13:55:41 +0200
X-Original-To: lists+linux-can@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 886B2679254
	for <lists+linux-can@lfdr.de>; Fri, 12 Jun 2026 13:55:40 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=Ya2U5x3j;
	spf=pass (mail.lfdr.de: domain of "linux-can+bounces-7835-lists+linux-can=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-can+bounces-7835-lists+linux-can=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2601A31D2791
	for <lists+linux-can@lfdr.de>; Fri, 12 Jun 2026 11:51:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2CBD37EFEF;
	Fri, 12 Jun 2026 11:51:02 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 847523E8665
	for <linux-can@vger.kernel.org>; Fri, 12 Jun 2026 11:51:01 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781265062; cv=none; b=Kj+wcjAJ4XEYP0PAel0CO52ALBUi7cDFDY6SRE8wXL2BPY9QXMtJ2rl1vPAkY/gnl5ckOL2DYVQtPbZ7H+/pjGSS7XEe2KpqTt4GHhDRg02jKdxILAOH656D1YJIlfSurL2Dr6jF4+N+zCZgRwAzGVGye3F21uKvManAKs2lgig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781265062; c=relaxed/simple;
	bh=z45Z7MlX5EXy86eYYrgXjYudDAXo+/ZmTgBwWOAEieY=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=KHT7QhXP8HxrEXSGy9P+CH4dV/83WEK1/vjsFSE63ACPYK1GzTtauT4EWj7Lmjr7bVaKibKkH45TeqCzc05SwFmBhC3QWSxnO7W+47jYEGVypvgevSPYR1R+T20Y1YzESvGwkb3ZaAtp2SVsNFTD5pw1sFCLc36TvZOL8KZ6XZ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ya2U5x3j; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 002B81F000E9;
	Fri, 12 Jun 2026 11:51:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781265061;
	bh=vcn1Ru+TqbObMPrYPoRrB4NuNQoUunhhAE/g0lSCg7U=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Ya2U5x3j+XlMBl6O9Fq6mPZ8oriSSG5CALgzaVsFuOWhCybtub2qS/olFByowxf9L
	 GlKynFfBhNxprU+YGCUtlzUbPk0EPRgGoh5bb9wZYGgGuEuJq5da2Tjo0zd0TxygSl
	 SyDlrKJ9gXQqM6W4PzAylNWO0VN4dLDjWpK1dQ2Sv2pQOo0UEvag2YPK2s6yAtVGHv
	 RQh7azx0JC1ifZcoplz6mxM3BgI+DT60eNiF0pmEM3WfxlE5bEVenJaxgO1EMqnFFJ
	 buldUdpSPoKn0J7GQSktk5ZAIFqKWchgKg5u0UmGAwE4QvklndxuFj+RzNYkmVncCD
	 K1Ej5ARo/CGCQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 5/5] can: bcm: use list_add_rcu() in bcm_[rx|tx]_setup()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Oliver Hartkopp" <socketcan@hartkopp.net>
Cc: "Marc Kleine-Budde" <mkl@pengutronix.de>, linux-can@vger.kernel.org, "Oleksij
 Rempel" <o.rempel@pengutronix.de>, "Vincent Mailhol" <mailhol@kernel.org>
In-Reply-To: <20260612-bcm_fixes-v1-5-ca2fa07ee70f@hartkopp.net>
References: <20260612-bcm_fixes-v1-5-ca2fa07ee70f@hartkopp.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 12 Jun 2026 11:51:00 +0000
Message-Id: <20260612115101.002B81F000E9@smtp.kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-7835-lists,linux-can=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	REPLYTO_DN_EQ_FROM_DN(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sashiko.dev:url,vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,smtp.kernel.org:mid,hartkopp.net:email,lists.linux.dev:replyto];
	FORGED_SENDER(0.00)[sashiko-bot@kernel.org,linux-can@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:socketcan@hartkopp.net,m:mkl@pengutronix.de,m:linux-can@vger.kernel.org,m:o.rempel@pengutronix.de,m:mailhol@kernel.org,s:lists@lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_NO_DN(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	HAS_REPLYTO(0.00)[sashiko-reviews@lists.linux.dev]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 886B2679254

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:

Pre-existing issues:
- [Critical] Lockless update of `op->frames` in `bcm_tx_setup()` creates a =
TOCTOU race allowing transmission of unvalidated CAN frames, leading to Out=
-of-Bounds reads in CAN drivers.
- [Critical] Complete lack of frame length validation in `bcm_rx_setup()` a=
llows Out-of-Bounds reads when responding to RTR frames.
- [High] Lockless updates to 64-bit ktime_t timer variables in `bcm_tx_setu=
p()` lead to torn reads and soft lockups on 32-bit platforms.
- [High] Objects are passed to call_rcu() while still linked in the RCU-pro=
tected tx_ops and rx_ops lists during socket release.
--

commit 0171fb1b05b0628e97f895bb66387fd0bd7335bb
Author: Oliver Hartkopp <socketcan@hartkopp.net>

can: bcm: use list_add_rcu() in bcm_[rx|tx]_setup()

sashiko-bot remarked the missing use of list_add_rcu() in
bcm_[rx|tx]_setup() to have a proper initialized bcm_op structure
when bcm_proc_show() traverses the bcm_op's under rcu_read_lock().

Link: https://lore.kernel.org/linux-can/20260610094654.A1FFE1F00893@smtp.ke=
rnel.org/

> diff --git a/net/can/bcm.c b/net/can/bcm.c
> index f1f1f11d1f92a..6a1d52189c0ab 100644
> --- a/net/can/bcm.c
> +++ b/net/can/bcm.c

[ ... ]

> @@ -1111,8 +1112,7 @@ static int bcm_tx_setup(struct bcm_msg_head *msg_he=
ad, struct msghdr *msg,
>  		hrtimer_setup(&op->thrtimer, hrtimer_dummy_timeout, CLOCK_MONOTONIC,
>  			      HRTIMER_MODE_REL_SOFT);
> =20
> -		/* add this bcm_op to the list of the tx_ops */
> -		list_add(&op->list, &bo->tx_ops);
> +		add_op_to_list =3D true;
> =20
>  	} /* if ((op =3D bcm_find_op(&bo->tx_ops, msg_head->can_id, ifindex))) =
*/

[Severity: Critical]
This is a pre-existing issue, but does this lockless update of op->frames
create a race condition?

In bcm_tx_setup(), user data is copied directly into the active array:

err =3D memcpy_from_msg((u8 *)cf, msg, op->cfsiz);

The validation (cf->len > 64 or > 8) happens after this copy without
holding op->bcm_tx_lock or disabling the active timer.

Could bcm_tx_timeout_handler() fire during this window, causing
bcm_can_tx() to read and transmit a partially updated or unvalidated
frame? If an attacker supplies an iovec that faults immediately after
the length byte is copied, leaving a malicious length (like 255), does
this cause an out-of-bounds read in the CAN driver when the timer
transmits the frame?

[Severity: High]
This is a pre-existing issue, but do the lockless updates to 64-bit timer
variables lead to torn reads on 32-bit platforms?

In bcm_tx_setup(), op->kt_ival1 and op->kt_ival2 are updated based on
user input without holding op->bcm_tx_lock or disabling softirqs.

Since bcm_tx_timeout_handler() reads these variables in softirq context:

if (op->kt_ival1 && (op->count > 0)) {
    ...
} else if (op->kt_ival2) {

Could a softirq interrupting the update read a torn ktime_t value (a mix
of old and new 32-bit halves) on 32-bit systems? Would passing this
garbage value to hrtimer_set_expires() result in the timer firing
continuously or hanging indefinitely?

> @@ -1134,6 +1134,10 @@ static int bcm_tx_setup(struct bcm_msg_head *msg_h=
ead, struct msghdr *msg,
>  		op->flags |=3D TX_ANNOUNCE;
>  	}
> =20
> +	/* add this bcm_op to the list of the tx_ops? */
> +	if (add_op_to_list)
> +		list_add_rcu(&op->list, &bo->tx_ops);
> +

[Severity: High]
This is a pre-existing issue, but does the teardown loop in bcm_release()
pass objects to call_rcu() while they are still linked in the RCU-protected
lists?

While this patch correctly updates list_add_rcu() for bo->tx_ops and
bo->rx_ops, bcm_release() iterates over these lists with
list_for_each_entry_safe() and calls bcm_remove_op().

Since bcm_remove_op() immediately calls call_rcu(&op->rcu, bcm_free_op_rcu),
the elements are never unlinked using list_del_rcu() before the call_rcu()
invocation.

Does leaving these objects physically linked in the RCU-protected list
violate the remove-before-reclaim ordering rule, potentially allowing
new readers to find the object after the grace period begins?

[ ... ]

> @@ -1376,10 +1377,12 @@ static int bcm_rx_setup(struct bcm_msg_head *msg_=
head, struct msghdr *msg,
>  					      bcm_rx_handler, op, "bcm", sk);
>  		if (err) {
>  			/* this bcm rx op is broken -> remove it */
> -			list_del_rcu(&op->list);
>  			bcm_remove_op(op);
>  			return err;
>  		}
> +
> +		/* add this bcm_op to the list of the rx_ops */
> +		list_add_rcu(&op->list, &bo->rx_ops);
>  	}

[Severity: Critical]
This is a pre-existing issue, but does the lack of frame length validation
in bcm_rx_setup() allow out-of-bounds reads during RTR replies?

When CAN frames are copied from user-space into op->frames via
memcpy_from_msg() in bcm_rx_setup(), the length field is never validated.

If the user configures the RX operation with the RX_RTR_FRAME flag,
bcm_rx_handler() automatically replies to incoming RTR packets:

if (op->flags & RX_RTR_FRAME) {
    if (rx_ext->skb->sk !=3D op->sk)
        bcm_can_tx(op);
    return;
}

Could an attacker set an arbitrary length (e.g., 255) for
op->frames[0].len, causing bcm_can_tx() to send an unvalidated frame
and trigger an out-of-bounds heap read in the driver?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260612-bcm_fixes-=
v1-0-ca2fa07ee70f@hartkopp.net?part=3D5

