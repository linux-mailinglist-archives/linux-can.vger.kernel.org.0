Return-Path: <linux-can+bounces-3956-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 38553B017FF
	for <lists+linux-can@lfdr.de>; Fri, 11 Jul 2025 11:35:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 315561CA3CD9
	for <lists+linux-can@lfdr.de>; Fri, 11 Jul 2025 09:35:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54C4327AC25;
	Fri, 11 Jul 2025 09:34:23 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76DA827A448
	for <linux-can@vger.kernel.org>; Fri, 11 Jul 2025 09:34:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752226463; cv=none; b=rgcAzjRmNwdxIjGKhEMne9YDICMfxrCXnvvsiZEY4C0CCm2tDtOwCFN7m79560RIv2zbADB95s6svhBygVnlv98ZWJibfjW0nnx86IF+VOK3Ut5ALDOm0hn3jq55iFYretEpF8+HqbjBxwwsg0Qi17JkCVtQY22MMP8fS2Lt9Wk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752226463; c=relaxed/simple;
	bh=PNw8/wjEXbri5MSRzmdIu6nBISxUaGUoc5kF04xM0to=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jeEYItwtTEx8VmaGfJku1Q5/q3m12Gm5xgcrhfCWrmAJxqNdQEdXILvgeWN5QW1eZ+NNdf0m7Emcm/kTXXUIjlASEbzCDg9m61+ITSHdWM6xeWQuESu+bM3Bs1j7lkcPX0tmHzce9nS+rBzL9gWTQ7fOXBYQA03BjhQRsCYBfp4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1uaA94-0005G8-Sc; Fri, 11 Jul 2025 11:34:18 +0200
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1uaA94-007tk8-24;
	Fri, 11 Jul 2025 11:34:18 +0200
Received: from pengutronix.de (p5b1645f7.dip0.t-ipconnect.de [91.22.69.247])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 62F3C43C756;
	Fri, 11 Jul 2025 09:34:18 +0000 (UTC)
Date: Fri, 11 Jul 2025 11:34:18 +0200
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Vincent Mailhol <mailhol.vincent@wanadoo.fr>, 
	linux-can@vger.kernel.org, linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH] can: rcar_can: Convert to DEFINE_SIMPLE_DEV_PM_OPS()
Message-ID: <20250711-clever-daffy-anteater-76e617-mkl@pengutronix.de>
References: <6ffe085f6e2548f53674dd11704b388cf4b303e9.1752086078.git.geert+renesas@glider.be>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="xhfuhzctmbniy4fq"
Content-Disposition: inline
In-Reply-To: <6ffe085f6e2548f53674dd11704b388cf4b303e9.1752086078.git.geert+renesas@glider.be>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org


--xhfuhzctmbniy4fq
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH] can: rcar_can: Convert to DEFINE_SIMPLE_DEV_PM_OPS()
MIME-Version: 1.0

On 09.07.2025 20:36:21, Geert Uytterhoeven wrote:
> Convert the Renesas R-Car CAN driver from SIMPLE_DEV_PM_OPS() to
> DEFINE_SIMPLE_DEV_PM_OPS() and pm_sleep_ptr().  This lets us drop the
> __maybe_unused annotations from its suspend and resume callbacks, and
> reduces kernel size in case CONFIG_PM or CONFIG_PM_SLEEP is disabled.
>=20
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>

Applied to can-next.

Thanks,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--xhfuhzctmbniy4fq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEn/sM2K9nqF/8FWzzDHRl3/mQkZwFAmhw2pcACgkQDHRl3/mQ
kZwcBggAk50ANoieXas5biYJ+By14HZi89nVtmPzTV9o3GTqsg8tFyC9r8/bLbZe
E9Dv1l0DGwUL5J4G6pWsXwWFJ8+cOq+LPhqi2gLOEq1fJBS7m9ltkevygkioifev
Z6HgYdBrujzTp2MOyHz+wNT+c3zuTqVgKGLw10R3ioKi9aszF2iDyaxp3NSggxiO
YJUZezOKNPFmfgvRLBo4sp5WPrytU61Oz5G08Gc78PTfPCFSpSk8MZp9lVQMifkE
zp0D5kWuMg1JiK4lCx/RSjl6iskUQCuBE5uQmIfIcIg7mtVKZ5dlbTl/MFm6ObPG
Dkg99VETUUq/YphVOpCJ7VhgwRyqFw==
=tzT5
-----END PGP SIGNATURE-----

--xhfuhzctmbniy4fq--

