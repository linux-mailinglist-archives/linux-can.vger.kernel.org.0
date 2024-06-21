Return-Path: <linux-can+bounces-799-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E8DD3911C85
	for <lists+linux-can@lfdr.de>; Fri, 21 Jun 2024 09:13:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 260601C21214
	for <lists+linux-can@lfdr.de>; Fri, 21 Jun 2024 07:13:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EA8E168C20;
	Fri, 21 Jun 2024 07:13:00 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 690DE12D742
	for <linux-can@vger.kernel.org>; Fri, 21 Jun 2024 07:12:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718953980; cv=none; b=eWeQAWaPlQ0RK9cOagEkcsZjA68Rmn7xRxunBIJWkkYFA1R7ZlXYdMJ5IOGkvXgS9Ca5cOdIkmUTjXwit0zUUpg1B/1uStn/FuKFSY0kZFCQ69elutoPVNOmrKyC8eTp5j2K5oVqgfkmhFGnFQoBWMeRxEOoCHROgjz+Cbc2prI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718953980; c=relaxed/simple;
	bh=VTO+fm3wuR6R8w0+YCZ9kTl7MPrxrQQRIK/pwoNERJs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=m9WRjHN45Ij55Ec5fcAgpTrfyYTweXPU1brk3RbUkCaKr8MlVilBxXC4w5ZWkQP7oCjFpyYNB3Rlj2fGvicG00kiBfJLqhCPR21F33xr+j+ypWYBhjK18Qn1szy78vuyvYhe8naVY02EiWHftOJAV1pP3pgqIjvwJajM/4UzBLg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1sKYRy-0000UE-Og; Fri, 21 Jun 2024 09:12:46 +0200
Received: from [2a0a:edc0:0:b01:1d::7b] (helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <mkl@pengutronix.de>)
	id 1sKYRx-003svC-Vt; Fri, 21 Jun 2024 09:12:46 +0200
