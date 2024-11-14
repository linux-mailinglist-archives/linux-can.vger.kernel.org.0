Return-Path: <linux-can+bounces-2063-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CF7D9C949C
	for <lists+linux-can@lfdr.de>; Thu, 14 Nov 2024 22:37:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DA1D7B22AF9
	for <lists+linux-can@lfdr.de>; Thu, 14 Nov 2024 21:37:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 690351ACDED;
	Thu, 14 Nov 2024 21:37:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Im9JKNkz"
X-Original-To: linux-can@vger.kernel.org
Received: from mail-yb1-f176.google.com (mail-yb1-f176.google.com [209.85.219.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0A282905;
	Thu, 14 Nov 2024 21:37:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731620262; cv=none; b=NjVl/7XEb3p1Mo66FtxOx6FQNmOCF4S/sn9c7sdyalDjFvF0gpb8z2MUcfCvYe8P8ChZgPeuivY9kEz+UbFesfevw42PEafmqOKIVJdir+RsghQ+TuWHfgPiLGjliNpyFow3FxKdsHWpcN+UO6j+XUgBGOqNA1Cx6H121xNwNUo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731620262; c=relaxed/simple;
	bh=9l7vFoEaDohyshh1ZdsoPPTLdeVwWUPMY+VXG9RZlZk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pgBG7Yh/4R/8eMIorcAmMCfCUiv8ys+xS41jTvtgZeA72xM73s88z+upT2/gTHof3yu9DFpyMIVTF6P7EFOral+kMt5EljLKOsP8MwnTL8lMxL9c+9vBVG7xY2UA75ZW9omIJIA3312BpzaD8dLhv8GPOP8SMT4cMPj1rKF5iac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Im9JKNkz; arc=none smtp.client-ip=209.85.219.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f176.google.com with SMTP id 3f1490d57ef6-e381638b61fso1004090276.0;
        Thu, 14 Nov 2024 13:37:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731620260; x=1732225060; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8HDQDZl5XK73PdEK03DrAUphRsdHCJGw/Puu2rwoRqo=;
        b=Im9JKNkzfueazw+suLAqIyN/aQnzaB50ySOsr9PlzXNZfq2UwCzpwEhdzRNqDfztHA
         wY2yq9P/B2EKDXFHegwiJilbH5F8kMejZr6y1tcsQvL4iVPeATsOLtKnsoWE4oit/cSe
         qrMqND4GjCMNyZ3EShFeDQoq+5yWyyy9ybCqCV+25lX0zgRrDrdPiOI7sDnFtc56PqCM
         KcVJdbzZtRwy3ErmAt1ZjY+kD295jHV0+phmO5XdzxGFrGvOPKNT+jTrQ95f/xMq+8Ay
         ze/AHN/cSXVZQFtb6GvKXwfKXrTUV+H05ig6pv7LC3eW6ESxkiBEQ+OZY3eoKqFhrzGc
         +m/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731620260; x=1732225060;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8HDQDZl5XK73PdEK03DrAUphRsdHCJGw/Puu2rwoRqo=;
        b=n3/bVOSVk+l1DDylpgpkTLEXNchj7KwlxhcXwVSfCGcPO+ucjHslmuaA7kw3Zp1SAP
         3jNo3e2ONAwFRrC9LEMLM18YLOH2AOJkUuF6rNSD91neXdQo5Svm/gDj/k0e7Bt1Nut7
         Doj/k8/f9KywtWEFc5q7B2Au22a47n0l1NORG8P534SXLcgZdIjC+QVWHUmWoFKSlUrp
         WRaWECRNKYmADdKKdtQO1hxzvSvL7cWhhftxwnmIGvUiYgnWtjsuFtxQ0YGkwYL4pvlE
         hxg1NvgsdYVttzBLaS2cDw71eM/FVjBk/9nqCKLWGLw+ZGlOMp37b02Hfd1byAEWIJB7
         Wt9Q==
X-Forwarded-Encrypted: i=1; AJvYcCWPeAmiuEqb3YZRj3RlWfQDG7FFkCjpfxu6J4etBwJDoWLdrPrgvE/CsA8+u3pIZwRmnW+jLwuG80Q=@vger.kernel.org, AJvYcCWwjph0PwxfBi1Xl4HNwmrKeueR5w9utcUf3M0PEa9oB+8gcf4nPFBO4sgSYJm86UBsChx5lvNkGlUQL7IyqH03HpQ=@vger.kernel.org, AJvYcCXZeNLvofx7uaTVcT5LaENX+ytD/j+c1Nyux8c7NDLjZQFKueN+bYPB2j2CFPvDuTpayK9MVrUQ4nUPmA2P@vger.kernel.org
X-Gm-Message-State: AOJu0YwbwKd64lnsyXCREgJYzvD7/ysLvrzpPn82XRhkwU7ug44u3Npf
	B63i3LYMnKIzv9scOQGId2gIuqAJjgjCfN0ev/dJzh3ceuf1PoIQLe6cOGG/0ZU9XjdGzbx1lqF
	NzXCobxYiGI9c/t5ln9Cn1M/rOOA=
X-Google-Smtp-Source: AGHT+IHmxKbrSWeNFNu3gSJW7/OVf6TAEd7ZES/6OudmTDW3jTbNwCmAw0PQX7uPWCMR0Z6u2Q8yItH7rzkZaXpSLAY=
X-Received: by 2002:a05:690c:7407:b0:6de:c0e:20ef with SMTP id
 00721157ae682-6ee55bbae5cmr6021867b3.7.1731620259669; Thu, 14 Nov 2024
 13:37:39 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241111200212.5907-1-rosenp@gmail.com> <20241114110745.h6luzb72zkahyr5j@DEN-DL-M31836.microchip.com>
In-Reply-To: <20241114110745.h6luzb72zkahyr5j@DEN-DL-M31836.microchip.com>
From: Rosen Penev <rosenp@gmail.com>
Date: Thu, 14 Nov 2024 13:37:28 -0800
Message-ID: <CAKxU2N9ssJS_1KApvXKFq67yw8uSkKVAD1erKPT05Wg172mnbA@mail.gmail.com>
Subject: Re: [PATCHv2 net-next] net: modernize ioremap in probe
To: Horatiu Vultur <horatiu.vultur@microchip.com>
Cc: netdev@vger.kernel.org, Chandrasekar Ramakrishnan <rcsekar@samsung.com>, 
	Marc Kleine-Budde <mkl@pengutronix.de>, Vincent Mailhol <mailhol.vincent@wanadoo.fr>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Kurt Kanzenbach <kurt@linutronix.de>, Vladimir Oltean <olteanv@gmail.com>, 
	Chris Snook <chris.snook@gmail.com>, Marcin Wojtas <marcin.s.wojtas@gmail.com>, 
	Russell King <linux@armlinux.org.uk>, 
	"maintainer:MICROCHIP LAN966X ETHERNET DRIVER" <UNGLinuxDriver@microchip.com>, 
	Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>, 
	=?UTF-8?Q?Niklas_S=C3=B6derlund?= <niklas.soderlund@ragnatech.se>, 
	Doug Berger <opendmb@gmail.com>, Florian Fainelli <florian.fainelli@broadcom.com>, 
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, 
	Heiner Kallweit <hkallweit1@gmail.com>, Richard Cochran <richardcochran@gmail.com>, 
	"open list:MCAN MMIO DEVICE DRIVER" <linux-can@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>, 
	"open list:RENESAS ETHERNET SWITCH DRIVER" <linux-renesas-soc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 14, 2024 at 3:10=E2=80=AFAM Horatiu Vultur
<horatiu.vultur@microchip.com> wrote:
>
> The 11/11/2024 12:02, Rosen Penev wrote:
>
> Hi Rosen,
>
> > diff --git a/drivers/net/ethernet/microchip/lan966x/lan966x_main.c b/dr=
ivers/net/ethernet/microchip/lan966x/lan966x_main.c
> > index 3234a960fcc3..375e9a68b9a9 100644
> > --- a/drivers/net/ethernet/microchip/lan966x/lan966x_main.c
> > +++ b/drivers/net/ethernet/microchip/lan966x/lan966x_main.c
> > @@ -77,20 +77,12 @@ static int lan966x_create_targets(struct platform_d=
evice *pdev,
> >          * this.
> >          */
> >         for (idx =3D 0; idx < IO_RANGES; idx++) {
> > -               iores[idx] =3D platform_get_resource(pdev, IORESOURCE_M=
EM,
> > -                                                  idx);
> > -               if (!iores[idx]) {
> > -                       dev_err(&pdev->dev, "Invalid resource\n");
> > -                       return -EINVAL;
> > -               }
> > -
> > -               begin[idx] =3D devm_ioremap(&pdev->dev,
> > -                                         iores[idx]->start,
> > -                                         resource_size(iores[idx]));
> > -               if (!begin[idx]) {
> > +               begin[idx] =3D devm_platform_get_and_ioremap_resource(
> > +                       pdev, idx, &iores[idx]);
> > +               if (IS_ERR(begin[idx])) {
> >                         dev_err(&pdev->dev, "Unable to get registers: %=
s\n",
> >                                 iores[idx]->name);
> > -                       return -ENOMEM;
> > +                       return PTR_ERR(begin[idx]);
> >                 }
> >         }
> >
>
> Unfortunately, this breaks the lan966x probe. With this change I get the
> following errors:
> [    1.705315] lan966x-switch e0000000.switch: can't request region for r=
esource [mem 0xe0000000-0xe00fffff]
> [    1.714911] lan966x-switch e0000000.switch: Unable to get registers: c=
pu
> [    1.721607] lan966x-switch e0000000.switch: error -EBUSY: Failed to cr=
eate targets
> [    1.729173] lan966x-switch: probe of e0000000.switch failed with error=
 -16
>
Yes, also causes problems with another platform.

This commit should be abandoned.
> --
> /Horatiu

