Return-Path: <linux-can+bounces-4781-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 41D6DB8FA72
	for <lists+linux-can@lfdr.de>; Mon, 22 Sep 2025 10:50:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4164416E69D
	for <lists+linux-can@lfdr.de>; Mon, 22 Sep 2025 08:50:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A90120E023;
	Mon, 22 Sep 2025 08:50:35 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3714E2777EA
	for <linux-can@vger.kernel.org>; Mon, 22 Sep 2025 08:50:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758531035; cv=none; b=bTQDBgJNYsqamWZ5wgMbVCnevkiJHhjAs0/F/IoTWVM6HMnQjh9nRU4VucmmvEytHPdss0e/IN2g/yNIptEN47hRMYiZa5CXAL8xCEUjYDwgD+SzMf9EN+RczhTSm7r0eIykQcnWV91b3D3TvxZs9/yqXRrcS1wKEjgw+X8oYno=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758531035; c=relaxed/simple;
	bh=SS6O8XSqKO1v7x49viaL2rsbT8oAdhGU7jIfpFIDFuU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=i5/y5aH8K4LKRpLiYUD9Y2JOY10z75MUSimtui5vZh5wzcQEt7co9mZML/1qUzIOF4SxsCda9XXJqbeYzHPJ1GUslYpf4D8tAVnmfWaz23ZAwtOWSzRT3lkTQFLDaS6R5Fqcs6w/Egv338kWg4D44IUZQshdxS+zdSQYpJ76Sl4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1v0cFd-0004Qf-Ka; Mon, 22 Sep 2025 10:50:25 +0200
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1v0cFc-002Yte-1E;
	Mon, 22 Sep 2025 10:50:24 +0200
Received: from pengutronix.de (p54b152ce.dip0.t-ipconnect.de [84.177.82.206])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 0A079476BEF;
	Mon, 22 Sep 2025 08:50:24 +0000 (UTC)
Date: Mon, 22 Sep 2025 10:50:23 +0200
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Andrea Daoud <andreadaoud6@gmail.com>
Cc: Heiko Stuebner <heiko@sntech.de>, 
	Elaine Zhang <zhangqing@rock-chips.com>, kernel@pengutronix.de, linux-can@vger.kernel.org, 
	netdev@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org, 
	Alexander Shiyan <eagle.alexander923@gmail.com>
Subject: Re: Possible race condition of the rockchip_canfd driver
Message-ID: <20250922-eccentric-rustling-gorilla-d2606f-mkl@pengutronix.de>
References: <CAOprWosSvBmORh9NKk-uxoWZpD6zdnF=dODS-uxVnTDjmofL6g@mail.gmail.com>
 <20250919-lurking-agama-of-genius-96b832-mkl@pengutronix.de>
 <CAOprWott046xznChj7JBNmVw3Z65uOC1_bqTbVB=LA+YBw7TTQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="2ruxaxste5kyxrlz"
Content-Disposition: inline
In-Reply-To: <CAOprWott046xznChj7JBNmVw3Z65uOC1_bqTbVB=LA+YBw7TTQ@mail.gmail.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org


--2ruxaxste5kyxrlz
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: Possible race condition of the rockchip_canfd driver
MIME-Version: 1.0

On 20.09.2025 18:08:03, Andrea Daoud wrote:
> > On 18.09.2025 20:58:33, Andrea Daoud wrote:
> > > I'm using the rockchip_canfd driver on an RK3568. When under high bus
> > > load, I get
> > > the following logs [1] in rkcanfd_tx_tail_is_eff, and the CAN bus is =
unable to
> > > communicate properly under this condition. The exact cause is current=
ly not
> > > entirely clear, and it's not reliably reproducible.
> >
> > Our customer is using a v3 silicon revision of the chip, which doesn't
> > this workaround.
>=20
> Could you please let me know how to check whether my RK3568 is v2 or v3?

Alexander Shiyan (Cc'ed) reads the information from an nvmem cell:

| https://github.com/MacroGroup/barebox/blob/macro/arch/arm/boards/diasom-r=
k3568/board.c#L239-L257

The idea is to fixup the device tree in the bootloader depending on the
SoC revision, so that the CAN driver uses only the needed workarounds.

> > > In the logs we can spot some strange points:
> > >
> > > 1. Line 24, tx_head =3D=3D tx_tail. This should have been rejected by=
 the if
> > > (!rkcanfd_get_tx_pending) clause.
> > >
> > > 2. Line 26, the last bit of priv->tx_tail (0x0185dbb3) is 1. This mea=
ns that the
> > > tx_tail should be 1, because rkcanfd_get_tx_tail is essentially mod t=
he
> > > priv->tx_tail by two. But the printed tx_tail is 0.
> > >
> > > I believe these problems could mean that the code is suffering from s=
ome race
> > > condition. It seems that, in the whole IRQ processing chain of the dr=
iver,
> > > there's no lock protection. Maybe some IRQ happens within the executi=
on of
> > > rkcanfd_tx_tail_is_eff, and touches the state of the tx_head and tx_t=
ail?
> > >
> > > Could you please have a look at the code, and check if some locking i=
s needed?
> >
> > My time for community support is currently a bit limited. I think this
> > has to wait a bit, apologies :/
>=20
> No worries, I will debug myself, and hopefully send a PR if I found
> something out.

Great, I have a both a v2 and a v3 SoC here to test.

regards,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--2ruxaxste5kyxrlz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEn/sM2K9nqF/8FWzzDHRl3/mQkZwFAmjRDcwACgkQDHRl3/mQ
kZwG6gf/b8xcXy5C2kLudCka3PJOOw8V+b51k7TIkzcjIxDUW0tY3KHlJLawnugC
V0DKwzPNG0v6bCHgfBA2IaH49W1MxVNvqsTDvQWf2udAUzGu5BYRN9bvs8qpFYpF
Pj6zlEUf0lO+Df68nqIEAekuwoXdout8CkTX6US6lgSZYe8uxPjWQ3T3fmFnzU44
iWTwK/nGOg7wUqZryuTsrmc1rkKmI2XjBek2PQSyTQxcgzMlESOuj11nhfXAVafa
BI32c6nsFwcLx8nH/KwjVGBQKkcrS3IUP//Dw0/R36nNlqiqG4lmgvsJ4y8PhCIF
ZNr9zrnmeflbjfKvZ9GdsswnKeNW5Q==
=hiC1
-----END PGP SIGNATURE-----

--2ruxaxste5kyxrlz--

