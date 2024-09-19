Return-Path: <linux-can+bounces-1513-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CAB5B97C6BE
	for <lists+linux-can@lfdr.de>; Thu, 19 Sep 2024 11:17:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1C3EEB20E05
	for <lists+linux-can@lfdr.de>; Thu, 19 Sep 2024 09:17:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5501619408B;
	Thu, 19 Sep 2024 09:17:31 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D4BD1922EF
	for <linux-can@vger.kernel.org>; Thu, 19 Sep 2024 09:17:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726737451; cv=none; b=FpNkwva3/i4J8GW2jsLgyXVNTgU4Vr8yd3cBKlO8mGnQL7ZDKeR9n698M8Gj7vu4bmZ022rbJsQhYu0vFBtibb0TRgkL9GNDeImUAfLAukYbGl4NVS1U7e6j9Bh5unWKZryV9ldajCSXLQzsYhDUkfVzCL98MwRXAI3/sN00yT4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726737451; c=relaxed/simple;
	bh=6rJ+Y1F5oXqTCG6kXlPKCP+27zvwmWQfn63Zo0OlV2Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=I0dry+8Gh8mZP1ooaflNISRZ6ODzLuDPZckhbD1OJFQMFPPe0PUGON1AtbBo39gfgWlQZZ0B+QQUEN3UoJ/MeCMgA/ShYAAzgeyryUVPQxRtZoV/6awLuFNLnkZa+ByBYZJv16jSWzZ+zGySvzcod3RncwcHi49pSocZxJDOQQI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1srDHg-0003W6-RT; Thu, 19 Sep 2024 11:17:08 +0200
Received: from [2a0a:edc0:0:b01:1d::7b] (helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <mkl@pengutronix.de>)
	id 1srDHe-0091Cd-24; Thu, 19 Sep 2024 11:17:06 +0200
Received: from pengutronix.de (unknown [IPv6:2a01:4f8:1c1c:29e9:22:41ff:fe00:1400])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 3606733F5C2;
	Thu, 19 Sep 2024 09:17:05 +0000 (UTC)
Date: Thu, 19 Sep 2024 11:17:04 +0200
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
Cc: Chandrasekar Ramakrishnan <rcsekar@samsung.com>, 
	Vincent Mailhol <mailhol.vincent@wanadoo.fr>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Martin =?utf-8?Q?Hundeb=C3=B8ll?= <martin@geanix.com>, 
	Markus Schneider-Pargmann <msp@baylibre.com>, "Felipe Balbi (Intel)" <balbi@kernel.org>, 
	Raymond Tan <raymond.tan@intel.com>, Jarkko Nikula <jarkko.nikula@linux.intel.com>, 
	linux-can@vger.kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux@ew.tq-group.com
Subject: Re: [PATCH 2/2] can: m_can: fix missed interrupts with m_can_pci
Message-ID: <20240919-colorful-gorilla-of-defense-3c2da3-mkl@pengutronix.de>
References: <ac8c49fffac582176ba1899a85db84e0f5d5c7a6.1726669005.git.matthias.schiffer@ew.tq-group.com>
 <f6155510fbea33b0e18030a147b87c04395f7394.1726669005.git.matthias.schiffer@ew.tq-group.com>
 <20240919-tourmaline-jaguar-of-reverence-4875d2-mkl@pengutronix.de>
 <0ebdf87729fba276b1ff4a06a5f4dad4a3768e8a.camel@ew.tq-group.com>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="xjxmyvj32vfads4c"
Content-Disposition: inline
In-Reply-To: <0ebdf87729fba276b1ff4a06a5f4dad4a3768e8a.camel@ew.tq-group.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org


--xjxmyvj32vfads4c
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 19.09.2024 10:58:46, Matthias Schiffer wrote:
> On Thu, 2024-09-19 at 10:47 +0200, Marc Kleine-Budde wrote:
> > On 18.09.2024 16:21:54, Matthias Schiffer wrote:
> > > The interrupt line of PCI devices is interpreted as edge-triggered,
> > > however the interrupt signal of the m_can controller integrated in In=
tel
> > > Elkhart Lake CPUs appears to be generated level-triggered.
> > >=20
> > > Consider the following sequence of events:
> > >=20
> > > - IR register is read, interrupt X is set
> > > - A new interrupt Y is triggered in the m_can controller
> > > - IR register is written to acknowledge interrupt X. Y remains set in=
 IR
