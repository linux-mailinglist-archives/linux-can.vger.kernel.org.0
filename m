Return-Path: <linux-can+bounces-2850-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 611B2A3BB3B
	for <lists+linux-can@lfdr.de>; Wed, 19 Feb 2025 11:09:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3658F189731C
	for <lists+linux-can@lfdr.de>; Wed, 19 Feb 2025 10:09:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B62A1CDA0B;
	Wed, 19 Feb 2025 10:08:57 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55AA61DBB3A
	for <linux-can@vger.kernel.org>; Wed, 19 Feb 2025 10:08:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739959737; cv=none; b=WUFOEc01MOMTMzKZaJOs87nDUDNtRDEviIlKXIAh2qXKHmRJMtYQ9qlwAHIfo+LXpezA03mxurNAF3wQ9n2hwezjKj1gTSaFpoSYyLGUzXnI8NpyRHmq2Qoc3racQb12EuYdRQEGaIt+RAkNYux4+P72aqAdab3v86Mo/rza1mA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739959737; c=relaxed/simple;
	bh=p/KxdQ4ruN5JahY/uQN98eW+Q2Xwpg9xtO6USNbCEdM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sTxmFTj+Co/EryMF4p2K97osDW6C/XyvvKslRhKAm3s5sCU4HDXyUdeYujqRIBsE6mUy/1lw3tpi7/b8KDJYnel+Qd0lPtjbI+/9hAtuojFgXOMLDWdoTcutfu0m21NLdHj5PsnE2OC4+cFOVPzbKBv2aIFHbQ+BOF7kSLIRv1A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1tkh0P-0005fw-VC; Wed, 19 Feb 2025 11:08:37 +0100
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1tkh0P-001k4v-1n;
	Wed, 19 Feb 2025 11:08:37 +0100
Received: from pengutronix.de (p5b164285.dip0.t-ipconnect.de [91.22.66.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 2F77D3C67EB;
	Wed, 19 Feb 2025 10:08:37 +0000 (UTC)
Date: Wed, 19 Feb 2025 11:08:36 +0100
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Ciprian Costea <ciprianmarian.costea@oss.nxp.com>
Cc: Vincent Mailhol <mailhol.vincent@wanadoo.fr>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, linux-can@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, NXP S32 Linux <s32@nxp.com>, imx@lists.linux.dev, 
	Christophe Lizzi <clizzi@redhat.com>, Alberto Ruiz <aruizrui@redhat.com>, 
	Enric Balletbo <eballetb@redhat.com>
Subject: Re: [PATCH v4 2/3 RESEND] can: flexcan: Add quirk to handle separate
 interrupt lines for mailboxes
Message-ID: <20250219-prophetic-accomplished-sunfish-5f0f0d-mkl@pengutronix.de>
References: <20250113120704.522307-1-ciprianmarian.costea@oss.nxp.com>
 <20250113120704.522307-3-ciprianmarian.costea@oss.nxp.com>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="xuwrpmy5uiyzauwm"
Content-Disposition: inline
In-Reply-To: <20250113120704.522307-3-ciprianmarian.costea@oss.nxp.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org


--xuwrpmy5uiyzauwm
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v4 2/3 RESEND] can: flexcan: Add quirk to handle separate
 interrupt lines for mailboxes
MIME-Version: 1.0

On 13.01.2025 14:07:03, Ciprian Costea wrote:
> From: Ciprian Marian Costea <ciprianmarian.costea@oss.nxp.com>
>=20
> Introduce 'FLEXCAN_QUIRK_SECONDARY_MB_IRQ' quirk to handle a FlexCAN
> hardware module integration particularity where two ranges of mailboxes
> are controlled by separate hardware interrupt lines.
> The same 'flexcan_irq' handler is used for both separate mailbox interrupt
> lines, with no other changes.
>=20
> Signed-off-by: Ciprian Marian Costea <ciprianmarian.costea@oss.nxp.com>
> Reviewed-by: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
> ---
>  drivers/net/can/flexcan/flexcan-core.c | 24 +++++++++++++++++++++++-
>  drivers/net/can/flexcan/flexcan.h      |  5 +++++
>  2 files changed, 28 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/net/can/flexcan/flexcan-core.c b/drivers/net/can/fle=
xcan/flexcan-core.c
> index ac1a860986df..3ae54305bf33 100644
> --- a/drivers/net/can/flexcan/flexcan-core.c
> +++ b/drivers/net/can/flexcan/flexcan-core.c
> @@ -1762,14 +1762,25 @@ static int flexcan_open(struct net_device *dev)
>  			goto out_free_irq_boff;
>  	}
> =20
> +	if (priv->devtype_data.quirks & FLEXCAN_QUIRK_SECONDARY_MB_IRQ) {
> +		err =3D request_irq(priv->irq_secondary_mb,
> +				  flexcan_irq, IRQF_SHARED, dev->name, dev);
> +		if (err)
> +			goto out_free_irq_err;
> +	}
> +
>  	flexcan_chip_interrupts_enable(dev);
> =20
>  	netif_start_queue(dev);
> =20
>  	return 0;
> =20
> + out_free_irq_err:
> +	if (priv->devtype_data.quirks & FLEXCAN_QUIRK_NR_IRQ_3)
> +		free_irq(priv->irq_err, dev);
>   out_free_irq_boff:
> -	free_irq(priv->irq_boff, dev);
> +	if (priv->devtype_data.quirks & FLEXCAN_QUIRK_NR_IRQ_3)
> +		free_irq(priv->irq_boff, dev);
>   out_free_irq:
>  	free_irq(dev->irq, dev);
>   out_can_rx_offload_disable:
> @@ -1799,6 +1810,9 @@ static int flexcan_close(struct net_device *dev)
>  		free_irq(priv->irq_boff, dev);
>  	}
> =20
> +	if (priv->devtype_data.quirks & FLEXCAN_QUIRK_SECONDARY_MB_IRQ)
> +		free_irq(priv->irq_secondary_mb, dev);
> +

While applying, I've changed the order to free the secondary IRQ first,
to be symmetrical to flexcan_open().

regards,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--xuwrpmy5uiyzauwm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEn/sM2K9nqF/8FWzzDHRl3/mQkZwFAme1raAACgkQDHRl3/mQ
kZwxnQgAm/qLQis4DHGGYASyvTu+okBD2sQvTNp0Fn7wq5ZOlgtVNZe51xpvZIMN
UH4G6nujnF34X7q0nxGoztcOcZjod9Ts0++6IGyb8XbB0JLsZnt8+juJitpBE8N2
NVp0A2dgfnLYuYHxeGWjP6uXR+LSW5adW8xoiC8k1Fjo7piY0Mw7WfISNaxTh7oY
Jjc4jh0a/PRMqiBtOPhzRCfRZ7oUv2k8pzK1Bl8l/6Kij0rG+asVy/iXhWT+O6YY
X0XbGdnFuyU1Sl9IauLqmWs0Nj5xwyNQv4DpjhWDnw3ifd1g5CDW2wnWZQufCxPB
OVbDhCDx0GHr/exKbn175IHhJove4A==
=XxV6
-----END PGP SIGNATURE-----

--xuwrpmy5uiyzauwm--

