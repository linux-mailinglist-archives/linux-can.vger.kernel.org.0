Return-Path: <linux-can+bounces-5368-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 51918C53E75
	for <lists+linux-can@lfdr.de>; Wed, 12 Nov 2025 19:24:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id F00CA4E1377
	for <lists+linux-can@lfdr.de>; Wed, 12 Nov 2025 18:17:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1789833A014;
	Wed, 12 Nov 2025 18:17:18 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BA7E2F3C09
	for <linux-can@vger.kernel.org>; Wed, 12 Nov 2025 18:17:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762971438; cv=none; b=RrUCjq62zqzf/KSRNaLhOktKu9TtBIMKnpzkReceugmpZoBX8+uagbSUnh81eJ2yOzz1bYqdO+Hfwc6kTAiqZ6kDwNc/N0dEd3wj2qgx8S/KcvdXWlgTD0KxfdMhg3MQcQptxc22fMcbenhGKG1Z8W40erWpZWMtXBv03XoD9IQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762971438; c=relaxed/simple;
	bh=f+b1rrPMukVeazYs5PAqtwAi/LNAlAX9ZDZNA/6oTgk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JZZ5Njm6CFL4PYteK3gdN0tfAH1sdivKNcUN8SxCQDV6rjZh5QOMcGnDIxlLFCtpmCi/DDsUK+Qb+CI0iyzI1FFXccBdep8/k3d7QN7NzUqWpOok27hItbVtESly51BPc3bNecX61yaRqTzUaMGz3SYm6owEySACKyCzmRGyNQI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1vJFOx-00032v-CC; Wed, 12 Nov 2025 19:17:03 +0100
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1vJFOv-000862-2Y;
	Wed, 12 Nov 2025 19:17:01 +0100
Received: from pengutronix.de (p54b152ce.dip0.t-ipconnect.de [84.177.82.206])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 7829949E099;
	Wed, 12 Nov 2025 18:17:01 +0000 (UTC)
Date: Wed, 12 Nov 2025 19:17:01 +0100
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, davem@davemloft.net, linux-can@vger.kernel.org, 
	kernel@pengutronix.de, Gregor Herburger <gregor.herburger@ew.tq-group.com>, 
	Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>, Manivannan Sadhasivam <mani@kernel.org>
Subject: Re: [PATCH net-next 07/11] can: mcp251xfd: add workaround for errata
 5
Message-ID: <20251112-gainful-sturdy-bird-296956-mkl@pengutronix.de>
References: <20251112091734.74315-1-mkl@pengutronix.de>
 <20251112091734.74315-8-mkl@pengutronix.de>
 <20251112092800.290282eb@kernel.org>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="pigoegfevrzrnn2g"
Content-Disposition: inline
In-Reply-To: <20251112092800.290282eb@kernel.org>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org


--pigoegfevrzrnn2g
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH net-next 07/11] can: mcp251xfd: add workaround for errata
 5
MIME-Version: 1.0

On 12.11.2025 09:28:00, Jakub Kicinski wrote:
> On Wed, 12 Nov 2025 10:13:47 +0100 Marc Kleine-Budde wrote:
> > +static int
> > +mcp251xfd_regmap_nocrc_gather_write(void *context,
> > +				    const void *reg_p, size_t reg_len,
> > +				    const void *val, size_t val_len)
> > +{
> > +	const u16 byte_exclude =3D MCP251XFD_REG_IOCON +
> > +				 mcp251xfd_first_byte_set(MCP251XFD_REG_IOCON_GPIO_MASK);
>
> Looks like this is added by the next patch :(
>
> drivers/net/can/spi/mcp251xfd/mcp251xfd-regmap.c:48:59: error: =E2=80=98M=
CP251XFD_REG_IOCON_GPIO_MASK=E2=80=99 undeclared (first use in this functio=
n); did you mean =E2=80=98MCP251XFD_REG_IOCON_GPIO0=E2=80=99?
>    48 |                                  mcp251xfd_first_byte_set(MCP251X=
FD_REG_IOCON_GPIO_MASK);
>       |                                                           ^~~~~~~=
~~~~~~~~~~~~~~~~~~~~~~
>       |                                                           MCP251X=
FD_REG_IOCON_GPIO0
>
> Do you do rebases or do we have to take it as is?

I'll fix it and send a new PR.

Sorry for the noise,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--pigoegfevrzrnn2g
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEn/sM2K9nqF/8FWzzDHRl3/mQkZwFAmkUzxkACgkQDHRl3/mQ
kZwWUwf/T4SnjyuObdK3U+JHwEGHJbtfd8udkIN+lM8HfPSUMv6c4M2fo+3y1nKy
mwqNW/1WISOlhwPSW4GvOWGsEmWQVkRc0fgu3BVl5f528qHR5lc6Yc5hpxQ647Iz
+GXv6I8Htkmhyq/QQUO4vso9XfGB4P/ugupDNfjpEIqL8b4f0AfIoR6dQYf4MuOL
h/lJIlx5R9gLGGOQVGWjI9WxgchteCmnAQv7unDuTQA0va2vVyH4zOhqqs8USeL6
6IUyMTDuu/T99ETzGPZUW/FVRs0ocu1J69OIuIc/nPqcXdWlTHP2Ym410Cbwkn7H
JIwFv6f0YpWpyxLqfsKbnJfDvMwRtA==
=Abwd
-----END PGP SIGNATURE-----

--pigoegfevrzrnn2g--

