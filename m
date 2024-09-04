Return-Path: <linux-can+bounces-1358-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9550396B65A
	for <lists+linux-can@lfdr.de>; Wed,  4 Sep 2024 11:20:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 53219283140
	for <lists+linux-can@lfdr.de>; Wed,  4 Sep 2024 09:20:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A718A18A95E;
	Wed,  4 Sep 2024 09:20:12 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B6B9194C82
	for <linux-can@vger.kernel.org>; Wed,  4 Sep 2024 09:20:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725441612; cv=none; b=DzHYJGt09IdtGqJQtcHjhg+fjmUg1zX/4IrCnf9KMMQtD9MkZ9ruGkpHGc4LX9OUkS1NU3XIUgsVLwDIr+mEhyP3FWZaijF8IRfvF0vCaEmY1Y8e8bTPR+msJLZHG6KE0TtcG+wfEFx8Ov4517C8m8AdteR98DOLlHV94jlYv2w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725441612; c=relaxed/simple;
	bh=WuRMqP+opsdPUvNSiW70+emfjDzD9Qgliwa3GLm0GmI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uN3iy7Kwc1ktbuWL6t7s90ZK5OiQKAqBnMYp515mO2i+7Rqks95iOrTl3Rk9fBscXBHIEyR4iX6AVKGVOEz1S/rHxjzedYxMpHH5datK02Z3EPLWoLajjf0RPqikCtTEUQrzGDJJZKV3OZNeLMN0BapC8L9km+50S5zFSoOfESs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1slmAz-0002tc-Pd; Wed, 04 Sep 2024 11:19:45 +0200
Received: from [2a0a:edc0:0:b01:1d::7b] (helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <mkl@pengutronix.de>)
	id 1slmAx-005PrZ-1z; Wed, 04 Sep 2024 11:19:43 +0200
Received: from pengutronix.de (pd9e5994e.dip0.t-ipconnect.de [217.229.153.78])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id A4329332301;
	Wed, 04 Sep 2024 09:19:42 +0000 (UTC)
Date: Wed, 4 Sep 2024 11:19:42 +0200
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
Subject: Re: [PATCH can-next v5 00/20] can: rockchip_canfd: add support for
 CAN-FD IP core found on Rockchip RK3568
Message-ID: <20240904-meticulous-original-sturgeon-ad2db3-mkl@pengutronix.de>
References: <20240904-rockchip-canfd-v5-0-8ae22bcb27cc@pengutronix.de>
 <86274585.BzKH3j3Lxt@diego>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="2ss46ydut665ggdf"
Content-Disposition: inline
In-Reply-To: <86274585.BzKH3j3Lxt@diego>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org


--2ss46ydut665ggdf
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 04.09.2024 10:55:21, Heiko St=C3=BCbner wrote:
> Hi Marc,
>=20
> Am Mittwoch, 4. September 2024, 10:12:44 CEST schrieb Marc Kleine-Budde:
> > This series adds support for the CAN-FD IP core found on the Rockchip
> > RK3568.
> >=20
> > The IP core is a bit complicated and has several documented errata.
> > The driver is added in several stages, first the base driver including
> > the RX-path. Then several workarounds for errata and the TX-path, and
> > finally features like hardware time stamping, loop-back mode and
> > bus error reporting.
> >=20
> > regards,
> > Marc
> >=20
> > Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
>=20
> I have neither CAN knowledge, nor hardware to test, but the integration
> itself looks pretty easy and straight-forward.
>=20
> Not sure how much it helps, but at this moment I assume you know what
> you're doing with respect to the CAN controller ;-)

I hope so :) The controller has some flaws :/

> Rest of the series (that hasn't got a Rb):
>=20
> Acked-by: Heiko Stuebner <heiko@sntech.de>

Thanks.

> How/when are you planning on applying stuff?
>=20
> I.e. if you're going to apply things still for 6.12, you could simply take
> the whole series if the dts patches still apply to your tree ;-)

Actually I've already started my PR workflow, but I'll address your
review feedback, add your tags and send a new PR today. This will go via
net-next into v6.12.

regards,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--2ss46ydut665ggdf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEUEC6huC2BN0pvD5fKDiiPnotvG8FAmbYJioACgkQKDiiPnot
vG8qKwf/e6qNy9jnMMR4a2ZA/TwN7Gvr9EtSz4YN78xGfPErfDaPjMMw11WRNBA0
foCcQRuNrOh/JoM+LcOO+bFM35p+M5GoPnXZreAuHolU7OZzSrCC6CVIFwuQKVDm
qVnmgnt5AU3YjFvU79RyPUHCtxsFQQPqDUKusLRgevAkXDtc2GwNDNumKrOaQGe2
8A+NSKRHYzpd1NYm2K/RV6VmbxrjWe8Zd3TlaFAQTjIaDadCmjbo2qA+3HjIwenm
CKYMxixTvEjEffTEBRy0AX2Cnp6j5xX7VmYdCDYrPzfvhWZx1vm2KFQ+pDWk+mNa
18dciG/5BLFa6hiFAx+agcVetZGWiA==
=Wdm5
-----END PGP SIGNATURE-----

--2ss46ydut665ggdf--

