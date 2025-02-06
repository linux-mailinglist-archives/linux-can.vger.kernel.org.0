Return-Path: <linux-can+bounces-2733-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8281CA2A2D0
	for <lists+linux-can@lfdr.de>; Thu,  6 Feb 2025 09:00:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8A09B167D1E
	for <lists+linux-can@lfdr.de>; Thu,  6 Feb 2025 08:00:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D6DD2253EC;
	Thu,  6 Feb 2025 07:59:35 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A2742248BB
	for <linux-can@vger.kernel.org>; Thu,  6 Feb 2025 07:59:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738828775; cv=none; b=evh/2vpacbi3ykaUCrURmUoPiOS4HqUY8/vr17X8Chkt6gvLul2UBe7lZyDwwvwOTQSCTxh7r82uE8ML7HWTFl4T9IOBtlqhSHj16ZNSIXjpwcF4VSpzxGamFxogV4zSV/msBa+EMmDF4xKXuyocxqE1hesoEkRqePlEZoRspso=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738828775; c=relaxed/simple;
	bh=fWapcgVS6rlPMBu3fcxND55qT5b4e9K/qeUwoccaclA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tvFaE59JiYWMYh0k5l72evMVG7mooxaUOf7bvMV3KrjYwTT0LUPzjMyrqSD+lYy22jhOqz+Iyq/VXNZVsUoreHW+AN6IKLCdmxKnhbrcdMAGOpvCDWrEOZD/q1lEW+76c84wNW+weyKcr6vDFZjf+Bhyrh5oJZhE9zOE493x0J8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1tfwnG-0003YG-4C; Thu, 06 Feb 2025 08:59:26 +0100
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1tfwnF-003lix-2u;
	Thu, 06 Feb 2025 08:59:25 +0100
Received: from pengutronix.de (pd9e59fec.dip0.t-ipconnect.de [217.229.159.236])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 80BD13BB117;
	Thu, 06 Feb 2025 07:59:25 +0000 (UTC)
Date: Thu, 6 Feb 2025 08:59:25 +0100
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Oleksij Rempel <o.rempel@pengutronix.de>
Cc: Robin van der Gracht <robin@protonic.nl>, 
	Oliver Hartkopp <socketcan@hartkopp.net>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Jonathan Corbet <corbet@lwn.net>, kernel@pengutronix.de, 
	linux-can@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] can: j1939: Extend stack documentation with buffer
 size behavior
Message-ID: <20250206-frisky-polecat-of-research-1deaf5-mkl@pengutronix.de>
References: <20241013181715.3488980-1-o.rempel@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="axffqekd53hpsxkv"
Content-Disposition: inline
In-Reply-To: <20241013181715.3488980-1-o.rempel@pengutronix.de>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org


--axffqekd53hpsxkv
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v1] can: j1939: Extend stack documentation with buffer
 size behavior
MIME-Version: 1.0

On 13.10.2024 20:17:15, Oleksij Rempel wrote:
> Extend the J1939 stack documentation to include information about how
> buffer sizes influence stack behavior, detailing handling of simple
> sessions, TP, and ETP transfers.
>=20
> Additionally, describe various setsockopt(2) options, including their
> usage  and potential error values that can be returned by the stack.
>=20
> Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>

Removed trailing newline and added to linux-can-next.

Thanks,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--axffqekd53hpsxkv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEn/sM2K9nqF/8FWzzDHRl3/mQkZwFAmeka9oACgkQDHRl3/mQ
kZzhBQf+KCmcd274q12v31jmE5xFVL5b8suaNAS19ClMrJ3kmJyofeyVoWtZHpTm
UNZzpJLg9bvpK+AS04vePinDLNe2bN55IhjOy0AOzrkjIrgecX/GROKx8kP23KG0
//XfwhDc0cNz/ZT/GNxuiqW9cuS1jM+DKfY41vBkfnV7z7rYqJaA++Y+oOfcy7PF
1lpSV2yC21jLORMKN4oXxR90HcGZSTOZh8AtTMQVYhudv4vfap0/amrDtzsM6GAD
+SWmUNb8/UJCwWPGr9rBpAZi8Y63SU1acTyH5b7Rq2ijuocB+xuG8pKk174UwNUB
/lgYSO3ycgJT6GmVyWNXKCo/cKPpWg==
=nFYt
-----END PGP SIGNATURE-----

--axffqekd53hpsxkv--

