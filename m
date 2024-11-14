Return-Path: <linux-can+bounces-2035-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C9B09C859C
	for <lists+linux-can@lfdr.de>; Thu, 14 Nov 2024 10:06:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C3C6E1F26833
	for <lists+linux-can@lfdr.de>; Thu, 14 Nov 2024 09:06:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8273329CFB;
	Thu, 14 Nov 2024 09:05:34 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA7291DE890
	for <linux-can@vger.kernel.org>; Thu, 14 Nov 2024 09:05:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731575134; cv=none; b=oiTkmZpSn5ibibrU+f9yWxtAzDpoLB1EqynRCLxB+6Rjt3M2ALEPpNInah7ksKm96AQ/KnS5sSAIPayL67iqz7O3TjmwYB4XNysLxHehTrI3RChFZRRzvX02+zAm+UhBfbySVfzn/WRJSIj96x92/gY9XUfq3jhUcMFWa+XzFEw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731575134; c=relaxed/simple;
	bh=RcaJCgb7/1s/L0gr18CUi14exJ38H4CbH2NkhEJa8ZU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZRP273RFgocRfk2f9eo6x+bs5si5iknxoHRQt9A+8TW7ahZW7Id9tAxeQo888qPiTTjHMNeORmPpj7uAzhxQCp8XaZ3lNIgPUcMhw9V3+inYuDUPzBE3+QbRKExNbUKBickh5R291+ZB2w345Iq3e4YGUjIowUz8uRKNFDR1ZJI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1tBVmw-00043D-38; Thu, 14 Nov 2024 10:05:18 +0100
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1tBVmv-000iZL-2e;
	Thu, 14 Nov 2024 10:05:17 +0100
Received: from pengutronix.de (pd9e59fec.dip0.t-ipconnect.de [217.229.159.236])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 5EABF372EE5;
	Thu, 14 Nov 2024 09:05:17 +0000 (UTC)
Date: Thu, 14 Nov 2024 10:05:17 +0100
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Cc: Sean Nyekjaer <sean@geanix.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, linux-can@vger.kernel.org, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v2 1/2] can: tcan4x5x: add option for selecting nWKRQ
 voltage
Message-ID: <20241114-rebel-peach-rhino-96357c-mkl@pengutronix.de>
References: <20241111-tcan-wkrqv-v2-0-9763519b5252@geanix.com>
 <20241111-tcan-wkrqv-v2-1-9763519b5252@geanix.com>
 <CAMZ6Rq++_yecNY-nNL7NK48ZsNPqH0KDRuqvCCGhUur24+7KGA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="ywcttwatzcumisks"
Content-Disposition: inline
In-Reply-To: <CAMZ6Rq++_yecNY-nNL7NK48ZsNPqH0KDRuqvCCGhUur24+7KGA@mail.gmail.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org


--ywcttwatzcumisks
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v2 1/2] can: tcan4x5x: add option for selecting nWKRQ
 voltage
MIME-Version: 1.0

