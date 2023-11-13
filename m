Return-Path: <linux-can+bounces-14-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 35A6B7E9D28
	for <lists+linux-can@lfdr.de>; Mon, 13 Nov 2023 14:30:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B11F4B208CB
	for <lists+linux-can@lfdr.de>; Mon, 13 Nov 2023 13:30:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECDFF200CD;
	Mon, 13 Nov 2023 13:30:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-can@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C587200BF
	for <linux-can@vger.kernel.org>; Mon, 13 Nov 2023 13:30:34 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6E7CD7E
	for <linux-can@vger.kernel.org>; Mon, 13 Nov 2023 05:30:30 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1r2X14-00042D-9d; Mon, 13 Nov 2023 14:30:14 +0100
Received: from [2a0a:edc0:0:b01:1d::7b] (helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <mkl@pengutronix.de>)
	id 1r2X12-008kZa-Ex; Mon, 13 Nov 2023 14:30:12 +0100
Received: from pengutronix.de (unknown [172.20.34.65])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 115B124B7DC;
	Mon, 13 Nov 2023 13:30:12 +0000 (UTC)
Date: Mon, 13 Nov 2023 14:30:11 +0100
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Martin =?utf-8?Q?Hundeb=C3=B8ll?= <martin@geanix.com>
Cc: Markus Schneider-Pargmann <msp@baylibre.com>,
	Chandrasekar Ramakrishnan <rcsekar@samsung.com>,
	Wolfgang Grandegger <wg@grandegger.com>,
	Vincent MAILHOL <mailhol.vincent@wanadoo.fr>,
	Simon Horman <simon.horman@corigine.com>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	linux-can@vger.kernel.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, Julien Panis <jpanis@baylibre.com>,
	Judith Mendez <jm@ti.com>
Subject: Re: [PATCH v6 00/14] can: m_can: Optimizations for m_can/tcan part 2
Message-ID: <20231113-mastiff-confetti-955bda37a458-mkl@pengutronix.de>
References: <20230929141304.3934380-1-msp@baylibre.com>
 <0c14d3d4372a29a9733c83af4c4254d5dfaf17c2.camel@geanix.com>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="ltv4sn6fykivt4dn"
Content-Disposition: inline
In-Reply-To: <0c14d3d4372a29a9733c83af4c4254d5dfaf17c2.camel@geanix.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org


--ltv4sn6fykivt4dn
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 13.11.2023 14:25:37, Martin Hundeb=C3=B8ll wrote:
> On Fri, 2023-09-29 at 16:12 +0200, Markus Schneider-Pargmann wrote:
> > Hi Marc, Simon, Martin and everyone,
> >=20
> > v6 is a rebase on v6.6. As there was a conflicting change merged for
> > v6.6 which introduced irq polling, I had to modify the patches that
> > touch the hrtimer.
> >=20
> > @Simon: I removed a couple of your reviewed-by tags because of the
> > changes.
> >=20
> > @Martin: as the functionality changed, I did not apply your Tested-by
> > tag as I may have introduced new bugs with the changes.
> >=20
> > The series implements many small and bigger throughput improvements
> > and
> > adds rx/tx coalescing at the end.
> >=20
> > Based on v6.6-rc2. Also available at
> > https://gitlab.baylibre.com/msp8/linux/-/tree/topic/mcan-optimization/v=
6.6?ref_type=3Dheads
>=20
> For the whole series:
> Tested-by: Martin Hundeb=C3=B8ll <martin@geanix.com>

On which hardware? On an mmio mapped m_can or the tcan4x5x?

Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--ltv4sn6fykivt4dn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEDs2BvajyNKlf9TJQvlAcSiqKBOgFAmVSJOAACgkQvlAcSiqK
BOgMLwf/fMwdMSII3RkS4eHnUFAhQ9qmXwNx+2h7M8cmFhx7wY+5N8whN6GJw8lu
aNDZ0cHXjKErd53GkXfLWwVojBAxuzfj4SYgW9oJGCpbJ4kudXK3XqZWQfqNQxY9
jdaLg0bPbXUY45VYZKHzTvUdyzFF5DW6ErY4Vc+AGqWp6g7h5ssjxcqAVPQsU9eF
Q+L/44D6auw9BmljR90mXVKPxx+TuTt1xCnDpqWPEtqvIcVUXrP6LBxhqFa6WxPH
x+Ue1xHfIMQa48LRqVmIypEeQVTfyToQHUpg2xmAl8F7YJiP4gW76VLD7FYXzo5k
Iwcgh3D3r/Hu6i+spguZGlV9Koeg0A==
=O2Cr
-----END PGP SIGNATURE-----

--ltv4sn6fykivt4dn--

