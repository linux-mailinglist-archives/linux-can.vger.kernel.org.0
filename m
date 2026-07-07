Return-Path: <linux-can+bounces-8067-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 4bARO97WTGqVqgEAu9opvQ
	(envelope-from <linux-can+bounces-8067-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Tue, 07 Jul 2026 12:37:18 +0200
X-Original-To: lists+linux-can@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A94071A785
	for <lists+linux-can@lfdr.de>; Tue, 07 Jul 2026 12:37:18 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=BgyA0xtO;
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	spf=pass (mail.lfdr.de: domain of "linux-can+bounces-8067-lists+linux-can=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="linux-can+bounces-8067-lists+linux-can=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 02C0B30516B9
	for <lists+linux-can@lfdr.de>; Tue,  7 Jul 2026 10:35:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C5DD3E559B;
	Tue,  7 Jul 2026 10:35:02 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA1ED3EC2CD
	for <linux-can@vger.kernel.org>; Tue,  7 Jul 2026 10:35:00 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783420502; cv=none; b=KWYWayqMSrqrtim7ZXjcIk6DQxonVdLIfZeBeZEWY4bhQouBfbWEuv7/JxNe8QWN21McyFaMHgXEKh4yjxz8T6MY5fVTUBmGLApgqhzc2meuCYgoobWdgLtFYiKbvEFntxgyjdjUTqx6lf9sI45LCRdquPu38KM5uryhZqvpLxQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783420502; c=relaxed/simple;
	bh=BUH+kZeDdpwk1omadZqTkPb5WEgAnhto2BxPkQH1B9M=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Dtg8Kco6jDY/wtzfMfmVuOlFwpcurZKe1wNdaEprgszR3D2U3GEwRpiebLX+N7JeZdZ+yofBNVW3B95ODsThMngbfA8RVNF2Ju1u2kUV22CuyljoUWvx/Y0QYJmUDdGKCBKAnej4TDwsJKfkMogFrc5Crqq5cv3ly3Je1HnsZWw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BgyA0xtO; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6898B1F000E9;
	Tue,  7 Jul 2026 10:35:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783420500;
	bh=gSm0fnuwY9SIPwzT2iFkKCmyD1f7cNnryV4TwSjavBg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=BgyA0xtORRwe9FQb0jyK02Mb7phpiVJCmQWxfMstf+Ta4U1zvpPwwwcMtdmatBAyz
	 6zVCv8+1zcnQUM/0VyXkIsRa5fiE9Kca+y94t3KPWWFHUvtgIzITFwsWhnnFoPNZ3m
	 haC9elupSn6iwK4Zmc88ikkNgZukAtb2zzprPRsZm2CfIp0SUK3m1FXuqB9bfVxEt7
	 SfJd396iCsxMwEQP+w2ELlWUbxr8297UaNsD7WItNjvwZK4x5eL6eZuMslmfb0HIKa
	 Y2+cuv6ZHiAiARZV+MuNrSONIHvdtFu6KB+MxYdBf1H1oCRw90jhr333Ph20aHP+tf
	 4s0Px6fl9nCIA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 3/7] can: bcm: add locking when updating filter and
 timer values
Reply-To: sashiko-reviews@lists.linux.dev
To: "Oliver Hartkopp" <socketcan@hartkopp.net>
Cc: "Vincent Mailhol" <mailhol@kernel.org>, "Oliver Hartkopp" <socketcan@hartkopp.net>, linux-can@vger.kernel.org, "Marc
 Kleine-Budde" <mkl@pengutronix.de>, "Oleksij Rempel" <o.rempel@pengutronix.de>
In-Reply-To: <20260707-bcm_fixes-v3-3-84600ca6d889@hartkopp.net>
References: <20260707-bcm_fixes-v3-0-84600ca6d889@hartkopp.net>
 <20260707-bcm_fixes-v3-3-84600ca6d889@hartkopp.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 07 Jul 2026 10:35:00 +0000
Message-Id: <20260707103500.6898B1F000E9@smtp.kernel.org>
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
	TAGGED_FROM(0.00)[bounces-8067-lists,linux-can=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	REPLYTO_DN_EQ_FROM_DN(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lists.linux.dev:replyto,vger.kernel.org:from_smtp,sashiko.dev:url,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,smtp.kernel.org:mid];
	FORGED_SENDER(0.00)[sashiko-bot@kernel.org,linux-can@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:socketcan@hartkopp.net,m:mailhol@kernel.org,m:linux-can@vger.kernel.org,m:mkl@pengutronix.de,m:o.rempel@pengutronix.de,s:lists@lfdr.de];
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
X-Rspamd-Queue-Id: 8A94071A785

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Concurrent timer updates lead to hrtimer_forward_now being called =
with a zero interval, triggering a WARN_ON.
- [High] Missing locking in the TX path leads to data races and torn reads =
for CAN frames and timer values.
--

--- Patch [3]: [PATCH v3 3/7] can: bcm: add locking when updating filter an=
d timer values ---
commit 29dee20a547c38c99b2b856375f9e172e6a33181
Author: Oliver Hartkopp <socketcan@hartkopp.net>

    can: bcm: add locking when updating filter and timer values

    KCSAN detected a simultaneous access to timer values that can be
    overwritten in bcm_rx_setup() when updating timer and filter content
    while bcm_rx_handler(), bcm_rx_timeout_handler() or bcm_rx_thr_handler()
    run concurrently on incoming CAN traffic.

    Closes: https://lore.kernel.org/linux-can/6975d5cf.a00a0220.33ccc7.0022=
.GAE@google.com/

> diff --git a/net/can/bcm.c b/net/can/bcm.c
> index b612135b017d1..fd548c6eaa913 100644
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
This isn't a bug introduced by this patch, but does bcm_tx_lock actually
prevent concurrent overwrites by bcm_tx_setup()?

The commit message claims to "take a lock-protected snapshot of the currfra=
me
in bcm_can_tx() to avoid partly overwrites by content updates in
bcm_tx_setup()".

However, looking at bcm_tx_setup(), it appears to copy user data directly i=
nto
op->frames without holding bcm_tx_lock:

net/can/bcm.c:bcm_tx_setup() {
    ...
    for (i =3D 0; i < msg_head->nframes; i++) {
        cf =3D op->frames + op->cfsiz * i;
        err =3D memcpy_from_msg((u8 *)cf, msg, op->cfsiz);
    ...
}

If the writer never acquires the lock (since memcpy_from_msg() can sleep),
doesn't this lock in bcm_can_tx() remain ineffective against races?

[ ... ]

> @@ -461,7 +466,7 @@ static enum hrtimer_restart bcm_tx_timeout_handler(st=
ruct hrtimer *hrtimer)
>  	struct bcm_msg_head msg_head;
> =20
>  	if (op->kt_ival1 && (op->count > 0)) {

[Severity: High]
This is a pre-existing issue, but is this lockless read of kt_ival1 vulnera=
ble
to torn reads on 32-bit systems?

bcm_tx_setup() appears to update kt_ival1 and kt_ival2 locklessly, and this
handler reads them locklessly. Could this cause the timer to fire at
unintended intervals if a 64-bit ktime_t is partially updated while being r=
ead?

> -		bcm_can_tx(op);
> +		bcm_can_tx(op, NULL);
>  		if (!op->count && (op->flags & TX_COUNTEVT)) {

[ ... ]

> @@ -686,15 +695,22 @@ static int bcm_rx_thr_flush(struct bcm_op *op)
>  static enum hrtimer_restart bcm_rx_thr_handler(struct hrtimer *hrtimer)
>  {
>  	struct bcm_op *op =3D container_of(hrtimer, struct bcm_op, thrtimer);
> +	enum hrtimer_restart ret;
> +
> +	spin_lock_bh(&op->bcm_rx_update_lock);
> =20
>  	if (bcm_rx_thr_flush(op)) {
>  		hrtimer_forward_now(hrtimer, op->kt_ival2);

[Severity: High]
This is a pre-existing issue, but could hrtimer_forward_now() be called wit=
h a
zero interval, triggering a WARN_ON_ONCE?

If a user updates an RX operation with msg_head->nframes =3D=3D 0 and ival2=
 =3D=3D 0,
bcm_rx_setup() updates op->kt_ival2 =3D 0 but does not clear op->last_frame=
s.
It drops the lock before cancelling the timer:

net/can/bcm.c:bcm_rx_setup() {
    ...
    spin_lock_bh(&op->bcm_rx_update_lock);
    op->ival2 =3D msg_head->ival2;
    op->kt_ival2 =3D bcm_timeval_to_ktime(msg_head->ival2);
    ...
    spin_unlock_bh(&op->bcm_rx_update_lock);

    /* disable an active timer due to zero value? */
    if (!op->kt_ival1)
        hrtimer_cancel(&op->timer);

    hrtimer_cancel(&op->thrtimer);
    ...
}

Because hrtimer_cancel(&op->thrtimer) is called without the
bcm_rx_update_lock held, could a concurrently expiring bcm_rx_thr_handler()
acquire the lock, flush the still-throttled frame, and call
hrtimer_forward_now(hrtimer, op->kt_ival2) with an interval of 0?

> -		return HRTIMER_RESTART;
> +		ret =3D HRTIMER_RESTART;
>  	} else {
>  		/* rearm throttle handling */
>  		op->kt_lastmsg =3D 0;
> -		return HRTIMER_NORESTART;
> +		ret =3D HRTIMER_NORESTART;
>  	}
> +
> +	spin_unlock_bh(&op->bcm_rx_update_lock);
> +
> +	return ret;
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260707-bcm_fixes-=
v3-0-84600ca6d889@hartkopp.net?part=3D3

