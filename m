Return-Path: <linux-can+bounces-5997-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A5940CF39B4
	for <lists+linux-can@lfdr.de>; Mon, 05 Jan 2026 13:49:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CB4083028FC7
	for <lists+linux-can@lfdr.de>; Mon,  5 Jan 2026 12:49:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DEF6349B12;
	Mon,  5 Jan 2026 12:49:55 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A577349B10
	for <linux-can@vger.kernel.org>; Mon,  5 Jan 2026 12:49:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767617395; cv=none; b=TrpraHJzg5WuB0WEUszxQNXF9Pv57Vo5jEruuV/Y5USmrYT36jkFpA2/kl5ak3ju1qMTvBuZKBS0B6IW8whhuCKNqrhq4YZP+Tp8VLD4HG4Km0KiE9vSL8GTNIAqcoyPWyCp4bk3FaVEq1NdQ+lI571esOnjut9P+y80bMKhTGs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767617395; c=relaxed/simple;
	bh=lRraDb91H8EGMrvV5XOLLRb+tX4puvrC8jQuSwsaH1M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=usypbpHyshxgLcx5GItRwaak3voNILVJ3gV1QyMJLuElW5cDASTMhoR2POInB94uthctpcp4cmqj06qjh1JS7WAWE8H4sBol0I+JoWx/sgMtfhECFmpylIpWhu9GKXvnKv21kVdMq7/t1LKRfcXqFanV3hcG43nV6IxBYIT8Eog=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1vck1s-0008Dv-Um; Mon, 05 Jan 2026 13:49:48 +0100
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1vck1r-009AhK-1H;
	Mon, 05 Jan 2026 13:49:47 +0100
Received: from pengutronix.de (p54b152ce.dip0.t-ipconnect.de [84.177.82.206])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 1D46A4C664F;
	Mon, 05 Jan 2026 12:49:47 +0000 (UTC)
Date: Mon, 5 Jan 2026 13:49:46 +0100
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Pavel Pisa <pisa@fel.cvut.cz>
Cc: linux-can@vger.kernel.org, David Laight <david.laight.linux@gmail.com>, 
	"David S. Miller" <davem@davemloft.net>, Andrea Daoud <andreadaoud6@gmail.com>, 
	Wolfgang Grandegger <wg@grandegger.com>, Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org, 
	Jiri Novak <jnovak@fel.cvut.cz>, Ondrej Ille <ondrej.ille@gmail.com>
Subject: Re: [PATCH v2] can: ctucanfd: fix SSP_SRC in cases when bit-rate is
 higher than 1 MBit.
Message-ID: <20260105-rare-imported-hyrax-b2e3e2-mkl@pengutronix.de>
References: <20260105111620.16580-1-pisa@fel.cvut.cz>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="atk4rgrunsb7ifgl"
Content-Disposition: inline
In-Reply-To: <20260105111620.16580-1-pisa@fel.cvut.cz>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org


--atk4rgrunsb7ifgl
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v2] can: ctucanfd: fix SSP_SRC in cases when bit-rate is
 higher than 1 MBit.
MIME-Version: 1.0

On 05.01.2026 12:16:20, Pavel Pisa wrote:
> From: Ondrej Ille <ondrej.ille@gmail.com>
>
> The Secondary Sample Point Source field has been
> set to an incorrect value by some mistake in the
> past
>
>   0b01 - SSP_SRC_NO_SSP - SSP is not used.
>
> for data bitrates above 1 MBit/s. The correct/default
> value already used for lower bitrates is
>
>   0b00 - SSP_SRC_MEAS_N_OFFSET - SSP position =3D TRV_DELAY
>          (Measured Transmitter delay) + SSP_OFFSET.
>
> The related configuration register structure is described
> in section 3.1.46 SSP_CFG of the CTU CAN FD
> IP CORE Datasheet.
>
> The analysis leading to the proper configuration
> is described in section 2.8.3 Secondary sampling point
> of the datasheet.
>
> The change has been tested on AMD/Xilinx Zynq
> with the next CTU CN FD IP core versions:
>
>  - 2.6 aka master in the "integration with Zynq-7000 system" test
>    6.12.43-rt12+ #1 SMP PREEMPT_RT kernel with CTU CAN FD git
>    driver (change already included in the driver repo)
>  - older 2.5 snapshot with mainline kernels with this patch
>    applied locally in the multiple CAN latency tester nightly runs
>    6.18.0-rc4-rt3-dut #1 SMP PREEMPT_RT
>    6.19.0-rc3-dut
>
> The logs, the datasheet and sources are available at
>
>  https://canbus.pages.fel.cvut.cz/
>
> Signed-off-by: Ondrej Ille <ondrej.ille@gmail.com>
> Signed-off-by: Pavel Pisa <pisa@fel.cvut.cz>

While applying, re-formated patch description and added the following tags:

| Reported-by: Andrea Daoud <andreadaoud6@gmail.com>
| Closes: https://lore.kernel.org/all/CAOprWotBRv_cvD3GCSe7N2tiLooZBoDisSwb=
u+VBAmt_2izvwQ@mail.gmail.com
| Cc: stable@vger.kernel.org
| Fixes: 2dcb8e8782d8 ("can: ctucanfd: add support for CTU CAN FD open-sour=
ce IP core - bus independent part.")

regards,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--atk4rgrunsb7ifgl
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEn/sM2K9nqF/8FWzzDHRl3/mQkZwFAmlbs2cACgkQDHRl3/mQ
kZw2eAgAnOyzkTpNBnmXYyvz6S9amUP5MgyUR4WcLRaL6H6o/X5K0XLhLGc04saO
HYQ7ujYFVmEu5AT3s6cxMkiOq/VSI3WJo6DybP/hignPAldyE+GAK6tHQ4N/iZB2
HfjMbJNGZkaQNhJRqANcrSdGHOUUm4orciVB+/fAyesYklMOsM/4NGbo0gNFmq28
QVbZxUZHcLuCl/R0GgfIuPFzDYAVxj7XshsDgMf3In8Jpab6Kd2Ar+98iBgGOl4N
TTgYTIHvWU0fyY7Iap89u4cIfzrIfgD19LjJ+egU+horcGFvrryiiI/0fqRozSvi
5IaAnzaoJ6YaYK9krVPwoKxYZlXHsw==
=wYjE
-----END PGP SIGNATURE-----

--atk4rgrunsb7ifgl--

