Return-Path: <linux-can+bounces-3496-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 40C51A9EAF3
	for <lists+linux-can@lfdr.de>; Mon, 28 Apr 2025 10:39:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C8F383B9D64
	for <lists+linux-can@lfdr.de>; Mon, 28 Apr 2025 08:39:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 658B6253F02;
	Mon, 28 Apr 2025 08:39:28 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD8A825E471
	for <linux-can@vger.kernel.org>; Mon, 28 Apr 2025 08:39:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745829568; cv=none; b=gj5K9EujniaTlFmlN5N2Mv/FJJr0q8diFC+mOw8jDO9xqYZxE2y/WbPZJeYtF5QfjGQXdK389fYxTCEdb4qOleqG+I5g8QIBnE6aOUhSov1Dktedl4/1jbehrmffHG/QevW4wH6V+yB+yTDUe+vyu3bBmRznlIgM5DHS3P7RcCw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745829568; c=relaxed/simple;
	bh=nAyAptyDqwaCLIc4TzQ4/e7aXY2+KKhN+cQCF184+aI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CUkF5If6j54PzEr8FmkA7vVO1o3FFix/hMKwfnGCjUCF06f0otft85PdHvs5b21FpVgtwGDnziQS5M48ExEH4GPpya0B64glENmzqw8tg68CgFl7mzqca7iICulCA36tR48YLv688FsHqOJPb82FLe8BjOsTFt9MMO85hRh1YAs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1u9K1M-0000nO-5a; Mon, 28 Apr 2025 10:39:24 +0200
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1u9K1L-000402-2D;
	Mon, 28 Apr 2025 10:39:23 +0200
Received: from pengutronix.de (p5b1645f7.dip0.t-ipconnect.de [91.22.69.247])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 1CAAE4032A2;
	Mon, 28 Apr 2025 06:08:00 +0000 (UTC)
Date: Mon, 28 Apr 2025 08:07:59 +0200
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Cc: Kelsey Maes <kelsey@vpprocess.com>, linux-can@vger.kernel.org
Subject: Re: [PATCH] can: mcp251xfd: make TDC controllable from userspace
Message-ID: <20250428-loose-agouti-of-wizardry-8f07f2-mkl@pengutronix.de>
References: <20250425191336.45581-1-kelsey@vpprocess.com>
 <CAMZ6RqKZK4eZhcTh5Lh8N294Y67FARGvO=r5ZP=P7iZ5ofKXYQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="ox6hu7adsnbkm24s"
Content-Disposition: inline
In-Reply-To: <CAMZ6RqKZK4eZhcTh5Lh8N294Y67FARGvO=r5ZP=P7iZ5ofKXYQ@mail.gmail.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org


--ox6hu7adsnbkm24s
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH] can: mcp251xfd: make TDC controllable from userspace
MIME-Version: 1.0

On 26.04.2025 13:23:34, Vincent Mailhol wrote:
> > There has been some confusion about the MCP2518FD using a relative or a=
bsolute
> > TDCO due to the datasheet specifying a range of [-64,63]. I have a cust=
om board
> > with a 40 MHz clock and an estimated loop delay of 100 to 216 ns. Durin=
g testing
> > at a data bit rate of 4 Mbit/s I found that using can_get_relative_tdco=
()
> > resulted in bus-off errors. The final TDCO value was 1 which correspond=
s to a
> > 10% SSP in an absolute configuration. This behavior is expected if the =
TDCO
> > value is really absolute and not relative. Using priv->can.tdc.tdco ins=
tead
> > results in a final TDCO of 8, setting the SSP at exactly 80%. This conf=
iguration
> > works.
>=20
> Your patch actually fixes an issue. Can you add this tag?
>=20
> Fixes: 55e5b97f003e ("can: mcp25xxfd: add driver for Microchip
> MCP25xxFD SPI CAN")
>=20
> @Marc, what do you think about the backport? The TDC framework was
> introduced a bit later so it is not possible to apply this patch as-is
> to the v5.10.x stable branch. However, it should apply smoothly to
> v5.15.x and anything after.
>=20
> So my suggestion would be to leave this unfixed in v5.10 (this isn't a
> major issue either) and just backport it to v5.15 and greater.

Sounds like a plan!

regards,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--ox6hu7adsnbkm24s
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEn/sM2K9nqF/8FWzzDHRl3/mQkZwFAmgPGzwACgkQDHRl3/mQ
kZwS8wf/ZShnnkAuZKzDhpN4cZ/YzsnXy+dddMy8GE4/WIbGHshEfQT/jmJx6O2k
eTCDdxfd7trio3wql5pYBQO0IP47OBXWAgXlXofGWp3FCDanc4Bf8/hQC+v+6Yeq
uDQUc1OB4RUoqu/jJYiSs082vsLoEl5yxJnEU7iTnsC1c5q8BOagMIO+ULJU+FG/
dgrvMoOqfrac2tQgfQKZ7M0YsnePwt3m53obQaRzqEPvAo1kKwzHIwcegmhyTkxp
BB81nDb6RzRsP3KtYiuUAnicbFbJ0jOdgdONhd8TkE7jecOBluswlBxOc1kofv4k
EOTGlZwRWMJyqsGrAfpKgaQYTT9hKQ==
=UwNj
-----END PGP SIGNATURE-----

--ox6hu7adsnbkm24s--

