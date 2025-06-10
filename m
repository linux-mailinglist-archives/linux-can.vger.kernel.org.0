Return-Path: <linux-can+bounces-3782-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A8B98AD3041
	for <lists+linux-can@lfdr.de>; Tue, 10 Jun 2025 10:28:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 03B1D1722BE
	for <lists+linux-can@lfdr.de>; Tue, 10 Jun 2025 08:27:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FB8525E80A;
	Tue, 10 Jun 2025 08:27:22 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A32327FD6E
	for <linux-can@vger.kernel.org>; Tue, 10 Jun 2025 08:27:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749544042; cv=none; b=BC587SOeKKZpV0Nr8XzSjgD60sfJjzrnoGpuidxkWupjOnkcRLlkr39MWr/LdJbLENKZNsIJ52H2iF7lyfGB1iPqWRPP1tlLaDPlkhHerJGHooIP1+1Umd1J7aJsYRREh8IBDf5MMc4VuqDBmq8XKqdHc+Y2nJGslc+Y2tzUr9o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749544042; c=relaxed/simple;
	bh=aJo5MLwkMkWdEcQ8icbT8AUR1XfmV3eIZHT4cvzd/FU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=r+LddLjRWSUhSxiiUShIi6KGOT0y6y9EJafPhobLm+lWeLv3moKAaPTjaiY9BASz7Qpbqf+GpP6JRUzqUwNpTGTiEy679mbafU0I2Ubh7m2RbU+h5KFqX9yIApF3oPAE/BVE5p/pT+1M05Jm+/GN/bsGRdzMehtufrrn2wEqdYI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1uOuKA-0006NB-Tf; Tue, 10 Jun 2025 10:27:14 +0200
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1uOuKA-002k0V-1l;
	Tue, 10 Jun 2025 10:27:14 +0200
Received: from pengutronix.de (p5b1645f7.dip0.t-ipconnect.de [91.22.69.247])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id CACAB424090;
	Tue, 10 Jun 2025 08:27:07 +0000 (UTC)
Date: Tue, 10 Jun 2025 10:27:05 +0200
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Davide Caratti <dcaratti@redhat.com>
Cc: linux-can@vger.kernel.org, Oliver Hartkopp <socketcan@hartkopp.net>, 
	fstornio@redhat.com, fmaurer@redhat.com
Subject: Re: [PATCH 0/2] can: add drop reasons in the receive path
Message-ID: <20250610-careful-banana-wombat-f3038f-mkl@pengutronix.de>
References: <20250604160605.1005704-1-dcaratti@redhat.com>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="pikmvfzsov46ubfr"
Content-Disposition: inline
In-Reply-To: <20250604160605.1005704-1-dcaratti@redhat.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org


--pikmvfzsov46ubfr
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH 0/2] can: add drop reasons in the receive path
MIME-Version: 1.0

On 04.06.2025 18:06:03, Davide Caratti wrote:
> drop reasons have been recently introduced to improve debuggability
> of networking stack. This series introduces drop reasons in the RX path
> of the CAN protocol stack.

Applied to linux-can-next. The threading of these mails is broken.
Consider using "git send-email" or "b4" for future patch series.

regards,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--pikmvfzsov46ubfr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEn/sM2K9nqF/8FWzzDHRl3/mQkZwFAmhH7FYACgkQDHRl3/mQ
kZwSSwgAjPjVoxY6Ikdd80kyGjMM/FBsWgZncvNzLKMB203iWfSpy7UhCwyZL//A
f5xHm3GydBHpxEvks9KTvKZVMIp3MMceoF7gLSxJSMJWijlUz2W0CgXFVHYzFZiH
iLk2YS9swdzn+Yhd6pyowFB5EJnnVMchmTV2Qi9NHV7rjcy3fRhAKVvI7g/KJV/j
S4v6J1wYBdvI69pQ21DTfYRBeY6NBPnY5PiDwEbrPSSOkd9Q3LEookPByfImSdXs
lxSm3yF/V+64WR9jxFCmmQPTMg0Hr8CEC9CbzyJgqsVbwN95CiTSfG6cJzba7v0h
u2/5vRg9okzaHoeRse7K4H3pNd+Pdw==
=V4Xp
-----END PGP SIGNATURE-----

--pikmvfzsov46ubfr--

