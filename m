Return-Path: <linux-can+bounces-1961-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 640149C4280
	for <lists+linux-can@lfdr.de>; Mon, 11 Nov 2024 17:21:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 24D8028901C
	for <lists+linux-can@lfdr.de>; Mon, 11 Nov 2024 16:21:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 335F21A08DF;
	Mon, 11 Nov 2024 16:21:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hPH7cBOp"
X-Original-To: linux-can@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0559D54728;
	Mon, 11 Nov 2024 16:21:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731342063; cv=none; b=TePZdrPBA7jEhvRXPOSG2WNtmLTnotDVjwXnoAKuLqjM+cBBrNJTXfxNVMUBpw0bmr2hvogkl5WyCxWEfkAQBlr7Nvlen+dCqs7py+e/TKS5pebbVXmMO2KKg9/pV8NyCyKHSkIP54gYq7PYEpBz5BxlqwRRcGuCBzuzy7T0XJI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731342063; c=relaxed/simple;
	bh=GfqOZHoPyLMOe3TrvjRQ3VBO9c4vBbSeNCUI7N4diTo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VIIX70yrxO0cjxXP6lXbzyB+l08fF1aMqArwmkd2TPsXpHCcJO4wlJZsKmfMEJ+c2xvOqZUwBEZOJMgl9qEgIFnuM2jTvBOkbqjxykcYEfHzg0i7mb8htvm9RXMrUS++w+oXgDcnb6y8qI5Cpwhr6dDHrQP3AAIqpp1L2LPqZ6k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hPH7cBOp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A5492C4CEE3;
	Mon, 11 Nov 2024 16:21:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731342062;
	bh=GfqOZHoPyLMOe3TrvjRQ3VBO9c4vBbSeNCUI7N4diTo=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=hPH7cBOpV/0WSzgdkLacMc9djqKB799vXFOejt+DVzx4KyX0VGM8WDsX5Vz9xBG2I
	 nqKki6CBmvBY7hxgqyW5ByFY0/CxRg9Usyhd+730U4gUtbdCalPKuJX/DyIdiGA37f
	 plWo84v7RYNXS5ihGc7+zqQfai5laAsCzxngyZnU4lkFadbCyLnOTeRAOKBzrVm3FM
	 taVFt5DEMApruTmKPSaH+G3dIUOT1qdk+jeUBv5WD9jdxBsgVVo7ZaA4uHjJ8EaJF0
	 GyKlMuTYJ/sFPIe3wCIyuB/xSXjPobMjKiJ4V2UONynvsoHTvnaceNDZta7KRYS4nM
	 OPcJRHFMMasGw==
Received: by mail-yb1-f174.google.com with SMTP id 3f1490d57ef6-e2915f00c12so4536947276.0;
        Mon, 11 Nov 2024 08:21:02 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUr8pZ33HxY+rYZq7lT6El35X1z6iJcYWu3S2bMqVsPBOtU02Ub5fxZf+rJgAVRJ3uncnXIPKmrWWviYtfK@vger.kernel.org, AJvYcCXiPlZPtrqDsjffMXeUmwhIkNbr/CmUbk2H7mi9G2v9BH8Us1RgfjxMCl2OzLU2tm9Ojb5UR8dsgKs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy2u4IRJaM2u2shaAHLFDhQTHv2zY1OJ4YPoWULr1hmBJgYZS8L
	IuNjEfDU73J5q3pYyDb18XA9rTab23JDXAXqCKQJs3JNjitg8/J+TkWXEZKMqIMcZr+ecOlo+DU
	eEnjjuKBOxcSvspmscg6dE7tduQ==
X-Google-Smtp-Source: AGHT+IFkAuK1RKHBxdF4ybGePBRZX8TGIGcGLxePtSshvEbTc34Fms21ng8jvbLerdOHzgIff9cxTqOeul3GUAOFeRE=
X-Received: by 2002:a05:690c:7441:b0:6e2:aceb:fb34 with SMTP id
 00721157ae682-6eaddd72ec1mr118266547b3.1.1731342061623; Mon, 11 Nov 2024
 08:21:01 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241109233821.8619-1-rosenp@gmail.com>
