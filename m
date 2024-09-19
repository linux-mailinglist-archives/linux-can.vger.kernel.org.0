Return-Path: <linux-can+bounces-1512-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 822BD97C66F
	for <lists+linux-can@lfdr.de>; Thu, 19 Sep 2024 10:59:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 15BDB1F274C5
	for <lists+linux-can@lfdr.de>; Thu, 19 Sep 2024 08:59:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AC031991CA;
	Thu, 19 Sep 2024 08:59:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b="muRV6Lg+";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b="gt8ZO/bt"
X-Original-To: linux-can@vger.kernel.org
Received: from mx1.tq-group.com (mx1.tq-group.com [93.104.207.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0845C28EA;
	Thu, 19 Sep 2024 08:58:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.104.207.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726736343; cv=none; b=Od9rO3r48YKyCLin4uJA244CcXci6KkHjAt9Y8A972FGrvhIVWIKL2LEDD/Fw1DGHOGxr2VqE590l9P8CZEC9GVNy7qvGaBOul0m1eDIb1/wUN3F30xWN72bMsXGSqgF6zXebeMTqctUrFADGXsPYxOB+6hbOXXvDhqfMkCmTfs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726736343; c=relaxed/simple;
	bh=myyO3TIX6AVGOwynSAzRpK1M+t0Hfdzns9f0eUnl4FI=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=JpeurPAUBLUcZrbvif2FxUfmZ5KYOV5hVxoLjmaj83GLYUeA5VU3uPsqj/tYpWTIpQyJDz+WwLfMkDkH1i6YVCtE99J7jnlQULRlMKfkXEgOcoDpOeyB1TaHoy4fUL7TO3htWwTeJQ6twFI6ysz6JuvDZF3FGpqr9ecgiYfQcKk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com; spf=pass smtp.mailfrom=ew.tq-group.com; dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b=muRV6Lg+; dkim=fail (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b=gt8ZO/bt reason="key not found in DNS"; arc=none smtp.client-ip=93.104.207.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ew.tq-group.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1726736339; x=1758272339;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=zslu8pDmiOlZUz8CHGNQsNG0CBKhz/IHbX6/HCWvCKk=;
  b=muRV6Lg+oXDW0ou8uJPqNZj6YvLG8cSUDzJB00NIg1E6/L299jPIB69b
   kv03FnENgbSWtVezhgCtLCMW/xrNrqenVBrVlXEmtNqnWMungqGaMUfYU
   JftUrjZjt9wAJ2j3016gQIB56vxVrMrKu1NYUJWZzQS6OolYwtOSFRQxa
   BbWGu2b0RA36HWUAkJ+pIOCeUP0gWmRDiOeQEPppJ+yJhl578L1+GsKtJ
   DcGLq03fAdLUBTqhTrEMWd7nxWFtWvE1yxzx7iACmKSEJI3TOxEf1FfYG
   27MJLirDLHe1s354gVok+oX4IiJ1rcfxUyk8irh1dpjAwHYyTX0CbfZab
   w==;
X-CSE-ConnectionGUID: b9nf3hCZS6eIi1hzZEenMg==
X-CSE-MsgGUID: m1cnnc2bSMWrHjdb7Gl+YQ==
X-IronPort-AV: E=Sophos;i="6.10,241,1719871200"; 
   d="scan'208";a="39020246"
Received: from vmailcow01.tq-net.de ([10.150.86.48])
  by mx1.tq-group.com with ESMTP; 19 Sep 2024 10:58:55 +0200
X-CheckPoint: {66EBE7D0-D-E520F13A-D17B83D9}
X-MAIL-CPID: EE31EAD2D0AEFA7880AB6BB5E3B931F4_2
X-Control-Analysis: str=0001.0A682F16.66EBE7D0.0151,ss=1,re=0.000,recu=0.000,reip=0.000,cl=1,cld=1,fgs=0
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id EE92A16CB35;
	Thu, 19 Sep 2024 10:58:46 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ew.tq-group.com;
	s=dkim; t=1726736331;
	h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=zslu8pDmiOlZUz8CHGNQsNG0CBKhz/IHbX6/HCWvCKk=;
	b=gt8ZO/btYHIuyBadKm5TSjL8OWEBwbaltfLOjbdn37uNYLqytix8PZkkmM91jElx2SBCDk
	CwDUxt6IqkJ69vVmerBV6UZx/5FuUpLM6uGn1+5AdCHGRmKBBJZpCRtOfVDYHU8ilh9dln
	goS8uOIb6yVLuMxbtRh9cKCbn6n0XUbB+jigpsoclhapd19JK77DxXUUvfk5oJv2u3a3ge
	9dXjAyOfFiNfWp2nHeo2ZQzF+XxoR9Snl7saI2g822TY5gtLl7Qi/vDc11SX0A78VZpUco
	MJZHBr3fJvIZnoOKsiPgVZdS4jyoJydhz3PCuVF/9EA+AqRw3Yvv1t3c8gzC2Q==
Message-ID: <0ebdf87729fba276b1ff4a06a5f4dad4a3768e8a.camel@ew.tq-group.com>
Subject: Re: [PATCH 2/2] can: m_can: fix missed interrupts with m_can_pci
From: Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: Chandrasekar Ramakrishnan <rcsekar@samsung.com>, Vincent Mailhol
 <mailhol.vincent@wanadoo.fr>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo
 Abeni <pabeni@redhat.com>,  Martin =?ISO-8859-1?Q?Hundeb=F8ll?=
 <martin@geanix.com>, Markus Schneider-Pargmann <msp@baylibre.com>, "Felipe
 Balbi (Intel)" <balbi@kernel.org>, Raymond Tan <raymond.tan@intel.com>,
 Jarkko Nikula <jarkko.nikula@linux.intel.com>, linux-can@vger.kernel.org, 
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, linux@ew.tq-group.com
Date: Thu, 19 Sep 2024 10:58:46 +0200
In-Reply-To: <20240919-tourmaline-jaguar-of-reverence-4875d2-mkl@pengutronix.de>
References: 
	<ac8c49fffac582176ba1899a85db84e0f5d5c7a6.1726669005.git.matthias.schiffer@ew.tq-group.com>
	 <f6155510fbea33b0e18030a147b87c04395f7394.1726669005.git.matthias.schiffer@ew.tq-group.com>
	 <20240919-tourmaline-jaguar-of-reverence-4875d2-mkl@pengutronix.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu2 
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Last-TLS-Session-Version: TLSv1.3

On Thu, 2024-09-19 at 10:47 +0200, Marc Kleine-Budde wrote:
> On 18.09.2024 16:21:54, Matthias Schiffer wrote:
> > The interrupt line of PCI devices is interpreted as edge-triggered,
> > however the interrupt signal of the m_can controller integrated in Inte=
l
> > Elkhart Lake CPUs appears to be generated level-triggered.
> >=20
> > Consider the following sequence of events:
> >=20
> > - IR register is read, interrupt X is set
> > - A new interrupt Y is triggered in the m_can controller
> > - IR register is written to acknowledge interrupt X. Y remains set in I=
R
> >=20
> > As at no point in this sequence no interrupt flag is set in IR, the
> > m_can interrupt line will never become deasserted, and no edge will eve=
r
> > be observed to trigger another run of the ISR. This was observed to
> > result in the TX queue of the EHL m_can to get stuck under high load,
> > because frames were queued to the hardware in m_can_start_xmit(), but
> > m_can_finish_tx() was never run to account for their successful
> > transmission.
> >=20
> > To fix the issue, repeatedly read and acknowledge interrupts at the
> > start of the ISR until no interrupt flags are set, so the next incoming
> > interrupt will also result in an edge on the interrupt line.
> >=20
> > Fixes: cab7ffc0324f ("can: m_can: add PCI glue driver for Intel Elkhart=
 Lake")
> > Signed-off-by: Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
> > ---
> >  drivers/net/can/m_can/m_can.c | 18 +++++++++++++-----
> >  1 file changed, 13 insertions(+), 5 deletions(-)
> >=20
> > diff --git a/drivers/net/can/m_can/m_can.c b/drivers/net/can/m_can/m_ca=
n.c
> > index 47481afb9add3..363732517c3c5 100644
> > --- a/drivers/net/can/m_can/m_can.c
> > +++ b/drivers/net/can/m_can/m_can.c
> > @@ -1207,20 +1207,28 @@ static void m_can_coalescing_update(struct m_ca=
n_classdev *cdev, u32 ir)
> >  static int m_can_interrupt_handler(struct m_can_classdev *cdev)
> >  {
> >  	struct net_device *dev =3D cdev->net;
> > -	u32 ir;
> > +	u32 ir =3D 0, ir_read;
> >  	int ret;
> > =20
> >  	if (pm_runtime_suspended(cdev->dev))
> >  		return IRQ_NONE;
> > =20
> > -	ir =3D m_can_read(cdev, M_CAN_IR);
> > +	/* For m_can_pci, the interrupt line is interpreted as edge-triggered=
,
> > +	 * but the m_can controller generates them as level-triggered. We mus=
t
> > +	 * observe that IR is 0 at least once to be sure that the next
> > +	 * interrupt will generate an edge.
> > +	 */
> > +	while ((ir_read =3D m_can_read(cdev, M_CAN_IR)) !=3D 0) {
> > +		ir |=3D ir_read;
> > +
> > +		/* ACK all irqs */
> > +		m_can_write(cdev, M_CAN_IR, ir);
> > +	}
>=20
> This probably causes a measurable overhead on peripheral devices, think
> about limiting this to !peripheral devices or introduce a new quirk that
> is only set for the PCI devices.
>=20
> Marc

Hi Marc,

I did consider introducing a flag like that, but is the overhead really sig=
nificant? In the regular
case (where no new interrupt comes in between reading, writing and re-readi=
ng IR), the only added
overhead is one additional register read. On m_can_pci, I've seen the race =
condition that causes a
second loop iteration to be taken only once in several 100k frames on avara=
ge.

Or are register reads and writes that much slower on peripheral devices tha=
t it is more likely to
receive a new interrupt inbetween? If that is the case, it would indeed mak=
e sense to limit this to
instances with edge-triggered IRQ.

Matthias



>=20
> > +
> >  	m_can_coalescing_update(cdev, ir);
> >  	if (!ir)
> >  		return IRQ_NONE;
> > =20
> > -	/* ACK all irqs */
> > -	m_can_write(cdev, M_CAN_IR, ir);
> > -
> >  	if (cdev->ops->clear_interrupts)
> >  		cdev->ops->clear_interrupts(cdev);
> > =20
> > --=20
> > TQ-Systems GmbH | M=C3=BChlstra=C3=9Fe 2, Gut Delling | 82229 Seefeld, =
Germany
> > Amtsgericht M=C3=BCnchen, HRB 105018
> > Gesch=C3=A4ftsf=C3=BChrer: Detlef Schneider, R=C3=BCdiger Stahl, Stefan=
 Schneider
> > https://www.tq-group.com/
> >=20
> >=20
> >=20
>=20
> Achtung externe E-Mail:=C2=A0=C3=96ffnen Sie Anh=C3=A4nge und Links nur, =
wenn Sie wissen, dass diese aus einer sicheren Quelle stammen und sicher si=
nd. Leiten Sie die E-Mail im Zweifelsfall zur Pr=C3=BCfung an den IT-Helpde=
sk weiter.
>   Attention external email:=C2=A0Open attachments and links only if you k=
now that they are from a secure source and are safe. In doubt forward the e=
mail to the IT-Helpdesk to check it.
>=20
> =C2=A0

--=20
TQ-Systems GmbH | M=C3=BChlstra=C3=9Fe 2, Gut Delling | 82229 Seefeld, Germ=
any
Amtsgericht M=C3=BCnchen, HRB 105018
Gesch=C3=A4ftsf=C3=BChrer: Detlef Schneider, R=C3=BCdiger Stahl, Stefan Sch=
neider
https://www.tq-group.com/

