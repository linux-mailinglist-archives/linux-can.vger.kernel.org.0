Return-Path: <linux-can+bounces-302-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4ABC985A372
	for <lists+linux-can@lfdr.de>; Mon, 19 Feb 2024 13:33:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7B5831C23365
	for <lists+linux-can@lfdr.de>; Mon, 19 Feb 2024 12:33:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2AF31DFFD;
	Mon, 19 Feb 2024 12:31:18 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 763F42E64F
	for <linux-can@vger.kernel.org>; Mon, 19 Feb 2024 12:31:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708345878; cv=none; b=spSM3F6IEjgil2rtyH6fmh+59B0nwNGydmmue0Ym5PPvEHy6pbiKYhsSLxFNBhrhoZzgo6okx6jagASK+UU1P1sxWXd8ENZadhdUhOUPHMHRYHOwvkO7Ah88ZN10iCBG+0Y9TB21iKfUo7USSBsqL/f9n81ksFlP+O9iqT5RxvA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708345878; c=relaxed/simple;
	bh=UuNvH/QPrgjsQMx2gtqQpI6wmz/66gtu83PJNAIobIg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ze4gvFxNGZAoHIQlgino35QJ3TDXgki32wxYkDO7it2apSVJ0QXfntH5omMRA42+i7SIy0KhVR/lfqMk0jjhMiV4JqD7ovkfwpyT+GknBVe16ww5GbxnzGYYsJj8O9xhKsLdU4YW5wLdHASKHMECL4rdwDIfLWc0Xqbu36WcWjE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1rc2ng-0007oN-FI; Mon, 19 Feb 2024 13:31:12 +0100
Received: from [2a0a:edc0:0:b01:1d::7b] (helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <mkl@pengutronix.de>)
	id 1rc2nf-001eAh-S7; Mon, 19 Feb 2024 13:31:11 +0100
Received: from pengutronix.de (unknown [172.20.34.65])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 8D75A2924F4;
	Mon, 19 Feb 2024 12:31:11 +0000 (UTC)
Date: Mon, 19 Feb 2024 13:31:11 +0100
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: "Dr. Michael Lauer" <mickey@vanille.de>
Cc: Oliver Hartkopp <socketcan@hartkopp.net>, linux-can@vger.kernel.org
Subject: Re: Protocol recommendation for CAN(FD)-USB adapter
Message-ID: <20240219-contend-catfight-cd49fff06252-mkl@pengutronix.de>
References: <20240216-acclaim-impromptu-4474f57f9761-mkl@pengutronix.de>
 <AEC70E89-BC6E-429A-B756-385ADC2B3E85@vanille.de>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="gydx2f3ytdszxvgx"
Content-Disposition: inline
In-Reply-To: <AEC70E89-BC6E-429A-B756-385ADC2B3E85@vanille.de>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org


--gydx2f3ytdszxvgx
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 18.02.2024 10:45:02, Dr. Michael Lauer wrote:
> >> https://github.com/candle-usb/candleLight_fw
> >>=20
> >> ... where currently the CAN FD support is in the testing phase IIRC.
> >=20
> > The USB protocol for CAN-FD is stable and supported by the kernel and
> > the Work-In-Progress firmware. The firmware can be found here:
> >=20
> > | https://github.com/candle-usb/candleLight_fw/pull/139
> > | https://github.com/candle-usb/candleLight_fw/pull/176
> >=20
> > We're currently discussing the implementation details of the firmware,
> > but the USB part is, as mentioned above, stable
>=20
> Sounds pretty cool. Our design is based on an ESP32-S3 though, so I
> have to duplicate that effort. Is there some kind of USB protocol
> definition for what gs-usb expects or do I need to learn that from the
> implementation?

I've put together a very rough summary of the driver's side of view:

https://gist.github.com/marckleinebudde/99f72d9db67accf08cc6efa367cfe54b

Feel free to update.

Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--gydx2f3ytdszxvgx
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEUEC6huC2BN0pvD5fKDiiPnotvG8FAmXTSgsACgkQKDiiPnot
vG/nwAf/c1N+vG92DxgoOxvrKRxdR6VWPumMqHA0iy0+whSgSqgcQML38Jr8zFMe
yQyitFzeh/ezFeQbShYFg8dyqx+/UKauUIeG3WdmClfg4dcdLT63m9Q0DV9uyU++
WOP5AcxVzwwquxlbNbPv/E9Q+pRuyI7mYf5kBVDoUDlgLavB0AsoIhmhncrmZdlx
5nbI8b55WW1G8WrE01tVXIr0RgdQd/lFTc1yNcGkBrTAXVFDrLg+MY6fjLfiBvBh
seAX6TZbvnkUszZJ5RLr+ySOYBt3a8wwcbWFn9JCJkzedffeY/gTtg8AH/nlabUu
la0ISHN9lad9p72ZuHkBAlRkeLbJGg==
=S5EL
-----END PGP SIGNATURE-----

--gydx2f3ytdszxvgx--

