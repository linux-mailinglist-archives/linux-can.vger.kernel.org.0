Return-Path: <linux-can+bounces-3523-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A48B4AA80B8
	for <lists+linux-can@lfdr.de>; Sat,  3 May 2025 14:39:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 55BB21B63E1F
	for <lists+linux-can@lfdr.de>; Sat,  3 May 2025 12:39:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9651813FEE;
	Sat,  3 May 2025 12:39:33 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03BCD262BE
	for <linux-can@vger.kernel.org>; Sat,  3 May 2025 12:39:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746275973; cv=none; b=qL58uLspROXbZAHGphXdlHsj7f2YlJSc96TfMzP7bdsKTqDhS0KsBmV+/Mbf4av2P88+gizCcLwMJse9OGlJ+X7TW0IHAhCiPTxUMAe7s5mX5aej9vcQVlcjoYU78ZM/8bNMz3PfjYYJteboXWNvULm5iNvHwwau3g3rwfcD/Ro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746275973; c=relaxed/simple;
	bh=OiSu7gzDke+UcUrDdwjpREmfrqEALGiaR7/OqTgD9Yk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TCPoILrJIn4si+p/wkSvyGgzaN94kd43mRjDvl55dyLXRJ4d6r6LTeQ+jDrG5eG4i7YOxQjIw/aRbu2E8mwxtDnye6+s53Tso0i9XJy5tW6moh8zE8W3Fia3QaKuWUHBrgF2/AN9A8ynx/R8wT3mH4yWCx9bC0NOC56KaILrJko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1uBC9H-00029x-Mh; Sat, 03 May 2025 14:39:19 +0200
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1uBC9G-000uVw-2i;
	Sat, 03 May 2025 14:39:18 +0200
Received: from pengutronix.de (p5b1645f7.dip0.t-ipconnect.de [91.22.69.247])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 82705407484;
	Sat, 03 May 2025 12:39:18 +0000 (UTC)
Date: Sat, 3 May 2025 14:39:16 +0200
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Kelsey Maes <kelsey@vpprocess.com>
Cc: linux-can@vger.kernel.org, 
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Subject: Re: [PATCH v5] can: mcp251xfd: fix TDC setting for low data bit rates
Message-ID: <20250503-huge-cow-of-merriment-cd997b-mkl@pengutronix.de>
References: <20250430161501.79370-1-kelsey@vpprocess.com>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="cllztlc66n2lknsc"
Content-Disposition: inline
In-Reply-To: <20250430161501.79370-1-kelsey@vpprocess.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org


--cllztlc66n2lknsc
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v5] can: mcp251xfd: fix TDC setting for low data bit rates
MIME-Version: 1.0

On 30.04.2025 09:15:01, Kelsey Maes wrote:
> The TDC is currently hardcoded enabled. This means that even for lower CA=
N-FD
> data bitrates (with a DBRP (data bitrate prescaler) > 2) a TDC is configu=
red.
> This leads to a bus-off condition.
>=20
> ISO 11898-1 section 11.3.3 says "Transmitter delay compensation" (TDC) is=
 only
> applicable if DBRP is 1 or 2.
>=20
> To fix the problem, switch the driver to use the TDC calculation provided=
 by the
> CAN driver framework (which respects ISO 11898-1 section 11.3.3). This ha=
s the
> positive side effect that userspace can control TDC as needed.
>=20
> Demonstration of the feature in action:
>   $ ip link set can0 up type can bitrate 125000 dbitrate 500000 fd on
>   $ ip -details link show can0
>   3: can0: <NOARP,UP,LOWER_UP,ECHO> mtu 72 qdisc pfifo_fast state UP mode=
 DEFAULT group default qlen 10
>       link/can  promiscuity 0  allmulti 0 minmtu 0 maxmtu 0
>       can <FD> state ERROR-ACTIVE (berr-counter tx 0 rx 0) restart-ms 0
>   	  bitrate 125000 sample-point 0.875
>   	  tq 50 prop-seg 69 phase-seg1 70 phase-seg2 20 sjw 10 brp 2
>   	  mcp251xfd: tseg1 2..256 tseg2 1..128 sjw 1..128 brp 1..256 brp_inc 1
>   	  dbitrate 500000 dsample-point 0.875
>   	  dtq 125 dprop-seg 6 dphase-seg1 7 dphase-seg2 2 dsjw 1 dbrp 5
>   	  mcp251xfd: dtseg1 1..32 dtseg2 1..16 dsjw 1..16 dbrp 1..256 dbrp_inc=
 1
