Return-Path: <linux-can+bounces-3509-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 54A7DAA42B5
	for <lists+linux-can@lfdr.de>; Wed, 30 Apr 2025 07:55:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2C9B93AF3C3
	for <lists+linux-can@lfdr.de>; Wed, 30 Apr 2025 05:55:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACC7319E98B;
	Wed, 30 Apr 2025 05:55:35 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35C55D2FB
	for <linux-can@vger.kernel.org>; Wed, 30 Apr 2025 05:55:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745992535; cv=none; b=La8ytGFIpgLDQjIFMS1P1L6veKEsfBhc7y5G+K4gYu0OdTF56aW4tY2trH9STrGj0MNWXeC0ScMsBcL0qQiL5WNZH51SB4ceTpahzfXcZV7mbnEfgS4b5zqpZuPse/VeLZg4i6rz86pzmG0P0oBkihhqWuQJQhAgmHhvWDGRCTU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745992535; c=relaxed/simple;
	bh=FSXgqNJu03aTciCC74ui1OuOFQmRJCEze76XqA8i5kU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=l3VuC2ZovoU5vWB3+0Gxgf9aUwNJ8yyGnSW7PAA0aQ9LYv33MGVOfAcYy+lY3/fRZg+41KhlOgOAoHzGl3izPhFJ+b6f1MNqZ9WWf3AUj0kfj7x2sSahDSqNFs/wyMaPHiCTqgS3SL/v8K7WMg/3l9n5Hon3Y5XPXHZQyu4iDbM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1uA0Pi-0003r8-QS; Wed, 30 Apr 2025 07:55:22 +0200
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1uA0Pi-000NTk-0G;
	Wed, 30 Apr 2025 07:55:22 +0200
Received: from pengutronix.de (p5b1645f7.dip0.t-ipconnect.de [91.22.69.247])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 88964404C23;
	Wed, 30 Apr 2025 05:53:13 +0000 (UTC)
Date: Wed, 30 Apr 2025 07:53:12 +0200
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Kelsey Maes <kelsey@vpprocess.com>
Cc: Vincent Mailhol <mailhol.vincent@wanadoo.fr>, 
	linux-can@vger.kernel.org, Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: Re: [PATCH v4] can: mcp251xfd: fix TDC setting for low data bit rates
Message-ID: <20250430-truthful-nautilus-of-amplitude-60af12-mkl@pengutronix.de>
References: <20250429173221.52101-1-kelsey@vpprocess.com>
 <87c3e3b0-f069-4053-b10a-5091cedbb940@wanadoo.fr>
 <FDE0052A-9434-43B7-9D6F-EB3151C93DA6@vpprocess.com>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="7txfd52qkfxcy7er"
Content-Disposition: inline
In-Reply-To: <FDE0052A-9434-43B7-9D6F-EB3151C93DA6@vpprocess.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org


--7txfd52qkfxcy7er
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v4] can: mcp251xfd: fix TDC setting for low data bit rates
MIME-Version: 1.0

On 29.04.2025 19:43:13, Kelsey Maes wrote:
> On Apr 29, 2025, at 19:00, Vincent Mailhol <mailhol.vincent@wanadoo.fr> w=
rote:
> >=20
> > On 30/04/2025 at 02:32, Kelsey Maes wrote:
> >> The TDC is currently hardcoded enabled. This means that even for lower=
 CAN-FD
> >> data bitrates (with a DBRP (data bitrate prescaler) > 2) a TDC is conf=
igured.
> >> This leads to a bus-off condition.
> >>=20
> >> ISO 11898-1 section 11.3.3 says "Transmitter delay compensation" (TDC)=
 is only
> >> applicable if DBRP is 1 or 2.
> >>=20
> >> To fix the problem, switch the driver to use the TDC calculation provi=
ded by the
> >> CAN driver framework (which respects ISO 11898-1 section 11.3.3). This=
 has the
> >> positive side effect that userspace can control TDC as needed.
> >>=20
> >> Demonstration of the feature in action:
> >>  $ ip link set can0 up type can bitrate 125000 dbitrate 500000 fd on
> >>  $ ip -details link show can0
> >>  3: can0: <NOARP,UP,LOWER_UP,ECHO> mtu 72 qdisc pfifo_fast state UP mo=
de DEFAULT group default qlen 10
> >>      link/can  promiscuity 0  allmulti 0 minmtu 0 maxmtu 0
> >>      can <FD> state ERROR-ACTIVE (berr-counter tx 0 rx 0) restart-ms 0
> >>     bitrate 125000 sample-point 0.875
> >>     tq 50 prop-seg 69 phase-seg1 70 phase-seg2 20 sjw 10 brp 2
> >>     mcp251xfd: tseg1 2..256 tseg2 1..128 sjw 1..128 brp 1..256 brp_inc=
 1
> >>     dbitrate 500000 dsample-point 0.875
> >>     dtq 125 dprop-seg 6 dphase-seg1 7 dphase-seg2 2 dsjw 1 dbrp 5
> >>     mcp251xfd: dtseg1 1..32 dtseg2 1..16 dsjw 1..16 dbrp 1..256 dbrp_i=
nc 1
> >>     tdco 0..63
> >          ^^^^^^^^^^
> >=20
> > Did you update this part of the message after introduction the manual m=
ode? This
> > should have read:
> >=20
> >  tdcv 0..63 tdco 0..63
> >=20
> > after the update.
>=20
> It did read like that during my testing, I just did not update the quote.=
 Should I issue a
