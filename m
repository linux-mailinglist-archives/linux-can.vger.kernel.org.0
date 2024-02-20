Return-Path: <linux-can+bounces-310-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 669FA85B3FC
	for <lists+linux-can@lfdr.de>; Tue, 20 Feb 2024 08:29:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2298628505D
	for <lists+linux-can@lfdr.de>; Tue, 20 Feb 2024 07:29:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CA0E5A4E5;
	Tue, 20 Feb 2024 07:29:14 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 323C75A4CB
	for <linux-can@vger.kernel.org>; Tue, 20 Feb 2024 07:29:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708414154; cv=none; b=nMmmXSHMfjfmMMkbD40D4DwWrkeaMrT/VPRovafdvo+5zwTm3rOphXzb+rAYFa12qbnUNxJPulcypvNBGuQ4okUxw+BBfckEwRCpzq49zFDuFAjtKwlVMTZaHGbfVEOjbEDCEPciNzaVm+R5U2DrKdg9f63LpCBgjmG/TGwIUvc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708414154; c=relaxed/simple;
	bh=IyeOKe4EYMljhTftugqUBFw3+gslq/tRAk6Y72OMvZI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WUKEf2jS0AjneI+f4VhKVqamjKZ0GUo0XlW0SYrDH/csA5jtgyLxoFuoR6BEQ+ZudIcUHz1q9h3f6zMiD3DT8/AURTJcRAd/DsT+0GaPQ/KMVEid7MAfwAqb6G8aXU323F6MIZaXp/QJsr86uOTNm4ub1D41cWJ6Xt+FKcIjJNo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1rcKYr-0006bM-7w; Tue, 20 Feb 2024 08:29:05 +0100
Received: from [2a0a:edc0:0:b01:1d::7b] (helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <mkl@pengutronix.de>)
	id 1rcKYq-001ncM-29; Tue, 20 Feb 2024 08:29:04 +0100
Received: from pengutronix.de (unknown [172.20.34.65])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id AF097292DBA;
	Tue, 20 Feb 2024 07:29:03 +0000 (UTC)
Date: Tue, 20 Feb 2024 08:29:02 +0100
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Oliver Hartkopp <socketcan@hartkopp.net>
Cc: Simon Horman <horms@kernel.org>, netdev@vger.kernel.org, 
	davem@davemloft.net, kuba@kernel.org, linux-can@vger.kernel.org, 
	kernel@pengutronix.de, Dan Carpenter <dan.carpenter@linaro.org>
Subject: Re: [PATCH net-next 22/23] can: canxl: add virtual CAN network
 identifier support
Message-ID: <20240220-kelp-footprint-2a26c121409f-mkl@pengutronix.de>
References: <20240213113437.1884372-1-mkl@pengutronix.de>
 <20240213113437.1884372-23-mkl@pengutronix.de>
 <20240219083910.GR40273@kernel.org>
 <20240219-activist-smartly-87263f328a0c-mkl@pengutronix.de>
 <2828dbd5-9bea-4b2e-9a4f-ebd0582c8f73@hartkopp.net>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="wl3ar4whl6jp2zgi"
Content-Disposition: inline
In-Reply-To: <2828dbd5-9bea-4b2e-9a4f-ebd0582c8f73@hartkopp.net>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org


--wl3ar4whl6jp2zgi
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 19.02.2024 21:15:19, Oliver Hartkopp wrote:
> the problem was an incomplete code adoption from another getsockopt()
> function CAN_RAW_FILTER. No need to reduce the scope of err here as we on=
ly
> have one sockopt function at a time.

The idea behind reducing the scope is that a future new sockopt does not
set err and think that it will be evaluated later.

Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--wl3ar4whl6jp2zgi
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEUEC6huC2BN0pvD5fKDiiPnotvG8FAmXUVLwACgkQKDiiPnot
vG9EyQf+PEpH9eVaVxBLhJF29xNXRj4OAPmWWz7ijQxxXLfuPE2n89MXwjrgJt/G
iDdndJ6VThGni1tGMlBUzO6bRk/dMhfRiUHRAu8sLfWtSWV53mN6CXKMvi9EZUEa
ScKa4V7NrpLqdQSOAZ3OGtitl2ujD1nRBceK2WWdwkjNdJhDI150uebpJv2W3BCH
3E4XPetBEvXd8x45mN22yBM1+1cTBj9EGgFTOqBGqUtN9Mxrwq+Vf0d7AL4KI6/M
2IYdVFjhL+NcibqkeaArvWVosLv/r5ETb4Pf2Le5DeHA+nfUk7d3ZgySL1kg+1Qn
WE2ga6uhELu35DVHaoTZ5oyO6b36pw==
=oq8v
-----END PGP SIGNATURE-----

--wl3ar4whl6jp2zgi--

