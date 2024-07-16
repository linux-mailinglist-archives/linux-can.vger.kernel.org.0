Return-Path: <linux-can+bounces-982-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7821E932F63
	for <lists+linux-can@lfdr.de>; Tue, 16 Jul 2024 19:51:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DB834B21E5E
	for <lists+linux-can@lfdr.de>; Tue, 16 Jul 2024 17:51:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E373019FA99;
	Tue, 16 Jul 2024 17:51:01 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44F3254BD4
	for <linux-can@vger.kernel.org>; Tue, 16 Jul 2024 17:51:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721152261; cv=none; b=QRB8pIsrZyHz/CXfnvnUK3Cbec/0c+pfladCweQKZwMwg1Cgk8k4IQut3yrdG1DyLFf8Kb0udwObaI6TnTZM98bdQATyRpuhBsFtxqBbiWDMIKGdx2QIq4tWKibkHpEXvPU+gudabfOfMHB4gQngDeZJXhFv1bfQ6ctXcHehxjo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721152261; c=relaxed/simple;
	bh=ic2sbABp4tHp3UGGNyn+mzu/e840S3TaNk0qjVFGVfk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=i+5tyVDOI0SqAKS5K+9ZYG3tYwrLwRFJsUwsWgCNJopdDuOxI0R/bfUX0arT0cjsgcWXsfZhBr2EQRbMlXbfpWzSpz+eEuP4xvRMtOGLaKwLjTHgjDkclk9+Q0PFja5yZrQzl6SYPZwtTa3AkDSP88SjqJji2RFcDWm/rgGdpRo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1sTmJy-0000eT-4W; Tue, 16 Jul 2024 19:50:38 +0200
Received: from [2a0a:edc0:0:b01:1d::7b] (helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <mkl@pengutronix.de>)
	id 1sTmJv-0001tg-EK; Tue, 16 Jul 2024 19:50:35 +0200
Received: from pengutronix.de (p5de45302.dip0.t-ipconnect.de [93.228.83.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 26D7D305380;
	Tue, 16 Jul 2024 14:45:36 +0000 (UTC)
Date: Tue, 16 Jul 2024 16:45:33 +0200
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Frank Li <Frank.li@nxp.com>
Cc: Vincent Mailhol <mailhol.vincent@wanadoo.fr>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, linux-can@vger.kernel.org, 
	netdev@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	haibo.chen@nxp.com, imx@lists.linux.dev, han.xu@nxp.com
Subject: Re: [PATCH v2 4/4] can: flexcan: add wakeup support for imx95
Message-ID: <20240716-chowchow-of-massive-joviality-77e833-mkl@pengutronix.de>
References: <20240715-flexcan-v2-0-2873014c595a@nxp.com>
 <20240715-flexcan-v2-4-2873014c595a@nxp.com>
 <20240716-curious-scorpion-of-glory-8265aa-mkl@pengutronix.de>
 <ZpaF4Wc70VuV4Cti@lizhi-Precision-Tower-5810>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="l2syr324jbfki6hb"
Content-Disposition: inline
In-Reply-To: <ZpaF4Wc70VuV4Cti@lizhi-Precision-Tower-5810>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org


--l2syr324jbfki6hb
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 16.07.2024 10:40:31, Frank Li wrote:
> > > @@ -2330,9 +2366,12 @@ static int __maybe_unused flexcan_noirq_resume=
(struct device *device)
> > >  	if (netif_running(dev)) {
> > >  		int err;
> > > =20
> > > -		err =3D pm_runtime_force_resume(device);
> > > -		if (err)
> > > -			return err;
> > > +		if (!(device_may_wakeup(device) &&
> >                       ^^^^^^^^^^^^^^^^^^^^^^^^
> >=20
> > Where does this come from?
>=20
> include/linux/pm_wakeup.h
>=20
> static inline bool device_may_wakeup(struct device *dev)                 =
                          =20
> {                                                                        =
                          =20
>         return dev->power.can_wakeup && !!dev->power.wakeup;             =
                          =20
> }

Sorry for the confusion. I wanted to point out, that the original driver
doesn't have the check to device_may_wakeup(). Why was this added?

> >=20
> > > +		      priv->devtype_data.quirks & FLEXCAN_QUIRK_SETUP_STOP_MODE_SC=
MI)) {
> > > +			err =3D pm_runtime_force_resume(device);
> > > +			if (err)
> > > +				return err;
> > > +		}
> > > =20
> > >  		if (device_may_wakeup(device))
> > >  			flexcan_enable_wakeup_irq(priv, false);
> > > diff --git a/drivers/net/can/flexcan/flexcan.h b/drivers/net/can/flex=
can/flexcan.h
> > > index 025c3417031f4..4933d8c7439e6 100644
> > > --- a/drivers/net/can/flexcan/flexcan.h
> > > +++ b/drivers/net/can/flexcan/flexcan.h
> > > @@ -68,6 +68,8 @@
> > >  #define FLEXCAN_QUIRK_SUPPORT_RX_MAILBOX_RTR BIT(15)
> > >  /* Device supports RX via FIFO */
> > >  #define FLEXCAN_QUIRK_SUPPORT_RX_FIFO BIT(16)
> > > +/* Setup stop mode with ATF SCMI protocol to support wakeup */
> > > +#define FLEXCAN_QUIRK_SETUP_STOP_MODE_SCMI BIT(17)
> > > =20
> > >  struct flexcan_devtype_data {
> > >  	u32 quirks;		/* quirks needed for different IP cores */

regards,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--l2syr324jbfki6hb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEUEC6huC2BN0pvD5fKDiiPnotvG8FAmaWh4sACgkQKDiiPnot
vG9pnwf+JoS4BGqt9+eauMHhwkSi1Z1OupbzhlhGwMBtIeQWPmhjM0f0/N0XDNyA
vFmZZs6HIj9lcXNADBVtKvB92MJFV4UbvGyPSqs4cU8r/cZdPr+I5j0gVHHCmtiq
RZcPzP+Jm6U6NV4C8Oj6RZxhPVCKKlNfckBW9pcjjhKg4XmEFksYC5J9G4ldofBz
DHivW/RXq2mcals9q7N2JTkgH6Zmw7wxnOWIUdFItj7Jt1XFDWQSO7ha4UC1ntmK
FgdCfR0anEHNOucDeLCyXw63FOBro/pD3iQ6xdIBCR/IVnhSIgkAjkIjFV6K5d+G
nvSKa9wCyX8iqQJuRZNp6HBTEvex/Q==
=Vri0
-----END PGP SIGNATURE-----

--l2syr324jbfki6hb--

