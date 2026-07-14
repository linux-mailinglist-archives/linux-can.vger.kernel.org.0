Return-Path: <linux-can+bounces-8439-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id K7k0GhNtVmpS5QAAu9opvQ
	(envelope-from <linux-can+bounces-8439-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Tue, 14 Jul 2026 19:08:35 +0200
X-Original-To: lists+linux-can@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id ED3CE757368
	for <lists+linux-can@lfdr.de>; Tue, 14 Jul 2026 19:08:34 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=HvAyWIUq;
	spf=pass (mail.lfdr.de: domain of "linux-can+bounces-8439-lists+linux-can=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="linux-can+bounces-8439-lists+linux-can=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 339F8303545E
	for <lists+linux-can@lfdr.de>; Tue, 14 Jul 2026 17:08:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B3DD39CD13;
	Tue, 14 Jul 2026 17:08:32 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31F5F39CCF1
	for <linux-can@vger.kernel.org>; Tue, 14 Jul 2026 17:08:28 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784048911; cv=none; b=cfDoMWGIDpz1rRLqtCazCylcwGBUCRwKugdR6XC4WWPH3prR73InW4A26WEUewvrf8HeOkZ/z57eVUKB1jZT/9eSiMiIWFXiQE2L66HlzXhthZASKmR3X81kS3Z5hxBMbl402QokSxcby7C4dKncIbKBrKEul3NEzBt6tWIQYzo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784048911; c=relaxed/simple;
	bh=1nz8czJwGwrdEWq2RgU2QHvEuva67MNeoLhZGI2HVlg=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=WxJ+gc35/84ifSv6M1PNKe2FeN3AGBIjMTaurpAGPV5he1uRLDTP55Yeefuo+nZC+Pa6Ssm6Ttq1D2k5BAAjw7av/IeuKbN2qbDevAB+EH3RqoOefNK94ps5Xh7i6xuaoYOPR2zDdSsCmNaSL0AtkNDH+NiaLPRxDlTNm9vvKaI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HvAyWIUq; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B29E1F00A3A;
	Tue, 14 Jul 2026 17:08:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784048908;
	bh=g7ONBWLo6T0+A3moR+NK9lTWwdC7TdgmbEEBpTo2Fek=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=HvAyWIUqb47bq4fSSgjVziFs5o1yX9Jz04tsLbukuDi/f90OPjoEtB4p8RNcvfO9u
	 bY9NvL6zADwCYBTCPHV4sLs15Gff7RV/2a3LtQ90ijafaMzuOdfaovCaOF6BRs2hBd
	 tFscWphJKEZ8zxMu/euRAzDSLD1Gy8aYVUdRmMUXH1R8a7L3DeHQxDuQNLSih08cHC
	 FUwLv+hgK1g2sxTFtJcU/V/vmv8E+L4oor4JiB/4m+zkgnuW2yBLR5i8ekPUKLPMe6
	 jgjNHyajQtUxloxx4Wx1BQ3dqGVtMdeM6aC3HNDbJJCd/Pl31ovF7fyOH4Jj8reYIn
	 gHxu1KBsDcOUQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v15 03/11] can: bcm: add locking when updating filter
 and timer values
Reply-To: sashiko-reviews@lists.linux.dev
To: "Oliver Hartkopp" <socketcan@hartkopp.net>
Cc: "Marc Kleine-Budde" <mkl@pengutronix.de>, "Oliver Hartkopp" <socketcan@hartkopp.net>, "Vincent
 Mailhol" <mailhol@kernel.org>, "Oleksij Rempel" <o.rempel@pengutronix.de>, linux-can@vger.kernel.org
In-Reply-To: <20260714-bcm_fixes-v15-3-562f7e3e42da@hartkopp.net>
References: <20260714-bcm_fixes-v15-0-562f7e3e42da@hartkopp.net>
 <20260714-bcm_fixes-v15-3-562f7e3e42da@hartkopp.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 14 Jul 2026 17:08:27 +0000
Message-Id: <20260714170828.1B29E1F00A3A@smtp.kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-8439-lists,linux-can=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	REPLYTO_DN_EQ_FROM_DN(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lists.linux.dev:replyto,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,sashiko.dev:url,hartkopp.net:email,smtp.kernel.org:mid,vger.kernel.org:from_smtp];
	FORGED_SENDER(0.00)[sashiko-bot@kernel.org,linux-can@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:socketcan@hartkopp.net,m:mkl@pengutronix.de,m:mailhol@kernel.org,m:o.rempel@pengutronix.de,m:linux-can@vger.kernel.org,s:lists@lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_NO_DN(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	HAS_REPLYTO(0.00)[sashiko-reviews@lists.linux.dev]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: ED3CE757368

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Missing validation of the `len` field for user-provided CAN frames=
 when creating an `RX_RTR_FRAME` filter leads to an out-of-bounds read and =
memory leak onto the CAN bus.
- [High] Data race on `op->frames_abs` leads to a divide by zero panic in p=
rocfs.
- [High] Lockless updates to 64-bit timer values and state fields in `bcm_t=
x_setup()` cause data races and torn reads.
- [High] `bcm_tx_setup()` updates `op->frames` without lock, making the rea=
der's lock in `bcm_can_tx()` useless and transmitting torn CAN frames.
--

--- Patch [3]: [PATCH v15 03/11] can: bcm: add locking when updating filter=
 and timer values ---
commit c68765d3cdec02f986dd3eafa2bbc8dffcaae484
Author: Oliver Hartkopp <socketcan@hartkopp.net>

    can: bcm: add locking when updating filter and timer values
   =20
    KCSAN detected a simultaneous access to timer values that can be
    overwritten in bcm_rx_setup() when updating timer and filter content
    while bcm_rx_handler(), bcm_rx_timeout_handler() or bcm_rx_thr_handler()
    run concurrently on incoming CAN traffic.

    Link: https://lore.kernel.org/linux-can/6975d5cf.a00a0220.33ccc7.0022.G=
AE@google.com/

> diff --git a/net/can/bcm.c b/net/can/bcm.c
> index b612135b017d1..1e5f8d65d351b 100644
> --- a/net/can/bcm.c
> +++ b/net/can/bcm.c
> @@ -293,22 +294,28 @@ static int bcm_proc_show(struct seq_file *m, void *=
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
> +	bool cyclic =3D !cf;
> +	unsigned int idx =3D 0;
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
> +	if (cyclic) {
> +		/* read currframe under lock protection */
> +		spin_lock_bh(&op->bcm_tx_lock);
> +		idx =3D op->currframe;
> +		memcpy(&cframe, op->frames + op->cfsiz * idx, op->cfsiz);
> +		cf =3D &cframe;
> +		spin_unlock_bh(&op->bcm_tx_lock);
> +	}

[Severity: High]
This isn't a bug introduced by this patch, but does taking bcm_tx_lock here
actually protect against torn reads during concurrent updates?

Looking at bcm_tx_setup(), the user-provided frames are copied directly into
op->frames without holding bcm_tx_lock:

bcm_tx_setup() {
    ...
    for (i =3D 0; i < msg_head->nframes; i++) {
        cf =3D op->frames + op->cfsiz * i;
        err =3D memcpy_from_msg((u8 *)cf, msg, op->cfsiz);
    ...
}

Since the writer does not acquire the lock, a cyclic transmission firing in
bcm_tx_timeout_handler() might read partially updated bytes while
memcpy_from_msg() is executing. Could this lead to the transmission of
corrupted, torn CAN frames to the CAN bus?

[ ... ]
> @@ -341,14 +348,20 @@ static void bcm_can_tx(struct bcm_op *op)
>  	if (!err)
>  		op->frames_abs++;

[Severity: High]
This is a pre-existing issue, but can this lockless increment of
op->frames_abs lead to a division by zero panic in procfs?

In bcm_rx_changed(), when op->frames_filtered exceeds ULONG_MAX/100, both
variables are locklessly cleared to 0:

bcm_rx_changed() {
    ...
    if (op->frames_filtered > ULONG_MAX/100)
        op->frames_filtered =3D op->frames_abs =3D 0;
    ...
}

Concurrently, a user reading /proc/net/can-bcm executes bcm_proc_show(),
which checks if op->frames_abs is non-zero before calculating a percentage:

bcm_proc_show() {
    ...
    if (!op->frames_abs)
        continue;
    ...
    seq_printf(...);
    ...
    reduction =3D 100 - (op->frames_filtered * 100) / op->frames_abs;
    ...
}

Because of the opaque function call to seq_printf(), the compiler must
reload op->frames_abs from memory for the division. If bcm_rx_changed()
clears it to 0 precisely after the initial check, would this result in
a divide by zero?

[ ... ]
> @@ -1116,7 +1159,7 @@ static int bcm_tx_setup(struct bcm_msg_head *msg_he=
ad, struct msghdr *msg,
>  	}
> =20
>  	if (op->flags & TX_ANNOUNCE)
> -		bcm_can_tx(op);
> +		bcm_can_tx(op, NULL);
> =20
>  	if (op->flags & STARTTIMER)
>  		bcm_tx_start_timer(op);

[Severity: High]
This is a pre-existing issue, but does this code leave the timer updates in
bcm_tx_setup() exposed to data races?

In bcm_tx_setup(), the timer values are updated directly without holding
bcm_tx_lock or any other synchronization:

bcm_tx_setup() {
    ...
    if (op->flags & SETTIMER) {
        op->ival1 =3D msg_head->ival1;
        op->ival2 =3D msg_head->ival2;
        op->kt_ival1 =3D bcm_timeval_to_ktime(msg_head->ival1);
        op->kt_ival2 =3D bcm_timeval_to_ktime(msg_head->ival2);
    ...
}

Simultaneously, the bcm_tx_timeout_handler() softirq might fire and read
these exact fields locklessly to dispatch timeout notifications to userspac=
e.

Could this lead to torn reads of 64-bit values (like ktime_t) on 32-bit
systems, leaking corrupted data to userspace and causing incorrect timer
behavior?

> @@ -1130,6 +1173,24 @@ static int bcm_tx_setup(struct bcm_msg_head *msg_h=
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
This is a pre-existing issue, but does this function omit the bounds check
on the user-provided len field?

Unlike bcm_tx_setup() which properly validates the length, this code normal=
izes
the RTR frame without validating frame0->len.

When a matching remote request is received, the malformed frame is
transmitted by bcm_rx_handler() -> bcm_can_tx(). The CAN driver then reads
len bytes from the frame.

If the len field was maliciously set (e.g., 255), could this result in an
out-of-bounds read past the end of the sk_buff payload, leading to a memory
leak of adjacent kernel memory onto the CAN bus?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260714-bcm_fixes-=
v15-0-562f7e3e42da@hartkopp.net?part=3D3

