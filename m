Return-Path: <linux-can+bounces-3288-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CA8B0A74E2F
	for <lists+linux-can@lfdr.de>; Fri, 28 Mar 2025 17:03:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 823333B3EB4
	for <lists+linux-can@lfdr.de>; Fri, 28 Mar 2025 16:03:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAAE41D5CD1;
	Fri, 28 Mar 2025 16:03:42 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19D801D5CC1;
	Fri, 28 Mar 2025 16:03:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743177822; cv=none; b=LhJH7ypFzZXpl1gHFLa9nTFm88aC38ajygiOt4YCx4HCAOh8NFuUfbf8fJ9Gr0VgZ3mtaKihvaCWXybFOelVqmo05O2Oams8bFWRlMAtOihserRYSy8wFG+F1Stl++d2GT9wYTQaKYiJCsso2gtfQqzjCnaZHRmprCcfDd6GDTU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743177822; c=relaxed/simple;
	bh=Zno6HutHdT8q/G02ExrzilXLEKpaM2i3/A2ubk+10vM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ikhz1x1/OnwsCjiJcbpvkT8AI4ImTOYGVaRrMaexi3DS6xcyegzpSOWX/6d93gxZBOodVXORc169tiZDAM3Fwf4VFPcaKUgCqT/96vw/FakRvhFM2CMkKHK7YpFWF+ro0q6P21gBbPj8lK0SjyK4IzUELdw/2CNeLGiNL/g2LsE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.160.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-4772f48f516so34149261cf.1;
        Fri, 28 Mar 2025 09:03:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743177818; x=1743782618;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tJ3/oeNOv16kMMM9uJQHAi2WhpN4gQHJ7vNpCBo2xE8=;
        b=eotwUUTjJNN/kEOiOdxZBaeh2SxHo7IlozgT+fK/qFOBnRfzvHsEYTQ7l/IX3jxBbc
         0YkrawAgk88XDxtXU1y6lN8XDrKKwTJxXU+y0J36ThqYE80vaeNVL7iLMgB+s3JhFkV2
         H+QlIyHj0AeEz+3voHMdCVPSKW+plBatmrhpBo9baVBs/hgL3q66laudo1GDuW5gXaQk
         Dw91UJbPyLbqPmzHM+8pNT9mXrNFGoED+bIIgeFaV8RMBIU5TU2HkZZJxM7wtBLcYnMe
         FvEIxQd7ZTmshzd4me43/Lt8z89hjB8kEQnxUeNjOd95QagWwAsmyhwx1zviaoZGR89C
         Xl8A==
X-Forwarded-Encrypted: i=1; AJvYcCWhBsdDQK0pzbzeS5Wgmna0m2Y9phzbgg13gP9rORKbZTb7OmzaeSedBUgVXwXQHYl6QrxIumymNGU=@vger.kernel.org, AJvYcCXBJ43G7vt+Rj4ypeIh7ZbM3Rr+zp8Oi/84CDUv4VSM5g2vPyBnMw1Z6w8kYh4GySwjvJ7gEG6KnMXH7go5cSp98tA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwA6dsoekOp6TlE3uDI9ItcfzNwnuozJDkt3hQkhta4f6rpQWGC
	oFNp2o9ZDemFeUjnFNyEnicbKphM1gZ9489OTQPjIIA94o0ng/qprF2lLYrV
X-Gm-Gg: ASbGncvbcaQzWFmZJl0mtcM3tBOkvYL1620JnajO8+D+PJ4hm2RtWvJE1kqZJ2Ad7ni
	YoYzNs/aBrt4hyUbYPwdCae0xQ4+R35WBWj9iDe3Y6O9yVEH4Vanj2L+UftdFU23Cneb/7iV4T7
	+9DdXl1R4yYAJ03eWACsLWOaqfLel9MJRgTWew73n3cBz7cViboqvFkJ8EUDmybQPwp+0CfGO1X
	gvRIV7CCHFOuUGTgKlvweyJpHwqwzn84DUPKtB141qxCdtK3SWocm2bhWFd9qQhCg5YDllXg74s
	I0fyekVTJzSN1Ds0jWbcEGS9gD8Vp7mpPwtuBO9+0O4jopRi7HlHSb+9BR4c4m55HBUpoYYlv9e
	RXL0goEckUxc=
