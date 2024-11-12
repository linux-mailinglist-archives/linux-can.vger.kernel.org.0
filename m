Return-Path: <linux-can+bounces-1967-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B5DC79C4D9D
	for <lists+linux-can@lfdr.de>; Tue, 12 Nov 2024 05:10:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7C073282B4C
	for <lists+linux-can@lfdr.de>; Tue, 12 Nov 2024 04:10:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFCB4208223;
	Tue, 12 Nov 2024 04:10:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H4BKgPpq"
X-Original-To: linux-can@vger.kernel.org
Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com [209.85.128.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A1B32076D7;
	Tue, 12 Nov 2024 04:10:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731384617; cv=none; b=f8teym1NUJpg4GZs1RyYPq58RRTZxqW8rfgpWQzj8D63eO4vyLW5fgkVmEs1iA36pSBZHO/OlAktYRAtoKmOcwXtj6JHrJtYnXx9OP2J3uDfJPucJe8wvqb463buN4hTq2w0+NED4wc86HpIrEu7CUKrmYRczBGyNRbEkSAxUXs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731384617; c=relaxed/simple;
	bh=Dh0Rge16au2bgrUgJitkpfwaIhhWpmio6WByFkkHRtI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TCSNLjI4kdbCzF42NHo+yA9JyJcjybDxcWcRRmjd56bBfqFTr9oVIy+7zMuZmcQ412gUV/MM2bj7TTE4wl7en4N+m0ZwggpjbLszKu5hUOEBhX7iFEEpJMdnXnp8KpMmNFXN3XGYEo1CDpO17J7K8xUAT29uT9Z0cY4pQWzBZOQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=H4BKgPpq; arc=none smtp.client-ip=209.85.128.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-6ea85f7f445so51346847b3.0;
        Mon, 11 Nov 2024 20:10:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731384615; x=1731989415; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DsmubN01hyDUEhQ6tv783ePv53ofcUVY2RqcZdf3yEo=;
        b=H4BKgPpqGjAJgJ3kI5rNJgvCMtWFSpE0QxOAiprbBS/3r/seXc2kid/TRioB7ZKyKS
         Q3zJNGd4wl7iHb92Pe52M22CNc2bLID7Xlo+DCdts/vLI3eMHK9L7wFPJSs4zl4ZKtXP
         lBG5zw+fpZhnnyJFhvsjcKGCL9S1op18xogwQ2gDMqKXA2lv8bHds7w+AAIEWRurfISL
         WulZDpXR3zX1KKhkrz8FmPPDt5+eEyy75i2KZKd5WyFE7KdG4leeJ3E02gCaGQ4/WzOw
         6QOMOzsEnF0NBRuvyMIf5bXox5RRw3ZA/Dvak7jz3uOkAhrPyYdux8zo5ZNt5oXo+g5x
         0+0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731384615; x=1731989415;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DsmubN01hyDUEhQ6tv783ePv53ofcUVY2RqcZdf3yEo=;
        b=NpITAByoFtUwKDdzyT8RAq5zhqoo48MCvzm8sZh5PsXf31n47yV6qVoBLfBgml+Eq1
         5iAaBcLLdEXjQG7pw/zl3byA7Eu7h5smWuue4qdWi9xQJRAX37IL+61ouuDQ5AVdU/Cz
         v7reQcS+XDb9k6/inbsheOd1U54gnOIyqKjtArMFxtGuHrvFEqadeYTbp8Pqqt7d9n0e
         pZGN1bAsQ1AXPsgtMd2BkgL2H+FShsjZn5Wi2RNKq66VPY+iRWpWITg/9DfkQS0qdPEG
         FWEvmalqyzG6bgGlUdX1msK8aWtcO012PsU/EpFzBjkL1Xptpb2QH8zio3XUC2hqAtUM
         B36w==
X-Forwarded-Encrypted: i=1; AJvYcCU3FOpgCJNJHiVJRfrfzCM9oMx5cjjzAeUsMi1KOYV9htLxL9fjLjNLQ0bgvcN35itbl8MNV3VF4kUsXQOY@vger.kernel.org, AJvYcCV6+hSiZ8GF71TzIQWKIV6BK8to1iT/Dzt/REWsjXiHYjJ1FvAyK2yYS1Kfey2rAn75MAwhYwR9aDA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxtBB9utSD9dfsZmhFUAmd4P0sYP/zd6oW4dWjkpvX7UKxvGAXT
	ymTNzGeLys9SgAksCshGlrTTjkehp+GCnYp8+mhV/EBSuqp6odHsPaQBjfwMZPo99BcifMQgQdF
	ZhMHrzQYKUNcThRShdv4kY8cGbSmcoiWm
X-Google-Smtp-Source: AGHT+IEEd9e7KYmg9hOChPdcooKIfQet+Ec2imFxx6bP82VRvCibSsbb8ecrhexu0TZ29275WhqN4tjEisNPdXIjqY0=
X-Received: by 2002:a05:690c:6b11:b0:6e2:ab93:8c68 with SMTP id
 00721157ae682-6eadddaf35cmr135388027b3.25.1731384615059; Mon, 11 Nov 2024
 20:10:15 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241111210316.15357-1-rosenp@gmail.com> <20241111193222.00ae2f3e@kernel.org>
In-Reply-To: <20241111193222.00ae2f3e@kernel.org>
From: Rosen Penev <rosenp@gmail.com>
Date: Mon, 11 Nov 2024 20:10:04 -0800
Message-ID: <CAKxU2N-VHmVerombZ77uOHApi0aGBFi46oC1eoGTm5sakCVc4w@mail.gmail.com>
Subject: Re: [PATCHv2 net-next] net: use pdev instead of OF funcs
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, Marc Kleine-Budde <mkl@pengutronix.de>, 
	Vincent Mailhol <mailhol.vincent@wanadoo.fr>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Paolo Abeni <pabeni@redhat.com>, Florian Fainelli <florian.fainelli@broadcom.com>, 
	Vladimir Oltean <olteanv@gmail.com>, Chen-Yu Tsai <wens@csie.org>, 
	Jernej Skrabec <jernej.skrabec@gmail.com>, Samuel Holland <samuel@sholland.org>, 
	Pantelis Antoniou <pantelis.antoniou@gmail.com>, Marcin Wojtas <marcin.s.wojtas@gmail.com>, 
	Byungho An <bh74.an@samsung.com>, Kevin Brace <kevinbrace@bracecomputerlab.com>, 
	Francois Romieu <romieu@fr.zoreil.com>, Michal Simek <michal.simek@amd.com>, 
	Heiner Kallweit <hkallweit1@gmail.com>, Russell King <linux@armlinux.org.uk>, 
	Zhao Qiang <qiang.zhao@nxp.com>, 
	"open list:CAN NETWORK DRIVERS" <linux-can@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>, 
	"moderated list:ARM/Allwinner sunXi SoC support" <linux-arm-kernel@lists.infradead.org>, 
	"open list:ARM/Allwinner sunXi SoC support" <linux-sunxi@lists.linux.dev>, 
	"open list:FREESCALE SOC FS_ENET DRIVER" <linuxppc-dev@lists.ozlabs.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 11, 2024 at 7:32=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> wr=
ote:
>
> On Mon, 11 Nov 2024 13:03:16 -0800 Rosen Penev wrote:
> > --- a/drivers/net/ethernet/samsung/sxgbe/sxgbe_platform.c
> > +++ b/drivers/net/ethernet/samsung/sxgbe/sxgbe_platform.c
> > @@ -111,7 +111,7 @@ static int sxgbe_platform_probe(struct platform_dev=
ice *pdev)
> >       }
> >
> >       /* Get the SXGBE common INT information */
> > -     priv->irq  =3D irq_of_parse_and_map(node, 0);
> > +     priv->irq =3D platform_get_irq(pdev, 0);
> >       if (priv->irq <=3D 0) {
> >               dev_err(dev, "sxgbe common irq parsing failed\n");
> >               goto err_drv_remove;
> > @@ -122,7 +122,7 @@ static int sxgbe_platform_probe(struct platform_dev=
ice *pdev)
> >
> >       /* Get the TX/RX IRQ numbers */
> >       for (i =3D 0, chan =3D 1; i < SXGBE_TX_QUEUES; i++) {
> > -             priv->txq[i]->irq_no =3D irq_of_parse_and_map(node, chan+=
+);
> > +             priv->txq[i]->irq_no =3D platform_get_irq(pdev, chan++);
> >               if (priv->txq[i]->irq_no <=3D 0) {
> >                       dev_err(dev, "sxgbe tx irq parsing failed\n");
> >                       goto err_tx_irq_unmap;
> > @@ -130,14 +130,14 @@ static int sxgbe_platform_probe(struct platform_d=
evice *pdev)
> >       }
> >
> >       for (i =3D 0; i < SXGBE_RX_QUEUES; i++) {
> > -             priv->rxq[i]->irq_no =3D irq_of_parse_and_map(node, chan+=
+);
> > +             priv->rxq[i]->irq_no =3D platform_get_irq(pdev, chan++);
> >               if (priv->rxq[i]->irq_no <=3D 0) {
> >                       dev_err(dev, "sxgbe rx irq parsing failed\n");
> >                       goto err_rx_irq_unmap;
> >               }
> >       }
> >
> > -     priv->lpi_irq =3D irq_of_parse_and_map(node, chan);
> > +     priv->lpi_irq =3D platform_get_irq(pdev, chan);
> >       if (priv->lpi_irq <=3D 0) {
> >               dev_err(dev, "sxgbe lpi irq parsing failed\n");
> >               goto err_rx_irq_unmap;
>
> Coccicheck wants you to drop the errors:
>
> drivers/net/ethernet/samsung/sxgbe/sxgbe_platform.c:116:2-9: line 116 is =
redundant because platform_get_irq() already prints an error
> drivers/net/ethernet/samsung/sxgbe/sxgbe_platform.c:127:3-10: line 127 is=
 redundant because platform_get_irq() already prints an error
> drivers/net/ethernet/samsung/sxgbe/sxgbe_platform.c:135:3-10: line 135 is=
 redundant because platform_get_irq() already prints an error
> drivers/net/ethernet/samsung/sxgbe/sxgbe_platform.c:142:2-9: line 142 is =
redundant because platform_get_irq() already prints an error

I looked at the output. The error checks need changing too.

>
> You can make it a separate patch in a series, for clarity.
I don't think it's enough to warrant its own commit.
> --
> pw-bot: cr

