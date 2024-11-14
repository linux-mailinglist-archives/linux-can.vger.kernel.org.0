Return-Path: <linux-can+bounces-2041-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D03C19C85F1
	for <lists+linux-can@lfdr.de>; Thu, 14 Nov 2024 10:21:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4DD6BB2D3F5
	for <lists+linux-can@lfdr.de>; Thu, 14 Nov 2024 09:20:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F13F1DF75D;
	Thu, 14 Nov 2024 09:19:52 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4BA11DD543
	for <linux-can@vger.kernel.org>; Thu, 14 Nov 2024 09:19:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731575992; cv=none; b=UaphI0bUVZxh96qR7SeT75vKn89EbwZSq1rIUdPgvfTtPB5MCi/9bs/I5/wthHqAgsDUuQJhNW7Ux6USbtQK6O3J2YQGv7IlbW8u4VDyqFL3wjywoBwteZv9CIpsEFdm4SP1FqMeGmlNvjIgIms99Eh7P5ICZOVmEwr+Z/bFdwg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731575992; c=relaxed/simple;
	bh=LWHAAfli4bGRK7npkueODa/RoTdZufayfH7el0f67kY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=q12IHm0XPriz/F3YaVzcXtAb+coK1G1NtGI02BakAKrhQuqmzSf+sdoa29D4YlNYtp/adiJzsSh3PVxEQXFjX4VZeeUVctov4G8goO8TmgHcoXqkZ9QoFeFVeae+9HzfvbF6C5+gBUv3QKv+EUAQwdbxo96ChaQwjrKI+wvVDLo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1tBW0o-0007PW-9J; Thu, 14 Nov 2024 10:19:38 +0100
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1tBW0o-000ibL-0E;
	Thu, 14 Nov 2024 10:19:38 +0100
Received: from pengutronix.de (pd9e59fec.dip0.t-ipconnect.de [217.229.159.236])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id C35B6372F20;
	Thu, 14 Nov 2024 09:19:37 +0000 (UTC)
Date: Thu, 14 Nov 2024 10:19:37 +0100
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Sean Nyekjaer <sean@geanix.com>
Cc: Vincent Mailhol <mailhol.vincent@wanadoo.fr>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, linux-can@vger.kernel.org, 
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH can-next v4 1/2] dt-bindings: can: tcan4x5x: Document the
 ti,nwkrq-voltage-vio option
Message-ID: <20241114-foamy-acrid-dalmatian-9d3afe-mkl@pengutronix.de>
References: <20241114-tcan-wkrqv-v4-0-f22589d67fb1@geanix.com>
 <20241114-tcan-wkrqv-v4-1-f22589d67fb1@geanix.com>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="vrzucmzcc43o4bfu"
Content-Disposition: inline
In-Reply-To: <20241114-tcan-wkrqv-v4-1-f22589d67fb1@geanix.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org


--vrzucmzcc43o4bfu
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH can-next v4 1/2] dt-bindings: can: tcan4x5x: Document the
 ti,nwkrq-voltage-vio option
MIME-Version: 1.0

On 14.11.2024 09:52:21, Sean Nyekjaer wrote:
> The nWKRQ pin supports an output voltage of either the internal reference
> voltage (3.6V) or the reference voltage of
> the digital interface 0-6V (VIO).
> Add the devicetree option ti,nwkrq-voltage-vio to set it to VIO.
>=20
> If this property is omitted the reset default, the internal reference
> voltage, is used.
>=20
> Signed-off-by: Sean Nyekjaer <sean@geanix.com>

Reviewed-by: Marc Kleine-Budde <mkl@pengutronix.de>

regards,
Marc

> ---
>  Documentation/devicetree/bindings/net/can/ti,tcan4x5x.yaml | 8 ++++++++
>  1 file changed, 8 insertions(+)
>=20
> diff --git a/Documentation/devicetree/bindings/net/can/ti,tcan4x5x.yaml b=
/Documentation/devicetree/bindings/net/can/ti,tcan4x5x.yaml
> index f1d18a5461e05296998ae9bf09bdfa1226580131..ff18cf7393550d1b7107b1233=
d8302203026579d 100644
> --- a/Documentation/devicetree/bindings/net/can/ti,tcan4x5x.yaml
> +++ b/Documentation/devicetree/bindings/net/can/ti,tcan4x5x.yaml
> @@ -106,6 +106,13 @@ properties:
>        Must be half or less of "clocks" frequency.
>      maximum: 18000000
> =20
> +  ti,nwkrq-voltage-vio:
> +    type: boolean
> +    description:
> +      nWKRQ Pin GPO buffer voltage configuration.
> +      Set nWKRQ to use VIO voltage rail.
> +      When not set nWKRQ will use internal voltage rail.
> +
>    wakeup-source:
>      $ref: /schemas/types.yaml#/definitions/flag
>      description:
> @@ -157,6 +164,7 @@ examples:
>              device-state-gpios =3D <&gpio3 21 GPIO_ACTIVE_HIGH>;
>              device-wake-gpios =3D <&gpio1 15 GPIO_ACTIVE_HIGH>;
>              reset-gpios =3D <&gpio1 27 GPIO_ACTIVE_HIGH>;
> +            ti,nwkrq-voltage-vio;
>              wakeup-source;
>          };
>      };
>=20
> --=20
> 2.46.2
>=20
>=20
>=20

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--vrzucmzcc43o4bfu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEUEC6huC2BN0pvD5fKDiiPnotvG8FAmc1wKcACgkQKDiiPnot
vG/wzggAlj0QJLxPRJoeuzsuwing/AB0/PX1rp6tStujNzgEFZ05HPwxf60F5ZiD
makZVZXtI5sUDjw6QyxPpeOBCkHNXoGzHK607qpI1uFNgpfF3lkFtQ5bYIu0DE5F
EOqHrMYLf2+zjKDn5vUl0gvoryuG/jm42TpTQDCovMQ2B4+3R4BBptbaWn+OuAxl
tbmbSY/8SHtSjjVfXP8uvIaTt0w8xTh5LMFCEkxw3DOzWzv9KEyy97Mi17ALKVs0
4d5dgrVAaKdNmEsHqOSeRGP5/LXOkmgFrFIQPWRxa8Q5wSnPemQoFpUlMIII5A+A
ym5nw+foS7CrhQ096Ky+HKIpSaeEJA==
=yFj+
-----END PGP SIGNATURE-----

--vrzucmzcc43o4bfu--

