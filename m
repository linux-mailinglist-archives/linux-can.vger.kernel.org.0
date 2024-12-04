Return-Path: <linux-can+bounces-2337-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 039C79E3932
	for <lists+linux-can@lfdr.de>; Wed,  4 Dec 2024 12:48:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8AE98280E77
	for <lists+linux-can@lfdr.de>; Wed,  4 Dec 2024 11:48:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79D281B3929;
	Wed,  4 Dec 2024 11:48:29 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 117182F22
	for <linux-can@vger.kernel.org>; Wed,  4 Dec 2024 11:48:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733312909; cv=none; b=e+gj4fhVTTEliU0RcvJYTig+oLdjJ/JpmRIrygJhs+fBUVsgJ7RN/o1ogtTUn07gAiWF+AvfQSLUsERJsQCSL/mY8AgxKmcaSG06yKnc0BawiNSnlSqTIo2tnwpS+3EHd5Wse0QwBrDwe/iQl1SsUX5wcBpg+wUUmTc6N0a+bxY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733312909; c=relaxed/simple;
	bh=m+ghy4Awkew6QPTuHp5SbuCCh6zgaq/e1ev+fd2Nmio=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ukh2V1Jj/40L/hYspuIp7CL9hq4o5ZzcMgx3B0XmVDNZJ13yz4PmBKmjWavjHjU5767ltpI2xjbYG+qKvbZM+SNEPBePHdDWdTAM8wHvhhdG+sBq3c8armJx+9ICvMFXufJuD+qRzPqRQLGFJGvw2zanJ1koTgKiYflMhIdADV4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1tInrQ-0005g7-3X; Wed, 04 Dec 2024 12:48:04 +0100
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1tInrO-001ds8-2w;
	Wed, 04 Dec 2024 12:48:03 +0100
Received: from pengutronix.de (pd9e59fec.dip0.t-ipconnect.de [217.229.159.236])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 4635A38565C;
	Wed, 04 Dec 2024 11:48:03 +0000 (UTC)
Date: Wed, 4 Dec 2024 12:48:02 +0100
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Ciprian Marian Costea <ciprianmarian.costea@oss.nxp.com>
Cc: Vincent Mailhol <mailhol.vincent@wanadoo.fr>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, linux-can@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, NXP S32 Linux <s32@nxp.com>, imx@lists.linux.dev, 
	Christophe Lizzi <clizzi@redhat.com>, Alberto Ruiz <aruizrui@redhat.com>, 
	Enric Balletbo <eballetb@redhat.com>
Subject: Re: [PATCH v4 3/3] can: flexcan: add NXP S32G2/S32G3 SoC support
Message-ID: <20241204-fantastic-rare-civet-8d24ec-mkl@pengutronix.de>
References: <20241204074916.880466-1-ciprianmarian.costea@oss.nxp.com>
 <20241204074916.880466-4-ciprianmarian.costea@oss.nxp.com>
 <20241204-chipmunk-of-unmatched-research-e89301-mkl@pengutronix.de>
 <1147e8d9-b6e1-4290-9cfa-888d93f185e9@oss.nxp.com>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="wkzoli5onnal3nbj"
Content-Disposition: inline
In-Reply-To: <1147e8d9-b6e1-4290-9cfa-888d93f185e9@oss.nxp.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org


--wkzoli5onnal3nbj
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v4 3/3] can: flexcan: add NXP S32G2/S32G3 SoC support
MIME-Version: 1.0

On 04.12.2024 13:38:51, Ciprian Marian Costea wrote:
> > Unrelated to this patch, but I want to extend the "FLEXCAN hardware
> > feature flags" table in "flexcan.h". Can you provide the needed
> > information?
> >=20
>=20
> I would say the following S32G related information could be added:
>=20
> > > /* FLEXCAN hardware feature flags
> > >   *
> > >   * Below is some version info we got:
> > >   *    SOC   Version   IP-Version  Glitch- [TR]WRN_INT IRQ Err Memory=
 err RTR rece-   FD Mode     MB
> > >   *                                Filter? connected?  Passive detect=
ion  ption in MB Supported?
> > >   * MCF5441X FlexCAN2  ?               no       yes        no       n=
o        no           no     16
> > >   *    MX25  FlexCAN2  03.00.00.00     no        no        no       n=
o        no           no     64
> > >   *    MX28  FlexCAN2  03.00.04.00    yes       yes        no       n=
o        no           no     64
> > >   *    MX35  FlexCAN2  03.00.00.00     no        no        no       n=
o        no           no     64
> > >   *    MX53  FlexCAN2  03.00.00.00    yes        no        no       n=
o        no           no     64
> > >   *    MX6s  FlexCAN3  10.00.12.00    yes       yes        no       n=
o       yes           no     64
> > >   *    MX8QM FlexCAN3  03.00.23.00    yes       yes        no       n=
o       yes          yes     64
> > >   *    MX8MP FlexCAN3  03.00.17.01    yes       yes        no      ye=
s       yes          yes     64
> > >   *    VF610 FlexCAN3  ?               no       yes        no      ye=
s       yes?          no     64
> > >   *  LS1021A FlexCAN2  03.00.04.00     no       yes        no       n=
o       yes           no     64
> > >   *  LX2160A FlexCAN3  03.00.23.00     no       yes        no      ye=
s       yes          yes     64
>       *  S32G2/S32G3 FlexCAN3 03.00.39.00  no       yes        no      ye=
s       yes          yes    128
> > >   *
> > >   * Some SOCs do not have the RX_WARN & TX_WARN interrupt line connec=
ted.
> > >   */
>=20
> Would you like me to send another version of this patchset with above
> information included ?

No. Once we have Krzysztof's ACK for the DT binding changes, I'll take
this series.

I think we'll make that a separate patch and maybe add more information.

regards,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--wkzoli5onnal3nbj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEUEC6huC2BN0pvD5fKDiiPnotvG8FAmdQQXAACgkQKDiiPnot
vG/cWwf7BsY4qQ2B0RNVdnEdOrirNIF8mOdtvMlQ4y5MgRz1ZrOiKflW/+nnZfYQ
vQ3UV23BhNhyWh28rZDzmFzbEQ4DzlGFSFchrc7ZPizyJ5nQkwWql2/CdSbtRD4r
hg+EdFSZ7OJ9V1odYciU+bIXH8iFOMizYPFBIPG9XKTv5e4AwOMbU7m2yuN58q/F
k6oEDwpdgPG2f+PVSRsDEyBR/REhea6V62ZI9lFwrQJlPs2t65k8ePP6izP6b0Xd
Jndx2sIxWBtjUSZyrtWdSFlsYiSYL9ruU2yFQ/YuaRoq4HBeoZaXtcA5yaDrU/lk
y5rpEt4pMPPM0Qk/bljCwcFIjV9mCw==
=PhJv
-----END PGP SIGNATURE-----

--wkzoli5onnal3nbj--

