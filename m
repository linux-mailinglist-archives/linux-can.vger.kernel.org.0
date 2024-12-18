Return-Path: <linux-can+bounces-2434-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BB219F6589
	for <lists+linux-can@lfdr.de>; Wed, 18 Dec 2024 13:07:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E01C716CA58
	for <lists+linux-can@lfdr.de>; Wed, 18 Dec 2024 12:07:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B79E19F49F;
	Wed, 18 Dec 2024 12:07:29 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6957419E97B
	for <linux-can@vger.kernel.org>; Wed, 18 Dec 2024 12:07:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734523649; cv=none; b=nosD08OKMSZdJiFN0MUt+VFcF3Uhtu7TJ4+V78yU85OcGN6tx5scVxllSk4pImvVVLyE2fkDXmXo+SGcVgVKCg6tRZG6jMdAHDTDHOySvkKxCrAsPbH6bMp7u8iHe984SUrYmDXfCRCCD0d8EslyWfcmDzyjwaAvBBJE5cVZiTU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734523649; c=relaxed/simple;
	bh=A3Q3aiySICafUyM/FGYPJvj3icOL6IVuLCKT1a9ywDI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Pw2yapzvqMWSK4mQxOkNtfkk5O8wN86hA7bi3V7/IIjvU1sVGTiWClsga6eTRohQTSt1aNjCKvV04UWreKha5PJtKKkDwlB3VJ8uW1q4OokYKOOF4s/6QMKLeiDU55d4GuUOfRqU9dME1ta5J/kDKh8nKbOrp0+k8/08uFdJwJE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1tNspf-0001Du-FG; Wed, 18 Dec 2024 13:07:15 +0100
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1tNspd-0041hz-2h;
	Wed, 18 Dec 2024 13:07:14 +0100
Received: from pengutronix.de (pd9e59fec.dip0.t-ipconnect.de [217.229.159.236])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 4B15B391653;
	Wed, 18 Dec 2024 12:07:14 +0000 (UTC)
Date: Wed, 18 Dec 2024 13:07:14 +0100
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: =?utf-8?Q?Pr=C3=BCckl?= Thomas <T.Prueckl@hainzl.at>
Cc: "rcsekar@samsung.com" <rcsekar@samsung.com>, 
	"linux-can@vger.kernel.org" <linux-can@vger.kernel.org>
Subject: Re: AW: net: m_can: missing mutexes in tx_work_queue and isr-handler
Message-ID: <20241218-athletic-pig-of-perfection-14a7e6-mkl@pengutronix.de>
References: <f6a9e128fbc04dcebd70e9b254b344e2@hainzl.at>
 <20241210-sly-impressive-kittiwake-aff4f1-mkl@pengutronix.de>
 <a1de308c7f96475281612c8ffa6fc820@hainzl.at>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="5tf5rj2qqgncud3h"
Content-Disposition: inline
In-Reply-To: <a1de308c7f96475281612c8ffa6fc820@hainzl.at>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org


--5tf5rj2qqgncud3h
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: AW: net: m_can: missing mutexes in tx_work_queue and isr-handler
MIME-Version: 1.0

On 10.12.2024 15:04:29, Pr=C3=BCckl Thomas wrote:
> > Can you show us the patch?
>=20
> My current patch currently just locks the isr and work queue.
> I guess that additional locks are necessary too (e.g. in m_can_close)
>=20
> Subject: [PATCH] can: m_can: added mutex to lock isr and tx work queue

Can you make the locking finer, I mean only lock the register access
which is critical? And keep in mind, that you cannot use mutexes from
the non-threaded IRQ handler, i.e. in non-peripheral mode.

regards,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--5tf5rj2qqgncud3h
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEUEC6huC2BN0pvD5fKDiiPnotvG8FAmdiuu8ACgkQKDiiPnot
vG9XGwgAg8vs6NO1w3OxfUo1wdYCImZJWLSoudufFzANzVv2ccG1dvCM6tedZqRN
vYnUyqN523e5+hduVEN/kjCreHCvTocHLqzdFKRkABrL8KR9OdbTwR6fpy1Y1W+m
YvPx7ua7NaQkZb/waXL2aL8tfXgwh2OKkoE5kU8opo8SsbgSpjOFDbv5Rfa1WDj1
9YILV2TJjWvzUw0d1+W6eOeFz/DhlggK4WDOk78zY0JBhqfSBDDKzKSOBaNCl16x
lx/Q8LZjODw7H0pvJ8Po5wRzlpULN34y4jZdDyGYR+rO/IkgNymLKaIZukm3uoL/
1A51s6wsHKZ4URDz1Un4739l5ScX0A==
=XDb7
-----END PGP SIGNATURE-----

--5tf5rj2qqgncud3h--

