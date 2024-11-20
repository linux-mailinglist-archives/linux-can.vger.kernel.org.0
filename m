Return-Path: <linux-can+bounces-2125-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BA58C9D35EF
	for <lists+linux-can@lfdr.de>; Wed, 20 Nov 2024 09:52:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 20431B236D7
	for <lists+linux-can@lfdr.de>; Wed, 20 Nov 2024 08:52:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 855672557A;
	Wed, 20 Nov 2024 08:52:22 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD83617E46E
	for <linux-can@vger.kernel.org>; Wed, 20 Nov 2024 08:52:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732092742; cv=none; b=om1pp1VMtmwE4a0TDX3VuQ7bkycIMUBz4MYs72G00pS0gwyeIXVUF2RUsnQj4sUGaT638L4xmatNfAx3x7dX8srys5je9sILgfGuGw+PQ5aZln6HW8KSyZ0s1AjNMmeNV4XrK/hpr7UD1cqnzAXFokcntsG820bgj5BDBAU547s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732092742; c=relaxed/simple;
	bh=wLDscVPrKUCW2MnjsiJx9LPBUOOJcvzBta007Y92kZw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FysRtjCgKHZK2h4ltGiyQQEJIoKvrh4GiQCj6FgGxwZyVbUgedF1eNbpQWIun/MundKCoOPvm1A7An3Goik8SPy2z/H/CofMKJVWAxBbWx82TG/VUBmBq3ctFsaXQ+5oiN3N6SsCIdhuuSzyDzyp9LYlbV5VQg/9U2vQmxWyARM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1tDgRO-0002oP-Mo; Wed, 20 Nov 2024 09:52:02 +0100
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1tDgRO-001iC2-0u;
	Wed, 20 Nov 2024 09:52:02 +0100
Received: from pengutronix.de (pd9e59fec.dip0.t-ipconnect.de [217.229.159.236])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id E03E3377A75;
	Wed, 20 Nov 2024 08:52:01 +0000 (UTC)
Date: Wed, 20 Nov 2024 09:52:01 +0100
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Ciprian Costea <ciprianmarian.costea@oss.nxp.com>
Cc: Vincent Mailhol <mailhol.vincent@wanadoo.fr>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S . Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, linux-can@vger.kernel.org, 
	netdev@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	imx@lists.linux.dev, NXP Linux Team <s32@nxp.com>, 
	Christophe Lizzi <clizzi@redhat.com>, Alberto Ruiz <aruizrui@redhat.com>, 
	Enric Balletbo <eballetb@redhat.com>
Subject: Re: [PATCH 3/3] can: flexcan: handle S32G2/S32G3 separate interrupt
 lines
Message-ID: <20241120-magnificent-accelerated-robin-70e7ef-mkl@pengutronix.de>
References: <20241119081053.4175940-1-ciprianmarian.costea@oss.nxp.com>
 <20241119081053.4175940-4-ciprianmarian.costea@oss.nxp.com>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="ez23ni5zujlwkjbj"
Content-Disposition: inline
In-Reply-To: <20241119081053.4175940-4-ciprianmarian.costea@oss.nxp.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org


--ez23ni5zujlwkjbj
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH 3/3] can: flexcan: handle S32G2/S32G3 separate interrupt
 lines
MIME-Version: 1.0

On 19.11.2024 10:10:53, Ciprian Costea wrote:
> From: Ciprian Marian Costea <ciprianmarian.costea@oss.nxp.com>
>=20
> On S32G2/S32G3 SoC, there are separate interrupts
> for state change, bus errors, MBs 0-7 and MBs 8-127 respectively.
>=20
> In order to handle this FlexCAN hardware particularity, reuse
> the 'FLEXCAN_QUIRK_NR_IRQ_3' quirk provided by mcf5441x's irq
> handling support.
>=20
> Additionally, introduce 'FLEXCAN_QUIRK_SECONDARY_MB_IRQ' quirk,
> which can be used in case there are two separate mailbox ranges
> controlled by independent hardware interrupt lines, as it is
> the case on S32G2/S32G3 SoC.

Does the mainline driver already handle the 2nd mailbox range? Is there
any downstream code yet?

Marc

