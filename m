Return-Path: <linux-can+bounces-4645-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D0269B51B04
	for <lists+linux-can@lfdr.de>; Wed, 10 Sep 2025 17:11:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 991ED161B49
	for <lists+linux-can@lfdr.de>; Wed, 10 Sep 2025 15:07:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52F5C25BF18;
	Wed, 10 Sep 2025 15:07:04 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20A05329F12
	for <linux-can@vger.kernel.org>; Wed, 10 Sep 2025 15:07:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757516824; cv=none; b=arX2YdaCCpeU6PkR/gL2KQVh+f+sumJQWijfg2P7RVvyD8nPM14iUsmyJaeZKNJx4cQecLGJ8QQweKWNhnteBPa9cf1ffhhlJTjMYkeYzWaLSQNKn7GJt+LZuOUu5gusIxqY3jlbYZEFFEn0f4EEFQ5iSp7STmQWwbOWC+f8iv4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757516824; c=relaxed/simple;
	bh=FfqIu8Fsx8I4ByIEcNKic2FTWkEejbSHxbNJa71spY4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ObwnbE8RZuEkTqfK1HN348NViu8XFJq45zD2AI8/cguk3laL9NW57O1zGsqr1FosOLPqWGs5cf77ZN2MLuh9XvKllV/TuHd0275/WpBdv2UyGjuf764CSQmlwO3augHj1aIJHthvitPBl1C1SewnnrgM17p8ER34EgRWmZfB6ng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1uwMPM-0002g3-70; Wed, 10 Sep 2025 17:06:52 +0200
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1uwMPK-000bqA-2G;
	Wed, 10 Sep 2025 17:06:50 +0200
Received: from pengutronix.de (glittertind.blackshift.org [116.203.23.228])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 4361C46B0B6;
	Wed, 10 Sep 2025 15:06:50 +0000 (UTC)
Date: Wed, 10 Sep 2025 17:06:49 +0200
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Markus Schneider-Pargmann <msp@baylibre.com>
Cc: Chandrasekar Ramakrishnan <rcsekar@samsung.com>, 
	Vincent Mailhol <mailhol.vincent@wanadoo.fr>, Patrik Flykt <patrik.flykt@linux.intel.com>, 
	Dong Aisheng <b29396@freescale.com>, Varka Bhadram <varkabhadram@gmail.com>, 
	Wu Bo <wubo.oduw@gmail.com>, Philipp Zabel <p.zabel@pengutronix.de>, 
	linux-can@vger.kernel.org, linux-kernel@vger.kernel.org, kernel@pengutronix.de
Subject: Re: [PATCH v2 2/7] can: m_can: only handle active interrupts
Message-ID: <20250910-strange-hopeful-chamois-6c4b6f-mkl@pengutronix.de>
References: <20250909-m_can-fix-state-handling-v2-0-af9fa240b68a@pengutronix.de>
 <20250909-m_can-fix-state-handling-v2-2-af9fa240b68a@pengutronix.de>
 <DCOZIMAYLN8P.23PQEAFQ26ADZ@baylibre.com>
 <20250910-fair-fast-uakari-4f734e-mkl@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="esmvew3ogqa7isdp"
Content-Disposition: inline
In-Reply-To: <20250910-fair-fast-uakari-4f734e-mkl@pengutronix.de>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org


--esmvew3ogqa7isdp
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v2 2/7] can: m_can: only handle active interrupts
MIME-Version: 1.0

On 10.09.2025 16:28:54, Marc Kleine-Budde wrote:
> On 10.09.2025 10:41:28, Markus Schneider-Pargmann wrote:
> > > diff --git a/drivers/net/can/m_can/m_can.c b/drivers/net/can/m_can/m_=
can.c
> > > index fe74dbd2c966..16b38e6c3985 100644
> > > --- a/drivers/net/can/m_can/m_can.c
> > > +++ b/drivers/net/can/m_can/m_can.c
> > > @@ -1057,6 +1057,7 @@ static int m_can_poll(struct napi_struct *napi,=
 int quota)
