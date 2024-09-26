Return-Path: <linux-can+bounces-1566-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DFE349870ED
	for <lists+linux-can@lfdr.de>; Thu, 26 Sep 2024 11:57:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A0B5D287EF2
	for <lists+linux-can@lfdr.de>; Thu, 26 Sep 2024 09:57:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B8671AC89C;
	Thu, 26 Sep 2024 09:57:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b="LzRUp8DR";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b="p8ma48a1"
X-Original-To: linux-can@vger.kernel.org
Received: from mx1.tq-group.com (mx1.tq-group.com [93.104.207.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1194F347B4;
	Thu, 26 Sep 2024 09:57:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.104.207.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727344670; cv=none; b=uQKzUMhXGbLdOvVPZal5lJEhUVV3D6rGuoW8qs9zVhxlnFq47dpED8JspWRBYB7LauABQIRLVdz0vX+vkGzJtHjypXMIuxyTTt9t8mWg9i2/Y4WUHFti1x7lb02q0pqk8nIitMN8A44YAAwd2DCNQ8oOWkhnYLw39uc8YAbC4a4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727344670; c=relaxed/simple;
	bh=gghXGsGxMSeLbedt0Z899uTBrkY6l6YeHBv2u6yBW+Q=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=d2zUNRQDjlN/vZvlO7WzEMAixxTDWMuwOmTQLK9z43s/QO7Hv53nHgD+FPOR5UvTxPB44Q9wbqguqyekvm+enrp3HmCFE/198EmO6whvq87obv4E05vbrA8Uw6WFZZZbLGQ0nKVKpJ5gtn443QRivxnVy8/iKnnIdC1XVd9mm6I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com; spf=pass smtp.mailfrom=ew.tq-group.com; dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b=LzRUp8DR; dkim=fail (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b=p8ma48a1 reason="key not found in DNS"; arc=none smtp.client-ip=93.104.207.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ew.tq-group.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1727344666; x=1758880666;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=gghXGsGxMSeLbedt0Z899uTBrkY6l6YeHBv2u6yBW+Q=;
  b=LzRUp8DRoq+rg3PVhwwmY9Q975YB86T10GdpD6PRMm8GqVGd4aQ7r9B3
   q/DIs2AbCdPSlhHH2ezpybrO7YKtOsGI0IaNOwPuvPd0PPOaZsy9xbcL7
   Ur5eoFZj8hyvag1oT2BNJ3rqDa86F2c8nronyzf+fyZVwz4d52TrMG0g7
   IIH7oQj2Tm8vRm+lrGIs8pwL2035HohgMauqirUWAphzOpi9TfZPiUeuz
   dBh64POqSmbv/JAa72vcdFHqPr2F7MzFag1shM//8b6dFaRCwkhVMIM/N
   6SaNmjnVeE4TDlg/dU6x0yD7chgNPSLaFHinEzUJduiokPANvd2mdAzFH
   g==;
X-CSE-ConnectionGUID: 4n8MSeCsR96mnTmGj5WqZA==
X-CSE-MsgGUID: qWdyFDreTQ+aSJ+yrogQUQ==
X-IronPort-AV: E=Sophos;i="6.10,155,1719871200"; 
   d="scan'208";a="39139036"
Received: from vmailcow01.tq-net.de ([10.150.86.48])
  by mx1.tq-group.com with ESMTP; 26 Sep 2024 11:57:43 +0200
X-CheckPoint: {66F53017-C-B62731C4-FB8D8F8A}
X-MAIL-CPID: 402C6AABCA872EA129630ACDBF17DFE8_3
X-Control-Analysis: str=0001.0A682F1A.66F53016.002F,ss=1,re=0.000,recu=0.000,reip=0.000,cl=1,cld=1,fgs=0
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 5C623163FB1;
	Thu, 26 Sep 2024 11:57:35 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ew.tq-group.com;
	s=dkim; t=1727344658;
	h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=gghXGsGxMSeLbedt0Z899uTBrkY6l6YeHBv2u6yBW+Q=;
	b=p8ma48a1qDNPoSG7GlvbraozPjyPsOq7sMIYv0AmL2UmUW+2Y/uX5TaGmwdnp7v79AepDK
	24mjha3LzFMzncoUzlCToblPQG5J/QE0QltPKG3REC7FWUouViBizgO6Wxm5p4e/LJ2phb
	pB3cbwqrgYks2T9/Va+G1kLdaGh4wU7Qg5wEsPIvDW8sNofrxFIkdHPRrCwSDCmr+91p4+
	iHNtt2vPGyaDhhprNJd/iTK9c8jQy1mXonLJW2uZc9x4+BspOQEMwSktqmCow9e1MYTLsL
	ZUA93HQvQ39w6Hu1glYL+6o1A5/vX7jqf3LhLB+cS9/iPuViiGxJoUy2Tt3VKA==
Message-ID: <2af8a6cb2d2b4606abf48f0d2d0048e06f97fe51.camel@ew.tq-group.com>
Subject: Re: [PATCH v3 2/2] can: m_can: fix missed interrupts with m_can_pci
From: Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: Markus Schneider-Pargmann <msp@baylibre.com>, Chandrasekar Ramakrishnan
 <rcsekar@samsung.com>, Vincent Mailhol <mailhol.vincent@wanadoo.fr>, "David
 S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub
 Kicinski <kuba@kernel.org>,  Paolo Abeni <pabeni@redhat.com>, Martin
 =?ISO-8859-1?Q?Hundeb=F8ll?= <martin@geanix.com>, "Felipe Balbi (Intel)"
 <balbi@kernel.org>, Raymond Tan <raymond.tan@intel.com>, Jarkko Nikula
 <jarkko.nikula@linux.intel.com>, linux-can@vger.kernel.org, 
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, linux@ew.tq-group.com
Date: Thu, 26 Sep 2024 11:57:34 +0200
In-Reply-To: <20240926-resilient-arrogant-limpet-98af37-mkl@pengutronix.de>
References: 
	<ed86ab0d7d2b295dc894fc3e929beb69bdc921f6.1727092909.git.matthias.schiffer@ew.tq-group.com>
	 <4715d1cfed61d74d08dcc6a27085f43092da9412.1727092909.git.matthias.schiffer@ew.tq-group.com>
	 <6qk7fmbbvi5m3evyriyq4txswuzckbg4lmdbdkyidiedxhzye5@av3gw7vweimu>
	 <1a4ed0696cbe222e50b5abdff08a5ce7f8223aae.camel@ew.tq-group.com>
	 <20240926-resilient-arrogant-limpet-98af37-mkl@pengutronix.de>
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

On Thu, 2024-09-26 at 11:43 +0200, Marc Kleine-Budde wrote:
> On 26.09.2024 11:19:53, Matthias Schiffer wrote:
> > On Tue, 2024-09-24 at 08:08 +0200, Markus Schneider-Pargmann wrote:
> > >=20
> > > On Mon, Sep 23, 2024 at 05:32:16PM GMT, Matthias Schiffer wrote:
> > > > The interrupt line of PCI devices is interpreted as edge-triggered,
> > > > however the interrupt signal of the m_can controller integrated in =
Intel
> > > > Elkhart Lake CPUs appears to be generated level-triggered.
> > > >=20
> > > > Consider the following sequence of events:
> > > >=20
> > > > - IR register is read, interrupt X is set
> > > > - A new interrupt Y is triggered in the m_can controller
> > > > - IR register is written to acknowledge interrupt X. Y remains set =
in IR
> > > >=20
> > > > As at no point in this sequence no interrupt flag is set in IR, the
> > > > m_can interrupt line will never become deasserted, and no edge will=
 ever
> > > > be observed to trigger another run of the ISR. This was observed to
> > > > result in the TX queue of the EHL m_can to get stuck under high loa=
d,
> > > > because frames were queued to the hardware in m_can_start_xmit(), b=
ut
> > > > m_can_finish_tx() was never run to account for their successful
> > > > transmission.
> > > >=20
> > > > To fix the issue, repeatedly read and acknowledge interrupts at the
> > > > start of the ISR until no interrupt flags are set, so the next inco=
ming
> > > > interrupt will also result in an edge on the interrupt line.
> > > >=20
> > > > Fixes: cab7ffc0324f ("can: m_can: add PCI glue driver for Intel Elk=
hart Lake")
> > > > Signed-off-by: Matthias Schiffer <matthias.schiffer@ew.tq-group.com=
>
> > >=20
> > > Just a few comment nitpicks below. Otherwise:
> > >=20
> > > Reviewed-by: Markus Schneider-Pargmann <msp@baylibre.com>
> >=20
> >=20
> > We have received a report that while this patch fixes a stuck queue iss=
ue reproducible with cangen,
> > the problem has not disappeared with our customer's application. I will=
 hold off sending a new
> > version of the patch while we're investigating whether there is a separ=
ate issue with the same
> > symptoms or the patch is insufficient.
> >=20
> > Patch 1/2 should be good to go and could be applied independently.
>=20
> Can you post the reproducer here, too. So that we can add it to the
> patch or at least reference to it.
>=20
> regards,
> Marc

Something like the following results in a stuck queue after a few minutes w=
ithout this patch, and
ran without issue for 2.5h with the patch (with can0 and can1 of the Elkhar=
t Lake connected to each
other):

---
ip link set can0 up type can bitrate 1000000
ip link set can1 up type can bitrate 1000000

cangen can1 -g 2 -I 100 -L 8 &
cangen can1 -g 2 -I 101 -L 8 &
cangen can1 -g 2 -I 102 -L 8 &
cangen can1 -g 2 -I 103 -L 8 &
cangen can1 -g 2 -I 104 -L 8 &
cangen can1 -g 2 -I 105 -L 8 &
cangen can1 -g 2 -I 106 -L 8 &
cangen can1 -g 2 -I 107 -L 8 &

cangen can0 -g 2 -I 000 -L 8 &
cangen can0 -g 2 -I 001 -L 8 &
cangen can0 -g 2 -I 002 -L 8 &
cangen can0 -g 2 -I 003 -L 8 &
cangen can0 -g 2 -I 004 -L 8 &
cangen can0 -g 2 -I 005 -L 8 &
cangen can0 -g 2 -I 006 -L 8 &
cangen can0 -g 2 -I 007 -L 8 &

stress-ng --matrix 0 &
---

I will add the reproducer to the commit message in v4. I'm also not sure if=
 the stress-ng actually
has any effect, I'll verify that before the next version of the patch.

Matthias


>=20

--=20
TQ-Systems GmbH | M=C3=BChlstra=C3=9Fe 2, Gut Delling | 82229 Seefeld, Germ=
any
Amtsgericht M=C3=BCnchen, HRB 105018
Gesch=C3=A4ftsf=C3=BChrer: Detlef Schneider, R=C3=BCdiger Stahl, Stefan Sch=
neider
https://www.tq-group.com/

