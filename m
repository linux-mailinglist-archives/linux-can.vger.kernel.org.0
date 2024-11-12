Return-Path: <linux-can+bounces-1978-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CD3F79C504E
	for <lists+linux-can@lfdr.de>; Tue, 12 Nov 2024 09:09:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3B1E71F225AC
	for <lists+linux-can@lfdr.de>; Tue, 12 Nov 2024 08:09:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3917154456;
	Tue, 12 Nov 2024 08:09:30 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4D7B1A08CB
	for <linux-can@vger.kernel.org>; Tue, 12 Nov 2024 08:09:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731398970; cv=none; b=n/1ewdNfJ+fX1SSWBTXjJVU+58W081L9u6hXxT1r4zSZk4uwiYBEaxui+F+jJ4roQ+AOqQG/3h/dyY9/BL0ryMEPO4Gh+VWlc5ZxW3KxqEX8pvOQmXGQEft/MLE2a5eWE7HM1RPy2BZNQTxeX+9dcztLmtxJIzN/rFWBhexd4/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731398970; c=relaxed/simple;
	bh=45BxNtrABQY7jjMEAwk/SQrjqNXIEEUhVy0Z0YuHfwE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=e5Tx2s+OSds4w82al3ePm/45CGbugW6ihlKA/eqR7gXx4J2nR3GyrX9HUr1QeF9/3mWigvcoNJt1DSBbBUzRZIfgHEdtU3z3g7pqGkUprWcxqcLyTseZ6nF8rgaXYTcxovG+yquOIPYVYXHNxiE3Lv7tGSbA2Ya7uxRPasOaoLY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1tAlxm-0002UR-MY; Tue, 12 Nov 2024 09:09:26 +0100
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1tAlxm-000NL3-0h;
	Tue, 12 Nov 2024 09:09:26 +0100
Received: from pengutronix.de (pd9e59fec.dip0.t-ipconnect.de [217.229.159.236])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id D68E43712E1;
	Tue, 12 Nov 2024 08:09:25 +0000 (UTC)
Date: Tue, 12 Nov 2024 09:09:25 +0100
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Cc: linux-can@vger.kernel.org, Oliver Hartkopp <socketcan@hartkopp.net>, 
	Robert Nawrath <mbro1689@gmail.com>
Subject: Re: [RFC PATCH 12/14] can: netlink: add CAN XL support
Message-ID: <20241112-flashy-straight-poodle-9a796d-mkl@pengutronix.de>
References: <20241110155902.72807-16-mailhol.vincent@wanadoo.fr>
 <20241110155902.72807-28-mailhol.vincent@wanadoo.fr>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="4bhryg6q7ks5qgyu"
Content-Disposition: inline
In-Reply-To: <20241110155902.72807-28-mailhol.vincent@wanadoo.fr>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org


--4bhryg6q7ks5qgyu
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [RFC PATCH 12/14] can: netlink: add CAN XL support
MIME-Version: 1.0

On 11.11.2024 00:56:01, Vincent Mailhol wrote:
> Add the netlink interface for CAN XL.
>=20
> Signed-off-by: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
> ---
>  drivers/net/can/dev/netlink.c    | 78 +++++++++++++++++++++++++++++---
>  include/linux/can/bittiming.h    |  2 +
>  include/linux/can/dev.h          | 13 ++++--
>  include/uapi/linux/can/netlink.h |  7 +++
>  4 files changed, 90 insertions(+), 10 deletions(-)
>=20
> diff --git a/drivers/net/can/dev/netlink.c b/drivers/net/can/dev/netlink.c
> index 6c3fa5aa22cf..3c89b304c5b8 100644
> --- a/drivers/net/can/dev/netlink.c
> +++ b/drivers/net/can/dev/netlink.c
> @@ -22,6 +22,9 @@ static const struct nla_policy can_policy[IFLA_CAN_MAX =
+ 1] =3D {
>  	[IFLA_CAN_TERMINATION] =3D { .type =3D NLA_U16 },
>  	[IFLA_CAN_TDC] =3D { .type =3D NLA_NESTED },
>  	[IFLA_CAN_CTRLMODE_EXT] =3D { .type =3D NLA_NESTED },
> +	[IFLA_CAN_XL_DATA_BITTIMING] =3D { .len =3D sizeof(struct can_bittiming=
) },
> +	[IFLA_CAN_XL_DATA_BITTIMING_CONST] =3D { .len =3D sizeof(struct can_bit=
timing_const) },
> +	[IFLA_CAN_XL_TDC] =3D { .type =3D NLA_NESTED },

I haven't looked at the can_xl IP-core docs yet.

I don't want to pass "struct can_bittiming_const" via netlink to user
space. It's not sufficient to fully describe the CAN-FD controllers, as
tseg1_min cannot equally divided into prop_seg and phase_seg1.

Better make it a NLA_NESTED, as you did for the TDC.

Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--4bhryg6q7ks5qgyu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEUEC6huC2BN0pvD5fKDiiPnotvG8FAmczDTEACgkQKDiiPnot
vG9KrAf9HO8qTIEWaZKi9UitNd3Ub/GIE7BUm4aRXv8Frb4jJ5Ugfp90GYzrbbMd
gvmZMV/GqcwKLp6Sdnuuyt4KLTAm8OMwnGrt89E53O+aKkv2g9MyWAlPRji05Gk9
nKrnuyoSdYVJgf+TALMerTCjYvisDPFq6c0PxMJdqW0jTStk0cbzLTzVro4iW+rM
pxdHnxoPcJo5OGIrXM9UEeHKutto2fmNQiyKMrcAQrzry4f8EZ5sdfGiDOScIGVk
rPV6+29J+ZJ3ykFtwpxLGO8FmL5MJFucKraLw3SYVz34eOnsAV9EqMmZIMbdOTH+
ycPQo9S37baCBp5fhGbwswhEe5Nwuw==
=V9n5
-----END PGP SIGNATURE-----

--4bhryg6q7ks5qgyu--

