Return-Path: <linux-can+bounces-7812-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 32blKUIzKWodSQMAu9opvQ
	(envelope-from <linux-can+bounces-7812-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Wed, 10 Jun 2026 11:49:54 +0200
X-Original-To: lists+linux-can@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DA42667FEB
	for <lists+linux-can@lfdr.de>; Wed, 10 Jun 2026 11:49:54 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=NyEn65n1;
	spf=pass (mail.lfdr.de: domain of "linux-can+bounces-7812-lists+linux-can=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="linux-can+bounces-7812-lists+linux-can=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id CCBFC306C5A8
	for <lists+linux-can@lfdr.de>; Wed, 10 Jun 2026 09:47:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DEA33E7151;
	Wed, 10 Jun 2026 09:46:56 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 368353E8351
	for <linux-can@vger.kernel.org>; Wed, 10 Jun 2026 09:46:55 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781084816; cv=none; b=M7jabeocsu2RCPNCiSy5rReh8UTu7HynwMkKMQrQ8iBzKCzzLDq4zVrC+5gZ0eCANbhuUj6Pf7aV+3uV1C4JY7cf7/lLKN6NqRSCOsSz92XzuEM0UYWwKjIpdwBhSuhny9qm4oRoRKaSlZaaigcA93tYDTVbxVD5YjHdv9UzPUk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781084816; c=relaxed/simple;
	bh=oN6y2VhZL5I0W7zzx+SRvcL/iLQ3Qt4FGVD2sow/8v4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=HDDKOvnxUFXVIyI1Rw/tc3MXAVyzhcwFk296tC0d8Q38tSAhHgERJjO8gKJW8N4fet+9hes3u9e9HA8y6mGTqj4Bbexuy1G3XHxlxGWKCIY4PoMKcdlUi2cRF4deqBBmgg5teCsfHrAllDfpQAEYwGJrlwJ7EGAgtPUqk5IJ/Mw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NyEn65n1; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A1FFE1F00893;
	Wed, 10 Jun 2026 09:46:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781084814;
	bh=4nyaFPRhHo+Pmk6lDR4EN0tqaE7vd0mASwVMCYrHv1M=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=NyEn65n1XUAf3d//FnFknXUHD94CFMI8fM2p+jt76hShQI5kYbNS9rKWtopAOcjRR
	 k1Ur44FvWdvpU87LfT2PoV+EYTwv6zdeCMCUufYenxs0qSlU1ikWgdWRvWxH/qdF7z
	 SrKvwH3FvlNlpSjJyNYQy/vcu9YatfrbVG5Ujrnro0LNFNMtYXs/UE1W2eehSBcW+p
	 +0zoi4wrvMKa6J5s3AajRwDUrieOfAsHzGnfnAsTAw0gUsD0PXasgRqVA2o02W0h26
	 LZs8X5YE5S3NzQ8FlnUrhOFRj2V/sGBOFtgrUnKJw2auh9mEPNke6j92+to55gXPZv
	 slguZ78s+x8EQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] can: bcm: fix CAN frame rx/tx statistics
Reply-To: sashiko-reviews@lists.linux.dev
To: "Oliver Hartkopp" <socketcan@hartkopp.net>
Cc: "Oleksij Rempel" <o.rempel@pengutronix.de>, linux-can@vger.kernel.org, "Vincent
 Mailhol" <mailhol@kernel.org>, "Marc Kleine-Budde" <mkl@pengutronix.de>
In-Reply-To: <20260610093422.39847-1-socketcan@hartkopp.net>
References: <20260610093422.39847-1-socketcan@hartkopp.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 10 Jun 2026 09:46:54 +0000
Message-Id: <20260610094654.A1FFE1F00893@smtp.kernel.org>
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
	TAGGED_FROM(0.00)[bounces-7812-lists,linux-can=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	REPLYTO_DN_EQ_FROM_DN(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[hartkopp.net:email,sashiko.dev:url,vger.kernel.org:from_smtp,lists.linux.dev:replyto,smtp.kernel.org:mid,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo];
	FORGED_SENDER(0.00)[sashiko-bot@kernel.org,linux-can@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:socketcan@hartkopp.net,m:o.rempel@pengutronix.de,m:linux-can@vger.kernel.org,m:mailhol@kernel.org,m:mkl@pengutronix.de,s:lists@lfdr.de];
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
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_NO_DN(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	HAS_REPLYTO(0.00)[sashiko-reviews@lists.linux.dev]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 4DA42667FEB

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:

New issues:
- [Medium] Logic flaw in statistics overflow handling breaks invariant and =
causes negative reduction percentages.

Pre-existing issues:
- [High] Data race on CAN message payloads, timestamps, and interface indic=
es during concurrent frame reception.
- [High] Use-After-Free due to a timer teardown race during BCM RX op delet=
ion.
- [High] Missing RCU memory barriers when modifying operation lists lead to=
 potential uninitialized memory accesses.
--

commit 6493cba39cc176386238cda012e3d42c9808c07e
Author: Oliver Hartkopp <socketcan@hartkopp.net>

can: bcm: fix CAN frame rx/tx statistics

This commit fixes a KCSAN-detected data race in bcm_rx_handler() when
multiple CPUs process CAN frames simultaneously. It converts the
statistics to atomic types and centralizes the overflow handling.

> diff --git a/net/can/bcm.c b/net/can/bcm.c
> index a4bef2c48a559..a8b914e862798 100644
> --- a/net/can/bcm.c
> +++ b/net/can/bcm.c
[ ... ]
> @@ -224,10 +224,13 @@ static int bcm_proc_show(struct seq_file *m, void *=
v)
> =20
>  	list_for_each_entry_rcu(op, &bo->rx_ops, list) {
> =20
> -		unsigned long reduction;
> +		long reduction, frames_filtered, frames_abs;

[Severity: High]
This is a pre-existing issue, but does bcm_rx_setup() use list_add()
instead of list_add_rcu() when inserting into bo->rx_ops?

If so, could lockless readers like bcm_proc_show() observe uninitialized
memory due to missing store-release memory barriers?

Similarly, does bcm_proc_show() traverse bo->tx_ops locklessly while
bcm_tx_setup() inserts using list_add()?

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
> +

[Severity: Medium]
When bcm_rx_handler() calls bcm_update_stats(), frames_abs is incremented
first. If it overflows, both frames_abs and frames_filtered are reset to 0.

If the packet passes the filter, bcm_rx_changed() is called next and
increments frames_filtered:

net/can/bcm.c:bcm_rx_changed() {
    ...
    atomic_long_inc(&op->frames_filtered);
    ...
}

Could this order cause frames_filtered to become 1 while frames_abs is 0?

Since frames_abs increments by 1 per packet, would frames_filtered remain
strictly greater than frames_abs, causing the reduction calculation in
bcm_proc_show() to persistently yield a negative percentage?

[ ... ]
> @@ -723,7 +732,7 @@ static void bcm_rx_handler(struct sk_buff *skb, void =
*data)
>  	/* save originator for recvfrom() */
>  	op->rx_ifindex =3D skb->dev->ifindex;

[Severity: High]
This is a pre-existing issue, but since the patch addresses data races in
concurrent frame reception, does this concurrent execution also race on
writing to op->rx_stamp and op->rx_ifindex here?

More significantly, could multiple CPUs concurrently execute memcpy() on
the shared op->last_frames array in bcm_rx_update_and_send():

net/can/bcm.c:bcm_rx_update_and_send() {
    ...
    memcpy(lastdata, rxdata, op->cfsiz);
    ...
}

Could this non-atomic memory copy corrupt the CAN frame payload sent
to userspace?

[Severity: High]
This is a pre-existing issue, but does unregistering the handler in
bcm_delete_rx_op() properly synchronize with a concurrent bcm_rx_handler()?

If bcm_delete_rx_op() unregisters the handler and cancels timers:

net/can/bcm.c:bcm_delete_rx_op() {
    ...
    can_rx_unregister(sock_net(op->sk), NULL, op->can_id, ...);
    ...
    hrtimer_cancel(&op->thrtimer);
}

Could a concurrent bcm_rx_handler() still be executing and call
hrtimer_start(&op->thrtimer) in bcm_rx_update_and_send() after the cancel?

Since op is freed after an RCU grace period, could this re-armed timer
fire later and cause a use-after-free?

>  	/* update statistics */
> -	op->frames_abs++;
> +	bcm_update_stats(op);
> =20
>  	if (op->flags & RX_RTR_FRAME) {
>  		/* send reply for RTR-request (placed in op->frames[0]) */

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260610093422.3984=
7-1-socketcan@hartkopp.net?part=3D1