>   	  tdcv 0..63 tdco 0..63
>   	  clock 40000000 numtxqueues 1 numrxqueues 1 gso_max_size 65536 gso_ma=
x_segs 65535 tso_max_size 65536 tso_max_segs 65535 gro_max_size 65536 paren=
tbus spi parentdev spi0.0
>   $ ip link set can0 up type can bitrate 1000000 dbitrate 4000000 fd on
>   $ ip -details link show can0
>   3: can0: <NOARP,UP,LOWER_UP,ECHO> mtu 72 qdisc pfifo_fast state UP mode=
 DEFAULT group default qlen 10
>       link/can  promiscuity 0  allmulti 0 minmtu 0 maxmtu 0
>       can <FD,TDC-AUTO> state ERROR-ACTIVE (berr-counter tx 0 rx 0) resta=
rt-ms 0
>   	  bitrate 1000000 sample-point 0.750
>   	  tq 25 prop-seg 14 phase-seg1 15 phase-seg2 10 sjw 5 brp 1
>   	  mcp251xfd: tseg1 2..256 tseg2 1..128 sjw 1..128 brp 1..256 brp_inc 1
>   	  dbitrate 4000000 dsample-point 0.700
>   	  dtq 25 dprop-seg 3 dphase-seg1 3 dphase-seg2 3 dsjw 1 dbrp 1
>   	  tdco 7
>   	  mcp251xfd: dtseg1 1..32 dtseg2 1..16 dsjw 1..16 dbrp 1..256 dbrp_inc=
 1
>   	  tdcv 0..63 tdco 0..63
>   	  clock 40000000 numtxqueues 1 numrxqueues 1 gso_max_size 65536 gso_ma=
x_segs 65535 tso_max_size 65536 tso_max_segs 65535 gro_max_size 65536 paren=
tbus spi parentdev spi0.0
>=20
> There has been some confusion about the MCP2518FD using a relative or abs=
olute
> TDCO due to the datasheet specifying a range of [-64,63]. I have a custom=
 board
> with a 40 MHz clock and an estimated loop delay of 100 to 216 ns. During =
testing
> at a data bit rate of 4 Mbit/s I found that using can_get_relative_tdco()
> resulted in bus-off errors. The final TDCO value was 1 which corresponds =
to a
> 10% SSP in an absolute configuration. This behavior is expected if the TD=
CO
> value is really absolute and not relative. Using priv->can.tdc.tdco inste=
ad
> results in a final TDCO of 8, setting the SSP at exactly 80%. This config=
uration
> works.
>=20
> The automatic, manual, and off TDC modes were tested at speeds up to, and
> including, 8 Mbit/s on real hardware and behave as expected.
>=20
> Fixes: 55e5b97f003e ("can: mcp25xxfd: add driver for Microchip MCP25xxFD =
SPI CAN")
> Reported-by: Kelsey Maes <kelsey@vpprocess.com>
> Closes: https://lore.kernel.org/all/C2121586-C87F-4B23-A933-845362C29CA1@=
vpprocess.com
> Reviewed-by: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
> Signed-off-by: Kelsey Maes <kelsey@vpprocess.com>

Applied to linux-can.

regards,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--cllztlc66n2lknsc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEn/sM2K9nqF/8FWzzDHRl3/mQkZwFAmgWDnEACgkQDHRl3/mQ
kZwlOgf/f4RI0S65W+3yzgGaQgVYL9VzY3o77uoacFFK7mOUsnnf96PjQQFcyxPk
WAuiK3/cQ8SDSmcigT3hlBX985NdmZFz7SF9ZdWVOhXpIypcqmTnrl9DiqBrScRc
jAWFJPFyDhy7bsX5XwBDW99pFNqiPNjgEGaEK31z/S3ungycV6aQ3MVnyMgDPprg
6p9i6BKsKUwQ17hmzDu51I3S00tEHc0o+SW/xeC1F1miNZT9JdpQSs/7b8To/VMF
YJ/KEbba0yM03fkjBjjr0evQsl5CR96YibNId++JDlmzW5TsMeOLKW6a0xR4J1NF
sbF9sEfRll7fM8LiJcIA28MF2uRo8g==
=xa39
-----END PGP SIGNATURE-----

--cllztlc66n2lknsc--