On 14.11.2024 13:53:34, Vincent Mailhol wrote:
> On Mon. 11 Nov. 2024 at 17:55, Sean Nyekjaer <sean@geanix.com> wrote:
> > nWKRQ supports an output voltage of either the internal reference volta=
ge
> > (3.6V) or the reference voltage of the digital interface 0 - 6V.
> > Add the devicetree option ti,nwkrq-voltage-sel to be able to select
> > between them.
> > Default is kept as the internal reference voltage.
> >
> > Signed-off-by: Sean Nyekjaer <sean@geanix.com>
> > ---
> >  drivers/net/can/m_can/tcan4x5x-core.c | 35 +++++++++++++++++++++++++++=
++++++++
> >  drivers/net/can/m_can/tcan4x5x.h      |  2 ++
> >  2 files changed, 37 insertions(+)
> >
> > diff --git a/drivers/net/can/m_can/tcan4x5x-core.c b/drivers/net/can/m_=
can/tcan4x5x-core.c
> > index 2f73bf3abad889c222f15c39a3d43de1a1cf5fbb..264bba830be50033347056d=
a994102f8b614e51b 100644
> > --- a/drivers/net/can/m_can/tcan4x5x-core.c
> > +++ b/drivers/net/can/m_can/tcan4x5x-core.c
> > @@ -92,6 +92,8 @@
> >  #define TCAN4X5X_MODE_STANDBY BIT(6)
> >  #define TCAN4X5X_MODE_NORMAL BIT(7)
> >
> > +#define TCAN4X5X_NWKRQ_VOLTAGE_MASK BIT(19)
> > +
> >  #define TCAN4X5X_DISABLE_WAKE_MSK      (BIT(31) | BIT(30))
> >  #define TCAN4X5X_DISABLE_INH_MSK       BIT(9)
> >
> > @@ -267,6 +269,11 @@ static int tcan4x5x_init(struct m_can_classdev *cd=
ev)
> >         if (ret)
> >                 return ret;
> >
> > +       ret =3D regmap_update_bits(tcan4x5x->regmap, TCAN4X5X_CONFIG,
> > +                                TCAN4X5X_NWKRQ_VOLTAGE_MASK, tcan4x5x-=
>nwkrq_voltage);
> > +       if (ret)
> > +               return ret;
> > +
> >         return ret;
> >  }
> >
> > @@ -318,6 +325,28 @@ static const struct tcan4x5x_version_info
> >         return &tcan4x5x_versions[TCAN4X5X];
> >  }
> >
> > +static int tcan4x5x_get_dt_data(struct m_can_classdev *cdev)
> > +{
> > +       struct tcan4x5x_priv *tcan4x5x =3D cdev_to_priv(cdev);
> > +       struct device_node *np =3D cdev->dev->of_node;
> > +       u8 prop;
> > +       int ret;
> > +
> > +       ret =3D of_property_read_u8(np, "ti,nwkrq-voltage-sel", &prop);
> > +       if (!ret) {
> > +               if (prop <=3D 1)
> > +                       tcan4x5x->nwkrq_voltage =3D prop;
> > +               else
> > +                       dev_warn(cdev->dev,
> > +                                "nwkrq-voltage-sel have invalid option=
: %u\n",
> > +                                prop);
> > +       } else {
> > +               tcan4x5x->nwkrq_voltage =3D 0;
> > +       }
>=20
> If the
>=20
>   if (prop <=3D 1)
>=20
> condition fails, you print a warning, but you are not assigning a
> value to tcan4x5x->nwkrq_voltage. Is this intentional?
>=20
> What about:
>=20
>         tcan4x5x->nwkrq_voltage =3D 0;
>         ret =3D of_property_read_u8(np, "ti,nwkrq-voltage-sel", &prop);
>         if (!ret) {
>                 if (prop <=3D 1)
>                         tcan4x5x->nwkrq_voltage =3D prop;
>                 else
>                         dev_warn(cdev->dev,
>                                  "nwkrq-voltage-sel have invalid option: =
%u\n",
>                                  prop);
>         }
>=20
> so that you make sure that tcan4x5x->nwkrq_voltage always gets a
> default zero value? Else, if you can make sure that tcan4x5x is always
> zero initialized, you can just drop the

The tcan4x5x_priv is allocated in the netdev priv, which is initialized
with 0x0.

>=20
>         tcan4x5x->nwkrq_voltage =3D 0;
>=20
> thing.

regards,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--ywcttwatzcumisks
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEUEC6huC2BN0pvD5fKDiiPnotvG8FAmc1vUoACgkQKDiiPnot
vG/S7Af8DraKUI5aQuGcxnKxoOgQ2HpLlTRHdTWjtGvqMlXp7nVUT7GXl0TP9RZz
Ami2hOk7ZEQhdUJobeqGZMU9O8p2UdEsa7TFQc8eghtfMAEj09OO42KY7Fd6X04V
ehRp9m8gUnHgLANeEKigahu6t8uytQvv33nTyDbIdS58uyjBkAU6wHiNW2rjFeeD
gacdD2m/rlAW3ny2RiIaADV6yJZDKmgdi6wUsCZNCNF59ydFQMwnR3rCuN7b/hEe
Q18AyzXTEGqTyicoMSS+5DyIDKIKH2gW6STdPefD2d0dyV5VMaz73I9a3aAhlb42
t8bsSdE/136KDqu9zAKaIElXYTpQiQ==
=JzXk
-----END PGP SIGNATURE-----

--ywcttwatzcumisks--

