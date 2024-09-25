Return-Path: <linux-can+bounces-1563-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E3AF9861BC
	for <lists+linux-can@lfdr.de>; Wed, 25 Sep 2024 17:00:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EEC4D1F2BF2B
	for <lists+linux-can@lfdr.de>; Wed, 25 Sep 2024 15:00:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB08E7D3F1;
	Wed, 25 Sep 2024 14:33:28 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1E9519F40D
	for <linux-can@vger.kernel.org>; Wed, 25 Sep 2024 14:33:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727274808; cv=none; b=hiJ0N6IzP7NpfwQ9aKX5g4LghAsP7saWCwW7EmKmCzWg4Li0vGa0AXshmi10ovbHy5+78QQWH93QeF0kCv91M6bYmnUIdDirrbtih4gwVB4KmdE/35mCrrAEcfcjBUj56lQwY9pY03gwrZ+tnAVR7RY9OXHNmjF/MxFkPI7OcUk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727274808; c=relaxed/simple;
	bh=Gkw0SZLaexIV+fDBfNcluwkJYxm6MCNhi51fvgTIF8w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=migfznMbMTI8I4TynhHZMnQ6qLMltpGjI3yM3NlqrmlKqd4EIVg7Jqq+Yz1VCXPM42pMbZJU/bjGSsX1yUS+wUm0RWVSqpsG1crNKo5f/xKGYVaXcvlN4X//etOEvUZgZFnFWzXqtUh+vGi4+XCk/ubcFNvYWUo+aQ2UV/+BZso=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1stT51-0008PO-EK; Wed, 25 Sep 2024 16:33:23 +0200
Received: from [2a0a:edc0:0:b01:1d::7b] (helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <mkl@pengutronix.de>)
	id 1stT50-001TAp-Jc; Wed, 25 Sep 2024 16:33:22 +0200
Received: from pengutronix.de (unknown [IPv6:2a01:4f8:1c1c:29e9:22:41ff:fe00:1400])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 173FB34289C;
	Wed, 25 Sep 2024 14:33:22 +0000 (UTC)
Date: Wed, 25 Sep 2024 16:33:21 +0200
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Sven Schuchmann <schuchmann@schleissheimer.de>
Cc: "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>
Subject: Re: IRQ handler mcp251xfd_handle_tefif() returned -22
Message-ID: <20240925-simple-nondescript-porcupine-d66a23-mkl@pengutronix.de>
References: <FR3P281MB155216711EFF900AD9791B7ED9692@FR3P281MB1552.DEUP281.PROD.OUTLOOK.COM>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="fcirzlls6ximoa46"
Content-Disposition: inline
In-Reply-To: <FR3P281MB155216711EFF900AD9791B7ED9692@FR3P281MB1552.DEUP281.PROD.OUTLOOK.COM>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org


--fcirzlls6ximoa46
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 25.09.2024 07:38:12, Sven Schuchmann wrote:
> I am using Kernel 6.6.47 and sometimes I see this in kernel logs:
>=20
> [  355.728634] mcp251xfd spi0.0 canfd0: IRQ handler mcp251xfd_handle_tefi=
f() returned -22.
> [  355.728672] mcp251xfd spi0.0 canfd0: IRQ handler returned -22 (intf=3D=
0xbf1a0016).
>=20
> After that the complete CAN is down.

Yes, the interface is shut down intentionally in case of errors.

> ifconfig canfd0 down and up fixes the problem.

That's intentional, too :)

> We are using two CANs (both mcp251xfd) at the same time in canfd mode.
> We are sending about 9 Frames each 10ms on  both CANs (bus load of about =
35% per CAN).
>=20
> Top shows about 10% of CPU Load on the SPIs:
>=20
>     PID USER      PR  NI    VIRT    RES    SHR S  %CPU  %MEM     TIME+ CO=
MMAND
>    5620 root     -51   0       0      0      0 S  11.9   0.0   0:45.33 ir=
q/45-spi0.0
>=20
> Anyone an idea on this?

Can you add "dev_err(&spi->dev, ... );" and print interesting things in
mcp251xfd-regmap.c where it returns -EINVAL. Maybe add an additionally
"dump_stack();"

Have you enabled CONFIG_CAN_MCP251XFD_SANITY? If not, please do.
Please also add "#define DEBUG" in mcp251xfd-tef.c before all "#includes".

regards,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--fcirzlls6ximoa46
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEUEC6huC2BN0pvD5fKDiiPnotvG8FAmb0Hy4ACgkQKDiiPnot
vG/sbwgAisQbtGPibnSTZEOb/5VoahU0+K2JHEjLXVivq72a4ijkiT+7gFE+7P+n
W8p+D3sME8j55nopabHWLAgo7igH8512B5N0LAwNsPIUyE0vfSBZupskP824M1yL
CVyoBcjQxl28IdepVHsvSI2+z4pnZY/nw8GpXz9HELtrldIfQlfChIYHqHj0TN5j
Q4criaIagpQCR7AX+SdaLN5DMu4CNh6gqGVNjiP5hHmqjpkJxRmT+zh7MKdnAjUh
xCrKc4eZmEsFF9JbMV1A4w6VPMMlQX/By4YwoniOSfBJOuV+wON1u9R+FJgJcYTr
H73KHkhWNfsPMX4ZNGuLAQ7Otc1JjA==
=Mano
-----END PGP SIGNATURE-----

--fcirzlls6ximoa46--

