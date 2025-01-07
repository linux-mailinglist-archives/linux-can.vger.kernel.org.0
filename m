Return-Path: <linux-can+bounces-2552-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AA3BA0404F
	for <lists+linux-can@lfdr.de>; Tue,  7 Jan 2025 14:04:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 88AA216065B
	for <lists+linux-can@lfdr.de>; Tue,  7 Jan 2025 13:04:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12D0D1F03CD;
	Tue,  7 Jan 2025 13:04:40 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B66441EE003
	for <linux-can@vger.kernel.org>; Tue,  7 Jan 2025 13:04:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736255080; cv=none; b=cWsMPVOx87DhSMYIFXCopaJy6d04pzabs428CggD294pwrr5ar+4y7c1ZVwVYRGXdSLhcva5bgLryPYya7fE4dAfTBf+4sHWS/2fPXe918UZ4gV9BMdYONYQmFabRuFzYksgZ0ysCKG6/hOyjkQaGaAzHWDbLJFEiBgN8iYtZI0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736255080; c=relaxed/simple;
	bh=/hPw75WGitfyGXoQIMKpa6lIk/LCkO5ouL196qat4eU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JRBZUsVEb+5BoN9ZEabGud79JL4WlumBdesiVG/LxVo+g923Bwz1OKm38MSQY3WhN5bSjZnxsmSNW9gW48hCstsuWveutBpryfVADvX76mu6mIEkRTRTQw6h2q9M9J0NEAcJc+AgiKo73xRlesDgn6E61xjKh2XzaV1uaZgTOOA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1tV9FZ-0003iC-6R; Tue, 07 Jan 2025 14:04:01 +0100
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1tV9FV-007Lc1-27;
	Tue, 07 Jan 2025 14:03:58 +0100
Received: from pengutronix.de (pd9e59fec.dip0.t-ipconnect.de [217.229.159.236])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id E073E3A08A6;
	Tue, 07 Jan 2025 13:03:57 +0000 (UTC)
Date: Tue, 7 Jan 2025 14:03:57 +0100
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Neil Armstrong <neil.armstrong@linaro.org>, Kevin Hilman <khilman@baylibre.com>, 
	Jerome Brunet <jbrunet@baylibre.com>, Martin Blumenstingl <martin.blumenstingl@googlemail.com>, 
	Doug Berger <opendmb@gmail.com>, Florian Fainelli <florian.fainelli@broadcom.com>, 
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, Ray Jui <rjui@broadcom.com>, 
	Scott Branden <sbranden@broadcom.com>, Vincent Mailhol <mailhol.vincent@wanadoo.fr>, 
	Maxime Coquelin <mcoquelin.stm32@gmail.com>, Alexandre Torgue <alexandre.torgue@foss.st.com>, 
	Kalle Valo <kvalo@kernel.org>, Oleksij Rempel <o.rempel@pengutronix.de>, 
	Dario Binacchi <dariobin@libero.it>, Christophe Roullier <christophe.roullier@foss.st.com>, 
	Grygorii Strashko <grygorii.strashko@ti.com>, Siddharth Vadapalli <s-vadapalli@ti.com>, 
	Roger Quadros <rogerq@kernel.org>, Brian Norris <briannorris@chromium.org>, 
	Frank Li <Frank.Li@nxp.com>, netdev@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-can@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com, 
	linux-wireless@vger.kernel.org
Subject: Re: [PATCH net-next] dt-bindings: net: Correct indentation and style
 in DTS example
Message-ID: <20250107-cocky-industrious-hare-c508f6-mkl@pengutronix.de>
References: <20250107125613.211478-1-krzysztof.kozlowski@linaro.org>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="5vdg3z53mqf4igqc"
Content-Disposition: inline
In-Reply-To: <20250107125613.211478-1-krzysztof.kozlowski@linaro.org>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org


--5vdg3z53mqf4igqc
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH net-next] dt-bindings: net: Correct indentation and style
 in DTS example
MIME-Version: 1.0

On 07.01.2025 13:56:13, Krzysztof Kozlowski wrote:
> DTS example in the bindings should be indented with 2- or 4-spaces and
> aligned with opening '- |', so correct any differences like 3-spaces or
> mixtures 2- and 4-spaces in one binding.
>=20
> No functional changes here, but saves some comments during reviews of
> new patches built on existing code.
>=20
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  .../bindings/net/can/bosch,c_can.yaml         | 10 +-
>  .../bindings/net/can/microchip,mcp2510.yaml   | 18 ++--

Acked-by: Marc Kleine-Budde <mkl@pengutronix.de> # for net/can

regards,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--5vdg3z53mqf4igqc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEUEC6huC2BN0pvD5fKDiiPnotvG8FAmd9JjoACgkQKDiiPnot
vG9NNgf/SxxAC8UsIuL4bDVaIUg+kAj0yKfrwEWjhutunUKK24lVKylz+/UY8+zv
3+LqniAsnEwHJPxLZ5S0rCe2+qZ6gsvXSBlQSqEJukZOzpWNVYECd8Wf8Q8dQzu+
qYoaEgvr5jcwNUr+cdrPvhyn4CXuNJCsdmwpfJn98S6XLhwSX+SxgiSUAkXpRmQn
EE2nnt52Dbrrk4CILlRtPPpd0/hsAXMEWGjIUBYW2f/FJqVNv+yPwZiEsIC2iDSG
V4fs/zJxh98GK89T2fN8fRzlMTG9pMPmWaQLbMPmVkHn5eJbX7LUoQzmSBe6Kgc3
I+WqIjPZzj6L9ubrNZg4MgJ3t+T4tg==
=gbSE
-----END PGP SIGNATURE-----

--5vdg3z53mqf4igqc--

