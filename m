Return-Path: <linux-can+bounces-827-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 37817911ED2
	for <lists+linux-can@lfdr.de>; Fri, 21 Jun 2024 10:31:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E12661F263C6
	for <lists+linux-can@lfdr.de>; Fri, 21 Jun 2024 08:31:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 761B215A49F;
	Fri, 21 Jun 2024 08:31:43 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15441168C3F
	for <linux-can@vger.kernel.org>; Fri, 21 Jun 2024 08:31:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718958703; cv=none; b=Wm8SiB+YJhGNLyxcqpsdGrbuA6ihrwD1Ip5UEWC8dE9nv8Q1Twx76lZDSj5W6mN40UffQMqzDMLuvBKit6ekxd5XdejEt9T8sfw8Gc+T6SB+9AUEzPeWybzzCE1BrLEni0Y47TwdGEyR9HIdU9/MacYod+b+FhrAKi00gMlXT+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718958703; c=relaxed/simple;
	bh=UHdt1FlY8b4HTH5zu2vTHEsAyY9+Z0MCAD1z2raHM+4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lDIj6Zzyo+DBkua0rDlwLLukmg/UYypqOo/SQmPWlQWAYmp6N3r6noW+YC+4wB4W+h8/pt2mV4lODn/gN5e1VyDkTY/zEpjjld8bz9blHofnSvtblUlJbK20I92Y0uhKB0WitdXiTqxH8nw/ypucjxbQ51l8607QWaFGWi1fygI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1sKZgJ-0000Ln-HA; Fri, 21 Jun 2024 10:31:39 +0200
Received: from [2a0a:edc0:0:b01:1d::7b] (helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <mkl@pengutronix.de>)
	id 1sKZgI-003tos-TN; Fri, 21 Jun 2024 10:31:38 +0200
Received: from pengutronix.de (p5de45302.dip0.t-ipconnect.de [93.228.83.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id A04992EE577;
	Fri, 21 Jun 2024 08:31:38 +0000 (UTC)
Date: Fri, 21 Jun 2024 10:31:38 +0200
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Martin Jocic <martin.jocic@kvaser.com>
Cc: linux-can@vger.kernel.org, mailhol.vincent@wanadoo.fr, 
	extja@kvaser.com
Subject: Re: [PATCH 0/7] can: kvaser_pciefd: Minor improvements and cleanups
Message-ID: <20240621-dynamic-goldfish-of-fantasy-bbbdda-mkl@pengutronix.de>
References: <20240614151524.2718287-1-martin.jocic@kvaser.com>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="p7iqxkkjiqjnv5t3"
Content-Disposition: inline
In-Reply-To: <20240614151524.2718287-1-martin.jocic@kvaser.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org


--p7iqxkkjiqjnv5t3
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 14.06.2024 17:15:17, Martin Jocic wrote:
> Minor improvements and cleanups for the kvaser_pciefd driver
> in preparation for an upcoming MSI interrupts patch series.

Applied to linux-can-next.

Thanks,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--p7iqxkkjiqjnv5t3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEUEC6huC2BN0pvD5fKDiiPnotvG8FAmZ1OmgACgkQKDiiPnot
vG9UrQf8C7+dsqtlLWTNfYGhetlU0a9uAESpUtBYlPBGgXiBbU0I46pd6B8ynn4w
freDQtmNbMXDVVDKe/GPmcsZ5hpF17PmVVvovgjhKu+xq0OasFlzGebNHTPrZ8zn
kT3cXJi02atE2JHoMHn0Va8PowKCVr+ZRLeWLquKwAqMNlKTBJuEyOE1RzpGK8oJ
6mvDlqt6vx9f50bxEvGj01xYG5CWfZ4OVqIVGSjNIr7g1PXMt2wJ44zcWCy5vSIK
FYpmX6VxkpGU1wkL9O5bmcmxtECpWiKkP8ZV8ZXy3Zsidd3oZCQkloP9D9kZxkVE
f5KtKsIuUx/Htw4mQzLhgSM8U52pdQ==
=SRhB
-----END PGP SIGNATURE-----

--p7iqxkkjiqjnv5t3--

