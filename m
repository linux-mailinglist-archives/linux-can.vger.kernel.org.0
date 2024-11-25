Return-Path: <linux-can+bounces-2215-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A1AD69D8966
	for <lists+linux-can@lfdr.de>; Mon, 25 Nov 2024 16:32:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 16A61167E2C
	for <lists+linux-can@lfdr.de>; Mon, 25 Nov 2024 15:32:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 953ADF507;
	Mon, 25 Nov 2024 15:32:23 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBCF614E2E8
	for <linux-can@vger.kernel.org>; Mon, 25 Nov 2024 15:32:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732548743; cv=none; b=uUuwyu5ObnDQOOKFQUNhBBwmj/sNUWpJPbN8RumYaYUl1vr/Yg7PNscAbU31pOsUAKMC61TmlOdwoTVOU3VGBIvdF1JSBnCF4Xw9FEpdQz4K5JrTuPV5XuAHm22lSSmNpj0HsWTLlXBPG/GfmLDzy6xQ8F9opp1C1fSX4xMVUJk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732548743; c=relaxed/simple;
	bh=qZN3tTINsuSh+bUMXLwiRKUoSwsgNquQ1nz8dUkwBu0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gELxwAyS6Wo7ROHUIX3sHcgiaq+d3IoXnCflok/W1Hr3ktQE15m8d1CnH8oBIDuxugqfcknPs03EmcTDWnMrBEIdHyBISkpiszmXqeIfisvgRO7nVJrUbxkxKtk7Gmp5LZ2aal9LM6qWEhxqjwtfJ4joQQ9IgJCaQS9jvVZm4jU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1tFb4S-0003eB-K3; Mon, 25 Nov 2024 16:32:16 +0100
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1tFb4R-0006RB-1y;
	Mon, 25 Nov 2024 16:32:16 +0100
Received: from pengutronix.de (pd9e59fec.dip0.t-ipconnect.de [217.229.159.236])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 0CE0B37CECC;
	Mon, 25 Nov 2024 15:32:16 +0000 (UTC)
Date: Mon, 25 Nov 2024 16:32:15 +0100
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Sasha Levin <sashal@kernel.org>
Cc: stable@vger.kernel.org, linux-can@vger.kernel.org, 
	kernel@pengutronix.de
Subject: Re: [PATCH RFC can] can: mcp251xfd: mcp251xfd_get_tef_len(): fix
 length calculation
Message-ID: <20241125-fantastic-tamarin-of-joy-0435c8-mkl@pengutronix.de>
References: <20241125-mcp251xfd-fix-length-calculation-v1-1-974445b5f893@pengutronix.de>
 <20241125100249-1c012e0994360c86@stable.kernel.org>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="wb2nemun5gkvnnaw"
Content-Disposition: inline
In-Reply-To: <20241125100249-1c012e0994360c86@stable.kernel.org>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org


--wb2nemun5gkvnnaw
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH RFC can] can: mcp251xfd: mcp251xfd_get_tef_len(): fix
 length calculation
MIME-Version: 1.0

Hello Sasha,

this patch is still in the RFC phase and should not have been sent to
stable yet...

On 25.11.2024 10:20:47, Sasha Levin wrote:
> [ Sasha's backport helper bot ]

Good bot!

> Found matching upstream commit: 3c1c18551e6ac1b988d0a05c5650e3f6c95a1b8a
>=20
>=20
> Status in newer kernel trees:
> 6.12.y | Present (exact SHA1)
>=20
> Note: The patch differs from the upstream commit:

=2E..and it should get a better patch subject. It currently has the same
subject as the previous patch, which fixes most issues, but not all.

sorry for the noise,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--wb2nemun5gkvnnaw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEUEC6huC2BN0pvD5fKDiiPnotvG8FAmdEmHwACgkQKDiiPnot
vG+LxAf/c+Ua+BsJCriX4ukSQuLwx5c4V+MaW+9xxYM2HeZ/qTtxqaTw1EQxdAa6
U9QNuqjJE4usrmnioMIQz86i3Yeqs6Qx7KGPzHntMWx4fOeP60tOeS6hl6BAzeXJ
V8xdXJy/itQgiqEQ74jYXeuNKx5UPQqybx5NLjvW0fjfiuUHqM+DcUG8T1AXpCfl
eqtI67uoLKrGtFGeYU7zJsRpBFctYIQC2YcGw6Opu2SiTtSb5RaY9SH7aImmwnDA
R6GUGjQ/wvs0Pbgwd9Kv1w3aYf5Fwn0YrGqJyD/hI+68kXavvtdIStO9xiw3Hey5
q8Izh0tvZQaxqudnx8SxZqE7ZRNT5w==
=vAG2
-----END PGP SIGNATURE-----

--wb2nemun5gkvnnaw--

