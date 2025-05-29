Return-Path: <linux-can+bounces-3733-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 81439AC7942
	for <lists+linux-can@lfdr.de>; Thu, 29 May 2025 08:57:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B68289E4927
	for <lists+linux-can@lfdr.de>; Thu, 29 May 2025 06:57:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 046C72550BB;
	Thu, 29 May 2025 06:57:47 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8C811891A9
	for <linux-can@vger.kernel.org>; Thu, 29 May 2025 06:57:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748501866; cv=none; b=MqG5lK8uXlW9kEDJiZ1sXKA1wZtAv3ijOF68RRMBIxnzKJTnJfK3WGO3GA1kPoiIQ3UryZ+zZ11f/9RZ8YGUwaT0OPLEypKwYvpumNa+yL1VZkL9Wa0If7jFanqXyM+oCaS8o7jZ8/IBlA5r3oJR5mJhi7k7aa+yEABwTY6s7ZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748501866; c=relaxed/simple;
	bh=TRwVjk6fccBpF0DSja2oP4ar6Pi8WSlGyvjXCD+dioo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=H+DcEP2LqhY+07ui33HZZs2bga/f2arVGawSrInCpuhLahmdU8PN6xhQHhfr0vFzeQ86ej+NiLRJMgk2m93wTduK6rU+vXeUK5h73PMNP1MUb6lfK8svn/3vihZakvHcqHJmyW0lMd0Hlsfu1FVPybWh60hIjIFu8WDaQY118fs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1uKXCw-0003LP-Fw; Thu, 29 May 2025 08:57:42 +0200
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1uKXCw-000iHY-0j;
	Thu, 29 May 2025 08:57:42 +0200
Received: from pengutronix.de (unknown [IPv6:2a01:4f8:1c1c:29e9:22:41ff:fe00:1400])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id AB50641BE8B;
	Thu, 29 May 2025 06:57:41 +0000 (UTC)
Date: Thu, 29 May 2025 08:57:03 +0200
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Oliver Hartkopp <socketcan@hartkopp.net>
Cc: linux-can@vger.kernel.org
Subject: Re: [PATCH 06/11] can: netlink: add CAN XL support
Message-ID: <20250529-unselfish-crystal-lorikeet-31c445-mkl@pengutronix.de>
References: <20250527195625.65252-1-socketcan@hartkopp.net>
 <20250527195625.65252-6-socketcan@hartkopp.net>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="z5id2w7k3va4mhaj"
Content-Disposition: inline
In-Reply-To: <20250527195625.65252-6-socketcan@hartkopp.net>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org


--z5id2w7k3va4mhaj
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH 06/11] can: netlink: add CAN XL support
MIME-Version: 1.0

On 27.05.2025 21:56:20, Oliver Hartkopp wrote:
>  drivers/net/can/xilinx_can.c     |  12 +-

I've removed the changes in xlinix_can.c from my tree b4/can-xl, they
broke compilation. See https://lore.kernel.org/all/202505291443.O21tBseZ-lk=
p@intel.com/

regards,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--z5id2w7k3va4mhaj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEn/sM2K9nqF/8FWzzDHRl3/mQkZwFAmg4BTsACgkQDHRl3/mQ
kZwlqwf8DWCDwLtV9liK4z9ntePz3szAcd6Xlz3Lh2JdQFtbi298yKpnXz0zH5Av
qPXOpVtrVfICMnEfndovBC7sybFf1vCvjKqLXI0dw9K4eccEQgktBvLDwp3AU0P1
RQgU2+UIZtmEBplak4S6GusF+Ro9Y350XjOyEdHBLWMoHsRDYk1IWASOpHS2vqlL
w4vvfdfLjfI/QjFprBbutmH330Fva9K/a5v2ArXjOxW7tS/hr5l9ZkbE3W0m0ui3
xACZjp2XQ3g69vZl18lvYSlstUb/BvOFslRgK52SZmtpHsw5pf/X1ivKMnJmjWCu
Gk44ymcQ2fqwW+tDS3mSyVfGuQ30Yg==
=F8f+
-----END PGP SIGNATURE-----

--z5id2w7k3va4mhaj--

