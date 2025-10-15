Return-Path: <linux-can+bounces-5198-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 638CABDDD62
	for <lists+linux-can@lfdr.de>; Wed, 15 Oct 2025 11:44:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1DEE93B68D5
	for <lists+linux-can@lfdr.de>; Wed, 15 Oct 2025 09:44:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A87A2C2359;
	Wed, 15 Oct 2025 09:44:06 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F18126B2D2
	for <linux-can@vger.kernel.org>; Wed, 15 Oct 2025 09:44:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760521445; cv=none; b=WAIGKQVJgBWkYrAK8tlY/cscpSnehD2zXnSglSedoE9pEx3hSI5h28xNZfgED4b6TbjeXtuTGaialRpt9RQM8smrlufIysnESyC1YTHwt0lM7YQJPaGY2klxPtSLtM5wxtl9pBvcBeqy38vBUCPaLywIT/S7cPumszxwzPclTMs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760521445; c=relaxed/simple;
	bh=9U3ZA08veq4NXFeHs6p2Z960sdKDOmRWTGa8oh9oEz4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BCi2CNEJAdnT9uYNyEIXaXwpLrgEiA9O8xy/8yipBes6QeKk0sysrx7Mtny96P3eLDGKFeAPbIxSXrgd7svS5j+gDI9rxnXejquLg1xJcP3JgAoVSxo6A+CZmHZG9p+diktQc+iq5vnrOMPsWmxF0YczMcuU1DyGcsqXc6LIj6o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1v8y2y-0001Vg-No; Wed, 15 Oct 2025 11:43:52 +0200
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1v8y2x-003hd7-23;
	Wed, 15 Oct 2025 11:43:51 +0200
Received: from pengutronix.de (p54b152ce.dip0.t-ipconnect.de [84.177.82.206])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 4B7DC486878;
	Wed, 15 Oct 2025 09:43:51 +0000 (UTC)
Date: Wed, 15 Oct 2025 11:43:50 +0200
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, Vincent Mailhol <mailhol@kernel.org>, 
	davem@davemloft.net, kuba@kernel.org, linux-can@vger.kernel.org, 
	kernel@pengutronix.de
Subject: Re: [PATCH net 9/9] can: add Transmitter Delay Compensation (TDC)
 documentation
Message-ID: <20251015-electric-cyber-goshawk-19e7fc-mkl@pengutronix.de>
References: <20251012142836.285370-1-mkl@pengutronix.de>
 <20251012142836.285370-10-mkl@pengutronix.de>
 <1157f3fe-f88b-449f-a4c2-aac9d27c95ea@redhat.com>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="prdkwz2v2jdr6y4b"
Content-Disposition: inline
In-Reply-To: <1157f3fe-f88b-449f-a4c2-aac9d27c95ea@redhat.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org


--prdkwz2v2jdr6y4b
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH net 9/9] can: add Transmitter Delay Compensation (TDC)
 documentation
MIME-Version: 1.0

On 13.10.2025 09:45:14, Paolo Abeni wrote:
> Ni,
>=20
> On 10/12/25 4:20 PM, Marc Kleine-Budde wrote:
> > From: Vincent Mailhol <mailhol@kernel.org>
> >=20
> > Back in 2021, support for CAN TDC was added to the kernel in series [1]
> > and in iproute2 in series [2]. However, the documentation was never
> > updated.
> >=20
> > Add a new sub-section under CAN-FD driver support to document how to
> > configure the TDC using the "ip tool".
> >=20
> > [1] add the netlink interface for CAN-FD Transmitter Delay Compensation=
 (TDC)
> > Link: https://lore.kernel.org/all/20210918095637.20108-1-mailhol.vincen=
t@wanadoo.fr/
> >=20
> > [2] iplink_can: cleaning, fixes and adding TDC support
> > Link: https://lore.kernel.org/all/20211103164428.692722-1-mailhol.vince=
nt@wanadoo.fr/
> >=20
> > Signed-off-by: Vincent Mailhol <mailhol@kernel.org>
> > Link: https://patch.msgid.link/20251012-can-fd-doc-v1-2-86cc7d130026@ke=
rnel.org
> > Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
> > ---
> >  Documentation/networking/can.rst | 60 ++++++++++++++++++++++++++++++++
> >  1 file changed, 60 insertions(+)
> >=20
> > diff --git a/Documentation/networking/can.rst b/Documentation/networkin=
g/can.rst
> > index ccd321d29a8a..402fefae0c2f 100644
> > --- a/Documentation/networking/can.rst
> > +++ b/Documentation/networking/can.rst
> > @@ -1464,6 +1464,66 @@ Example when 'fd-non-iso on' is added on this sw=
itchable CAN FD adapter::
> >     can <FD,FD-NON-ISO> state ERROR-ACTIVE (berr-counter tx 0 rx 0) res=
tart-ms 0
> > =20
> > =20
> > +Transmitter Delay Compensation
> > +~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> > +
> > +At high bit rates, the propagation delay from the TX pin to the RX pin=
 of
> > +the transceiver might become greater than the actual bit time causing
> > +measurement errors: the RX pin would still be measuring the previous b=
it.
> > +
> > +The Transmitter Delay Compensation (thereafter, TDC) resolves this pro=
blem
> > +by introducing a Secondary Sample Point (SSP) equal to the distance, in
> > +minimum time quantum, from the start of the bit time on the TX pin to =
the
> > +actual measurement on the RX pin. The SSP is calculated as the sum of =
two
> > +configurable values: the TDC Value (TDCV) and the TDC offset (TDCO).
> > +
> > +TDC, if supported by the device, can be configured together with CAN-FD
> > +using the ip tool's "tdc-mode" argument as follow::
> > +
> > +- **omitted**: when no "tdc-mode" option is provided, the kernel will
> > +  automatically decide whether TDC should be turned on, in which case =
it
>=20
> The above apparently makes htmldoc unhappy:
>=20
> New errors added
> --- /tmp/tmp.ZsYbmUst3Y	2025-10-12 14:23:45.746737362 -0700
> +++ /tmp/tmp.8o1xOCQtDp	2025-10-12 14:58:29.920405220 -0700
> @@ -15,0 +16 @@
> +/home/doc-build/testing/Documentation/networking/can.rst:1484: ERROR:
> Unexpected indentation.
>=20
> Could you please address the above and send a v2?

Here you go:

| https://lore.kernel.org/all/20251014122140.990472-1-mkl@pengutronix.de/

regards,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--prdkwz2v2jdr6y4b
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEn/sM2K9nqF/8FWzzDHRl3/mQkZwFAmjvbNMACgkQDHRl3/mQ
kZybHAf9HvokYfPsneDaXItKrsldILolFTyJE/48jgBscL7KHD5kjEjAJtRz+l93
GDXy+8xqmTLRnH6dkQClv/UUvMTJbCcssLVMOYgHXeaWR7BlV0o9n9zH8M4eSSsn
a4sEaUj2SJe61gj6Ia5V84G9ExVkZbcKHbcmIcADk/Tb+3rLRW5/04MJeMYtO8Kv
t8moyV1P5ouF7tA4AbvdVRb5Ga+BLbjeEdVIZzHTKp6uSEj+o9Zxhkz+CkuDEbw0
Psd5vbfozEAgiZLRP+owN9kvNuDnpJs/N8J7Q53nwwN5SBBBb9e7ieyMjip8aSMO
TReCCxr2e+YvWVxXlPQXC8Zv0XckNA==
=7TL/
-----END PGP SIGNATURE-----

--prdkwz2v2jdr6y4b--