>=20
> Signed-off-by: Ciprian Marian Costea <ciprianmarian.costea@oss.nxp.com>
> ---
>  drivers/net/can/flexcan/flexcan-core.c | 25 +++++++++++++++++++++++--
>  drivers/net/can/flexcan/flexcan.h      |  3 +++
>  2 files changed, 26 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/net/can/flexcan/flexcan-core.c b/drivers/net/can/fle=
xcan/flexcan-core.c
> index f0dee04800d3..dc56d4a7d30b 100644
> --- a/drivers/net/can/flexcan/flexcan-core.c
> +++ b/drivers/net/can/flexcan/flexcan-core.c
> @@ -390,9 +390,10 @@ static const struct flexcan_devtype_data nxp_s32g2_d=
evtype_data =3D {
>  	.quirks =3D FLEXCAN_QUIRK_DISABLE_RXFG | FLEXCAN_QUIRK_ENABLE_EACEN_RRS=
 |
>  		FLEXCAN_QUIRK_DISABLE_MECR | FLEXCAN_QUIRK_BROKEN_PERR_STATE |
>  		FLEXCAN_QUIRK_USE_RX_MAILBOX | FLEXCAN_QUIRK_SUPPORT_FD |
> -		FLEXCAN_QUIRK_SUPPORT_ECC |
> +		FLEXCAN_QUIRK_SUPPORT_ECC | FLEXCAN_QUIRK_NR_IRQ_3 |
>  		FLEXCAN_QUIRK_SUPPORT_RX_MAILBOX |
> -		FLEXCAN_QUIRK_SUPPORT_RX_MAILBOX_RTR,
> +		FLEXCAN_QUIRK_SUPPORT_RX_MAILBOX_RTR |
> +		FLEXCAN_QUIRK_SECONDARY_MB_IRQ,
>  };
> =20
>  static const struct can_bittiming_const flexcan_bittiming_const =3D {
> @@ -1771,12 +1772,21 @@ static int flexcan_open(struct net_device *dev)
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
> +	free_irq(priv->irq_err, dev);
>   out_free_irq_boff:
>  	free_irq(priv->irq_boff, dev);
>   out_free_irq:
> @@ -1808,6 +1818,9 @@ static int flexcan_close(struct net_device *dev)
>  		free_irq(priv->irq_boff, dev);
>  	}
> =20
> +	if (priv->devtype_data.quirks & FLEXCAN_QUIRK_SECONDARY_MB_IRQ)
> +		free_irq(priv->irq_secondary_mb, dev);
> +
>  	free_irq(dev->irq, dev);
>  	can_rx_offload_disable(&priv->offload);
>  	flexcan_chip_stop_disable_on_error(dev);
> @@ -2197,6 +2210,14 @@ static int flexcan_probe(struct platform_device *p=
dev)
>  		}
>  	}
> =20
> +	if (priv->devtype_data.quirks & FLEXCAN_QUIRK_SECONDARY_MB_IRQ) {
> +		priv->irq_secondary_mb =3D platform_get_irq(pdev, 3);
> +		if (priv->irq_secondary_mb < 0) {
> +			err =3D priv->irq_secondary_mb;
> +			goto failed_platform_get_irq;
> +		}
> +	}
> +
>  	if (priv->devtype_data.quirks & FLEXCAN_QUIRK_SUPPORT_FD) {
>  		priv->can.ctrlmode_supported |=3D CAN_CTRLMODE_FD |
>  			CAN_CTRLMODE_FD_NON_ISO;
> diff --git a/drivers/net/can/flexcan/flexcan.h b/drivers/net/can/flexcan/=
flexcan.h
> index 4933d8c7439e..d4b1a954c538 100644
> --- a/drivers/net/can/flexcan/flexcan.h
> +++ b/drivers/net/can/flexcan/flexcan.h
> @@ -70,6 +70,8 @@
>  #define FLEXCAN_QUIRK_SUPPORT_RX_FIFO BIT(16)
>  /* Setup stop mode with ATF SCMI protocol to support wakeup */
>  #define FLEXCAN_QUIRK_SETUP_STOP_MODE_SCMI BIT(17)
> +/* Setup secondary mailbox interrupt */
> +#define FLEXCAN_QUIRK_SECONDARY_MB_IRQ	BIT(18)
> =20
>  struct flexcan_devtype_data {
>  	u32 quirks;		/* quirks needed for different IP cores */
> @@ -105,6 +107,7 @@ struct flexcan_priv {
>  	struct regulator *reg_xceiver;
>  	struct flexcan_stop_mode stm;
> =20
> +	int irq_secondary_mb;
>  	int irq_boff;
>  	int irq_err;
> =20
> --=20
> 2.45.2
>=20
>=20
>=20

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--ez23ni5zujlwkjbj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEUEC6huC2BN0pvD5fKDiiPnotvG8FAmc9oy4ACgkQKDiiPnot
vG/NdQf6AtuniF8dcHrunU1m1SSRv5jc3w6XkosxNN8CKylVbbyk5j17sCoPxDBl
x4dePWSbEBp/823861k6VQn+oYuNorZ97+WlAoreKizkbymQZ6kLWa6NyRSMGCTZ
xuF74F1vPTX48tTgwQAbzZVe5yat+fgju7n6FRMml36vDSZT8DpvhneusodoVIil
Zqrdy9hZKUQNLCx3/kiV8z6GF2bUMyo6bhCktHKD1iaF/uQBhgcPEkMiaESYkhPN
zgUHkbePjkOtcuHvb5srNjM/1fRmvhbcv+eDHA9M+lA9hHsaz9JmN/8TW8e7iF2A
eqOcFGfFbEDQsz2/QnvDacm1CMN/QQ==
=wVkf
-----END PGP SIGNATURE-----

--ez23ni5zujlwkjbj--

