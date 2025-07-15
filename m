Return-Path: <linux-can+bounces-3991-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DD644B05774
	for <lists+linux-can@lfdr.de>; Tue, 15 Jul 2025 12:07:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0E8823A81BF
	for <lists+linux-can@lfdr.de>; Tue, 15 Jul 2025 10:06:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF9AC271466;
	Tue, 15 Jul 2025 10:06:57 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1363226D10
	for <linux-can@vger.kernel.org>; Tue, 15 Jul 2025 10:06:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752574017; cv=none; b=TYHoNxiycZ0pZw5iXofTYDX1BwNW/1SQ9SMeHZFy0I8rVaizAv83+afyeAXuhDk1f85+OoM62GURv0b+RZfAIjPG+tcawqe8JhhaOLQpZly3QLiE4+xwuhzVD6lFhBh1dz244fVhAvVktlywXx9r1B5fzAJ2TKA1VkNqVqMujxU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752574017; c=relaxed/simple;
	bh=CAlzXY0Jwe6wQ0J2MbqAWqsi9ch0UsRNubi2rpBKObY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=b1XeVcWzyGNVyiC9TidSKP/fN5XlNXPseSY653a2u/4z0ntF57VsOzG4S8+6uG3DEEq0I8D9MPs1EWFBIuiIEavP56SJZGdpD+4+gG76U1vf0Zy+cRfw0IM9r0nPU/EpiCXKnSaR9/du5yQK/FcsfORVeplXWiNrzAjtmrZelK4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1ubcYo-0004y1-3y; Tue, 15 Jul 2025 12:06:54 +0200
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1ubcYn-008YzA-2Y;
	Tue, 15 Jul 2025 12:06:53 +0200
Received: from pengutronix.de (p5b1645f7.dip0.t-ipconnect.de [91.22.69.247])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 731A54422D5;
	Tue, 15 Jul 2025 10:06:53 +0000 (UTC)
Date: Tue, 15 Jul 2025 12:06:53 +0200
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Cc: Oliver Hartkopp <socketcan@hartkopp.net>, linux-can@vger.kernel.org
Subject: Re: [PATCH can-next/b4 2/2] dummyxl: print ctrlmode and PWM values
Message-ID: <20250715-futuristic-tricky-raptor-9f9195-mkl@pengutronix.de>
References: <20250706133550.47369-1-socketcan@hartkopp.net>
 <20250706133550.47369-2-socketcan@hartkopp.net>
 <CAMZ6RqJaYY_ZDOo-V_+4mDPZvp0WU4K=iWL44sd0_hYhMLOP_A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="wnvqpnwrjtfhq6de"
Content-Disposition: inline
In-Reply-To: <CAMZ6RqJaYY_ZDOo-V_+4mDPZvp0WU4K=iWL44sd0_hYhMLOP_A@mail.gmail.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org


--wnvqpnwrjtfhq6de
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH can-next/b4 2/2] dummyxl: print ctrlmode and PWM values
MIME-Version: 1.0

