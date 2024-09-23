Return-Path: <linux-can+bounces-1539-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9026997EA71
	for <lists+linux-can@lfdr.de>; Mon, 23 Sep 2024 13:07:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C13C41C20F3D
	for <lists+linux-can@lfdr.de>; Mon, 23 Sep 2024 11:07:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F26F9197A92;
	Mon, 23 Sep 2024 11:06:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b="pe2CRJTt";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b="Yf8oDo8X"
X-Original-To: linux-can@vger.kernel.org
Received: from mx1.tq-group.com (mx1.tq-group.com [93.104.207.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 588E1197549;
	Mon, 23 Sep 2024 11:06:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.104.207.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727089616; cv=none; b=WhCe6zrSeXKQDjl+R/9xuohwZpKnerE83TsymbOrOpGeclxug3IXkS27gSILK0oNwa2Wn6z1ExZ5DFxejuzHxYSkzRTLCoCyfE+m46wh2gTPwKXg0vqakO1KNe1vS8ghLF5RCGgMmVidqHBD/zIYiGlELBcZrs79awPrKVTfdW4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727089616; c=relaxed/simple;
	bh=NUwoXVjP0DXzj/mDS2AXKUKlXgpn964UGAmMJ+Er5nw=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=DWImxx5j5bb0pV92Kp8BMZriHlEj0Q50Txn+tHicjKTjheGmHjVthdAFuwDdiiV6jxpx0ZGE3rfgO9vkIkshqiQipu/dOwVw+DMCApYac8tiwV9StlfhS1hYUko3Fise/zNqSy3X7u4fGWfGkhROc2m1bTNwhlr7ABJ2TfNM1UQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com; spf=pass smtp.mailfrom=ew.tq-group.com; dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b=pe2CRJTt; dkim=fail (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b=Yf8oDo8X reason="key not found in DNS"; arc=none smtp.client-ip=93.104.207.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ew.tq-group.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1727089613; x=1758625613;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=NUwoXVjP0DXzj/mDS2AXKUKlXgpn964UGAmMJ+Er5nw=;
  b=pe2CRJTte7f/VCjw6BdbfRzKGyHJhDg24L2AiGacg6P4Ip+gD2P4vvlz
   kyOjyexJSe7UbLWzsyyFr3VMFZBNsLWwHqYXmNjJouWoescEtgBfTFxsn
   OHcnvqz0X3kRBloXjiE1gIQwTV1mY03QF4dA3GlUIbF0zDlzMrLNZV/KI
   0SVg7x9PjUa5MtchXO4JYxMqiGm0dhWaA8zKo1jl2++gheuQYGD2pu1Ob
   OFh8M0nacTXZMaLnmRuCmA+0MQ2zqPxKLCCaKTgU7xc22iAA1PZXKFpiV
   KjC5u88EANjOvYVdsnBsKzwHBoAD/xmLJL2sf2B+1PWMM3J0C/asx7jI7
   A==;
X-CSE-ConnectionGUID: reDRXPcsSJGf7t0wixE+Dw==
X-CSE-MsgGUID: UEsOEtLhSXGYx8/hZv8Zvg==
X-IronPort-AV: E=Sophos;i="6.10,251,1719871200"; 
   d="scan'208";a="39069132"
Received: from vmailcow01.tq-net.de ([10.150.86.48])
  by mx1.tq-group.com with ESMTP; 23 Sep 2024 13:06:49 +0200
X-CheckPoint: {66F14BC9-17-B8661266-C8AC785A}
X-MAIL-CPID: 0B579DCDA0D8C38CD81507ADAA3CE170_5
X-Control-Analysis: str=0001.0A682F1C.66F14BC9.0111,ss=1,re=0.000,recu=0.000,reip=0.000,cl=1,cld=1,fgs=0
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 8C31B16E7EF;
	Mon, 23 Sep 2024 13:06:40 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ew.tq-group.com;
	s=dkim; t=1727089605;
	h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=NUwoXVjP0DXzj/mDS2AXKUKlXgpn964UGAmMJ+Er5nw=;
	b=Yf8oDo8XZNQEaRxj1OBNGDDUQYlV4z2sW4F5kPdkOsIGXLANM5GTfd4BB662Q7KLb4tYhg
	RTYg/uVvgWCXedRgnwPsw6x9yh9fH/iX3CfulL28TX94mDieZTXM5FKKlqs5vi3GUdE62a
	kaWb+c2hKrl8WjBi1bZZGYHfrF+CrO6J2RhXLhRbakxUl3LHPC1E6oB3JtCvACfXAgIbvX
	wBSiecQINJpWXSG4R4nSDpBOuLQmE1bfOZL42i7Mzt1PqJXn89ddTkG8aXh74GBN9Hn+DT
	T7AOliK3et0fJPOGF0QMWAnXgf4l3Sa/VYZmNmLH8MtdrlscIo6AX098t15iWg==
Message-ID: <28314c36f464e1d39f71c0a60997c38fd6775172.camel@ew.tq-group.com>
Subject: Re: [PATCH v2 2/2] can: m_can: fix missed interrupts with m_can_pci
From: Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: Chandrasekar Ramakrishnan <rcsekar@samsung.com>, Vincent Mailhol
 <mailhol.vincent@wanadoo.fr>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo
 Abeni <pabeni@redhat.com>,  Martin =?ISO-8859-1?Q?Hundeb=F8ll?=
 <martin@geanix.com>, Markus Schneider-Pargmann <msp@baylibre.com>, "Felipe
 Balbi (Intel)" <balbi@kernel.org>, Raymond Tan <raymond.tan@intel.com>,
 Jarkko Nikula <jarkko.nikula@linux.intel.com>, linux-can@vger.kernel.org, 
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux@ew.tq-group.com,  lst@pengutronix.de
Date: Mon, 23 Sep 2024 13:06:40 +0200
In-Reply-To: <20240923-honored-ant-of-ecstasy-f7edae-mkl@pengutronix.de>
References: 
	<ac8c49fffac582176ba1899a85db84e0f5d5c7a6.1726745009.git.matthias.schiffer@ew.tq-group.com>
	 <861164dfe6d95fd69ab2f82528306db6be94351a.1726745009.git.matthias.schiffer@ew.tq-group.com>
	 <20240923-honored-ant-of-ecstasy-f7edae-mkl@pengutronix.de>
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

On Mon, 2024-09-23 at 12:17 +0200, Marc Kleine-Budde wrote:
> On 19.09.2024 13:27:28, Matthias Schiffer wrote:
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
> My coworker Lucas pointed me to:
>=20
> > https://wiki.linuxfoundation.org/networking/napi#non-level_sensitive_ir=
qs
>=20

Thanks. I don't think this is directly applicable here - in our case the lo=
st TX complete interrupts
were the issue, not (only) the RX interrupts.

Matthias


> On the other hand, I would also like to convert the !peripteral part of
> the driver to rx-offload. However, I am still looking for potential
> customers for this task. I have talked to some TI and ST people at LPC,
> maybe they are interested.
>=20
> I think let's first fix edge sensitive IRQs, then rework the driver to
> rx-offload.
>=20
> regards,
> Marc
>=20
> =C2=A0

--=20
TQ-Systems GmbH | M=C3=BChlstra=C3=9Fe 2, Gut Delling | 82229 Seefeld, Germ=
any
Amtsgericht M=C3=BCnchen, HRB 105018
Gesch=C3=A4ftsf=C3=BChrer: Detlef Schneider, R=C3=BCdiger Stahl, Stefan Sch=
neider
https://www.tq-group.com/

