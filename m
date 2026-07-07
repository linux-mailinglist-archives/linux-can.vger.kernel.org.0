Return-Path: <linux-can+bounces-8035-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id a7iJJPe4TGrYogEAu9opvQ
	(envelope-from <linux-can+bounces-8035-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Tue, 07 Jul 2026 10:29:43 +0200
X-Original-To: lists+linux-can@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 249207191CB
	for <lists+linux-can@lfdr.de>; Tue, 07 Jul 2026 10:29:43 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=S3B3Vy0l;
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	spf=pass (mail.lfdr.de: domain of "linux-can+bounces-8035-lists+linux-can=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="linux-can+bounces-8035-lists+linux-can=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id C0AE93009094
	for <lists+linux-can@lfdr.de>; Tue,  7 Jul 2026 08:29:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5B1D2EDD7D;
	Tue,  7 Jul 2026 08:29:00 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF47713A86C
	for <linux-can@vger.kernel.org>; Tue,  7 Jul 2026 08:28:59 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783412940; cv=none; b=jYo8Q4B5mH/37H0+nvgdJ6hl/qBxOtLLPSxEE381GVtuIGTAyQtd13J0SRDly2iC4TeKfQbGPDoc4nc3hcGXtJ6KfQ85iZKOgzfn32s6uFsYja1Kt7JNmfsbYwnDovN69ZiJwLi0izy5fkNw5eRYrir6pIfLK9y3a6CcL6PKnMk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783412940; c=relaxed/simple;
	bh=hPX8iZRcMUMPDER5GTeQe5IFInl/tdn8V7m7qxSjISI=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=U6cAPNOAWecdkl44K4oBMh2qOCWAEUzv6KiEhm+MhsKs/IGxEXpzhU0BBl4yzjcDlutqIf1uOfu7Gz2mEyiOmKuG5aRZ2zESCbf5+/oGdB/ATKcS3uQn7w3DYIcZDMwBpTCLYeCdJTu3JIvSRzoXLYFxEfxgxCFOqIudVnWFMSU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S3B3Vy0l; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 25DC51F00A3A;
	Tue,  7 Jul 2026 08:28:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783412939;
	bh=v4wyhhvNdY1i74fhHedvNHReN6e1CodZqhuk6kg0dSo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=S3B3Vy0laZVcy5C4bEy0EY99it2D/9q1ziAR74riCCpFXl7GIjx2dYeHVkuK71+dB
	 r07zmKO4EQ9nArN6jxnkqCvSCTF+pfSf5NH2dhaJIAJPwLsWr9WeBvbWSD7wUpgltt
	 c4KU7LzQVTEpDE+ZVTGnD8MdOVUw2AHQZHe6U1Ho+C6mFEhlhw+kquR/5P8fq8f4fk
	 v9c20LRodGCIXIvkujJotctrdUg05nQNgow2dgB3dhATw+tFBku/X1uXhIKEqCoXXn
	 U4mybBw4AtknkQTqrlOqO4VY8E9t4/N73f0S7uNoRL285m4s0rfDcw81kATY/5Zyp/
	 B8RH5q62qoAyg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 3/6] can: bcm: add locking when updating filter and
 timer values
Reply-To: sashiko-reviews@lists.linux.dev
To: "Oliver Hartkopp" <socketcan@hartkopp.net>
Cc: "Oliver Hartkopp" <socketcan@hartkopp.net>, "Vincent Mailhol" <mailhol@kernel.org>, "Marc
 Kleine-Budde" <mkl@pengutronix.de>, "Oleksij Rempel" <o.rempel@pengutronix.de>, linux-can@vger.kernel.org
In-Reply-To: <20260707-bcm_fixes-v2-3-96620c534b75@hartkopp.net>
References: <20260707-bcm_fixes-v2-0-96620c534b75@hartkopp.net>
 <20260707-bcm_fixes-v2-3-96620c534b75@hartkopp.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 07 Jul 2026 08:28:58 +0000
Message-Id: <20260707082859.25DC51F00A3A@smtp.kernel.org>
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
	TAGGED_FROM(0.00)[bounces-8035-lists,linux-can=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	REPLYTO_DN_EQ_FROM_DN(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,hartkopp.net:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,sashiko.dev:url];
	FORGED_SENDER(0.00)[sashiko-bot@kernel.org,linux-can@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:socketcan@hartkopp.net,m:mailhol@kernel.org,m:mkl@pengutronix.de,m:o.rempel@pengutronix.de,m:linux-can@vger.kernel.org,s:lists@lfdr.de];
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
X-Rspamd-Queue-Id: 249207191CB

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

Pre-existing issues:
- [High] The TX timeout handler reads 64-bit ktime_t variables and 32-bit s=
tate variables locklessly, creating data races that can lead to torn ktime_=
t reads and erratic timer behavior.
- [High] The CAN frame payload on the transmission side is copied into the =
SKB locklessly, allowing a concurrent update from userspace to overwrite th=
e frame while it is being transmitted, resulting in torn CAN frames.
--

--- Patch [3]: [PATCH v2 3/6] can: bcm: add locking when updating filter an=
d timer values ---
commit 5cea5eef9652435aa644979477f4e925e5e24c8f
Author: Oliver Hartkopp <socketcan@hartkopp.net>

can: bcm: add locking when updating filter and timer values

This commit adds a new per-op bcm_rx_update_lock to protect timer and
filter data updates in the RX handlers against concurrent execution. It
also addresses an RTR flag clearing race by normalizing the frame content
during initial preparation instead of modifying the live frame.

Link: https://lore.kernel.org/linux-can/6975d5cf.a00a0220.33ccc7.0022.GAE@g=
oogle.com/

> diff --git a/net/can/bcm.c b/net/can/bcm.c
> index b612135b017d1..1eabacad0b001 100644
> --- a/net/can/bcm.c
> +++ b/net/can/bcm.c
> @@ -293,22 +294,23 @@ static int bcm_proc_show(struct seq_file *m, void *=
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
> +		cf =3D op->frames + op->cfsiz * op->currframe;
> +		spin_unlock_bh(&op->bcm_tx_lock);
> +	}

[Severity: High]
This isn't a bug introduced by this patch, but can this lead to torn CAN
frames during transmission?

While the bcm_tx_lock protects the calculation of the cf pointer here, the
lock is dropped before calling skb_put_data(skb, cf, op->cfsiz) further
down in bcm_can_tx().

Concurrently, bcm_tx_setup() can overwrite the active op->frames buffer
using memcpy_from_msg() directly from userspace locklessly:

net/can/bcm.c:bcm_tx_setup() {
    ...
    cf =3D op->frames + op->cfsiz * i;
    err =3D memcpy_from_msg((u8 *)cf, msg, op->cfsiz);
    ...
}

Could this allow a partially updated CAN frame to be copied into the skb and
transmitted onto the network while the data is being mutated?

[ ... ]
> @@ -461,7 +463,7 @@ static enum hrtimer_restart bcm_tx_timeout_handler(st=
ruct hrtimer *hrtimer)
>  	struct bcm_msg_head msg_head;
> =20
>  	if (op->kt_ival1 && (op->count > 0)) {

[Severity: High]
This is a pre-existing issue, but can the lockless read of op->kt_ival1
result in a torn read on 32-bit platforms?

In bcm_tx_setup(), the 64-bit ktime_t variables kt_ival1 and kt_ival2 can
be updated concurrently from user space data. Evaluating these values
in bcm_tx_timeout_handler() and bcm_tx_set_expiry() without holding
bcm_tx_lock could yield arbitrary timer intervals.

Could this cause the hrtimer to stall indefinitely or fire in an immediate
tight loop?

> -		bcm_can_tx(op);
> +		bcm_can_tx(op, NULL);
>  		if (!op->count && (op->flags & TX_COUNTEVT)) {
> =20
>  			/* create notification to user */

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260707-bcm_fixes-=
v2-0-96620c534b75@hartkopp.net?part=3D3