> > >=20
> > > As at no point in this sequence no interrupt flag is set in IR, the
> > > m_can interrupt line will never become deasserted, and no edge will e=
ver
> > > be observed to trigger another run of the ISR. This was observed to
> > > result in the TX queue of the EHL m_can to get stuck under high load,
> > > because frames were queued to the hardware in m_can_start_xmit(), but
> > > m_can_finish_tx() was never run to account for their successful
> > > transmission.
> > >=20
> > > To fix the issue, repeatedly read and acknowledge interrupts at the
> > > start of the ISR until no interrupt flags are set, so the next incomi=
ng
> > > interrupt will also result in an edge on the interrupt line.
> > >=20
> > > Fixes: cab7ffc0324f ("can: m_can: add PCI glue driver for Intel Elkha=
rt Lake")
> > > Signed-off-by: Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
> > > ---
> > >  drivers/net/can/m_can/m_can.c | 18 +++++++++++++-----
> > >  1 file changed, 13 insertions(+), 5 deletions(-)
> > >=20
> > > diff --git a/drivers/net/can/m_can/m_can.c b/drivers/net/can/m_can/m_=
can.c
> > > index 47481afb9add3..363732517c3c5 100644
> > > --- a/drivers/net/can/m_can/m_can.c
> > > +++ b/drivers/net/can/m_can/m_can.c
> > > @@ -1207,20 +1207,28 @@ static void m_can_coalescing_update(struct m_=
can_classdev *cdev, u32 ir)
> > >  static int m_can_interrupt_handler(struct m_can_classdev *cdev)
> > >  {
> > >  	struct net_device *dev =3D cdev->net;
> > > -	u32 ir;
> > > +	u32 ir =3D 0, ir_read;
> > >  	int ret;
> > > =20
> > >  	if (pm_runtime_suspended(cdev->dev))
> > >  		return IRQ_NONE;
> > > =20
> > > -	ir =3D m_can_read(cdev, M_CAN_IR);
> > > +	/* For m_can_pci, the interrupt line is interpreted as edge-trigger=
ed,
> > > +	 * but the m_can controller generates them as level-triggered. We m=
ust
> > > +	 * observe that IR is 0 at least once to be sure that the next
> > > +	 * interrupt will generate an edge.
> > > +	 */
> > > +	while ((ir_read =3D m_can_read(cdev, M_CAN_IR)) !=3D 0) {
> > > +		ir |=3D ir_read;
> > > +
> > > +		/* ACK all irqs */
> > > +		m_can_write(cdev, M_CAN_IR, ir);
> > > +	}
> >=20
> > This probably causes a measurable overhead on peripheral devices, think
> > about limiting this to !peripheral devices or introduce a new quirk that
> > is only set for the PCI devices.

> I did consider introducing a flag like that, but is the overhead
> really significant? In the regular case (where no new interrupt comes
> in between reading, writing and re-reading IR), the only added
> overhead is one additional register read. On m_can_pci, I've seen the
> race condition that causes a second loop iteration to be taken only
> once in several 100k frames on avarage.

A register read via SPI is quite costly compared to mmio. And Marcus has
optimized the peripheral case quite good, and I don't want any
performance regressions.

> Or are register reads and writes that much slower on peripheral
> devices that it is more likely to receive a new interrupt inbetween?
> If that is the case, it would indeed make sense to limit this to
> instances with edge-triggered IRQ.

The mcp251xfd driver actually loops [1] the whole handling until there
are no IRQ pending:

https://elixir.bootlin.com/linux/v6.11/source/drivers/net/can/spi/mcp251xfd=
/mcp251xfd-core.c#L1466

But the m_can driver doesn't.

[1] I don't have measurements how often the driver actually loops.

regards,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--xjxmyvj32vfads4c
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEUEC6huC2BN0pvD5fKDiiPnotvG8FAmbr7A0ACgkQKDiiPnot
vG+P7wf/bY5m4qLcECs+4hJbJAyLo63e2qk3wRpv2w78Tyxxy588C2apyme79dDE
izqcomSc2J++eWqZTfF3Yg87PupRIUUuiiHoaiut1+YWYw55B7eTfvEe8ASLLTd6
JtDPbolQ5LOAyLllu1tMx4KRB7vI21DPsRtkaJrexl3U3aNl8knR8tPkHnuCtwxW
qJIerMS0stYvA4lNGkPOeUBH1gYIGrPQRgSdV7GwDpprZ88UlIM148jLj8H1CX4Y
bKlKBw2oF4uCsKgOG79VMfqat/HHFZEc8iFg6NDZ9MTi9QRT+KYMB2U8k2OZFDwM
Gkniox4gMne7atjgnffhTqX+PbqQ5g==
=ft3C
-----END PGP SIGNATURE-----

--xjxmyvj32vfads4c--

