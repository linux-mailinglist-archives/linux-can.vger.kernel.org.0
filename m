Return-Path: <linux-can+bounces-4176-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 79005B121C1
	for <lists+linux-can@lfdr.de>; Fri, 25 Jul 2025 18:17:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 212931CE6D88
	for <lists+linux-can@lfdr.de>; Fri, 25 Jul 2025 16:16:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27DF12EF66C;
	Fri, 25 Jul 2025 16:14:34 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7F452EF669
	for <linux-can@vger.kernel.org>; Fri, 25 Jul 2025 16:14:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753460074; cv=none; b=WWZF+E6kSwsXxtNj512buhfcM/wdi3lqybgp6PrvvB1fJBF9+3AA/Mx7ZE13oM0c00rctB6wyyIsrg6AcYo/CcejPsmbijWuK5q74WblJhB3zi0C5THsGahrOXgkIMECnX3yZp+AzQBpGcza3q6SBoFviCjfcp+9PR8Geu1BjEU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753460074; c=relaxed/simple;
	bh=46/Qyf0csSt3L+45rt8fy84xXIfo/4IWt7ugXOkO3wM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tAbPwSyiDPGqLNLYf6bBS5B6n39yHMKkX1TjJVcOgh9rh/+hADmUXd1EzBzyKy2e8/L7WSBbH5uHNUY9zQQ8UqNEadsas38F5RKYRqNpI94KcIRhJbc2zWQ1GwU14In6s2hzBqCj2ByWAnNF0T6DA5Yx59lKa+Ib6WhzNrGXwMY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1ufL41-0007ry-H8; Fri, 25 Jul 2025 18:14:29 +0200
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1ufL41-00AFgc-0m;
	Fri, 25 Jul 2025 18:14:29 +0200
Received: from pengutronix.de (p5b1645f7.dip0.t-ipconnect.de [91.22.69.247])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id DE315449988;
	Fri, 25 Jul 2025 16:14:28 +0000 (UTC)
Date: Fri, 25 Jul 2025 18:14:28 +0200
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Jimmy Assarsson <extja@kvaser.com>
Cc: linux-can@vger.kernel.org, Jimmy Assarsson <jimmyassarsson@gmail.com>, 
	Vincent Mailhol <mailhol.vincent@wanadoo.fr>, Simon Horman <horms@kernel.org>, netdev@vger.kernel.org
Subject: Re: [PATCH v3 00/11] can: kvaser_usb: Simplify identification of
 physical CAN interfaces
Message-ID: <20250725-hungry-slug-of-success-aa3086-mkl@pengutronix.de>
References: <20250725123452.41-1-extja@kvaser.com>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="lfncyt5cmnoo6b22"
Content-Disposition: inline
In-Reply-To: <20250725123452.41-1-extja@kvaser.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org


--lfncyt5cmnoo6b22
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v3 00/11] can: kvaser_usb: Simplify identification of
 physical CAN interfaces
MIME-Version: 1.0

On 25.07.2025 14:34:41, Jimmy Assarsson wrote:
> This patch series simplifies the process of identifying which network
> interface (can0..canX) corresponds to which physical CAN channel on
> Kvaser USB based CAN interfaces.
>=20
> Note that this patch series is based on [1]
> "can: kvaser_pciefd: Simplify identification of physical CAN interfaces"

Added to linux-can-next and included the my latest PR.

Have you thought about creating an entry in the MAINTAINERS file?

Thanks,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--lfncyt5cmnoo6b22
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEyBAABCgAdFiEEn/sM2K9nqF/8FWzzDHRl3/mQkZwFAmiDrWEACgkQDHRl3/mQ
kZwgiwf44i6mutHLVWWPzPbpL7bmyyeVnoHhd/hrr/1ySag8Y+CrA5cjM5fH+PXy
M0IJ02uWErJAt+TTKA+MNbphmdp4KACvFgpB7ATEA1yQKRNIJx+G+LeCDtACc4/U
r5EnHcVP8XI3M9f43ww01g1hQGn0EM53hkSv+ok+TThq7/fNKF4V0cpQN7vh0fJg
GrZnbxkgtOfDn0xnPzq5X6MK4yyRSnufBCVw5t/fcEnBsHlrfyfJMu8julyRJTb2
noq+Pj8FBiPdX9uvK/PwXVFObD7iN6i4xoz7kARC8MIbquKz6faxOEF2CdtimOGc
7pUL6KK4TztSomnDoInPrN0zbL3n
=KvFV
-----END PGP SIGNATURE-----

--lfncyt5cmnoo6b22--