Received: from pengutronix.de (p5de45302.dip0.t-ipconnect.de [93.228.83.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id A0F832EE332;
	Fri, 21 Jun 2024 07:12:45 +0000 (UTC)
Date: Fri, 21 Jun 2024 09:12:45 +0200
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Martin Jocic <martin.jocic@kvaser.com>
Cc: linux-can@vger.kernel.org, mailhol.vincent@wanadoo.fr, 
	extja@kvaser.com
Subject: Re: [PATCH v2 2/2] can: kvaser_pciefd: Add MSI interrupts
Message-ID: <20240621-giga-gopher-from-uranus-230ff0-mkl@pengutronix.de>
References: <20240620181320.235465-1-martin.jocic@kvaser.com>
 <20240620181320.235465-3-martin.jocic@kvaser.com>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="xdouttr2h5joikar"
Content-Disposition: inline
In-Reply-To: <20240620181320.235465-3-martin.jocic@kvaser.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org


--xdouttr2h5joikar
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 20.06.2024 20:13:20, Martin Jocic wrote:
> Use MSI interrupts with fallback to INTx interrupts.
>=20
> Signed-off-by: Martin Jocic <martin.jocic@kvaser.com>
> ---
>=20
>  Changes since v1:
>   * Implemented review comments from Jimmy Assarsson:
>     - Add missing pci_free_irq_vectors() in kvaser_pciefd_remove()
>     - Replace dev_info() with dev_err() when reporting errors
>=20
>   * Implemented review comment from Marc Kleine-Budde:
>     - Replace deprecated #define PCI_IRQ_LEGACY with PCI_IRQ_INTX
>=20
> Thank you for your comments.
>=20
> /Martin
>=20
>  drivers/net/can/kvaser_pciefd.c | 25 +++++++++++++++++++++----
>  1 file changed, 21 insertions(+), 4 deletions(-)
>=20
> diff --git a/drivers/net/can/kvaser_pciefd.c b/drivers/net/can/kvaser_pci=
efd.c
> index b4ffd56fdeff..5aed2521ccd1 100644
> --- a/drivers/net/can/kvaser_pciefd.c
> +++ b/drivers/net/can/kvaser_pciefd.c
> @@ -1774,11 +1774,24 @@ static int kvaser_pciefd_probe(struct pci_dev *pd=
ev,
>  	if (ret)
>  		goto err_teardown_can_ctrls;
> =20
> -	ret =3D request_irq(pcie->pci->irq, kvaser_pciefd_irq_handler,
> -			  IRQF_SHARED, KVASER_PCIEFD_DRV_NAME, pcie);
> -	if (ret)
> +	ret =3D pci_alloc_irq_vectors(pcie->pci, 1, 1, PCI_IRQ_INTX | PCI_IRQ_M=
SI);
> +	if (ret < 0) {
> +		dev_err(&pcie->pci->dev, "Failed to allocate IRQ vectors.\n");
>  		goto err_teardown_can_ctrls;
> +	}
> +
> +	ret =3D pci_irq_vector(pcie->pci, 0);
> +	if (ret < 0)
> +		goto err_free_msi;
> +
> +	pcie->pci->irq =3D ret;
> =20
> +	ret =3D request_irq(pcie->pci->irq, kvaser_pciefd_irq_handler,
> +			  IRQF_SHARED, KVASER_PCIEFD_DRV_NAME, pcie);
> +	if (ret) {
> +		dev_err(&pcie->pci->dev, "Failed to request IRQ %d\n", pcie->pci->irq);
> +		goto err_free_msi;
> +	}
>  	iowrite32(KVASER_PCIEFD_SRB_IRQ_DPD0 | KVASER_PCIEFD_SRB_IRQ_DPD1,
>  		  KVASER_PCIEFD_SRB_ADDR(pcie) + KVASER_PCIEFD_SRB_IRQ_REG);
> =20
> @@ -1807,6 +1820,10 @@ static int kvaser_pciefd_probe(struct pci_dev *pde=
v,
>  	iowrite32(0, irq_en_base);
>  	free_irq(pcie->pci->irq, pcie);
> =20
> +err_free_msi:
> +	if (pcie->pci->msi_enabled)
> +		pci_free_irq_vectors(pcie->pci);

I think you can call this unconditionally here, too. Will fixup while apply=
ing.

Marc

> +
>  err_teardown_can_ctrls:
>  	kvaser_pciefd_teardown_can_ctrls(pcie);
>  	iowrite32(0, KVASER_PCIEFD_SRB_ADDR(pcie) + KVASER_PCIEFD_SRB_CTRL_REG);
> @@ -1852,7 +1869,7 @@ static void kvaser_pciefd_remove(struct pci_dev *pd=
ev)
>  	iowrite32(0, KVASER_PCIEFD_PCI_IEN_ADDR(pcie));
> =20
>  	free_irq(pcie->pci->irq, pcie);
> -
> +	pci_free_irq_vectors(pcie->pci);
>  	pci_iounmap(pdev, pcie->reg_base);
>  	pci_release_regions(pdev);
>  	pci_disable_device(pdev);
> --=20
> 2.40.1
>=20
>=20
>=20

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--xdouttr2h5joikar
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEUEC6huC2BN0pvD5fKDiiPnotvG8FAmZ1J+oACgkQKDiiPnot
vG92kgf/SSgT0/C4UqHHsu6PmZG5OW0uvZpkpmSwW6qKB/B2OgwBtEdwmy4dFzSk
IFDz2HpvDH3+0PkHkTJBmx831u+AKCirOD/yq01sgLkGbDMyiA6BMQVzU1nxYnvw
xZozAwo77FaQO/yP++7SqMc//SWAAHyJIWV9R3tQKXnPEdSJXAzWLX+hzEEik2jH
73cXOUoewaUjG6J7M4QPIiUYMYTI0H7i4GZotf3CkI1RBjl1+YdHTZ8ByHbqh2xH
7IQlLqo6jPBeGZQZfCxSMbQNJxobE804RjHsnSvmItjvoGkXgABSYZOvkLVZoSb1
icSNC5+FM7ug8mCYMXQ/ftBm4Ph2YQ==
=qBW/
-----END PGP SIGNATURE-----

--xdouttr2h5joikar--

