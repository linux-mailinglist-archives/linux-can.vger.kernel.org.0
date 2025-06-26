Return-Path: <linux-can+bounces-3908-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 370FDAEA23C
	for <lists+linux-can@lfdr.de>; Thu, 26 Jun 2025 17:17:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1833E500273
	for <lists+linux-can@lfdr.de>; Thu, 26 Jun 2025 15:09:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EC7F2ECD0B;
	Thu, 26 Jun 2025 15:06:19 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2D2D2ECD16
	for <linux-can@vger.kernel.org>; Thu, 26 Jun 2025 15:06:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750950379; cv=none; b=G7GfUh1Ae+iBHvxF/bJ/IwdtJ/9knSjLeNxWYOirVK6RbpeLX7IIGzWtwvT92BFWOD117L6C/EZwAELPE6HtDObsXn/CjPHH6ALo0KK9UJLWmVDvnWYJ8ebNvcqvl/dkSHZVPbE3FadbOCyltomyqfEYYJFQlsNPWFeCNJecrd8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750950379; c=relaxed/simple;
	bh=GjyxDuLK1zIIyCnBbyEnronQ6F6eitBNZR17OVA4BrA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GdiSp6FOZYJuoGh7GbAqD5EZSwoKz5n8SKUalpxt6cnwqTnRz/VwC0kEZ+fLRlf/dYNZqvEl2/4JnK2kuMprOgUfpJiSaavLmnx23dge7RO5iXTU/fYiryo9Zq+hjeYNpRlktFeqdi1vzxSBlTqqRQlGlBNkUqfpc2dcVox+OSw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1uUoAz-0006sQ-3n; Thu, 26 Jun 2025 17:06:09 +0200
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1uUoAx-005T6F-1f;
	Thu, 26 Jun 2025 17:06:07 +0200
Received: from pengutronix.de (p5b1645f7.dip0.t-ipconnect.de [91.22.69.247])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 24007431329;
	Thu, 26 Jun 2025 15:06:07 +0000 (UTC)
Date: Thu, 26 Jun 2025 17:06:06 +0200
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Markus Elfring <Markus.Elfring@web.de>
Cc: linux-can@vger.kernel.org, 
	Vincent Mailhol <mailhol.vincent@wanadoo.fr>, LKML <linux-kernel@vger.kernel.org>, 
	kernel-janitors@vger.kernel.org, Chen Ni <nichen@iscas.ac.cn>
Subject: Re: [PATCH v2] can: ucan: Use two USB endpoint API functions rather
 than duplicating their implementations
Message-ID: <20250626-opalescent-tireless-locust-564d48-mkl@pengutronix.de>
References: <bf5442d1-34e0-495f-8a56-4e47f53ca4ad@wanadoo.fr>
 <a7a00125-b393-4283-a7dc-6c80ced8e7e6@web.de>
 <c96a5d2c-0ee1-4e3e-a95d-d38a8f668feb@wanadoo.fr>
 <0768a008-d4a9-41ec-bc47-1e7c63362296@web.de>
 <c04376f2-6ab7-4256-8bdc-aa6ff3ea88b4@wanadoo.fr>
 <7e6f8929-6665-45af-b01b-167a1aa80305@web.de>
 <CAMZ6Rq+PEZWzxNYDODq-Rz_Y8T_XEihyZKoY-MYo6bn5ATaGLQ@mail.gmail.com>
 <1e64bcef-33f1-4295-b91f-d4598b32b866@web.de>
 <57815326-740d-4053-8b85-c5e57d7cec90@wanadoo.fr>
 <e70a929f-a5c5-487e-9231-61b5423115db@web.de>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="edbne6u4w4n6o4ul"
Content-Disposition: inline
In-Reply-To: <e70a929f-a5c5-487e-9231-61b5423115db@web.de>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org


--edbne6u4w4n6o4ul
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v2] can: ucan: Use two USB endpoint API functions rather
 than duplicating their implementations
MIME-Version: 1.0

On 26.06.2025 16:46:32, Markus Elfring wrote:
> From: Markus Elfring <elfring@users.sourceforge.net>
> Date: Thu, 26 Jun 2025 16:34:26 +0200
>=20
> * Reuse existing functionality from usb_endpoint_is_bulk_in()
>   and usb_endpoint_is_bulk_out() instead of keeping duplicate source code.
>=20
> * Omit two comment lines which became redundant with this refactoring.
>=20
> The source code was transformed by using the Coccinelle software.
>=20
> Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>

Sorry, this patch is not Signed-off-by its sender.

Please don't use existing threads for vN+1.

Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--edbne6u4w4n6o4ul
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEn/sM2K9nqF/8FWzzDHRl3/mQkZwFAmhdYdoACgkQDHRl3/mQ
kZwCRAgAjj58DlDlSwFeLAshpJv805TpIGkS6gJB2osul46B81DwCkYLfEJ+9uXf
PU8jBvSpvcw9iol10bXfBtOkkR/LbfRPInh68LeevsF5/d3MVzAQ3cU42cvUoHjk
CC6CZJxeFeWrnB56wBPi/OJ6x6m2u7h2+5NTj3tRn3LBHOrfTkoDYTecpAQyYRnM
kUFuJL2ZljwJhh8Oa17rsijGg3c+lGu5skXi96ZqwkuALa5OmrltZsHa6Zu4IuG0
hCtgWzxFMW23pEP7hWHQQWvdiStZUhXdUyFASt/yGY9jeu+rFOpy1l8OoAn4JERv
Lr4n/rKGhM8pv0zI/Sohc1ZmDPZO7w==
=snTM
-----END PGP SIGNATURE-----

--edbne6u4w4n6o4ul--

