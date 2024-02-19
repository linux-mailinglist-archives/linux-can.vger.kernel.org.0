Return-Path: <linux-can+bounces-303-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5399285A374
	for <lists+linux-can@lfdr.de>; Mon, 19 Feb 2024 13:33:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8579C1C238EE
	for <lists+linux-can@lfdr.de>; Mon, 19 Feb 2024 12:33:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 842E22E83C;
	Mon, 19 Feb 2024 12:31:49 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24C4F5240
	for <linux-can@vger.kernel.org>; Mon, 19 Feb 2024 12:31:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708345909; cv=none; b=JaedibHv6sDxfcV9uwRiuswV2DGxJ4c+nFwp/I+da+o1L7bIk8BEXWMDTIUL5xCBbGQnP2GQWpXwFs0M+GzNhj5bJytVbuyIz1S3MprdmCJin49yl/ppy+Qb4yLdxPFPrh1Ony9/pKNQsLKZ81q+pEaSVzHVKtYZKpRjIacf5n4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708345909; c=relaxed/simple;
	bh=EiUjhERiyj7x7C6lPGGOAwXQnI7gT+xjch+oWZQ44JM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AFyE44V9moFL04lbphJYaGCOZqCmMSvAQowCTBoPT7VIuCl1c5tu5B6VV4swDnoTGdT6eBqlHYr+nBUOchAe6ag4w8UikAMXigYt5pQQ1QFjiDbiWcdHQjY0w0z/yz9txHdmnH5qbFIi9jSIBnv1kZ6OjmQIpWliKb0yI8hCUFQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1rc2oD-0008BB-CF; Mon, 19 Feb 2024 13:31:45 +0100
Received: from [2a0a:edc0:0:b01:1d::7b] (helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <mkl@pengutronix.de>)
	id 1rc2oC-001eAm-O0; Mon, 19 Feb 2024 13:31:44 +0100
Received: from pengutronix.de (unknown [172.20.34.65])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 77B192924F5;
	Mon, 19 Feb 2024 12:31:44 +0000 (UTC)
Date: Mon, 19 Feb 2024 13:31:44 +0100
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Vincent MAILHOL <mailhol.vincent@wanadoo.fr>
Cc: Stephane Grosjean <s.grosjean@peak-system.com>, 
	linux-can Mailing List <linux-can@vger.kernel.org>
Subject: Re: [PATCH v2] can: peak_usb: fix potential kernel log flooding
Message-ID: <20240219-marvelous-unkempt-ea6e6174d3f4-mkl@pengutronix.de>
References: <20240216135553.97845-1-s.grosjean@peak-system.com>
 <CAMZ6RqLknp_R+5_UgkMS20R_usP6+c7ywtzHKnQXo4AWroMgHQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="r6al3o2j4bldy4vj"
Content-Disposition: inline
In-Reply-To: <CAMZ6RqLknp_R+5_UgkMS20R_usP6+c7ywtzHKnQXo4AWroMgHQ@mail.gmail.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org


--r6al3o2j4bldy4vj
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 18.02.2024 01:10:44, Vincent MAILHOL wrote:
> On Fri. 16 Feb. 2024, 22:57, Stephane Grosjean
> <s.grosjean@peak-system.com> wrote:
> >
> > In rare cases of very high bus load, the firmware of the PEAK-System
> > PCAN-USB Pro FD HW v4 can generate messages warning that the receive ca=
che
> > capacity is about to be exceeded. This modification prevents the driver
> > from flooding the kernel log with messages and memory dumps that are far
> > too verbose in such cases, by limiting their production to once for all.
> >
> > Signed-off-by: Stephane Grosjean <s.grosjean@peak-system.com>
> > ---
> >  drivers/net/can/usb/peak_usb/pcan_usb_fd.c | 21 +++++++++++++++++++++
> >  1 file changed, 21 insertions(+)
> >
> > diff --git a/drivers/net/can/usb/peak_usb/pcan_usb_fd.c b/drivers/net/c=
an/usb/peak_usb/pcan_usb_fd.c
> > index a1c339716776..aa0b68c1ae81 100644
> > --- a/drivers/net/can/usb/peak_usb/pcan_usb_fd.c
> > +++ b/drivers/net/can/usb/peak_usb/pcan_usb_fd.c
> > @@ -667,6 +667,19 @@ static int pcan_usb_fd_decode_error(struct pcan_us=
b_fd_if *usb_if,
> >         return 0;
> >  }
> >
> > +/* Handle uCAN Rx cache warning messages.
> > + *
> > + * Such messages SHOULD NOT occur. If they do, then this might come fr=
om
> > + * massive PING host flooding that prevents PCAN-USB Pro FD HW v4 to h=
andle
> > + * CAN traffic anymore.
> > + */
> > +static void pcan_usb_fd_handle_rx_cache_warn(struct peak_usb_device *d=
ev,
> > +                                            struct pucan_msg *rx_msg)
>                                                                  ^^^^^^
>=20
> That rx_msg parameter is unused.
>=20
> Do you think it is worth keeping that
> pcan_usb_fd_handle_rx_cache_warn() function? Wouldn't it be easier to
> directly call netdev_warn_once() from pcan_usb_fd_decode_buf()?

+1

Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--r6al3o2j4bldy4vj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEUEC6huC2BN0pvD5fKDiiPnotvG8FAmXTSi0ACgkQKDiiPnot
vG8LoAf/RCCeGvYpks7QPrHK1pKa/UFD+iww36SjFTANrUW+2TScczhPt3sj2dyP
xJ1FS6Px/KWXQmhlgWK/ugBLwZYjOl9X8UbMm/s/Fkh7HDOeiUxkhMChx8RsRdQ8
HVZO+sIo3HdTCDsHYCsB4iX/zXGbFbaES34V+TJYftrzDxz8x/eH3NYTqM2Po98K
xM78sDyEFW6Yp399I+nP7oXo376kAmX22tbMZkYg5VUjZkvFMT0DEztG9F0riX8D
gOyUJIzwsgjxisgTB0Z355wVou4sFDHSZEGKGUy9i+2xKTttlm6kMJkj7qSpu2/O
PsyQeUudyMypMHws9CJxEEsLbwrsxw==
=a5rb
-----END PGP SIGNATURE-----

--r6al3o2j4bldy4vj--

