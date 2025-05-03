Return-Path: <linux-can+bounces-3524-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 23FACAA80BA
	for <lists+linux-can@lfdr.de>; Sat,  3 May 2025 14:40:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 019271B63EA4
	for <lists+linux-can@lfdr.de>; Sat,  3 May 2025 12:40:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B6CC20C03E;
	Sat,  3 May 2025 12:40:17 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66C7413FEE
	for <linux-can@vger.kernel.org>; Sat,  3 May 2025 12:40:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746276017; cv=none; b=CqOnpiE3xNDav/eIe0BYvcKPas/X8ujSkeyCs48k+k6yyRQGGnWG/CjHz98FyYe6gkdiX1Rhj67V00Oruk16JpHboOR929a1TZLj2Mv7zmTdY9veOgk06iENnD4sXPwS5yqfmYriBcg46ADRu/Dq+NLAyU67CL5wUNZwWYOlpwM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746276017; c=relaxed/simple;
	bh=y6j/s6Ooh1Vnb6pv3kwbib3fg7tNUE86lUql42rhsEM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CxGmpHu2/gj9GazHYpW0VAQGLm77ECE4/EYAK7wnWE78ciO8Wsxi1x6+ExrOPlMUozn5moVn2jfi211Mcn7yJxGGfILFOjV/VHLVbX2MErVkYHfxl29ZZ9wFZWms8MKvlq5MRECo8Ckr+8dAjAPCfv68zptpxWUQ3kvoYTVbbWQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1uBC9h-0002FE-VL; Sat, 03 May 2025 14:39:45 +0200
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1uBC9f-000uW0-2f;
	Sat, 03 May 2025 14:39:43 +0200
Received: from pengutronix.de (p5b1645f7.dip0.t-ipconnect.de [91.22.69.247])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 78C13407487;
	Sat, 03 May 2025 12:39:43 +0000 (UTC)
Date: Sat, 3 May 2025 14:39:42 +0200
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Biju Das <biju.das.jz@bp.renesas.com>
Cc: Vincent Mailhol <mailhol.vincent@wanadoo.fr>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Geert Uytterhoeven <geert+renesas@glider.be>, 
	Wolfram Sang <wsa+renesas@sang-engineering.com>, u.kleine-koenig@baylibre.com, 
	Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>, Biju Das <biju.das.au@gmail.com>, 
	Duy Nguyen <duy.nguyen.rh@renesas.com>, Fabrizio Castro <fabrizio.castro.jz@renesas.com>, 
	Simon Horman <horms@kernel.org>, linux-renesas-soc@vger.kernel.org, linux-can@vger.kernel.org, 
	devicetree@vger.kernel.org
Subject: Re: [PATCH v9 00/19] Add support for RZ/G3E CANFD
Message-ID: <20250503-adept-elastic-coucal-7b76f3-mkl@pengutronix.de>
References: <20250417054320.14100-1-biju.das.jz@bp.renesas.com>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="vi2vlrcpcbbsglia"
Content-Disposition: inline
In-Reply-To: <20250417054320.14100-1-biju.das.jz@bp.renesas.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org


--vi2vlrcpcbbsglia
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v9 00/19] Add support for RZ/G3E CANFD
MIME-Version: 1.0

On 17.04.2025 06:43:01, Biju Das wrote:
> The CAN-FD module on RZ/G3E is very similar to the one on both R-Car V4H
> and RZ/G2L, but differs in some hardware parameters:
>  * No external clock, but instead has ram clock.
>  * Support up to 6 channels.
>  * 20 interrupts.

Applied to linux-can-next.

Thanks,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--vi2vlrcpcbbsglia
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEn/sM2K9nqF/8FWzzDHRl3/mQkZwFAmgWDosACgkQDHRl3/mQ
kZyiBwf9HF+FnT398+kPop31k9Z7bBkHnwvhfu8EMeHzhkav3JBW8S7HxKZu3fM3
f9pLigBrNtOirUfcXdPcG/JPtz1PmCxBEPP3pQVEGIbQxONSFhS4PDmrWNyWiuKo
1Yo+wpx4nGXCLdip2YcUo5xMIuHMBoXWZUWxPbHCSWPaqSuzPznPs3ZaKKopNVwJ
WLuNekHRc6LuLan1mAyx3Ww6pucxNcpeghS5kM/HtFLEiwPoQhK7eAU3p+ykFnfP
2n49lSKXAX7IfD91zzFrQyZ98RzRgmyq5T7QckykZAnFhQ5Lhb9E8OeK55tLIB1B
Fnpv1HAEqrHF0l95lZsnaf5l1kJKGw==
=/dgu
-----END PGP SIGNATURE-----

--vi2vlrcpcbbsglia--

