Return-Path: <linux-can+bounces-2459-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5010D9F76A1
	for <lists+linux-can@lfdr.de>; Thu, 19 Dec 2024 09:03:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8F06016115B
	for <lists+linux-can@lfdr.de>; Thu, 19 Dec 2024 08:03:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F1052163B8;
	Thu, 19 Dec 2024 08:03:19 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6E991B4233
	for <linux-can@vger.kernel.org>; Thu, 19 Dec 2024 08:03:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734595399; cv=none; b=MW09jhC6zCaf6WgD1B8Ua1I9XbbukQDF1AlAIobQO1vYDY4So8vGlroViUgoLLlkC/qTvR6pBCehHFg9jd3D5Gt9uf+bocIsnUXTEFRl2lNYHgZs9I8f8sekvFEvH3iFjdZWlDmYqG1GVqTs0xf0TEbVxfq8O4O3BxwLaBdEhso=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734595399; c=relaxed/simple;
	bh=wrn8ipLAM3YkV/N8d2Cjr6QdMvZIEtM/98MUZUIX0n4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VkD92Lj1ZJJNfr0omHpn8011Evq4Lvn5YOFw07R7WIPIw8xEdRSjHo4d9lGTcD1g/bFzf8ATqis/ZrC5oPRIHQmnzs8ZeDYgm/EFy4XRspSrRj6JqRu/9xOMPMTp5Y120tgzYrb0dWAajv1yicsw7mP9ahUYC7t3th4o9MS/1ak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1tOBV1-0006Nd-Rj; Thu, 19 Dec 2024 09:03:11 +0100
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1tOBV0-004AkG-00;
	Thu, 19 Dec 2024 09:03:10 +0100
Received: from pengutronix.de (pd9e59fec.dip0.t-ipconnect.de [217.229.159.236])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 759DC3920E9;
	Thu, 19 Dec 2024 08:03:10 +0000 (UTC)
Date: Thu, 19 Dec 2024 09:03:08 +0100
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, davem@davemloft.net, linux-can@vger.kernel.org, 
	kernel@pengutronix.de
Subject: Re: [PATCH net 0/2] pull-request: can 2024-12-18
Message-ID: <20241219-shiny-ermine-of-enhancement-6958eb-mkl@pengutronix.de>
References: <20241218121722.2311963-1-mkl@pengutronix.de>
 <20241218175423.20cd97b1@kernel.org>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="ln6ki3hhjam4dpoo"
Content-Disposition: inline
In-Reply-To: <20241218175423.20cd97b1@kernel.org>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org


--ln6ki3hhjam4dpoo
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH net 0/2] pull-request: can 2024-12-18
MIME-Version: 1.0

On 18.12.2024 17:54:23, Jakub Kicinski wrote:
> On Wed, 18 Dec 2024 13:10:26 +0100 Marc Kleine-Budde wrote:
> > this is a pull request of 21 patches for net/master.
>=20
> The "21" is just quantum state of 1 becoming 2? ;)

Must have been the infamous fat-finger quantum state :)

Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--ln6ki3hhjam4dpoo
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEUEC6huC2BN0pvD5fKDiiPnotvG8FAmdj0zoACgkQKDiiPnot
vG+xTwgAkqzdqHLAdVCVx+ND8OKro8WQM13G5S2Beye7dY3mSxZsDJo1DIzt11a7
5zsuORN/Br5+IDZeAdA3YnwnrHFP2ZDIWGZYRlIRPRrLlctbnb/lv4IFfcBn0tv0
usjPolntzayf1lghpQ3+5g+SKa763Hr/QbxxN2W2APp/wF97+watoU1t51tjxFv0
DNTBD89kXxiuOStp2aq7KSjS6NwhJLZxqqfloRJBJk/KoXtHNcNEYHYYMVHL0rkE
qambR9nTY+T85WDkDEMMoyCAwZTd51ILrjIxmuHUf///dnJ4RzJ6aihEMasFnMkh
+O0fcXBqxOpYvWSc1DDa0GgWRZBbUg==
=N10q
-----END PGP SIGNATURE-----

--ln6ki3hhjam4dpoo--

