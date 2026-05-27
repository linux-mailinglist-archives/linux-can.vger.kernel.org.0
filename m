Return-Path: <linux-can+bounces-7714-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GEEOG9IYF2pR4QcAu9opvQ
	(envelope-from <linux-can+bounces-7714-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Wed, 27 May 2026 18:16:18 +0200
X-Original-To: lists+linux-can@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id BF17C5E7959
	for <lists+linux-can@lfdr.de>; Wed, 27 May 2026 18:16:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 46E073015E19
	for <lists+linux-can@lfdr.de>; Wed, 27 May 2026 16:09:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE8AE421EFF;
	Wed, 27 May 2026 16:09:37 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 137784266AA
	for <linux-can@vger.kernel.org>; Wed, 27 May 2026 16:09:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779898176; cv=none; b=R8yMIoqbiMCsU2jXpWvQKLUdc9LrNew1EtJWElFd0Ccu+WJzaoIpylwerUTaF8pxhgvdmUDrhXuMJzQjh5XulV6Tqiff5vl2lgjJ/HZZOzdU0tWJD0+9o9hTc8s6Qr6v3U79/LrFA1+EBz/cEn76Ad81n6wFNF4kV7PniPcIYEo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779898176; c=relaxed/simple;
	bh=4oEQBktbmqHV66JPViGQ/i6DUXjviD9CBogZ41TSoM4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fLTn+9AvG6uWeSFZKnl3dYS/xwINEj/O+jTX97WpVfT4Anm+jIgqNT4x8I7ZwN2kqeLV+VXNs3SvJ8tWoO892+DIFRvb9Rnm7x5p/I9HDwAn1YAsNnt1PWxFs/Dya7/DVnv+kYoIAstbQdns9+AfnSlRXMomSQIwp2AbFnVANKY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtp (Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1wSGof-0005BL-PJ; Wed, 27 May 2026 18:09:09 +0200
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1wSGoe-0028V9-0P;
	Wed, 27 May 2026 18:09:08 +0200
Received: from pengutronix.de (p4ffb2dc6.dip0.t-ipconnect.de [79.251.45.198])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 51A205432C7;
	Wed, 27 May 2026 16:09:08 +0000 (UTC)
Date: Wed, 27 May 2026 18:09:07 +0200
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Pavel Pisa <pisa@fel.cvut.cz>
Cc: Bernhard Beschow <shentey@gmail.com>, 
	=?utf-8?B?TWF0ecOhxaE=?= Bobek <matyas.bobek@gmail.com>, Matyas Bobek <bobekmat@fel.cvut.cz>, qemu-devel@nongnu.org, 
	qemu-arm@nongnu.org, Oliver Hartkopp <socketcan@hartkopp.net>, 
	Nikita Ostrenkov <n.ostrenkov@gmail.com>, "Daniel P. Berrange" <berrange@redhat.com>, 
	Peter Maydell <peter.maydell@linaro.org>, linux-can@vger.kernel.org, Sascha Hauer <s.hauer@pengutronix.de>, 
	Andrey Volkov <andrey.volkov@munic.io>
Subject: Re: [PATCH v3 0/7] hw/arm/sabrelite: Add FlexCAN support
Message-ID: <20260527-fast-unbiased-flamingo-5c5cbe-mkl@pengutronix.de>
X-AI: stop_reason: "refusal"
References: <cover.1777571962.git.matyas.bobek@gmail.com>
 <CAFEAcA95RcGhhN8ZqVeOgRyhRqSar23EnJhCjVgKBwoqXBJwjw@mail.gmail.com>
 <08A7BC6B-7019-45C4-B581-0A26AD3AA554@gmail.com>
 <202605271738.21722.pisa@fel.cvut.cz>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="jpf24v3oghdzyj2v"
Content-Disposition: inline
In-Reply-To: <202605271738.21722.pisa@fel.cvut.cz>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org
X-Spamd-Result: default: False [-1.06 / 15.00];
	SIGNED_PGP(-2.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	FREEMAIL_CC(0.00)[gmail.com,fel.cvut.cz,nongnu.org,hartkopp.net,redhat.com,linaro.org,vger.kernel.org,pengutronix.de,munic.io];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-7714-lists,linux-can=lfdr.de];
	DMARC_NA(0.00)[pengutronix.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mkl@pengutronix.de,linux-can@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-0.997];
	TAGGED_RCPT(0.00)[linux-can];
	R_DKIM_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,linaro.org:email,varma-el.com:email,pengutronix.de:url,pengutronix.de:email,pengutronix.de:mid]
X-Rspamd-Queue-Id: BF17C5E7959
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


--jpf24v3oghdzyj2v
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v3 0/7] hw/arm/sabrelite: Add FlexCAN support
MIME-Version: 1.0

Hello,

On 27.05.2026 17:38:21, Pavel Pisa wrote:
> please, provide your opinion, the license for small Linux kernel
> headers excepts seems to be the last and only blocker for mainlining.
> See the copied code below.

not sure how much help I can provide...

