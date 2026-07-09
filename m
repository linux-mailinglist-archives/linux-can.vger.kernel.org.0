Return-Path: <linux-can+bounces-8201-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id VIZ1OlZ+T2p4iAIAu9opvQ
	(envelope-from <linux-can+bounces-8201-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Thu, 09 Jul 2026 12:56:22 +0200
X-Original-To: lists+linux-can@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C88872FF1F
	for <lists+linux-can@lfdr.de>; Thu, 09 Jul 2026 12:56:22 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=Qn0bDHtK;
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	spf=pass (mail.lfdr.de: domain of "linux-can+bounces-8201-lists+linux-can=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="linux-can+bounces-8201-lists+linux-can=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 6BCE43072079
	for <lists+linux-can@lfdr.de>; Thu,  9 Jul 2026 10:52:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FE5C403EB2;
	Thu,  9 Jul 2026 10:52:49 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23D5E40B37F
	for <linux-can@vger.kernel.org>; Thu,  9 Jul 2026 10:52:45 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783594369; cv=none; b=mnESszPuCtnebiKKlrHUbiXCoP1R9okM/4TfIVA1+xkJNeuZVKcQcTMQ20p5rs+d7xAxOJ3aFG4g7lyebbc4fHyKrVEDQmeRA2HFFvpstOZYTUYiLqrCwnrA/yeRkjt7ZE1yNxW6XPuUCP+6XN3hLs+VutuAPb9mI5OoZoKNDJw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783594369; c=relaxed/simple;
	bh=4TG+zyJKmh2hYTSD3B+XF4GXxE40wUZ39y3kqUOYoWY=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=puETKWCH2VKewHB05c4JEhbikLX1b0ynMsXfutgXKflwUGgRequJzAPEPZhWbDtCFONuk/YkgBdx+FjooA6XpVO3Gi3JZCJvJi01xY8Bz+1sdfXsVUKvbIWjnpn7KT24hBerhP+za1r3Dbdvm8ERIokV2syFKiRWiOUfu2lh5/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Qn0bDHtK; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C2CE71F000E9;
	Thu,  9 Jul 2026 10:52:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783594365;
	bh=Cns17xL+wVhSFmFCrCIFMLh9OazyAlOVOXknwv8qSMU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Qn0bDHtKNp08O0Aey3YDnLX6ishR764pqhZt3UJew2F5zzQxp8i2/ef9O7Q9Z6xgG
	 OTXtR4dj1cQ45IuJiuVnrBg0wM/zVBvyOHZQXMeTcBJGkLi2gNlZlAIRXv7ArZxcwd
	 0oVOpmPPcmGNFYYuMxSK7vqVkLj4SG75MeJJeEwIK1KomrUt9ta5OzhNp4kq49E+PB
	 kQ+H5eBp52y+wYUv/fJosZaaOs+F4g+3F/7Q7SoJUQxDkZeplCLfR0aC1RksGYjU8m
	 jgaqspXLKgl/qOQujKxF7QTiyBWsJs3opTdr/FFVli9lAzxNjLPWajsQ4P4HSMRKrv
	 VjZVIHi+dX/DA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v10 03/10] can: bcm: add locking when updating filter
 and timer values
Reply-To: sashiko-reviews@lists.linux.dev
To: "Oliver Hartkopp" <socketcan@hartkopp.net>
Cc: linux-can@vger.kernel.org, "Oleksij Rempel" <o.rempel@pengutronix.de>, "Oliver
 Hartkopp" <socketcan@hartkopp.net>, "Vincent Mailhol" <mailhol@kernel.org>, "Marc
 Kleine-Budde" <mkl@pengutronix.de>
In-Reply-To: <20260709-bcm_fixes-v10-3-57fff38e34ce@hartkopp.net>
References: <20260709-bcm_fixes-v10-0-57fff38e34ce@hartkopp.net>
 <20260709-bcm_fixes-v10-3-57fff38e34ce@hartkopp.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 09 Jul 2026 10:52:44 +0000
Message-Id: <20260709105244.C2CE71F000E9@smtp.kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-8201-lists,linux-can=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	REPLYTO_DN_EQ_FROM_DN(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sashiko.dev:url,hartkopp.net:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,lists.linux.dev:replyto,vger.kernel.org:from_smtp,smtp.kernel.org:mid];
	FORGED_SENDER(0.00)[sashiko-bot@kernel.org,linux-can@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:socketcan@hartkopp.net,m:linux-can@vger.kernel.org,m:o.rempel@pengutronix.de,m:mailhol@kernel.org,m:mkl@pengutronix.de,s:lists@lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_NO_DN(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	HAS_REPLYTO(0.00)[sashiko-reviews@lists.linux.dev]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 4C88872FF1F

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Lockless `memcpy_from_msg()` in `bcm_tx_setup()` defeats the `bcm_=
can_tx()` lock-protected snapshot, leading to torn CAN frames and potential=
ly transmitting unvalidated malicious lengths.
- [High] Missing frame payload length validation for `RX_RTR_FRAME` operati=
ons in `bcm_rx_setup()`, leading to downstream out-of-bounds reads during a=
utomated RTR replies.
- [Medium] Metadata `rx_stamp`, `rx_ifindex`, and `frames_abs` are updated =
outside the newly introduced `bcm_rx_update_lock` in `bcm_rx_handler()`, le=
ading to torn metadata for concurrent packet receptions.
- [Medium] Timer fields and counters (`kt_ival1`, `kt_ival2`, `count`) are =
read without locking in `bcm_tx_timeout_handler()`, leading to potential lo=
gic flaws and torn reads.
--

--- Patch [3]: [PATCH v10 03/10] can: bcm: add locking when updating filter=
 and timer values ---
commit 3f8b487ac0338cf76d904d74f58ed7c66c12d1fb
Author: Oliver Hartkopp <socketcan@hartkopp.net>

can: bcm: add locking when updating filter and timer values

This patch adds a new per-op bcm_rx_update_lock to protect timer and filter
updates in bcm_rx_setup() against concurrent access from RX handlers. It
also stages memcpy_from_msg() into a temporary buffer to avoid sleeping
while holding a spinlock, and closes a race condition where a stale reply
with CAN_RTR_FLAG could be transmitted.

Link: https://lore.kernel.org/linux-can/6975d5cf.a00a0220.33ccc7.0022.GAE@g=
oogle.com/

> diff --git a/net/can/bcm.c b/net/can/bcm.c
> index b612135b017d1..af4bb4182bc29 100644
> --- a/net/can/bcm.c
> +++ b/net/can/bcm.c

[ ... ]

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
This is a pre-existing issue, but does bcm_tx_setup() update op->frames
locklessly?

If a concurrent bcm_can_tx() is driven by the TX timer while the user
updates an existing TX operation, bcm_tx_setup() copies data into the active
op->frames without taking a lock:

net/can/bcm.c:bcm_tx_setup() {
    ...
    cf =3D op->frames + op->cfsiz * i;
    err =3D memcpy_from_msg((u8 *)cf, msg, op->cfsiz);
    ...
}

Because memcpy_from_msg() can sleep, it happens without the spinlock,
which could allow an attacker to concurrently write a malicious payload
length.

Could this lead to a torn read of the CAN frame in bcm_can_tx() and a
transmission of an unvalidated length, resulting in an out-of-bounds read?

[ ... ]

> @@ -461,7 +466,7 @@ static enum hrtimer_restart bcm_tx_timeout_handler(st=
ruct hrtimer *hrtimer)
>  	struct bcm_msg_head msg_head;
> =20
>  	if (op->kt_ival1 && (op->count > 0)) {
> -		bcm_can_tx(op);
> +		bcm_can_tx(op, NULL);
>  		if (!op->count && (op->flags & TX_COUNTEVT)) {

[Severity: Medium]
This is a pre-existing issue, but are the timer and count fields read here
subject to concurrent updates?

bcm_tx_timeout_handler() evaluates op->kt_ival1, op->kt_ival2, and op->count
without holding the bcm_tx_lock.

Meanwhile, bcm_tx_setup() can update these timer values locklessly in proce=
ss
context. Additionally, op->count can be decremented by another thread execu=
ting
bcm_can_tx() concurrently.

Could this lead to torn reads of 64-bit ktime_t values on 32-bit platforms,
causing unexpected timer expiries or incorrect notifications?

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
> +	rtr_frame =3D op->flags & RX_RTR_FRAME;
> +	if (rtr_frame)
> +		memcpy(&rtrframe, op->frames, op->cfsiz);
> +	spin_unlock_bh(&op->bcm_rx_update_lock);

[Severity: Medium]
This is a pre-existing issue, but are some metadata updates still left
unprotected by the new lock?

Just above this section, metadata fields are modified outside the lock:

net/can/bcm.c:bcm_rx_handler() {
    ...
    op->rx_stamp =3D skb->tstamp;
    op->rx_ifindex =3D skb->dev->ifindex;
    ...
    op->frames_abs++;
    ...
}

If an operation is bound to all interfaces (ifindex =3D 0) and receives fra=
mes
concurrently on multiple CPUs, could these updates overwrite op->rx_ifindex
before bcm_send_to_user() dispatches it inside the critical section?

Would this result in userspace receiving incorrectly bundled metadata,
such as a packet from can0 tagged with the timestamp and ifindex of can1?

[ ... ]

> @@ -1130,6 +1165,24 @@ static int bcm_tx_setup(struct bcm_msg_head *msg_h=
ead, struct msghdr *msg,
>  	return err;
>  }
> =20
> +static void bcm_rx_setup_rtr_check(struct bcm_msg_head *msg_head,
> +				   struct bcm_op *op, void *new_frames)
> +{
> +	/* funny feature in RX(!)_SETUP only for RTR-mode:
> +	 * copy can_id into frame BUT without RTR-flag to
> +	 * prevent a full-load-loopback-test ... ;-]
> +	 * normalize this on the staged buffer, before it is
> +	 * ever installed into op->frames.
> +	 */
> +	if (msg_head->flags & RX_RTR_FRAME) {
> +		struct canfd_frame *frame0 =3D new_frames;
> +
> +		if ((msg_head->flags & TX_CP_CAN_ID) ||
> +		    frame0->can_id =3D=3D op->can_id)
> +			frame0->can_id =3D op->can_id & ~CAN_RTR_FLAG;
> +	}
> +}

[Severity: High]
This isn't a bug introduced by this patch, but does the handling for
RX_RTR_FRAME lack payload length validation?

If a user configures an RX_SETUP operation with RX_RTR_FRAME and provides
a CAN frame with a malicious length (for example, len =3D 255),
bcm_rx_setup_rtr_check() normalizes the RTR flag but doesn't validate
the payload length bounds.

When an incoming RTR frame triggers the automated reply, bcm_rx_handler()
passes this unvalidated frame to bcm_can_tx():

net/can/bcm.c:bcm_rx_handler() {
    ...
    if (rtr_frame) {
        bcm_can_tx(op, &rtrframe);
        return;
    }
    ...
}

Could the CAN driver trust cf->len and read beyond the allocated buffer,
leading to an out-of-bounds slab read that leaks kernel memory onto the bus?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260709-bcm_fixes-=
v10-0-57fff38e34ce@hartkopp.net?part=3D3