In-Reply-To: <20241109233821.8619-1-rosenp@gmail.com>
From: Rob Herring <robh@kernel.org>
Date: Mon, 11 Nov 2024 10:20:50 -0600
X-Gmail-Original-Message-ID: <CAL_JsqJeYS12OCVeMHze01631NOtj=uaLcEZRiWKPRZLQpSkUA@mail.gmail.com>
Message-ID: <CAL_JsqJeYS12OCVeMHze01631NOtj=uaLcEZRiWKPRZLQpSkUA@mail.gmail.com>
Subject: Re: [PATCH net-next] net: use pdev instead of OF funcs
To: Rosen Penev <rosenp@gmail.com>
Cc: netdev@vger.kernel.org, Marc Kleine-Budde <mkl@pengutronix.de>, 
	Vincent Mailhol <mailhol.vincent@wanadoo.fr>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Florian Fainelli <florian.fainelli@broadcom.com>, Vladimir Oltean <olteanv@gmail.com>, 
	Chen-Yu Tsai <wens@csie.org>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
	Samuel Holland <samuel@sholland.org>, Pantelis Antoniou <pantelis.antoniou@gmail.com>, 
	Marcin Wojtas <marcin.s.wojtas@gmail.com>, Byungho An <bh74.an@samsung.com>, 
	Kevin Brace <kevinbrace@bracecomputerlab.com>, Francois Romieu <romieu@fr.zoreil.com>, 
	Michal Simek <michal.simek@amd.com>, Heiner Kallweit <hkallweit1@gmail.com>, 
	Russell King <linux@armlinux.org.uk>, Zhao Qiang <qiang.zhao@nxp.com>, 
	"open list:CAN NETWORK DRIVERS" <linux-can@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>, 
	"moderated list:ARM/Allwinner sunXi SoC support" <linux-arm-kernel@lists.infradead.org>, 
	"open list:ARM/Allwinner sunXi SoC support" <linux-sunxi@lists.linux.dev>, 
	"open list:FREESCALE SOC FS_ENET DRIVER" <linuxppc-dev@lists.ozlabs.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Nov 9, 2024 at 5:40=E2=80=AFPM Rosen Penev <rosenp@gmail.com> wrote=
:
>
> np here is ofdev->dev.of_node. Better to use the proper functions as
> there's no use of children or anything else.

Your commit message needs some work.