> v5 patch?

Either send a v5 or paste the console output here and I'll add it. :)

> >>     clock 40000000 numtxqueues 1 numrxqueues 1 gso_max_size 65536 gso_=
max_segs 65535 tso_max_size 65536 tso_max_segs 65535 gro_max_size 65536 par=
entbus spi parentdev spi0.0
> >>  $ ip link set can0 up type can bitrate 1000000 dbitrate 4000000 fd on
> >>  $ ip -details link show can0
> >>  3: can0: <NOARP,UP,LOWER_UP,ECHO> mtu 72 qdisc pfifo_fast state UP mo=
de DEFAULT group default qlen 10
> >>      link/can  promiscuity 0  allmulti 0 minmtu 0 maxmtu 0
> >>      can <FD,TDC-AUTO> state ERROR-ACTIVE (berr-counter tx 0 rx 0) res=
tart-ms 0
> >>     bitrate 1000000 sample-point 0.750
> >>     tq 25 prop-seg 14 phase-seg1 15 phase-seg2 10 sjw 5 brp 1
> >>     mcp251xfd: tseg1 2..256 tseg2 1..128 sjw 1..128 brp 1..256 brp_inc=
 1
> >>     dbitrate 4000000 dsample-point 0.700
> >>     dtq 25 dprop-seg 3 dphase-seg1 3 dphase-seg2 3 dsjw 1 dbrp 1
> >>     tdco 7
> >>     mcp251xfd: dtseg1 1..32 dtseg2 1..16 dsjw 1..16 dbrp 1..256 dbrp_i=
nc 1
> >>     tdco 0..63
> >>     clock 40000000 numtxqueues 1 numrxqueues 1 gso_max_size 65536 gso_=
max_segs 65535 tso_max_size 65536 tso_max_segs 65535 gro_max_size 65536 par=
entbus spi parentdev spi0.0
> >>=20
> >> There has been some confusion about the MCP2518FD using a relative or =
absolute
> >> TDCO due to the datasheet specifying a range of [-64,63]. I have a cus=
tom board
> >> with a 40 MHz clock and an estimated loop delay of 100 to 216 ns. Duri=
ng testing
> >> at a data bit rate of 4 Mbit/s I found that using can_get_relative_tdc=
o()
> >> resulted in bus-off errors. The final TDCO value was 1 which correspon=
ds to a
> >> 10% SSP in an absolute configuration. This behavior is expected if the=
 TDCO
> >> value is really absolute and not relative. Using priv->can.tdc.tdco in=
stead
> >> results in a final TDCO of 8, setting the SSP at exactly 80%. This con=
figuration
> >> works.
> >>=20
> >> The automatic, manual, and off TDC modes were tested at speeds up to, =
and
> >> including, 8 Mbit/s on real hardware and behave as expected.
> >=20
> > Thanks for also adding the manual mode!
> >=20
> >> Fixes: 55e5b97f003e ("can: mcp25xxfd: add driver for Microchip MCP25xx=
FD SPI CAN")
> >> Reported-by: Kelsey Maes <kelsey@vpprocess.com>
> >> Closes: https://lore.kernel.org/all/C2121586-C87F-4B23-A933-845362C29C=
A1@vpprocess.com
> >> Signed-off-by: Kelsey Maes <kelsey@vpprocess.com>
> >=20
> > Congrats for your first patch! Notwithstanding of above nitpick:
> >=20
> > Reviewed-by: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
>=20
> Thanks! Should I add this tag in the v5? Is there anything else I need to=
 do to get this upstream?

Yes, if you send a v5, include this tag, otherwise the tool "b4" I'm
using will add it automatically for my while applying the patch.

No further actions to get this mainline are needed. But I'm quite busy
today, you can ping me end of next week if I forget this patch.

regards,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--7txfd52qkfxcy7er
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEn/sM2K9nqF/8FWzzDHRl3/mQkZwFAmgRusUACgkQDHRl3/mQ
kZylbQf/dEAcb8BxVoH7WfnOJy93LuVhhh7w8oBVtrO26mRb9NsquWMt3BHJqv3o
k7cgTS028abnwcWKQtuxAI6AmplQROVTGgXbKs9v45fjzkyvIISytdEFb3mIKzf+
GD3YID9L3hbmo9czQTurxwWsTCZLz4WnFyEjka1JN4YPUH2UYXhk+UcKByFU6I5/
Y5XZRvLpBaXAnL9PCzta9r0Ov7G3iv2VWEnpsC2OfAWHpzmr23ABuRrLNUDKtKW3
ay5BDhA+cwi9opKuVxTM4VhDAx3I/nmlnGoG3fvJZ7O2GIUmNDbzi1c33gIh4yKG
m1WvDd7ZGDK2NH2YMCiDMqNDaclaAQ==
=nSyX
-----END PGP SIGNATURE-----

--7txfd52qkfxcy7er--

