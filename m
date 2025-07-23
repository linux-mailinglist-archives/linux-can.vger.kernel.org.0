Return-Path: <linux-can+bounces-4059-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C6A7B0F17B
	for <lists+linux-can@lfdr.de>; Wed, 23 Jul 2025 13:40:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7D85D3BBA8E
	for <lists+linux-can@lfdr.de>; Wed, 23 Jul 2025 11:40:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C86B82E0924;
	Wed, 23 Jul 2025 11:40:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b="kC2WPWDa"
X-Original-To: linux-can@vger.kernel.org
Received: from mail.zeus03.de (zeus03.de [194.117.254.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E48D928B4F8
	for <linux-can@vger.kernel.org>; Wed, 23 Jul 2025 11:40:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.117.254.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753270845; cv=none; b=NvgECmOIyA6SRjAhkJP2iGMOeleDH1O4ufO+AonhMdcKNSK4VKl7dzikEhPbrpveCf7kyERvgNDAMQBzzRK/yYrQymIeZ6dwxjCG66BpA1HAsF9+erKm31BzKGqnq2oIf+fUuQDillOpIWRxfbKvdx8rmGt8sg+1k65a9KlADBI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753270845; c=relaxed/simple;
	bh=vBLeINt+biwJoMtPoVVFU+AyFpkgcapAO9E+5gGvdxs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=g22ibheL85BhKwTvt29K3MkuqPhgFncl38kfqJQDu5oVEVvx4kq9LtFUrQvwdPE91qTLBatJXAj9Wf87HHKo76KzcHGOqh9bemWx+gZbgUjdzAqgLOGxZAB0GORU5q7ZdUx6/YexC1EnugNNW3RfHsxrp4ZHo8GXN9Ik1kw8ks4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com; spf=pass smtp.mailfrom=sang-engineering.com; dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b=kC2WPWDa; arc=none smtp.client-ip=194.117.254.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sang-engineering.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	sang-engineering.com; h=date:from:to:cc:subject:message-id
	:references:mime-version:content-type:in-reply-to; s=k1; bh=vBLe
	INt+biwJoMtPoVVFU+AyFpkgcapAO9E+5gGvdxs=; b=kC2WPWDaokTQoHdXhIqT
	+4nvQmuF7Q6kQWiGDR97P/l4ZZbVpwRg+0wN6fs/NdCJ75oAC/LWN4hvQWFAahTk
	kCis8IkWJgij5/2XKql6tjdb4MNCrPlvaX5UZpn5ZAEm+1eZiNS1AfJ4ljCbKqNL
	zeYFhgmN1vmr/5RjZNhTaBuDDlMUN6JTK1flvRnlVlaC3880HKxMjsZpolFIaZcb
	8cEX3vDBmv43xJiw4bkHyFbabsUW35++L1rIx8TtDOECt4N1EcHdK2o4VQ7dqLIA
	KYhmY+PxaV4ok7JfIYGrnzIwgJmF0ODVcGOwnmepXLEp/HL24kp2jjurDETPCYsB
	QQ==
Received: (qmail 1683768 invoked from network); 23 Jul 2025 13:40:38 +0200
Received: by mail.zeus03.de with UTF8SMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 23 Jul 2025 13:40:38 +0200
X-UD-Smtp-Session: l3s3148p1@LMKHLZc6ltAujnvr
Date: Wed, 23 Jul 2025 13:40:38 +0200
From: Wolfram Sang <wsa+renesas@sang-engineering.com>
To: a0282524688@gmail.com
Cc: tmyu0@nuvoton.com, lee@kernel.org, linus.walleij@linaro.org,
	brgl@bgdev.pl, andi.shyti@kernel.org, mkl@pengutronix.de,
	mailhol.vincent@wanadoo.fr, andrew+netdev@lunn.ch,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, wim@linux-watchdog.org, linux@roeck-us.net,
	jdelvare@suse.com, alexandre.belloni@bootlin.com,
	linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
	linux-i2c@vger.kernel.org, linux-can@vger.kernel.org,
	netdev@vger.kernel.org, linux-watchdog@vger.kernel.org,
	linux-hwmon@vger.kernel.org, linux-rtc@vger.kernel.org,
	linux-usb@vger.kernel.org
Subject: Re: [PATCH v14 3/7] i2c: Add Nuvoton NCT6694 I2C support
Message-ID: <aIDKNieKis55kyZN@shikoro>
References: <20250715025626.968466-1-a0282524688@gmail.com>
 <20250715025626.968466-4-a0282524688@gmail.com>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="Iem7TgVIXcEduHhw"
Content-Disposition: inline
In-Reply-To: <20250715025626.968466-4-a0282524688@gmail.com>


--Iem7TgVIXcEduHhw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 15, 2025 at 10:56:22AM +0800, a0282524688@gmail.com wrote:
> From: Ming Yu <a0282524688@gmail.com>
>=20
> This driver supports I2C adapter functionality for NCT6694 MFD
> device based on USB interface.
>=20
> Each I2C controller uses the default baudrate of 100kHz, which
> can be overridden via module parameters.
>=20
> Acked-by: Andi Shyti <andi.shyti@kernel.org>
> Signed-off-by: Ming Yu <a0282524688@gmail.com>

Reviewed-by: Wolfram Sang <wsa+renesas@sang-engineering.com>


--Iem7TgVIXcEduHhw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAmiAyjIACgkQFA3kzBSg
KbZiTA//QkvcMLKXy7oEhoPaRSSzTZUtGps1YigTeY52v1SgTJ/ySNv1fAEE54ei
gr1ochYm/mhCI4ahDZFZZ2j2ulA34KchA8SQ0Tj20RPyQz9jbgHiNPP6Wsgl4kk4
z943QFzVoxDlxWoWhnkJbwMMCO683Oq/JPRP3DSgVbLRbVBVXdNgp7mit9zgmZev
2koMgmj6AePIWn35T2/U7pIS4vVzYVzHqycllQdt+XmA5U/V8b3ozjswOKHNDDZf
64brf3wbZLM5xDg8gXI6qmceEWYTAfY4i7epDpqZtFclVRcnHl2+guWppdu7TO2F
OGpaqLudduYZG//U2VX3WycczzhsboQoEiLJb/lfAw+xfI/pjbN7FRlQhtd4e/0t
0rRJMjckmrmFA4G9Yu+Hd3AA2OcLt0FcW/z3+HXUFLd8HvORVgozd/nF1fyYMlKD
ySy+iBx9eYxgGGxAw8xiWGFIMIJ8Xc40D2SZ1Rh7ZAZTJvDklJpvB2iHSsU86yMD
1XRWJO14df/RrKqsfecRa49LXmpbNU5pbHshW4p7IJaeWhjliAa5j9kA77Y/iWDq
fShNWwC5++edujKlXVdHX+46+fikhZTo374+SrY3mx49zcZcL1UQ/MTgX3vmMfkk
SyTxZuVMK+Vr5jA7+vjMkCm7G/9thcIsx/sRYG5LXfIKnd/NZMQ=
=KBkq
-----END PGP SIGNATURE-----

--Iem7TgVIXcEduHhw--

