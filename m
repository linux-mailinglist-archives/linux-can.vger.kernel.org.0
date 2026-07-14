Return-Path: <linux-can+bounces-8417-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 7kunLpAmVmp50AAAu9opvQ
	(envelope-from <linux-can+bounces-8417-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Tue, 14 Jul 2026 14:07:44 +0200
X-Original-To: lists+linux-can@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 05D2E75447A
	for <lists+linux-can@lfdr.de>; Tue, 14 Jul 2026 14:07:44 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=ZGSXsaeQ;
	spf=pass (mail.lfdr.de: domain of "linux-can+bounces-8417-lists+linux-can=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-can+bounces-8417-lists+linux-can=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 753E7328B498
	for <lists+linux-can@lfdr.de>; Tue, 14 Jul 2026 11:54:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E62B437D123;
	Tue, 14 Jul 2026 11:52:56 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88D41374169
	for <linux-can@vger.kernel.org>; Tue, 14 Jul 2026 11:52:55 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784029976; cv=none; b=BotL7Ebbow+9pV9DUhYAyYcgC0Px8GFRgKagWzx3V6vrvXhAhmhKrica/JkQEkEt3mPYzfT6ypF31vsNufLazIMd+8HNq05vtWhECTNHzAX5DPSvlOJASpsPIpnEAkJhK4e0gbaDfmq+7nTZl84nFuLpJTcmisOS/z+OxKszza0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784029976; c=relaxed/simple;
	bh=GtGtkNM1kczoWe647kwMx/Cp84+yxqX5uq18NKfdrgI=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=j7099VJxHq8gthVtuPLr4B7q3TdDK0/5JDbSvYOORPASGm35zsnH/AX78VwC0G/HR7vgKAIFuAP8rnSXkW1vgT+8nUP0MqzwhYB1kuC1gVVtHNLgLyjMYViQX+FrEYo5bpNWEQc7GjuGBXvf32ZFpbMmbyu256xzDYm7exX6rDA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZGSXsaeQ; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D9C2B1F000E9;
	Tue, 14 Jul 2026 11:52:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784029975;
	bh=9jw26uN8Pdv+ZUNwofUU3Zp+5eSMZsqEvO61ul5PDHE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ZGSXsaeQ8jQCRjYWByRjRky6JDlkKhYKbWBHyk1Yd6uHYv4rEnNvZxxC43bMG9oUT
	 8eZUDDY2t9WsXwt9qFbAq5+7Camp8Cc3r5wliGQx2AzyjlUnZXHLwIY54pKYBCE9NT
	 E1ahARe4WoVTF26ElWmDeDGtD8nK4TK2xL059Xpi0H+jzSxcmtOjEy3xIn0G3qPUjc
	 SPQ285fw64/jJN0me4k4Gzrx+UnYUe4Bhla5npLeUNC+Vn0sau6XpUsq6Df+0En5sr
	 Olw7ft3OF0nCe6AF9qbCLKbYvp84FpuVlSr1QePaVfyLSrZk080VM954b2Mq4KEUky
	 /I8bZsam4Tkjw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v14 03/11] can: bcm: add locking when updating filter
 and timer values
Reply-To: sashiko-reviews@lists.linux.dev
To: "Oliver Hartkopp" <socketcan@hartkopp.net>
Cc: "Marc Kleine-Budde" <mkl@pengutronix.de>, "Oliver Hartkopp" <socketcan@hartkopp.net>, linux-can@vger.kernel.org, "Vincent
 Mailhol" <mailhol@kernel.org>, "Oleksij Rempel" <o.rempel@pengutronix.de>
In-Reply-To: <20260714-bcm_fixes-v14-3-867a4be60a61@hartkopp.net>
References: <20260714-bcm_fixes-v14-0-867a4be60a61@hartkopp.net>
 <20260714-bcm_fixes-v14-3-867a4be60a61@hartkopp.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 14 Jul 2026 11:52:54 +0000
Message-Id: <20260714115254.D9C2B1F000E9@smtp.kernel.org>
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
	TAGGED_FROM(0.00)[bounces-8417-lists,linux-can=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	REPLYTO_DN_EQ_FROM_DN(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,sashiko.dev:url,vger.kernel.org:from_smtp,hartkopp.net:email,lists.linux.dev:replyto];
	FORGED_SENDER(0.00)[sashiko-bot@kernel.org,linux-can@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:socketcan@hartkopp.net,m:mkl@pengutronix.de,m:linux-can@vger.kernel.org,m:mailhol@kernel.org,m:o.rempel@pengutronix.de,s:lists@lfdr.de];
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
X-Rspamd-Queue-Id: 05D2E75447A

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:

New issues:
- [Medium] Split critical sections in `bcm_rx_setup()` create a window of i=
nconsistent state.

Pre-existing issues:
- [High] Lockless reads and writes of timer values and flags in TX path cau=
se a data race and potential torn reads.
- [High] Direct, lockless modification of `op->frames` array in `bcm_tx_set=
up()` leads to data races and unrecoverable state corruption.
- [High] Use of `list_add()` instead of `list_add_rcu()` causes data races =
with lockless RCU readers.
--

--- Patch [3]: [PATCH v14 03/11] can: bcm: add locking when updating filter=
 and timer values ---
commit b803c079b36024599ab905728a0b29f52d124d0c
Author: Oliver Hartkopp <socketcan@hartkopp.net>

can: bcm: add locking when updating filter and timer values

This commit introduces bcm_rx_update_lock to protect timer and filter data
updates in bcm_rx_setup() and various RX handlers. It also adds read-side
locking in bcm_can_tx() and normalizes RTR frames in a staging buffer
before registering them.

Link: https://lore.kernel.org/linux-can/6975d5cf.a00a0220.33ccc7.0022.GAE@g=
oogle.com/

> diff --git a/net/can/bcm.c b/net/can/bcm.c
> index b612135b017d1..af4bb4182bc29 100644
> --- a/net/can/bcm.c
> +++ b/net/can/bcm.c
> @@ -293,22 +294,26 @@ static int bcm_proc_show(struct seq_file *m, void *=
v)
>   * bcm_can_tx - send the (next) CAN frame to the appropriate CAN interfa=
ce
>   *              of the given bcm tx op
>   */
> -static void bcm_can_tx(struct bcm_op *op)
> +static void bcm_can_tx(struct bcm_op *op, struct canfd_frame *cf)
>  {
>  	struct sk_buff *skb;
>  	struct can_skb_ext *csx;
>  	struct net_device *dev;
> -	struct canfd_frame *cf;
> +	struct canfd_frame cframe;
>  	int err;
> =20
>  	/* no target device? =3D> exit */
>  	if (!op->ifindex)
>  		return;
> =20
> -	/* read currframe under lock protection */
> -	spin_lock_bh(&op->bcm_tx_lock);
> -	cf =3D op->frames + op->cfsiz * op->currframe;
> -	spin_unlock_bh(&op->bcm_tx_lock);
> +	if (!cf) {
> +		/* read currframe under lock protection */
> +		spin_lock_bh(&op->bcm_tx_lock);
> +		memcpy(&cframe, op->frames + op->cfsiz * op->currframe,
> +		       op->cfsiz);
> +		cf =3D &cframe;
> +		spin_unlock_bh(&op->bcm_tx_lock);
> +	}

[Severity: High]
This is a pre-existing issue, but does this read-side lock actually protect
against concurrent updates?

While bcm_can_tx() acquires bcm_tx_lock here, the writer in bcm_tx_setup()
directly modifies the op->frames array without holding the lock and without
using a staging buffer:

bcm_tx_setup() {
    ...
    for (i =3D 0; i < msg_head->nframes; i++) {
        cf =3D op->frames + op->cfsiz * i;
        err =3D memcpy_from_msg((u8 *)cf, msg, op->cfsiz);
    ...
}

Because memcpy_from_msg() can sleep, it cannot be called under a spinlock.
Could this lead to bcm_can_tx() copying partially overwritten CAN frames, or
unrecoverable state corruption if memcpy_from_msg() fails midway?

[ ... ]

> @@ -461,7 +466,7 @@ static enum hrtimer_restart bcm_tx_timeout_handler(st=
ruct hrtimer *hrtimer)
>  	struct bcm_msg_head msg_head;
> =20
>  	if (op->kt_ival1 && (op->count > 0)) {
> -		bcm_can_tx(op);
> +		bcm_can_tx(op, NULL);

[Severity: High]
This is a pre-existing issue, but can this result in torn reads on 32-bit
platforms?

The bcm_tx_timeout_handler() reads kt_ival1, count, and flags locklessly
here. Concurrently, a user calling sendmsg() with TX_SETUP can trigger
bcm_tx_setup() to write new timer values locklessly:

bcm_tx_setup() {
    ...
    if (op->flags & SETTIMER) {
        op->ival1 =3D msg_head->ival1;
        op->ival2 =3D msg_head->ival2;
        op->kt_ival1 =3D bcm_timeval_to_ktime(msg_head->ival1);
        op->kt_ival2 =3D bcm_timeval_to_ktime(msg_head->ival2);
    }
    ...
}

Does this data race risk unpredictable timer expiration or spurious CAN
transmissions if inconsistent combinations of flags and counts are observed?

[ ... ]

> @@ -1175,19 +1230,40 @@ static int bcm_rx_setup(struct bcm_msg_head *msg_=
head, struct msghdr *msg,
>  			return -E2BIG;
> =20
>  		if (msg_head->nframes) {
> -			/* update CAN frames content */
> -			err =3D memcpy_from_msg(op->frames, msg,
> +			/* get new CAN frames content before locking */
> +			new_frames =3D kmalloc(msg_head->nframes * op->cfsiz,
> +					     GFP_KERNEL);
> +			if (!new_frames)
> +				return -ENOMEM;
> +
> +			err =3D memcpy_from_msg(new_frames, msg,
>  					      msg_head->nframes * op->cfsiz);
> -			if (err < 0)
> +			if (err < 0) {
> +				kfree(new_frames);
>  				return err;
> +			}
> =20
> -			/* clear last_frames to indicate 'nothing received' */
> -			memset(op->last_frames, 0, msg_head->nframes * op->cfsiz);
> +			bcm_rx_setup_rtr_check(msg_head, op, new_frames);
>  		}
> =20
> +		spin_lock_bh(&op->bcm_rx_update_lock);
>  		op->nframes =3D msg_head->nframes;
>  		op->flags =3D msg_head->flags;
> =20
> +		if (msg_head->nframes) {
> +			/* update CAN frames content */
> +			memcpy(op->frames, new_frames,
> +			       msg_head->nframes * op->cfsiz);
> +
> +			/* clear last_frames to indicate 'nothing received' */
> +			memset(op->last_frames, 0,
> +			       msg_head->nframes * op->cfsiz);
> +		}
> +		spin_unlock_bh(&op->bcm_rx_update_lock);

[ ... ]

> @@ -1266,29 +1345,20 @@ static int bcm_rx_setup(struct bcm_msg_head *msg_=
head, struct msghdr *msg,
>  	/* check flags */
> =20
>  	if (op->flags & RX_RTR_FRAME) {
> -		struct canfd_frame *frame0 =3D op->frames;
> -
>  		/* no timers in RTR-mode */
>  		hrtimer_cancel(&op->thrtimer);
>  		hrtimer_cancel(&op->timer);
> -
> -		/*
> -		 * funny feature in RX(!)_SETUP only for RTR-mode:
> -		 * copy can_id into frame BUT without RTR-flag to
> -		 * prevent a full-load-loopback-test ... ;-]
> -		 */
> -		if ((op->flags & TX_CP_CAN_ID) ||
> -		    (frame0->can_id =3D=3D op->can_id))
> -			frame0->can_id =3D op->can_id & ~CAN_RTR_FLAG;
> -
>  	} else {
>  		if (op->flags & SETTIMER) {
> =20
>  			/* set timer value */
> +			spin_lock_bh(&op->bcm_rx_update_lock);
>  			op->ival1 =3D msg_head->ival1;
>  			op->ival2 =3D msg_head->ival2;

[Severity: Medium]
Could a concurrent bcm_rx_handler() process a frame during the gap between
these two critical sections?

In bcm_rx_setup(), the lock is acquired to update flags and frames, then
dropped, and re-acquired here to update the timer values. Does this create
a window where bcm_rx_handler() might see the new flags and frames alongside
stale kt_ival1 and kt_ival2 timer values, resulting in incorrect throttling
behavior?

[Severity: High]
This is a pre-existing issue, but does publishing operations without RCU
primitives cause data races with lockless readers?

In bcm_tx_setup() and bcm_rx_setup(), operations are published to the lists
using list_add() rather than list_add_rcu():

bcm_tx_setup() {
    ...
    list_add(&op->list, &bo->tx_ops);
    ...
}

However, readers like bcm_proc_show() traverse the list locklessly:

bcm_proc_show() {
    ...
    list_for_each_entry(op, &bo->tx_ops, list) {
    ...
}

Since list_add() lacks the smp_store_release() barrier provided by
list_add_rcu(), can lockless readers observe uninitialized memory if they
reach a newly linked node before its contents are globally visible?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260714-bcm_fixes-=
v14-0-867a4be60a61@hartkopp.net?part=3D3

