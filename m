Return-Path: <linux-can+bounces-1384-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B817F96BD56
	for <lists+linux-can@lfdr.de>; Wed,  4 Sep 2024 14:58:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1103AB26CF6
	for <lists+linux-can@lfdr.de>; Wed,  4 Sep 2024 12:58:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 801C21D86F7;
	Wed,  4 Sep 2024 12:56:58 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CD481D88CC
	for <linux-can@vger.kernel.org>; Wed,  4 Sep 2024 12:56:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725454618; cv=none; b=ZYfCMBRIIi+vn0P9mgEBfGgrdk3ANeeUjab9goC4eXO3dHtY4IdcslWXM5h/YzlgML6G+ZJ+snjWUYewlLDjF0EV4jQTVMZ/zL/ENwUeCopveULyEGYy+ReW8+NUJtbn2rgpawuAYWXgTS7f5Q+ZDAMRHNBAuXdv6IPkZk9AGJM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725454618; c=relaxed/simple;
	bh=ysrjmkFaxkvzl1UbrDoR+j9DjytH5gxXHZ9QFjRmEmo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JFDz4MrMsIJDy9ZEUTJbKp9I/u0GWd8TJQ8HWcO1A8aTXT6ljFHRte995tkcFjXHYJTo6pEntNfhoUY+tOFENTTu5XG2BmIIZ6wXMgpjZlyszI9+09lRI3xKymCKe25cPZnpvKT5TDiD/GLSzJfv/CI/Dxzhh/AZ5SciVO8neH8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1slpZ5-0003A9-4X; Wed, 04 Sep 2024 14:56:51 +0200
Received: from [2a0a:edc0:0:b01:1d::7b] (helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <mkl@pengutronix.de>)
	id 1slpZ4-005SPy-Ez; Wed, 04 Sep 2024 14:56:50 +0200
Received: from pengutronix.de (pd9e5994e.dip0.t-ipconnect.de [217.229.153.78])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 2AC6833273F;
	Wed, 04 Sep 2024 12:56:50 +0000 (UTC)
Date: Wed, 4 Sep 2024 14:56:49 +0200
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net, kuba@kernel.org, linux-can@vger.kernel.org, 
	kernel@pengutronix.de
Subject: Re: [PATCH net-next 0/20] pull-request: can-next 2024-09-04
Message-ID: <20240904-stirring-meteoric-cobra-831697-mkl@pengutronix.de>
References: <20240904094218.1925386-1-mkl@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="fpjaiwcqynel5whv"
Content-Disposition: inline
In-Reply-To: <20240904094218.1925386-1-mkl@pengutronix.de>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org


--fpjaiwcqynel5whv
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Please don't pull.

DTS changes should not be included in this PR. I'll send an updated one.

Sorry for the noise,
Marc

On 04.09.2024 11:38:35, Marc Kleine-Budde wrote:
> Hello netdev-team,
>=20
> this is a pull request of 20 patches for net-next/master.
>=20
> All 20 patches add support for CAN-FD IP core found on Rockchip
> RK3568.
>=20
> The first patch is co-developed by Elaine Zhang and me and adds DT
> bindings documentation.
>=20
> The next 2 patches are by David Jander and add the CAN nodes to the
> rk3568.dtsi and enable it in the rk3568-mecsbc.dts.
>=20
> The remaining 17 patches are by me and add the driver in several
> stages.
>=20
> regards,
> Marc
>=20
> ---
>=20
> The following changes since commit 3d4d0fa4fc32f03f615bbf0ac384de06ce0005=
f5:
>=20
>   be2net: Remove unused declarations (2024-09-03 15:38:22 -0700)
>=20
> are available in the Git repository at:
>=20
>   git://git.kernel.org/pub/scm/linux/kernel/git/mkl/linux-can-next.git ta=
gs/linux-can-next-for-6.12-20240904
>=20
> for you to fetch changes up to d7caa9016063ab55065468e49ae0517e0d08358a:
>=20
>   Merge patch series "can: rockchip_canfd: add support for CAN-FD IP core=
 found on Rockchip RK3568" (2024-09-04 11:37:17 +0200)
