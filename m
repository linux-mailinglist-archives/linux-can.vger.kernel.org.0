Return-Path: <linux-can+bounces-1969-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 14BD19C4F48
	for <lists+linux-can@lfdr.de>; Tue, 12 Nov 2024 08:19:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2AF91B207F5
	for <lists+linux-can@lfdr.de>; Tue, 12 Nov 2024 07:19:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D0D920A5E6;
	Tue, 12 Nov 2024 07:19:08 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 258A2207A14
	for <linux-can@vger.kernel.org>; Tue, 12 Nov 2024 07:19:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731395947; cv=none; b=AWiTFVIv7DuHfC+incmEddMnbX4wIL9deGQJewEKlS3H4JFM4pCS3WlK25KkwfTiZTyOy54eROwO0Q4X6P4J79UhQdZUWUrVLdM2a1WJTai0BTvkbue2OIXQGJF6k0GoyP/DmC3vKe5OfXU+TgPQX+/helTJuu7yMHjGN4OTaIM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731395947; c=relaxed/simple;
	bh=76xbpcZxfKnQKxcIbxF4rUKygZAb+/RF0H6O+QjZFrY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cTRbmrhKylLlnmye79HDUgL3tkbi3YCYMqG3Be5fcFc6oZQ83m8T4M6TsYYAIKICQBhffBDZ1EvYfr1vc/oE+rsSGaCKDVmlW6dKfTPdgT3FwkrtEh69KhDAZMKHcA3h0DRnaOy6mLG8yD7VilT9msWDwi4h+GITxL3pP2j2Jv8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1tAlAl-00029k-RZ; Tue, 12 Nov 2024 08:18:47 +0100
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1tAlAk-000N82-10;
	Tue, 12 Nov 2024 08:18:46 +0100
Received: from pengutronix.de (pd9e59fec.dip0.t-ipconnect.de [217.229.159.236])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 2C92437111E;
	Tue, 12 Nov 2024 07:16:04 +0000 (UTC)
Date: Tue, 12 Nov 2024 08:16:02 +0100
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Sean Nyekjaer <sean@geanix.com>
Cc: Jakub Kicinski <kuba@kernel.org>, 
	Vincent Mailhol <mailhol.vincent@wanadoo.fr>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, linux-can@vger.kernel.org, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v2 0/2] can: tcan4x5x: add option for selecting nWKRQ
 voltage
Message-ID: <20241112-hulking-smiling-pug-c6fd4d-mkl@pengutronix.de>
References: <20241111-tcan-wkrqv-v2-0-9763519b5252@geanix.com>
 <20241111101011.30e04701@kernel.org>
 <fatpdmg5k2vlwzr3nhz47esxv7nokzdebd7ziieic55o5opzt6@axccyqm6rjts>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="2dmhaauk3amznaiq"
Content-Disposition: inline
In-Reply-To: <fatpdmg5k2vlwzr3nhz47esxv7nokzdebd7ziieic55o5opzt6@axccyqm6rjts>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org


--2dmhaauk3amznaiq
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v2 0/2] can: tcan4x5x: add option for selecting nWKRQ
 voltage
MIME-Version: 1.0

On 12.11.2024 07:39:12, Sean Nyekjaer wrote:
> On Mon, Nov 11, 2024 at 10:10:11AM +0100, Jakub Kicinski wrote:
> > On Mon, 11 Nov 2024 09:54:48 +0100 Sean Nyekjaer wrote:
> > > This series adds support for setting the nWKRQ voltage.
> >=20
> > There is no need to CC netdev@ on pure drivers/net/can changes.
> > Since these changes are not tagged in any way I have to manually
> > go and drop all of them from our patchwork.

Does the prefix "can-next" help, i.e.:

| [PATCH can-next v2 0/2]

which can be configured via:

| b4 prep --set-prefixes "can-next"

> Oh sorry for that.
> I'm using b4's --auto-to-cc feature, any way to fix that?

You can manually trim the list of Cc: using:

| b4 prep --edit-cover

regards,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--2dmhaauk3amznaiq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEUEC6huC2BN0pvD5fKDiiPnotvG8FAmczAK8ACgkQKDiiPnot
vG9RuQf+Nj+pyf7e2gKIkxeZr+ao11kZrMz4UOp00qlZNwshVskI6oUB8/t0cDxD
qJO7Rfs1u4FqzvVsrB7yvtJZCxFNQrgIiUwEGJAP1Kp1/+/JKBoFkWVlvdCY1Olg
3Tden0OB9T5P99cBQ4aJMQjma/TRuAnC0RNhURVGhDGqwlr7SPorfRXH0G4s7vni
lFqRQ9CLH4pz5r2RbnVNFC0JQcyqZZAXr9j+r4U9RMg9BI80ATaAXK6aHJUP0nES
QjM/aXXdI6OEQII9i+LobAqUlGiCoyAhTcLiClOwhl2bWst5TMe5Ntu1x5qpGNQS
jYpaZnAnmBDkTVlYJw+kzDpVKcL0+w==
=Y/tF
-----END PGP SIGNATURE-----

--2dmhaauk3amznaiq--

