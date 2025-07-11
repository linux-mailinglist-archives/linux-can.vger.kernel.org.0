Return-Path: <linux-can+bounces-3955-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A7840B017FA
	for <lists+linux-can@lfdr.de>; Fri, 11 Jul 2025 11:35:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 48B6A5A141B
	for <lists+linux-can@lfdr.de>; Fri, 11 Jul 2025 09:35:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3367521B9F0;
	Fri, 11 Jul 2025 09:34:02 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 825FA1F3B85
	for <linux-can@vger.kernel.org>; Fri, 11 Jul 2025 09:33:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752226442; cv=none; b=L0TE6saFHIjGfR8o/pr/qLmuycIPyTFG7sIb0kTHL8xfJhNk5VB1gqGBKJiu3jWuayY2rfiA9iqzWfMY/JIOoTHpPoMoz14S6RvvnBa3iowiF5QKkvICLLgf/pTJNJcK59I5bDJgu5njowMEDkUbwAnCrhXJX48Czr+sWMdKJbk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752226442; c=relaxed/simple;
	bh=Ta5GjM9SSUFo+zaONrfM2NcvqjadSAMqcbhQquMVlFE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ShUNI/YkxuByICk2Tjz++jcjsnZrigVUdLqPGhwjQURMyl/Tp28jlfnoR4JrS1SsLUtNnBmEZ8vWyYD95kY2P8l5M5fB+/sj5mBXA7da9DhRyVki44Fn2+lKMj++yFn2z0KSxLCKQqIJRV7Al82ZswGAkQoL7X4pCTHSckRSG3U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1uaA8P-0004kr-Ox; Fri, 11 Jul 2025 11:33:37 +0200
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1uaA8N-007tjw-38;
	Fri, 11 Jul 2025 11:33:36 +0200
Received: from pengutronix.de (p5b1645f7.dip0.t-ipconnect.de [91.22.69.247])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 93B6A43C755;
	Fri, 11 Jul 2025 09:33:35 +0000 (UTC)
Date: Fri, 11 Jul 2025 11:33:35 +0200
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Sean Nyekjaer <sean@geanix.com>
Cc: Chandrasekar Ramakrishnan <rcsekar@samsung.com>, 
	Vincent Mailhol <mailhol.vincent@wanadoo.fr>, Fengguang Wu <fengguang.wu@intel.com>, 
	Varka Bhadram <varkabhadram@gmail.com>, Dong Aisheng <b29396@freescale.com>, linux-can@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] can: m_can: apply rate-limiting to lost msg in rx
Message-ID: <20250711-astonishing-tentacled-tench-9fe229-mkl@pengutronix.de>
References: <20250630-mcan_ratelimit-v2-1-6b7a01341ea9@geanix.com>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="myshn7loduw7tdyg"
Content-Disposition: inline
In-Reply-To: <20250630-mcan_ratelimit-v2-1-6b7a01341ea9@geanix.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org


--myshn7loduw7tdyg
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v2] can: m_can: apply rate-limiting to lost msg in rx
MIME-Version: 1.0

On 30.06.2025 09:52:44, Sean Nyekjaer wrote:
> Wrap the "msg lost in rxf0" error in m_can_handle_lost_msg() with
> a call to net_ratelimit() to prevent flooding the kernel log
> with repeated debug messages.
>
> Fixes: e0d1f4816f2a ("can: m_can: add Bosch M_CAN controller support")
> Reviewed-by: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
> Signed-off-by: Sean Nyekjaer <sean@geanix.com>
> ---
> Changes in v2:
> - Changed to dbg msg
> - Link to v1: https://lore.kernel.org/r/20250620-mcan_ratelimit-v1-1-e747=
ee30f71f@geanix.com
> ---
>  drivers/net/can/m_can/m_can.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/net/can/m_can/m_can.c b/drivers/net/can/m_can/m_can.c
> index 6c656bfdb3235e1f5d6405c49b07b821ddacc1b9..9f43111609d364c01c6df1048=
9fc4708deab9fbb 100644
> --- a/drivers/net/can/m_can/m_can.c
> +++ b/drivers/net/can/m_can/m_can.c
> @@ -665,7 +665,8 @@ static int m_can_handle_lost_msg(struct net_device *d=
ev)
>  	struct can_frame *frame;
>  	u32 timestamp =3D 0;
>
> -	netdev_err(dev, "msg lost in rxf0\n");
> +	if (net_ratelimit())
> +		netdev_dbg(dev, "msg lost in rxf0\n");

This has some subtle side effects. Even if debugging is not enabled, you
will still get the "... output lines suppressed due to ratelimiting"
message, which is IMHO very confusing :)

What about replacing the netdev_err() by netdev_dbg()?

--- a/drivers/net/can/m_can/m_can.c
+++ b/drivers/net/can/m_can/m_can.c
@@ -665,7 +665,7 @@ static int m_can_handle_lost_msg(struct net_device *dev)
        struct can_frame *frame;
        u32 timestamp =3D 0;

-       netdev_err(dev, "msg lost in rxf0\n");
+       netdev_dbg(dev, "msg lost in rxf0\n");

        stats->rx_errors++;
        stats->rx_over_errors++;

regards,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--myshn7loduw7tdyg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEn/sM2K9nqF/8FWzzDHRl3/mQkZwFAmhw2msACgkQDHRl3/mQ
kZzbNgf+I17X+decbgDxV9wzfsT8Zdk54vZDmImS6/M/yWaYgO0I9vz0zfTEk0Qk
XViSutCZEgEzOX5Um6DtvL39XRSB7wpWoHlk6cA4YQJLYAPyl83cD6FC9oPPkHgV
2ozpb2+l/v1ZBKLzX/tS1R3bhLYkzfx8YsQZSTodGIr4p2Eitzih5eGd/Ey451yI
M5xKMXlhZ4Jz6gF1lai55H3EJvZB+a6CPc1dFwlHpjbNq8iRAFv7Ut5GC08CsJAW
3pN8O5U1tn/K75v75fub0iRyxuSxxPeOpGzk1uinPogAhpJfBNmuXyP8RRxf3HUF
bl8Ri2syy2Ga3X576/qsBRWIkOFd0w==
=R6JF
-----END PGP SIGNATURE-----

--myshn7loduw7tdyg--

