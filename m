Return-Path: <linux-can+bounces-81-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 243C780AA91
	for <lists+linux-can@lfdr.de>; Fri,  8 Dec 2023 18:21:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C04141F210D5
	for <lists+linux-can@lfdr.de>; Fri,  8 Dec 2023 17:21:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E99238FBB;
	Fri,  8 Dec 2023 17:20:58 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2CFD35A5
	for <linux-can@vger.kernel.org>; Fri,  8 Dec 2023 09:18:36 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1rBeU9-0006oS-Lt; Fri, 08 Dec 2023 18:17:57 +0100
Received: from [2a0a:edc0:0:b01:1d::7b] (helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <mkl@pengutronix.de>)
	id 1rBeU8-00ESyf-8k; Fri, 08 Dec 2023 18:17:56 +0100
Received: from pengutronix.de (unknown [172.20.34.65])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id CB34F25EAD8;
	Fri,  8 Dec 2023 17:17:55 +0000 (UTC)
Date: Fri, 8 Dec 2023 18:17:54 +0100
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Conor Dooley <conor@kernel.org>
Cc: linux-riscv@lists.infradead.org,
	Conor Dooley <conor.dooley@microchip.com>,
	Daire McNamara <daire.mcnamara@microchip.com>,
	Wolfgang Grandegger <wg@grandegger.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>, linux-can@vger.kernel.org,
	netdev@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org
Subject: Re: [PATCH RESEND v1 0/7] MPFS clock fixes required for correct CAN
 clock modeling
Message-ID: <20231208-atonable-cable-24ce1ceec083-mkl@pengutronix.de>
References: <20231208-reenter-ajar-b6223e5134b3@spud>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="xyc7h6dsb2frvsw2"
Content-Disposition: inline
In-Reply-To: <20231208-reenter-ajar-b6223e5134b3@spud>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org


--xyc7h6dsb2frvsw2
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 08.12.2023 17:12:22, Conor Dooley wrote:
> From: Conor Dooley <conor.dooley@microchip.com>
>=20
> Resending cos I accidentally only sent the cover letter a few minutes
> prior to this series, due to screwing up a dry run of sending.
> :clown_face:
>=20
> While reviewing a CAN clock driver internally for MPFS [1]

> 1 - Hopefully that'll show up on the lists soon, once we are happy with
>   it ourselves.

A CAN clock driver or a complete CAN driver?

Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--xyc7h6dsb2frvsw2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEDs2BvajyNKlf9TJQvlAcSiqKBOgFAmVzT78ACgkQvlAcSiqK
BOhBxQf7BYrhkxcGONNExkw5pTvSe2aLsApA8F4gr/MdexrCCcTenD7cTeiajOzK
K0oLIoWt5Gu2YpWLNf9rl6YAjTSMel/sbvSpwi5VpC0sJXtQ6snB522S7zB40dBX
DlV/YH+cIaYauSFFcCRGD/SBAKdNn24jn87i/lG4Ban1OXDZ979dRxwqZC+OXhJ+
E4noB9XsO4EalZtLDH6R3jKxTUmEgh43ic9c2v73S0tJO4P8v3bEWocQoManBJsa
09Lk42+pknYNywmrtNJnzBoJ5CAm5DojiSVBRmi0/3VTcOZDulX+1rY4+BeDFtG7
CszXgKFkjG9kv7z0kmuxK0NANfvGxw==
=7yOt
-----END PGP SIGNATURE-----

--xyc7h6dsb2frvsw2--