>=20
> ----------------------------------------------------------------
> linux-can-next-for-6.12-20240904
>=20
> ----------------------------------------------------------------
> David Jander (2):
>       arm64: dts: rockchip: add CAN-FD controller nodes to rk3568
>       arm64: dts: rockchip: mecsbc: add CAN0 and CAN1 interfaces
>=20
> Marc Kleine-Budde (19):
>       dt-bindings: can: rockchip_canfd: add rockchip CAN-FD controller
>       can: rockchip_canfd: add driver for Rockchip CAN-FD controller
>       can: rockchip_canfd: add quirks for errata workarounds
>       can: rockchip_canfd: add quirk for broken CAN-FD support
>       can: rockchip_canfd: add support for rk3568v3
>       can: rockchip_canfd: add notes about known issues
>       can: rockchip_canfd: rkcanfd_handle_rx_int_one(): implement workaro=
und for erratum 5: check for empty FIFO
>       can: rockchip_canfd: rkcanfd_register_done(): add warning for errat=
um 5
>       can: rockchip_canfd: add TX PATH
>       can: rockchip_canfd: implement workaround for erratum 6
>       can: rockchip_canfd: implement workaround for erratum 12
>       can: rockchip_canfd: rkcanfd_get_berr_counter_corrected(): work aro=
und broken {RX,TX}ERRORCNT register
>       can: rockchip_canfd: add stats support for errata workarounds
>       can: rockchip_canfd: prepare to use full TX-FIFO depth
>       can: rockchip_canfd: enable full TX-FIFO depth of 2
>       can: rockchip_canfd: add hardware timestamping support
>       can: rockchip_canfd: add support for CAN_CTRLMODE_LOOPBACK
>       can: rockchip_canfd: add support for CAN_CTRLMODE_BERR_REPORTING
>       Merge patch series "can: rockchip_canfd: add support for CAN-FD IP =
core found on Rockchip RK3568"
>=20
>  .../bindings/net/can/rockchip,rk3568v2-canfd.yaml  |  74 ++
>  MAINTAINERS                                        |   8 +
>  arch/arm64/boot/dts/rockchip/rk3568-mecsbc.dts     |  14 +
>  arch/arm64/boot/dts/rockchip/rk3568.dtsi           |  39 +
>  drivers/net/can/Kconfig                            |   1 +
>  drivers/net/can/Makefile                           |   1 +
>  drivers/net/can/rockchip/Kconfig                   |   9 +
>  drivers/net/can/rockchip/Makefile                  |  10 +
>  drivers/net/can/rockchip/rockchip_canfd-core.c     | 969 +++++++++++++++=
++++++
>  drivers/net/can/rockchip/rockchip_canfd-ethtool.c  |  73 ++
>  drivers/net/can/rockchip/rockchip_canfd-rx.c       | 299 +++++++
>  .../net/can/rockchip/rockchip_canfd-timestamp.c    | 105 +++
>  drivers/net/can/rockchip/rockchip_canfd-tx.c       | 167 ++++
>  drivers/net/can/rockchip/rockchip_canfd.h          | 553 ++++++++++++
>  14 files changed, 2322 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/net/can/rockchip,rk=
3568v2-canfd.yaml
>  create mode 100644 drivers/net/can/rockchip/Kconfig
>  create mode 100644 drivers/net/can/rockchip/Makefile
>  create mode 100644 drivers/net/can/rockchip/rockchip_canfd-core.c
>  create mode 100644 drivers/net/can/rockchip/rockchip_canfd-ethtool.c
>  create mode 100644 drivers/net/can/rockchip/rockchip_canfd-rx.c
>  create mode 100644 drivers/net/can/rockchip/rockchip_canfd-timestamp.c
>  create mode 100644 drivers/net/can/rockchip/rockchip_canfd-tx.c
>  create mode 100644 drivers/net/can/rockchip/rockchip_canfd.h
>=20
>=20
>=20

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--fpjaiwcqynel5whv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEUEC6huC2BN0pvD5fKDiiPnotvG8FAmbYWQ4ACgkQKDiiPnot
vG+iaAf+NlkmnpykoPqnJ/vbHQtBmBaHKTfI+PrRQnU6f3L6U1HN0VJVhphO+4qB
SNXNCEY8Ax5d/8hqF1uxpHqLlYhh6LCG2oNF/GH8bndJJumBLI2zL3Vs6UsWzxbA
MevAXR6Rpn3eYCpRjKyJaphWRBKHmwcRrjzMY0hpM8J7AVS6zSc4BbNKNtE8WzHW
KmJIy9E1P6RBvf1nJyVaFKUSsDjvS+vldf8hUmOEGhXJ/iVL/RIqKyH0brLAQ60H
PyyNr0dlVPLdwmbXToS3WufOKA6lZchVqjZhhV7tT2z/pn/ZfAASXW2aVbvYjD/1
NYNGxDD6NEtIKB22Gxz33ZGeEBEJ4w==
=c+td
-----END PGP SIGNATURE-----

--fpjaiwcqynel5whv--

