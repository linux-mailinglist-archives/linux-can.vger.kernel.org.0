Return-Path: <linux-can+bounces-2084-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 660C39D0B48
	for <lists+linux-can@lfdr.de>; Mon, 18 Nov 2024 09:57:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 35A1B2826FC
	for <lists+linux-can@lfdr.de>; Mon, 18 Nov 2024 08:57:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF34615B0F2;
	Mon, 18 Nov 2024 08:57:36 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2377C14AD0D
	for <linux-can@vger.kernel.org>; Mon, 18 Nov 2024 08:57:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731920256; cv=none; b=DG0HVpYnjpis6ekMi43Pie7rS650WTfP0aZrGiu8mxxheOHqxb4CmzOBkwwgdSKonNj8nmLcMcu/MwTi1fEVvXmpfwu2gBMfrXwbG7r6jDntpxY0C/rMxP7TdqE8pAIqJCLYi09Fj7/DAbBqubP8iGzPn5u5yveui87AAoxZpsw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731920256; c=relaxed/simple;
	bh=0vBV+gglBJcq43hd4gwjepgs9kZH2MZOYIFZvQPfUtM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=P2hmOT+HTuJhExIpoEQ0hzwgA41STxlS/RbIUtirDF7yoaa0ZBB5L0iefCUzM1RmGX6kRFcTXallPjFpNqJF+NM5Nc+AmyCBH5SQNagY8239GOUvKRMwsNspCRQXy7s7vM8AYnBEoVe1PmAoggX61D4QwN6OUXkqOhH5GCz7w8Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1tCxZZ-0001PE-OZ; Mon, 18 Nov 2024 09:57:29 +0100
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1tCxZW-001MYd-0w;
	Mon, 18 Nov 2024 09:57:26 +0100
Received: from pengutronix.de (pd9e59fec.dip0.t-ipconnect.de [217.229.159.236])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 9F7BF374FEF;
	Mon, 18 Nov 2024 08:50:24 +0000 (UTC)
Date: Mon, 18 Nov 2024 09:50:24 +0100
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Oliver Hartkopp <socketcan@hartkopp.net>
Cc: Dario Binacchi <dario.binacchi@amarulasolutions.com>, 
	Vincent Mailhol <mailhol.vincent@wanadoo.fr>, linux-amarula@amarulasolutions.com, 
	Andrew Lunn <andrew+netdev@lunn.ch>, Eric Dumazet <edumazet@google.com>, 
	"Ji-Ze Hong (Peter Hong)" <peter_hong@fintek.com.tw>, linux-can@vger.kernel.org
Subject: Re: [PATCH 7/7] can: f81604: fix {rx,tx}_errors statistics
Message-ID: <20241118-versatile-pastel-bittern-92fb0c-mkl@pengutronix.de>
References: <20241116180301.3935879-1-dario.binacchi@amarulasolutions.com>
 <20241116180301.3935879-8-dario.binacchi@amarulasolutions.com>
 <9d43985d-fc25-4f51-b339-d5dcd33b666d@hartkopp.net>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="7nmb2oadjsa73omu"
Content-Disposition: inline
In-Reply-To: <9d43985d-fc25-4f51-b339-d5dcd33b666d@hartkopp.net>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org


--7nmb2oadjsa73omu
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH 7/7] can: f81604: fix {rx,tx}_errors statistics
MIME-Version: 1.0

On 18.11.2024 09:39:27, Oliver Hartkopp wrote:
> -netdev ML
>=20
> Hello Dario,
>=20
> thanks for taking a look on the error statistics.
>=20
> As an example for my following remark I picked this patch.
>=20
> On 16.11.24 19:02, Dario Binacchi wrote:
> > The f81604_handle_can_bus_errors() function only incremented the receive
> > error counter and never the transmit error counter, even if the ECC_DIR
> > flag reported that an error had occurred during transmission. The patch
> > increments the receive/transmit error counter based on the value of the
> > ECC_DIR flag.

"Increment" the receive/transmit error counter instead of "The patch
increments".

> >=20
> > Fixes: 88da17436973 ("can: usb: f81604: add Fintek F81604 support")
> > Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>
> >=20
> > ---
> >=20
> >   drivers/net/can/usb/f81604.c | 7 +++++--
> >   1 file changed, 5 insertions(+), 2 deletions(-)
> >=20
> > diff --git a/drivers/net/can/usb/f81604.c b/drivers/net/can/usb/f81604.c
> > index bc0c8903fe77..8463e00517c9 100644
> > --- a/drivers/net/can/usb/f81604.c
> > +++ b/drivers/net/can/usb/f81604.c
> > @@ -526,7 +526,6 @@ static void f81604_handle_can_bus_errors(struct f81=
604_port_priv *priv,
> >   		netdev_dbg(netdev, "bus error interrupt\n");
> >   		priv->can.can_stats.bus_error++;
> > -		stats->rx_errors++;
> >   		if (skb) {
>=20
> The statistics are updated only if we successfully allocated a skbuff for
> the error message frame.
>=20
> >   			cf->can_id |=3D CAN_ERR_PROT | CAN_ERR_BUSERROR;
> > @@ -550,8 +549,12 @@ static void f81604_handle_can_bus_errors(struct f8=
1604_port_priv *priv,
> >   			cf->data[3] =3D data->ecc & F81604_SJA1000_ECC_SEG;
> >   			/* Error occurred during transmission? */
> > -			if ((data->ecc & F81604_SJA1000_ECC_DIR) =3D=3D 0)
> > +			if ((data->ecc & F81604_SJA1000_ECC_DIR) =3D=3D 0) {
> >   				cf->data[2] |=3D CAN_ERR_PROT_TX;
> > +				stats->tx_errors++;
> > +			} else {
> > +				stats->rx_errors++;
> > +			}
> >   		}
> >   		set_bit(F81604_CLEAR_ECC, &priv->clear_flags);
>=20
> Is this a good approach or should we always update the statistics
> independently of the potential failure of the skbuff allocation?

Yes, we always want to update the statistics. If the error skb
allocation fails due to OOM, we want at least accurate statistics.

regards,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--7nmb2oadjsa73omu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEUEC6huC2BN0pvD5fKDiiPnotvG8FAmc6/80ACgkQKDiiPnot
vG+2VggAiyPJeGlQqH2Jl1YFJ+SxCNy7pcQgGSbnS5AlRixS+XKCyaG8HI1sOjov
PTtgQIdXHQtvEfVw8fL7gWth9A4G+0Bcuw3RG/kZVURjTudH4eBioQQGvam137HW
frsOsksctjUgBiUuwM8Gyx66/A0vPOgf9kmUEyWNviMoSxQZsFLtFqPmkJKQ4TkX
JsVsKS1FYCMXzNHvHedaPNmThvPmFQQRRfdUmkHRyALcZK1I8lK+Ns34HG+3rDO5
UQKGx2UqMIT2f1B0N/2wZ4G5P2U1SJzpruSBUBS41bccmVAXLbvTembWTuBANdJd
WE+ITxblREWwOZElQiQvsrZHtzlZtw==
=nFnh
-----END PGP SIGNATURE-----

--7nmb2oadjsa73omu--

