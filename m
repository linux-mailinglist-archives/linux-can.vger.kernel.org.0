Return-Path: <linux-can+bounces-5758-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 21233C904DD
	for <lists+linux-can@lfdr.de>; Thu, 27 Nov 2025 23:43:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A48EF3A8746
	for <lists+linux-can@lfdr.de>; Thu, 27 Nov 2025 22:43:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 514433254B2;
	Thu, 27 Nov 2025 22:43:40 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 278802C158D
	for <linux-can@vger.kernel.org>; Thu, 27 Nov 2025 22:43:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764283420; cv=none; b=gFLRV0hAKpEWb01Kc6BNXKElkFQFDJIYDuyFazT3nt/JrEYqPQaugqnF+lWEfJZwTUZyZ0DoTOD9VYJ1QCLnfZg7HWb0Bv6q4VcBVdbPboAUnUoo1gXFqsKQ0cIraCgOL3pQ9tZQnqz/6XfOcp28y384njSjww8BdAGXIW4Bd5c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764283420; c=relaxed/simple;
	bh=PjxhVKOUp8R55MRbCsak0DY4y/bys1LtPrrpAtI4SEA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WnGcYsTQ+V/TtEmIT7L+pMdtXY+LyZPU8D8kJ3jpxHMMk9EdW7KWJK6x3Q9ZV2HR4r/ATwJdgcGYRYpQi8JFRty3Ib01bkk+BZIhXvUIvA3O2hdqtLi7zVmLJyetpexrMhjIPoF6UeayALXL1beM7zbEDWHEOpvdgl5UuvFnsLI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1vOki3-0007mp-K9; Thu, 27 Nov 2025 23:43:31 +0100
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1vOki3-002rKv-03;
	Thu, 27 Nov 2025 23:43:31 +0100
Received: from pengutronix.de (unknown [IPv6:2a03:2260:2009::])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 69F334A9E0D;
	Thu, 27 Nov 2025 22:43:30 +0000 (UTC)
Date: Thu, 27 Nov 2025 23:43:29 +0100
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Oliver Hartkopp <socketcan@hartkopp.net>
Cc: linux-can@vger.kernel.org, netdev@vger.kernel.org, davem@davemloft.net, 
	kuba@kernel.org, kernel@pengutronix.de, Vincent Mailhol <mailhol@kernel.org>
Subject: Re: [net-next] can: raw: fix build without CONFIG_CAN_DEV
Message-ID: <20251127-hypnotic-platinum-snake-041707-mkl@pengutronix.de>
References: <20251127210710.25800-1-socketcan@hartkopp.net>
 <20251127-inquisitive-vegan-boobook-abac0e-mkl@pengutronix.de>
 <f3393f50-02a8-4076-9129-6e8a1b8356f2@hartkopp.net>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="dwxvbnk54ez3jwoq"
Content-Disposition: inline
In-Reply-To: <f3393f50-02a8-4076-9129-6e8a1b8356f2@hartkopp.net>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org


--dwxvbnk54ez3jwoq
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [net-next] can: raw: fix build without CONFIG_CAN_DEV
MIME-Version: 1.0

On 27.11.2025 23:35:48, Oliver Hartkopp wrote:
> > That's not sufficient. We can build the CAN_DEV as a module but compile
> > CAN_RAW into the kernel.

> Oh, yes that's better.

It's nicer, but it will not work if you build CAN_RAW into the kernel
and CAN_DEV as a module....Let me think of the right kconfig magic to
workaround this...

Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--dwxvbnk54ez3jwoq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEn/sM2K9nqF/8FWzzDHRl3/mQkZwFAmko1A0ACgkQDHRl3/mQ
kZzZKQgAj34ZnwkWHuOxB0XvDIfP6S8Mn1sqJ+Kw+f+fZINI2jtMjri09qrC+KXH
JyZ66Edw9SpB9l93Ga9le+xsIUJpysYKusEZdW3SQTdJ2Ss8YYH1ESGwuxeShWLe
hhGwo3/Spk4NOZsYbBzHk1TpBBFOLN1AfTzxZ8DW6elaQkBcqOO8W/vc9s6g2Ff5
LSbFNfozz9+r2zXoDIuBbkDE/NhJwFdkG2i5c7a2wA2byG/CYXYUTnnTnvakoLaw
/xWPItrtkyq/xeji4WuGVSqpI4Hhc1Wynt3BlDjS8AzW0HQSmLcajGS4+CzBov/J
8CCKroFpxFf2iYJW4+NdJZF327zvyw==
=oY23
-----END PGP SIGNATURE-----

--dwxvbnk54ez3jwoq--

