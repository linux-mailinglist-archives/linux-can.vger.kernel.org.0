Return-Path: <linux-can+bounces-8147-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 42B2HUh4TmqfNQIAu9opvQ
	(envelope-from <linux-can+bounces-8147-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Wed, 08 Jul 2026 18:18:16 +0200
X-Original-To: lists+linux-can@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C7E8B728981
	for <lists+linux-can@lfdr.de>; Wed, 08 Jul 2026 18:18:15 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=fypmfYNI;
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	spf=pass (mail.lfdr.de: domain of "linux-can+bounces-8147-lists+linux-can=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-can+bounces-8147-lists+linux-can=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 545903283DF2
	for <lists+linux-can@lfdr.de>; Wed,  8 Jul 2026 15:48:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A55DA370D7D;
	Wed,  8 Jul 2026 15:48:24 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57BA5373C00
	for <linux-can@vger.kernel.org>; Wed,  8 Jul 2026 15:48:23 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783525704; cv=none; b=qkgaqIPs/KUKiiXcB0zzWmL1qV6gg+8TCvpk6sz8OJhNGbJicYj4cyA7DwZVL+VjMaAFS0RnCKGyxM3EDl4Qh5Hcla7C1GZNntjHOK6Bp2KOEp5Bm0X3124bI66U1MXSGTck/IwbEfyeZiiv1WgLGMf/GmwmjnW0lSeLSivdHyo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783525704; c=relaxed/simple;
	bh=IyWRay6bOg1aYF8WQW8h2z/kF4qR4q+nLamjDfjPcFM=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=AXHUjsF4j4BaXw58Slzjw4EBvZHhpWs7b7KAr/38ZVJZKjMTEpwu3yRZeC9/zAs3SLBGjXN3Nm2Kf+RRj+ZPcYFHwOoYfhPMbz3TNv2RxMrE13oIt9uybyAPyNuo1XyRGVlmqkOb/G/da6e0afa0wsVoNM42ApPJI2A5Top51q8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fypmfYNI; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F8F51F000E9;
	Wed,  8 Jul 2026 15:48:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783525703;
	bh=9hifNDXOXjzX/pjjHzFgyUGRIi5OxCQPzstBNRrFi4w=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=fypmfYNItK8O9htL9QFBQUQpvMqiyW1wAYU1P703vrlu9p/omDK5UszLUvcLyQ72E
	 RZO2nA8Le1o3txjh9Q4xgJNKPlHVMPA8P5OFyRr5mfsOrUliuoqyoZvXWeHXRoBywE
	 b3GyJJwRFsIGKROWDVPDwPAaAvbAijz4cOvX5KaWjpedg3+GdTMMmQosgScjO+Bhsl
	 p/6BTFxL1PcMgmR099ti1UjDrsWiY7b1ST8LE5/xq6dZ3QZ4iYxeJYmvpwUVkDG5wz
	 cxrhNBwnui9xW2tpCRtwRLlW5lsFjejMebA4uXkUfToYG3ufkUPVA5wCswLNnglOV7
	 4eyEQCfiIyltQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 10/10] can: bcm: fix data race on rx_stamp/rx_ifindex
 in bcm_rx_handler()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Oliver Hartkopp" <socketcan@hartkopp.net>
Cc: "Oliver Hartkopp" <socketcan@hartkopp.net>, "Vincent Mailhol" <mailhol@kernel.org>, "Oleksij
 Rempel" <o.rempel@pengutronix.de>, "Marc Kleine-Budde" <mkl@pengutronix.de>, linux-can@vger.kernel.org
In-Reply-To: <20260708-bcm_fixes-v7-10-c78896b342e4@hartkopp.net>
References: <20260708-bcm_fixes-v7-0-c78896b342e4@hartkopp.net>
 <20260708-bcm_fixes-v7-10-c78896b342e4@hartkopp.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 08 Jul 2026 15:48:22 +0000
Message-Id: <20260708154822.9F8F51F000E9@smtp.kernel.org>
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
	TAGGED_FROM(0.00)[bounces-8147-lists,linux-can=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	REPLYTO_DN_EQ_FROM_DN(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lists.linux.dev:replyto,sashiko.dev:url,smtp.kernel.org:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp];
	FORGED_SENDER(0.00)[sashiko-bot@kernel.org,linux-can@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:socketcan@hartkopp.net,m:mailhol@kernel.org,m:o.rempel@pengutronix.de,m:mkl@pengutronix.de,m:linux-can@vger.kernel.org,s:lists@lfdr.de];
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
X-Rspamd-Queue-Id: C7E8B728981

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Multiplexed or throttled CAN frames share a single global `rx_stam=
p` and `rx_ifindex`, which are overwritten by rejected or unrelated multipl=
ex frames, causing metadata corruption when sending throttled frames to use=
rspace.
--

--- Patch [10]: [PATCH v7 10/10] can: bcm: fix data race on rx_stamp/rx_ifi=
ndex in bcm_rx_handler() ---
commit 981b0672b1caa15044dae2fc2e2b6c5ccb8394f9
Author: Oliver Hartkopp <socketcan@hartkopp.net>

can: bcm: fix data race on rx_stamp/rx_ifindex in bcm_rx_handler()

This commit moves the updates to op->rx_stamp and op->rx_ifindex inside
the bcm_rx_update_lock section to prevent data races. It also notes that
metadata is bundled correctly when running concurrently on different CPUs
for wildcard interface subscriptions.

Link: https://lore.kernel.org/linux-can/20260707145135.5BC831F00A3A@smtp.ke=
rnel.org/

> diff --git a/net/can/bcm.c b/net/can/bcm.c
> --- a/net/can/bcm.c
> +++ b/net/can/bcm.c
[ ... ]
> @@ -805,6 +800,14 @@ static void bcm_rx_handler(struct sk_buff *skb, void=
 *data)
> =20
>  	spin_lock_bh(&op->bcm_rx_update_lock);
> =20
> +	/* save rx timestamp and originator for recvfrom() under lock.
> +	 * For an op subscribed on all interfaces (ifindex =3D=3D 0)
> +	 * bcm_rx_handler() can run concurrently on different CPUs so
> +	 * the CAN content and the meta data must be bundled correctly.
> +	 */
> +	op->rx_stamp =3D skb->tstamp;
> +	op->rx_ifindex =3D skb->dev->ifindex;
> +

[Severity: High]
This is a pre-existing issue, but by updating op->rx_stamp and
op->rx_ifindex unconditionally here before checking the multiplex mask,
are we risking metadata corruption for throttled frames?

If a valid multiplexed frame is received and throttled, its payload is
buffered. If another frame with the same CAN ID but a non-matching
multiplex ID (or on a different interface) arrives while the throttle
timer is running, we reach this code and overwrite the global op->rx_stamp
and op->rx_ifindex.

When the timer later expires, bcm_rx_thr_flush() flushes all pending
throttled MUX frames using the shared overwritten metadata:

net/can/bcm.c:bcm_rx_thr_flush() {
    ...
    for (i =3D 1; i < op->nframes; i++)
        updated +=3D bcm_rx_do_flush(op, i);
    ...
}

Which propagates to bcm_rx_changed():

net/can/bcm.c:bcm_rx_changed() {
    ...
    bcm_send_to_user(op, &head, data, 1);
    ...
}

Could this cause applications to respond on the wrong CAN bus interface if
recvfrom() returns the incorrectly overwritten ifindex?

>  	if (op->flags & RX_FILTER_ID) {
>  		/* the easiest case */
>  		bcm_rx_update_and_send(op, op->last_frames, rxframe,

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260708-bcm_fixes-=
v7-0-c78896b342e4@hartkopp.net?part=3D10

