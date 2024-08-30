Return-Path: <linux-can+bounces-1236-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 888F7965F7C
	for <lists+linux-can@lfdr.de>; Fri, 30 Aug 2024 12:41:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 45BFA28BBBA
	for <lists+linux-can@lfdr.de>; Fri, 30 Aug 2024 10:41:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB9C4165F05;
	Fri, 30 Aug 2024 10:41:44 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2921D16E866
	for <linux-can@vger.kernel.org>; Fri, 30 Aug 2024 10:41:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725014504; cv=none; b=qzuTRQp1ITrKUOSezQeoVa2QaPIUGWSRJzGgk+Ve42R+pwEptE3ON3fmXRY0uCOkMWn+AL7MZe012XaBPCnLqfaTmuOjsYqwyaATHMd8pnw88Q+eN9V4ahxmc47k/XwllTNoDc0HNLJiG+ZePE9QeI/Pjwf55WkzDTdKGOI6Qak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725014504; c=relaxed/simple;
	bh=nUYhO0WXcCD6WYdXSEvS1Vkk9/GD/8f+q+El5lLAK14=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=L0T6SMQngfXWIVl678Sx8EBMivqxmeGCtVT666Nw9TJSoE1Ug7VoT4Mm+u+1AYkoy9lvVqj0ONdmhZOP6mAGAUWbuxZ+dVtYXZbJDIkrD+VUDATvSRPualv6AhikOxjU1kesteFcSDrqvwdqAaSfc+S+CO2pdxAyuuG8IRbo3Mc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1sjz4F-0001vT-E4; Fri, 30 Aug 2024 12:41:23 +0200
Received: from [2a0a:edc0:0:b01:1d::7b] (helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <mkl@pengutronix.de>)
	id 1sjz4D-00484Y-B7; Fri, 30 Aug 2024 12:41:21 +0200
Received: from pengutronix.de (pd9e5994e.dip0.t-ipconnect.de [217.229.153.78])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 044B632DCDC;
	Fri, 30 Aug 2024 10:41:21 +0000 (UTC)
Date: Fri, 30 Aug 2024 12:41:20 +0200
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Vincent Mailhol <mailhol.vincent@wanadoo.fr>, 
	"David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Fabrizio Castro <fabrizio.castro.jz@renesas.com>, linux-can@vger.kernel.org, netdev@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-renesas-soc@vger.kernel.org, 
	Duy Nguyen <duy.nguyen.rh@renesas.com>
Subject: Re: [PATCH v3] dt-bindings: can: renesas,rcar-canfd: Document R-Car
 V4M support
Message-ID: <20240830-tidy-glistening-bear-44918a-mkl@pengutronix.de>
References: <68b5f910bef89508e3455c768844ebe859d6ff1d.1722520779.git.geert+renesas@glider.be>
 <20240806-fragrant-nimble-crane-c5a129-mkl@pengutronix.de>
 <CAMuHMdXy09rrzB1sc9Soy5mUvMo=u=r_-Yf0iah_HTsYJ+fNDg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="67ai2k6iu5bb2q4h"
Content-Disposition: inline
In-Reply-To: <CAMuHMdXy09rrzB1sc9Soy5mUvMo=u=r_-Yf0iah_HTsYJ+fNDg@mail.gmail.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org


--67ai2k6iu5bb2q4h
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 30.08.2024 12:18:40, Geert Uytterhoeven wrote:
> Hi Marc,
>=20
> On Tue, Aug 6, 2024 at 9:15=E2=80=AFPM Marc Kleine-Budde <mkl@pengutronix=
=2Ede> wrote:
> > On 01.08.2024 16:03:17, Geert Uytterhoeven wrote:
> > > From: Duy Nguyen <duy.nguyen.rh@renesas.com>
> > >
> > > Document support for the CAN-FD Interface on the Renesas R-Car V4M
> > > (R8A779H0) SoC, which supports up to four channels.
> > >
> > > The CAN-FD module on R-Car V4M is very similar to the one on R-Car V4=
H,
> > > but differs in some hardware parameters, as reflected by the Parameter
> > > Status Information part of the Global IP Version Register.  However,
> > > none of this parameterization should have any impact on the driver, as
> > > the driver does not access any register that is impacted by the
> > > parameterization (except for the number of channels).
> > >
> > > Signed-off-by: Duy Nguyen <duy.nguyen.rh@renesas.com>
> > > [geert: Clarify R-Car V4M differences]
> > > Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> >
> > Added to linux-can-next.
>=20
> Looks like you are back from holidays, but haven't pushed linux-can-next
> recently?

I'll update the branch today and send a PR.

regards,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--67ai2k6iu5bb2q4h
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEUEC6huC2BN0pvD5fKDiiPnotvG8FAmbRoc0ACgkQKDiiPnot
vG/ySQgAjPE+xbklHn2bSXifTp2+1FT4kR0Wq+Wa59JfrRpMqQ1zbTj1QG2dfMH7
xcoppAQ7Qn32YljyHiAOl0Fx3tCBXQsg3qFiGbVMRPt+ovStnDBueuK7xx0ApxFs
3/OwrY41fglcF89ihjYbxyYMETj6NTtpOc205Iu/pjcmQ5oidnSEJHgIBVcYheRa
/yFGXdmR8j+5xuwVuLOSM2JhXC8vojHEDF2ywVC4mjMPiXxjVB19Y539OQRL1QWB
5K+Ys/lnVbSfYhiNm8si9/TpAHbly3Rf7sd1zLR5BjlJ+Ak49lOIAA8efODW59bR
HyvOmnNxcBmNFQvtu5Yp6W22X/RDGQ==
=R3+d
-----END PGP SIGNATURE-----

--67ai2k6iu5bb2q4h--

