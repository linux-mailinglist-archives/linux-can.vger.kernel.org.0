Return-Path: <linux-can+bounces-2013-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 831D19C6BEA
	for <lists+linux-can@lfdr.de>; Wed, 13 Nov 2024 10:50:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1C1EC2812A7
	for <lists+linux-can@lfdr.de>; Wed, 13 Nov 2024 09:50:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BACDC1F942E;
	Wed, 13 Nov 2024 09:48:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GxhMy+G2"
X-Original-To: linux-can@vger.kernel.org
Received: from mail-qv1-f43.google.com (mail-qv1-f43.google.com [209.85.219.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FE691F8EE0;
	Wed, 13 Nov 2024 09:48:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731491319; cv=none; b=f8B9T4QeIBewFF3A1dLqmnEgLeSdJP+fkv8YqO/8txgkeF1QYLoTwk9AOWnCCPcGu/xKbhy1eYczhFUo2+xBq45eG+c9arClo0Krb1l+vfoxeDEbZaaDXqxtyExI08w/9W7tHBdSlcQnl4GhV0M/Gw5u0ZNujes13nj2mT2CIoY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731491319; c=relaxed/simple;
	bh=ks90hqffQrT0BE2v4o9sOT2myXod5HsJJ8zUteV+gKw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=K1xlrCZdPbyJU8tAWWlIb/ZhZZF2Lrf4MT+c5MRGczffU2H0nolIG3t9nEW1pYN2OWmVqcruwXKaR6m1lEOsEdI+yL7vn+j0nbD7DE7nryJeY6CXdl/e8gtAXa2DZFitbOeANieJk8pUchC3+q486W/lict05J0lGjVWAy/QytA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GxhMy+G2; arc=none smtp.client-ip=209.85.219.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f43.google.com with SMTP id 6a1803df08f44-6cbcc2bd800so4951406d6.0;
        Wed, 13 Nov 2024 01:48:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731491317; x=1732096117; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XaSnfzm/t5DivDcI8TYnD0ZfKr8uwA2J8rw6CZWmB2k=;
        b=GxhMy+G2e7m9E9ytfeJJ2FRRKn+k4bJAGKLETXozgLmocakpkFT5uyuDtnI9Cae28w
         lxZarTXvw/JeT9JP0M5fqpeVyv2dyL8yEBN8OKjhZjHkObsMdTMzbi8kQyxCBelYHJ8u
         Z7+SvCoez3MuBHDd/Z7LpIOHmHuvn0LXVVea9JQk7L6MKeqM5ziHDJtpTUV9ycGifhiN
         0palZwvpiTGnMMZDZ+449vKiB2hmFDKUYs4huMMT4C2m0ED9WBVYbaLtiMkFpYnjfdDc
         lV56rInoCSoa4kG1AAWSSHYdrD/wx3wf8LCcf6y71O8t+jAMidGhF5gVVE8Q0F+Q6SFE
         UzyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731491317; x=1732096117;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XaSnfzm/t5DivDcI8TYnD0ZfKr8uwA2J8rw6CZWmB2k=;
        b=Ae6HJRla1DsHSvj0RxQBzBONZ4NyPWv+J1K5+7e5u7OELlCw02fgRBWQrA+isu2nzv
         obz32OadNftrJqGDwSp6h+5JVw0OmsbL5dR6awBF/0LJccxAI0EQ8Am/w0jkHfpzZGz3
         UtRCxY3u4Wv6poitir/ZpQUUBxXhVnNyK+vKbOQr8Tqt83fkACGglVYFB+8QWOjiD2pd
         sAb7SJ7ZQMWQc6ZoWWT2SvnHl+eVddpqMeQsoj34iB8fWzz7l/uP4ZQMNIMxgbON396j
         tS+2oRow72YPbrRoo9eaqEfAUGTN610Nc6VLC0TERDRA56EE7zx+qyUyMGbgLTDVnaf/
         dhfA==
X-Forwarded-Encrypted: i=1; AJvYcCWMYpJqTV1XmAfLCswE6kxtRRwUuiPWrhXnrB78QSbAUNRbVnxo1ja7k49dSuEjDIX080uawWEVg3I=@vger.kernel.org, AJvYcCWeUu/96Pd+X4nzduKCWJu721eujbaFlArZiEjXB8UKWt0mrL0w9yrAjbmo2sWHHStKAfTOUWRftP3b3sui@vger.kernel.org
X-Gm-Message-State: AOJu0YzG+7NqEzELHHz+fHi7RhQQxDwGWda7ZBXTnfCq304R9SFAs+ra
	UVKUH1ARhi69QZUONQaBuyNEm3EUSo/XSyvybNDKyd4Dzu1aFSGiqOoMe5vc5WPlnznPug4ylkS
	W4pY+ao3ImnAAjAf7c3oxtzbcJnE=
X-Google-Smtp-Source: AGHT+IHcLy8AEacbQGHGgfaEwyTub+t1gLTfFsAT9DwCgvxu+gX32+4tA6aRof7gwejihIaPx+ov6qt1kZkNWsKHlks=
X-Received: by 2002:ad4:5d49:0:b0:6d3:5be3:e711 with SMTP id
 6a1803df08f44-6d39d57c179mr302997596d6.9.1731491316900; Wed, 13 Nov 2024
 01:48:36 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241112211442.7205-1-rosenp@gmail.com>
In-Reply-To: <20241112211442.7205-1-rosenp@gmail.com>
From: Julian Calaby <julian.calaby@gmail.com>
Date: Wed, 13 Nov 2024 20:48:24 +1100
Message-ID: <CAGRGNgXhtPy_G9O0n7dEhcAX3sWN=08tF9tgFpLs8V---uELYg@mail.gmail.com>
Subject: Re: [PATCHv3 net-next] net: modernize IRQ resource acquisition
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

Hi Rosen,

On Wed, Nov 13, 2024 at 8:14=E2=80=AFAM Rosen Penev <rosenp@gmail.com> wrot=
e:
>
> In probe, np =3D=3D pdev->dev.of_node. It's easier to pass pdev directly.
>
> Replace irq_of_parse_and_map() by platform_get_irq() to do so. Requires
> removing the error message as well as fixing the return type.
>
> Replace of_address_to_resource() with platform_get_resource() for the
> same reason.

Sorry for the drive-by review, but I have to question the utility of
this conversion.

> diff --git a/drivers/net/can/grcan.c b/drivers/net/can/grcan.c
> index cdf0ec9fa7f3..48e93c3445e7 100644
> --- a/drivers/net/can/grcan.c
> +++ b/drivers/net/can/grcan.c
> @@ -1673,9 +1673,8 @@ static int grcan_probe(struct platform_device *ofde=
v)
>                 goto exit_error;
>         }
>
> -       irq =3D irq_of_parse_and_map(np, GRCAN_IRQIX_IRQ);
> -       if (!irq) {
> -               dev_err(&ofdev->dev, "no irq found\n");
> +       irq =3D platform_get_irq(ofdev, GRCAN_IRQIX_IRQ);
> +       if (irq < 0) {

In this change and a lot of the others, you're not removing the "np"
variable, so you're basically replacing one wrapper with another.

>                 err =3D -ENODEV;
>                 goto exit_error;
>         }
> diff --git a/drivers/net/ethernet/freescale/fs_enet/mac-fcc.c b/drivers/n=
et/ethernet/freescale/fs_enet/mac-fcc.c
> index be63293511d9..9006137e3a55 100644
> --- a/drivers/net/ethernet/freescale/fs_enet/mac-fcc.c
> +++ b/drivers/net/ethernet/freescale/fs_enet/mac-fcc.c
> @@ -83,8 +83,8 @@ static int do_pd_setup(struct fs_enet_private *fep)
>         struct fs_platform_info *fpi =3D fep->fpi;
>         int ret =3D -EINVAL;
>
> -       fep->interrupt =3D irq_of_parse_and_map(ofdev->dev.of_node, 0);
> -       if (!fep->interrupt)
> +       fep->interrupt =3D platform_get_irq(ofdev, 0);
> +       if (fep->interrupt < 0)

This one and others like it are fine: it's much cleaner to use the
"platform_irq()" function instead of reaching deep into the structure
to grab the "of_node" property.

That said, in this case and probably a few others this is a driver for
an OF device so I'm still not sure this actually makes sense.

Thanks,

--=20
Julian Calaby

Email: julian.calaby@gmail.com
Profile: http://www.google.com/profiles/julian.calaby/

