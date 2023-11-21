Return-Path: <linux-can+bounces-40-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E6E7F7F3199
	for <lists+linux-can@lfdr.de>; Tue, 21 Nov 2023 15:51:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DB830B21D58
	for <lists+linux-can@lfdr.de>; Tue, 21 Nov 2023 14:51:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F59B2772A;
	Tue, 21 Nov 2023 14:51:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fZao+fKC"
X-Original-To: linux-can@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F3B55392;
	Tue, 21 Nov 2023 14:51:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF260C433D9;
	Tue, 21 Nov 2023 14:51:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1700578267;
	bh=0Hzbhezg3LEYvk3jV45ChdxYUsSKEP9VDFl59KpQ+cU=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=fZao+fKCi30D2OU8mkp2CSBObry/17OOuVNUgwlfsTKUlut1qgNQY0AzOoujvrPE+
	 OpfDJuhCJMtkMquBMoNPtcugiX2F2MbHjrxXPsHUsF/Q+HJRUDfGj6Icj8cBR81Owf
	 i14mUHT+faWDLif9ZnKlpe0Ov1VZQpGWG+0dBbk1d6tTylKII4TwX4Ckw+0JpGV/JP
	 HW4Gxe2YCDjZduQmG4nl7UsiDWS1rQRsSBRV8Crt3qEPfRIeRoz89HoIwE54fwi1k2
	 sS17uQEWs3lmSd4xCWaQMVKn+4mxnSBtWm4B8znU5Nm/PMRy3o8z2FcsbZyvO21EVB
	 a51o0Ev8BST+Q==
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-507a5f2193bso5831580e87.1;
        Tue, 21 Nov 2023 06:51:06 -0800 (PST)
X-Gm-Message-State: AOJu0Yx6w5wNfrxxNuYEul6zhV0vv1rdECmR4HuagY2PULVBBqa156cs
	wqeY4HTBHW65jrxY5rqdk5MDB4nbtEwOSyJLCQ==
X-Google-Smtp-Source: AGHT+IHAgECyxRGZoAUk3nMcJ8/f2p6QZjyOKysSbNWX5YzA0p6881GhJQrwodpOCv5t41nc17DnYHwCQ59f76jZIn8=
X-Received: by 2002:a05:6512:1106:b0:50a:7648:349f with SMTP id
 l6-20020a056512110600b0050a7648349fmr1142319lfg.10.1700578265105; Tue, 21 Nov
 2023 06:51:05 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231115210129.3739377-1-robh@kernel.org> <20231116182923.GH109951@vergenet.net>
In-Reply-To: <20231116182923.GH109951@vergenet.net>
From: Rob Herring <robh@kernel.org>
Date: Tue, 21 Nov 2023 07:50:52 -0700
X-Gmail-Original-Message-ID: <CAL_JsqJp=H-O=nkL=f_G=stYOL=1FP=u8w8W+hNor5Zvt+6OrA@mail.gmail.com>
Message-ID: <CAL_JsqJp=H-O=nkL=f_G=stYOL=1FP=u8w8W+hNor5Zvt+6OrA@mail.gmail.com>
Subject: Re: [RESEND PATCH] net: can: Use device_get_match_data()
To: Simon Horman <horms@kernel.org>
Cc: Wolfgang Grandegger <wg@grandegger.com>, Marc Kleine-Budde <mkl@pengutronix.de>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Appana Durga Kedareswara rao <appana.durga.rao@xilinx.com>, 
	Naga Sureshkumar Relli <naga.sureshkumar.relli@xilinx.com>, Michal Simek <michal.simek@amd.com>, 
	linux-can@vger.kernel.org, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 16, 2023 at 11:29=E2=80=AFAM Simon Horman <horms@kernel.org> wr=
ote:
>
> On Wed, Nov 15, 2023 at 03:01:28PM -0600, Rob Herring wrote:
> > Use preferred device_get_match_data() instead of of_match_device() to
> > get the driver match data. With this, adjust the includes to explicitly
> > include the correct headers.
> >
> > Signed-off-by: Rob Herring <robh@kernel.org>
>
> ...
>
> > diff --git a/drivers/net/can/xilinx_can.c b/drivers/net/can/xilinx_can.=
c
> > index abe58f103043..f17fd43d03c0 100644
> > --- a/drivers/net/can/xilinx_can.c
> > +++ b/drivers/net/can/xilinx_can.c
> > @@ -20,8 +20,8 @@
> >  #include <linux/module.h>
> >  #include <linux/netdevice.h>
> >  #include <linux/of.h>
> > -#include <linux/of_device.h>
> >  #include <linux/platform_device.h>
> > +#include <linux/property.h>
> >  #include <linux/skbuff.h>
> >  #include <linux/spinlock.h>
> >  #include <linux/string.h>
> > @@ -1726,7 +1726,6 @@ static int xcan_probe(struct platform_device *pde=
v)
> >       struct net_device *ndev;
> >       struct xcan_priv *priv;
> >       struct phy *transceiver;
> > -     const struct of_device_id *of_id;
> >       const struct xcan_devtype_data *devtype =3D &xcan_axi_data;
>
> Hi Rob,
>
> Here devtype is initialised.
>
> >       void __iomem *addr;
> >       int ret;
> > @@ -1741,9 +1740,7 @@ static int xcan_probe(struct platform_device *pde=
v)
> >               goto err;
> >       }
> >
> > -     of_id =3D of_match_device(xcan_of_match, &pdev->dev);
> > -     if (of_id && of_id->data)
> > -             devtype =3D of_id->data;
>
> And in the old code devtype was conditionally re-initialised here,
> if a match with data was found.
>
> But in the new code devtype is re-initialised unconditionally.
>
> Possibly I am missing something obvious, but it seems that either this
> should somehow be made conditional, or the initialisation to &xcan_axi_da=
ta
> should be dropped.

of_match_device() would never fail because we only match with DT for
this driver and if we didn't match, we wouldn't be in probe. So I'll
drop the initialization.

Rob

