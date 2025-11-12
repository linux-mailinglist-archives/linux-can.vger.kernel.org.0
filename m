Return-Path: <linux-can+bounces-5349-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 084D3C51377
	for <lists+linux-can@lfdr.de>; Wed, 12 Nov 2025 09:56:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 1458D4F1B73
	for <lists+linux-can@lfdr.de>; Wed, 12 Nov 2025 08:51:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD1D22FDC41;
	Wed, 12 Nov 2025 08:51:39 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D2652FD680
	for <linux-can@vger.kernel.org>; Wed, 12 Nov 2025 08:51:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762937499; cv=none; b=DWXVwYpaob9nwwFY/JOtqSHoUpckaJUO/XwNMzkgKOdeD98p6/Jl+zzMwoInYZasRMzDBNpkXX/sEnJSedexqoo2qjNdBMF4If+2PDFtWng+bixEpc4jMt8tAdVEw7DrWWToRUkQk70oJQPf4yWM95Jg8ifuegUK9Br6DZMDCgs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762937499; c=relaxed/simple;
	bh=ofDGwQnGMQnzPFS/07xi7dEXMK7njim+0IicHZYUAoY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MP3tol3HuL7BJCMReXiZrpmqJ66Xtcv4hawA4N2NtGXEFwsPwalHoeofmJWyqef3BzjNqhpao5KbBOWukoHFjNbUXtYErEMGr7WTmMBB3/yfugqqGRjo92d8WD0sqG6N6Xu4vFQklwL4zJfzr4ph3hxLvHGSFmZUvVBzDPCXBMs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1vJ6Zh-0002vV-QM; Wed, 12 Nov 2025 09:51:33 +0100
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1vJ6Zh-0003Iq-1s;
	Wed, 12 Nov 2025 09:51:33 +0100
Received: from pengutronix.de (p54b152ce.dip0.t-ipconnect.de [84.177.82.206])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 3F80B49D940;
	Wed, 12 Nov 2025 08:51:33 +0000 (UTC)
Date: Wed, 12 Nov 2025 09:51:32 +0100
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Chu Guangqing <chuguangqing@inspur.com>
Cc: mailhol@kernel.org, linux-can@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] can: janz-ican3: Fix a typo error for DESC_INVALID
Message-ID: <20251112-interesting-loutish-booby-aaf75f-mkl@pengutronix.de>
References: <20251103064934.4611-1-chuguangqing@inspur.com>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="gf27c4y5fcurbnai"
Content-Disposition: inline
In-Reply-To: <20251103064934.4611-1-chuguangqing@inspur.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org


--gf27c4y5fcurbnai
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH] can: janz-ican3: Fix a typo error for DESC_INVALID
MIME-Version: 1.0

On 03.11.2025 14:49:34, Chu Guangqing wrote:
> The macro definition DESC_IVALID should be DESC_INVALID, as there is a
> spelling error here.

Have you taken a look at the manual? Does it talk about IVALID or
INVALID?

regards,
Marc

> Signed-off-by: Chu Guangqing <chuguangqing@inspur.com>
> ---
>  drivers/net/can/janz-ican3.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/net/can/janz-ican3.c b/drivers/net/can/janz-ican3.c
> index 1efdd1fd8caa..7ae1f4ba4627 100644
> --- a/drivers/net/can/janz-ican3.c
> +++ b/drivers/net/can/janz-ican3.c
> @@ -62,7 +62,7 @@
>  #define DESC_VALID		0x80
>  #define DESC_WRAP		0x40
>  #define DESC_INTERRUPT		0x20
> -#define DESC_IVALID		0x10
> +#define DESC_INVALID		0x10
>  #define DESC_LEN(len)		(len)
>
>  /* Janz ICAN3 Firmware Messages */
> @@ -1723,11 +1723,11 @@ static netdev_tx_t ican3_xmit(struct sk_buff *skb=
, struct net_device *ndev)
>  	ican3_put_echo_skb(mod, skb);
>
>  	/*
> -	 * the programming manual says that you must set the IVALID bit, then
> +	 * the programming manual says that you must set the INVALID bit, then
>  	 * interrupt, then set the valid bit. Quite weird, but it seems to be
>  	 * required for this to work
>  	 */
> -	desc.control |=3D DESC_IVALID;
> +	desc.control |=3D DESC_INVALID;
>  	memcpy_toio(desc_addr, &desc, sizeof(desc));
>
>  	/* generate a MODULbus interrupt to the microcontroller */
> --
> 2.43.7
>
>
>

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--gf27c4y5fcurbnai
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEn/sM2K9nqF/8FWzzDHRl3/mQkZwFAmkUSpEACgkQDHRl3/mQ
kZykbQf/Uy5O2fZcbDo8YvVPBploWYszh6LQ2z7lJJoBub5ZiiT8bVNti53+sDVn
OqjBLpV37FKdcaVB8Csstx6Nv3iLA0XDQdHI22oEFEpz/R+y9nhxkSFcwDscFcLU
zM7f/Jz9MUqaJ5nYkGOF5ZOwl+y0MEphifDVACj3cM/U++lkVfJlnH9+Q7qItBy3
cH3qkek3OQqoI8qwuREjbzLKEa3gHh492bss2M+9tyA7vAITupRfYa7Dzxv0XnPz
gclyAOR5JQJdJrHt90Rpl7yCPSsZA8ZhaLmDdkw/orJJiqWYCEdCNL8L6n+dTMZk
S30oeH4DWAwSNW21+iuPVGhvmRCtlQ==
=4f0+
-----END PGP SIGNATURE-----

--gf27c4y5fcurbnai--

