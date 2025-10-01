Return-Path: <linux-can+bounces-5072-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 89910BAFA7A
	for <lists+linux-can@lfdr.de>; Wed, 01 Oct 2025 10:34:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AEC8C7AA3BC
	for <lists+linux-can@lfdr.de>; Wed,  1 Oct 2025 08:32:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2226119DF4F;
	Wed,  1 Oct 2025 08:33:56 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B441226D17
	for <linux-can@vger.kernel.org>; Wed,  1 Oct 2025 08:33:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759307636; cv=none; b=PlCrVqO+X/6nOc3ZBSzrMjUKIc476sRtTXnPjzAwOVqgpf1Wac+VuGnUdwfZNHmZ7ExupiLk7vrGacn05WN3ZAMsSq27RZInt63nusaRCqxY/2SA8AqOD4ZNTnb/EKe1XmGN+6U8g06s8EIG9dpxALZYDA4NpPPH9ubX8Y1u2Dk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759307636; c=relaxed/simple;
	bh=Vq/LfM78mbCNJEv668cPBOEAfGDzftY4J7Gd/maKNsk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kAGMvqKf+rlrVnwoXhSZsS3QmNa47kacWOcq6X/fE7Md8VooaUKsh1ESQNyeHYz1tUd7EQ3py4JQ56hI95f+z9urVXFir10+5fjNvcLWIG8omAoI814v5aNNDWM0c/3190pnX5BEeHdm7B5yHgb+h+2yLmKFwSkVE7cWy7T1P60=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1v3sHX-00089l-Tk; Wed, 01 Oct 2025 10:33:51 +0200
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1v3sHX-001Nne-1W;
	Wed, 01 Oct 2025 10:33:51 +0200
Received: from pengutronix.de (p54b152ce.dip0.t-ipconnect.de [84.177.82.206])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 3A44C47DB57;
	Wed, 01 Oct 2025 08:33:51 +0000 (UTC)
Date: Wed, 1 Oct 2025 10:33:50 +0200
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: =?utf-8?B?U3TDqXBoYW5l?= Grosjean <stephane.grosjean@free.fr>
Cc: linux-can Mailing List <linux-can@vger.kernel.org>, 
	=?utf-8?B?U3TDqXBoYW5l?= Grosjean <stephane.grosjean@hms-networks.com>
Subject: Re: [PATCH] can: peak_usb: align variable declaration and usage
Message-ID: <20251001-sociable-alligator-of-youth-b5215d-mkl@pengutronix.de>
References: <20250926124234.376881-1-stephane.grosjean@free.fr>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="a632mj7iqhlhbwtu"
Content-Disposition: inline
In-Reply-To: <20250926124234.376881-1-stephane.grosjean@free.fr>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org


--a632mj7iqhlhbwtu
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH] can: peak_usb: align variable declaration and usage
MIME-Version: 1.0

On 26.09.2025 14:42:20, St=C3=A9phane Grosjean wrote:
> From: St=C3=A9phane Grosjean <stephane.grosjean@hms-networks.com>
>=20
> delta_ts must be 64-bit due to possible 32-bit shift.
>=20
> Signed-off-by: St=C3=A9phane Grosjean <stephane.grosjean@hms-networks.com>
> Fixes: c443be70aaee ("can: peak_usb: fix shift-out-of-bounds issue")=20
> ---
>  drivers/net/can/usb/peak_usb/pcan_usb_core.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/net/can/usb/peak_usb/pcan_usb_core.c b/drivers/net/c=
an/usb/peak_usb/pcan_usb_core.c
> index dd5caa1c302b..93b33ee6f6a3 100644
> --- a/drivers/net/can/usb/peak_usb/pcan_usb_core.c
> +++ b/drivers/net/can/usb/peak_usb/pcan_usb_core.c
> @@ -108,7 +108,7 @@ void peak_usb_update_ts_now(struct peak_time_ref *tim=
e_ref, u32 ts_now)
> =20
>  	/* should wait at least two passes before computing */
>  	if (ktime_to_ns(time_ref->tv_host) > 0) {
> -		u32 delta_ts =3D time_ref->ts_dev_2 - time_ref->ts_dev_1;
> +		u64 delta_ts =3D time_ref->ts_dev_2 - time_ref->ts_dev_1;

struct peak_time_ref {
	ktime_t tv_host_0, tv_host;
	u32 ts_dev_1, ts_dev_2;
	u64 ts_total;
	u32 tick_count;
	const struct peak_usb_adapter *adapter;
};

Both ts_dev are 32 bit wide, so the difference is, too.
> =20
>  		if (time_ref->ts_dev_2 < time_ref->ts_dev_1)
>  			delta_ts &=3D (1ULL << time_ref->adapter->ts_used_bits) - 1;

if ts_used_bits is 32, the mask will be 0xffffffff, which means all of
the 32 bits of delta_ts will keep their original value.

See following user space code:

#include <stdint.h>
#include <stdio.h>
#include <stdlib.h>

int main(int argc, char *argv[])
{
	uint32_t delta_ts;
	uint32_t delta_ts_masked, delta_ts_broken;
	uint32_t mask;

	delta_ts =3D strtoul(argv[1], NULL, 0);
	mask =3D strtoul(argv[2], NULL, 0);

	delta_ts_masked =3D delta_ts & ((1ULL << mask) - 1);
	delta_ts_broken =3D delta_ts & ((1 << mask) - 1);

	printf("delta_ts=3D0x%08x delta_ts_masked=3D0x%08x delta_ts_broken=3D0x%08=
x mask=3D0x%016llx\n",
	       delta_ts, delta_ts_masked, delta_ts_broken, (1ULL << mask) - 1);

	return 0;
}

| $ ./test 0xffeeddcc 31
| delta_ts=3D0xffeeddcc delta_ts_masked=3D0x7feeddcc delta_ts_broken=3D0x7f=
eeddcc mask=3D0x000000007fffffff
| $ ./test 0xffeeddcc 32
| delta_ts=3D0xffeeddcc delta_ts_masked=3D0xffeeddcc delta_ts_broken=3D0x00=
000000 mask=3D0x00000000ffffffff

regards,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--a632mj7iqhlhbwtu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEn/sM2K9nqF/8FWzzDHRl3/mQkZwFAmjc52sACgkQDHRl3/mQ
kZxkhAf/VaLU7fBlrhOs3xu9EaeFShNqhCvw3SNGJEx//73ohf8oAaGjB75LCzyi
It9IL81lUAIVy2nWhBuR4e44Br22L6LqeU0PgRGVTfLLAqdbvQYVF1uUsnbxfQ9K
sqFANrZII+cJBu2PuBqwo95vz3IplLXtihCzkTQ1bOW95iXqYpGG3GH6XFkKF4IQ
oW2JJVSr+ddX5IR9MSBlt0esr8HQjqvq3MUtTzy2eapMhfjPZUqlU8YDgvZJTf70
l/vzBJ5T7GZrl0e8vVnQsVjAZzSLejxJf0utaF4BtlyFcYYGzuOdGmMZjswkma6u
7FMs2bVwz3wR6x+aCprMHpGNO50SIw==
=NXgW
-----END PGP SIGNATURE-----

--a632mj7iqhlhbwtu--

