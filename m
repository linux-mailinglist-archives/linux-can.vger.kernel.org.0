Return-Path: <linux-can+bounces-5565-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id B0CC2C790D8
	for <lists+linux-can@lfdr.de>; Fri, 21 Nov 2025 13:47:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 924D44E9F3E
	for <lists+linux-can@lfdr.de>; Fri, 21 Nov 2025 12:47:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C667E24BBFD;
	Fri, 21 Nov 2025 12:47:00 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BBAD2F5A13
	for <linux-can@vger.kernel.org>; Fri, 21 Nov 2025 12:46:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763729220; cv=none; b=qFF2XuquizIxU/dMgFrtZmiqZIZyg19qUnKMsYEKo71PiatWthsgAtFrokHO0rBxWfkYYErPqUd22xxcAe7stejlHYpAd9u9Hqlut5xQgQHs05UrXw3fPuvOPnIbjhn4YiR8/rJFoabkQwAdbZKne1jB7DbzuD84ZPgPHLLpilI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763729220; c=relaxed/simple;
	bh=oHqk6VNsN+sGDkupWuP2d9zDW9N2Um1rQHtpeGSYTw4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rOdWnVm1VN5eH3UK/Qu4OyNKdqm7vZ5TrUluV9UXZwSSzzKBPznyPZj5pYbSvKLhWP6dRzZvRPoQKAtFkoqcAXdgmpX25p6oL9q1qRc6bAL5HsH1aH3I8Us+pk4bv+guV2U7hKAYsHTz2Sq67sKlW6+uUw1iKnhPFz5MrjSdHN4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1vMQXH-0000NG-RY; Fri, 21 Nov 2025 13:46:47 +0100
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1vMQXH-001aYJ-1f;
	Fri, 21 Nov 2025 13:46:47 +0100
Received: from pengutronix.de (p54b152ce.dip0.t-ipconnect.de [84.177.82.206])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 369084A47D9;
	Fri, 21 Nov 2025 12:46:47 +0000 (UTC)
Date: Fri, 21 Nov 2025 13:46:46 +0100
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Arun Muthusamy <arun.muthusamy@gaisler.com>
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, 
	mailhol@kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-can@vger.kernel.org, Daniel Hellstrom <daniel@gaisler.com>
Subject: Re: [PATCH 07/10] can: grcan: set DMA mask for GRCAN and GRCANFD to
 32-bit
Message-ID: <20251121-smart-angelic-dormouse-e4b53f-mkl@pengutronix.de>
References: <20251118092115.3455-1-arun.muthusamy@gaisler.com>
 <20251118092115.3455-8-arun.muthusamy@gaisler.com>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="5pusgntu3qyjk3f3"
Content-Disposition: inline
In-Reply-To: <20251118092115.3455-8-arun.muthusamy@gaisler.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org


--5pusgntu3qyjk3f3
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH 07/10] can: grcan: set DMA mask for GRCAN and GRCANFD to
 32-bit
MIME-Version: 1.0

On 18.11.2025 10:21:12, Arun Muthusamy wrote:
> From: Daniel Hellstrom <daniel@gaisler.com>
>
> Sets the DMA mask for GRCAN and GRCANFD devices to 32-bit.
> Setting the DMA mask and coherent DMA mask to 32-bit ensures proper
> memory addressing during DMA operations
>
> Signed-off-by: Arun Muthusamy <arun.muthusamy@gaisler.com>
> Signed-off-by: Daniel Hellstrom <daniel@gaisler.com>
> ---
>  drivers/net/can/grcan.c | 6 ++++++
>  1 file changed, 6 insertions(+)
>
> diff --git a/drivers/net/can/grcan.c b/drivers/net/can/grcan.c
> index e367581faa57..51a10fae2faf 100644
> --- a/drivers/net/can/grcan.c
> +++ b/drivers/net/can/grcan.c
> @@ -1074,6 +1074,12 @@ static int grcan_allocate_dma_buffers(struct net_d=
evice *dev,
>
>  	/* Extra GRCAN_BUFFER_ALIGNMENT to allow for alignment */
>  	dma->base_size =3D lsize + ssize + GRCAN_BUFFER_ALIGNMENT;
> +
> +	/* On 64-bit systems.. GRCAN and GRCANFD can only address 32-bit */
> +	if (dma_set_mask_and_coherent(priv->ofdev_dev, DMA_BIT_MASK(32))) {
> +		netdev_warn(dev, "No suitable DMA available\n");
> +		return -ENOMEM;

Please move this to probe(), return the error code, and use
dev_err_probe() for the error message.

regards,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--5pusgntu3qyjk3f3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEn/sM2K9nqF/8FWzzDHRl3/mQkZwFAmkgXzMACgkQDHRl3/mQ
kZx9aggAr32RDiPSUGJ9dWhQkxywlDRCBxEE5Shcci5GLYx1OszK5XvuI5JN0vhl
GEgq0OYJO20FRYgV9/c03CdRU3GIbhn4FCdTzdmfwUjvnOc2udYYrS9w8by1wl/g
5/WG5aH4ZEwPDOA07H6xKD3+9dSjDWxX1rUL0UkzrGT5OaCAuSx0Oj8lQiHJeRBF
cRt793QYziDeTrpD8m4bP1iosY7LeFtVN8WQL1wRWddddlPQw0kDZfbAShBGk493
eZ/bI4csO1F9OchBIMPNCvTWARMsoMYguSLM/dwvk+PqTkQiZMgF5eHM1TbseJqf
GKsNxdpXf2uKelE9Tw/r+X3sGDyzMw==
=yCxw
-----END PGP SIGNATURE-----

--5pusgntu3qyjk3f3--

