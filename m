Return-Path: <linux-can+bounces-5294-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 807B5C28FF2
	for <lists+linux-can@lfdr.de>; Sun, 02 Nov 2025 14:55:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 5919A4E27C8
	for <lists+linux-can@lfdr.de>; Sun,  2 Nov 2025 13:55:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C15551D516F;
	Sun,  2 Nov 2025 13:55:22 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 632CFDDAB
	for <linux-can@vger.kernel.org>; Sun,  2 Nov 2025 13:55:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762091722; cv=none; b=H+uQcl2cGE9z2N/3g/bb23zM1mhUAAC29GGBDpCETF5GNfBFIh32FelUq6GQzvldTDab9pXKUeIPQZl7XF4C/Lr1xz3xEtYsH3H88LW2j+AsrsgIcLb8BjUV0IOueVG+S5RyGqwJOvDUP+lOCwcNildBs/OG3KrNYCucO7bx35M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762091722; c=relaxed/simple;
	bh=C+hvZgu83rdMCp/R+ETSIUghickwP2Pg+LlnsAW1WSQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=c1QG+cqnknPvRff5EFpWDB/8i8R61lMCMW98W1IqHC+fZ/l7CVJU8ubHjpZqlA/pCUYmQxttHDVak5wNxWMWNKao/hJoNU9TcY1G773/W/JgE/rKstZSe0zkOGBnnqQhlVP5ehel/6F9ZHH1zsYRwx7oS6L9c32bRPhT1jJtIn4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1vFYXt-0007Xk-DM; Sun, 02 Nov 2025 14:55:01 +0100
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1vFYXs-006ha2-37;
	Sun, 02 Nov 2025 14:55:00 +0100
Received: from pengutronix.de (unknown [IPv6:2a01:4f8:1c1c:29e9:22:41ff:fe00:1400])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id BF619494549;
	Fri, 31 Oct 2025 12:17:42 +0000 (UTC)
Date: Fri, 31 Oct 2025 13:17:38 +0100
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Maud Spierings via B4 Relay <devnull+maudspierings.gocontroll.com@kernel.org>
Cc: Vincent Mailhol <mailhol@kernel.org>, linux-can@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Maud Spierings <maudspierings@gocontroll.com>
Subject: Re: [PATCH] net: can: mcp251x: use dev_err_probe() in probe
Message-ID: <20251031-lumpy-fierce-sturgeon-01885c-mkl@pengutronix.de>
References: <20251030-mcp_err-v1-1-eecf737823b7@gocontroll.com>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="klwwvdtpzt4gwlo5"
Content-Disposition: inline
In-Reply-To: <20251030-mcp_err-v1-1-eecf737823b7@gocontroll.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org


--klwwvdtpzt4gwlo5
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH] net: can: mcp251x: use dev_err_probe() in probe
MIME-Version: 1.0

On 30.10.2025 08:07:42, Maud Spierings via B4 Relay wrote:
> From: Maud Spierings <maudspierings@gocontroll.com>
>
> The currently used combination of dev_err plus return leaves a loud
> error in dmesg even when the error is a deferred probe which gets
> resolved later. For example a supply that has not been probed yet.
>
> Use dev_err_probe to improve the handling/display of errors.
>
> Signed-off-by: Maud Spierings <maudspierings@gocontroll.com>

Applied to linux-can-next.

regards,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--klwwvdtpzt4gwlo5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEn/sM2K9nqF/8FWzzDHRl3/mQkZwFAmkEqN4ACgkQDHRl3/mQ
kZzjdAf/bY02b6QD7ru5fwba2j/tStaVnSaLx9dElNy0L4d1Zgh/SsB3ajlk4z0m
NYh7f07UP0vuaIP4/Zry0E5k4kOhCHjwvHyxb/Gazj73mFsi7POhC9vFbH+nfCf7
2RVLoMYuhN/kUjiwCyeKHjwefuZtZbFUhHCcvvAEzprSwzqZnCWv40IsMYEzmr6f
LK2xwDRFHkbAvCJS5nf4zyS5uPureykkRTTXvi0ZJ+sjVNwsRalJHTTrWGLGrhIy
sJTUiHRsh6dPkIX1pQiQhD7LwVEtrTnrzPyknfwtvnxfCZRLLUXsLny5tGhjVgRU
NuM5dcta7NnWD3whOeQltjiRdUBn/w==
=K7Bm
-----END PGP SIGNATURE-----

--klwwvdtpzt4gwlo5--