> Signed-off-by: Rosen Penev <rosenp@gmail.com>
> ---
>  drivers/net/can/grcan.c                       |  2 +-
>  drivers/net/can/mscan/mpc5xxx_can.c           |  2 +-
>  drivers/net/dsa/bcm_sf2.c                     |  4 ++--
>  drivers/net/ethernet/allwinner/sun4i-emac.c   |  2 +-
>  drivers/net/ethernet/freescale/fec_mpc52xx.c  | 23 ++++++++++---------
>  .../net/ethernet/freescale/fec_mpc52xx_phy.c  | 12 ++++++----
>  .../net/ethernet/freescale/fs_enet/mac-fcc.c  |  2 +-
>  .../net/ethernet/freescale/fs_enet/mac-fec.c  |  2 +-
>  .../net/ethernet/freescale/fs_enet/mac-scc.c  |  2 +-
>  .../net/ethernet/freescale/fs_enet/mii-fec.c  | 12 ++++++----
>  drivers/net/ethernet/freescale/ucc_geth.c     | 12 +++++-----
>  drivers/net/ethernet/marvell/mvneta.c         |  2 +-
>  drivers/net/ethernet/moxa/moxart_ether.c      |  4 ++--
>  .../ethernet/samsung/sxgbe/sxgbe_platform.c   |  8 +++----
>  drivers/net/ethernet/via/via-rhine.c          |  2 +-
>  drivers/net/ethernet/via/via-velocity.c       |  2 +-
>  drivers/net/ethernet/xilinx/ll_temac_mdio.c   |  6 ++---
>  drivers/net/mdio/mdio-mux-mmioreg.c           | 16 +++++++------
>  drivers/net/wan/fsl_ucc_hdlc.c                | 10 ++++----
>  19 files changed, 66 insertions(+), 59 deletions(-)
>
> diff --git a/drivers/net/can/grcan.c b/drivers/net/can/grcan.c
> index cdf0ec9fa7f3..0a2cc0ba219f 100644
> --- a/drivers/net/can/grcan.c
> +++ b/drivers/net/can/grcan.c
> @@ -1673,7 +1673,7 @@ static int grcan_probe(struct platform_device *ofde=
v)
>                 goto exit_error;
>         }
>
> -       irq =3D irq_of_parse_and_map(np, GRCAN_IRQIX_IRQ);
> +       irq =3D platform_get_irq(ofdev, GRCAN_IRQIX_IRQ);
>         if (!irq) {
>                 dev_err(&ofdev->dev, "no irq found\n");
>                 err =3D -ENODEV;
> diff --git a/drivers/net/can/mscan/mpc5xxx_can.c b/drivers/net/can/mscan/=
mpc5xxx_can.c
> index 0080c39ee182..252ad40bdb97 100644
> --- a/drivers/net/can/mscan/mpc5xxx_can.c
> +++ b/drivers/net/can/mscan/mpc5xxx_can.c
> @@ -300,7 +300,7 @@ static int mpc5xxx_can_probe(struct platform_device *=
ofdev)
>         if (!base)
>                 return dev_err_probe(&ofdev->dev, err, "couldn't ioremap\=
n");
>
> -       irq =3D irq_of_parse_and_map(np, 0);
> +       irq =3D platform_get_irq(ofdev, 0);
>         if (!irq) {
>                 dev_err(&ofdev->dev, "no irq found\n");
>                 err =3D -ENODEV;
> diff --git a/drivers/net/dsa/bcm_sf2.c b/drivers/net/dsa/bcm_sf2.c
> index 43bde1f583ff..9229582efd05 100644
> --- a/drivers/net/dsa/bcm_sf2.c
> +++ b/drivers/net/dsa/bcm_sf2.c
> @@ -1443,8 +1443,8 @@ static int bcm_sf2_sw_probe(struct platform_device =
*pdev)
>                 of_node_put(ports);
>         }
>
> -       priv->irq0 =3D irq_of_parse_and_map(dn, 0);
> -       priv->irq1 =3D irq_of_parse_and_map(dn, 1);
> +       priv->irq0 =3D platform_get_irq(pdev, 0);
> +       priv->irq1 =3D platform_get_irq(pdev, 1);
>
>         base =3D &priv->core;
>         for (i =3D 0; i < BCM_SF2_REGS_NUM; i++) {
> diff --git a/drivers/net/ethernet/allwinner/sun4i-emac.c b/drivers/net/et=
hernet/allwinner/sun4i-emac.c
> index 2f516b950f4e..18df8d1d93fd 100644
> --- a/drivers/net/ethernet/allwinner/sun4i-emac.c
> +++ b/drivers/net/ethernet/allwinner/sun4i-emac.c
> @@ -995,7 +995,7 @@ static int emac_probe(struct platform_device *pdev)
>
>         /* fill in parameters for net-dev structure */
>         ndev->base_addr =3D (unsigned long)db->membase;
> -       ndev->irq =3D irq_of_parse_and_map(np, 0);
> +       ndev->irq =3D platform_get_irq(pdev, 0);
>         if (ndev->irq =3D=3D -ENXIO) {
>                 netdev_err(ndev, "No irq resource\n");
>                 ret =3D ndev->irq;
> diff --git a/drivers/net/ethernet/freescale/fec_mpc52xx.c b/drivers/net/e=
thernet/freescale/fec_mpc52xx.c
> index 2bfaf14f65c8..553d33a98c99 100644
> --- a/drivers/net/ethernet/freescale/fec_mpc52xx.c
> +++ b/drivers/net/ethernet/freescale/fec_mpc52xx.c
> @@ -811,7 +811,7 @@ static int mpc52xx_fec_probe(struct platform_device *=
op)
>         int rv;
>         struct net_device *ndev;
>         struct mpc52xx_fec_priv *priv =3D NULL;
> -       struct resource mem;
> +       struct resource *mem;
>         const u32 *prop;
>         int prop_size;
>         struct device_node *np =3D op->dev.of_node;
> @@ -828,20 +828,21 @@ static int mpc52xx_fec_probe(struct platform_device=
 *op)
>         priv->ndev =3D ndev;
>
>         /* Reserve FEC control zone */
> -       rv =3D of_address_to_resource(np, 0, &mem);
> -       if (rv) {
> +       mem =3D platform_get_resource(op, 0, IORESOURCE_MEM);
> +       if (!mem) {
>                 pr_err("Error while parsing device node resource\n");
> +               rv =3D -ENODEV;
>                 goto err_netdev;
>         }
> -       if (resource_size(&mem) < sizeof(struct mpc52xx_fec)) {
> +       if (resource_size(mem) < sizeof(struct mpc52xx_fec)) {
>                 pr_err("invalid resource size (%lx < %x), check mpc52xx_d=
evices.c\n",
> -                      (unsigned long)resource_size(&mem),
> +                      (unsigned long)resource_size(mem),
>                        sizeof(struct mpc52xx_fec));
>                 rv =3D -EINVAL;
>                 goto err_netdev;
>         }
>
> -       if (!request_mem_region(mem.start, sizeof(struct mpc52xx_fec),
> +       if (!request_mem_region(mem->start, sizeof(struct mpc52xx_fec),
>                                 DRIVER_NAME)) {
>                 rv =3D -EBUSY;
>                 goto err_netdev;
> @@ -851,13 +852,13 @@ static int mpc52xx_fec_probe(struct platform_device=
 *op)
>         ndev->netdev_ops        =3D &mpc52xx_fec_netdev_ops;
>         ndev->ethtool_ops       =3D &mpc52xx_fec_ethtool_ops;
>         ndev->watchdog_timeo    =3D FEC_WATCHDOG_TIMEOUT;
> -       ndev->base_addr         =3D mem.start;
> +       ndev->base_addr         =3D mem->start;
>         SET_NETDEV_DEV(ndev, &op->dev);
>
>         spin_lock_init(&priv->lock);
>
>         /* ioremap the zones */
> -       priv->fec =3D ioremap(mem.start, sizeof(struct mpc52xx_fec));
> +       priv->fec =3D ioremap(mem->start, sizeof(struct mpc52xx_fec));

Generally, devm_platform_ioremap_resource(),
devm_platform_get_and_ioremap_resource(), etc. are preferred. So if
we're going to rework things, rework them to use those.

Rob

