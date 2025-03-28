Return-Path: <linux-can+bounces-3264-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CC870A748A2
	for <lists+linux-can@lfdr.de>; Fri, 28 Mar 2025 11:46:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C8F967A85A4
	for <lists+linux-can@lfdr.de>; Fri, 28 Mar 2025 10:45:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98A0D1A5BAE;
	Fri, 28 Mar 2025 10:46:08 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from mail-vk1-f177.google.com (mail-vk1-f177.google.com [209.85.221.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A85BE6FBF;
	Fri, 28 Mar 2025 10:46:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743158768; cv=none; b=HcVC7tIKcv60gvbbuRsokwFKooVDGkN30ekLO4kdw7Dj7ID/TCki536R8cGFmP81Q4DchgKAG7keyuAU2p+cmK2F2MdiK9fk7/2P3kudtb0MN0Z66S1bpfsgqxphki6b/oZFNX2tHYmkRnuev2+uQG9XfaVV89AVxXeaEHTuHd4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743158768; c=relaxed/simple;
	bh=aq+Q2Tz94GcDqbYiph2YuHAplYRXJslchXRCTz0ozGA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qtai+CSycwVnAeHRWPOXINaDqjq77wt5ynXyjjRLLFEjbTIUZ0ULqwNuW9nmHv4mVQxDHVA+AKSCYUZQGOMaisb7IsKtT/nKOZoHUz5TNLOhElF8YdmJn4BrjaFeJBRwjpTwn86qKHULgcJZlp5kzEZmozyD52RePTcyOOWgww4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f177.google.com with SMTP id 71dfb90a1353d-523eb86b31aso933357e0c.0;
        Fri, 28 Mar 2025 03:46:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743158765; x=1743763565;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fz7Hy0X0ja0MUy8SfPs14C/LCrU2EryH1zXbLEH1v80=;
        b=t1WzkiwdIRAeA1gR0+aPfjel24NZ+Fic2Cxr73HvjoUZwHWKFLUbuJg9P3xiNd40N8
         Vw8TVp7LEnBiyo9P+n/cA64DtovrTXK0yUdiqbedHYzPCIZvG3230621dqwcrEgzPesP
         aCqIoA1CR6O9I7IH2egWJ44EacJOARzvMT3r/bvzYS6ichoRZ480PnEB9+P8xRULGmn8
         6L5FbM/LsCVOXbzxKCJ2gq+uMnTxDtyI6GutqNJGom2EisrxmNzd4DCxVkTlcV/RNS4k
         JvG/hzftr7Ue/gc5A7irl+uSA1viGnS+UkjeRGnFQ+b5m6h9ycUgDC9QUacqEy/VI3Z5
         3ccg==
X-Forwarded-Encrypted: i=1; AJvYcCUXXBcxGKE9uZ0Vmvha0m0Ovj30MhU6mUdPKm4WO5M4BK6ssoOBJmM/82Xs4GzW7YmBv8G7WlJP2pZggHiOjvLa7lk=@vger.kernel.org, AJvYcCVA3OOk0ziEUe2NBZ3jtElAju8O9rJ1yraMhZKdQH5dS9n3nACgnaqO6v56pQOajRNghswl92RlfnY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyv6xoiquRDpBTn0JdS7vaHco4nHZH/skWPEqTf1ebOAyJsEl3N
	ZRBKqHeRaX2IVs22Sm+dkWZOuTJq6PkQx742XJ0AMVoCncZmAgYSAr+VxI09
X-Gm-Gg: ASbGncuh25KagYjJqgVPzxva9vCEf7se8Uw4h4BMAfgHNSlUnoh5U7NLH4PcNS3jfIv
	R5XESUU2z4SsgVVo+LVW8P/Zr4tYOmU4jig4OfEB9fEHvzzGghMAN/drVDKwc/7xgcgC2aAkjBm
	wpBRzzPOTow7tJbrMtFQT0CfoH2CVj9Zi7AKmT1V5Na63lUuu2iF8BUIR1Gw/F4E0faFcEO74ZE
	IVw/N5P0/k9hqanhIYuJzDvPMgBZyIbER/IoXl153aSUFe1317h5TLaTXqsn52BYPvWH0z2Ytmj
	R7GvIxi5wghvo6drjmK9TQ6O/s55OdmtONwfSIEEgMXeEeR9kYs1QXa0b/BIFDzH3M4vY4LKk79
	oSgu9Rfk=
X-Google-Smtp-Source: AGHT+IELw3N84GL6rvcPukuG6hqUVnOxhu42zJxwpy9982MIlcFbWKXCeejolKhkGfVLLnYYnMPqxQ==
X-Received: by 2002:a05:6122:660c:b0:50b:e9a5:cd7b with SMTP id 71dfb90a1353d-52600a8ada4mr6333995e0c.9.1743158764884;
        Fri, 28 Mar 2025 03:46:04 -0700 (PDT)
Received: from mail-ua1-f41.google.com (mail-ua1-f41.google.com. [209.85.222.41])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5260e7e9014sm348211e0c.12.2025.03.28.03.46.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 28 Mar 2025 03:46:04 -0700 (PDT)
Received: by mail-ua1-f41.google.com with SMTP id a1e0cc1a2514c-86715793b1fso887924241.0;
        Fri, 28 Mar 2025 03:46:04 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWoz6HV9ZvFzlqSTDuOdUxUV45QMBDeyhcze6FPM+cgwvEFH/ZNZmzQ+ixXNann8ORwqoepmYsS0JJBo6RjmfEkyNE=@vger.kernel.org, AJvYcCXlksIkh3d2zEIoUKc76gw3uwnYk8ojjIObAvQrVS3LmJNB+YWcqjRHz86KH0RipqRGlrIeZHDdQUE=@vger.kernel.org
X-Received: by 2002:a05:6102:3f4e:b0:4c3:49b:8f78 with SMTP id
 ada2fe7eead31-4c5870e0a6fmr5369028137.25.1743158764315; Fri, 28 Mar 2025
 03:46:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250326122003.122976-1-biju.das.jz@bp.renesas.com>
 <20250326122003.122976-8-biju.das.jz@bp.renesas.com> <3bf3ec05-d900-494a-954e-633828b4c984@wanadoo.fr>
In-Reply-To: <3bf3ec05-d900-494a-954e-633828b4c984@wanadoo.fr>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Fri, 28 Mar 2025 11:45:52 +0100
X-Gmail-Original-Message-ID: <CAMuHMdUJpE93H2=QDcPAD9-gimQC9B21AUe8mksn-WVyiiHO-w@mail.gmail.com>
X-Gm-Features: AQ5f1Jo4SH8dF8yYfKyTm3Nhcxsg1e_BU04tUZCjguNdJa75TcnqSe7v3lG2xk0
Message-ID: <CAMuHMdUJpE93H2=QDcPAD9-gimQC9B21AUe8mksn-WVyiiHO-w@mail.gmail.com>
Subject: Re: [PATCH v7 07/18] can: rcar_canfd: Add rnc_stride variable to
 struct rcar_canfd_hw_info
To: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Cc: Biju Das <biju.das.jz@bp.renesas.com>, 
	Wolfram Sang <wsa+renesas@sang-engineering.com>, 
	=?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <u.kleine-koenig@baylibre.com>, 
	linux-can@vger.kernel.org, 
	Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>, Biju Das <biju.das.au@gmail.com>, 
	linux-renesas-soc@vger.kernel.org, Marc Kleine-Budde <mkl@pengutronix.de>
Content-Type: text/plain; charset="UTF-8"

Hi Vincent,

On Fri, 28 Mar 2025 at 11:36, Vincent Mailhol
<mailhol.vincent@wanadoo.fr> wrote:
> On 26/03/2025 at 21:19, Biju Das wrote:
> > R-Car Gen4 packs 2 RNC values in a 32-bit word, whereas R-Car Gen3 packs
> > up to 4 values in a 32-bit word. Handle this difference by adding
> > rnc_stride variable to struct rcar_canfd_hw_info and update the macro
> > RCANFD_GAFLCFG.
> >
> > Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
> > Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
> > ---
> > v6->v7:
> >  * Collected tag.
> > v5->v6:
> >  * Replaced RCANFD_RNC_PER_REG macro with rnc_stride variable.
> >  * Updated commit description
> >  * Dropped Rb tag.
> > v5:
> >  * New patch.
> > ---
> >  drivers/net/can/rcar/rcar_canfd.c | 8 ++++++--
> >  1 file changed, 6 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/net/can/rcar/rcar_canfd.c b/drivers/net/can/rcar/rcar_canfd.c
> > index 32d700962d69..0001c8043c25 100644
> > --- a/drivers/net/can/rcar/rcar_canfd.c
> > +++ b/drivers/net/can/rcar/rcar_canfd.c
> > @@ -291,7 +291,7 @@
> >  /* RSCFDnCFDGAFLECTR / RSCFDnGAFLECTR */
> >  #define RCANFD_GAFLECTR                      (0x0098)
> >  /* RSCFDnCFDGAFLCFG / RSCFDnGAFLCFG */
> > -#define RCANFD_GAFLCFG(ch)           (0x009c + (0x04 * ((ch) / 2)))
> > +#define RCANFD_GAFLCFG(gpriv, ch)    (0x009c + (0x04 * ((ch) / (gpriv)->info->rnc_stride)))
>
> I find it rather hard to follow the logic here. Your are multiplying by
> four and then dividing again to get the good results. Here, I guess that
> 0x04 represents sizeof(u32), but this needs some thinking to figure that
> out.

The division is done first...

> Wouldn't it be more intuitive to instead store the size in bytes of the
> RNC value?
>
> #define RCANFD_GAFLCFG(gpriv, ch) \
>         (0x009c + (gpriv)->info->sizeof_rnc * (ch))
>
> This way, no more 0x04 magic number and it is easier to process a
> multiplication than a division in your head when reading the code.

... so this is not equivalent.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

