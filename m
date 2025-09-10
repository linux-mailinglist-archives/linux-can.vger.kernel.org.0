Return-Path: <linux-can+bounces-4642-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CAD1B5195F
	for <lists+linux-can@lfdr.de>; Wed, 10 Sep 2025 16:30:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 802175E4D40
	for <lists+linux-can@lfdr.de>; Wed, 10 Sep 2025 14:29:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6E5332C31C;
	Wed, 10 Sep 2025 14:29:09 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0DE1324B33
	for <linux-can@vger.kernel.org>; Wed, 10 Sep 2025 14:29:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757514549; cv=none; b=JsGQ8wLGy3oY4VzSYK/hd6MGxQ9eFBaKeHzz3GEoMJk4MUqCIr+BbKwy0nEqC1wDnKP+INu4Qjz88Rq7SNhAlyTRx38lpz2UtXv8OLGJKXgR2DgA3/h5Y4nHIC2ep2Hx1810rFABl9MB68ui+iaQHPz4JwuzpxtlJdM+Y69omxI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757514549; c=relaxed/simple;
	bh=tjPh7yRuiVV5BO0Fhe782vzx9mpCYkeYvw8450XbWnQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lozI2OUZKWg2QHMbmDEroFUK1Dqaw/JQAqTo417QI7kTiRopB7OcqhTkoltNqCecG3IeOyqOljCk9N1DxI5IZUtf8csqFEpxs7kClIq0rluaMeIa9jS1gjNATtmOpdcFBO1GfqKRQYb88ARiWhVM+1/vmTlVNe9t3HmvHqrL/s8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1uwLof-0006pq-7X; Wed, 10 Sep 2025 16:28:57 +0200
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1uwLod-000be4-1P;
	Wed, 10 Sep 2025 16:28:55 +0200
Received: from pengutronix.de (glittertind.blackshift.org [116.203.23.228])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id EE8B146B01C;
	Wed, 10 Sep 2025 14:28:54 +0000 (UTC)
Date: Wed, 10 Sep 2025 16:28:54 +0200
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Markus Schneider-Pargmann <msp@baylibre.com>
Cc: Chandrasekar Ramakrishnan <rcsekar@samsung.com>, 
	Vincent Mailhol <mailhol.vincent@wanadoo.fr>, Patrik Flykt <patrik.flykt@linux.intel.com>, 
	Dong Aisheng <b29396@freescale.com>, Varka Bhadram <varkabhadram@gmail.com>, 
	Wu Bo <wubo.oduw@gmail.com>, Philipp Zabel <p.zabel@pengutronix.de>, 
	linux-can@vger.kernel.org, linux-kernel@vger.kernel.org, kernel@pengutronix.de
Subject: Re: [PATCH v2 2/7] can: m_can: only handle active interrupts
Message-ID: <20250910-fair-fast-uakari-4f734e-mkl@pengutronix.de>
References: <20250909-m_can-fix-state-handling-v2-0-af9fa240b68a@pengutronix.de>
 <20250909-m_can-fix-state-handling-v2-2-af9fa240b68a@pengutronix.de>
 <DCOZIMAYLN8P.23PQEAFQ26ADZ@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="vbis66p6xljqbu6v"
Content-Disposition: inline
In-Reply-To: <DCOZIMAYLN8P.23PQEAFQ26ADZ@baylibre.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org


--vbis66p6xljqbu6v
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v2 2/7] can: m_can: only handle active interrupts
MIME-Version: 1.0

On 10.09.2025 10:41:28, Markus Schneider-Pargmann wrote:
> > diff --git a/drivers/net/can/m_can/m_can.c b/drivers/net/can/m_can/m_ca=
n.c
> > index fe74dbd2c966..16b38e6c3985 100644
> > --- a/drivers/net/can/m_can/m_can.c
> > +++ b/drivers/net/can/m_can/m_can.c
> > @@ -1057,6 +1057,7 @@ static int m_can_poll(struct napi_struct *napi, i=
nt quota)
> >  	u32 irqstatus;
> > =20
> >  	irqstatus =3D cdev->irqstatus | m_can_read(cdev, M_CAN_IR);
> > +	irqstatus &=3D cdev->active_interrupts;
> > =20
> >  	work_done =3D m_can_rx_handler(dev, quota, irqstatus);
> > =20
> > @@ -1243,6 +1244,8 @@ static int m_can_interrupt_handler(struct m_can_c=
lassdev *cdev)
> >  	}
> > =20
> >  	m_can_coalescing_update(cdev, ir);
> > +
> > +	ir &=3D cdev->active_interrupts;
>=20
> m_can_coalescing_update() can change active_interrupts, meaning the
> interrupt that caused the interrupt handler to run may be disabled in
> active_interrupts above and then masked in this added line. Would that
> still work or does it confuse the hardware?

