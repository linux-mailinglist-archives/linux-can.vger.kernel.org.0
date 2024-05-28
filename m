Return-Path: <linux-can+bounces-685-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D1C7C8D1D4E
	for <lists+linux-can@lfdr.de>; Tue, 28 May 2024 15:43:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 36085282737
	for <lists+linux-can@lfdr.de>; Tue, 28 May 2024 13:43:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0ABD16ABD5;
	Tue, 28 May 2024 13:43:53 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52B3517C7F
	for <linux-can@vger.kernel.org>; Tue, 28 May 2024 13:43:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716903833; cv=none; b=jFupJBFWsb7Bk99PCjbrhnoWuaTu1mcNWfe8cOYzjhqG1LnHkQcCU+wwZ8mpQMAsrIF+W/ifULakk5CTZgHVxMirPT0Es7CYidlvBssmhax1J/k6WdfLBoAhTmIoXNbscEtPXRUft2S4dxRDHvdhrRvakD9uBThVBpDZqPEPD60=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716903833; c=relaxed/simple;
	bh=IzhMLTVoe+JLkOeDdoPH3boHn8s9m41hRq6prvUJ9dE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oKOO36xDnLWJsMYFUgonriJePtis8HAaP5ZSugcIBimydfbarGziNwlNcMAcx66Z2RgdqdZNKUcGqjJXjxUJv7FTNy87c6tgUiBfFPH1DP7/MHG+HrkmhuU7H/uEFxX4OoJ8N/51DYlVxWaHRjuy6So+p1D7oyAK1BgRwRpbMBA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1sBx76-0002B7-W6; Tue, 28 May 2024 15:43:41 +0200
Received: from [2a0a:edc0:0:b01:1d::7b] (helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <mkl@pengutronix.de>)
	id 1sBx74-003KpZ-HM; Tue, 28 May 2024 15:43:38 +0200
Received: from pengutronix.de (unknown [172.20.34.65])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 232FB2DB98C;
	Tue, 28 May 2024 13:43:38 +0000 (UTC)
Date: Tue, 28 May 2024 15:43:37 +0200
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Markus Schneider-Pargmann <msp@baylibre.com>
Cc: Martin =?utf-8?Q?Hundeb=C3=B8ll?= <martin@geanix.com>, 
	Chandrasekar Ramakrishnan <rcsekar@samsung.com>, Vincent Mailhol <mailhol.vincent@wanadoo.fr>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, linux-can@vger.kernel.org, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] can: m_can: don't enable transceiver when probing
Message-ID: <20240528-beautiful-teal-of-attack-a6d106-mkl@pengutronix.de>
References: <20240501124204.3545056-1-martin@geanix.com>
 <rgjyty2tbqngttoicyxhntmiplihcd2xxjsqsi6r7pqrxrnumc@upt2nelsumv3>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="dw25iobgk3zzmc32"
Content-Disposition: inline
In-Reply-To: <rgjyty2tbqngttoicyxhntmiplihcd2xxjsqsi6r7pqrxrnumc@upt2nelsumv3>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org


--dw25iobgk3zzmc32
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 07.05.2024 14:29:57, Markus Schneider-Pargmann wrote:
> Hi Martin,
>=20
> On Wed, May 01, 2024 at 02:42:03PM +0200, Martin Hundeb=C3=B8ll wrote:
> > The m_can driver sets and clears the CCCR.INIT bit during probe (both
> > when testing the NON-ISO bit, and when configuring the chip). After
> > clearing the CCCR.INIT bit, the transceiver enters normal mode, where it
> > affects the CAN bus (i.e. it ACKs frames). This can cause troubles when
> > the m_can node is only used for monitoring the bus, as one cannot setup
> > listen-only mode before the device is probed.
> >=20
> > Rework the probe flow, so that the CCCR.INIT bit is only cleared when
> > upping the device. First, the tcan4x5x driver is changed to stay in
> > standby mode during/after probe. This in turn requires changes when
> > setting bits in the CCCR register, as its CSR and CSA bits are always
> > high in standby mode.
> >=20
> > Signed-off-by: Martin Hundeb=C3=B8ll <martin@geanix.com>
> > ---
> >=20
> > Changes since v1:
> >  * Implement Markus review comments:
> >    - Rename m_can_cccr_wait_bits() to m_can_cccr_update_bits()
> >    - Explicitly set CCCR_INIT bit in m_can_dev_setup()
> >    - Revert to 5 timeouts/tries to 10
> >    - Use m_can_config_{en|dis}able() in m_can_niso_supported()
> >    - Revert move of call to m_can_enable_all_interrupts()
> >    - Return -EBUSY on failure to enter normal mode
> >    - Use tcan4x5x_clear_interrupts() in tcan4x5x_can_probe()
>=20
> Thanks for addressing these.
>=20
> In general this looks good:
> Reviewed-by: Markus Schneider-Pargmann <msp@baylibre.com>
>=20
> A few small things commented below, mostly nit-picks.
> @Marc: Up to you if you want to merge it or not. I hope the review was
> early enough for your PR :)
> I don't have time to test it this week, but I can do that next week.

Martin, please address the review feedback by Markus and send a v3.

regards,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--dw25iobgk3zzmc32
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEUEC6huC2BN0pvD5fKDiiPnotvG8FAmZV34YACgkQKDiiPnot
vG8W0gf+OXBFxXnx3JnC+bhlMxgn5v7NSRKsE4GU5mE0Z5uaUZXpEjavklwP2cDg
Yirkaai/61+NRkVLn0vNlQsLTDIY3t4Q/N1edYBql44XMua3XrCGZ3071yzF/4Uo
kOE6y9DNZei1vDsCbukXwWmaynXNtrLtnOh0u2vzENPE3StE1Z6gozPmPhwgFmna
G5JcdA9Bx3765cKBx1PPCZqPeTJHJc+GVJNMUgwaAJXdGRMOn/mqu5tSFuDevANZ
vwDMQoH8jxoWGu+/ReavCS99tVcizLPilpjiZsBiPaE1Y68Awl4IUEl1gAQ7urO+
nc+sfDgheyINWOeig9Or08N22NNC9A==
=fHzh
-----END PGP SIGNATURE-----

--dw25iobgk3zzmc32--

