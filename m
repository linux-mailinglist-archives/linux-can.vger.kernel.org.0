Return-Path: <linux-can+bounces-8164-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id JIPnCkCNTmoiPQIAu9opvQ
	(envelope-from <linux-can+bounces-8164-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Wed, 08 Jul 2026 19:47:44 +0200
X-Original-To: lists+linux-can@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 706FD729528
	for <lists+linux-can@lfdr.de>; Wed, 08 Jul 2026 19:47:43 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=bAi90miA;
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	spf=pass (mail.lfdr.de: domain of "linux-can+bounces-8164-lists+linux-can=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-can+bounces-8164-lists+linux-can=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3268E300F11A
	for <lists+linux-can@lfdr.de>; Wed,  8 Jul 2026 17:47:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 621F837C933;
	Wed,  8 Jul 2026 17:47:41 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BD3A72630
	for <linux-can@vger.kernel.org>; Wed,  8 Jul 2026 17:47:39 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783532861; cv=none; b=C6IqdozrBgQBGIFCiXaY1tK7jP9A/quanKlu4lc8Oa0DO+xfl5l+mmoy7hEvBgGoOALySR+kjO4ZtyJJ7bXqHK/j9vRxEEDNwT97r3ogwMyIufnXqbaq+j9siaLQxHko4IuVJjHd3Xjq63njlFJgcFZw1TspkHK3aXChzCilG8g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783532861; c=relaxed/simple;
	bh=nj9Q6n8JV1x10KM5LoEYcL9864FxJPaaDhORjKqEUFI=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=kg211biU3b1U+6vUmu0iz75ykfY5FSVNXGaz4s2wfFnaZQZKDLOKZX8wfeZ8ItloPLc/eDGivWxFubR+VJRSomPXP6tPzAaeAs5IHcvoR8ngE1iYvK/I29Nv2pUF0cz7ZQ0MBaLOdfbWG6r6/PsRALGlQBQRVE6PdOy+gTI/yoU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bAi90miA; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E1111F000E9;
	Wed,  8 Jul 2026 17:47:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783532859;
	bh=1R19t2YAzdghZMNdzPebTUzxHYBWFcshIND05hdihMM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=bAi90miAGYZKfGWc1Ac8TB059SHrUvRhf5FJhZzQtSBKBeMuoN+Pjf/vScbQRfd7E
	 x3Qzkp4VrgJ9hRx+UERInIwWQk6Ivy2kpSKafiU4MwuwcjH0vSx52OzkcRTB13SDOo
	 137fmnmvcw89TPVLfcS3U70NBsOV2sROwLoDlhPNyuWgCFYLgE1QZHi7qk83pUZ5ib
	 6srB4304neT9v1ydpsa0ivTR8vMWRAEJFn2k4KRkw6hCL/qt7wyHq1VqB6VQszzxFG
	 mRQ5vLhB505a7UJCEZQk/zu7KM/aHa1lNXzqyWZd7SJQ66iPVIsYx6cTTyyWkX9JgR
	 StSuHuzvitZkA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v8 10/10] can: bcm: fix data race on rx_stamp/rx_ifindex
 in bcm_rx_handler()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Oliver Hartkopp" <socketcan@hartkopp.net>
Cc: linux-can@vger.kernel.org, "Oleksij Rempel" <o.rempel@pengutronix.de>, "Vincent
 Mailhol" <mailhol@kernel.org>, "Marc Kleine-Budde" <mkl@pengutronix.de>, "Oliver
 Hartkopp" <socketcan@hartkopp.net>
In-Reply-To: <20260708-bcm_fixes-v8-10-8c2f5f3bc212@hartkopp.net>
References: <20260708-bcm_fixes-v8-0-8c2f5f3bc212@hartkopp.net>
 <20260708-bcm_fixes-v8-10-8c2f5f3bc212@hartkopp.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 08 Jul 2026 17:47:39 +0000
Message-Id: <20260708174739.7E1111F000E9@smtp.kernel.org>
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
	TAGGED_FROM(0.00)[bounces-8164-lists,linux-can=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	REPLYTO_DN_EQ_FROM_DN(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,sashiko.dev:url,lists.linux.dev:replyto,smtp.kernel.org:mid,vger.kernel.org:from_smtp,hartkopp.net:email];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_NO_DN(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	HAS_REPLYTO(0.00)[sashiko-reviews@lists.linux.dev]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 706FD729528

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] This problem wasn't introduced by this patch, but the patch fails =
to fully resolve the issue it claims to fix: Metadata mismatch for delayed/=
throttled CAN frames. `op->rx_stamp` and `op->rx_ifindex` are overwritten b=
y subsequent frames, causing delayed frames to be delivered with incorrect =
timestamps and originator ifindexes.
--

--- Patch [10]: [PATCH v8 10/10] can: bcm: fix data race on rx_stamp/rx_ifi=
ndex in bcm_rx_handler() ---
commit 1903094034673eeaf05aa58b49f4d0ff45d06795
Author: Oliver Hartkopp <socketcan@hartkopp.net>

can: bcm: fix data race on rx_stamp/rx_ifindex in bcm_rx_handler()

This commit addresses data races and torn stores on rx_stamp and rx_ifindex
by moving their assignment inside the bcm_rx_update_lock section in
bcm_rx_handler(). It ensures CAN content and metadata are bundled correctly.

Link: https://lore.kernel.org/linux-can/20260707145135.5BC831F00A3A@smtp.ke=
rnel.org/

> diff --git a/net/can/bcm.c b/net/can/bcm.c
> index 66dd8789843b5..1986d33a7d279 100644
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

[Severity: High]
This isn't a bug introduced by this patch, but does this fully resolve the
metadata mismatch for delayed or throttled CAN frames?

Since op->rx_stamp and op->rx_ifindex are unconditionally updated here, will
they overwrite the metadata corresponding to pending throttled frames?

If an application configures a BCM socket with a throttle timer (kt_ival2 >=
 0)
and a frame is marked for delayed delivery, a subsequent frame arriving bef=
ore
the timer expires will overwrite this global metadata.

When the timer expires and the delayed frame is eventually flushed to user
space via bcm_send_to_user(), it will be sent with the clobbered
op->rx_ifindex rather than the interface it originally arrived on. Could th=
is
lead to the user application receiving an incorrect source interface and
potentially responding on the wrong CAN bus?

> +
>  	if (op->flags & RX_FILTER_ID) {
>  		/* the easiest case */
>  		bcm_rx_update_and_send(op, op->last_frames, rxframe,

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260708-bcm_fixes-=
v8-0-8c2f5f3bc212@hartkopp.net?part=3D10

