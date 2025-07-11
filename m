Return-Path: <linux-can+bounces-3960-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E617B01944
	for <lists+linux-can@lfdr.de>; Fri, 11 Jul 2025 12:04:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BF0611620E3
	for <lists+linux-can@lfdr.de>; Fri, 11 Jul 2025 10:04:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF619279DA0;
	Fri, 11 Jul 2025 10:04:31 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC8DA1CD215
	for <linux-can@vger.kernel.org>; Fri, 11 Jul 2025 10:04:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752228271; cv=none; b=cTtyG2Hu+x4RQxiMZa0OZv07S/pF6moKGSSKIDpjg7I9YlS4YK1osdjoQFeufZy0qVf6wpMkY3cwZiCFrXpOBTJ4P74ebZ8JY0kn8F3JKZneH5OFuKhuOQEQx/z8siMHk4yaLGKnuTxIq8P7YwCosFpM3FdWLZCxXwTtyROxjnM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752228271; c=relaxed/simple;
	bh=bvLqlRYQdA4HPfEvOl7SrdrZwNiykoEAA+WLD/Pep3E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rQXI41ALxxzKHJQ/4mw8NuZeNyB++mbrSKSLcH48FBXWnUuluCOYR/zWyjyii+Mfj/cEEcx2/Q+QHeOtInjpNJbMaEpnzjc4VKpMDcdCUbOaAEbdBM7JiJy2aaziz2qH1eBczyvm1vc9rYckSQbJ2pfyLjJh4YVcEUmLOcOE1jA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1uaAc9-0002yy-Lf; Fri, 11 Jul 2025 12:04:21 +0200
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1uaAc8-007u4P-0E;
	Fri, 11 Jul 2025 12:04:20 +0200
Received: from pengutronix.de (p5b1645f7.dip0.t-ipconnect.de [91.22.69.247])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id B1F5C43C7BD;
	Fri, 11 Jul 2025 10:04:19 +0000 (UTC)
Date: Fri, 11 Jul 2025 12:04:19 +0200
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Sean Nyekjaer <sean@geanix.com>
Cc: Chandrasekar Ramakrishnan <rcsekar@samsung.com>, 
	Vincent Mailhol <mailhol.vincent@wanadoo.fr>, Fengguang Wu <fengguang.wu@intel.com>, 
	Varka Bhadram <varkabhadram@gmail.com>, Dong Aisheng <b29396@freescale.com>, linux-can@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] can: m_can: apply rate-limiting to lost msg in rx
Message-ID: <20250711-sloppy-righteous-falcon-db09cc-mkl@pengutronix.de>
References: <20250630-mcan_ratelimit-v2-1-6b7a01341ea9@geanix.com>
 <20250711-astonishing-tentacled-tench-9fe229-mkl@pengutronix.de>
 <ku5336aidq5j24dswy5egbuse6a6jpfmf5j7ochenifxzy7he7@lth6f55c4nz4>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="gacxx7ldutkahecw"
Content-Disposition: inline
In-Reply-To: <ku5336aidq5j24dswy5egbuse6a6jpfmf5j7ochenifxzy7he7@lth6f55c4nz4>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org


--gacxx7ldutkahecw
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v2] can: m_can: apply rate-limiting to lost msg in rx
MIME-Version: 1.0

On 11.07.2025 09:58:53, Sean Nyekjaer wrote:
> > What about replacing the netdev_err() by netdev_dbg()?
> >=20
> > --- a/drivers/net/can/m_can/m_can.c
> > +++ b/drivers/net/can/m_can/m_can.c
> > @@ -665,7 +665,7 @@ static int m_can_handle_lost_msg(struct net_device =
*dev)
> >         struct can_frame *frame;
> >         u32 timestamp =3D 0;
> >=20
> > -       netdev_err(dev, "msg lost in rxf0\n");
> > +       netdev_dbg(dev, "msg lost in rxf0\n");
> >=20
> >         stats->rx_errors++;
> >         stats->rx_over_errors++;
> >=20
>=20
> Yeah that will do. V3 or?

Yes, please.

Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--gacxx7ldutkahecw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEn/sM2K9nqF/8FWzzDHRl3/mQkZwFAmhw4aAACgkQDHRl3/mQ
kZyQogf/U0p+sFC7xemKEG/fMP5ySKQTGKI1ZAec2lh0dnVmEIq0x/HQw6WGDlSa
G872Tf59DPZSFynCSkIv9c7ivjBpLjGjNfwPpbZHDKirIvL3cxMkdy+gzf30vG68
7IHa0hO0bZFY9omZqmCqRfstdAzDUkrTdw0m+G6hVbMv3tL6DTZz4AP5YLN+nAyr
+qCN5JBtqYIP4KcDYwUd2SQg79Yt/gMe4Tyrbjt0jPnTVSGIWr+fzgKoVNOJu+3K
89Jm+SaeXtSXzEgK5NmflyyeRbPnpOhjaxKIzPdVPIawJ0R5BPni/5dPiCcgTtCo
N4oihy/OYjg2DeCvpFt5CnvAK49ZMQ==
=Dmlr
-----END PGP SIGNATURE-----

--gacxx7ldutkahecw--