On 14.07.2025 02:25:01, Vincent Mailhol wrote:
> On Sun. 6 juil. 2025 at 22:36, Oliver Hartkopp <socketcan@hartkopp.net> w=
rote:
> > Signed-off-by: Oliver Hartkopp <socketcan@hartkopp.net>
>=20
> (...)
>=20
> > -static void dummyxl_print_config(struct net_device *dev)
> > +static void dummyxl_print_ctrlmode(struct net_device *dev)
> >  {
> >         struct dummyxl_priv *priv =3D netdev_priv(dev);
> >         struct can_priv *can_priv =3D &priv->can;
> > +       char opts[300] =3D { 0 };
> >
> >         netdev_info(dev, "CAN control mode/supported : %08X/%08X\n",
> >                     can_priv->ctrlmode, can_priv->ctrlmode_supported);
> > +
> > +       if (can_priv->ctrlmode & CAN_CTRLMODE_LOOPBACK)
> > +               strcat(opts, " loopback");
> > +
> > +       if (can_priv->ctrlmode & CAN_CTRLMODE_LISTENONLY)
> > +               strcat(opts, " listen-only");
> > +
> > +       if (can_priv->ctrlmode & CAN_CTRLMODE_3_SAMPLES)
> > +               strcat(opts, " triple-sampling");
> > +
> > +       if (can_priv->ctrlmode & CAN_CTRLMODE_ONE_SHOT)
> > +               strcat(opts, " one-shot");
> > +
> > +       if (can_priv->ctrlmode & CAN_CTRLMODE_BERR_REPORTING)
> > +               strcat(opts, " berr-reporting");
> > +
> > +       if (can_priv->ctrlmode & CAN_CTRLMODE_FD)
> > +               strcat(opts, " fd");
> > +
> > +       if (can_priv->ctrlmode & CAN_CTRLMODE_PRESUME_ACK)
> > +               strcat(opts, " presume-ack");
> > +
> > +       if (can_priv->ctrlmode & CAN_CTRLMODE_FD_NON_ISO)
> > +               strcat(opts, " fd-non-iso");
> > +
> > +       if (can_priv->ctrlmode & CAN_CTRLMODE_CC_LEN8_DLC)
> > +               strcat(opts, " cc-len8-dlc");
> > +
> > +       if (can_priv->ctrlmode & CAN_CTRLMODE_TDC_AUTO)
> > +               strcat(opts, " tdc-mode-auto");
> > +       else if (can_priv->ctrlmode & CAN_CTRLMODE_TDC_MANUAL)
> > +               strcat(opts, " tdc-mode-manual");
> > +       else
> > +               strcat(opts, " tdc-mode-off");
> > +
> > +       if (can_priv->ctrlmode & CAN_CTRLMODE_XL)
> > +               strcat(opts, " xl");
> > +
> > +       if (can_priv->ctrlmode & CAN_CTRLMODE_XL_TDC_AUTO)
> > +               strcat(opts, " xltdc-mode-auto");
> > +       else if (can_priv->ctrlmode & CAN_CTRLMODE_XL_TDC_MANUAL)
> > +               strcat(opts, " xltdc-mode-manual");
> > +       else
> > +               strcat(opts, " xltdc-mode-off");
> > +
> > +       if (can_priv->ctrlmode & CAN_CTRLMODE_XL_RRS)
> > +               strcat(opts, " xlrrs");
> > +
> > +       if (can_priv->ctrlmode & CAN_CTRLMODE_XL_TRX)
> > +               strcat(opts, " xltrx");
> > +
> > +       if (can_priv->ctrlmode & CAN_CTRLMODE_XL_ERR_SIGNAL)
> > +               strcat(opts, " xlerrsig");
>=20
> I am not a big fan of having a fixed length buffer and then doing
> several strcat() on it.

+1

> I rewrote it as below:
>=20
>   static void dummyxl_print_ctrlmode(struct net_device *dev)
>   {
>           static const char *names[] =3D {
>                   [ilog2(CAN_CTRLMODE_LOOPBACK)] =3D "loopback",
>                   [ilog2(CAN_CTRLMODE_LISTENONLY)] =3D "listen-only",
>                   [ilog2(CAN_CTRLMODE_3_SAMPLES)] =3D "triple-sampling",
>                   [ilog2(CAN_CTRLMODE_ONE_SHOT)] =3D "one-shot",
>                   [ilog2(CAN_CTRLMODE_BERR_REPORTING)] =3D "berr-reportin=
g",
>                   [ilog2(CAN_CTRLMODE_FD)] =3D "fd",
>                   [ilog2(CAN_CTRLMODE_PRESUME_ACK)] =3D "presume-ack",
>                   [ilog2(CAN_CTRLMODE_FD_NON_ISO)] =3D "fd-non-iso",
>                   [ilog2(CAN_CTRLMODE_CC_LEN8_DLC)] =3D "cc-len8-dlc",
>                   [ilog2(CAN_CTRLMODE_TDC_AUTO)] =3D "fd-tdc-auto",
>                   [ilog2(CAN_CTRLMODE_TDC_MANUAL)] =3D "fd-tdc-manual",
>                   [ilog2(CAN_CTRLMODE_XL)] =3D "xl",
>                   [ilog2(CAN_CTRLMODE_XL_TDC_AUTO)] =3D "xl-tdc-auto",
>                   [ilog2(CAN_CTRLMODE_XL_TDC_MANUAL)] =3D "xl-tdc-manual",
>                   [ilog2(CAN_CTRLMODE_XL_RRS)] =3D "xl-rrs",
>                   [ilog2(CAN_CTRLMODE_XL_TRX)] =3D "xl-trx",
>                   [ilog2(CAN_CTRLMODE_XL_ERR_SIGNAL)] =3D "xl-err-signal",
>                   [ilog2(CAN_CTRLMODE_XL_PWM)] =3D "pmw",
>           };

Is the compiler clever enough, or do you have to use const_ilog2()?

regards,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--wnvqpnwrjtfhq6de
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEn/sM2K9nqF/8FWzzDHRl3/mQkZwFAmh2KDoACgkQDHRl3/mQ
kZwLSwf/acOFmw8iyah8uk3pLhtv0E4TVcyOOUJVEfnNAKdKG155inpXCLP48r0B
vJBJGvk43fH25m1x/mVn6rIWsl/Rwsh7ZrKpqyHBPeN5UP9yJMe80cTgF2Xg+ZAR
q1oI6F1mfBgPk6iJ3XJ6tYFOqPpEhJfWoAQGGQ0ZLvggFLYKSvIdaUXQVxdb20w9
PFg4sK/KeNhkT1N/86ZAmmkd3YS7WV9mTlcOjapbfc5GJabdjHHcPNzLh8Jxx7dr
b23ptuS8jSWP9NxbZpmzZj91i+DrCq2MuXAotzxao3t0rwKJ25oK3YdHdyb2KEB6
CmAFpjJqxTXxhJywsw/KZFvceThwaA==
=CDYp
-----END PGP SIGNATURE-----

--wnvqpnwrjtfhq6de--

