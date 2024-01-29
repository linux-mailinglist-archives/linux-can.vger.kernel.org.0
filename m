Return-Path: <linux-can+bounces-174-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8916683FF81
	for <lists+linux-can@lfdr.de>; Mon, 29 Jan 2024 08:57:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3B7431F23A5E
	for <lists+linux-can@lfdr.de>; Mon, 29 Jan 2024 07:57:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 845AF4F1EA;
	Mon, 29 Jan 2024 07:57:06 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9742C4EB3E
	for <linux-can@vger.kernel.org>; Mon, 29 Jan 2024 07:57:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706515026; cv=none; b=FbzKk+LW1kMGY8/N1+pCfmA8W5VZfp6o4NllaFUCx5l1e6M+WteWhQfcF5tPHMBz0w1lkOnJwOT/Df9Yqf8YAI2Cik5JLNt56TeNhD3RN7p20PDt0tRlO/d6KRqVqD52ivZK0ZY4iF+sz1BHOdLF1XL0BuxYufzSWsQNBURfVGM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706515026; c=relaxed/simple;
	bh=cpzbQdEFyJfdWkgTGQtglKfld1njoP+xNZIO0UPn3nU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ucSophnqK93PtEml3sLXMrfcK+s0oZNl3Tn+YXZgp4PBhF6gd2Rvow6DgLy7NnT2n/FOpCUQTkBga8XdIhjaC+8Rc2T56d2xBjOXvnjc57sADu8Cii4cgcx6+OyxraZe34e4/5ZUjhgXewJEN6EApJcuMdohH0fCZswZDODM/1k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1rUMVn-0005hM-7z; Mon, 29 Jan 2024 08:56:59 +0100
Received: from [2a0a:edc0:0:b01:1d::7b] (helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <mkl@pengutronix.de>)
	id 1rUMVm-0037Pp-Hj; Mon, 29 Jan 2024 08:56:58 +0100
Received: from pengutronix.de (unknown [172.20.34.65])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 35ADF2806D6;
	Mon, 29 Jan 2024 07:56:58 +0000 (UTC)
Date: Mon, 29 Jan 2024 08:56:57 +0100
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Uwe Bonnes <bon@elektron.ikp.physik.tu-darmstadt.de>
Cc: linux-can@vger.kernel.org
Subject: Re: SLCAN and systemd
Message-ID: <20240129-matrimony-net-4e529ace684b-mkl@pengutronix.de>
References: <26034.34881.283564.969697@gargle.gargle.HOWL>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="6omznj47ldpdnst4"
Content-Disposition: inline
In-Reply-To: <26034.34881.283564.969697@gargle.gargle.HOWL>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org


--6omznj47ldpdnst4
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 25.01.2024 17:11:45, Uwe Bonnes wrote:
> can anybody help to set up an SLCAN adapter via systemd?

If you have the option of using a proper CAN adapter, e.g. a candlelight
compatible one, you should do so. You won't have much fun with slcan
based devices.

> By hand and for the given adapter I can do
> slcand -o -s8 -t hw -S 3000000 \
> /dev/serial/by-id/usb-Black_Sphere_Technologies_Black_Magic_Probe_STLINK-=
V3_v1.7.1-353-gbb84e8ec_004100483038510D34333935-if06
>=20
> and
>=20
> ip link set up slcan
>=20
> and it works as expected. However automativ setup at plug would be fine.

You can create a systemd "service" that uses "BindsTo" to bind to your
USB Serial Adapter. Have a look at the output of "systemctl" to get the
corresponding "device". This service would be automatically started, if
you plug the device. =20

It looks something like this (untested, not sure about the quoting):

"BindsTo=3Dsys-devices-pci0000:00-0000:00:14.0-usb2-2\x2d1-2\x2d1.3-2\x2d1.=
3.2-2\x2d1.3.2:1.0-ttyUSB0-tty-ttyUSB0.device"

Use "slcand" as "ExecStart" in that service.

Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--6omznj47ldpdnst4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEDs2BvajyNKlf9TJQvlAcSiqKBOgFAmW3WkcACgkQvlAcSiqK
BOgaZwf/UTmd4mhYN6enm30ZHVfpvAine0/7/bhW0Gu2iz4rJlnGYhYHf8bCWSDV
ZnDDnSUS0z+QysWBEhr64BCJ9qdp22YuWq0LkdiQr66FN/AeVUgPhdul45VLXjUB
sHjBqzLpngpefLXJXQHAytEWt0Zft5kMFv5Wbu3//c49kNLQuh5RUt5HejFmCTZU
mYWQrGTFxwL9u1PflRN95jWkmVMR4QVbstPjfY0Ja9oZgZaUupqXSG6ImwrSg6s/
s8WD/h7zL58IYBDhdXdStERtZKD/wVpV6lhENfSIyMd8CeXXLuisAjyPL3Q7WR6i
ql1KQLEps/vZbcEOAXlgGv6yjxQcYQ==
=zWUo
-----END PGP SIGNATURE-----

--6omznj47ldpdnst4--

