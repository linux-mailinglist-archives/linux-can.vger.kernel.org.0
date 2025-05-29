Return-Path: <linux-can+bounces-3732-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EDE0AC7915
	for <lists+linux-can@lfdr.de>; Thu, 29 May 2025 08:38:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AB6A07B002F
	for <lists+linux-can@lfdr.de>; Thu, 29 May 2025 06:37:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E51B2561B6;
	Thu, 29 May 2025 06:36:58 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B0682561A3
	for <linux-can@vger.kernel.org>; Thu, 29 May 2025 06:36:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748500618; cv=none; b=Cr41HolylCrb3JDSB4ZoEZpCo9cZsXKEpfkCqeDLj6Qs8nt7lQW5aoUxfNmS+WhShuWPLrJoOcPD4OIyKPJ4oaiZo4c2liOO/vSyb7W8CFLh420GSlzQbfAoz4BvLv8FAKe3tlCOqlfJfnU6z/tUd/vme5ORAe/Wk/Am1w3gPGQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748500618; c=relaxed/simple;
	bh=B3JaLtFtqu40LGnOcKtzZBziOjGYImFrUGlkaaAIyRo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tRas0MqAOIvwVz1clU6wPmuvMR5Xxfkda3iyIkw288GgNiWs7apH64A37HzwPtlQVjKuYI3oI8X4CGQUfrT3Q+cxibrDyo+pIhdnoZKfjGvkV2o8OjVPqR/66pwJ8eQuoYZY7ZYXlOtTZmWfR5a39Tl5/dh93nw9TKonTDDUEa4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1uKWse-00053S-PV; Thu, 29 May 2025 08:36:44 +0200
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1uKWsd-000iG1-35;
	Thu, 29 May 2025 08:36:43 +0200
Received: from pengutronix.de (unknown [IPv6:2a01:4f8:1c1c:29e9:22:41ff:fe00:1400])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 2F11A41BE59;
	Thu, 29 May 2025 06:36:43 +0000 (UTC)
Date: Thu, 29 May 2025 08:36:41 +0200
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: kernel test robot <lkp@intel.com>
Cc: Oliver Hartkopp <socketcan@hartkopp.net>, llvm@lists.linux.dev, 
	oe-kbuild-all@lists.linux.dev, linux-can@vger.kernel.org
Subject: Re: [mkl-can-next:b4/can-xl 6/11]
 drivers/net/can/xilinx_can.c:518:7: error: call to undeclared function
 'can_tdc_is_enabled'; ISO C99 and later do not support implicit function
 declarations
Message-ID: <20250529-tactful-placid-bullfinch-e5e792-mkl@pengutronix.de>
References: <202505291443.O21tBseZ-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="6sjjnrsshstua36b"
Content-Disposition: inline
In-Reply-To: <202505291443.O21tBseZ-lkp@intel.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org


--6sjjnrsshstua36b
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [mkl-can-next:b4/can-xl 6/11]
 drivers/net/can/xilinx_can.c:518:7: error: call to undeclared function
 'can_tdc_is_enabled'; ISO C99 and later do not support implicit function
 declarations
MIME-Version: 1.0

On 29.05.2025 14:15:06, kernel test robot wrote:
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/mkl/linux-can-nex=
t.git b4/can-xl
> head:   7861c36608b1d1f26b010a9c465c048137d9d156
> commit: 48f48b8238cc98e533eaeda03271a101ccdac359 [6/11] can: netlink: add=
 CAN XL support
> config: hexagon-allmodconfig (https://download.01.org/0day-ci/archive/202=
50529/202505291443.O21tBseZ-lkp@intel.com/config)
> compiler: clang version 17.0.6 (https://github.com/llvm/llvm-project 6009=
708b4367171ccdbf4b5905cb6a803753fe18)
> reproduce (this is a W=3D1 build): (https://download.01.org/0day-ci/archi=
ve/20250529/202505291443.O21tBseZ-lkp@intel.com/reproduce)
>=20
> If you fix the issue in a separate patch/commit (i.e. not just a new vers=
ion of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202505291443.O21tBseZ-lkp=
@intel.com/
>=20
> All errors (new ones prefixed by >>):
>=20
> >> drivers/net/can/xilinx_can.c:518:7: error: call to undeclared function=
 'can_tdc_is_enabled'; ISO C99 and later do not support implicit function d=
eclarations [-Wimplicit-function-declaration]
>      518 |                 if (can_tdc_is_enabled(&priv->can)) {
>          |                     ^

Good bot! Fixed.

Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--6sjjnrsshstua36b
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEn/sM2K9nqF/8FWzzDHRl3/mQkZwFAmg4AHYACgkQDHRl3/mQ
kZw+WggAlQUVs6jJjVer7DADb/otS6dO2Z6g15x+532y0FySPB4Lczrp8gcjkAYD
Db8A58d7loL0PDqncIF2gXk/+biJ1su+fOrloqJ7XdlbwTsXSfZwwmzEULzaN45K
yxNyqT9vRrTfXAZswfDCGJMUd3aGOCKLq24m0MYv80hwbgdWWXWPmouPzd95AuT/
c5x2VbnvkNR7AAv7R2hBLK4Gto/NXBWGDHrlM+pQeALmKi6GPuIC8Pnv+g3gyViT
tN0fN9hTD7pxSZKMnCQoxeAUbL4dSQK+Sc2sUkski27pvQ9ua5M30QMUORmAdf50
z9pSdmTDWuSfrIecZfYaUTEiIC6Qbw==
=3WNM
-----END PGP SIGNATURE-----

--6sjjnrsshstua36b--

