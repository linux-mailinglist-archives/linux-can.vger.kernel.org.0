Return-Path: <linux-can+bounces-8441-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id NCYJENFuVmqr5QAAu9opvQ
	(envelope-from <linux-can+bounces-8441-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Tue, 14 Jul 2026 19:16:01 +0200
X-Original-To: lists+linux-can@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 88131757407
	for <lists+linux-can@lfdr.de>; Tue, 14 Jul 2026 19:16:00 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=EglhuWtV;
	spf=pass (mail.lfdr.de: domain of "linux-can+bounces-8441-lists+linux-can=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-can+bounces-8441-lists+linux-can=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7BF413041496
	for <lists+linux-can@lfdr.de>; Tue, 14 Jul 2026 17:15:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC7932848BE;
	Tue, 14 Jul 2026 17:15:51 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9708039CD1B
	for <linux-can@vger.kernel.org>; Tue, 14 Jul 2026 17:15:50 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784049351; cv=none; b=mC+fvP419WnLMXVOIhaijtvYZgQgdo0RVE1Frz7UCUsqC/dUH/ZqFmc4c2Fs7efKtHGbivmCFex/hlpKt7TGmOx6h5Szms+PXEpUop3cX+mxqsiwSBZ43xCkSKHAuLN6jfvxqcD2QlzCe9FRavunPb65m1iPeMTMidxpjdrts8s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784049351; c=relaxed/simple;
	bh=Mac9Ofmpxvw3KP2zY01yDLufpxxD/boBrGGGKltSnFE=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=HAwliMXRYh+k+x+42AOu18ISbh8gI0IiLrLLp//MuAFraCXI6MKE0xQjPl88nQiMxrYnYvSuHKgd6y9OmhCdAh/eqeb5aXgYZdJt+QHIWj5+bTrFqFyRgh+b0HIs8NhSUBC15yTO4U+/G4dZOd4h6A1aGfhgbAqXjghg4Pd2XEc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EglhuWtV; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E331C1F000E9;
	Tue, 14 Jul 2026 17:15:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784049350;
	bh=NjXn18Qvi4UrjkyJ0iI0eWMA6UGo7OF9XdLcMYnQmTM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=EglhuWtVasFlE6ZPv261GukHZ5buFkL2Rm/h50FQtJ7dxvwM24NnQ99JettjE7mw+
	 PtKh8Y9O3oGfUe3jAOZfvA2jxK5eFUbFJgFiSWAy1tyPxN6UIc99by5jwWsl3K6a1I
	 jruXKujnhr9/BikqPZ6Mx51/rhseAdHoXH01csKCKtJuqRbRfQyHB7GAjcQdqySbCv
	 E/wgHbxsU7Xg4tqmRDV3LxGDOAcpoe7RpyWvR0+v/NSedcVWLId23559xBu5Zd0g5E
	 xtMaGB3FoL9hJN1fn71baFwFnOheEnzwFSr8897KyP3A1UdysgLJXFRAeS3bNH2O7Y
	 qi17Nzk/43Oig==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v15 10/11] can: bcm: fix data race on
 rx_stamp/rx_ifindex in bcm_rx_handler()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Oliver Hartkopp" <socketcan@hartkopp.net>
Cc: "Oliver Hartkopp" <socketcan@hartkopp.net>, linux-can@vger.kernel.org, "Marc
 Kleine-Budde" <mkl@pengutronix.de>, "Oleksij Rempel" <o.rempel@pengutronix.de>, "Vincent
 Mailhol" <mailhol@kernel.org>
In-Reply-To: <20260714-bcm_fixes-v15-10-562f7e3e42da@hartkopp.net>
References: <20260714-bcm_fixes-v15-0-562f7e3e42da@hartkopp.net>
 <20260714-bcm_fixes-v15-10-562f7e3e42da@hartkopp.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 14 Jul 2026 17:15:49 +0000
Message-Id: <20260714171549.E331C1F000E9@smtp.kernel.org>
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
	TAGGED_FROM(0.00)[bounces-8441-lists,linux-can=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	REPLYTO_DN_EQ_FROM_DN(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp,sashiko.dev:url,hartkopp.net:email,lists.linux.dev:replyto,smtp.kernel.org:mid];
	FORGED_SENDER(0.00)[sashiko-bot@kernel.org,linux-can@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:socketcan@hartkopp.net,m:linux-can@vger.kernel.org,m:mkl@pengutronix.de,m:o.rempel@pengutronix.de,m:mailhol@kernel.org,s:lists@lfdr.de];
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
X-Rspamd-Queue-Id: 88131757407

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Unmatched or multiplexed frames overwrite global metadata (rx_stam=
p/rx_ifindex), corrupting subsequent throttled frame notifications.
--

--- Patch [10]: [PATCH v15 10/11] can: bcm: fix data race on rx_stamp/rx_if=
index in bcm_rx_handler() ---
commit 192a4832f1f8f3051e71e66a1a0dc3b893e46cc8
Author: Oliver Hartkopp <socketcan@hartkopp.net>
can: bcm: fix data race on rx_stamp/rx_ifindex in bcm_rx_handler()

This commit addresses a data race on op->rx_stamp and op->rx_ifindex in
bcm_rx_handler(). It moves the assignment of these fields into the same
spin_lock_bh() critical section as the content comparison, preventing torn
stores on 32-bit platforms and ensuring CAN frame metadata is correctly
bundled when processing concurrently on different CPUs.

Link: https://lore.kernel.org/linux-can/20260707145135.5BC831F00A3A@smtp.ke=
rnel.org/

> diff --git a/net/can/bcm.c b/net/can/bcm.c
> index a53dba6ab8b89..f213a0b377915 100644
> --- a/net/can/bcm.c
> +++ b/net/can/bcm.c
[ ... ]
> @@ -836,6 +831,14 @@ static void bcm_rx_handler(struct sk_buff *skb, void=
 *data)
>  			traffic_flags |=3D RX_OWN;
>  	}
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
This isn't a bug introduced by this patch, but do unmatched or multiplexed
frames overwrite global metadata here in bcm_rx_handler(), corrupting subse=
quent
throttled frame notifications?

Since the assignments to op->rx_stamp and op->rx_ifindex happen uncondition=
ally
before the multiplex filter checks, a frame that matches the CAN ID but fai=
ls
the multiplex mask check will still update the metadata.

If a previous frame matched a multiplex mask and was queued for throttle
delivery, could it be flushed to userspace with the timestamp and ifindex o=
f the
dropped frame instead?

Additionally, if an operation tracks multiple indices (nframes > 1), would
concurrently throttled frames sharing the single global op->rx_stamp inevit=
ably
overwrite each other's metadata?

>  	if (op->flags & RX_FILTER_ID) {
>  		/* the easiest case */
>  		bcm_rx_update_and_send(op, op->last_frames, rxframe,
>  				       traffic_flags);
>  		goto rx_starttimer;
>  	}
> =20
>  	if (op->nframes =3D=3D 1) {
>  		/* simple compare with index 0 */
>  		bcm_rx_cmp_to_index(op, 0, rxframe, traffic_flags);
>  		goto rx_starttimer;
>  	}
> =20
>  	if (op->nframes > 1) {
>  		/*
>  		 * multiplex compare
>  		 *
>  		 * find the first multiplex mask that fits.
>  		 * Remark: The MUX-mask is stored in index 0 - but only the
>  		 * first 64 bits of the frame data[] are relevant (CAN FD)
>  		 */
> =20
>  		for (i =3D 1; i < op->nframes; i++) {
>  			if ((get_u64(op->frames, 0) & get_u64(rxframe, 0)) =3D=3D
>  			    (get_u64(op->frames, 0) &
>  			     get_u64(op->frames + op->cfsiz * i, 0))) {
>  				bcm_rx_cmp_to_index(op, i, rxframe,
>  						    traffic_flags);
>  				break;
>  			}
>  		}
>  	}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260714-bcm_fixes-=
v15-0-562f7e3e42da@hartkopp.net?part=3D10

