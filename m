Return-Path: <linux-can+bounces-332-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 43DE785B9C3
	for <lists+linux-can@lfdr.de>; Tue, 20 Feb 2024 11:59:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7E1891C2207C
	for <lists+linux-can@lfdr.de>; Tue, 20 Feb 2024 10:59:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B074657DB;
	Tue, 20 Feb 2024 10:59:53 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C2AD6519D
	for <linux-can@vger.kernel.org>; Tue, 20 Feb 2024 10:59:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708426793; cv=none; b=UpYD5XzI+6lHCFhgeqAjz/xVkE7NFa4Y7FZBBb+Xm+ZL/R7bFh/pF89/9S4KCjXjxCU0nwfQDuUHLE4JM2YU+dkKc6d80IRsmMvBUVX3BsrBEVBGRrRew2kh0gMvQ2BPzja1Gmp7rXSuoBEzfFMPUVLI+p1gNpO8oCN4h3GHMMk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708426793; c=relaxed/simple;
	bh=sR8mqzcJkeIArOOSiIYDCgclbT39A+tPKuRni7VYeLY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kDZLOdNk0zapeibucG4tGy0aEHjmdC/Aw7Stig25d0rufpgAx+nSxPtVy8WODZ9PBKUqSMaKAXWwdrdCIrnYVTSMjczdOizUlyp6Ewq8sxG/jn0UiBM8/bSD6lM/bCh2LAd+A48d0gdLdnVWFtjFR4IY4K/fF2Ef7HkcucEpzWQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1rcNqm-0002eX-C2; Tue, 20 Feb 2024 11:59:48 +0100
Received: from [2a0a:edc0:0:b01:1d::7b] (helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <mkl@pengutronix.de>)
	id 1rcNql-001pL3-RY; Tue, 20 Feb 2024 11:59:47 +0100
Received: from pengutronix.de (unknown [172.20.34.65])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 81E57293154;
	Tue, 20 Feb 2024 10:59:47 +0000 (UTC)
Date: Tue, 20 Feb 2024 11:59:46 +0100
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Vincent MAILHOL <mailhol.vincent@wanadoo.fr>
Cc: "Dr. Michael 'Mickey' Lauer" <mickey@vanille.de>, 
	Oliver Hartkopp <socketcan@hartkopp.net>, linux-can@vger.kernel.org
Subject: Re: Protocol recommendation for CAN(FD)-USB adapter
Message-ID: <20240220-coziness-grapple-88c0a583ea0c-mkl@pengutronix.de>
References: <20240216-acclaim-impromptu-4474f57f9761-mkl@pengutronix.de>
 <AEC70E89-BC6E-429A-B756-385ADC2B3E85@vanille.de>
 <20240219-contend-catfight-cd49fff06252-mkl@pengutronix.de>
 <8609D943-B86B-4584-88A1-984BD39E25D3@vanille.de>
 <20240220-cottage-neatly-832a106bc879-mkl@pengutronix.de>
 <CAMZ6Rq+fE7J=ndRAVRuBvpUNXS-5rDx1r5mZeEPTuKrtbjKYOA@mail.gmail.com>
 <CAMZ6RqJorVA8bgT11J4AMMHJs6Kj759QkMTyYMvUQq+uyGJUcw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="jnjdignfl7js4eum"
Content-Disposition: inline
In-Reply-To: <CAMZ6RqJorVA8bgT11J4AMMHJs6Kj759QkMTyYMvUQq+uyGJUcw@mail.gmail.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org


--jnjdignfl7js4eum
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 20.02.2024 19:44:21, Vincent MAILHOL wrote:
> On Tue. 20 Feb. 2024 at 17:35, Vincent Mailhol
> <vincent.mailhol@gmail.com> wrote:
> > On Tue. 20 Feb. 2024 at 17:10, Marc Kleine-Budde <mkl@pengutronix.de> w=
rote:
> > >
> > > On 20.02.2024 08:49:26, Dr. Michael 'Mickey' Lauer wrote:
> > > > Hi Marc,
> > > >
> > > > >>
> > > > >> Sounds pretty cool. Our design is based on an ESP32-S3 though, s=
o I
> > > > >> have to duplicate that effort. Is there some kind of USB protocol
> > > > >> definition for what gs-usb expects or do I need to learn that fr=
om the
> > > > >> implementation?
> > > > >
> > > > > I've put together a very rough summary of the driver's side of vi=
ew:
> > > > >
> > > > > https://gist.github.com/marckleinebudde/99f72d9db67accf08cc6efa36=
7cfe54b
> > > > >
> > > > > Feel free to update.
> > > >
> > > > Wow, that=E2=80=99s very kind of you!
> > >
> > > :)
> > >
> > > > Later this year I=E2=80=99ll take this blueprint to implement the n=
ecessary
> > > > changes in our firmware. I=E2=80=99ll enhance / update your summary
> > > > as I=E2=80=99ll go.
> > >
> > > If you discover any odd points or areas for improvement in the USB
> > > protocol, please let us know.
> > >
> > > Currently, TX-complete sends the _entire_ structure back to the host,
> > > which is quite an overhead, especially for CAN FD frames. We're worki=
ng
> > > on a "short-tx-complete" feature.
> >
> > The es581.4 may be doing what you are looking for:
> >
> >   - When sending a frame, the driver attaches a 32 bit index:
> > https://elixir.bootlin.com/linux/v6.7/source/drivers/net/can/usb/etas_e=
s58x/es581_4.h#L78
> >   - When receiving the TX completion message, the device just send
> > back that index and a timestamp:
> > https://elixir.bootlin.com/linux/v6.7/source/drivers/net/can/usb/etas_e=
s58x/es581_4.h#L97
> >
> > The device is agnostic of what this index represents. The driver uses
> > the index from the can_put_echo_skb() / can_get_echo_skb().
> >
> > (in addition the driver can handle bulk send and receive but that's
> > another story).
>=20
> I forgot to mention: it is also perfectly fine not to use the index as
> long as you can guarantee that the TX completion messages are received
> in order (which is not hard to achieve). In which case, the TX
> completion message can be as simple as just a timestamp.

ACK, but in the medium term I want to add a CTRL mode to switch CAN
devices into true "send CAN frames by prio" mode.

regards,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--jnjdignfl7js4eum
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEUEC6huC2BN0pvD5fKDiiPnotvG8FAmXUhiAACgkQKDiiPnot
vG9Vvgf+MGLPma+h5LKsTE1QiX7nUO22TtpUnZz8fLqjX/2h4k3MWf6LJiTf1t4u
KzyEARyQRtHTbrKT0gG7cYyXGbRMuRsTwUmVJuuLiMPOidBSQWIXC0BsY+XbggVc
NfDzuet9wJ8k6ksrd0e2E6lwsYfmXNVqM1Hs8M9R3PxY0ehOCxYz0vtCrcbxWeNr
ceclbkjWhAg/H/GyCRbKEk3Rhrm2SrVkxV4bkwgMPv2+Ds+5qUc6V/tRLOrJhIgt
i4W5fp2j9YkWEvfb3G/UsboyVT77DriYpWG+JznFsVZlebyBlOQZgV1zl15Axc0e
CSMYqy7sLWF68+j5wNAGsujUaCdL5Q==
=WmKZ
-----END PGP SIGNATURE-----

--jnjdignfl7js4eum--

