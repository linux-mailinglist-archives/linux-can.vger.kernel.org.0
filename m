Return-Path: <linux-can+bounces-5564-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id CFB7FC7898C
	for <lists+linux-can@lfdr.de>; Fri, 21 Nov 2025 12:00:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 9BE8A4E6657
	for <lists+linux-can@lfdr.de>; Fri, 21 Nov 2025 11:00:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49D602BF019;
	Fri, 21 Nov 2025 11:00:43 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69557336ECE
	for <linux-can@vger.kernel.org>; Fri, 21 Nov 2025 11:00:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763722843; cv=none; b=oL9GO0ZfqjCNvCgiP5+ecsOg7136Mnqg0E8mX70aOOGFvdTJmC2BwGaigJJ2achhht6ocAiNvw6U2MRV9mdBtADhI2AwAsDHwEKde2xVeB/FZJ7g8WvAbfQf2lNHRoZCDHbk1GvB6naj6uDoRTXeoJ4VecwPcUahVYo3oP9w+zk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763722843; c=relaxed/simple;
	bh=0IpxXvgGHZfe2FLjd4o2OpOorGnU+HP0zjWbFC+xu+A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XcEdtAjax2dJCk3R/hthvnneG+fhmnvNvI0zjZlMoz2vS2HWPyEhPT8+WJPzf/t1NNjaHYzV0AVfePkYtWNynKKsEgcsItqyPpjhGMIlAbVFHuedDWZjiy6UAsD0Rq577KnvPsDRblAolxmjO1zwGGWKAw3/VxHI8aqXkcbM+fs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1vMOsS-0005jJ-CX; Fri, 21 Nov 2025 12:00:32 +0100
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1vMOsS-001ZPs-0N;
	Fri, 21 Nov 2025 12:00:32 +0100
Received: from pengutronix.de (p54b152ce.dip0.t-ipconnect.de [84.177.82.206])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id B7CC44A46F1;
	Fri, 21 Nov 2025 11:00:31 +0000 (UTC)
Date: Fri, 21 Nov 2025 12:00:31 +0100
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Arun Muthusamy <arun.muthusamy@gaisler.com>
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, 
	mailhol@kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-can@vger.kernel.org, Daniel Hellstrom <daniel@gaisler.com>
Subject: Re: [PATCH 06/10] can: grcan: optimize DMA by 32-bit accesses
Message-ID: <20251121-abiding-meek-bustard-187f63-mkl@pengutronix.de>
References: <20251118092115.3455-1-arun.muthusamy@gaisler.com>
 <20251118092115.3455-7-arun.muthusamy@gaisler.com>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="r7264apdwlzw3ri7"
Content-Disposition: inline
In-Reply-To: <20251118092115.3455-7-arun.muthusamy@gaisler.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org


--r7264apdwlzw3ri7
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH 06/10] can: grcan: optimize DMA by 32-bit accesses
MIME-Version: 1.0

On 18.11.2025 10:21:11, Arun Muthusamy wrote:
> From: Daniel Hellstrom <daniel@gaisler.com>
>
> Optimizes DMA transfers in the GRCAN driver by reorganizing
> data handling to use 32-bit accesses instead of individual
> byte accesses.
>
> Signed-off-by: Arun Muthusamy <arun.muthusamy@gaisler.com>
> Signed-off-by: Daniel Hellstrom <daniel@gaisler.com>
> ---
>  drivers/net/can/grcan.c | 21 ++++++++++-----------
>  1 file changed, 10 insertions(+), 11 deletions(-)
>
> diff --git a/drivers/net/can/grcan.c b/drivers/net/can/grcan.c
> index b9b0dd7d53f6..e367581faa57 100644
> --- a/drivers/net/can/grcan.c
> +++ b/drivers/net/can/grcan.c
> @@ -1287,7 +1287,7 @@ static int grcan_receive(struct net_device *dev, in=
t budget)
>  	struct sk_buff *skb;
>  	u32 wr, rd, startrd;
>  	u32 *slot;
> -	u32 i, rtr, eff, j, shift;
> +	u32 rtr, eff;
>  	int work_done =3D 0;
>
>  	rd =3D grcan_read_reg(&regs->rxrd);
> @@ -1323,10 +1323,10 @@ static int grcan_receive(struct net_device *dev, =
int budget)
>  		if (rtr) {
>  			cf->can_id |=3D CAN_RTR_FLAG;
>  		} else {
> -			for (i =3D 0; i < cf->len; i++) {
> -				j =3D GRCAN_MSG_DATA_SLOT_INDEX(i);
> -				shift =3D GRCAN_MSG_DATA_SHIFT(i);
> -				cf->data[i] =3D (u8)(slot[j] >> shift);
> +			if (cf->can_dlc > 0) {
> +				*(u32 *)(cf->data) =3D slot[2];
> +				if (cf->can_dlc > 4)
> +					*(u32 *)(cf->data + 4) =3D slot[3];

Can you can use memcpy() for this?

>  			}

>
>  			stats->rx_bytes +=3D cf->len;
> @@ -1466,8 +1466,7 @@ static netdev_tx_t grcan_start_xmit(struct sk_buff =
*skb,
>  	u32 id, txwr, txrd, space, txctrl;
>  	int slotindex;
>  	u32 *slot;
> -	u32 i, rtr, eff, dlc, tmp, err;
> -	int j, shift;
> +	u32 rtr, eff, dlc, tmp, err;
>  	unsigned long flags;
>  	u32 oneshotmode =3D priv->can.ctrlmode & CAN_CTRLMODE_ONE_SHOT;
>
> @@ -1520,10 +1519,10 @@ static netdev_tx_t grcan_start_xmit(struct sk_buf=
f *skb,
>  	slot[1] =3D ((dlc << GRCAN_MSG_DLC_BIT) & GRCAN_MSG_DLC);
>  	slot[2] =3D 0;
>  	slot[3] =3D 0;
> -	for (i =3D 0; i < dlc; i++) {
> -		j =3D GRCAN_MSG_DATA_SLOT_INDEX(i);
> -		shift =3D GRCAN_MSG_DATA_SHIFT(i);
> -		slot[j] |=3D cf->data[i] << shift;
> +	if (dlc > 0) {
> +		slot[2] =3D *(u32 *)(cf->data); /* data aligned 64-bit */
> +		if (dlc > 4)
> +			slot[3] =3D *(u32 *)(cf->data + 4);

Can you can use memcpy() for this?

Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--r7264apdwlzw3ri7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEn/sM2K9nqF/8FWzzDHRl3/mQkZwFAmkgRkwACgkQDHRl3/mQ
kZyR1gf8DSxpEeRDzmSWLm6+H99g8pd8mIBJF4OIjh7cRfsUGku7ntOFTMavRu9d
7BkJB9uRkyquCyjSeo49mU/6f1FJM75BhsUWyGCmRVVwyKq6kf8vRliY4axbcqUt
mBWZYcvMLCzB4ddXfw+u1VGEMkIJLfMKXraRW7kylQ5bIcDZCF3LNVtewom3TR9E
6h0lCmMjnBl1XDzPg6hxOUM+n6cRDlSSiLDx5vYOUR8D2F7oe83uVqcs+N/7bkdB
tZBOyex+18lgMl2u0bYR6PnBJiIqPHnYZLXvN9OyyX+s6dVvW4d01hFi4ANeTJIN
VoRgBJ1AWH+d6J1CTca//5k/ilFxOQ==
=trHk
-----END PGP SIGNATURE-----

--r7264apdwlzw3ri7--

