Return-Path: <linux-can+bounces-8096-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id Vv0uBi0mTWpYvwEAu9opvQ
	(envelope-from <linux-can+bounces-8096-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Tue, 07 Jul 2026 18:15:41 +0200
X-Original-To: lists+linux-can@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C18871DBA5
	for <lists+linux-can@lfdr.de>; Tue, 07 Jul 2026 18:15:40 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=mxeLlqQg;
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	spf=pass (mail.lfdr.de: domain of "linux-can+bounces-8096-lists+linux-can=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="linux-can+bounces-8096-lists+linux-can=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id D24E730078B3
	for <lists+linux-can@lfdr.de>; Tue,  7 Jul 2026 16:15:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC3CF4229C8;
	Tue,  7 Jul 2026 16:15:27 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88A563DDAFA;
	Tue,  7 Jul 2026 16:15:26 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783440927; cv=none; b=jMR9OhCJ/12mpVseWrX6u3GUNhSMiXPjM6HT7uYuMWGnd0T0JT7D7KG5SfVXYg846G7b9rslgtOeTGN3bPWAy3YKw9zYVimeoEIJhAXr6VPgyXwkk9XeiOxZtj2EsFucy8Rrw0yDTr8yH0sGtMBPOawbcX+0iLkGwm6mX3WdwUM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783440927; c=relaxed/simple;
	bh=Pc06K2SlUk5TraOO1/tPbU4hMOOHHM4Jhv+0aavFKpU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rydYRO0/u7wYlVc9T3B8GUsg6c12MHUmKMbVp7y37VuHoVcD4vEY3snimGaj/aU8On5/FJ3PdRdBp+2mnoyBJoo4TgMBMF+7BRXGJnECpxfz//agBtsP2PiEbLVCRlMCqYCsPIyz2zm3WmzoA9ng6vsiK9lfxQP4+cQUqChQXT0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mxeLlqQg; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52B0D1F000E9;
	Tue,  7 Jul 2026 16:15:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783440926;
	bh=F88R+S6rc7ozRNA3csjjQyY6uBLsx6oJBsOm6HnxlVI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=mxeLlqQgkUFmpcfOoqyQSFbZyVtpHEFjAMv8Nm8L+DzAf7ALh5doUFKHJjjVay6BR
	 M4/Jt4bLqGyK+6fpOiy2DIayCTAmloBFpa0p2CJccTOPcY0exHeKYeNyQaMrXG93M4
	 3P30RhjZGXrcE3ajE+HtEbsAczQqCu6cxVx/S41tKdZN67m5eAN8PoKhB5S59Wa9GR
	 e426MmpdRW13uxgfp88ucE/UOH3j71g0Jn3UqdZuEYCtdH1s7PgFlA1V4NVrXxlP25
	 TD89gMVwe9Sg1OfNWvggUjVryIZ1pSKp/i7XlsUBIxNZ+b2Pc8PR3xuBF4MeabSCzu
	 pU076qe6GVx7A==
Date: Tue, 7 Jul 2026 17:15:22 +0100
From: Conor Dooley <conor@kernel.org>
To: sashiko-reviews@lists.linux.dev
Cc: Claudiu Beznea <claudiu.beznea+renesas@tuxon.dev>,
	Marc Kleine-Budde <mkl@pengutronix.de>, robh@kernel.org,
	conor+dt@kernel.org, Oleksij Rempel <o.rempel@pengutronix.de>,
	Vincent Mailhol <mailhol@kernel.org>, linux-can@vger.kernel.org,
	devicetree@vger.kernel.org, wsa+renesas@sang-engineering.com,
	Oliver Hartkopp <socketcan@hartkopp.net>
Subject: Re: [PATCH 2/8] dt-bindings: can: renesas,rcar-canfd: Document
 RZ/G3S SoC
Message-ID: <20260707-hypnotist-portly-46b580fb922f@spud>
References: <20260707102418.1646159-1-claudiu.beznea+renesas@tuxon.dev>
 <20260707102418.1646159-3-claudiu.beznea+renesas@tuxon.dev>
 <20260707103040.021DE1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="eeSkgMZVqTITsw8c"
Content-Disposition: inline
In-Reply-To: <20260707103040.021DE1F000E9@smtp.kernel.org>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-5.26 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	SIGNED_PGP(-2.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-8096-lists,linux-can=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[conor@kernel.org,linux-can@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:sashiko-reviews@lists.linux.dev,m:claudiu.beznea+renesas@tuxon.dev,m:mkl@pengutronix.de,m:robh@kernel.org,m:conor+dt@kernel.org,m:o.rempel@pengutronix.de,m:mailhol@kernel.org,m:linux-can@vger.kernel.org,m:devicetree@vger.kernel.org,m:wsa+renesas@sang-engineering.com,m:socketcan@hartkopp.net,m:claudiu.beznea@tuxon.dev,m:conor@kernel.org,m:wsa@sang-engineering.com,s:lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[conor@kernel.org,linux-can@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCPT_COUNT_SEVEN(0.00)[11];
	TAGGED_RCPT(0.00)[linux-can,renesas,dt];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sashiko.dev:url,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,spud:mid,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 9C18871DBA5

--eeSkgMZVqTITsw8c
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 07, 2026 at 10:30:39AM +0000, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issu=
e(s) to consider:
> - [Medium] The schema fails to forbid the `renesas,no-can-fd` and `renesa=
s,fd-only` properties for the RZ/G3S (`renesas,r9a08g045-canfd`) SoC, allow=
ing unsupported hardware configurations to pass schema validation.
> --
>=20
> --- Patch [2]: [PATCH 2/8] dt-bindings: can: renesas,rcar-canfd: Document=
 RZ/G3S SoC ---
> commit fc07d92ff1acfa102fb8f08fa8b6ff1a0537c592
> Author: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
>=20
> dt-bindings: can: renesas,rcar-canfd: Document RZ/G3S SoC
>=20
> This commit documents the CAN FD controller found on the Renesas RZ/G3S S=
oC.
> It updates the bindings since the RZ/G3S provides only two channels, supp=
orts
> only CAN FD operation, and does not require assigned-clocks properties.
>=20
> > diff --git a/Documentation/devicetree/bindings/net/can/renesas,rcar-can=
fd.yaml b/Documentation/devicetree/bindings/net/can/renesas,rcar-canfd.yaml
> > index b9d9dd7a79676..f8b4d3dd54afc 100644
> > --- a/Documentation/devicetree/bindings/net/can/renesas,rcar-canfd.yaml
> > +++ b/Documentation/devicetree/bindings/net/can/renesas,rcar-canfd.yaml
>=20
> [ ... ]
>=20
> > @@ -350,6 +352,17 @@ allOf:
> >        properties:
> >          reset-names: false
> > =20
> > +  - if:
> > +      properties:
> > +        compatible:
> > +          not:
> > +            contains:
> > +              const: renesas,r9a08g045-canfd
> > +    then:
> > +      required:
> > +        - assigned-clocks
> > +        - assigned-clock-rates
> > +
>=20
> [Severity: Medium]
> Since the commit message states that the RZ/G3S supports only CAN FD oper=
ation,
> should the schema also explicitly forbid the renesas,no-can-fd and
> renesas,fd-only properties for the renesas,r9a08g045-canfd compatible?
>=20
> Without an if-then block restricting these properties to false, the schema
> will incorrectly validate device trees that specify these unsupported mod=
es.

This looks like a reasonable request.
pw-bot: changes-requested

>=20
> >  unevaluatedProperties: false
> > =20
> >  examples:
>=20
> --=20
> Sashiko AI review =B7 https://sashiko.dev/#/patchset/20260707102418.16461=
59-1-claudiu.beznea+renesas@tuxon.dev?part=3D2

--eeSkgMZVqTITsw8c
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCak0mGQAKCRB4tDGHoIJi
0smlAP9UYunv9LVF33FRMLSiU4bEBUtL6EvRW2JTroFv3tLtCAEA6h+w8g1PiuZU
ghWJyI2ucpzNdWcEz6s7IlGuVON7SQU=
=119l
-----END PGP SIGNATURE-----

--eeSkgMZVqTITsw8c--

