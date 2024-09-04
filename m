Return-Path: <linux-can+bounces-1359-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 37E9F96B696
	for <lists+linux-can@lfdr.de>; Wed,  4 Sep 2024 11:27:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D63241F21B7A
	for <lists+linux-can@lfdr.de>; Wed,  4 Sep 2024 09:27:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7821E1CEE8A;
	Wed,  4 Sep 2024 09:25:50 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 079061CDFDC
	for <linux-can@vger.kernel.org>; Wed,  4 Sep 2024 09:25:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725441950; cv=none; b=rkyS5nLkk3jp261x6AxDNy+tmG2Nmy2+oOk2zM1XVrgqNp1yqwR/SklkShFi9FqxbKbOOHnFNEiJrB+cZHgo3MwA1cVZhGSYqqJuGiLP3j1AdkDIjEv3ATamePSlm/FHNV6L+kKJv/onTgoFo80qembFBmkfx9Q2GavpH39l7Zg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725441950; c=relaxed/simple;
	bh=f1ap+DpWuHfV4L9uiSh9Ce1uPByPjx0+PDhLmubtWGk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gxqV4SSXo+4GfAj1T6F81TZYPY6REesve/RUI6Rcci4mIN4VKwOYict+KMgNEeBcDfVg7n2zTaj5AhOzCgu7lmNZGfBoPB55D7Ty0EGRj5dqD0ZvAvQTbqZHFy3t9RwUBD9O/mbp+cKxr4WGF8T/et5u1nFPR885t7LLShAv8/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1slmGU-0005LV-8C; Wed, 04 Sep 2024 11:25:26 +0200
Received: from [2a0a:edc0:0:b01:1d::7b] (helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <mkl@pengutronix.de>)
	id 1slmGT-005Pwc-K1; Wed, 04 Sep 2024 11:25:25 +0200
Received: from pengutronix.de (pd9e5994e.dip0.t-ipconnect.de [217.229.153.78])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 355FC332322;
	Wed, 04 Sep 2024 09:25:25 +0000 (UTC)
Date: Wed, 4 Sep 2024 11:25:24 +0200
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Heiko =?utf-8?Q?St=C3=BCbner?= <heiko@sntech.de>
Cc: kernel@pengutronix.de, Alibek Omarov <a1ba.omarov@gmail.com>, 
	Vincent Mailhol <mailhol.vincent@wanadoo.fr>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Philipp Zabel <p.zabel@pengutronix.de>, Elaine Zhang <zhangqing@rock-chips.com>, 
	David Jander <david.jander@protonic.nl>, Simon Horman <horms@kernel.org>, linux-can@vger.kernel.org, 
	netdev@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org, David Jander <david@protonic.nl>
Subject: Re: [PATCH can-next v5 03/20] arm64: dts: rockchip: mecsbc: add CAN0
 and CAN1 interfaces
Message-ID: <20240904-calculating-wapiti-of-renovation-148501-mkl@pengutronix.de>
References: <20240904-rockchip-canfd-v5-0-8ae22bcb27cc@pengutronix.de>
 <20240904-rockchip-canfd-v5-3-8ae22bcb27cc@pengutronix.de>
 <8027881.qOBuL9xsDt@diego>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="jcdxuxpemqhvjpvs"
Content-Disposition: inline
In-Reply-To: <8027881.qOBuL9xsDt@diego>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org


--jcdxuxpemqhvjpvs
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 04.09.2024 10:52:54, Heiko St=C3=BCbner wrote:
> Am Mittwoch, 4. September 2024, 10:12:47 CEST schrieb Marc Kleine-Budde:
> > From: David Jander <david@protonic.nl>
> >=20
> > This patch adds support for the CAN0 and CAN1 interfaces to the board.
> >=20
> > Signed-off-by: David Jander <david@protonic.nl>
> > Tested-by: Alibek Omarov <a1ba.omarov@gmail.com>
> > Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
> > ---
> >  arch/arm64/boot/dts/rockchip/rk3568-mecsbc.dts | 14 ++++++++++++++
> >  1 file changed, 14 insertions(+)
> >=20
> > diff --git a/arch/arm64/boot/dts/rockchip/rk3568-mecsbc.dts b/arch/arm6=
4/boot/dts/rockchip/rk3568-mecsbc.dts
> > index c2dfffc638d1..052ef03694cf 100644
> > --- a/arch/arm64/boot/dts/rockchip/rk3568-mecsbc.dts
> > +++ b/arch/arm64/boot/dts/rockchip/rk3568-mecsbc.dts
> > @@ -117,6 +117,20 @@ &cpu3 {
> >  	cpu-supply =3D <&vdd_cpu>;
> >  };
> > =20
> > +&can0 {
> > +	compatible =3D "rockchip,rk3568v3-canfd", "rockchip,rk3568v2-canfd";
> > +	pinctrl-names =3D "default";
> > +	pinctrl-0 =3D <&can0m0_pins>;
> > +	status =3D "okay";
> > +};
> > +
> > +&can1 {
> > +	compatible =3D "rockchip,rk3568v3-canfd", "rockchip,rk3568v2-canfd";
> > +	pinctrl-names =3D "default";
> > +	pinctrl-0 =3D <&can1m1_pins>;
> > +	status =3D "okay";
> > +};
> > +
>=20
> cpu3 > can0 ... aka alphabetical sorting of phandles
>=20
> Reviewed-by: Heiko Stuebner <heiko@sntech.de>
>=20
> No need to resend for that though.

Fixed.

Thanks,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--jcdxuxpemqhvjpvs
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEyBAABCgAdFiEEUEC6huC2BN0pvD5fKDiiPnotvG8FAmbYJ4EACgkQKDiiPnot
vG8zpQf40HRtHMi6gDrD4NgXJljWVMNsQS8fbDw689XxsH3RaHudW1E3WIyNPoUc
CkL+WRcoGismYlISOSBB7k/D8iU2kL9+S8JNteVd4S9MXz8D9Np9KjDjlfmnp7qh
8Ey75faWgM9+a3uvOpnD7KUrfq+mXx0o1mOj6H7T5J6cLx63+blYCpgUCkRQKXga
fH2LQGDmgAYQiCA3q2yFM+0SAUPpvk2Yg0BtPW76wptN2vD/OxXkQ6/UFNalRsrK
u4PtTWSs5YoyUZpKzeafXvqUIcTcS0CzjM3Z7z9F5FoPebiwqnUqN5CPMHdPnBtt
Eyi168DqvJX2vx54l4L4s71lYF4k
=DXUB
-----END PGP SIGNATURE-----

--jcdxuxpemqhvjpvs--

