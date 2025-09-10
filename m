Return-Path: <linux-can+bounces-4635-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EC474B51495
	for <lists+linux-can@lfdr.de>; Wed, 10 Sep 2025 12:55:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 04D461C81995
	for <lists+linux-can@lfdr.de>; Wed, 10 Sep 2025 10:56:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A630B3115A2;
	Wed, 10 Sep 2025 10:55:34 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0366C303A1A
	for <linux-can@vger.kernel.org>; Wed, 10 Sep 2025 10:55:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757501734; cv=none; b=RuWKdNy/LJpQUwnxCXZznxgDXQJdtejXqPdalFFmMirL4WAeSHneT58oK1d05ygKMyDIt1LpeWJp8lodChui3h4TavOfQMSoUnJHViefrzf5750/mlwtHGecgoXWi0ahvYkonK2VDMWNzEuLdTxxUsfzdwMp81nLJcNkypq88zM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757501734; c=relaxed/simple;
	bh=8nvkIAZCReg0X56hAjdZQZYgX4EEt2Ac+PloTh3KTII=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=E+e5JWgoFEBR4b1Ug6pZSqv8tCZ8uZUpIp/8ET0GEbAruk6aYTwvzGZ5T4SYFUzYF7huafJeKRj8EriwK7T3XNUt9DnXafQHLIpO+MH3/LNoB2mAMtTI7QVGLf1ewBI8bQiJt1NRv+nQEFefvC79RWzMjNRD3woCElHxPm2PFgQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1uwIU0-0008BJ-B7; Wed, 10 Sep 2025 12:55:24 +0200
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1uwITz-000Zpd-1H;
	Wed, 10 Sep 2025 12:55:23 +0200
Received: from pengutronix.de (glittertind.blackshift.org [116.203.23.228])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 0E29846AD9E;
	Wed, 10 Sep 2025 10:55:23 +0000 (UTC)
Date: Wed, 10 Sep 2025 12:55:22 +0200
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Vincent Mailhol <mailhol@kernel.org>
Cc: Oliver Hartkopp <socketcan@hartkopp.net>, 
	=?utf-8?B?U3TDqXBoYW5l?= Grosjean <stephane.grosjean@hms-networks.com>, Robert Nawrath <mbro1689@gmail.com>, 
	Minh Le <minh.le.aj@renesas.com>, Duy Nguyen <duy.nguyen.rh@renesas.com>, 
	linux-can@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 04/20] can: netlink: refactor can_validate_bittiming()
Message-ID: <20250910-quaint-weightless-narwhal-658e26-mkl@pengutronix.de>
References: <20250910-canxl-netlink-prep-v2-0-f128d4083721@kernel.org>
 <20250910-canxl-netlink-prep-v2-4-f128d4083721@kernel.org>
 <20250910-outrageous-liberal-falcon-9215d3-mkl@pengutronix.de>
 <1c7024ba-60fc-472d-982a-ab45b4f23748@kernel.org>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="m5knyjl545q6dpmc"
Content-Disposition: inline
In-Reply-To: <1c7024ba-60fc-472d-982a-ab45b4f23748@kernel.org>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org


--m5knyjl545q6dpmc
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v2 04/20] can: netlink: refactor can_validate_bittiming()
MIME-Version: 1.0

On 10.09.2025 15:43:00, Vincent Mailhol wrote:
> On 10/09/2025 at 15:13, Marc Kleine-Budde wrote:
> > On 10.09.2025 15:03:29, Vincent Mailhol wrote:
> >> Whenever can_validate_bittiming() is called, it is always preceded by
> >> some boilerplate code which was copy pasted all over the place. Move
> >> that repeated code directly inside can_validate_bittiming().
> >>
> >> Finally, the mempcy() is not needed. Just use the pointer returned by
> >> nla_data() as-is.
> >=20
> > The memcpy()'ed struct is guaranteed to be properly aligned, is this
> > also the case for the casted nla_data() pointer?
>=20
> The NLA attributes are aligned on 4 bytes, c.f. NLA_ALIGNTO:
>=20
> https://elixir.bootlin.com/linux/v6.16.5/source/include/uapi/linux/netlin=
k.h#L248
>=20
> Which is sufficient for struct can_bittiming which also requires just 4 b=
ytes of
> alignment as proven by the fact the the code would still compile if I add=
 this
> static assert:
>=20
>   static_assert(_Alignof(typeof(*bt)) <=3D NLA_ALIGNTO);
>=20
> But I have to admit that you caught me off guard. I did not think of that=
=2E Maybe
> I should add above static assertions to the code to document that what we=
 are
> doing is correct?

Yes, make it so!

regards,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--m5knyjl545q6dpmc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEn/sM2K9nqF/8FWzzDHRl3/mQkZwFAmjBWRgACgkQDHRl3/mQ
kZzB+AgAt34/hIMo1GS6hgYwJLghxiyPkp3HrhyAEM0sfWNvtLPvml/q7s/FFgrK
2Yy8GwqDDJZ4B8djBQq/Sj5dBFGmRLhL/tWB9bUQnXk32KZ/TvblkCaFTWf/76Va
1z3RWKW6aVl9vDQ5q9IRTnx9WbIlHJx9Eq+fmz7R9unF0Wo6QgYKfq2mhQqzkcJL
ZWtA+U2RfLKbQ+9Fh8rCljZfkao/cbbSEPmRDEwUlQPjg3bfoQZXAIv712YHP3yg
Pi1INm2XgE8BLcRvEtD9d3wt42yv7KVm9ZdKScUm0KGbbs2FuYY+yfr/UOR7jYgy
fFaa19bR9S3TAiOduI11xUGTXIuNhw==
=uaFW
-----END PGP SIGNATURE-----

--m5knyjl545q6dpmc--

