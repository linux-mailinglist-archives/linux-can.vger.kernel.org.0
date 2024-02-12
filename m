Return-Path: <linux-can+bounces-227-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D8A285187F
	for <lists+linux-can@lfdr.de>; Mon, 12 Feb 2024 16:53:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3CA491F22145
	for <lists+linux-can@lfdr.de>; Mon, 12 Feb 2024 15:53:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E68933CF52;
	Mon, 12 Feb 2024 15:53:39 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40F083C47A
	for <linux-can@vger.kernel.org>; Mon, 12 Feb 2024 15:53:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707753219; cv=none; b=rqWvH1lTwalEVALz1iI0sPF+KzXC5v9nC3vaxeNqJSTHTdizAoQQZr9WBClFtEMUe3sY3YXAVsCxyzsWPWeImSNgHhQVKXI6lRdQhtXKIx29kCkPW/aVaViqOrdlDuzHcCMq4jjnZvdWDBztki6GM/m4bQCiGR7qsim1MhL9Hms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707753219; c=relaxed/simple;
	bh=OPpg1leJr3c7A8naWt0xeRIryHtQhLrehVbYfCXwf44=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=A7mvPjnikh7Wb6K9LQMsCgjF8JtOKWuIG85NvCVXYQ09R3PBDVGSbsUcSahHAJC5nlO/iyX0i+s0AcLJ3Avrcu69DxXAD/lM21mu+uRGHu0qxiQtY+ZCEESmQJyydpjPDuDI7X2ztLj/1a9nP2gAhJKszc1Rf7diotgRmrqJcaU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1rZYcg-0007IJ-7h; Mon, 12 Feb 2024 16:53:34 +0100
Received: from [2a0a:edc0:0:b01:1d::7b] (helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <mkl@pengutronix.de>)
	id 1rZYcf-000JdJ-PN; Mon, 12 Feb 2024 16:53:33 +0100
Received: from pengutronix.de (unknown [172.20.34.65])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 7A06E28C6D0;
	Mon, 12 Feb 2024 15:53:33 +0000 (UTC)
Date: Mon, 12 Feb 2024 16:53:32 +0100
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Oliver Hartkopp <socketcan@hartkopp.net>
Cc: Guy Harris <gharris@sonic.net>, 
	Vincent Mailhol <vincent.mailhol@gmail.com>, linux-can@vger.kernel.org
Subject: Re: [PATCH rework v1] canxl: add virtual CAN network identifier
 support
Message-ID: <20240212-curry-aspire-408b56e4ef6f-mkl@pengutronix.de>
References: <20240212151404.60828-1-socketcan@hartkopp.net>
 <4a3f3605-6a54-4ca0-9581-eff900e6b169@hartkopp.net>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="hnw7qebdmzqjyzhy"
Content-Disposition: inline
In-Reply-To: <4a3f3605-6a54-4ca0-9581-eff900e6b169@hartkopp.net>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org


--hnw7qebdmzqjyzhy
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 12.02.2024 16:26:34, Oliver Hartkopp wrote:
> I'm currently in discussion with Guy Harris who's working on the Linux-CAN
> support in Wireshark.
>=20
> We current have two approaches how to integrate the VCID into the struct
> canxl_frame:
>=20
> 1. Add the VCID at a specific 16 bit offset (above the 11 bit Prio ID)
> 2. Create a endian-dependent data structure with a separate uint8 VCID
>=20
> 1: https://lore.kernel.org/linux-can/20240212151404.60828-1-socketcan@har=
tkopp.net/
> 2: https://lore.kernel.org/linux-can/20240128183758.68401-1-socketcan@har=
tkopp.net/
>=20
> The endian-dependent data structure looks like this:
>=20
> struct canxl_frame {
> #if defined(__LITTLE_ENDIAN)
>         __u16 prio;   /* 11 bit priority for arbitration */
>         __u8  vcid;   /* virtual CAN network identifier */
>         __u8  __res0; /* reserved / padding must be set to zero */
> #elif defined(__BIG_ENDIAN)
>         __u8  __res0; /* reserved / padding must be set to zero */
>         __u8  vcid;   /* virtual CAN network identifier */
>         __u16 prio;   /* 11 bit priority for arbitration */
> #else
> #error "Unknown endianness"
> #endif
>         __u8  flags;  /* additional flags for CAN XL */
>         __u8  sdt;    /* SDU (service data unit) type */
>         __u16 len;    /* frame payload length in byte */
>         __u32 af;     /* acceptance field */
>         __u8  data[CANXL_MAX_DLEN];
> };
>=20
> @Guy: Besides the fact that suggestion 2 does not win a design prize I'm =
not
> sure whether solution 1 or 2 are better to maintain over lifetime.
>=20
> Feedback about the two suggestions is highly appreciated.

Then I'll skip the virtual CAN network identifier support patches for
now.

Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--hnw7qebdmzqjyzhy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEUEC6huC2BN0pvD5fKDiiPnotvG8FAmXKPvoACgkQKDiiPnot
vG/jsggAgQKS02W45ac41o13XAHzZ+uT9Ii5Axh5MudPVtTzKeN39RP4Z2YEHR1G
5jIPsaJ2xOd6snI8HtoTZ5J8Gaty+f8FfBsRk0WzNCgHJUNW/tLZ+dS5tzTYL78c
3X8JEBVDn65N1HpzPrajejK7K2z33lEX5Vr5rF3F1LPMyAxg5uhrFyTX1u5XDxKi
pd/agbdCdOfQsaAA3GDbm+ddFfJeqFHN+JhC8a9qIEGLD9prj/xGR1E3oygC4y98
G0Q79IjXZb4oz/pNaviC6dK/IO442dSWEAcux0yDYid+JiW0tTLp3TbEeBz+dmoC
5iTX/cd4eo+KLpTFw88H6QJWah0UdA==
=oQBb
-----END PGP SIGNATURE-----

--hnw7qebdmzqjyzhy--

