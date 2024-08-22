Return-Path: <linux-can+bounces-1205-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C37FD95AD9C
	for <lists+linux-can@lfdr.de>; Thu, 22 Aug 2024 08:37:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F10D51C20314
	for <lists+linux-can@lfdr.de>; Thu, 22 Aug 2024 06:37:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 793E314A4CC;
	Thu, 22 Aug 2024 06:36:08 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EBA213BAEE
	for <linux-can@vger.kernel.org>; Thu, 22 Aug 2024 06:36:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724308568; cv=none; b=XVJjgXYCmlpv8AP8hT9KGTr6M41JdEqByX23UxU8HqGAoH+TGw2YPBvSnDVuTbxAsMkcWoJerEY4eUBns9ye91KHrJCOTk+92mhMhTt6XkbqA6zK2mGp+pRQzVABE9LwEgbSovT0z+FSa0SUUw66CaZRbIUtlF5y2e1l4aHaU4U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724308568; c=relaxed/simple;
	bh=ZFTpzIctnFmlrxfzNwwlwipkaQ7J2Y/78/8CWc7+VrE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=T/M6kCX+ouN/m4betI9/RJEHlXnFXJvvdnXKsdIaThhvedvM9p/DJSFV2Gh7vcpXAZyLSFXEXR9SIiP/3yJpDe19mFE1NAeIV5+jgJn1gThRIc+RAQJFbRJf5F7h/4UbbxWepM7lfM9s74QbTr7D9sYNT7gl8gwCNwyjxrU8aNQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1sh1QP-00058U-RS; Thu, 22 Aug 2024 08:36:01 +0200
Received: from [2a0a:edc0:0:b01:1d::7b] (helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <mkl@pengutronix.de>)
	id 1sh1QO-002Ber-VT; Thu, 22 Aug 2024 08:36:01 +0200
Received: from pengutronix.de (pd9e5994e.dip0.t-ipconnect.de [217.229.153.78])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id A37DB323516;
	Thu, 22 Aug 2024 06:36:00 +0000 (UTC)
Date: Thu, 22 Aug 2024 08:36:00 +0200
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Martin =?utf-8?B?Sm9jacSH?= <martin.jocic@kvaser.com>
Cc: "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>, 
	Jimmy Assarsson <extja@kvaser.com>, "mailhol.vincent@wanadoo.fr" <mailhol.vincent@wanadoo.fr>
Subject: Re: [PATCH] can: kvaser_pciefd: Enable 64-bit DMA addressing
Message-ID: <20240822-able-octopus-of-swiftness-e68a9e-mkl@pengutronix.de>
References: <20240819142255.643149-1-martin.jocic@kvaser.com>
 <20240821-proficient-raptor-of-order-8cace0-mkl@pengutronix.de>
 <f61b536397092bd46d701cba2a0fc41430964b73.camel@kvaser.com>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="t7hkvhesspd777mi"
Content-Disposition: inline
In-Reply-To: <f61b536397092bd46d701cba2a0fc41430964b73.camel@kvaser.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org


--t7hkvhesspd777mi
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 21.08.2024 15:10:58, Martin Joci=C4=87 wrote:
> > Several other driver first set a 64 bit mask and if this fails they set
> > a 32 bit mask and then bail out, e.g.:

[...]

> As far as I can tell, the dynamic DMA mapping guide of the Kernel docs se=
ems to
> advise against this:
>=20
> From https://www.kernel.org/doc/html/next/core-api/dma-api-howto.html
>=20
> <begin quote>
> The standard 64-bit addressing device would do something like this:
>=20
> dma_set_mask_and_coherent(dev, DMA_BIT_MASK(64))
>=20
> dma_set_mask_and_coherent() never return fail when DMA_BIT_MASK(64).
> Typical error code like:
>=20
> /* Wrong code */
> if (dma_set_mask_and_coherent(dev, DMA_BIT_MASK(64)))
>         dma_set_mask_and_coherent(dev, DMA_BIT_MASK(32))
>=20
> dma_set_mask_and_coherent() will never return failure when bigger than 32.
> So typical code like:
>=20
> /* Recommended code */
> if (support_64bit)
>         dma_set_mask_and_coherent(dev, DMA_BIT_MASK(64));
> else
>         dma_set_mask_and_coherent(dev, DMA_BIT_MASK(32));
> <end quote>

Thanks for looking it up and pointing out.

> In Kvaser's case all CAN PCIe devices support 64-bit addressing.
>=20
> Should I still change the patch as per your suggestion?

Use the original patch but please convert the ifdef into IS_ENABLED:

        if (IS_ENABLED(CONFIG_ARCH_DMA_ADDR_T_64BIT)

regards,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--t7hkvhesspd777mi
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEUEC6huC2BN0pvD5fKDiiPnotvG8FAmbG3E0ACgkQKDiiPnot
vG9Y5Qf9Hu2vfICKrJ4YqlJGVlCaaeBDxvpxYaMy/iLS8FPbXvmOqIAHxqYCo0AO
qlBEiJDdFkDKsv9T7lCzZwXE3A8cpso+mfaT0cXKSaWFpcV2aipZT0XUcmEzBSpS
AvB4P8ykJlGkkUwcVO8T64DYDEU/5BvGS0NuMGJp63zSupfGFYShlG1NPjvG5XPM
LHJYKPc+fdVxyYsdGI49tCpwhs+6npo0zXqhboARhgP0Zvb+vSYSrW17fPZWaZ7I
V68ThjeUVP9Ilb4/KmYZ5J2Qyebj5sn0LKeHoYSKshjRa1uHFdeI1AfaRNDBwVSg
FVfk/t7MSjETwltYniMp4PGhUFalBw==
=f/7k
-----END PGP SIGNATURE-----

--t7hkvhesspd777mi--

