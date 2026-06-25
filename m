Return-Path: <linux-can+bounces-7901-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id UOcmGRGPPWpO4AgAu9opvQ
	(envelope-from <linux-can+bounces-7901-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Thu, 25 Jun 2026 22:26:57 +0200
X-Original-To: lists+linux-can@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 462F66C8804
	for <lists+linux-can@lfdr.de>; Thu, 25 Jun 2026 22:26:57 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=sang-engineering.com header.s=k1 header.b=d3KGj1bz;
	spf=pass (mail.lfdr.de: domain of "linux-can+bounces-7901-lists+linux-can=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="linux-can+bounces-7901-lists+linux-can=lfdr.de@vger.kernel.org";
	dmarc=none;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 78FBE3047A98
	for <lists+linux-can@lfdr.de>; Thu, 25 Jun 2026 20:26:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5959B329E7E;
	Thu, 25 Jun 2026 20:26:52 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from mail.zeus03.de (zeus03.de [194.117.254.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2381013D891
	for <linux-can@vger.kernel.org>; Thu, 25 Jun 2026 20:26:48 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782419212; cv=none; b=YQspOdtEpgX1y6zqlWsLw0iHLnQ4HQ58OmtruNaLNrnpaboUgukHCrAgHSSI8ubfLTCGVGZej4SHyb2wYx2H51Z7NJzoI/0yBOkNQSS1JcNjudKOPKkb+vADHBaBRUAUNjr1Cz/h51xDe5P24S2tsqspAw0U/iIiWH/CGz9L174=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782419212; c=relaxed/simple;
	bh=0r6z8Eb9QAh/01Ozd77nz9h3n/2EqTeSCL3Pm5JgYqg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rpVMAVJlnOQ7agKGw49Cez2GI/TmS0DXrob5yhEfHNm700SVH83N9Soy6azYjNjutvHL9YkY+EV2AJofb9GtYHQKP23min9kmYCsrCfZh17SxkEe9qxDg/rurpbupBkas5PE5rkPCvlk5SjPaDMre0cEDc8YjKwDLxkEGvpgIUM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com; spf=pass smtp.mailfrom=sang-engineering.com; dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b=d3KGj1bz; arc=none smtp.client-ip=194.117.254.33
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	sang-engineering.com; h=date:from:to:cc:subject:message-id
	:references:mime-version:content-type:in-reply-to; s=k1; bh=fa3G
	9wDDsoLZI6iQlQ3xbagRa/rnvItWFLioLtrAplI=; b=d3KGj1bzEzS5Zlm+VB0i
	8GqyKaU/JrxJAm+39ovDixHI8RUULx1qZBkiVAhj4gWem1gLhOMmonfI1UkbGs7c
	l6EqMbrdhntNnt3E/BPNnrpCxKxaw9TSTS1s+BKU208PQheqVcZPYB8lT+UY6KmM
	lLC6N3HVfUB9UDLr07/v6zIWTf3YueJ62xHmBFIOsLliJ8GdA7UqZKYlaYeZiOmU
	V1F66QduecrXHRubRbBgIp768FBcaWCiWCnnzQZNBn/HbmROVvRDrMKehlKqjUcl
	BB8NXZEpBCImTqBkD52eJ2Ug6U/X/dQQ6phik8VFFObXxOMEMFJ4rIN5opyZzS6n
	Ug==
Received: (qmail 3284849 invoked from network); 25 Jun 2026 22:26:47 +0200
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 25 Jun 2026 22:26:47 +0200
X-UD-Smtp-Session: l3s3148p1@pvqlzxlVmGdtKXMK
Date: Thu, 25 Jun 2026 22:26:46 +0200
From: Wolfram Sang <wsa+renesas@sang-engineering.com>
To: Biju <biju.das.au@gmail.com>
Cc: Marc Kleine-Budde <mkl@pengutronix.de>,
	Vincent Mailhol <mailhol@kernel.org>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Magnus Damm <magnus.damm@gmail.com>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Tu Nguyen <tu.nguyen.xg@renesas.com>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	Duy Nguyen <duy.nguyen.rh@renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	linux-can@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] can: rcar_canfd: Change the initializing flow for clocks
 and resets
Message-ID: <aj2PBvZYaVs0G-be@shikoro>
References: <20260625135216.130450-1-biju.das.jz@bp.renesas.com>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="0VzdE6JBYyEbdubs"
Content-Disposition: inline
In-Reply-To: <20260625135216.130450-1-biju.das.jz@bp.renesas.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.26 / 15.00];
	SIGNED_PGP(-2.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[sang-engineering.com:s=k1];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS(0.00)[m:biju.das.au@gmail.com,m:mkl@pengutronix.de,m:mailhol@kernel.org,m:geert+renesas@glider.be,m:magnus.damm@gmail.com,m:p.zabel@pengutronix.de,m:tu.nguyen.xg@renesas.com,m:biju.das.jz@bp.renesas.com,m:duy.nguyen.rh@renesas.com,m:prabhakar.mahadev-lad.rj@bp.renesas.com,m:linux-can@vger.kernel.org,m:linux-renesas-soc@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:bijudasau@gmail.com,m:geert@glider.be,m:magnusdamm@gmail.com,s:lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	DMARC_NA(0.00)[sang-engineering.com];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[wsa@sang-engineering.com,linux-can@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-7901-lists,linux-can=lfdr.de,renesas];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[sang-engineering.com:+];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[wsa@sang-engineering.com,linux-can@vger.kernel.org];
	FREEMAIL_CC(0.00)[pengutronix.de,kernel.org,glider.be,gmail.com,renesas.com,bp.renesas.com,vger.kernel.org];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	TAGGED_RCPT(0.00)[linux-can,renesas];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TO_DN_SOME(0.00)[]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 462F66C8804


--0VzdE6JBYyEbdubs
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Biju,

Sashiko found issues with your patch. I curated the list and left those
which I see as reasonable. I know that being pointed to pre-existing
issues is annoying, but maybe you have interest to look at these issues?

Thank you and happy hacking,

   Wolfram

> Thank you for your contribution! Sashiko AI review found 4 potential issu=
e(s) to consider:
>=20
> Pre-existing issues:
> - [High] Double-cleanup and unclocked register access on initialization f=
ailure in `rcar_canfd_probe()`.
> - [High] Premature registration of global interrupt handlers causes NULL =
pointer dereference and unclocked register access.
> - [High] Dangling pointer in the global state array leads to a double fre=
e on channel probe failure.
> - [High] Mismatch between `devm_request_irq` and manual memory freeing ca=
uses use-after-free.
> --
>=20
> commit 6b6a83169ac0a7297a4dc2c78e16dd98f4f2ed0f
> Author: Tu Nguyen <tu.nguyen.xg@renesas.com>
>=20
> can: rcar_canfd: Change the initializing flow for clocks and resets
>=20
> This patch updates the initialization order for clocks and resets in the
> rcar_canfd driver to match the hardware manual for RZ/G2L and RZ/G3E.
> It ensures clocks are enabled before deasserting resets, and updates the
> teardown path to mirror the new sequence.
>=20
> > diff --git a/drivers/net/can/rcar/rcar_canfd.c b/drivers/net/can/rcar/r=
car_canfd.c
> > index eaf8cac780387..fcc37b73ed436 100644
> > --- a/drivers/net/can/rcar/rcar_canfd.c
> > +++ b/drivers/net/can/rcar/rcar_canfd.c
> [ ... ]
> > @@ -2090,10 +2090,10 @@ static void rcar_canfd_global_deinit(struct rca=
r_canfd_global *gpriv, bool full)
> >  		rcar_canfd_set_bit(gpriv->base, RCANFD_GCTR, RCANFD_GCTR_GSLPR);
> >  	}
> > =20
> > -	clk_disable_unprepare(gpriv->clk_ram);
> > -	clk_disable_unprepare(gpriv->clkp);
> >  	reset_control_assert(gpriv->rstc2);
> >  	reset_control_assert(gpriv->rstc1);
> > +	clk_disable_unprepare(gpriv->clk_ram);
> > +	clk_disable_unprepare(gpriv->clkp);
> >  }
>=20
> [Severity: High]
> This isn't a bug introduced by this patch, but there is a pre-existing=20
> potential double-cleanup and unclocked register access on initialization=
=20
> failure.
>=20
> In rcar_canfd_probe(), if rcar_canfd_global_init() encounters an error,=
=20
> it disables the clocks and asserts the resets before returning. However,=
=20
> the probe function then jumps to the fail_mode label and unconditionally=
=20
> calls rcar_canfd_global_deinit().=20
>=20
> The deinit function calls rcar_canfd_disable_global_interrupts(), which=
=20
> writes to the hardware registers. Since the peripheral clock has already=
=20
> been disabled by the failed init, does this write trigger a synchronous=
=20
> external abort or bus fault?
>=20
> [Severity: High]
> This is a pre-existing issue, but I noticed a potential problem with=20
> interrupt registration order.
>=20
> In rcar_canfd_probe(), global interrupts are requested via=20
> devm_request_irq() before rcar_canfd_global_init() enables the clocks and=
=20
> before the per-channel structures in gpriv->ch[] are allocated.=20
>=20
> If the interrupt is shared and fires immediately, the handler=20
> rcar_canfd_global_err_interrupt() will invoke rcar_canfd_handle_global_er=
r().
> This function dereferences priv =3D gpriv->ch[ch], which is currently NUL=
L.
> Could this lead to a NULL pointer dereference, as well as an unclocked=20
> hardware read?
>=20
> [Severity: High]
> This is a pre-existing issue, but there appears to be a dangling pointer=
=20
> risk on channel probe failure.
>=20
> In rcar_canfd_channel_probe(), the channel pointer is saved globally via=
=20
> gpriv->ch[priv->channel] =3D priv. If register_candev() fails shortly aft=
er,=20
> the error path uses free_candev(ndev) to release the memory but leaves th=
e=20
> pointer in the global array.=20
>=20
> During teardown, rcar_canfd_probe() calls rcar_canfd_channel_remove() for=
=20
> all channels in the mask. Since the dangling pointer still evaluates to t=
rue,=20
> will this result in a use-after-free and double free of the memory?
>=20
> [Severity: High]
> This isn't a bug introduced by this patch, but there might be a=20
> use-after-free vulnerability with the device-managed IRQs.
>=20
> In rcar_canfd_channel_probe(), the per-channel interrupt is requested=20
> using devm_request_irq() with priv as the callback data. However,=20
> rcar_canfd_channel_remove() manually frees the channel structure using=20
> free_candev(priv->ndev).=20
>=20
> Because the devm-managed IRQ is not unregistered until the driver probe o=
r=20
> remove function completely returns, could an interrupt firing in this=20
> teardown window access the freed priv structure?
>=20
> --=20
> Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260625135216.13=
0450-1-biju.das.jz@bp.renesas.com?part=3D1

--0VzdE6JBYyEbdubs
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAmo9jwYACgkQFA3kzBSg
KbYx5RAAqEDXbQ50TaUyZDw87cwaaZ0xE0Nx3Lllr1P18E8fNjAuMDwOyb4f2zbg
P/Mij3hbImYQrlmZbBEDgE5EJctvKfHtzTftOZ/2WyOMW0KVtnbWZMFFOYca5qmw
5gZnYx4UK/r3h+64IC3ot7W4qEJiSOoulcr45wCReB2K8mArKhW2/xTVxxvm29YM
nqr5Ov9K+x8uOMzNNNuJUAsLMAg63na7CrIOpTJ1cMiCpltZukdUe3NIAGJLcuo8
TAvSwld7obKiK4gvnIIOMvEX1Fg02rye5DUeH0NOLTtEQyF5zx1/2cRzpFBhCkU5
FqlayVRW59iyFx+JT924M2qf8MlHeAI6FNX/QdxmrT28NxghWyd9hEQkyTJb627M
dHh/INSfyI1eTJV+OfJWBbqCsEmYlzYPHAzeBOsieYeOaYErPDUFDiLD6dHtuErl
rZiaKvB3FdpJlSyA5RXuf8qOxQSuUfhRJJPb20KUg7ddIqecWjJFcxqz9y2dJ2rX
LdjqIiVUXWUH1To8M284X8zo6CH4bePM8xxg/O+RRFWLBjxZmJQ23Ljrzhd8vIEs
3wMrgFp8Tm9NE68Ngs9xxyUEdpRg+Pbd22Taf9Dkkb8hNcyJNbAlk8B4MuUelYUe
sAdtTtmKm2AlIvyYidZqUsWKML21Ii28/P0lj0lSqA7BeuvhRvc=
=rlHn
-----END PGP SIGNATURE-----

--0VzdE6JBYyEbdubs--

