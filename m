Return-Path: <linux-can+bounces-1200-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 830E29597D6
	for <lists+linux-can@lfdr.de>; Wed, 21 Aug 2024 12:41:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 314A41F213D5
	for <lists+linux-can@lfdr.de>; Wed, 21 Aug 2024 10:41:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47A821D460C;
	Wed, 21 Aug 2024 08:44:07 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 570C21D45F2
	for <linux-can@vger.kernel.org>; Wed, 21 Aug 2024 08:44:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724229847; cv=none; b=Qh7dApL3EY9HuyNl2n0gFktjYGqBuAgp1W1ZgIzJdePv0duPdHKyfJYbedXBANmc7b5xgMRQRxNiA/NNPf8qxj1P4Acu3ZOx85x4kXIbR6D6aXhJ6GLgCrqRauZcxRgoYx6floxWMeLXmPXMOEnmuaOKb9XHgrfCTea4hs+TUQE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724229847; c=relaxed/simple;
	bh=IiBHsujyF6Ii815MCoi6liC8R0ddV0O+iBeXXqpGeNU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RFLh7D8o9WrTSrDSwg/tdbeUWSK7Mxe34SM4Ik9u7DjRD7Yza/f6/2zIQTateRf5yXqfv1scD5x9wl+QKmRD9yg9SqpEyC6w1qmnM/L/8MEmR4gdN9BGu/wKloeaY9SddFiTL03r2GrcmkBWLORZERV0+S2dx0uyiniJ7aI74Jo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1sggwh-0003nc-7m; Wed, 21 Aug 2024 10:43:59 +0200
Received: from [2a0a:edc0:0:b01:1d::7b] (helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <mkl@pengutronix.de>)
	id 1sggwg-001yE4-EK; Wed, 21 Aug 2024 10:43:58 +0200
Received: from pengutronix.de (pd9e5994e.dip0.t-ipconnect.de [217.229.153.78])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 220A1322A75;
	Wed, 21 Aug 2024 08:43:58 +0000 (UTC)
Date: Wed, 21 Aug 2024 10:43:57 +0200
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Martin Jocic <martin.jocic@kvaser.com>
Cc: linux-can@vger.kernel.org, mailhol.vincent@wanadoo.fr, 
	extja@kvaser.com
Subject: Re: [PATCH] can: kvaser_pciefd: Enable 64-bit DMA addressing
Message-ID: <20240821-proficient-raptor-of-order-8cace0-mkl@pengutronix.de>
References: <20240819142255.643149-1-martin.jocic@kvaser.com>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="zkre6h725fulvnjs"
Content-Disposition: inline
In-Reply-To: <20240819142255.643149-1-martin.jocic@kvaser.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org


--zkre6h725fulvnjs
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 19.08.2024 16:22:55, Martin Jocic wrote:
> Enabling 64-bit addressing for DMA buffers will prevent issues
> on some memory constrained platforms like e.g. Raspberry Pi 5,
> where the driver won't load because it cannot allocate enough
> continuous memory in the default 32-bit memory address range.
>=20
> Signed-off-by: Martin Jocic <martin.jocic@kvaser.com>
> ---
>  drivers/net/can/kvaser_pciefd.c | 5 +++++
>  1 file changed, 5 insertions(+)
>=20
> diff --git a/drivers/net/can/kvaser_pciefd.c b/drivers/net/can/kvaser_pci=
efd.c
> index a60d9efd5f8d..5885f1ce189d 100644
> --- a/drivers/net/can/kvaser_pciefd.c
> +++ b/drivers/net/can/kvaser_pciefd.c
> @@ -1104,6 +1104,11 @@ static int kvaser_pciefd_setup_dma(struct kvaser_p=
ciefd *pcie)
>=20
>  	/* Disable the DMA */
>  	iowrite32(0, KVASER_PCIEFD_SRB_ADDR(pcie) + KVASER_PCIEFD_SRB_CTRL_REG);
> +
> +#ifdef CONFIG_ARCH_DMA_ADDR_T_64BIT
> +	dma_set_mask_and_coherent(&pcie->pci->dev, DMA_BIT_MASK(64));
> +#endif
> +

Several other driver first set a 64 bit mask and if this fails they set
a 32 bit mask and then bail out, e.g.:

https://elixir.bootlin.com/linux/v6.10.6/source/drivers/net/ethernet/intel/=
i40e/i40e_main.c#L15613


>  	for (i =3D 0; i < KVASER_PCIEFD_DMA_COUNT; i++) {
>  		pcie->dma_data[i] =3D dmam_alloc_coherent(&pcie->pci->dev,
>  							KVASER_PCIEFD_DMA_SIZE,
> --
> 2.43.0
>=20
>=20
>=20

regards,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--zkre6h725fulvnjs
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEUEC6huC2BN0pvD5fKDiiPnotvG8FAmbFqMkACgkQKDiiPnot
vG8mAwf/Z6ZKS/zumDYEWaV9CL9FWcsTIYRxpkPFJUg2/C77687M7zwMAjTn4Zqu
CjbF/kHcfnJ14Tu7K4H0q9JgI3rTS1dHdIfSgNA+8O78RtK3ChgM/oF3nspuMZ9U
8J2sJ+8rqPSVXSsqHi95E3iPJtlzHRkxqrPx2tHdoKDoyNVhKmFw3mMnulUBr9Tg
+a4LLEwUc0psLQUoiKCDZmN4bbnrryRwp6jhsN8SZzietpFPXjHGT/o7bjin8mRJ
k1A1m9ylXAi8qZNqnTLoheVutYosPXb0A/hT25I7eL2PNqsPwEbR9LIBkgVNN4kh
nW6Lb/XI7rL6ooeAX9oh4IX+3nWBaQ==
=vkdi
-----END PGP SIGNATURE-----

--zkre6h725fulvnjs--

