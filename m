Return-Path: <linux-can+bounces-5348-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CE61C512FF
	for <lists+linux-can@lfdr.de>; Wed, 12 Nov 2025 09:50:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 66556189DE2B
	for <lists+linux-can@lfdr.de>; Wed, 12 Nov 2025 08:50:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCFAC2FDC50;
	Wed, 12 Nov 2025 08:49:23 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4491A2FD665
	for <linux-can@vger.kernel.org>; Wed, 12 Nov 2025 08:49:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762937363; cv=none; b=E9P17PZ5jj9X8AvkDxtY8fZP/J8zGP27vWpqG5kV7veo61xuHyzcBAkyd3MXxLtS/XoHRwiTPsr7pyxQsMAL2hwHcgNKy/Yg2zs27+Lf5tw+eZwY4+I46vkQF8cXhkHulbsReeAx7e64CfmbS5SE545qAMZqezzipjiQ5qFtNZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762937363; c=relaxed/simple;
	bh=7Y0NcEO50k+Lkg2TaAhT6H2aLX/ROBKDfEWsp+yfC9k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MU1ewn5zn849bNnQ8sEWrbfD6ZI5BXkTEnO3SINVnbC3pDcxX5DstvUcwVxzF8csvKOeK4J2+L1wo/OCsVVXpVys6vCOUQwlTY9rCfV57jEeeWgM1sO2y+16Sx5wQK6+NWBsQxaUZF+DtqnBy1W6VDLpyCY+4YAMthNxYpBS16s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1vJ6XM-0002Yv-Jz; Wed, 12 Nov 2025 09:49:08 +0100
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1vJ6XL-0003Ic-24;
	Wed, 12 Nov 2025 09:49:07 +0100
Received: from pengutronix.de (p54b152ce.dip0.t-ipconnect.de [84.177.82.206])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 60C0B49D932;
	Wed, 12 Nov 2025 08:49:07 +0000 (UTC)
Date: Wed, 12 Nov 2025 09:49:07 +0100
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>
Cc: mani@kernel.org, thomas.kopp@microchip.com, mailhol.vincent@wanadoo.fr, 
	robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, 
	linus.walleij@linaro.org, brgl@bgdev.pl, linux-can@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, mukesh.savaliya@oss.qualcomm.com, 
	anup.kulkarni@oss.qualcomm.com
Subject: Re: [PATCH v6 0/6] can: mcp251xfd: add gpio functionality
Message-ID: <20251112-misty-functional-tench-b87da7-mkl@pengutronix.de>
References: <20251001091006.4003841-1-viken.dadhaniya@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="x44lo3g2fuc72oal"
Content-Disposition: inline
In-Reply-To: <20251001091006.4003841-1-viken.dadhaniya@oss.qualcomm.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org


--x44lo3g2fuc72oal
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v6 0/6] can: mcp251xfd: add gpio functionality
MIME-Version: 1.0

On 01.10.2025 14:40:00, Viken Dadhaniya wrote:
> Hi all,
>
> The mcp251xfd allows two pins to be configured as GPIOs. This series
> adds support for this feature.
>
> The GPIO functionality is controlled with the IOCON register which has
> an erratum.
>
> Patch 1 from https://lore.kernel.org/linux-can/20240429-mcp251xfd-runtime=
_pm-v1-3-c26a93a66544@pengutronix.de/
> Patch 2 refactor of no-crc functions to prepare workaround for non-crc wr=
ites
> Patch 3 is the fix/workaround for the aforementioned erratum
> Patch 4 only configure pin1 for rx-int
> Patch 5 adds the gpio support
> Patch 6 updates dt-binding
>
> As per Marc's comment on below patch, we aim to get this series into
> linux-next since the functionality is essential for CAN on the RB3 Gen2
> board. As progress has stalled, Take this series forward with minor code
> adjustments. Include a Tested-by tag to reflect validation performed on t=
he
> target hardware.
>
> https://lore.kernel.org/all/20240806-industrious-augmented-crane-44239a-m=
kl@pengutronix.de/

Applied to linux-can-next.

Thanks,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--x44lo3g2fuc72oal
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEn/sM2K9nqF/8FWzzDHRl3/mQkZwFAmkUSgAACgkQDHRl3/mQ
kZwz0QgAipcjcGPzwKwxFbq5c4IoWpsPnYAFL+EOEL7hSL3OyHweBpeMW3tl7Lex
NExeojiPB7ji26RDdMv6ZWeCsSo8z8zjGZSHo881gorLtT/RZXLEM2SR+HV0oCym
ouEWEgVLMwAaN/EsB3OUiKP7MvrhBGdCWvZvHkwjxLaoB9BPaR9LHX1SgUfad6jb
1UMT4Tmn9Nl26pZDubdl1ybVG9NOpQOlVXu4ne7p3OioVGWUXlaZhJmGL1pybMR0
EHS9f7/h851NBzM+IdfF3pejmBU+22wZcFOrN9S8X4/td31HtVR9SLid5Yma/c85
Ncye9dZMUL577iAde/B8uRWivo479g==
=mfrj
-----END PGP SIGNATURE-----

--x44lo3g2fuc72oal--

