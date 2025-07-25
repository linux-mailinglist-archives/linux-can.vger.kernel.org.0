Return-Path: <linux-can+bounces-4149-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D0C97B11F02
	for <lists+linux-can@lfdr.de>; Fri, 25 Jul 2025 14:47:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ED3BB18886BC
	for <lists+linux-can@lfdr.de>; Fri, 25 Jul 2025 12:48:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28348242922;
	Fri, 25 Jul 2025 12:47:55 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF7682E36E3
	for <linux-can@vger.kernel.org>; Fri, 25 Jul 2025 12:47:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753447675; cv=none; b=eKFiSbWEIpT839ukSIl7pfkcWcvgn2FIaA01+Em+ysT0gYOTmDxMmiQ4Z7hZDTqSMKaGj42xZtdePukGrTEtciARcGuewwH+8hPWHcLZE0PZTHqwmCHdt9bztiPEZ09RYUn63qKDSJkWT8IuWfHTMkGGTYrxVJ9M+BbFyeJyn1k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753447675; c=relaxed/simple;
	bh=HZtWIFNtCJpMK2qxCgsJ8HLcBMXFIsU6z61saV4vKcA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hiXJLQDTAMc+hPPsBxZNFOInZ4+OuDO4R6amkcTanv9UKSaShTaNyH4E1XD9ePwXHuVZyenZCvsrPk7J6avCouFeGjuBmSWaO99R401SA7cgx+Iys18jw9nntAaUPYnoR6EcpGtMUoTSA9PzlcRpw3Ra7MAcJpnBLxq0tBOAYl0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1ufHpz-0000aE-CF; Fri, 25 Jul 2025 14:47:47 +0200
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1ufHpy-00ADrz-2y;
	Fri, 25 Jul 2025 14:47:46 +0200
Received: from pengutronix.de (p5b1645f7.dip0.t-ipconnect.de [91.22.69.247])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 97D7044960A;
	Fri, 25 Jul 2025 12:47:46 +0000 (UTC)
Date: Fri, 25 Jul 2025 14:47:46 +0200
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Jimmy Assarsson <extja@kvaser.com>
Cc: linux-can@vger.kernel.org, Jimmy Assarsson <jimmyassarsson@gmail.com>, 
	Vincent Mailhol <mailhol.vincent@wanadoo.fr>, Simon Horman <horms@kernel.org>, netdev@vger.kernel.org
Subject: Re: [PATCH v4 07/10] can: kvaser_pciefd: Add devlink support
Message-ID: <20250725-ingenious-labradoodle-of-action-d4dfb7-mkl@pengutronix.de>
References: <20250725123230.8-1-extja@kvaser.com>
 <20250725123230.8-8-extja@kvaser.com>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="3mf2wj25wf4cp2ss"
Content-Disposition: inline
In-Reply-To: <20250725123230.8-8-extja@kvaser.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org


--3mf2wj25wf4cp2ss
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v4 07/10] can: kvaser_pciefd: Add devlink support
MIME-Version: 1.0

On 25.07.2025 14:32:27, Jimmy Assarsson wrote:
> --- a/drivers/net/can/kvaser_pciefd/kvaser_pciefd_core.c
> +++ b/drivers/net/can/kvaser_pciefd/kvaser_pciefd_core.c
> @@ -1751,14 +1751,16 @@ static int kvaser_pciefd_probe(struct pci_dev *pd=
ev,
>  			       const struct pci_device_id *id)
>  {
>  	int ret;
> +	struct devlink *devlink;
>  	struct device *dev =3D &pdev->dev;
>  	struct kvaser_pciefd *pcie;
>  	const struct kvaser_pciefd_irq_mask *irq_mask;
> =20
> -	pcie =3D devm_kzalloc(dev, sizeof(*pcie), GFP_KERNEL);
> -	if (!pcie)
> +	devlink =3D devlink_alloc(&kvaser_pciefd_devlink_ops, sizeof(*pcie), de=
v);
> +	if (!devlink)
>  		return -ENOMEM;
> =20
> +	pcie =3D devlink_priv(devlink);
>  	pci_set_drvdata(pdev, pcie);
>  	pcie->pci =3D pdev;
>  	pcie->driver_data =3D (const struct kvaser_pciefd_driver_data *)id->dri=
ver_data;
> @@ -1766,7 +1768,7 @@ static int kvaser_pciefd_probe(struct pci_dev *pdev,
> =20
>  	ret =3D pci_enable_device(pdev);
>  	if (ret)
> -		return ret;
> +		goto err_free_devlink;
> =20
>  	ret =3D pci_request_regions(pdev, KVASER_PCIEFD_DRV_NAME);
>  	if (ret)
> @@ -1830,6 +1832,8 @@ static int kvaser_pciefd_probe(struct pci_dev *pdev,
>  	if (ret)
>  		goto err_free_irq;
> =20
> +	devlink_register(devlink);
> +
>  	return 0;
> =20
>  err_free_irq:
> @@ -1853,6 +1857,9 @@ static int kvaser_pciefd_probe(struct pci_dev *pdev,
>  err_disable_pci:
>  	pci_disable_device(pdev);
> =20
> +err_free_devlink:
> +	devlink_free(devlink);
> +
>  	return ret;
>  }
> =20
> @@ -1876,6 +1883,8 @@ static void kvaser_pciefd_remove(struct pci_dev *pd=
ev)
>  	for (i =3D 0; i < pcie->nr_channels; ++i)
>  		free_candev(pcie->can[i]->can.dev);
> =20
> +	devlink_unregister(priv_to_devlink(pcie));
> +	devlink_free(priv_to_devlink(pcie));
>  	pci_iounmap(pdev, pcie->reg_base);
                          ^^^^

This smells like a use after free. Please call the cleanup function in
reverse order of allocation functions, i.e. move devlink_free() to the
end of this function.

>  	pci_release_regions(pdev);
>  	pci_disable_device(pdev);

regards,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--3mf2wj25wf4cp2ss
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEn/sM2K9nqF/8FWzzDHRl3/mQkZwFAmiDfO8ACgkQDHRl3/mQ
kZyY2Qf/d8YL1m9zzf0GR8VhMlgXqQMqKI6bgEetN/STYpbPYISZikAXLKH3PMhl
+KPg4RXEm83uDB0jMEm9EW+wmKp523GQAI+nbFKxuNeRCX/XkopzSMr89DqltU0o
vH1wV5ARkJW1DtiB4sAJdUWpPk2ry44gecZmujxs2fRM8yhU1HivumKUDauaMpu5
jiQhjvjWet4hcKagRVHU4yt58PPXSc/gbkVKjEzFxHReVEO831SDPBvsUMVaOHMQ
rSj7uv5Z6ZwAGDHhMAEWr5TtdGQLv/6+5ZFIZzd7ZqoCOk3MjLdvwUcbvgAnhZUa
dv3ihtEUDQbMCqIKpnnrigGWuCx/iw==
=veG8
-----END PGP SIGNATURE-----

--3mf2wj25wf4cp2ss--

