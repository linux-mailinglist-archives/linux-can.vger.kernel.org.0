Return-Path: <linux-can+bounces-2555-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 00EABA04125
	for <lists+linux-can@lfdr.de>; Tue,  7 Jan 2025 14:48:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6AB9B3A12E9
	for <lists+linux-can@lfdr.de>; Tue,  7 Jan 2025 13:48:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D1AB1F0E43;
	Tue,  7 Jan 2025 13:48:31 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A68A11F0E52
	for <linux-can@vger.kernel.org>; Tue,  7 Jan 2025 13:48:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736257711; cv=none; b=GaB6mT4Yi6iiWxtlUlGcVYdOkCzRauXg8kIJrovkX2UMM3n4KWIPNCqE3DMSY5CzFO2cCTOKtywgHmUGGfHxyFcs3ieXuPHQVHJICG1CMBuKK8/R2hcz4hWgxClOA4IYGEgCXSMcBbDoXmvkXSEkKTtUGGIrHM5n+ZK3qcGS7Ok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736257711; c=relaxed/simple;
	bh=cvLDMvZ9dRo7Bgr4jycM32wtYh+oNlLa6C42KkZo/TU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=puVbv5SkaBIUqHNoaDWeeokoDUMrprWSt4ZjXwYhDm4K4MftQhyCC/kKh8i/+T3p07MWM88/AK9XqUoW2OtQtmoRJK1XWbKqexw6gGMABwfhzzY6OAmKp8Znfd8sQ8sWuySwCwb3AJoYXFDBfEhdXXvvQZLqA0l9H3M6oUHA6qA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1tV9wR-0004Z7-9m; Tue, 07 Jan 2025 14:48:19 +0100
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1tV9wP-007M20-1L;
	Tue, 07 Jan 2025 14:48:18 +0100
Received: from pengutronix.de (pd9e59fec.dip0.t-ipconnect.de [217.229.159.236])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id C8E4A3A0954;
	Tue, 07 Jan 2025 13:48:17 +0000 (UTC)
Date: Tue, 7 Jan 2025 14:48:17 +0100
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Alexander =?utf-8?B?SMO2bHps?= <alexander.hoelzl@gmx.net>
Cc: robin@protonic.nl, socketcan@hartkopp.net, davem@davemloft.net, 
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, corbet@lwn.net, 
	kernel@pengutronix.de, linux-can@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] j1939: fix unable to send messages with data length zero
Message-ID: <20250107-conscious-daring-lemming-c63aa8-mkl@pengutronix.de>
References: <20250107133217.119646-1-alexander.hoelzl@gmx.net>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="vxpme32c2iydzg67"
Content-Disposition: inline
In-Reply-To: <20250107133217.119646-1-alexander.hoelzl@gmx.net>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org


--vxpme32c2iydzg67
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH] j1939: fix unable to send messages with data length zero
MIME-Version: 1.0

On 07.01.2025 14:32:17, Alexander H=C3=B6lzl wrote:
> The J1939 standard requires the transmission of messages of length 0.
> For example the proprietary messages are specified with a data length
> of 0 to 1785. The transmission of such messages was not possible.
> Sending such a message resulted in no error being returned but no
> corresponding can frame being generated.

What does your patch do? Please describe it here.

Marc

> Signed-off-by: Alexander H=C3=B6lzl <alexander.hoelzl@gmx.net>
> ---
>  net/can/j1939/socket.c    | 4 ++--
>  net/can/j1939/transport.c | 5 +++--
>  2 files changed, 5 insertions(+), 4 deletions(-)
>=20
> diff --git a/net/can/j1939/socket.c b/net/can/j1939/socket.c
> index 305dd72c844c..17226b2341d0 100644
> --- a/net/can/j1939/socket.c
> +++ b/net/can/j1939/socket.c
> @@ -1132,7 +1132,7 @@ static int j1939_sk_send_loop(struct j1939_priv *pr=
iv,  struct sock *sk,
>=20
>  	todo_size =3D size;
>=20
> -	while (todo_size) {
> +	do {
>  		struct j1939_sk_buff_cb *skcb;
>=20
>  		segment_size =3D min_t(size_t, J1939_MAX_TP_PACKET_SIZE,
> @@ -1177,7 +1177,7 @@ static int j1939_sk_send_loop(struct j1939_priv *pr=
iv,  struct sock *sk,
>=20
>  		todo_size -=3D segment_size;
>  		session->total_queued_size +=3D segment_size;
> -	}
> +	} while (todo_size);
>=20
>  	switch (ret) {
>  	case 0: /* OK */
> diff --git a/net/can/j1939/transport.c b/net/can/j1939/transport.c
> index 319f47df3330..99832e60c08d 100644
> --- a/net/can/j1939/transport.c
> +++ b/net/can/j1939/transport.c
> @@ -382,8 +382,9 @@ sk_buff *j1939_session_skb_get_by_offset(struct j1939=
_session *session,
>  	skb_queue_walk(&session->skb_queue, do_skb) {
>  		do_skcb =3D j1939_skb_to_cb(do_skb);
>=20
> -		if (offset_start >=3D do_skcb->offset &&
> -		    offset_start < (do_skcb->offset + do_skb->len)) {
> +		if ((offset_start >=3D do_skcb->offset &&
> +		     offset_start < (do_skcb->offset + do_skb->len)) ||
> +			(offset_start =3D=3D 0 && do_skcb->offset =3D=3D 0 && do_skb->len =3D=
=3D 0)) {
>  			skb =3D do_skb;
>  		}
>  	}
> --
> 2.43.0
>=20
>=20
>=20

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--vxpme32c2iydzg67
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEUEC6huC2BN0pvD5fKDiiPnotvG8FAmd9MJ4ACgkQKDiiPnot
vG/l6AgAhak9L/3s2F2He8AP9r2x4LJNpKRcQ+492x2vyKtSofznR4tZBg02eYXN
dhvfdY6yv8jnbCc7/bpI4vgxyvGvIDTJok5V/boQ4/ubK0bNvFRgtMwXTvGSKBcW
0C9TddSCyPUg3+iYjagbZ++qTo02iEsI3BChYYonif1967953df/vmV8cKudOnLn
PO+No+i2yfDagu1BOzO0Isg9+dWXC9IneOx9wwjF1fjdivLqcjXrAM6EkCQTGpTT
5YiJoJNYiP100cHF9rmC2kpdakxJl/yeHPlRfo0jnEZdrhWuhidLQoYfdoZ3oEeI
WADmhhGiHjeXtzRqJ8nqVLfNSP+Yug==
=TuID
-----END PGP SIGNATURE-----

--vxpme32c2iydzg67--

