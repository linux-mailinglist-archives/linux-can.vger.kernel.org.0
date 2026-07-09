Return-Path: <linux-can+bounces-8260-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 5WCDJqkHUGqYsAIAu9opvQ
	(envelope-from <linux-can+bounces-8260-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Thu, 09 Jul 2026 22:42:17 +0200
X-Original-To: lists+linux-can@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 11A957357FC
	for <lists+linux-can@lfdr.de>; Thu, 09 Jul 2026 22:42:17 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=V0Rstv52;
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	spf=pass (mail.lfdr.de: domain of "linux-can+bounces-8260-lists+linux-can=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="linux-can+bounces-8260-lists+linux-can=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 32AE7304E733
	for <lists+linux-can@lfdr.de>; Thu,  9 Jul 2026 20:38:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68F9E305E19;
	Thu,  9 Jul 2026 20:38:08 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F4783CFF79
	for <linux-can@vger.kernel.org>; Thu,  9 Jul 2026 20:38:06 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783629488; cv=none; b=hm/4AcyzheApJLIA+hKvSKidTAqvsWt73JKsmMqdPWVD8mq/lXv3pDKlOrFmJn7oGh/LjL7QD25FTd3iawlxm8C4zcn0AdkC6IP/WsrEmEzigMX031dMfW8X24FS7RQPmTU2j3ja69CD3qxLizE84aTmcjOvfqGh5EpZtvIgkjk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783629488; c=relaxed/simple;
	bh=z525+k8wye3dEgJmCvLMjcVL3XWanF+YVC+27wGkSX4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=X3H0RCpdDitoLE91ojPzuQNiYNxJOdM6EyL5zkoiOGH7zXJNnCxIng7ruwwdQQaF3wJshjJpXQ2O52bzjMWjBUb9JGGC6e1GcSy1ZJmfobsMVASMr/zO2JtFV2Ncb3rn4STF5RRGAU2AItFTDDatjF7EWZj4Ef17jOpJn12tHd4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V0Rstv52; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4921F1F000E9;
	Thu,  9 Jul 2026 20:38:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783629486;
	bh=oOUM6KZUfTkq5cZIdW7/Bu0tLh3GOuJ1ZLrV5phBdGw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=V0Rstv529am3A5zxTufMlAJFQQlJcqdm9+Q6Y8dRXFtKoMnPChh7mneYYRtuauIrk
	 5JS3tvpB7YI0wUd6grrUlmQ+QRkh+kNfSiPU1cn0/i4e+USGmiqcxq+uJdzwD5sKoX
	 KNRgiTJQU7CW1ZXs2491EHNMgsD+7igUkPTM7AAOhIXtLGp3UcNJOqV0+ugVuPW1Am
	 DJjCDMhEd3OkJITxsF+9xRBR18VjRPOls/a1akhuHSfSSB2bKYNkt3LZtZb8q9Sm63
	 XccBghY/ujdqeoEgE/kBvMnOwQtlYW9ToA13hSV3lXeD+xjxwlcAcVqkg3ZcgdZrhx
	 2uKxuOvLaZl9Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v12 03/11] can: bcm: add locking when updating filter
 and timer values
Reply-To: sashiko-reviews@lists.linux.dev
To: "Oliver Hartkopp" <socketcan@hartkopp.net>
Cc: linux-can@vger.kernel.org, "Vincent Mailhol" <mailhol@kernel.org>, "Marc
 Kleine-Budde" <mkl@pengutronix.de>, "Oliver Hartkopp" <socketcan@hartkopp.net>, "Oleksij
 Rempel" <o.rempel@pengutronix.de>
In-Reply-To: <20260709-bcm_fixes-v12-3-61c06291bf1c@hartkopp.net>
References: <20260709-bcm_fixes-v12-0-61c06291bf1c@hartkopp.net>
 <20260709-bcm_fixes-v12-3-61c06291bf1c@hartkopp.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 09 Jul 2026 20:38:05 +0000
Message-Id: <20260709203806.4921F1F000E9@smtp.kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-8260-lists,linux-can=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	REPLYTO_DN_EQ_FROM_DN(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[smtp.kernel.org:mid,vger.kernel.org:from_smtp,hartkopp.net:email,lists.linux.dev:replyto,sashiko.dev:url,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns];
	FORGED_SENDER(0.00)[sashiko-bot@kernel.org,linux-can@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:socketcan@hartkopp.net,m:linux-can@vger.kernel.org,m:mailhol@kernel.org,m:mkl@pengutronix.de,m:o.rempel@pengutronix.de,s:lists@lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_NO_DN(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	HAS_REPLYTO(0.00)[sashiko-reviews@lists.linux.dev]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 11A957357FC

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Missing payload length validation for `RX_RTR_FRAME` replies in `b=
cm_rx_setup` allows injecting frames with arbitrary length, causing out-of-=
bounds reads in drivers.
- [High] Incomplete fix: `bcm_tx_setup()` updates `op->frames` locklessly, =
rendering the reader lock in `bcm_can_tx()` ineffective against data races.
- [High] Torn reads of 64-bit timer values (`kt_ival1`, `kt_ival2`) in the =
TX path on 32-bit systems lead to timer corruption.
- [High] Concurrent reset of `op->frames_abs` causes a divide-by-zero kerne=
l panic in `bcm_proc_show()`.
--

--- Patch [3]: [PATCH v12 03/11] can: bcm: add locking when updating filter=
 and timer values ---
commit b4832d6a0263dd4d6aa442ff6fb6515600a402df
Author: Oliver Hartkopp <socketcan@hartkopp.net>

can: bcm: add locking when updating filter and timer values

KCSAN detected a simultaneous access to timer values that can be
overwritten in bcm_rx_setup() when updating timer and filter content
while bcm_rx_handler(), bcm_rx_timeout_handler() or bcm_rx_thr_handler()
run concurrently on incoming CAN traffic.

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
This is a pre-existing issue, but does bcm_tx_setup() still overwrite
op->frames locklessly from userspace?

If bcm_tx_setup() directly uses memcpy_from_msg() without holding
bcm_tx_lock:

net/can/bcm.c:bcm_tx_setup() {
    ...
    cf =3D op->frames + op->cfsiz * i;
    err =3D memcpy_from_msg((u8 *)cf, msg, op->cfsiz);
    ...
}

Would this reader lock in bcm_can_tx() be ineffective, allowing it to
copy and transmit a partially overwritten torn frame?

[ ... ]

> @@ -461,7 +466,7 @@ static enum hrtimer_restart bcm_tx_timeout_handler(st=
ruct hrtimer *hrtimer)
>  	struct bcm_msg_head msg_head;
> =20
>  	if (op->kt_ival1 && (op->count > 0)) {
> -		bcm_can_tx(op);
> +		bcm_can_tx(op, NULL);

[Severity: High]
This is a pre-existing issue, but could this lockless read of op->kt_ival1 =
in
softirq context lead to a torn read?

If bcm_tx_setup() assigns the 64-bit kt_ival1 and kt_ival2 locklessly:

net/can/bcm.c:bcm_tx_setup() {
    ...
    op->kt_ival1 =3D bcm_timeval_to_ktime(msg_head->ival1);
    op->kt_ival2 =3D bcm_timeval_to_ktime(msg_head->ival2);
    ...
}

Could a concurrent bcm_tx_timeout_handler() on a 32-bit system observe torn
halves of the timer interval and set a corrupted expiry time? This appears
similar to the KCSAN-reported torn read on the RX path that this patch fixe=
s.

[ ... ]

> @@ -729,9 +751,18 @@ static void bcm_rx_handler(struct sk_buff *skb, void=
 *data)
>  	/* update statistics */
>  	op->frames_abs++;

[Severity: High]
This is a pre-existing issue, but does the concurrent reset of op->frames_a=
bs
cause a divide-by-zero kernel panic in bcm_proc_show()?

If bcm_proc_show() executes locklessly:

net/can/bcm.c:bcm_proc_show() {
    if (!op->frames_abs)
        continue;
   =20
    // ...=20
    reduction =3D 100 - (op->frames_filtered * 100) / op->frames_abs;
    ...
}

And a concurrent CAN frame reception triggers bcm_rx_changed() which resets
these counters without synchronization:

net/can/bcm.c:bcm_rx_changed() {
    if (op->frames_filtered > ULONG_MAX/100)
        op->frames_filtered =3D op->frames_abs =3D 0;
    ...
}

Could op->frames_abs be zeroed out between the check and the division,
resulting in a crash?

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
This is a pre-existing issue, but is there missing payload length validation
for RX_RTR_FRAME replies?

While bcm_rx_setup_rtr_check() normalizes the CAN ID, it does not appear to
check the len field of the user-supplied canfd_frame.=20

If a user creates an RX_SETUP operation with RX_RTR_FRAME and provides a
frame with a maliciously large len field (e.g., 255), could bcm_can_tx()
later allocate an SKB and hand this invalid frame to the networking stack?

Will this cause out-of-bounds reads in drivers that trust skb->len?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260709-bcm_fixes-=
v12-0-61c06291bf1c@hartkopp.net?part=3D3