X-Google-Smtp-Source: AGHT+IHGjH4fa+8Y3DyppfbqBISmrWbjfaIaSog+jUcqueJeQDJaTkrk4nDP1ypNA7aZausBSMxAgA==
X-Received: by 2002:ac8:7d86:0:b0:477:6e32:aae2 with SMTP id d75a77b69052e-477a15a4402mr1065341cf.0.1743177817884;
        Fri, 28 Mar 2025 09:03:37 -0700 (PDT)
Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com. [209.85.222.172])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4778317b877sm12331521cf.58.2025.03.28.09.03.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 28 Mar 2025 09:03:37 -0700 (PDT)
Received: by mail-qk1-f172.google.com with SMTP id af79cd13be357-7c592764e24so249878085a.0;
        Fri, 28 Mar 2025 09:03:37 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVSbodfrmvhcwmvIBD0HTwrLIGVdTaWE+JVTUuNg+9h7Smh0ufyu/rr8j1IEi0/e3u18hbcGEp+LYRc0E0l5qaZRfU=@vger.kernel.org, AJvYcCWVn3qgFD5jGi1J4kEJPP83aZDHyk9Zmw9jyXH5vSVvuViyzVcOxdPxGvCiD3hjSPMw3t0T1SwXc2Q=@vger.kernel.org
X-Received: by 2002:a05:620a:2625:b0:7c0:a9ee:e6c1 with SMTP id
 af79cd13be357-7c5f9b83841mr471702585a.7.1743177816971; Fri, 28 Mar 2025
 09:03:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250326122003.122976-1-biju.das.jz@bp.renesas.com>
 <20250326122003.122976-8-biju.das.jz@bp.renesas.com> <3bf3ec05-d900-494a-954e-633828b4c984@wanadoo.fr>
 <TY3PR01MB113461BFAD846313BD0584A8A86A02@TY3PR01MB11346.jpnprd01.prod.outlook.com>
In-Reply-To: <TY3PR01MB113461BFAD846313BD0584A8A86A02@TY3PR01MB11346.jpnprd01.prod.outlook.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Fri, 28 Mar 2025 17:03:25 +0100
X-Gmail-Original-Message-ID: <CAMuHMdW7qTBVuHCxVfpOom-dEkROYfPG_neUiY7iUq=HAgAjFA@mail.gmail.com>
X-Gm-Features: AQ5f1JrN7YcmCj0YrWw24W7lAhVMo-mpJYNgnCd8Qr3Ss1favnyARhevriU6iDc
Message-ID: <CAMuHMdW7qTBVuHCxVfpOom-dEkROYfPG_neUiY7iUq=HAgAjFA@mail.gmail.com>
Subject: Re: [PATCH v7 07/18] can: rcar_canfd: Add rnc_stride variable to
 struct rcar_canfd_hw_info
To: Biju Das <biju.das.jz@bp.renesas.com>
Cc: Vincent Mailhol <mailhol.vincent@wanadoo.fr>, 
	Wolfram Sang <wsa+renesas@sang-engineering.com>, 
	Geert Uytterhoeven <geert+renesas@glider.be>, 
	=?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <u.kleine-koenig@baylibre.com>, 
	"linux-can@vger.kernel.org" <linux-can@vger.kernel.org>, 
	Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>, 
	"biju.das.au" <biju.das.au@gmail.com>, 
	"linux-renesas-soc@vger.kernel.org" <linux-renesas-soc@vger.kernel.org>, Marc Kleine-Budde <mkl@pengutronix.de>
Content-Type: text/plain; charset="UTF-8"

Hi Biju,

On Fri, 28 Mar 2025 at 16:39, Biju Das <biju.das.jz@bp.renesas.com> wrote:
> By introducing setrnc(), this patch is no more needed as
> rnc_stride is local variable inside strnc(). So I would like to drop this
> patch in next version.
>
> [1]
> static void rcar_canfd_setrnc(struct rcar_canfd_global *gpriv, u32 ch,
>                               int num_rules)
> {
>         u32 shift, rnc, offset, w, rnc_stride;
>
>         rnc_stride = 32 / gpriv->info->rnc_field_width;
>         shift = 32 - ((ch % rnc_stride + 1) * gpriv->info->rnc_field_width);
>         rnc = (num_rules & (gpriv->info->num_supported_rules - 1)) << shift;
>         w = ch / rnc_stride;
>         offset = RCANFD_GAFLCFG(w);
>         rcar_canfd_set_bit(gpriv->base, offset, rnc);
> }

Nice!

Please combine variable declaration and assignment.
While at it, perhaps "unsigned int ch" and "unsigned int num_rules"?
Actually about everything above should be unsigned int, except rnc.

I know this existed before, but do we need

    num_rules & (gpriv->info->num_supported_rules - 1)

? That "&" only works as long as num_supported_rules is a power of two,
and I think num_rules can never be larger than num_supported_rules anyway.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

