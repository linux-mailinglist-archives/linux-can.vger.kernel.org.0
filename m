Return-Path: <linux-can+bounces-1531-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 44EFB97E8C5
	for <lists+linux-can@lfdr.de>; Mon, 23 Sep 2024 11:33:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 95071B20AC2
	for <lists+linux-can@lfdr.de>; Mon, 23 Sep 2024 09:33:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9929D1946C8;
	Mon, 23 Sep 2024 09:33:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b="eEXtPq7G";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b="ripCyzPk"
X-Original-To: linux-can@vger.kernel.org
Received: from mx1.tq-group.com (mx1.tq-group.com [93.104.207.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 645D0EEB5;
	Mon, 23 Sep 2024 09:33:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.104.207.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727083993; cv=none; b=FJvZ3AdzP4a6YZWJ99v5zNv7R29DQVR5Cn8bxhLR/GcDkLu/T6EleK+a+s3OC9FNO2tLxxwfUZayIGXMvwvY/liiGLvCieLSH6sjo6seLBBmZbPTD8LV6zgoKyjZAtSPcXRqBdyYg9Ef6+BcgNuzskBQ9AuxEKfvH47BnmrYIis=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727083993; c=relaxed/simple;
	bh=vxkqz320cW/spP4lT+HFsKd08PMkG4HwW54twObqwmg=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=HU4kIMk/WrVFUCY10NjGZASx1VXwNY5/xiu8u/Wa9J7Ycf86wNO+/5hz3eDGDS/hMeCZVTCKyFsDAj4fd9PTsjFln+FnVWXGtiUFg4K69iKTH1aN0J5At5HdIyvd55DkDAVrxXhDEUsPj5wQgd9jRItZf4sQ761Ji6ev5N29nSY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com; spf=pass smtp.mailfrom=ew.tq-group.com; dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b=eEXtPq7G; dkim=fail (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b=ripCyzPk reason="key not found in DNS"; arc=none smtp.client-ip=93.104.207.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ew.tq-group.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1727083989; x=1758619989;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=6szGaal/XQsLsZx10pCSTFFiwID2HkfR9WwPzC3n0GI=;
  b=eEXtPq7GSq9GSXO23Sa9hmQo3H/Q/I/DQJny3UB4F5rAZbT3YWFjUoB5
   dcUadcdPtRG+K0Nvbb9hTYVjqV/nFk+p7xFmUSXBJUbS5//osFhCndCGD
   PTA9FUPHoV5h5LzwgnuATxieVavSBXatQ+Y2AwmpKBeglo/Z1fBsVDuH/
   yhRI54kyhG/pa/r/X6FvJ9e3semKusXxDeA9JPv+KwuX9BjUMSh98KVdk
   +xYRqPRQ7/HCIr6D/scWODeK36F3xllwtpkQ1wmG6W3qkTWf2aGCZ6uob
   HQYkGzzuBCCxlQJLMFAQyXBTSB0ndTw7nNICpuo0AQ0C4iQVSe6Kmm3vG
   A==;
X-CSE-ConnectionGUID: aWcYgEGHT+qezaGCvcNK3w==
X-CSE-MsgGUID: +pAqfjMNSmaPS/PngZV53g==
X-IronPort-AV: E=Sophos;i="6.10,251,1719871200"; 
   d="scan'208";a="39066892"
Received: from vmailcow01.tq-net.de ([10.150.86.48])
  by mx1.tq-group.com with ESMTP; 23 Sep 2024 11:33:00 +0200
X-CheckPoint: {66F135CC-2-3BCFFE8C-D8CDCBC9}
X-MAIL-CPID: 6C58804A629CA5E352D79DFDA312284A_4
X-Control-Analysis: str=0001.0A682F20.66F135CC.00B4,ss=1,re=0.000,recu=0.000,reip=0.000,cl=1,cld=1,fgs=0
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id E1A761658B4;
	Mon, 23 Sep 2024 11:32:49 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ew.tq-group.com;
	s=dkim; t=1727083974;
	h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=6szGaal/XQsLsZx10pCSTFFiwID2HkfR9WwPzC3n0GI=;
	b=ripCyzPkxCGJg86aFBXGnpU+1E0m800+4GxUzt4JRn000MazIR42dbuKFlEqn72HnhIYw9
	1MRvW5STp+vEtSm3Heylbj0hqKLRpDPC8CXcoqFGze+EweY3/27Cp1eOAS0uuXMb25np1s
	KXEBa1WuABRtHgc9Ga4X0rsYWsLhXU0TnXhy+x66cj+B4vSFG2ZZyVbvPdoFeYEw4Sp3bD
	A1JHfuJg3vf8o9ojzbHgZf7bYQ5XXUthHHn33OpKtgs+gAfyQmFVXYa4FV8wKvCH+yr2ht
	P4OEQH54xMyL/pskXcNAOTu3zkisz3fmDIEH5lePbv81XXHMF9jp2jY9rWF33w==
Message-ID: <cc14312b391c17443a04129ae7871ae6aba43c20.camel@ew.tq-group.com>
Subject: Re: [PATCH v2 2/2] can: m_can: fix missed interrupts with m_can_pci
From: Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
To: Markus Schneider-Pargmann <msp@baylibre.com>
Cc: Chandrasekar Ramakrishnan <rcsekar@samsung.com>, Marc Kleine-Budde
 <mkl@pengutronix.de>, Vincent Mailhol <mailhol.vincent@wanadoo.fr>, "David
 S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub
 Kicinski <kuba@kernel.org>,  Paolo Abeni <pabeni@redhat.com>, Martin
 =?ISO-8859-1?Q?Hundeb=F8ll?= <martin@geanix.com>, "Felipe Balbi (Intel)"
 <balbi@kernel.org>, Raymond Tan <raymond.tan@intel.com>, Jarkko Nikula
 <jarkko.nikula@linux.intel.com>, linux-can@vger.kernel.org, 
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, linux@ew.tq-group.com
Date: Mon, 23 Sep 2024 11:32:49 +0200
In-Reply-To: <lfxoixj52ip25ys5ndhsn4jhoruucpavstwvwzygsvkmld2vxw@d7yiwmz3jb4y>
References: 
	<ac8c49fffac582176ba1899a85db84e0f5d5c7a6.1726745009.git.matthias.schiffer@ew.tq-group.com>
	 <861164dfe6d95fd69ab2f82528306db6be94351a.1726745009.git.matthias.schiffer@ew.tq-group.com>
	 <lfxoixj52ip25ys5ndhsn4jhoruucpavstwvwzygsvkmld2vxw@d7yiwmz3jb4y>
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

On Mon, 2024-09-23 at 10:03 +0200, Markus Schneider-Pargmann wrote:
> Hi Matthias,
>=20
> On Thu, Sep 19, 2024 at 01:27:28PM GMT, Matthias Schiffer wrote:
> > The interrupt line of PCI devices is interpreted as edge-triggered,
> > however the interrupt signal of the m_can controller integrated in Inte=
l
>=20
> I have a similar patch though for a different setup (I didn't send it
> yet). I have a tcan chip wired to a pin that is only capable of edge
> interrupts.

Should I also change the Fixes tag to something else then?

>=20
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
> >=20
> > v2: introduce flag is_edge_triggered, so we can avoid the loop on !m_ca=
n_pci
> >=20
> >  drivers/net/can/m_can/m_can.c     | 21 ++++++++++++++++-----
> >  drivers/net/can/m_can/m_can.h     |  1 +
> >  drivers/net/can/m_can/m_can_pci.c |  1 +
> >  3 files changed, 18 insertions(+), 5 deletions(-)
> >=20
> > diff --git a/drivers/net/can/m_can/m_can.c b/drivers/net/can/m_can/m_ca=
n.c
> > index 47481afb9add3..2e182c3c98fed 100644
> > --- a/drivers/net/can/m_can/m_can.c
> > +++ b/drivers/net/can/m_can/m_can.c
> > @@ -1207,20 +1207,31 @@ static void m_can_coalescing_update(struct m_ca=
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
>=20
> Could you please remove this hardware specific comment? As mentioned
> above this will be independent of any specific hardware.

Ok.


>=20
> > +	while ((ir_read =3D m_can_read(cdev, M_CAN_IR)) !=3D 0) {
> > +		ir |=3D ir_read;
> > +
> > +		/* ACK all irqs */
> > +		m_can_write(cdev, M_CAN_IR, ir);
> > +
> > +		if (!cdev->is_edge_triggered)
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
> > index 92b2bd8628e6b..8c17eb94d2f98 100644
> > --- a/drivers/net/can/m_can/m_can.h
> > +++ b/drivers/net/can/m_can/m_can.h
> > @@ -99,6 +99,7 @@ struct m_can_classdev {
> >  	int pm_clock_support;
> >  	int pm_wake_source;
> >  	int is_peripheral;
> > +	bool is_edge_triggered;
>=20
> To avoid confusion could you rename it to irq_edge_triggered or
> something similar, to make clear that it is not about the chip but the
> way the interrupt line is connected?

Will do.

>=20
> Also I am not sure it is possible, but could you use
> irq_get_trigger_type() to see if it is a level or edge based interrupt?
> Then we wouldn't need this additional parameter at all and could just
> detect it in m_can.c.

Unfortunately that doesn't seem to work. irq_get_trigger_type() only return=
s a meaningful value
after the IRQ has been requested. I thought about requesting the IRQ with I=
RQF_NO_AUTOEN and then
filling in the irq_edge_triggered field before enabling the IRQ, but IRQF_N=
O_AUTOEN is incompatible
with IRQF_SHARED.

Of course there are ways around this - checking irq_get_trigger_type() from=
 the ISR itself, or
adding more locking, but neither seems quite worthwhile to me. Would you ag=
ree with this?

Maybe there is some other way to find out the trigger type that would be se=
t when the IRQ is
requested? I don't know what that would be however - so I'd just keep setti=
ng the flag statically
for m_can_pci and leave a dynamic solution for future improvement.

Matthias



>=20
> Best
> Markus
>=20
> > =20
> >  	// Cached M_CAN_IE register content
> >  	u32 active_interrupts;
> > diff --git a/drivers/net/can/m_can/m_can_pci.c b/drivers/net/can/m_can/=
m_can_pci.c
> > index d72fe771dfc7a..f98527981402a 100644
> > --- a/drivers/net/can/m_can/m_can_pci.c
> > +++ b/drivers/net/can/m_can/m_can_pci.c
> > @@ -127,6 +127,7 @@ static int m_can_pci_probe(struct pci_dev *pci, con=
st struct pci_device_id *id)
> >  	mcan_class->pm_clock_support =3D 1;
> >  	mcan_class->pm_wake_source =3D 0;
> >  	mcan_class->can.clock.freq =3D id->driver_data;
> > +	mcan_class->is_edge_triggered =3D true;
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
> >=20

--=20
TQ-Systems GmbH | M=C3=BChlstra=C3=9Fe 2, Gut Delling | 82229 Seefeld, Germ=
any
Amtsgericht M=C3=BCnchen, HRB 105018
Gesch=C3=A4ftsf=C3=BChrer: Detlef Schneider, R=C3=BCdiger Stahl, Stefan Sch=
neider
https://www.tq-group.com/

