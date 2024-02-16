Return-Path: <linux-can+bounces-291-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BB27C857DA8
	for <lists+linux-can@lfdr.de>; Fri, 16 Feb 2024 14:27:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EA65A1C22BBB
	for <lists+linux-can@lfdr.de>; Fri, 16 Feb 2024 13:27:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E69F1B966;
	Fri, 16 Feb 2024 13:27:38 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF853126F20
	for <linux-can@vger.kernel.org>; Fri, 16 Feb 2024 13:27:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708090058; cv=none; b=PJAlEGkYxRXheTu5y58Dtzz6l9p8Nfo6fsX+OfP2/ghJAp2ENhj1+v+Bb0l0DRX6o/ok/Oyaf+HFLjl0l5dFd7DnCSZbWcOJcvah5PuJn3tbLf1yLCMBwR7y3ZFDp2FIzlBlgPsa56Vqex+JXlvcWU2fkK3r5moPAvq4n2Jn2Gw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708090058; c=relaxed/simple;
	bh=yU6YEcnXNYHYdwAB8wQ/hzTx4IhFo92jgu2K+5/rwtc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GRRo9s8+oTmeJACOrmWQAXazrM6GiYxDL29oLv6ModGXtCkdcJBKEXaQndOYltO9GNoUVQ4KYdfhPKBstEhZHxvSH1xjLhubw2UYiM9wBuVxIM6X08nPqPvjBN+kVNoBLzIpSUgdZrzo4sXOTvZUWiNBHr+uoCwQy6Na1irS+4E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1rayFZ-0002D0-9f; Fri, 16 Feb 2024 14:27:33 +0100
Received: from [2a0a:edc0:0:b01:1d::7b] (helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <mkl@pengutronix.de>)
	id 1rayFX-0015NA-Rm; Fri, 16 Feb 2024 14:27:31 +0100
Received: from pengutronix.de (unknown [172.20.34.65])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 8239729042D;
	Fri, 16 Feb 2024 13:27:31 +0000 (UTC)
Date: Fri, 16 Feb 2024 14:27:30 +0100
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Vincent Mailhol <vincent.mailhol@gmail.com>
Cc: Stephane Grosjean <s.grosjean@peak-system.com>, 
	linux-can Mailing List <linux-can@vger.kernel.org>
Subject: Re: [PATCH 3/3] can: peak_usb: fix potential kernel log flooding
Message-ID: <20240216-unguided-countdown-aec8f28f6e61-mkl@pengutronix.de>
References: <20240215152656.13883-1-s.grosjean@peak-system.com>
 <20240215152656.13883-3-s.grosjean@peak-system.com>
 <CAMZ6RqL=qp9OHVny92Qt9wyY7eU=3dm2aQRChvCBkAfnj2jqng@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="2ohri5mriljichtf"
Content-Disposition: inline
In-Reply-To: <CAMZ6RqL=qp9OHVny92Qt9wyY7eU=3dm2aQRChvCBkAfnj2jqng@mail.gmail.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org


--2ohri5mriljichtf
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 16.02.2024 10:37:48, Vincent Mailhol wrote:
> > +static void pcan_usb_fd_handle_rx_cache_warn(struct peak_usb_device *d=
ev,
> > +                                            struct pucan_msg *rx_msg)
> > +{
> > +       struct pcan_usb_fd_device *pdev =3D
> > +                       container_of(dev, struct pcan_usb_fd_device, de=
v);
> > +
> > +       if (pdev->rx_cache_warn_handled)
> > +               return;
> > +
> > +       netdev_warn(dev->netdev,
> > +                   "Rx cache size warning! Possible loss of frames\n");
>=20
> Did you consider using netdev_warn_once?
>=20
>   https://elixir.bootlin.com/linux/v6.7/source/include/net/net_debug.h#L46
>=20
> This seems to do pretty much what you want.
>=20
> FYI, the net_ratelimit() may also be helpful here:
>=20
>         if (net_ratelimit())
>                 netdev_warn(...);

There is also dev_warn_ratelimited(), but this does not output the
associated netdev. This could be useful if an error occurs on USB
devices with multiple network devices and the error cannot be linked to
a network device. But AFAICS there is no netdev_warn_ratelimited().

regards,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--2ohri5mriljichtf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEUEC6huC2BN0pvD5fKDiiPnotvG8FAmXPYsAACgkQKDiiPnot
vG8KqwgAhEmuiYkf0kfUHuyX8sbP6cAa8nd++THFr7Qg9L/vHYasvMkgDv+i0huT
WToJJET72fawVNnmfBq929n6gFmBh1HnLdLdajXB97dwY+0lsMvDHkis2bE1WLGK
hReJQ3/YnW8NDQwDfHdnRwFyDSRqIFQJZYzBfeYRLp0k1h3g+LXuDhDehJEufQ/2
wbLSRBAAhFBuDRJnAjTE3+3KkimmM83oTOJ08PPjGEABKLfWFrIdZeo4oyH0LVFF
DkZ9WVVoQ+uIxGSuqMKERnRIy7PdKlh2K18nu5Dr6du3zjLGCVbf8RuvoBDsf3Bk
IKnuEEz9NxkVcrr3+eXEzzC5tTFL0A==
=q5c/
-----END PGP SIGNATURE-----

--2ohri5mriljichtf--

