Return-Path: <linux-can+bounces-3518-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BBF35AA722C
	for <lists+linux-can@lfdr.de>; Fri,  2 May 2025 14:35:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 47B8B3B3873
	for <lists+linux-can@lfdr.de>; Fri,  2 May 2025 12:34:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AC46252284;
	Fri,  2 May 2025 12:34:52 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E4BF251782
	for <linux-can@vger.kernel.org>; Fri,  2 May 2025 12:34:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746189292; cv=none; b=KtJ+EiK+iypr2tcHMmrZK3VHeQGMWnH367FlIE/cCk/Dhemka8zDoryINSxqGQipyqh2EMnPRXmwrsiG6hiquXSb/edGCIO+wIZa3PAjqmngue12UZcgpjHKbWN5qNvXHeB4LdthGK0/zb1auEU3DzRC5NthYACSRqITh1wdbcg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746189292; c=relaxed/simple;
	bh=uuOu+aJmFh8t/CGTXqml2m2wi/LsBLGeddyeesWvub8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=He/0atflQIUo/k/PYSCFUBQW+oun5YjqRQ75KRX5yWxDHLCv/NyniccZMubNY2QcPfXzxDq3+W69nwNVAB8RjT+k0jbl8VI4w0z5dd71LmjIX3MeqThPdQVqoAUTp17uq3sM9OOtvjvWOnefGOKKAIgovQ1uKW+c0FLxcr6PpDA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1uApbM-0006E2-DO; Fri, 02 May 2025 14:34:48 +0200
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1uApbL-000khI-2k;
	Fri, 02 May 2025 14:34:47 +0200
Received: from pengutronix.de (p5b1645f7.dip0.t-ipconnect.de [91.22.69.247])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 81CFB4064AB;
	Fri, 02 May 2025 12:34:47 +0000 (UTC)
Date: Fri, 2 May 2025 14:34:47 +0200
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Cc: Oliver Hartkopp <socketcan@hartkopp.net>, linux-can@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] can: dev: add struct data_bittiming_params to group
 FD parameters
Message-ID: <20250502-scrupulous-sunfish-of-attack-ca0160-mkl@pengutronix.de>
References: <20250501171213.2161572-2-mailhol.vincent@wanadoo.fr>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="p3azooixii3bxc6t"
Content-Disposition: inline
In-Reply-To: <20250501171213.2161572-2-mailhol.vincent@wanadoo.fr>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org


--p3azooixii3bxc6t
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v2] can: dev: add struct data_bittiming_params to group
 FD parameters
MIME-Version: 1.0

On 02.05.2025 02:12:10, Vincent Mailhol wrote:
> This is a preparation patch for the introduction of CAN XL.
>=20
> CAN FD and CAN XL uses similar bittiming parameters. Add one level of
> nesting for all the CAN FD parameters. Typically:
>=20
>   priv->can.data_bittiming;
>=20
> becomes:
>=20
>   priv->can.fd.data_bittiming;
>=20
> This way, the CAN XL equivalent (to be introduced later) would be:
>=20
>   priv->can.xl.data_bittiming;
>=20
> Add the new struct data_bittiming_params which contains all the data
> bittiming parameters, including the TDC and the callback functions.
>=20
> This done, update all the CAN FD drivers to make use of the new
> layout.

Thanks for the series!

> Acked-by: Oliver Hartkopp <socketcan@hartkopp.net>
> Signed-off-by: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
> ---
> The CAN XL series is still blocked because of lack of information on
> the PWMS and PWML calculations, c.f.:
>=20
>   https://lore.kernel.org/linux-can/68e8c449-a6ab-4958-af3c-852ece2694c2@=
wanadoo.fr/
>=20
> Regardless, the above patch will be needed at some time. And instead
> of constantly rebasing it, I would rather have it merged early.
>=20
> The other CAN XL preparation patches target a smaller subset of the
> tree and rebasing those is not an issue.
>=20
> ** Changelog **
>=20
> v1 -> v2:
>=20
>   - add Oliver's Acked-by tag
>   - rebase on top of:
>=20
>       [PATCH v5] can: mcp251xfd: fix TDC setting for low data bit rates
>       Link: https://lore.kernel.org/linux-can/20250430161501.79370-1-kels=
ey@vpprocess.com/T/#u
>=20
>   Link: https://lore.kernel.org/linux-can/20250320144154.56611-2-mailhol.=
vincent@wanadoo.fr/

As "mcp251xfd: fix TDC setting for low data bit rates" will go through
the "can" and "net" tree, we have to wait until "net" is merged back to
"net-next".

Regards,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--p3azooixii3bxc6t
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEn/sM2K9nqF/8FWzzDHRl3/mQkZwFAmgUu+MACgkQDHRl3/mQ
kZw3DAf9EHh8b1+KqOwr/TBrHaQBO5esjx8fUF7D93qne7afbCiFKTM+570KKcFE
vmOV4k1IvW54UkydnLTVulbgsKmprw+Lgd0hLPSupI8Sd+ow8LvBT9vo3nvOvVmP
K8mb/x+LpqgGTBwyHb9ulvzGYAWsHfHRzWpmtXn+ezS8sXpNwKDKdUKh+b8Q57uO
rNPcDKqt17l0FgL0S9ppQDaUW6gzKPiJ8RD/LrNjMssHHhlOAagaNC0zxs0XYCyb
QrAlLhhMNoMBSYmn0Y5p9fHQlgTE81Ql+B0vXzsEn8GcEbihrgq/uxsVq917eR4S
nFGju7HN+Umywc5kyrPzIL514BLIXA==
=e+i5
-----END PGP SIGNATURE-----

--p3azooixii3bxc6t--

