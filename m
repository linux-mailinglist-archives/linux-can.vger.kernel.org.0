Return-Path: <linux-can+bounces-1587-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BBDEF98C026
	for <lists+linux-can@lfdr.de>; Tue,  1 Oct 2024 16:35:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6E3841F21B09
	for <lists+linux-can@lfdr.de>; Tue,  1 Oct 2024 14:35:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47F811A08A8;
	Tue,  1 Oct 2024 14:35:19 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CC53282F7
	for <linux-can@vger.kernel.org>; Tue,  1 Oct 2024 14:35:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727793319; cv=none; b=CX0dAMbh9hLtRgqTpXWUtkW6ITTHMrFONh+cQ7zO+T2R0LNlCVu/k/UKWHu/JDk60CBOT4y+MCX9dLhNvHOezeUsz/+ATXUcXpkPEEoTp8489tCrRuazgmO1abUPiFCemaOPxVI6iQDDzQW0OYS6PXIF9SxEvee7x0v6F4BJMb4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727793319; c=relaxed/simple;
	bh=bOvA02m+d1eVNwuWDqQUmqeziRFBg94GBBFS9UEmHJo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WSV9qXCpm8hXDQFsDiYAH2/QP+nVZDkIY2qJnVmDaJKTIhlYvuff1bMcumLNyWXImcrGXzONZra1WcO7Cqa1FWi+j5bXIj5k9W974pnm5qNnyT6vSHcqLv76uQiZjS1k/GfvWhsB7PtN+FTVQBCOyEg1HrP69Ti9WemjQf0PZ7A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1svdy7-0004bb-Qo; Tue, 01 Oct 2024 16:35:15 +0200
Received: from [2a0a:edc0:0:b01:1d::7b] (helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <mkl@pengutronix.de>)
	id 1svdy7-002teO-42; Tue, 01 Oct 2024 16:35:15 +0200
Received: from pengutronix.de (pd9e595f8.dip0.t-ipconnect.de [217.229.149.248])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id CFD03347C26;
	Tue, 01 Oct 2024 14:35:14 +0000 (UTC)
Date: Tue, 1 Oct 2024 16:35:14 +0200
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Sven Schuchmann <schuchmann@schleissheimer.de>
Cc: "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>
Subject: Re: AW: AW: AW: AW: IRQ handler mcp251xfd_handle_tefif() returned -22
Message-ID: <20241001-slick-dynamic-pegasus-200415-mkl@pengutronix.de>
References: <FR3P281MB155216711EFF900AD9791B7ED9692@FR3P281MB1552.DEUP281.PROD.OUTLOOK.COM>
 <20240925-simple-nondescript-porcupine-d66a23-mkl@pengutronix.de>
 <FR3P281MB15522178FE612C6B5B728C2BD96A2@FR3P281MB1552.DEUP281.PROD.OUTLOOK.COM>
 <20240926-pragmatic-colorful-lyrebird-dc8068-mkl@pengutronix.de>
 <FR3P281MB1552B40D19AF9DE8CA8150AAD96A2@FR3P281MB1552.DEUP281.PROD.OUTLOOK.COM>
 <20240927-utopian-super-dolphin-88a1d9-mkl@pengutronix.de>
 <FR3P281MB1552D0C69616DA620C2629ACD96B2@FR3P281MB1552.DEUP281.PROD.OUTLOOK.COM>
 <20240929-upbeat-carrot-whippet-bc3e9c-mkl@pengutronix.de>
 <FR3P281MB15522AE82690498E0E20A66BD9772@FR3P281MB1552.DEUP281.PROD.OUTLOOK.COM>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="hamzh27clfmzkagf"
Content-Disposition: inline
In-Reply-To: <FR3P281MB15522AE82690498E0E20A66BD9772@FR3P281MB1552.DEUP281.PROD.OUTLOOK.COM>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org


--hamzh27clfmzkagf
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 01.10.2024 13:37:07, Sven Schuchmann wrote:
> > If the IRQ handler fails with an error, the driver will generate a dump
> > of the driver and chip state and write it to
> > "/var/log/devcoredump-*.dump". Please send me this file.
> > Please use the unmodified v6.11 version of the driver on your v6.6 kern=
el.
>=20
> File is attached.

Thanks, I think that contains all the necessary information. I'll have
to think about this a bit.

regards,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--hamzh27clfmzkagf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEUEC6huC2BN0pvD5fKDiiPnotvG8FAmb8CJ8ACgkQKDiiPnot
vG9lhQgAlqum1ZxZPIEQdZOnAoAxTWENln09dMeg+/bEXdTgHfIBJ5+pUgBJY4BN
oJGlFNw+9rfZ4FMP5JKS8svJlQ6jRKkMDr7x/0txkbdHrfRuXWckMleWlBFLlrMa
64mJtPhL70pi3CxB9n+fBmIpnRn1GEtlAvEfE0JDwEV0c7pJNeAXTRU89MHFO83u
OW/QvPD8QP7nFhlfTN9Ciwr1ZilWbFr24X1tkMhZi93NDcFAMMOc8+8hn3gTUQw4
6TLJS6x68vK0J+r27b/n3z88dAFWHE7EfbfgRAm5CK5Yq0T2JGvJS410jtTO7A3A
bQ43QCOR9VuU/xd2Y2IX5zXrmTgYuA==
=rSSq
-----END PGP SIGNATURE-----

--hamzh27clfmzkagf--

