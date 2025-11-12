Return-Path: <linux-can+bounces-5346-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7550EC512C9
	for <lists+linux-can@lfdr.de>; Wed, 12 Nov 2025 09:49:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C324C1894438
	for <lists+linux-can@lfdr.de>; Wed, 12 Nov 2025 08:48:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D94B2D5C7A;
	Wed, 12 Nov 2025 08:47:34 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 164952EE5F4
	for <linux-can@vger.kernel.org>; Wed, 12 Nov 2025 08:47:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762937254; cv=none; b=TOpsUqjIKcSL3MKN3VqDStpzgmlyXs9qJNyJdNfSb4Hsxd7nMTW/ql20w5dSCPi4jtpqhjBSMFHpbzq5Tju+dxAZI9xyBY7Q5MC+I1yooMECmfB0+IkjlvMUyprdUtlBaJpog32jB0KFue2ysnYYFdH5UQ0DJUoWQDlu5m29QVg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762937254; c=relaxed/simple;
	bh=AWeQnti40jHnOJbmGeOlA0NmYMcbw2PDNWzz614QK/M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LwTsnvl2PMhlNiaLPlvs8WSaf+Cqf0pxuRlw3Xsc4zrvUhCJmuWSxaPHcg7pcTbOUb/FE+jfrCiZkJvgJVx1p3Gz4EOOSCyjnjnXcRMc4LWT//C+FUIY9nSGP76+lao9MdtBEURgHoOTMTG8bz4zFWB9P0h98Pl2A/eEplExY6w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1vJ6Vc-0002Je-Qv; Wed, 12 Nov 2025 09:47:20 +0100
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1vJ6Vb-0003IJ-22;
	Wed, 12 Nov 2025 09:47:19 +0100
Received: from pengutronix.de (p54b152ce.dip0.t-ipconnect.de [84.177.82.206])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 55FAC49D92A;
	Wed, 12 Nov 2025 08:47:19 +0000 (UTC)
Date: Wed, 12 Nov 2025 09:47:19 +0100
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Biju <biju.das.au@gmail.com>
Cc: Vincent Mailhol <mailhol@kernel.org>, 
	Geert Uytterhoeven <geert+renesas@glider.be>, Magnus Damm <magnus.damm@gmail.com>, 
	Biju Das <biju.das.jz@bp.renesas.com>, Tranh Ha <tranh.ha.xb@renesas.com>, 
	Duy Nguyen <duy.nguyen.rh@renesas.com>, linux-can@vger.kernel.org, linux-renesas-soc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>, 
	stable@vger.kernel.org
Subject: Re: [PATCH] can: rcar_canfd: Fix controller mode setting for RZ/G2L
 SoCs
Message-ID: <20251112-warping-ninja-jaybird-22edde-mkl@pengutronix.de>
References: <20251030120508.420377-1-biju.das.jz@bp.renesas.com>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="lxeis23kjl3hmw2g"
Content-Disposition: inline
In-Reply-To: <20251030120508.420377-1-biju.das.jz@bp.renesas.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org


--lxeis23kjl3hmw2g
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH] can: rcar_canfd: Fix controller mode setting for RZ/G2L
 SoCs
MIME-Version: 1.0

On 30.10.2025 12:05:04, Biju wrote:
> From: Biju Das <biju.das.jz@bp.renesas.com>
>
> The commit 5cff263606a1 ("can: rcar_canfd: Fix controller mode setting")
> applies to all SoCs except the RZ/G2L family of SoCs. As per RZ/G2L
> hardware manual "Figure 28.16 CAN Setting Procedure after the MCU is
> Reset" CAN mode needs to be set before channel reset. Add the
> mode_before_ch_rst variable to struct rcar_canfd_hw_info to handle
> this difference.
>
> The above commit also breaks CANFD functionality on RZ/G3E. Adapt this
> change to RZ/G3E, as well=C2=A0as it works ok by following the initialisa=
tion
> sequence of RZ/G2L.
>
> Fixes: 5cff263606a1 ("can: rcar_canfd: Fix controller mode setting")
> Cc: stable@vger.kernel.org
> Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>

Applied to linux-can.

Thanks,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--lxeis23kjl3hmw2g
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEn/sM2K9nqF/8FWzzDHRl3/mQkZwFAmkUSZIACgkQDHRl3/mQ
kZwuigf9F5PFg+qtPIWyiJ0SYay6CKVFjWfOfIo6j4qqRIYmT2K+uhZVhUaUkoYo
KfqPGwX7NZFUGA5zVghfGDI4efNmI0uWY9YOYCiI1AIQhPj9RDYzouLHhXrubTh1
dgqtnpY4lZ9NwR5diS8NoDHUHUfUz1oGCzSRJF8XZVKEsOAB99QqsgkKLuioPCB2
0av+JbP8ElykswI8Zh+iALa4/funve5dN01tpl7Bnb80D816672a8tGv1JnkDg15
rThLn7XQ8i8sqCPKwQK8d0QJTJ+W2YiSXkUUYjGsLsk+ScCckL1WQjghWgPhjfw5
psUadcWpBqHziKPpH9CZ/eKuuSVbnQ==
=4TVP
-----END PGP SIGNATURE-----

--lxeis23kjl3hmw2g--

