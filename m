Return-Path: <linux-can+bounces-3102-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A71AA634DE
	for <lists+linux-can@lfdr.de>; Sun, 16 Mar 2025 10:51:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 90625189006A
	for <lists+linux-can@lfdr.de>; Sun, 16 Mar 2025 09:51:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CD1D19D881;
	Sun, 16 Mar 2025 09:51:04 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from mail-ua1-f52.google.com (mail-ua1-f52.google.com [209.85.222.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DF8139ACC;
	Sun, 16 Mar 2025 09:51:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742118663; cv=none; b=T3enQSsySFPTp6HtMOaNfBEK9ADZ3jcZJu3U8ROU/KcgxJdsKtiRwqxYI30JlyTI8W9uoDWfrHC5T/Cd1Ongt8UEdur/Hdv7IcYaM1R6NeeEgW3olmW1W7NnqDHjyZvNjUaQZ9bP2pTg0FV0IKtZJVZ00IRgOXVeyY2i/8qORkA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742118663; c=relaxed/simple;
	bh=8hQ6cnLMUz2O/EM8OqZ2c3wsQl1EkQG1SnPMBzO4WV0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oY9D9+jZUOdqdVeDQ7/OVJ9MNaVHZgFRGN0iMTwJkiA/ZLD1d+qRxk+hC/4pCE+MhrjEJQq2iP1qb1GNrJBnr0PeVtezZPMkcFCzsY3LzTaJPR3F6wPLNVHoGU/D4x2sBrYg9tpU4CBMyVdt78TAe6qpB4EuKSoWYG41MWK+4V4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.222.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f52.google.com with SMTP id a1e0cc1a2514c-86d3907524cso1479903241.0;
        Sun, 16 Mar 2025 02:51:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742118660; x=1742723460;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mi16ht2KDvISWnAgWjWjUChP5u+945AUE5Vpt0Z2vj4=;
        b=sbHTxEiCgkCMAkynHyOSCy8DCsKOrpdkwlEdLCeitSCtNkwJSlobxB6tJ6iweBk9qW
         0MmYDN5lNoyCNdAU4kzsFPmowhFgRUUdSE2F5cgKa7n4kDdcfoIoigouJhYYvetIB/uH
         b9nDYnaQoSE1Dkm3/4jNmxbGpx2ER1J0tz7kgN0p+8ObXD6Jtk+Ow1AOleE+uOOsi9dj
         wLMEGmER41n+ixR5mEAHn/8jRhP94MMMYe6tB1z2gAPLtOt7K1n9oozqJs1KWzL7Jjf2
         E5GqhOXC5o0dyL/yV2HYg/bYgJ7WpYqH+79yURGmqIw/8hzFTfVfoCWQqZ8FafU+qWdY
         TvDw==
X-Forwarded-Encrypted: i=1; AJvYcCUdvXvPdVw8QU30Y855i1clN4iKhME9hlubIbsJcN/ORxpPxLL74LPQFqew0i0P4t32u4u8IVL1EoY=@vger.kernel.org, AJvYcCUk7r60tnC5A+qd4ac1hyJzOapuyE++0vZK+kciau0wjcnMdQUIITuascT/vFmFNpWzn7P09AJePpKtY4QQB7lulQU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyFENRna27NuNaCmETmUtLBg9uzKtpdlkFBfF/DoUV+mKTwtpyk
	aWq4jUDsDOCxVpBoxb2FbcmWRWnuwoNUGtMA+auOighlc/4+lZZlEMmSjiDL
X-Gm-Gg: ASbGnctNfpuh6+cOkH27esd3AG2CVvPP9xLT9wwAtrq/1R0XAcoYmo5HOmhiCPPZA4i
	KkLBnl9ZnM3UUrgBqHsl3OBE5IEI2alAxsRYKcBkqKOpffsCPFOwq8mYFJ9jWQl6XDJJ/qa8O+/
	fa0YTpwef1na+CVl6ukOXdqSWFvjqvNhI0U9xJgZD8BK2x92ddXa5B1HkKWETmSBGlZPVmBL8Qg
	aDFXDCoFtPeVvW3McaEUbjDdNGP5EHVGgd/OFyBpsU4ID5uaizHUt5F3TnNIHizCoi8O2w2e0AV
	9bb9KfQ32aY0kTaFvN+20qltGYmR6otopFeN3EfbXeqoR3dbAd9t4TPLs2s3AuJ/G4xAQsEn8o0
	558YgqJ5rD/o=
X-Google-Smtp-Source: AGHT+IGzSNUAXQLOouj+uNdCZms3FPg/3N1I8W7BFkYK5JFcuKDZsVsl9fkOj/L5fGWW6NLtTC8X4w==
X-Received: by 2002:a05:6102:390f:b0:4b1:14f3:5d6d with SMTP id ada2fe7eead31-4c3831470f1mr4870134137.6.1742118660267;
        Sun, 16 Mar 2025 02:51:00 -0700 (PDT)
Received: from mail-vk1-f176.google.com (mail-vk1-f176.google.com. [209.85.221.176])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-4c374f646cbsm1116801137.16.2025.03.16.02.51.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 16 Mar 2025 02:51:00 -0700 (PDT)
Received: by mail-vk1-f176.google.com with SMTP id 71dfb90a1353d-52446b21cfdso1023164e0c.1;
        Sun, 16 Mar 2025 02:51:00 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCU3UfijhJo6AJHaWAbFLnpkL2nR+GA5efJ2kMotoFpAjSrjeApY6GPAVe5PfIHpQ8m9a44pQlVujWL1uO4dBlyJZq0=@vger.kernel.org, AJvYcCXnlROSVbUHTOshvfb/ls4pT6JIWXcaC0woh8K+ZPhh2MKi0SyimyJWVbV/NKXJ6kVPRVwKQ7kbuGs=@vger.kernel.org
X-Received: by 2002:a05:6102:8084:b0:4bc:82f:b4e0 with SMTP id
 ada2fe7eead31-4c38323694bmr5367133137.22.1742118659808; Sun, 16 Mar 2025
 02:50:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250306124256.93033-1-biju.das.jz@bp.renesas.com>
 <20250306124256.93033-10-biju.das.jz@bp.renesas.com> <CAMuHMdWQQGHdg_bH8+QTwXKOxQb6_M3Hkj5Re4QkGU8BNZ6vhg@mail.gmail.com>
 <TY3PR01MB113462C8C4356BFAABADFF66586DD2@TY3PR01MB11346.jpnprd01.prod.outlook.com>
In-Reply-To: <TY3PR01MB113462C8C4356BFAABADFF66586DD2@TY3PR01MB11346.jpnprd01.prod.outlook.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Sun, 16 Mar 2025 10:50:47 +0100
X-Gmail-Original-Message-ID: <CAMuHMdXy6vF_h09BZjkdL7QADpOuk5bW4ocnOodTw69Mf-VCkg@mail.gmail.com>
X-Gm-Features: AQ5f1Jrrrf3oMgLUBtEJ-0z8rU8RinfdTn7snyU9MCi03kJOzKA2veK8-316_Zg
Message-ID: <CAMuHMdXy6vF_h09BZjkdL7QADpOuk5bW4ocnOodTw69Mf-VCkg@mail.gmail.com>
Subject: Re: [PATCH v4 09/11] can: rcar_canfd: Add only_internal_clks variable
 to struct rcar_canfd_hw_info
To: Biju Das <biju.das.jz@bp.renesas.com>
Cc: Marc Kleine-Budde <mkl@pengutronix.de>, Vincent Mailhol <mailhol.vincent@wanadoo.fr>, 
	Wolfram Sang <wsa+renesas@sang-engineering.com>, 
	=?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <u.kleine-koenig@baylibre.com>, 
	"linux-can@vger.kernel.org" <linux-can@vger.kernel.org>, 
	Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>, 
	"biju.das.au" <biju.das.au@gmail.com>, 
	"linux-renesas-soc@vger.kernel.org" <linux-renesas-soc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

Hi Biju,

On Sat, 15 Mar 2025 at 18:33, Biju Das <biju.das.jz@bp.renesas.com> wrote:
> > From: Geert Uytterhoeven <geert@linux-m68k.org>
> > On Thu, 6 Mar 2025 at 13:43, Biju Das <biju.das.jz@bp.renesas.com> wrote:
> > > All SoCs supports extenal clock, but RZ/G3E has only internal clocks.
> > > Add
> >
> > existing SoCs .... an external
>
> OK, Will use "All existing SoCs supports an external clock"

support (sorry, missed that before).

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

