Return-Path: <linux-can+bounces-2843-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DBB74A39FDA
	for <lists+linux-can@lfdr.de>; Tue, 18 Feb 2025 15:32:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EBF5A3A586F
	for <lists+linux-can@lfdr.de>; Tue, 18 Feb 2025 14:28:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E91826D5BD;
	Tue, 18 Feb 2025 14:27:46 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D642D26A0D7
	for <linux-can@vger.kernel.org>; Tue, 18 Feb 2025 14:27:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739888866; cv=none; b=OZxXxQmEPFA+8qoi9E7b+h9y4rhuduyuNPa42H8T1sONrrW5M/gHINO7uDVx2vMijNeSq1MJhtr5ZCH08Lis1AcG7m3Dct0V0KyEQYb7Z8P7EP+8Ex7KA12v6SsUE1Blz4Q7lI1YSaW3Su6XJWGvcwHPbEp1yjseTpryEigDCpc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739888866; c=relaxed/simple;
	bh=S4XgtmNUByEmZZeVuy1IrEWQ986N2dY34e1tfciwELM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NQTZbzN88zB2GIFGklQy1jZqpVqwOiS78BFYyHDQXPkfDH4mrFiibaUgaKdrgzwUNsT8KS/YyB8u8OEondQvxS8q8nr6gDu3wPH7c3B3N2hhIN9C/6JPY5+VR17uak1eL7PfFlrZQ9dhzRzO8H2oan4FPKIVGQFGb7dbTAI6PME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1tkOZZ-0004om-Gj; Tue, 18 Feb 2025 15:27:41 +0100
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1tkOZZ-001bjn-0N;
	Tue, 18 Feb 2025 15:27:41 +0100
Received: from pengutronix.de (p5b164285.dip0.t-ipconnect.de [91.22.66.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id C0AF33C5DE5;
	Tue, 18 Feb 2025 14:27:40 +0000 (UTC)
Date: Tue, 18 Feb 2025 15:27:40 +0100
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Cc: Matt Jan <zoo868e@gmail.com>, 
	syzbot+d7d8c418e8317899e88c@syzkaller.appspotmail.com, linux-kernel@vger.kernel.org, linux-can@vger.kernel.org
Subject: Re: [PATCH] can: ucan: Correct the size parameter
Message-ID: <20250218-daring-melodic-meerkat-3f5953-mkl@pengutronix.de>
References: <67b323a4.050a0220.173698.002b.GAE@google.com>
 <20250217190404.354574-1-zoo868e@gmail.com>
 <2f33170a-f7bb-47dd-8cb7-15c055dabc83@wanadoo.fr>
 <20250218-accurate-viridian-manatee-6f2878-mkl@pengutronix.de>
 <b174cc40-d08b-42a5-89fc-9fdac2b15ea9@wanadoo.fr>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="xt57c3apzbfb5oxv"
Content-Disposition: inline
In-Reply-To: <b174cc40-d08b-42a5-89fc-9fdac2b15ea9@wanadoo.fr>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org


--xt57c3apzbfb5oxv
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH] can: ucan: Correct the size parameter
MIME-Version: 1.0

On 18.02.2025 23:26:01, Vincent Mailhol wrote:
> >> @@ -1555,7 +1544,10 @@ static int ucan_probe(struct usb_interface *int=
f,
> >>
> >>         /* initialisation complete, log device info */
> >>         netdev_info(up->netdev, "registered device\n");
> >> -       netdev_info(up->netdev, "firmware string: %s\n", firmware_str);
> >> +       ucan_get_fw_info(up, up->ctl_msg_buffer->fw_info,
> >> +                        sizeof(up->ctl_msg_buffer->fw_info));
> >> +       netdev_info(up->netdev, "firmware string: %s\n",
> >> +                   up->ctl_msg_buffer->fw_info);
> >=20
> > We could also use the:
> >=20
> >     printf("%.*s", sizeof(up->ctl_msg_buffer->fw_info), up->ctl_msg_buf=
fer->fw_info);
> >=20
> > format string trick to only print a limited number of chars of the given
> > string.
>=20
> Indeed. But after the renaming of ucan_device_request_in() into
> ucan_get_fw_info(), it makes slightly more sense to me to have this new
> function to handle the string NUL termination logic rather than to
> deffer it to the format string.

ACK, makes sense!

> But thanks for the suggestion.
>=20
> > But I'm also fine with your solution. Either way, please send a
> > proper patch :)
>=20
> Will do so right now!

Thanks,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--xt57c3apzbfb5oxv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEn/sM2K9nqF/8FWzzDHRl3/mQkZwFAme0mNkACgkQDHRl3/mQ
kZy11wf8C+c4LQWcDA8hNVoF5iYJwt+Gu5qvPzenFbzEq3vVSdX6nbcuzlomLEPG
PDQWMiIwDEqkEG/sOKtBq+SDLLo+4YXxHh0azxTMuVN12aqtANkzUsRRGStOw7U5
SsnfG5ffS+yQMhYaAaO0cuKCB3VidreGkkGvWgf8kjDgWuTInp0DRLEBTAXvXn1v
imSQBcRKb2BoWvxg6VD4D0wJQJQskagVU76sDXvh237hy41h1jX6bfJrbBelGMXp
xlxQ9J8YwfTrnduOswGVdZ60sXVaqBY13ewoqLF3U3y5J4zXfp9MhGTt7U1BW7iK
5Nv1AjihdgIyV++QfF53Z4mI6YaCBA==
=JsfW
-----END PGP SIGNATURE-----

--xt57c3apzbfb5oxv--

