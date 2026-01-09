Return-Path: <linux-can+bounces-6064-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id F0EBFD08AC7
	for <lists+linux-can@lfdr.de>; Fri, 09 Jan 2026 11:46:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 32FAB304868A
	for <lists+linux-can@lfdr.de>; Fri,  9 Jan 2026 10:42:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAC8C189906;
	Fri,  9 Jan 2026 10:42:15 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01D6333ADB9
	for <linux-can@vger.kernel.org>; Fri,  9 Jan 2026 10:41:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767955335; cv=none; b=rSnfhTO7rF61yVzd6fu/uJle226Ml0p1Ix5BtnvBuFopBGsDLg2CJh23kFGFnCT48Nhosh8GpC1gf3UhphRqWnrLGqFUbCtYZOHYzx7sfeC2Lq16cmMfY2I1ParYoyJIyjiOvpZA0/jMka98a6jy/Q4k34B03BaO+q55Qm213Oc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767955335; c=relaxed/simple;
	bh=CJ7mfMxSr3ixZHs7K2E2IvaqEB4tBwme3NDzoMwXXig=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kVcP1bRodUt4QxBXSZa9iF7CMUVLnrTlcfo8iipVOsluqRh9HaMI4AY48cdnwpksUma8D3lFt1i74RliCqD/Ajyx1nwTWaL0lzcvpstFAsKUDfzniZX8gGvoMzrsmq/MW8mZXS/GBbLSmQSM3u37nYMN4QA1f0VbiLEl0lnVSwU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1ve9wC-0006ft-4E; Fri, 09 Jan 2026 11:41:48 +0100
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1ve9wB-009paz-2j;
	Fri, 09 Jan 2026 11:41:47 +0100
Received: from pengutronix.de (unknown [IPv6:2a03:2260:2009::])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 5C7024C97A9;
	Fri, 09 Jan 2026 10:41:47 +0000 (UTC)
Date: Fri, 9 Jan 2026 11:41:46 +0100
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Oliver Hartkopp <socketcan@hartkopp.net>
Cc: linux-can@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, 
	Vincent Mailhol <mailhol@kernel.org>
Subject: Re: [PATCH 3/3] can: raw: instantly reject disabled CAN frames
Message-ID: <20260109-gainful-sheep-of-promise-5a0721-mkl@pengutronix.de>
References: <20260101191330.1836-1-socketcan@hartkopp.net>
 <20260101191330.1836-3-socketcan@hartkopp.net>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="by7hj4j4by2qwto4"
Content-Disposition: inline
In-Reply-To: <20260101191330.1836-3-socketcan@hartkopp.net>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org


--by7hj4j4by2qwto4
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH 3/3] can: raw: instantly reject disabled CAN frames
MIME-Version: 1.0

On 01.01.2026 20:13:30, Oliver Hartkopp wrote:
> For real CAN interfaces the CAN_CTRLMODE_FD and CAN_CTRLMODE_XL control
> modes indicate whether an interface can handle those CAN FD/XL frames.
>
> In the case a CAN XL interface is configured in CANXL-only mode with
> disabled error-signalling neither CAN CC nor CAN FD frames can be sent.
>
> The checks are now performed on CAN_RAW sockets to give an instant feedba=
ck
> to the user when writing unsupported CAN frames to the interface or when
> the CAN interface is in read-only mode.
>
> Fixes: 1a620a723853 ("can: raw: instantly reject unsupported CAN frames")
> Cc: Marc Kleine-Budde <mkl@pengutronix.de>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: Vincent Mailhol <mailhol@kernel.org>
> Signed-off-by: Oliver Hartkopp <socketcan@hartkopp.net>
> ---
>  net/can/raw.c | 23 ++++++++++++++---------
>  1 file changed, 14 insertions(+), 9 deletions(-)
>
> diff --git a/net/can/raw.c b/net/can/raw.c
> index f36a83d3447c..aa6e8b19be22 100644
> --- a/net/can/raw.c
> +++ b/net/can/raw.c
> @@ -48,11 +48,11 @@
>  #include <linux/socket.h>
>  #include <linux/if_arp.h>
>  #include <linux/skbuff.h>
>  #include <linux/can.h>
>  #include <linux/can/core.h>
> -#include <linux/can/dev.h> /* for can_is_canxl_dev_mtu() */
> +#include <linux/can/can-ml.h> /* for can_cap_enabled() */

I think we can remove the comment, please keep the list sorted.

otherwise LGTM, thanks
Marc

--
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--by7hj4j4by2qwto4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEn/sM2K9nqF/8FWzzDHRl3/mQkZwFAmlg22cACgkQDHRl3/mQ
kZwF0wf7Bfnuy42MNCnrnZMbaKj7ALqW4DNp3AvSWdty7i8+GDpJFadNTbUiyV7U
dpoFibYOs3ls89VuXq3fkNHpX7vfWxv3/Q+WrmZrMdrHE3qINZO98B5plkpPEYBO
/9jnjWLbJ61a7c44a8xpx8g8l9bKuQ46M5b8TJKKwr6za7GJh8C5cdrSS2/tMdcb
Co0ryze/R1z7u+030YQZ4xwYslWR+DVdh+EAxdidGugKA9CnN2JUykaF97B1GXGh
TIqCkJzCwe4e3h9+waiaQl1HWlLZEJg4+7ldA4FB/OvjeWMVDopanUiTV67p4bGv
1vV5ApJ6w9G4VnW33ArRiAenAwkXiw==
=TOba
-----END PGP SIGNATURE-----

--by7hj4j4by2qwto4--

