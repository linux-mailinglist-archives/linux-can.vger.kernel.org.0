Return-Path: <linux-can+bounces-1983-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 140419C52DD
	for <lists+linux-can@lfdr.de>; Tue, 12 Nov 2024 11:13:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D7373282F1E
	for <lists+linux-can@lfdr.de>; Tue, 12 Nov 2024 10:13:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7D921A256C;
	Tue, 12 Nov 2024 10:12:45 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97F0F212EE3
	for <linux-can@vger.kernel.org>; Tue, 12 Nov 2024 10:12:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731406365; cv=none; b=K2AzLQ3+ZI+A5nr7g3l99KMv3buuqhBEkSH5cJqQMKb7dD41Vb0RgX8SgKTvzuHWJ1KyxYPaRc7taPf8NDSWPX7rmG2Wo+l0o9XrXN10p1ko9b5JgFLblMJGudGbyjmDqOoIrV6PnrD4kBX0t5+bfC8S74iJfn/C88G/ED6MkuM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731406365; c=relaxed/simple;
	bh=7l57nZiICvyyIX4qMkqdKWUMD5fO0qhwgdzzu+TScKw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=spMSy1w1nX+3OehegofxTCCRuxaNYPhwjxBDKzlhLX/91HVIIngb//fKJLWMQK0o8WppDsbvhhicJHVHxCvzL9sSth7cMtLejpfXi6RePNTFKyXz61AobRTyhUhl8HzS8J8q7wXuC61HF9IEcte+qjJreqtffW/9eLVJFCNRON4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1tAnt0-0002XR-N9; Tue, 12 Nov 2024 11:12:38 +0100
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1tAnt0-000OUD-0a;
	Tue, 12 Nov 2024 11:12:38 +0100
Received: from pengutronix.de (pd9e59fec.dip0.t-ipconnect.de [217.229.159.236])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id D8C9B371707;
	Tue, 12 Nov 2024 10:12:37 +0000 (UTC)
Date: Tue, 12 Nov 2024 11:12:37 +0100
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Cc: linux-can@vger.kernel.org, Oliver Hartkopp <socketcan@hartkopp.net>, 
	Robert Nawrath <mbro1689@gmail.com>
Subject: Re: [RFC PATCH 00/14] can: netlink: add CAN XL
Message-ID: <20241112-shiny-vole-of-charisma-bf3ac4-mkl@pengutronix.de>
References: <20241110155902.72807-16-mailhol.vincent@wanadoo.fr>
 <20241112-glittering-khaki-uakari-8e15cb-mkl@pengutronix.de>
 <CAMZ6RqJVgsJ0EpXs-seO4MNMVADM17Pf0KNdZ7QYGgJK_oa1aw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="5fgi37nz2fo56uhp"
Content-Disposition: inline
In-Reply-To: <CAMZ6RqJVgsJ0EpXs-seO4MNMVADM17Pf0KNdZ7QYGgJK_oa1aw@mail.gmail.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org


--5fgi37nz2fo56uhp
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [RFC PATCH 00/14] can: netlink: add CAN XL
MIME-Version: 1.0

On 12.11.2024 18:24:55, Vincent Mailhol wrote:
> > What's the base commit of this series? It doesn't apply to
> > net-next/main. For a series this big, try using 'b4', it also
> > automatically sends the base commit.
>=20
> It is linux-can-next/main.

Ohh, apparently I forgot to update it after the last PR was merged. I've
done that now.

> I will rebase at least the first patch and maybe some of the trivial
> renaming onto net-next/main before the merge window opens. This way,
> we will not have to worry about these anymore. After this, the other
> patches should apply smoothly.

regards,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--5fgi37nz2fo56uhp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEUEC6huC2BN0pvD5fKDiiPnotvG8FAmczKhIACgkQKDiiPnot
vG/zsQf/ejB4nUFdrAKdn8LEsk8OlbDwlLM8SKRMO+vi/K5z2HreM/2yMX2OVTGh
rffHOkuOoBT1VUxZ1LXLYYHgOdrlAafgP59i87v5vI0WqNYs8qL2yR9Ytw9CU73u
0U5W0R31IctBuwNBCcXDvR3/Z4f0lCpuZwDUmOLCGkWurvaCI5fq/PeZBeFwsui0
zIt2yZX7vPhu6L5fxo1QZ1oaCebsACZA5V5/ttBNZ3OMARRnXufwuuMckv+SFNvp
qnZqSPjmGD7gFdOw07+G97uuCu8oCRt9EC+7T896SZS5WKhCO/Cdyw5TDIgyyxul
W6qKheLQlzAPfNnuJQE84MDAmLt67g==
=PU3Z
-----END PGP SIGNATURE-----

--5fgi37nz2fo56uhp--

