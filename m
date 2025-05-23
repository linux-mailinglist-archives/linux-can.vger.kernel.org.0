Return-Path: <linux-can+bounces-3673-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D989AAC1E72
	for <lists+linux-can@lfdr.de>; Fri, 23 May 2025 10:16:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8F479A401B1
	for <lists+linux-can@lfdr.de>; Fri, 23 May 2025 08:16:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55DF5289811;
	Fri, 23 May 2025 08:16:06 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBA88289E1B
	for <linux-can@vger.kernel.org>; Fri, 23 May 2025 08:16:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747988166; cv=none; b=OUwVn2bWMxXHPWxLjAjuw+D3fk9PmyWIE/N8EaRrb2V2uNLou1uWUD7r3mxI+2s7yTonPicMlc8Cr4J2DqWVXoAFAZJWdLlhaFUTJZQcCmctAHieyFOSeXV2tjLeOxu9Sf/fE6JW9MXWjngmgL8PIlbc1amRVPtFmwJpcNEkXyU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747988166; c=relaxed/simple;
	bh=WnGkweXbMTvqm1k+cA/PuSpChITwx4vZKQFQpjZpfaw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gJC/ORQgeBO7t6X40Ope9bzP+RZGvUuU7+AT+tPExX5DEzExnPO8rrD9x/OMM/iPzNR90USMqvCdv3gHb20O6/gJSXuk4+Sp5uMiJpSrOxdVupLl2RBSE4vAuyFlI6Np9zykiROlb4Na0mCUsJQ+YPFH2KFOSoCFuYAmUQni6+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1uINZE-00048L-H1; Fri, 23 May 2025 10:15:48 +0200
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1uINZE-000s0g-0C;
	Fri, 23 May 2025 10:15:48 +0200
Received: from pengutronix.de (unknown [IPv6:2a03:2260:2009:2000::])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 1562B418169;
	Fri, 23 May 2025 08:15:47 +0000 (UTC)
Date: Fri, 23 May 2025 10:15:46 +0200
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Elaine Zhang <zhangqing@rock-chips.com>
Cc: kernel@pengutronix.de, mailhol.vincent@wanadoo.fr, robh@kernel.org, 
	krzk+dt@kernel.org, conor+dt@kernel.org, heiko@sntech.de, cl@rock-chips.com, 
	kever.yang@rock-chips.com, linux-can@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v5 3/4] net: can: rockchip: add can for RK3576 Soc
Message-ID: <20250523-elegant-elite-iguana-8b4116-mkl@pengutronix.de>
References: <20250523075422.4010083-1-zhangqing@rock-chips.com>
 <20250523075422.4010083-4-zhangqing@rock-chips.com>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="c5dnlywm7hswlywp"
Content-Disposition: inline
In-Reply-To: <20250523075422.4010083-4-zhangqing@rock-chips.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org


--c5dnlywm7hswlywp
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v5 3/4] net: can: rockchip: add can for RK3576 Soc
MIME-Version: 1.0

On 23.05.2025 15:54:21, Elaine Zhang wrote:
> Is new controller, new register layout and Bit position definition:
> Support CAN and CANFD protocol, ISO 11898-1
> Support transmit or receive error count
> Support acceptance filter, more functional
> Support interrupt and all interrupt can be masked
> Support error code check
> Support self test\silent\loop-back mode
> Support auto retransmission mode
> Support auto bus on after bus-off state
> Support 2 transmit buffers
> Support Internal Storage Mode
> Support DMA
>=20
> Signed-off-by: Elaine Zhang <zhangqing@rock-chips.com>

Compiling throws the following error:

| drivers/net/can/rockchip/rockchip_canfd-tx.c:173:18: error: variable 'skb=
' set but not used [-Werror,-Wunused-but-set-variable]
|   173 |         struct sk_buff *skb;
|       |                         ^

regards,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--c5dnlywm7hswlywp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEn/sM2K9nqF/8FWzzDHRl3/mQkZwFAmgwLq8ACgkQDHRl3/mQ
kZxFJgf/RJLII4jmWOIO0Kb32Hp9dCsN8hBYODQ+RosNpTkM/rBDuyJtV6a8RjoA
QkGvGiZgji4sv3G5o/kWmggUz4OIY7hbqzKWy4wy3rRVLeotubC/O4Fw7q5tYBCv
uX7C4eiAJKBiJvnnAT7qiQ4jc4foCQqZgh0b73GKu2oUmYoN7kTfl6yF/yICbbSq
sMMteatdKMyTwn5zbgSp3+QnxqWD8rnEU8eDyPOrZBhQ1PVS9Ck5prYF7e5erxEw
OpfsaJRJXfjf0h1ZTZiNbOlKvtqnUWFCDwUV/ScZ/wP94vdiRSrJfWrsKn07KjQa
rljIHYoxSu7aVhIUgk/71QvejRHWOQ==
=egoG
-----END PGP SIGNATURE-----

--c5dnlywm7hswlywp--

