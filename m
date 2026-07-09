Return-Path: <linux-can+bounces-8241-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id dab0CNDqT2rlqAIAu9opvQ
	(envelope-from <linux-can+bounces-8241-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Thu, 09 Jul 2026 20:39:12 +0200
X-Original-To: lists+linux-can@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8203373457A
	for <lists+linux-can@lfdr.de>; Thu, 09 Jul 2026 20:39:11 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=eG62Z3Vz;
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	spf=pass (mail.lfdr.de: domain of "linux-can+bounces-8241-lists+linux-can=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="linux-can+bounces-8241-lists+linux-can=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 8EAFC301CC47
	for <lists+linux-can@lfdr.de>; Thu,  9 Jul 2026 18:39:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99F813DCDB8;
	Thu,  9 Jul 2026 18:39:08 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E91913DDAE
	for <linux-can@vger.kernel.org>; Thu,  9 Jul 2026 18:39:07 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783622348; cv=none; b=iRury/EME6oVpR3Cq0kfcqqoW+c1qVrojkHdbCu+mHOo8MCFnn6UH601TiMySA+6fpDf0WolmCBVy9wQ28e72XghiMwgPYYwlwFAh7XSneWbSF7mMsc86zOvbSq2YQV/IbyN8OqrJ5Uk0Tm1fYkoLwYdBThfOzkCuLdz09MeuTI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783622348; c=relaxed/simple;
	bh=CVdHvaRG3kVVBcy3ug/9NxIb8SzzIVbn/jKrCXJJUt0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=tkKdsm4E67Y77EMgixfnfC1H9DUZyyfh8DX/bBDrgjzj9DjgrwG/A0sxQ/a/aKGuULdQIX0ICFSaEW90LuSwesRDvOlg1H3vilFNEFcPSlGo8yklP4lsdmwpEnzzD3rZCxwhsLVdyJX7lebzIA85RiW8OBrLuSuagqwjAepR4NY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eG62Z3Vz; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E99A31F000E9;
	Thu,  9 Jul 2026 18:39:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783622347;
	bh=0SxICYg+N9O1xe6K5wwLnNNNtyyl7H0BsRdM72K7dec=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=eG62Z3VzhT/YaDvEuMEastJZ72zegiIDquJ7DcZBTkVqn/Q2gbvEcLBGCBv1FunfR
	 YM8vdBfyvZ76/221IczcOKyNdESJvbbL9+iNY7Xfo2WNmXGPZAOTz2/8bs7y/PoLAH
	 sD+CupXgATcfUI9T7FEwrPTkw0BMj0mviR/7gRR/fulYfg/IoMHmisKUf28I4hoYrZ
	 xa/vF/rIXLI+Fo7GKxgDJhrBoWEm0E9VyLVDNJj3t+hhvtKe5sarZeVA3Pri7lasr2
	 PT97e0I6IU9gqBnRO9C996ApQ3z4lk0TmLk3zgfvnCZvY9bx7cfPqSxdlnRhXml727
	 0jd8+HXAMy7yQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v11 09/11] can: bcm: fix stale rx/tx ops after device
 removal
Reply-To: sashiko-reviews@lists.linux.dev
To: "Oliver Hartkopp" <socketcan@hartkopp.net>
Cc: "Marc Kleine-Budde" <mkl@pengutronix.de>, "Oleksij Rempel" <o.rempel@pengutronix.de>, "Oliver
 Hartkopp" <socketcan@hartkopp.net>, "Vincent Mailhol" <mailhol@kernel.org>, linux-can@vger.kernel.org
In-Reply-To: <20260709-bcm_fixes-v11-9-067ba11bec5c@hartkopp.net>
References: <20260709-bcm_fixes-v11-0-067ba11bec5c@hartkopp.net>
 <20260709-bcm_fixes-v11-9-067ba11bec5c@hartkopp.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 09 Jul 2026 18:39:06 +0000
Message-Id: <20260709183906.E99A31F000E9@smtp.kernel.org>
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
	TAGGED_FROM(0.00)[bounces-8241-lists,linux-can=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	REPLYTO_DN_EQ_FROM_DN(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,lists.linux.dev:replyto,smtp.kernel.org:mid,vger.kernel.org:from_smtp,sashiko.dev:url];
	FORGED_SENDER(0.00)[sashiko-bot@kernel.org,linux-can@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:socketcan@hartkopp.net,m:mkl@pengutronix.de,m:o.rempel@pengutronix.de,m:mailhol@kernel.org,m:linux-can@vger.kernel.org,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashiko-bot@kernel.org,linux-can@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	TAGGED_RCPT(0.00)[linux-can];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	HAS_REPLYTO(0.00)[sashiko-reviews@lists.linux.dev];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_NO_DN(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 8203373457A

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Data race on op->rx_stamp and op->rx_ifindex in bcm_rx_handler cau=
ses incorrect metadata to be delivered to userspace.
--

--- Patch [9]: [PATCH v11 09/11] can: bcm: fix stale rx/tx ops after device=
 removal ---
commit ef4eaedce01b041fb9a737217fc61cc4150a0e37
Author: Oliver Hartkopp <socketcan@hartkopp.net>

can: bcm: fix stale rx/tx ops after device removal

This commit fixes issues with stale rx and tx operations after a CAN device
is removed. It ensures rx operations are re-registered if they were torn
down by a concurrent NETDEV_UNREGISTER, and cancels the hrtimer for tx
operations to prevent runaway timers.

Link: https://lore.kernel.org/linux-can/20260708094536.DDF821F00A3A@smtp.ke=
rnel.org/
Link: https://lore.kernel.org/linux-can/20260708154039.347ED1F000E9@smtp.ke=
rnel.org/

> diff --git a/net/can/bcm.c b/net/can/bcm.c
> index 5660165cdf0eb..fbf1cbb7c99fe 100644
> --- a/net/can/bcm.c
> +++ b/net/can/bcm.c

[ ... ]

> @@ -1714,11 +1735,19 @@ static void bcm_notify(struct bcm_sock *bo, unsig=
ned long msg,
>  	case NETDEV_UNREGISTER:
>  		lock_sock(sk);
> =20
> -		/* remove device specific receive entries */
> +		/* rx_ops: remove device specific receive entries */
>  		list_for_each_entry(op, &bo->rx_ops, list)
>  			if (op->rx_reg_dev =3D=3D dev)
>  				bcm_rx_unreg(dev, op);

[Severity: High]
This is a pre-existing issue, but is there a data race on op->rx_stamp and
op->rx_ifindex in bcm_rx_handler() that causes incorrect metadata to be
delivered to userspace?

If a CAN frame matching the same ANYDEV filter is received concurrently on
different interfaces, bcm_rx_handler() can execute simultaneously on
different CPUs. Could both CPUs write to the shared op->rx_stamp and
op->rx_ifindex without holding a lock?

net/can/bcm.c:bcm_rx_handler() {
	/* save rx timestamp */
	op->rx_stamp =3D skb->tstamp;
	/* save originator for recvfrom() */
	op->rx_ifindex =3D skb->dev->ifindex;

	/* op->flags/op->frames may be updated concurrently by bcm_rx_setup() */
	spin_lock_bh(&op->bcm_rx_update_lock);
}

When CPU 1 subsequently acquires op->bcm_rx_update_lock and calls
bcm_send_to_user(), will it read the values overwritten by CPU 2?

net/can/bcm.c:bcm_send_to_user() {
	if (has_timestamp) {
		/* restore rx timestamp */
		skb->tstamp =3D op->rx_stamp;
	}

	/* ... */

	addr =3D (struct sockaddr_can *)skb->cb;
	memset(addr, 0, sizeof(*addr));
	addr->can_family  =3D AF_CAN;
	addr->can_ifindex =3D op->rx_ifindex;
}

For ANYDEV sockets, the ifindex returned in sockaddr_can is the sole source
of truth for identifying the origin bus, and delivering the wrong ifindex
can cause userspace gateway applications to misroute CAN frames.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260709-bcm_fixes-=
v11-0-067ba11bec5c@hartkopp.net?part=3D9

