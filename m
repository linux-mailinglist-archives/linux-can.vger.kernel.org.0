Return-Path: <linux-can+bounces-5381-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 9481FC54037
	for <lists+linux-can@lfdr.de>; Wed, 12 Nov 2025 19:53:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 29BBC4E252A
	for <lists+linux-can@lfdr.de>; Wed, 12 Nov 2025 18:45:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9258A348894;
	Wed, 12 Nov 2025 18:45:54 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23DDA347BCC
	for <linux-can@vger.kernel.org>; Wed, 12 Nov 2025 18:45:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762973154; cv=none; b=bizMVuKOX94Pl0boOMrTtuguaN321gTKtewXV8/+yhePy+d3ZXon0rLlNhCv4/AU4dTD99D6XbF4tVgBAe0NaSL1lcRrveLVBxy7kOnYNuUVsDm0TLKv0pN4rrgQcoFkXDNS76XWFlSKmpPopjbXDlg/yiQHyGQc9t/NoA6WXNk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762973154; c=relaxed/simple;
	bh=6s0bv0ogS7AofMNQA1RKIwLzaImccRjzFQ1m1D1AMbc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CL4pAF7sDcfAWdbxy3NIkojNPf3P6mEXlQeA2MP4t7quWRGBq069rNpSA5F9aKOQVqdy5DLlSf2seiQcvz5XEY2AMJuRmRQO3Mazr7nte1Z9So6ewJLL84Ubs+vt6zunecQ7uMabIVdXhFL5JjmG4yAKKIX4yBRwIWZflLfE380=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1vJFqj-0007hx-Pl; Wed, 12 Nov 2025 19:45:45 +0100
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1vJFqj-0008DK-0G;
	Wed, 12 Nov 2025 19:45:45 +0100
Received: from pengutronix.de (p54b152ce.dip0.t-ipconnect.de [84.177.82.206])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id B9C1F49E111;
	Wed, 12 Nov 2025 18:45:44 +0000 (UTC)
Date: Wed, 12 Nov 2025 19:45:44 +0100
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, davem@davemloft.net, linux-can@vger.kernel.org, 
	kernel@pengutronix.de, Gregor Herburger <gregor.herburger@ew.tq-group.com>, 
	Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>, Manivannan Sadhasivam <mani@kernel.org>
Subject: Re: [PATCH net-next 07/11] can: mcp251xfd: add workaround for errata
 5
Message-ID: <20251112-meteoric-cuttlefish-of-cubism-eb4566-mkl@pengutronix.de>
References: <20251112091734.74315-1-mkl@pengutronix.de>
 <20251112091734.74315-8-mkl@pengutronix.de>
 <20251112092800.290282eb@kernel.org>
 <20251112-gainful-sturdy-bird-296956-mkl@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="6goxyitucoudzupj"
Content-Disposition: inline
In-Reply-To: <20251112-gainful-sturdy-bird-296956-mkl@pengutronix.de>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org


--6goxyitucoudzupj
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH net-next 07/11] can: mcp251xfd: add workaround for errata
 5
MIME-Version: 1.0

On 12.11.2025 19:17:01, Marc Kleine-Budde wrote:
> > Looks like this is added by the next patch :(
> >
> > drivers/net/can/spi/mcp251xfd/mcp251xfd-regmap.c:48:59: error: =E2=80=
=98MCP251XFD_REG_IOCON_GPIO_MASK=E2=80=99 undeclared (first use in this fun=
ction); did you mean =E2=80=98MCP251XFD_REG_IOCON_GPIO0=E2=80=99?
> >    48 |                                  mcp251xfd_first_byte_set(MCP25=
1XFD_REG_IOCON_GPIO_MASK);
> >       |                                                           ^~~~~=
~~~~~~~~~~~~~~~~~~~~~~~~
> >       |                                                           MCP25=
1XFD_REG_IOCON_GPIO0
> >
> > Do you do rebases or do we have to take it as is?
>
> I'll fix it and send a new PR.

Here it is: https://lore.kernel.org/all/20251112184344.189863-1-mkl@pengutr=
onix.de/

regards,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--6goxyitucoudzupj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEn/sM2K9nqF/8FWzzDHRl3/mQkZwFAmkU1dUACgkQDHRl3/mQ
kZx3LAf/QduUbUKfGiYz/b4oef+4cJ5VRErF1D8sH/5JonmK0Q+naIS+PSk1+Vxi
atmuzqKnCPTyylBvn49OnxWesKPdRg/udea27SHn+FH0ToHrbwwVBIPmqlZZIO1c
mkyGpyZg1Kb66L8gFb55X6+fxBivdxMJGfFoF/jCnd00YCmw8BEBHpG6gz8unzem
5hMCLsfkGeN5V6KA/4iovV3q6GTeuVhfpwm2GUh+Mwfh0s3eFqOstYPcoV+ufMoB
a8MaT2YUUMR+Kgcx+JElVwzuVArYt+VuVVP2UoZYRuyRg/HaYCCHEsqQd2D8Gg+r
IRiazlR09l5x47RRR78gf7+pjl4Djw==
=h3ui
-----END PGP SIGNATURE-----

--6goxyitucoudzupj--

