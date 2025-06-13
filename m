Return-Path: <linux-can+bounces-3831-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A894AD8408
	for <lists+linux-can@lfdr.de>; Fri, 13 Jun 2025 09:31:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 23624189AC60
	for <lists+linux-can@lfdr.de>; Fri, 13 Jun 2025 07:31:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7267E1EA7E1;
	Fri, 13 Jun 2025 07:31:02 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21AB01B95B
	for <linux-can@vger.kernel.org>; Fri, 13 Jun 2025 07:30:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749799862; cv=none; b=lGtGW5Esp8ANzgLaNWk1jIy7954OXL/0DUye7gjg1f7F1CJoKeief2WDKxSnjTuNO6quSREd9gaappD8o8eMXmnd/sL+ZQ6N+IBg5sY9f8sGe/ROqeyXqYtX7QwxXlLeMng30P44WOFVSq5WeQ4M+TMda5bD2QI76R6XTybsh6o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749799862; c=relaxed/simple;
	bh=cBQbV806MunnlrYLSpuN3FK9YSYRGvxOZmYLt/ntwk8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=J1K4hw83+La6dWTF/T5HAyQqEQghRfwBsKkLiOJoH06ChXHRBTMbptsN0PSodM9MyB4Jk97oBPjo57A3WKz6lWIsMdc0WPBmZ3KsLZKt9izntsYgczeIMwFc4yWuGiBCT4q6+MNNhuuUOFw6drBKivSC937FBLMp3dreJ7PZzh0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1uPysK-0007Pr-Hr; Fri, 13 Jun 2025 09:30:56 +0200
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1uPysJ-003Ffn-0q;
	Fri, 13 Jun 2025 09:30:55 +0200
Received: from pengutronix.de (p5b1645f7.dip0.t-ipconnect.de [91.22.69.247])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id EB762426D52;
	Fri, 13 Jun 2025 07:30:54 +0000 (UTC)
Date: Fri, 13 Jun 2025 09:30:54 +0200
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Brett Werling <brett.werling@garmin.com>
Cc: linux-can@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Vincent Mailhol <mailhol.vincent@wanadoo.fr>, bwerl.dev@gmail.com
Subject: Re: [PATCH] can: tcan4x5x: fix power regulator retrieval during probe
Message-ID: <20250613-snobbish-tapir-of-fascination-1dc74c-mkl@pengutronix.de>
References: <20250612191825.3646364-1-brett.werling@garmin.com>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="mq5qqb2o7yoqfyri"
Content-Disposition: inline
In-Reply-To: <20250612191825.3646364-1-brett.werling@garmin.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org


--mq5qqb2o7yoqfyri
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH] can: tcan4x5x: fix power regulator retrieval during probe
MIME-Version: 1.0

On 12.06.2025 14:18:25, Brett Werling wrote:
> Fixes the power regulator retrieval in tcan4x5x_can_probe() by ensuring
> the regulator pointer is not set to NULL in the successful return from
> devm_regulator_get_optional().
>=20
> Fixes: 3814ca3a10be ("can: tcan4x5x: tcan4x5x_can_probe(): turn on the po=
wer before parsing the config")
> Signed-off-by: Brett Werling <brett.werling@garmin.com>

Applied to linux-can and added stable on Cc.

Thanks,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--mq5qqb2o7yoqfyri
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEn/sM2K9nqF/8FWzzDHRl3/mQkZwFAmhL06sACgkQDHRl3/mQ
kZw+Agf/atxpfdDJq/vqi5uCot1TovWSbv1wEiG6jQYBYVDNz3ib3DmdykY55lzF
Tfjd8ow26v//NRddqJncMSXkFlSLFqSoM8Yb928dylnLsZhDZU2H5PJNDa63+9t3
5zr4LpWpAmuXnQP8kqX47D7vZQ8j1qMwO4zK/s/Gqd2nHcHt6d7f4TaBzVLMZlmB
OMwF0ST/Ras4DN/RJi8WqBPtHmI49m0u5LfJvZZEAB/Eo9vvPRoUGrsxp2AJvPjM
Vqw+1dLA8B9QNl66npbWh8W/Bo4Md+NZEfVyVCmSDTW1jKL96vjKOOk+GegDEnyU
XZdfvnz4t0C+pVSFWy9RuNcGTPSWKg==
=8kCX
-----END PGP SIGNATURE-----

--mq5qqb2o7yoqfyri--

