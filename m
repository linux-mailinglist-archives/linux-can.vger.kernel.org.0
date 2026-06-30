Return-Path: <linux-can+bounces-7922-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id wKMRIOXOQ2pgiwoAu9opvQ
	(envelope-from <linux-can+bounces-7922-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Tue, 30 Jun 2026 16:12:53 +0200
X-Original-To: lists+linux-can@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D2FC56E546C
	for <lists+linux-can@lfdr.de>; Tue, 30 Jun 2026 16:12:52 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b="ay/PxSw/";
	spf=pass (mail.lfdr.de: domain of "linux-can+bounces-7922-lists+linux-can=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-can+bounces-7922-lists+linux-can=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CD28E3145C85
	for <lists+linux-can@lfdr.de>; Tue, 30 Jun 2026 14:05:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63FCB32C957;
	Tue, 30 Jun 2026 14:05:27 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B08F377010
	for <linux-can@vger.kernel.org>; Tue, 30 Jun 2026 14:05:26 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782828327; cv=none; b=IPzHbJcKReKlJJpqamHnoxrrA4JjzUN/SM+sqpTTkBdDeGIbTg33ucvyOgEhNezMrB69IoZ/apyPwKKN8ftko8uRUSsRqNFMRByTjdm8xR/1daUbdGT7NhtmBfGSwPWnjKBJZK/XpBOR5pUX/Nw1Y9b7sgzU0c8TCWZ/mbQDRSA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782828327; c=relaxed/simple;
	bh=KV8WfcvlZYfcRxwiyjivdgMtS5ehIE3oRk/KFd8IF3Q=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=p2ZryA0ILNoeOUiGeDgzqm8cL/P0j6Qg7gGtkMdZif4xzLZogcbWjHQN2+1r6Q2OQQyr4PKYwS5MrG4rGoF+96Dld9NPWnhbprtzMK4OFEV1FnUYTr0Do5MWsPaDDZqNDYdAY2XflJ3opLSimHjlV6XPeUjAwfpJAOIZEqTSEmo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ay/PxSw/; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8FBF11F00A3A;
	Tue, 30 Jun 2026 14:05:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782828326;
	bh=4lWCc69qWNXRnm9zEHJiTITZmF767kCd5e9rs3UOo2I=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ay/PxSw//biXfxjbXYHqu0/dYk0R3V4+LoY2kdSeJpFtmhq6nBFD9XGjdPfGqRAOv
	 5Yc8A6D7JUlBHlhtYaXasYyYUZ7u0VG/k35wDLH2ZGeiXQhuQuM8E/SeqTW39DB71r
	 r8OWuOSxLcS6tM549pekMnwQy2KX+ViXlyCw078igzmRQbza+Q7mo191Ps/mxtGdjw
	 aYPwwOwGGYha2VJm9dvit7WGMCppZ3p0zjnfrlYc8idtDjQ3trOqxC9Mk2XxbZdbte
	 MgZb7p/Sk8/gSj37ve/37QW9aw/5KiRapwB6SQl8bNhy6UEVWpjfxHVWtjc3ngqd5B
	 eLJ9QNSCAhI1A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 3/3] can: rcar_canfd: Fix interrupt registration order
Reply-To: sashiko-reviews@lists.linux.dev
To: Biju <biju.das.au@gmail.com>
Cc: "Oliver Hartkopp" <socketcan@hartkopp.net>, "Oleksij Rempel" <o.rempel@pengutronix.de>, "Marc
 Kleine-Budde" <mkl@pengutronix.de>, wsa+renesas@sang-engineering.com, "Vincent
 Mailhol" <mailhol@kernel.org>, linux-can@vger.kernel.org
In-Reply-To: <20260630135119.104774-4-biju.das.jz@bp.renesas.com>
References: <20260630135119.104774-1-biju.das.jz@bp.renesas.com>
 <20260630135119.104774-4-biju.das.jz@bp.renesas.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 30 Jun 2026 14:05:24 +0000
Message-Id: <20260630140525.8FBF11F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	MISSING_MIME_VERSION(2.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	REPLYTO_DN_EQ_FROM_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-7922-lists,linux-can=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:biju.das.au@gmail.com,m:socketcan@hartkopp.net,m:o.rempel@pengutronix.de,m:mkl@pengutronix.de,m:wsa+renesas@sang-engineering.com,m:mailhol@kernel.org,m:linux-can@vger.kernel.org,m:bijudasau@gmail.com,m:wsa@sang-engineering.com,s:lists@lfdr.de];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[sashiko-bot@kernel.org,linux-can@vger.kernel.org];
	FROM_NEQ_ENVFROM(0.00)[sashiko-bot@kernel.org,linux-can@vger.kernel.org];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCPT_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[linux-can,renesas];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_NO_DN(0.00)[];
	HAS_REPLYTO(0.00)[sashiko-reviews@lists.linux.dev];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sashiko.dev:url,lists.linux.dev:replyto,renesas.com:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,smtp.kernel.org:mid,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: D2FC56E546C

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:

New issues:
- [High] Premature UAPI exposure causes unhandled hardware interrupts (IRQ =
storm).

Pre-existing issues:
- [High] Use-After-Free in global interrupt handlers during driver removal =
and error paths.
- [High] NULL pointer dereference due to early channel IRQ registration.
--

commit a0e1233eee22a1c4cd2d28a4473c39b527927759
Author: Biju Das <biju.das.jz@bp.renesas.com>

can: rcar_canfd: Fix interrupt registration order

In rcar_canfd_probe(), global interrupts are requested via
devm_request_irq() before rcar_canfd_global_init() enables the clocks
and before the per-channel structures in gpriv->ch[] are allocated.

> diff --git a/drivers/net/can/rcar/rcar_canfd.c b/drivers/net/can/rcar/rca=
r_canfd.c
> index 1f3dc4b354f87..48f624c1eda9a 100644
> --- a/drivers/net/can/rcar/rcar_canfd.c
> +++ b/drivers/net/can/rcar/rcar_canfd.c
> @@ -2216,6 +2216,17 @@ static int rcar_canfd_probe(struct platform_device=
 *pdev)
>  	gpriv->base =3D addr;
>  	gpriv->fcbase =3D addr + gpriv->info->regs->coffset;
> =20
> +	err =3D rcar_canfd_global_init(gpriv);
> +	if (err)
> +		goto fail_dev;
> +
> +	for_each_set_bit(ch, &gpriv->channels_mask, info->max_channels) {
> +		err =3D rcar_canfd_channel_probe(gpriv, ch, fcan_freq,
> +					       transceivers[ch]);

[Severity: High]
Does moving rcar_canfd_channel_probe() before the global interrupt
registration expose the device to userspace prematurely?

rcar_canfd_channel_probe() calls register_candev(), which makes the network
device visible. If a userspace daemon immediately brings the interface up, =
it
can transition to operational mode and receive CAN frames, asserting the
global receive interrupt before devm_request_irq() has registered the global
handler.

Could this lead to an unhandled hardware interrupt storm that permanently
disables the CAN interrupt line?

[Severity: High]
This is a pre-existing issue, but does rcar_canfd_channel_probe() suffer
from the exact same early interrupt registration bug being fixed here?

Inside rcar_canfd_channel_probe(), when multi_channel_irqs is enabled,
devm_request_irq() is called for the channel error interrupt before the
channel pointer is stored:

drivers/net/can/rcar/rcar_canfd.c:rcar_canfd_channel_probe() {
    ...
    err =3D devm_request_irq(dev, err_irq, rcar_canfd_channel_err_interrupt,
                           ...);
    ...
    gpriv->ch[priv->channel] =3D priv;
}

If a pending interrupt fires immediately, the handler calls
rcar_canfd_handle_channel_err(), which dereferences gpriv->ch[ch].

Since gpriv->ch[ch] is still NULL, will this result in a kernel panic?

> +		if (err)
> +			goto fail_channel;
> +	}
> +
>  	/* Request IRQ that's common for both channels */
>  	if (info->shared_global_irqs) {
>  		err =3D devm_request_irq(dev, ch_irq,
> @@ -2224,7 +2235,7 @@ static int rcar_canfd_probe(struct platform_device =
*pdev)
>  		if (err) {
>  			dev_err(dev, "devm_request_irq %d failed: %pe\n",
>  				ch_irq, ERR_PTR(err));
> -			goto fail_dev;
> +			goto fail_channel;

[Severity: High]
This is a pre-existing issue, but does the fail_channel error path have a
use-after-free race condition?

When tearing down the channels, rcar_canfd_channel_remove() calls
free_candev() but does not clear the gpriv->ch[ch] pointer:

drivers/net/can/rcar/rcar_canfd.c:rcar_canfd_channel_remove() {
    ...
    free_candev(priv->ndev);
    // gpriv->ch[ch] is left dangling
}

Since global interrupts remain enabled until rcar_canfd_global_deinit() runs
after the channel loop, if a global receive interrupt fires for an active
channel, the handler rcar_canfd_global_receive_fifo_interrupt() will iterate
over all channels and dereference the dangling gpriv->ch[ch] pointer.

Can this cause a kernel crash if CAN traffic is present during the error
path or driver removal?

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260630135119.1047=
74-1-biju.das.jz@bp.renesas.com?part=3D3

