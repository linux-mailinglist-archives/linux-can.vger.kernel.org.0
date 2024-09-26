Return-Path: <linux-can+bounces-1564-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A741D986FE2
	for <lists+linux-can@lfdr.de>; Thu, 26 Sep 2024 11:20:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 217531F21872
	for <lists+linux-can@lfdr.de>; Thu, 26 Sep 2024 09:20:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB8841A7AD0;
	Thu, 26 Sep 2024 09:20:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b="W20fQ9wi";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b="ajB9HqZz"
X-Original-To: linux-can@vger.kernel.org
Received: from mx1.tq-group.com (mx1.tq-group.com [93.104.207.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 203891A4E9A;
	Thu, 26 Sep 2024 09:20:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.104.207.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727342409; cv=none; b=HBmy96fx5dWjdd4SgaR4QmTd5IdEGdH9avjIrUwJtEliIIvVZ4djfM4E/nGxha9C/ReE7qS7D2bzZpENKrIjLZQWWgaVWigRDj0APPfXlW8eU0Iy8cBZct4MYMn5c0DqI+23QhOkRBUS1kvpLslKv0qO3RcfaY9tVJTwGjOhjuk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727342409; c=relaxed/simple;
	bh=fPxIITGwvsR8oZaU7WU0RDsZkwH0CjGkd3lOuyO+iHQ=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=BwcPN1R25v9qE46GOG1gOMv6rYpeMcyPQsjMxtpdIkuLBbez+egRipm/ZZ/0DE5uE6wH0b6NY7dySs6P48KUmWLdfb9Ye+jzd9ATsLNVopq35zhfvpmAjsfS/UOtJ1tyfuPj+YxLIo1k2eRXz50V/j5tuEIirn+uwGmiwCIkmws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com; spf=pass smtp.mailfrom=ew.tq-group.com; dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b=W20fQ9wi; dkim=fail (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b=ajB9HqZz reason="key not found in DNS"; arc=none smtp.client-ip=93.104.207.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ew.tq-group.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1727342406; x=1758878406;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=rekTNiajdYTDYhal5o7yC/gc4wdPo/buylcC+7XLvf0=;
  b=W20fQ9wiQETMjy/CGNJjJpUlhvJN4Nar2Zr1sBt4UtqTgCDI2OFY8mkU
   nIil87LfcmL+plZZ9nKzZjACGML7XiLynYzm7bYu4D2SDXxC8aBuajXsQ
   T7FhfLjR9px9L9Oo5ljURgrY3hAxzCuxcE8ZISfqu9i++Dn4plAf5AN+m
   CPsQI6UQMPZat2yxG2GoKNph3SS2FrKs1e0mDXqP1XkZ8qkb92V8uK2u4
   vB356Qf8zobL1oz6DkNtxMSOKbFnpWJ3Gg4hxTQLB1ruV5V7wX0msuord
   1wkoKGtp1/EOYaKj4ElauLN1Xxi5ZiJOJV2l85qPjmuI8yUhYC9J0/nZd
   Q==;
X-CSE-ConnectionGUID: T5bvyQ9mR9OUij5kNx/G6g==
X-CSE-MsgGUID: 2MhZBR0DTvCanKpiBK4F6w==
X-IronPort-AV: E=Sophos;i="6.10,260,1719871200"; 
   d="scan'208";a="39137207"
Received: from vmailcow01.tq-net.de ([10.150.86.48])
  by mx1.tq-group.com with ESMTP; 26 Sep 2024 11:20:02 +0200
X-CheckPoint: {66F52742-3-6BF03F0A-F83EAA27}
X-MAIL-CPID: 91894B9D38675A8080ECBDF9025865E8_1
X-Control-Analysis: str=0001.0A682F19.66F52742.0106,ss=1,re=0.000,recu=0.000,reip=0.000,cl=1,cld=1,fgs=0
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id ABB8D160BC1;
	Thu, 26 Sep 2024 11:19:53 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ew.tq-group.com;
	s=dkim; t=1727342397;
	h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=rekTNiajdYTDYhal5o7yC/gc4wdPo/buylcC+7XLvf0=;
	b=ajB9HqZzhGnDclRMuLGMwuIUbY8GxA4vUb+UQKsqbP0BgWPOAqLBABmFZseWyPyVsok1VE
	4IKw0aSQSOQ1NmQsizl15a0Xa9tmxWEOCHb9bi904fL6TKnsKraVA9VQjCDo7VVrgGgeyE
	hJD+yXIiBGnJGUor2L1I16Uuwp8PDUasSfmzq3YdKshPaayDTIXAZhLxxeVIDty69gbrsf
	B6ioduclBElMAotalzuErQADlp1C4vp9nfBYlOSoYE6GyxvfruZy5KO3sYg49E3powkCw1
	I08kYXwYreAbJO0uUa1CxhN5PjwfLQjz3Hs71xbBrva+GSrQh4nfq7Yjqc2YNA==
Message-ID: <1a4ed0696cbe222e50b5abdff08a5ce7f8223aae.camel@ew.tq-group.com>
Subject: Re: [PATCH v3 2/2] can: m_can: fix missed interrupts with m_can_pci
From: Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
To: Markus Schneider-Pargmann <msp@baylibre.com>, Marc Kleine-Budde
	 <mkl@pengutronix.de>
Cc: Chandrasekar Ramakrishnan <rcsekar@samsung.com>, Vincent Mailhol
 <mailhol.vincent@wanadoo.fr>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo
 Abeni <pabeni@redhat.com>,  Martin =?ISO-8859-1?Q?Hundeb=F8ll?=
 <martin@geanix.com>, "Felipe Balbi (Intel)" <balbi@kernel.org>, Raymond Tan
 <raymond.tan@intel.com>, Jarkko Nikula <jarkko.nikula@linux.intel.com>, 
 linux-can@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org,  linux@ew.tq-group.com
Date: Thu, 26 Sep 2024 11:19:53 +0200
In-Reply-To: <6qk7fmbbvi5m3evyriyq4txswuzckbg4lmdbdkyidiedxhzye5@av3gw7vweimu>
References: 
	<ed86ab0d7d2b295dc894fc3e929beb69bdc921f6.1727092909.git.matthias.schiffer@ew.tq-group.com>
	 <4715d1cfed61d74d08dcc6a27085f43092da9412.1727092909.git.matthias.schiffer@ew.tq-group.com>
	 <6qk7fmbbvi5m3evyriyq4txswuzckbg4lmdbdkyidiedxhzye5@av3gw7vweimu>
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

On Tue, 2024-09-24 at 08:08 +0200, Markus Schneider-Pargmann wrote:
>=20
> On Mon, Sep 23, 2024 at 05:32:16PM GMT, Matthias Schiffer wrote:
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
>=20
> Just a few comment nitpicks below. Otherwise:
>=20
> Reviewed-by: Markus Schneider-Pargmann <msp@baylibre.com>


We have received a report that while this patch fixes a stuck queue issue r=
eproducible with cangen,
the problem has not disappeared with our customer's application. I will hol=
d off sending a new
version of the patch while we're investigating whether there is a separate =
issue with the same
symptoms or the patch is insufficient.

Patch 1/2 should be good to go and could be applied independently.

Matthias


>=20
> > ---
> >=20
> > v2: introduce flag is_edge_triggered, so we can avoid the loop on !m_ca=
n_pci
> > v3:
> > - rename flag to irq_edge_triggered
> > - update comment to describe the issue more generically as one of syste=
ms with
> >   edge-triggered interrupt line. m_can_pci is mentioned as an example, =
as it
> >   is the only m_can variant that currently sets the irq_edge_triggered =
flag.
> >=20
> >  drivers/net/can/m_can/m_can.c     | 22 +++++++++++++++++-----
> >  drivers/net/can/m_can/m_can.h     |  1 +
> >  drivers/net/can/m_can/m_can_pci.c |  1 +
> >  3 files changed, 19 insertions(+), 5 deletions(-)
> >=20
> > diff --git a/drivers/net/can/m_can/m_can.c b/drivers/net/can/m_can/m_ca=
n.c
> > index c85ac1b15f723..24e348f677714 100644
> > --- a/drivers/net/can/m_can/m_can.c
> > +++ b/drivers/net/can/m_can/m_can.c
> > @@ -1207,20 +1207,32 @@ static void m_can_coalescing_update(struct m_ca=
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
> > +	/* The m_can controller signals its interrupt status as a level, but
> > +	 * depending in the integration the CPU may interpret the signal as
>                  ^ on?
>=20
> > +	 * edge-triggered (for example with m_can_pci).
> > +	 * We must observe that IR is 0 at least once to be sure that the nex=
t
>=20
> As the loop has a break for non edge-triggered chips, I think you should
> include that in the comment, like 'For these edge-triggered
> integrations, we must observe...' or something similar.
>=20
> Best
> Markus
>=20
> > +	 * interrupt will generate an edge.
> > +	 */
> > +	while ((ir_read =3D m_can_read(cdev, M_CAN_IR)) !=3D 0) {
> > +		ir |=3D ir_read;
> > +
> > +		/* ACK all irqs */
> > +		m_can_write(cdev, M_CAN_IR, ir);
> > +
> > +		if (!cdev->irq_edge_triggered)
> > +			break;
> > +	}
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
> > diff --git a/drivers/net/can/m_can/m_can.h b/drivers/net/can/m_can/m_ca=
n.h
> > index 92b2bd8628e6b..ef39e8e527ab6 100644
> > --- a/drivers/net/can/m_can/m_can.h
> > +++ b/drivers/net/can/m_can/m_can.h
> > @@ -99,6 +99,7 @@ struct m_can_classdev {
> >  	int pm_clock_support;
> >  	int pm_wake_source;
> >  	int is_peripheral;
> > +	bool irq_edge_triggered;
> > =20
> >  	// Cached M_CAN_IE register content
> >  	u32 active_interrupts;
> > diff --git a/drivers/net/can/m_can/m_can_pci.c b/drivers/net/can/m_can/=
m_can_pci.c
> > index d72fe771dfc7a..9ad7419f88f83 100644
> > --- a/drivers/net/can/m_can/m_can_pci.c
> > +++ b/drivers/net/can/m_can/m_can_pci.c
> > @@ -127,6 +127,7 @@ static int m_can_pci_probe(struct pci_dev *pci, con=
st struct pci_device_id *id)
> >  	mcan_class->pm_clock_support =3D 1;
> >  	mcan_class->pm_wake_source =3D 0;
> >  	mcan_class->can.clock.freq =3D id->driver_data;
> > +	mcan_class->irq_edge_triggered =3D true;
> >  	mcan_class->ops =3D &m_can_pci_ops;
> > =20
> >  	pci_set_drvdata(pci, mcan_class);
> > --=20
> > TQ-Systems GmbH | M=C3=BChlstra=C3=9Fe 2, Gut Delling | 82229 Seefeld, =
Germany
> > Amtsgericht M=C3=BCnchen, HRB 105018
> > Gesch=C3=A4ftsf=C3=BChrer: Detlef Schneider, R=C3=BCdiger Stahl, Stefan=
 Schneider
> > https://www.tq-group.com/

--=20
TQ-Systems GmbH | M=C3=BChlstra=C3=9Fe 2, Gut Delling | 82229 Seefeld, Germ=
any
Amtsgericht M=C3=BCnchen, HRB 105018
Gesch=C3=A4ftsf=C3=BChrer: Detlef Schneider, R=C3=BCdiger Stahl, Stefan Sch=
neider
https://www.tq-group.com/