> On Wednesday 27 of May 2026 12:42:23 Bernhard Beschow wrote:
> > Am 8. Mai 2026 12:10:21 UTC schrieb Peter Maydell <peter.maydell@linaro=
=2Eorg>:
> > >On Tue, 5 May 2026 at 21:21, Bernhard Beschow <shentey@gmail.com> wrot=
e:
> > >> Am 5. Mai 2026 18:41:52 UTC schrieb Peter Maydell <peter.maydell@lin=
aro.org>:
> > >> >On Tue, 5 May 2026 at 19:03, Bernhard Beschow <shentey@gmail.com> w=
rote:
> > >> >> I guess the only open issue is the licensing of struct FlexcanRegs
> > >> >> [1] which originates from Linux? How do we proceed here?
> > >> >>
> > >> >> Best regards,
> > >> >> Bernhard
> > >> >>
> > >> >> [1]
> > >> >> https://lore.kernel.org/qemu-devel/202603211316.18181.pisa@fel.cv=
ut.c
> > >> >>z/
> > >> >
> > >> >Could you say what the problem is? In general there is no problem
> > >> >with taking header structs from the Linux kernel, as they are
> > >> >GPL-2-only and that is a QEMU-compatible license. The relevant
> > >> >source files or pieces of source files would need to be noted
> > >> >as 2-only rather than our default of 2-or-later, but that is
> > >> >doable -- we already do that for other things we have borrowed
> > >> >from the kernel.

This would be IMHO the cleared solution. Put these macros into a
separate file with the proper license and copyright headers copied from
the kernel driver.

> > >> In
> > >> https://lore.kernel.org/qemu-devel/f3cb3166-c3f8-4ed8-8c9a-cbf48b071=
d1e@
> > >>gmail.com/ I raised this review question: "The following structure lo=
oks
> > >> like being based on Linux. Does this affect the copyright of this fi=
le?"
> > >> I was just asking for advice and I'm glad the solution is that easy.
> > >
> > >If the struct was copied from the kernel, then it's GPL-2.0-only,
> > >and we should just note the license and where we got the code from.
> > >
> > >If the struct is just very similar to the kernel's one because
> > >it's the obvious representation taken from the datasheet, then
> > >it's not related to the kernel code and we can treat it as
> > >GPL-2.0-or-later like the rest of the file.
> > >
> > >Since Maty=C3=A1=C5=A1 says in the cover letter here "the headers (str=
uct
> > >FlexcanRegs and flexcan_regs.h macros) were copied from the Linux
> > >kernel" then we're in case 1.
> > >
> > >You can mark this up by having the file's SPDX tag be
> > >"SPDX-License-Identifier: (GPL-2.0-only AND GPL-2.0-or-later)"
> > >Then have a normal comment in the file next to the part that is
> > >2.0-only that says
> > >/*
> > > * [This struct / the macros X, Y, Z / whatever ] are borrowed
> > > * from the Linux kernel, and so (unlike the rest of this file)
> > > * they are GPL-2.0-only.
> > > */
> >
> > Ping
> >
> > Any news? With just the license issue remaining, it would be nice to get
> > FlexCAN support into the upcoming release.
>
> The problem is that QEMU maintainers decided to prefer GPL-2.0-or-later
> as the rule for new contributions and Matyas Bobek has reused
> next excepts from Linux kernel sources
>
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/d=
rivers/net/can/flexcan/flexcan-core.c
>
> which have license
>
> // SPDX-License-Identifier: GPL-2.0
> //
> // flexcan.c - FLEXCAN CAN controller driver
> //
> // Copyright (c) 2005-2006 Varma Electronics Oy
> // Copyright (c) 2009 Sascha Hauer, Pengutronix
> // Copyright (c) 2010-2017 Pengutronix, Marc Kleine-Budde <kernel@pengutr=
onix.de>
> // Copyright (c) 2014 David Jander, Protonic Holland
> //
> // Based on code originally by Andrey Volkov <avolkov@varma-el.com>
>
>
> I think, personally, that the code excepts are on the edge
> of the rules for copyright applications because the lines are direct
> transformation of the offests and bit-fields found in the original
> FreeScale/NXP manuals so there should be no problem to use them for
> QEMU and revwite from scratch for copyright clarity with a little
> different naming rules would make only more mess for future updates
> to FexCAN 3 etc.

As you target currently imx6 only, you can re-create them from the imx6
data sheet, it already comes with "C" compatible naming scheme, e.g.:

| "Rx Mailboxes Global Mask Register (FLEXCAN1_RXMGMASK)"

> hw/net/can/flexcan_regs.h
>
> +/**
> + * These macros ware originally written for the Linux kernel
> + * by Marc Kleine-Budde.
> + */

This is not 100% correct. I'm the git-author of the initial mainline
flexcan commit e955cead0311 ("CAN: Add Flexcan CAN controller driver"),
but it already comes with these copyright statements:

+ * Copyright (c) 2005-2006 Varma Electronics Oy
+ * Copyright (c) 2009 Sascha Hauer, Pengutronix
+ * Copyright (c) 2010 Marc Kleine-Budde, Pengutronix
+ *
+ * Based on code originally by Andrey Volkov <avolkov@varma-el.com>

So I cannot re-license even the initial file alone, Sascha is my
co-worker.

Hope that helps,
Marc

--
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--jpf24v3oghdzyj2v
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSl+MghEFFAdY3pYJLMOmT6rpmt0gUCahcXIQAKCRDMOmT6rpmt
0v4gAPkBScCslAu1TO4gkoW/E6JLO0XMxAIl96ySfr8RsOqb9wEAluZKARleMrh/
K959yIMlkc6r/ialHAPgBlJPrqfZVAI=
=psEc
-----END PGP SIGNATURE-----

--jpf24v3oghdzyj2v--

