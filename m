Return-Path: <linux-can+bounces-4816-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DEC1AB91B60
	for <lists+linux-can@lfdr.de>; Mon, 22 Sep 2025 16:29:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 078A23B477E
	for <lists+linux-can@lfdr.de>; Mon, 22 Sep 2025 14:29:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6D1E224AF2;
	Mon, 22 Sep 2025 14:29:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="y6X4OPhs"
X-Original-To: linux-can@vger.kernel.org
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E713B229B16
	for <linux-can@vger.kernel.org>; Mon, 22 Sep 2025 14:29:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758551351; cv=none; b=lnVwMv4p021ZLqIu1+QUAw6vrA3Qf50tjzzsVOp/zBzFqib3I4VgbculOKqNOkjTBYySj5Ry1m1cTGA9OaAKBSE/CO01XKQecqv7Ce4j5lEZSaeKfX9rW8aT0ctyy2gsPitwaGLGIkXN1U1N0+XZJPVDDjN92GlR7LC/h+1PpI4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758551351; c=relaxed/simple;
	bh=b2ezm2CLNj8YPp+R11hW7QBb2waAeV16fpTYLUG0zgI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lbI9FDzkJl6b1QWvdqaVLAr6EsI9YNZSWLQ4KU593abab2mnLj+smSyfx4Vu/hdg4ALJDbLsEl+7g3+gKwJVFSTN5PAPmlDpi89xQ1TNbxX2y1/AG05KWpUWSyY3sBweda3tsZHhXiXehNak3DwOg78ETl0OZgMTaqxbPHa90sI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=y6X4OPhs; arc=none smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-57933d3e498so4768612e87.3
        for <linux-can@vger.kernel.org>; Mon, 22 Sep 2025 07:29:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1758551345; x=1759156145; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=A4q66f+/NkdHqkcY42mBK6VQLve99lj7NTw37nKoPuE=;
        b=y6X4OPhsdKzB/wG8eZ8UepKcFaWqGcwlqQU5FyiyyIds0ZYih80dd1gN3q2ybmSNWk
         4kBvsIAK5H4vpeiPjvz78SYOm51Ta2TCrSe7rfrSN1HxGCvjLwjidQ+wBgcwyYdasCVN
         iFDxBdG5ZdCd9N0D0oECcQfAsKUTJHQz7a6KqWTlziuO/octo2UiEvVmCxSnA0aaDuje
         mvkK1B/Br3KclkJ210W1sc2e8NzxQNZDcdOke7sZsD1zjtCpws9HuznkulSDbD/er6kZ
         +x+hSYl65CuCJVqIKdnfTt9GDVIujIidxt7htc1InOPxPLkapaE9Bl5hl8tDjPrn8FM8
         4fqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758551345; x=1759156145;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=A4q66f+/NkdHqkcY42mBK6VQLve99lj7NTw37nKoPuE=;
        b=IKYi8sExWX87sVWqj3Hx3DQgEM7Tf3V2chePDcQeRVQTAo6GCdjjnnlmpqi+vMJlq1
         8WervmJ5w/5JLHGHnJzyDP21elmdoASscUTL7M0RxM7wHAnPEzxuO0PEXSWqlQinal5Z
         /cl1/tt1lIYdcqJZqQfZ32vAbmAshYftzpWdUoMkOu2BlLYjiOP6CMb01bnLHJ2jLFv7
         9rR+EUuLblB1lqSLpZUa7vE6Z4qfz9ARFhRFi5VBiQo2h0NNMP6cgIyNJxgYsnIMdN17
         pWpHnmJfjKCu9IM+bj+Gij+0ARiR1qjC3yRBOcWSdHkGmlMRYn0KObHSY+Am8KoY6gfx
         PyuQ==
X-Forwarded-Encrypted: i=1; AJvYcCXVi8D6JrHZVFbfjGe3c1JkXktCWdym/pclusx6oyhiqntxXTt0XAWxdxoYGYbt2xWvZmB6twbuWoA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwMhdnjFKdZ376NQz6ksjAcGy/dDe7tmrPVQFq6Cy62LRDyeeeR
	u17S+Ra4WfLm2lpOJZZRLfhbDRSWy7WMkXcjQmmQsDRRDjdPHVQiAmmcEu1Z8dIxPZiMDC0SXsm
	zQXAYVMTiXfEu2xpgPhT/ZnXQVSVK6urftZ/BhrXwAg==
