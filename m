Return-Path: <linux-can+bounces-4563-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 97CADB4D60D
	for <lists+linux-can@lfdr.de>; Tue,  9 Sep 2025 14:09:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 528CA16D97C
	for <lists+linux-can@lfdr.de>; Tue,  9 Sep 2025 12:09:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E3112C0F60;
	Tue,  9 Sep 2025 12:09:09 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD6F824503B
	for <linux-can@vger.kernel.org>; Tue,  9 Sep 2025 12:09:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757419749; cv=none; b=sGs2krX2ak7npOLEtHoBBgHI3dnC0K1AjqGlljQcu1QTwvRZx+mp5BYbbFDsbw+fHRNJgLxIKjZcu1I7fLvBVc3H0NyK2D7a49Er8F79oldaxgYvhKsS7Dszc5jf1qBvSlMw8L0Ge1H5qlR80oi1h/qafdVOTJDgfMYKSGFMQPk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757419749; c=relaxed/simple;
	bh=pmi9z2rNOsL9GtbWEhdGdsyMfwgTgS60FBSTZt6GaC8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Qe3igqBUsl7fpmGrQZ/9gynuFp/kV8zTgwS2PswT7LjRV0sdITbMlYggWOra1dvkeVo0Tf7ksEybfAikvIMHHH7D7v56ra/4ugofsVQgvdByQ0UB3GWLBPqgXItqTaZcdlwdBSLy2VvdIKlzAf7F/qMawS3zmFojQaASb2kUOQM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1uvx9k-0000BT-M7; Tue, 09 Sep 2025 14:09:04 +0200
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1uvx9j-000Pw9-37;
	Tue, 09 Sep 2025 14:09:03 +0200
Received: from pengutronix.de (p54b152ce.dip0.t-ipconnect.de [84.177.82.206])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id A7087469EC6;
	Tue, 09 Sep 2025 12:09:03 +0000 (UTC)
Date: Tue, 9 Sep 2025 14:09:03 +0200
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Anssi Hannula <anssi.hannula@bitwise.fi>
Cc: Appana Durga Kedareswara rao <appana.durga.rao@xilinx.com>, 
	linux-can@vger.kernel.org
Subject: Re: [PATCH] can: xilinx_can: fix use-after-free of transmitted SKB
Message-ID: <20250909-flounder-of-scientific-perception-f9f8d6-mkl@pengutronix.de>
References: <20250822095002.168389-1-anssi.hannula@bitwise.fi>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="o2b2bnpr7fdclbza"
Content-Disposition: inline
In-Reply-To: <20250822095002.168389-1-anssi.hannula@bitwise.fi>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org


--o2b2bnpr7fdclbza
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH] can: xilinx_can: fix use-after-free of transmitted SKB
MIME-Version: 1.0

On 22.08.2025 12:50:02, Anssi Hannula wrote:
> can_put_echo_skb() takes ownership of the SKB and it may be freed
> during or after the call.
>=20
> However, xilinx_can xcan_write_frame() keeps using SKB after the call.
>=20
> Fix that by only calling can_put_echo_skb() after the code is done
> touching the SKB.
>=20
> The tx_lock is held for the entire xcan_write_frame() execution and
> also on the can_get_echo_skb() side so the order of operations does not
> matter.
>=20
> An earlier fix 3d3c817c3a40 ("can: xilinx_can: Fix usage of skb memory")
               ^^^

added missing "commit"

> did not move the can_put_echo_skb() call far enough.
>=20
> Signed-off-by: Anssi Hannula <anssi.hannula@bitwise.fi>
> Fixes: 1598efe57b3e ("can: xilinx_can: refactor code in preparation for C=
AN FD support")
> ---
>  drivers/net/can/xilinx_can.c | 16 ++++++++--------
>  1 file changed, 8 insertions(+), 8 deletions(-)
>=20
> diff --git a/drivers/net/can/xilinx_can.c b/drivers/net/can/xilinx_can.c
> index 3f2e378199abb..c14ffbe8e501a 100644
> --- a/drivers/net/can/xilinx_can.c
> +++ b/drivers/net/can/xilinx_can.c
> @@ -690,14 +690,6 @@ static void xcan_write_frame(struct net_device *ndev=
, struct sk_buff *skb,
>  		dlc |=3D XCAN_DLCR_EDL_MASK;
>  	}
> =20
> -	if (!(priv->devtype.flags & XCAN_FLAG_TX_MAILBOXES) &&
> -	    (priv->devtype.flags & XCAN_FLAG_TXFEMP))
> -		can_put_echo_skb(skb, ndev, priv->tx_head % priv->tx_max, 0);
> -	else
> -		can_put_echo_skb(skb, ndev, 0, 0);
> -
> -	priv->tx_head++;
> -
>  	priv->write_reg(priv, XCAN_FRAME_ID_OFFSET(frame_offset), id);
>  	/* If the CAN frame is RTR frame this write triggers transmission
>  	 * (not on CAN FD)
> @@ -730,6 +722,14 @@ static void xcan_write_frame(struct net_device *ndev=
, struct sk_buff *skb,
>  					data[1]);
>  		}
>  	}
> +
> +	if (!(priv->devtype.flags & XCAN_FLAG_TX_MAILBOXES) &&
> +		(priv->devtype.flags & XCAN_FLAG_TXFEMP))
           ^^^^^^

I've fixed the indention.

> +		can_put_echo_skb(skb, ndev, priv->tx_head % priv->tx_max, 0);
> +	else
> +		can_put_echo_skb(skb, ndev, 0, 0);
> +
> +	priv->tx_head++;
>  }
> =20
>  /**
> --=20

Applied to linux-can.

regards,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--o2b2bnpr7fdclbza
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEn/sM2K9nqF/8FWzzDHRl3/mQkZwFAmjAGNsACgkQDHRl3/mQ
kZw3uQf9HNWhs5bGDGClO4lVaJkYVYf7BQrJez9yqqqYWSYYbioPaJP0dwM4JKtS
cqd5nfFcfFpHcZP2tyJazNNMl3oMdK2KRaT6dh/jiJGo25a53daZ5TWNlRBg4KZx
kU3H/1C8yYRYqx4p0v5+jmopq+ACyOgsHbUMe1fEyRPgCDmjWY+Ygdducj5J75Kk
HXZdv76I+w9IfiV8cfyTzaU1s7IS+tOrkf4hEL43PljJe07YB7vrOh7hnCXsKaaX
gD2CBEDxr9C80QhByh8Es43PXVs2cnFTD8datlZbjwsMMxQiG07cYnfnj4wmhNXm
yLNsHKJojEWWM6wD0Ml2OVMrEQRZ6w==
=oAwD
-----END PGP SIGNATURE-----

--o2b2bnpr7fdclbza--

