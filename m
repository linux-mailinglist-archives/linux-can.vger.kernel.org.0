Return-Path: <linux-can+bounces-8163-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 6F4VFZCMTmrqPAIAu9opvQ
	(envelope-from <linux-can+bounces-8163-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Wed, 08 Jul 2026 19:44:48 +0200
X-Original-To: lists+linux-can@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D403E7294F8
	for <lists+linux-can@lfdr.de>; Wed, 08 Jul 2026 19:44:47 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=BRLG4xjo;
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	spf=pass (mail.lfdr.de: domain of "linux-can+bounces-8163-lists+linux-can=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-can+bounces-8163-lists+linux-can=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2C8B9300D96E
	for <lists+linux-can@lfdr.de>; Wed,  8 Jul 2026 17:44:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63C522C2360;
	Wed,  8 Jul 2026 17:44:05 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17551242D9D
	for <linux-can@vger.kernel.org>; Wed,  8 Jul 2026 17:44:04 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783532645; cv=none; b=SMe6lHJdIWPLy9q641H8WS76/pmE8acDjmgOIfwz5OxUBWMleLkrdEA2oI/tm2VQfM0DAl8bMloAgjzxjcc7DYHelNVAufDpvNMU9LwLAdBNWzSsFBRZTRUz/jJ9IC79Sx6lfE3uW84tSd0+7W0mcmM07o7TyAM3PPn1V4/ZHTA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783532645; c=relaxed/simple;
	bh=MdhXFfjpQjLCFWAkzLJvGP18a854nC5XLd3PRQLti+U=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=fWrSgXhvETm0N2eiGfuA16zrVqjC4PVs8BcYUtnHdpm9INNMgWC24uDydp0nCXluujUEBaruM11OsFxBLAR8bVITPkmqeckq7RU3ja+aQtvzFp1+M9cLiJVYv2uFPX3T6eFCo5fRSTLjGtcLOrOf6lxOn41mBtHvPfz8ZgYysQ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BRLG4xjo; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C4C91F000E9;
	Wed,  8 Jul 2026 17:44:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783532644;
	bh=08pQBxT/Lwhi8ZsZ7hg42Q/p90DufggIhIaeKrQxM8Q=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=BRLG4xjoDPXq8AEhIrL0QbkhC8qx4weEWVlE8z2QbM7ZMRc5W0YekJcewUotu/q1L
	 tE18/RrnXQ6bDKAqcdksfvzm0wutr4q913B13qnuQQ25lre/e9V/fQcaDUvteYAM5l
	 MA+hWpb2ohmpmrhs/xOwv2kTGwjsbd7z3kun0LlGzMXuZJENFMFuIvpkKEYj0ctzxn
	 PUrVFC2QwUGRnoGaW050x3d2A/SbWZdTFhw4GL/mb5mYA9XAprJyJrkuB1vPCnttvL
	 DoSA3vDa409NXwuC9uQIhrjfn9hCyxrWrf7uXgVaqSMeBbYEFBg8T7IHQvIu4I5o6s
	 RSdy9StKqPJUg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v8 03/10] can: bcm: add locking when updating filter and
 timer values
Reply-To: sashiko-reviews@lists.linux.dev
To: "Oliver Hartkopp" <socketcan@hartkopp.net>
Cc: "Vincent Mailhol" <mailhol@kernel.org>, linux-can@vger.kernel.org, "Marc
 Kleine-Budde" <mkl@pengutronix.de>, "Oliver Hartkopp" <socketcan@hartkopp.net>, "Oleksij
 Rempel" <o.rempel@pengutronix.de>
In-Reply-To: <20260708-bcm_fixes-v8-3-8c2f5f3bc212@hartkopp.net>
References: <20260708-bcm_fixes-v8-0-8c2f5f3bc212@hartkopp.net>
 <20260708-bcm_fixes-v8-3-8c2f5f3bc212@hartkopp.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 08 Jul 2026 17:44:03 +0000
Message-Id: <20260708174403.9C4C91F000E9@smtp.kernel.org>
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
	TAGGED_FROM(0.00)[bounces-8163-lists,linux-can=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	REPLYTO_DN_EQ_FROM_DN(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,lists.linux.dev:replyto,smtp.kernel.org:mid,sashiko.dev:url,vger.kernel.org:from_smtp,hartkopp.net:email];
	FORGED_SENDER(0.00)[sashiko-bot@kernel.org,linux-can@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:socketcan@hartkopp.net,m:mailhol@kernel.org,m:linux-can@vger.kernel.org,m:mkl@pengutronix.de,m:o.rempel@pengutronix.de,s:lists@lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	HAS_REPLYTO(0.00)[sashiko-reviews@lists.linux.dev];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_NO_DN(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: D403E7294F8

Thank you for your contribution! Sashiko AI review found 6 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Torn read data races on timer values in the TX path.
- [High] The lock added in bcm_can_tx() is ineffective against torn reads b=
ecause the writer (bcm_tx_setup) does not hold the lock.
- [High] Timer armed on freed bcm_op due to race between bcm_rx_handler and=
 bcm_delete_rx_op.
- [High] Missing list_add_rcu() for BCM operations accessed locklessly via =
RCU.
- [High] Unsafe lockless traversal of tx_ops list in procfs handler.
- [Medium] op->rx_stamp, op->rx_ifindex, and op->frames_abs are updated loc=
klessly in bcm_rx_handler().
--

--- Patch [3]: [PATCH v8 03/10] can: bcm: add locking when updating filter =
and timer values ---
commit ae43444642bccb605ce6673ee360da9626ce6a3b
Author: Oliver Hartkopp <socketcan@hartkopp.net>

can: bcm: add locking when updating filter and timer values

This commit adds a new bcm_rx_update_lock to protect timer and filter data
updates in bcm_rx_setup() against concurrent execution of RX handlers.
It also modifies the transmit paths and timer handlers to attempt to close
several synchronization races.

Link: https://lore.kernel.org/linux-can/6975d5cf.a00a0220.33ccc7.0022.GAE@g=
oogle.com/

> diff --git a/net/can/bcm.c b/net/can/bcm.c
> index b612135b017d1..af4bb4182bc29 100644
> --- a/net/can/bcm.c
> +++ b/net/can/bcm.c
[ ... ]
> -static void bcm_can_tx(struct bcm_op *op)
> +static void bcm_can_tx(struct bcm_op *op, struct canfd_frame *cf)
>  {
>  	struct sk_buff *skb;
[ ... ]
> +	if (!cf) {
> +		/* read currframe under lock protection */
> +		spin_lock_bh(&op->bcm_tx_lock);
> +		memcpy(&cframe, op->frames + op->cfsiz * op->currframe,
> +		       op->cfsiz);
> +		cf =3D &cframe;
> +		spin_unlock_bh(&op->bcm_tx_lock);
> +	}

[Severity: High]
This isn't a bug introduced by this patch, but is this lock effective
against torn reads here?

The writer in bcm_tx_setup() modifies op->frames locklessly via
memcpy_from_msg():

bcm_tx_setup()
    err =3D memcpy_from_msg((u8 *)cf, msg, op->cfsiz);

Since the writer mutates the buffer without holding bcm_tx_lock, does the
reader's lock in bcm_can_tx() prevent a concurrently firing timer callback
from reading and transmitting a corrupted, partially-overwritten CAN frame?

[ ... ]
> @@ -461,7 +466,7 @@ static enum hrtimer_restart bcm_tx_timeout_handler(st=
ruct hrtimer *hrtimer)
>  	struct bcm_msg_head msg_head;
> =20
>  	if (op->kt_ival1 && (op->count > 0)) {
> -		bcm_can_tx(op);
> +		bcm_can_tx(op, NULL);

[Severity: High]
This is a pre-existing issue, but can we experience torn reads on these
timer values?

In bcm_tx_setup(), the timer fields are updated locklessly:

bcm_tx_setup()
    op->kt_ival1 =3D bcm_timeval_to_ktime(msg_head->ival1);
    op->kt_ival2 =3D bcm_timeval_to_ktime(msg_head->ival2);

Concurrently, bcm_tx_timeout_handler() and bcm_tx_set_expiry() read these
fields locklessly.

On 32-bit systems, reading or writing a 64-bit ktime_t is not atomic.
Could a torn read (where half of the old ktime and half of the new one
are read) result in a corrupted timer expiration time being programmed?

[ ... ]
> @@ -729,9 +751,18 @@ static void bcm_rx_handler(struct sk_buff *skb, void=
 *data)
>  	/* update statistics */
>  	op->frames_abs++;
> =20
> -	if (op->flags & RX_RTR_FRAME) {
> +	/* snapshot the flag under lock: op->flags/op->frames may be updated
> +	 * concurrently by bcm_rx_setup().
> +	 */
> +	spin_lock_bh(&op->bcm_rx_update_lock);

[Severity: Medium]
This isn't a bug introduced by this patch, but does the lockless update of
metadata before taking bcm_rx_update_lock cause mismatched data?

Right before this snippet, bcm_rx_handler() updates metadata locklessly:

bcm_rx_handler()
    op->rx_stamp =3D skb->tstamp;
    op->rx_ifindex =3D skb->dev->ifindex;
    op->frames_abs++;

For a socket bound to all interfaces (ifindex =3D=3D 0), bcm_rx_handler() c=
an
execute concurrently on multiple CPUs for the same bcm_op.

Since bcm_send_to_user() reads these values inside the lock, could it bundle
a CAN frame from one CPU with the timestamp or ifindex metadata from anothe=
r?

[ ... ]
> @@ -778,6 +811,8 @@ static void bcm_rx_handler(struct sk_buff *skb, void =
*data)
> =20
>  rx_starttimer:
>  	bcm_rx_starttimer(op);
> +
> +	spin_unlock_bh(&op->bcm_rx_update_lock);
>  }

[Severity: High]
This is a pre-existing issue, but can this arm the timer on a freed object?

The teardown path in bcm_delete_rx_op() sets the flag locklessly and
cancels the timer:

bcm_delete_rx_op()
    op->flags |=3D RX_NO_AUTOTIMER;
    ...
    hrtimer_cancel(&op->timer);

Since bcm_delete_rx_op() doesn't take bcm_rx_update_lock, it can cancel
the timer before the handler arms it.

If bcm_rx_handler() reads op->flags before it is set, and then reaches
bcm_rx_starttimer(), could it start the timer on an object that will be
freed after the RCU grace period, causing a use-after-free?

[ ... ]
> @@ -1116,7 +1151,7 @@ static int bcm_tx_setup(struct bcm_msg_head *msg_he=
ad, struct msghdr *msg,
>  	}
> =20
>  	if (op->flags & TX_ANNOUNCE)
> -		bcm_can_tx(op);
> +		bcm_can_tx(op, NULL);

[Severity: High]
This is a pre-existing issue, but is the lockless traversal of tx_ops safe?

bcm_tx_setup() adds operations to the list using list_add():

bcm_tx_setup()
    list_add(&op->list, &bo->tx_ops);

However, bcm_proc_show() iterates this list locklessly using the non-RCU
macro list_for_each_entry() while holding only rcu_read_lock().

Since the procfs reader does not use the proper RCU primitives for tx_ops,
could it follow corrupted pointers if the list is modified concurrently?

[ ... ]
> @@ -1164,6 +1217,8 @@ static int bcm_rx_setup(struct bcm_msg_head *msg_he=
ad, struct msghdr *msg,
>  	/* check the given can_id */
>  	op =3D bcm_find_op(&bo->rx_ops, msg_head, ifindex);
>  	if (op) {
> +		void *new_frames =3D NULL;
> +

[Severity: High]
This is a pre-existing issue, but does rx_ops require list_add_rcu()?

Later in bcm_rx_setup(), it inserts the struct into the rx_ops list without
RCU memory barriers:

bcm_rx_setup()
    list_add(&op->list, &bo->rx_ops);

Meanwhile, bcm_proc_show() iterates the list expecting RCU protection:

bcm_proc_show()
    list_for_each_entry_rcu(op, &bo->rx_ops, list) { ... }

Because list_add() lacks the smp_store_release() semantics of
list_add_rcu(), could an RCU reader observe the new list node before its
memory contents are fully visible across cores?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260708-bcm_fixes-=
v8-0-8c2f5f3bc212@hartkopp.net?part=3D3