> > >  	u32 irqstatus;
> > > =20
> > >  	irqstatus =3D cdev->irqstatus | m_can_read(cdev, M_CAN_IR);
> > > +	irqstatus &=3D cdev->active_interrupts;
> > > =20
> > >  	work_done =3D m_can_rx_handler(dev, quota, irqstatus);
> > > =20
> > > @@ -1243,6 +1244,8 @@ static int m_can_interrupt_handler(struct m_can=
_classdev *cdev)
> > >  	}
> > > =20
> > >  	m_can_coalescing_update(cdev, ir);
> > > +
> > > +	ir &=3D cdev->active_interrupts;
> >=20
> > m_can_coalescing_update() can change active_interrupts, meaning the
> > interrupt that caused the interrupt handler to run may be disabled in
> > active_interrupts above and then masked in this added line. Would that
> > still work or does it confuse the hardware?
>=20
> I think m_can_coalescing_update() expects the RX/TX will be cleared. Are
> the following comments OK...
>=20
> | diff --git a/drivers/net/can/m_can/m_can.c b/drivers/net/can/m_can/m_ca=
n.c
> | index 16b38e6c3985..8cb9cc1cddbf 100644
> | --- a/drivers/net/can/m_can/m_can.c
> | +++ b/drivers/net/can/m_can/m_can.c
> | @@ -1188,28 +1188,39 @@ static int m_can_echo_tx_event(struct net_devic=
e *dev)
> | =20
> |  static void m_can_coalescing_update(struct m_can_classdev *cdev, u32 i=
r)
> |  {
> |          u32 new_interrupts =3D cdev->active_interrupts;
> |          bool enable_rx_timer =3D false;
> |          bool enable_tx_timer =3D false;
> | =20
> |          if (!cdev->net->irq)
> |                  return;
> | =20
> | +        /* If there is a packet in the FIFO then:
> | +         * - start timer
> | +         * - disable not empty IRQ
> | +         * - handle FIFO
>                 ^^^^^^^^^^^
>=20
> ...especially this one?
>=20
> | +         */
> |          if (cdev->rx_coalesce_usecs_irq > 0 && (ir & (IR_RF0N | IR_RF0=
W))) {
> |                  enable_rx_timer =3D true;
> |                  new_interrupts &=3D ~IR_RF0N;
> |          }
> |          if (cdev->tx_coalesce_usecs_irq > 0 && (ir & (IR_TEFN | IR_TEF=
W))) {
> |                  enable_tx_timer =3D true;
> |                  new_interrupts &=3D ~IR_TEFN;
> |          }
> | +
> | +        /* If:
> | +         * - timer is not going to be start
> | +         * - and timer is not active
> | +         * -> then enable FIFO empty IRQ
> | +         */
> |          if (!enable_rx_timer && !hrtimer_active(&cdev->hrtimer))
> |                  new_interrupts |=3D IR_RF0N;
> |          if (!enable_tx_timer && !hrtimer_active(&cdev->hrtimer))
> |                  new_interrupts |=3D IR_TEFN;
> | =20
> |          m_can_interrupt_enable(cdev, new_interrupts);
> |          if (enable_rx_timer | enable_tx_timer)
> |                  hrtimer_start(&cdev->hrtimer, cdev->irq_timer_wait,
> |                                HRTIMER_MODE_REL);
> |  }

I can't reproduce the problem I had before. I will drop this patch for
now.

In an upcoming series, however, I would still like to move
can_coalescing_update() to the end of the IRQ handler.

> Currently the m_can_coalescing_update() is called at the beginning of
> the IRQ handler. Does it make sense to move it to the end and pass the
> unmasked M_CAN_IR?

Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--esmvew3ogqa7isdp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEn/sM2K9nqF/8FWzzDHRl3/mQkZwFAmjBlAQACgkQDHRl3/mQ
kZzoAQf+J7IKn8bm0QijlLnX3ALW7fQlhUOhelGc+ROH8RZsEqHRsO5XbgaKyjRz
My866Pp2W+PQAVWCftriNlvzxP+8vXjKcxRPHRZp7YOlsUwPBY0WF1OBB9cyQBWt
J7OThVT+sEtMtolsaSygmfUDuPuj1uiGS2X5goH6mJ3KGGwVc2vFBuHg11/jR6Co
PaHDF3/tbOw4ikhK4hMCc9XdvyN5t1ac9JaIYYz5uQ2M40Dk1/MVC5Xm3SDaAGbF
CH/SK46RINVaK6fpcNhm01JAK7XOASRfezunYzIbm++U16BK0eNOyJ49lA3rSNE8
+TW9jLCOHU7n89obslfvINhZ6coZ1A==
=+Cq9
-----END PGP SIGNATURE-----

--esmvew3ogqa7isdp--

