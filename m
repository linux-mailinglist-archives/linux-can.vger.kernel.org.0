Return-Path: <linux-can+bounces-2312-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BB23A9E0113
	for <lists+linux-can@lfdr.de>; Mon,  2 Dec 2024 12:59:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 872061628C1
	for <lists+linux-can@lfdr.de>; Mon,  2 Dec 2024 11:59:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E6181FE468;
	Mon,  2 Dec 2024 11:59:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ucw.cz header.i=@ucw.cz header.b="kfCOHf6D"
X-Original-To: linux-can@vger.kernel.org
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BAE41FE457;
	Mon,  2 Dec 2024 11:59:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.255.230.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733140774; cv=none; b=CObQCg2d0IbjHHDjgrMPhmLn/QvVJ048+mFxZuHlBBcUOBlZqjhJaWDTLzeiOlteylHs1ezEDR7tt9HVdgKH61MbFKa3EFhAtgAmUmV6BcT/Sb5lCtZ/I7kQjGZYNzmFcz0h9U/azyCDB+p5Hhf+iyQji4HNR4D7GpWcqs8dK98=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733140774; c=relaxed/simple;
	bh=N/FtLGxZSOjoESGAFkoZ7rNu2YPWJnOH24yyDQkCF1I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Jm2O/2bQJIrX8oWEc5xtit7oZanDxqrk5JQO6VQhdE2dLZW9OdUu9nSnBhMnsJDV5OkNlL6xjN9RSngypIKz2GvnqMVz1hAe/EzR7T0ar7VoS/fnNKJrDcoTZi/9xTSMHdvbGmHdHk1/mAfrUNN584cUYFbLXU7sOFFMxL1Mo50=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ucw.cz; spf=pass smtp.mailfrom=ucw.cz; dkim=pass (1024-bit key) header.d=ucw.cz header.i=@ucw.cz header.b=kfCOHf6D; arc=none smtp.client-ip=46.255.230.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ucw.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ucw.cz
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id 889F91C00A0; Mon,  2 Dec 2024 12:59:21 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ucw.cz; s=gen1;
	t=1733140761;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=H5ubiw6vD4okQFCfJBW+Ugm6BtQvdoUcLByM+fyDWlU=;
	b=kfCOHf6Dmy4t3nZYQCoE1xuCMpfTN/ZPug/6jz8E5HOnEaShyW/jfKEXm9TCCPlCibt3pc
	2Iq5O9lku9yBP3uJeE0JAXWJxiqqABBXmlA+Lj5jUJ49CkPImVyzG6fc4ahCA8Tfntq00w
	Bi/+mCXdm+r5lqCoOdf24UFOtWIwcWQ=
Date: Mon, 2 Dec 2024 12:59:21 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Sasha Levin <sashal@kernel.org>
Cc: linux-kernel@vger.kernel.org, stable@vger.kernel.org,
	Alexander =?iso-8859-1?Q?H=F6lzl?= <alexander.hoelzl@gmx.net>,
	Oleksij Rempel <o.rempel@pengutronix.de>,
	Vincent Mailhol <mailhol.vincent@wanadoo.fr>,
	Marc Kleine-Budde <mkl@pengutronix.de>, robin@protonic.nl,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, corbet@lwn.net, linux-can@vger.kernel.org,
	netdev@vger.kernel.org, linux-doc@vger.kernel.org
Subject: Re: [PATCH AUTOSEL 5.10 3/6] can: j1939: fix error in J1939
 documentation.
Message-ID: <Z02hGYbHhkEeE3eQ@duo.ucw.cz>
References: <20241112103803.1654174-1-sashal@kernel.org>
 <20241112103803.1654174-3-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="UyTOBD7KB2x8PJGs"
Content-Disposition: inline
In-Reply-To: <20241112103803.1654174-3-sashal@kernel.org>


--UyTOBD7KB2x8PJGs
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> From: Alexander H=F6lzl <alexander.hoelzl@gmx.net>
>=20
> [ Upstream commit b6ec62e01aa4229bc9d3861d1073806767ea7838 ]
>=20
> The description of PDU1 format usage mistakenly referred to PDU2
> format.

I'm pretty sure this does not fix user-visible bug.

BR,
								Pavel

> Signed-off-by: Alexander H=F6lzl <alexander.hoelzl@gmx.net>
> Acked-by: Oleksij Rempel <o.rempel@pengutronix.de>
> Acked-by: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
> Link: https://patch.msgid.link/20241023145257.82709-1-alexander.hoelzl@gm=
x.net
> Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
> Signed-off-by: Sasha Levin <sashal@kernel.org>
> ---
>  Documentation/networking/j1939.rst | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/Documentation/networking/j1939.rst b/Documentation/networkin=
g/j1939.rst
> index 0a4b73b03b997..59f81ba411608 100644
> --- a/Documentation/networking/j1939.rst
> +++ b/Documentation/networking/j1939.rst
> @@ -83,7 +83,7 @@ format, the Group Extension is set in the PS-field.
> =20
>  On the other hand, when using PDU1 format, the PS-field contains a so-ca=
lled
>  Destination Address, which is _not_ part of the PGN. When communicating =
a PGN
> -from user space to kernel (or vice versa) and PDU2 format is used, the P=
S-field
> +from user space to kernel (or vice versa) and PDU1 format is used, the P=
S-field
>  of the PGN shall be set to zero. The Destination Address shall be set
>  elsewhere.
> =20

--=20
People of Russia, stop Putin before his war on Ukraine escalates.

--UyTOBD7KB2x8PJGs
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCZ02hGQAKCRAw5/Bqldv6
8l9LAJwL6qfkl3olcEWNHAA4lyQ0gqDEHACfcaO8EgLoYfDotzr44LxkgMgl/VE=
=/fMJ
-----END PGP SIGNATURE-----

--UyTOBD7KB2x8PJGs--

