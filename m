Return-Path: <linux-can+bounces-2138-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DE9A49D398E
	for <lists+linux-can@lfdr.de>; Wed, 20 Nov 2024 12:34:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0DA5CB238DD
	for <lists+linux-can@lfdr.de>; Wed, 20 Nov 2024 11:34:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 863D416F907;
	Wed, 20 Nov 2024 11:34:12 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1EDE17BB2E
	for <linux-can@vger.kernel.org>; Wed, 20 Nov 2024 11:34:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732102452; cv=none; b=tz+qp+17TxFCsL/lyuYTaAohnBykdcA8is8RBf1WA5tr0AZQjibSbl3iwtSfwpkg5InT+dSJKhwIrLmFPqz7viAknkfgwbpxb0nDppq2vvS6dnBz5THSoUGKHYBbJFm57cb42C1PhmmfaPBL2CbRe3SnG3OJU6deSb+qNAfuCfY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732102452; c=relaxed/simple;
	bh=rqYE/LDFYG+MmMRSDPJ7ITKApe4LdqoAau/AARTvmnQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MNJDZVUtnjF0FLOrL/EPrTt5FMpkPcnGlnOzzCOvek5KZigVX8/AdMRe/WDI3duhpXLwrzhdsgGMV6BQYyxIJCKtlf9sER8uZkGPPAc5E+e+L2dEH+lQxnV+eidLy0/rcEhMvtKRZGcEZ8ZdZow92icu23Mo1/vojSWTDK6PWxw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1tDixq-0000PP-So; Wed, 20 Nov 2024 12:33:42 +0100
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1tDixp-001jS8-0J;
	Wed, 20 Nov 2024 12:33:41 +0100
Received: from pengutronix.de (pd9e59fec.dip0.t-ipconnect.de [217.229.159.236])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id ADF44377CB4;
	Wed, 20 Nov 2024 11:33:40 +0000 (UTC)
Date: Wed, 20 Nov 2024 12:33:40 +0100
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Ciprian Marian Costea <ciprianmarian.costea@oss.nxp.com>
Cc: Vincent Mailhol <mailhol.vincent@wanadoo.fr>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S . Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, linux-can@vger.kernel.org, 
	netdev@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	imx@lists.linux.dev, NXP Linux Team <s32@nxp.com>, 
	Christophe Lizzi <clizzi@redhat.com>, Alberto Ruiz <aruizrui@redhat.com>, 
	Enric Balletbo <eballetb@redhat.com>
Subject: Re: [PATCH 3/3] can: flexcan: handle S32G2/S32G3 separate interrupt
 lines
Message-ID: <20241120-spirited-vulture-of-coffee-423adb-mkl@pengutronix.de>
References: <20241119081053.4175940-1-ciprianmarian.costea@oss.nxp.com>
 <20241119081053.4175940-4-ciprianmarian.costea@oss.nxp.com>
 <20241120-magnificent-accelerated-robin-70e7ef-mkl@pengutronix.de>
 <c9d8ff57-730f-40d9-887e-d11aba87c4b5@oss.nxp.com>
 <20241120-venomous-skilled-rottweiler-622b36-mkl@pengutronix.de>
 <aa73f763-44bc-4e59-ad4a-ccaedaeaf1e8@oss.nxp.com>
 <20241120-cheerful-pug-of-efficiency-bc9b22-mkl@pengutronix.de>
 <72d06daa-82ed-4dc6-8396-fb20c63f5456@oss.nxp.com>
 <20241120-rational-chocolate-marten-70ed52-mkl@pengutronix.de>
 <06acdf7f-3b35-48bc-ab2e-9578221b7aea@oss.nxp.com>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="idbngjom6ttlxwj6"
Content-Disposition: inline
In-Reply-To: <06acdf7f-3b35-48bc-ab2e-9578221b7aea@oss.nxp.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org


--idbngjom6ttlxwj6
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH 3/3] can: flexcan: handle S32G2/S32G3 separate interrupt
 lines
MIME-Version: 1.0

On 20.11.2024 13:02:56, Ciprian Marian Costea wrote:
> On 11/20/2024 12:54 PM, Marc Kleine-Budde wrote:
> > On 20.11.2024 12:47:02, Ciprian Marian Costea wrote:
> > > > > > > The mainline driver already handles the 2nd mailbox range (sa=
me
> > > > > > > 'flexcan_irq') is used. The only difference is that for the 2=
nd mailbox
> > > > > > > range a separate interrupt line is used.
> > > > > >=20
> > > > > > AFAICS the IP core supports up to 128 mailboxes, though the dri=
ver only
> > > > > > supports 64 mailboxes. Which mailboxes do you mean by the "2nd =
mailbox
> > > > > > range"? What about mailboxes 64..127, which IRQ will them?
> > > > >=20
> > > > > On S32G the following is the mapping between FlexCAN IRQs and mai=
lboxes:
> > > > > - IRQ line X -> Mailboxes 0-7
> > > > > - IRQ line Y -> Mailboxes 8-127 (Logical OR of Message Buffer Int=
errupt
> > > > > lines 127 to 8)
> > > > >=20
> > > > > By 2nd range, I was refering to Mailboxes 8-127.
> > > >=20
> > > > Interesting, do you know why it's not symmetrical (0...63, 64...127=
)?
> > > > Can you point me to the documentation.
> > >=20
> > > Unfortunately I do not know why such hardware integration decisions h=
ave
> > > been made.
> > >=20
> > > Documentation for S32G3 SoC can be found on the official NXP website,
> > > here:
> > > https://www.nxp.com/products/processors-and-microcontrollers/s32-auto=
motive-platform/s32g-vehicle-network-processors/s32g3-processors-for-vehicl=
e-networking:S32G3
> > >=20
> > > But please note that you need to setup an account beforehand.
> >=20
> > I have that already, where is the mailbox to IRQ mapping described?
> >=20
> > regards,
> > Marc
> >=20
>=20
> If you have successfully downloaded the Reference Manual for S32G2 or S32=
G3
> SoC, it should have attached an excel file describing all the interrupt
> mappings.

I downloaded the S32G3 Reference Manual:

| https://www.nxp.com/webapp/Download?colCode=3DRMS32G3

It's a pdf. Where can I find the execl file?

> In the excel file, if you search for 'FlexCAN_0' for example, you should =
be
> able to find IRQ lines 39 and 40 which correspond to Maiboxes 0-7 and 8-1=
29
> (ored) previously discussed.

regards,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--idbngjom6ttlxwj6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEUEC6huC2BN0pvD5fKDiiPnotvG8FAmc9yREACgkQKDiiPnot
vG/Bhwf/TmgOWpK70qWkVmuc6pmKnZd7518rr3HRby5yKjHlz9lMpMU+rdevXATt
Eb1uT7wi4HkmIFcogcLaLaMiqlCd+r+4R4rdb1s93NNBMcTVqJPQUFcOGzmkW6Vm
yhVdQRO2wbLTxizGSbKnJZEwVrSO+i45FBAzWiDOjfn5D4HTdcycQE7LQUr/d26l
aBMOdm4qLqK/g5lnYFE6PipHYnhyTrVCRMJmBYItO7SvwhYf1lfMKx9JG6qUWINS
tMJThoELNypy4s5miXbs6ohkPtcTDbcSFBMiBbc8d9aAUsJ0yjTmW5FQ8noxsaGX
3y9ERfkDZbXgGXInziFvzYiXtXpRCQ==
=qt5d
-----END PGP SIGNATURE-----

--idbngjom6ttlxwj6--

