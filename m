Return-Path: <linux-can+bounces-4245-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 264B0B26570
	for <lists+linux-can@lfdr.de>; Thu, 14 Aug 2025 14:34:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7559316836D
	for <lists+linux-can@lfdr.de>; Thu, 14 Aug 2025 12:33:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95BCA2EA160;
	Thu, 14 Aug 2025 12:33:06 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from mail-ua1-f52.google.com (mail-ua1-f52.google.com [209.85.222.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A47021E868;
	Thu, 14 Aug 2025 12:33:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755174786; cv=none; b=OXQyQjnvEF4d8vvwYiRaaHqcdwgxcTmHdFmanrUWC/jKOU2f5RiQR8sYlTHoR4R8yJqwZodkJ7F/RbUaqUvM25pxw0frHy4UlFaZyTL55U4u6AwY8lEGL/89A3n9DHL+QxM4Ku0xbcXD0yxVSdrvwK5+SN9K4F7lGHAVOBMNQZ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755174786; c=relaxed/simple;
	bh=ijkxdKmoiHSBSX0wJf02WaokLLh8bjMzCsplRGepVLs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sNeiVsVcWi9K6rxDWdanK07yoIYh5EbqTBzyFlYGEANEQJyOIzUgOX0zb90N5wyahXw/Nc7NJZNOijqvyfCCCEb0Ld8Gw5PNcDmZYl2qXabI+g8BiflL8LfzEIWeWA3th7NVd4z9dwzRs4JyiqQsTgrNnffRHcJf2qNx6y/Ib7I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.222.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f52.google.com with SMTP id a1e0cc1a2514c-89021b256d1so81129241.1;
        Thu, 14 Aug 2025 05:33:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755174783; x=1755779583;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BLvrdOmt5Hmmf8Mi1+JczimXtjeI82BM8/FRMX75B6Y=;
        b=urgvZaOI5eKCMVfu+LlG1J131miO4c+FwRj8yiX2wNxZvtBjzra88KdMMPREYasU3+
         1z7tRqXZ9YghrMibjXx72/KDf2jNxGoxRqVuF1jxjPbsqmYor3fWgmdK2as0TYO8n/VO
         mfLSnB2FhKQHdVk8uV2LR2Vo9i8sAY8PARcc+HZJRGJr5L7O6+rfQE8SAMp49miJmK3o
         KGKpT+eVakJSkpEslc7eVFAsrlDXaCq+l6g+qUPgOBNxbGrkdMYuB5wqs5SePAJE606e
         +WWVu5V+koNzV2/X8YeOQgnNvlzDqMTlLA5zr46G7MoBUgNB8XNdNQQMWSWKnvQtfkjJ
         nUxQ==
X-Forwarded-Encrypted: i=1; AJvYcCUuOCdACmlOTiTrKD/KJLiJCUwMyf/XsBDC/MueOBtCmxCv4JJPTQxx3cqlAFeAQTF6IO3vaIoArQk=@vger.kernel.org, AJvYcCVtBCv/7gWEO99LfTYElUfErLbjl1o3xS9FvjiUR45unE7/8l5VqZ/s8jERXtnCpY2tTa9ciNWIRQZ67LuS7i/z7bw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzTtwfBGi7I7OihqLBlSQlsXSgm92xj0V1/wnvYDUtTI6QbTHzH
	SQtZdUoWXmTSej0Vo5Q3fX0JtYHw4i+NWQNd+s5O7cTeeK1wNakO4c6lgOtyZ9NW
X-Gm-Gg: ASbGncsBWpwKqLK6oc1TE998VgRWEwvIyxhWFhe3JQrZXmEYFf2xWGXex/HKfVj31xR
	N5RmSrfs+BFvvvRE7cMux7NwNU616SDabZwjELa2Dte8epeiBrcM4DuFBEizl/7YPmd4nEqEmRA
	WVJ28ATfr2ZzHI5Xbt3Zt/KHfmQ+Veu6BfMVdBHwxF+FwYOdkT1abxhGL11yAU187QxJkOajwhf
	hvpw6M2hHAJ5N67e8DvlwwlorNpH7/g89vF0zKs0E5Uck7rivqJZrvPU+WGT7ARAWu+OG9Qk2Zr
	agWkvd01OwxeFFpOYZT0fjjK3/xBtqr/QDGYrDZFzadH4Mm9KriBq+tWrPMh0F9DhMaq9B5HNGa
	OXFc9j1jpPaHKVMMho+OAzkRN/COVgxiSlspXfeXjGl9DvLZpxUsel8n4VRbJ
X-Google-Smtp-Source: AGHT+IHHwhWCf1dHhlPYvAZr3wWt9drzxNbEG13sQJuECB/r/MRQpgV0QT/++yDLSzp0zh20jh8N3w==
X-Received: by 2002:a05:6102:38c9:b0:4e6:edce:4b55 with SMTP id ada2fe7eead31-50ffff1614bmr854319137.4.1755174782953;
        Thu, 14 Aug 2025 05:33:02 -0700 (PDT)
Received: from mail-ua1-f54.google.com (mail-ua1-f54.google.com. [209.85.222.54])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-507a216a07fsm2580443137.3.2025.08.14.05.33.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 Aug 2025 05:33:02 -0700 (PDT)
Received: by mail-ua1-f54.google.com with SMTP id a1e0cc1a2514c-8901915d04fso232655241.3;
        Thu, 14 Aug 2025 05:33:02 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVgvk/PQKm7IP8yoqcPdQaEIOisEFCqXUzj1IAJTbXxRMfnTqL2fgww6AtSGbrMFZuBfGtxWY10A3M=@vger.kernel.org, AJvYcCVtcpBiHqvcYBOY8SGoOEk8a6O2ad9BTz5E4YlVzF3FcsEXOCHkwg0bWWei97SwVuQPsQr48llLNEJQiW/FKthyYWc=@vger.kernel.org
X-Received: by 2002:a67:e7c1:0:b0:4e2:a235:2483 with SMTP id
 ada2fe7eead31-5100231379amr908317137.19.1755174782374; Thu, 14 Aug 2025
 05:33:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1755172404.git.geert+renesas@glider.be> <ae8fdd96d926ddd2c699ec2795a4c9937c3f3bc3.1755172404.git.geert+renesas@glider.be>
 <20250814-incredible-cordial-coot-5f9fc9-mkl@pengutronix.de>
In-Reply-To: <20250814-incredible-cordial-coot-5f9fc9-mkl@pengutronix.de>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 14 Aug 2025 14:32:49 +0200
X-Gmail-Original-Message-ID: <CAMuHMdUpyPMCJjBcLtCE2POAZ9pA=+F7QZHavdLGZuvk4EoWuQ@mail.gmail.com>
X-Gm-Features: Ac12FXzOSBhslo5BXRKHTSofkUM762ZP4gzyrQGR2yNUUbypsTQ7Rmq0_JgmQ68
Message-ID: <CAMuHMdUpyPMCJjBcLtCE2POAZ9pA=+F7QZHavdLGZuvk4EoWuQ@mail.gmail.com>
Subject: Re: [PATCH 3/9] can: rcar_can: Convert to Runtime PM
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: Vincent Mailhol <mailhol.vincent@wanadoo.fr>, linux-can@vger.kernel.org, 
	linux-renesas-soc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Marc,

On Thu, 14 Aug 2025 at 14:08, Marc Kleine-Budde <mkl@pengutronix.de> wrote:
> On 14.08.2025 14:02:01, Geert Uytterhoeven wrote:
> > The R-Car CAN module is part of a Clock Domain on all supported SoCs.
> > Hence convert its driver from explicit clock management to Runtime PM.
>
> Does kconfig ensure that Runtime PM is selected?

drivers/soc/renesas/Kconfig:

    config ARCH_RCAR_GEN1
            bool
            select PM

    config ARCH_RCAR_GEN2
            bool
            select HAVE_ARM_ARCH_TIMER
            select PM

    config ARCH_RCAR_GEN3
            bool
            select PM

> > --- a/drivers/net/can/rcar/rcar_can.c
> > +++ b/drivers/net/can/rcar/rcar_can.c
> > @@ -506,10 +506,10 @@ static int rcar_can_open(struct net_device *ndev)
> >       struct rcar_can_priv *priv = netdev_priv(ndev);
> >       int err;
> >
> > -     err = clk_prepare_enable(priv->clk);
> > +     err = pm_runtime_resume_and_get(ndev->dev.parent);
> >       if (err) {
> >               netdev_err(ndev,
> > -                        "failed to enable peripheral clock, error %d\n",
> > +                        "pm_runtime_resume_and_get() failed, error %d\n",
>
> Can you convert the errors to %pE?

Sure, will do!
Thanks!

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