I think m_can_coalescing_update() expects the RX/TX will be cleared. Are
the following comments OK...

| diff --git a/drivers/net/can/m_can/m_can.c b/drivers/net/can/m_can/m_can.c
| index 16b38e6c3985..8cb9cc1cddbf 100644
| --- a/drivers/net/can/m_can/m_can.c
| +++ b/drivers/net/can/m_can/m_can.c
| @@ -1188,28 +1188,39 @@ static int m_can_echo_tx_event(struct net_device =
*dev)
| =20
|  static void m_can_coalescing_update(struct m_can_classdev *cdev, u32 ir)
|  {
|          u32 new_interrupts =3D cdev->active_interrupts;
|          bool enable_rx_timer =3D false;
|          bool enable_tx_timer =3D false;
| =20
|          if (!cdev->net->irq)
|                  return;
| =20
| +        /* If there is a packet in the FIFO then:
| +         * - start timer
| +         * - disable not empty IRQ
| +         * - handle FIFO
                ^^^^^^^^^^^

=2E..especially this one?

| +         */
|          if (cdev->rx_coalesce_usecs_irq > 0 && (ir & (IR_RF0N | IR_RF0W)=
)) {
|                  enable_rx_timer =3D true;
|                  new_interrupts &=3D ~IR_RF0N;
|          }
|          if (cdev->tx_coalesce_usecs_irq > 0 && (ir & (IR_TEFN | IR_TEFW)=
)) {
|                  enable_tx_timer =3D true;
|                  new_interrupts &=3D ~IR_TEFN;
|          }
| +
| +        /* If:
| +         * - timer is not going to be start
| +         * - and timer is not active
| +         * -> then enable FIFO empty IRQ
| +         */
|          if (!enable_rx_timer && !hrtimer_active(&cdev->hrtimer))
|                  new_interrupts |=3D IR_RF0N;
|          if (!enable_tx_timer && !hrtimer_active(&cdev->hrtimer))
|                  new_interrupts |=3D IR_TEFN;
| =20
|          m_can_interrupt_enable(cdev, new_interrupts);
|          if (enable_rx_timer | enable_tx_timer)
|                  hrtimer_start(&cdev->hrtimer, cdev->irq_timer_wait,
|                                HRTIMER_MODE_REL);
|  }

Currently the m_can_coalescing_update() is called at the beginning of
the IRQ handler. Does it make sense to move it to the end and pass the
unmasked M_CAN_IR?

Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--vbis66p6xljqbu6v
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEn/sM2K9nqF/8FWzzDHRl3/mQkZwFAmjBiyMACgkQDHRl3/mQ
kZylwAf/RXbHXDIhPI9saC5LVBLI/eFaCnVrpGZ9a4HTTbMkdHDe8JBuUk6dZj3X
AU3uyoM+2gm7RHpkhy99LcKCbQPcxWneeeOp3+Z8XnXoD/Dx/RWGVTjseXIN8ErP
xo46qtsEL2xeb6N+7xHpW8w4E6KMRYDomZP2dBPlWnD+ivasnPaagln9D+MS/zM3
Nk35yQX30RVLidst9iq/3R43jzCCUo6YB3OIxiPGDMjcbmgGzNjUropVuCBv+YFo
EB6NFbfaUjNXSqDRDerZL9CtefPKAbf787Cm7WHhwn7HbgUhbdx4zLDZF86+I0La
qNTBVPW26A3gwyAFLTjryiSF2OQftA==
=fj+z
-----END PGP SIGNATURE-----

--vbis66p6xljqbu6v--