X-Gm-Gg: ASbGncvUFFo2pDCdNi8h159xGWYESQuYVR4gAueQqlKdpN9z4lINwYZbGYitssHRhzA
	Wf+uOkmKLUJIcQ/0AhSn+sf/GQfd2kxW25EQOlB4a2VOPnDspCdrREjaoUZQvKYO1/fs/ASUJ+/
	a3dETCt94cH/0f1bM6gxD+zIV9hwnydeAaExu7WawY5f6HtXojkbfkYdUs/40IT1pPg1zKDRgSd
	ULEHCI+aCKwvkYjU6MGFwkL9NWJFzurtPNNtw==
X-Google-Smtp-Source: AGHT+IE1ar7tRHkG4IUK8LMV42jr5T2FKxk9T43MX0AQD8U2dE0IgRxVKZnyx4o4hhViPedEpA2DSrOYdFPIg3vPB/Y=
X-Received: by 2002:a05:6512:61af:b0:57d:6fca:f208 with SMTP id
 2adb3069b0e04-57d6fcaf54fmr2095526e87.45.1758551345084; Mon, 22 Sep 2025
 07:29:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250918064903.241372-1-viken.dadhaniya@oss.qualcomm.com>
 <20250918064903.241372-6-viken.dadhaniya@oss.qualcomm.com>
 <CAMRc=Mf2ycyKbL35bdy5m1WBEap7Bu8OO2Q9AdZYgc04Uynf8g@mail.gmail.com> <20250918-daffy-steady-griffin-5299ac-mkl@pengutronix.de>
In-Reply-To: <20250918-daffy-steady-griffin-5299ac-mkl@pengutronix.de>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Mon, 22 Sep 2025 16:28:53 +0200
X-Gm-Features: AS18NWBCrzmRTOZ0yZcaH0SVMve1h4lSlOaxa3VVIQ-5wTmn4Svt6EZzx0jdPYY
Message-ID: <CAMRc=Mfypwopu6daCBzg90i98dbO-7rwAehkiNkA-tF074fO5w@mail.gmail.com>
Subject: Re: [PATCH v4 5/6] can: mcp251xfd: add gpio functionality
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>, mukesh.savaliya@oss.qualcomm.com, 
	anup.kulkarni@oss.qualcomm.com, 
	Gregor Herburger <gregor.herburger@ew.tq-group.com>, mani@kernel.org, 
	thomas.kopp@microchip.com, mailhol.vincent@wanadoo.fr, robh@kernel.org, 
	krzk+dt@kernel.org, conor+dt@kernel.org, linus.walleij@linaro.org, 
	linux-can@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 18, 2025 at 12:58=E2=80=AFPM Marc Kleine-Budde <mkl@pengutronix=
.de> wrote:
>
> On 18.09.2025 05:46:44, Bartosz Golaszewski wrote:
> > > diff --git a/drivers/net/can/spi/mcp251xfd/mcp251xfd-core.c b/drivers=
/net/can/spi/mcp251xfd/mcp251xfd-core.c
> > > index ea41f04ae1a6..8c253091f498 100644
> > > --- a/drivers/net/can/spi/mcp251xfd/mcp251xfd-core.c
> > > +++ b/drivers/net/can/spi/mcp251xfd/mcp251xfd-core.c
> > > @@ -16,6 +16,7 @@
> > >  #include <linux/bitfield.h>
> > >  #include <linux/clk.h>
> > >  #include <linux/device.h>
> > > +#include <linux/gpio/driver.h>
> > >  #include <linux/mod_devicetable.h>
> > >  #include <linux/module.h>
> > >  #include <linux/pm_runtime.h>
> > > @@ -1797,6 +1798,178 @@ static int mcp251xfd_register_check_rx_int(st=
ruct mcp251xfd_priv *priv)
> > >     return 0;
> > >  }
> > >
> > > +#ifdef CONFIG_GPIOLIB
> >
> > Any reason why you don't just depend on GPIOLIB in Kconfig? There's no
> > reason to make it optional if the device always has the GPIO pins.
>
> I don't mind having the ifdef. But it's up to you.
>
> [...]
>
> > > +static void mcp251xfd_gpio_set(struct gpio_chip *chip, unsigned int =
offset,
> > > +                          int value)
> >
> > You must be rebased on pre v6.17 code, this will not compile with curre=
nt
> > mainline.
>
> You mean "post" v6.17? Best rebase to latest net-next/main, which
> already contains the new signatures for the GPIO callbacks.
>

No, you read that right. The signature of the set() and set_multiple()
callbacks changed in v6.17-rc1 so Viken must have rebased his changes
on v6.16 or earlier.

Bartosz

