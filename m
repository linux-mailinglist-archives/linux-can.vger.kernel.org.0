Return-Path: <linux-can+bounces-2176-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CBD1F9D6052
	for <lists+linux-can@lfdr.de>; Fri, 22 Nov 2024 15:33:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5B815B2439F
	for <lists+linux-can@lfdr.de>; Fri, 22 Nov 2024 14:33:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4DB37082B;
	Fri, 22 Nov 2024 14:33:39 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com [209.85.128.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C5125D477
	for <linux-can@vger.kernel.org>; Fri, 22 Nov 2024 14:33:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732286019; cv=none; b=qzELiYC3qdKOEnMrbvWJkeF+XnS6kwLZgUlIjd8JGuMN6VgCWwOwD+2LW+EwLTT2/4CsqeDAJsYAFWmtO8eO3UigUeVoguJjVcw1dgy9xmadCKn/SWiFtZ+6SGjH+Ee4IfscwGBGWQiCgvh09XHl7jrB2YpyhBsjlyzcgVaRf3E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732286019; c=relaxed/simple;
	bh=F6hk1mzzl8Fr3M5JQoYa8dNc4KNBuWD0ivKzD4kqzmQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XYWoTnjkVFqvB0lMKPbrJ/m/dFUsWHJb8bVxSVtaUpPApahKB8Hz9A541sdsMX9rDbKd1wYng0ebwIBLBSQUlLAUR0PIx/aKtfLUsyaHm/WQ2NrnuzfLHbBtsxHH+zPell5OtaiCpsCscbXOpuokPK3/m0rEH/b7W9nNSqeh9K8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-6e2e41bd08bso28841847b3.2
        for <linux-can@vger.kernel.org>; Fri, 22 Nov 2024 06:33:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732286015; x=1732890815;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=clysjjs6hstlS3vul64vzOqoDA1aCKYo726T8vokckI=;
        b=H02UDLx23fQH1ql15tuWjJct4KtSJbapL/LO3p3fVxmYeK4/4l9CL5jkPxbp7WREbA
         Mrr6jJULCcZ0Q4+hjKUSEgKIdAfBMjWgnKs0oXICEQ0WkOhi60lwVD14tumVF72H4G6c
         oH3i45tigWhXiMNeDNBhbYyRfud1ojFpzpVYLEiwy/+XN/2G0CwCW/v2yVkm7EEjqN6B
         SIu10+MgqUFttORtWQrLm8xgu1/fVL3mnQlAJROXi8GccUk4iknE+hog8snxrfJRA6GL
         +BFw9MtOymchOlCI6mjnSTMB5Fe4GbCBgexHGu7Nce3hBy1A/2rq6YwRmRvUpOlQcLge
         Gqiw==
X-Forwarded-Encrypted: i=1; AJvYcCXA6z0qIXkveMBvJCynsvG+AMT1++ByrgUOM5WHTY9n04+CIeUx6pFZqPm47V1ohHzGgh3iPjks/ow=@vger.kernel.org
X-Gm-Message-State: AOJu0Yww8W4I7OsCYcK80//dIr3mWa2pEnBgvrHOTYQ46hQJAXknQYwN
	8Az4d5vjGy/3YD29SROEug4JYSq1eP4IiHTCp+QyEd4WnqfkfeZOEbVYDM0W
X-Gm-Gg: ASbGncttYm+LK+vuR5SWWdgTQyF3TdHZfUun3BnBV7ePC2iU/VkdUJ8whlErG5AWK6a
	nvYAcvCCAlqYFPrSKeCQRmzXXMGYl2w9Xk1Mvdo5Zjv5JYKFjO104ET8RUPW+A+f1xNkdsusDj3
	kUYTTSPOV3Wd0bUrQ/YkgzUGaKNFKcyURWqVZrIaC6YSALj+LVYXzc7Uq9sV1r1DR9d+K+u+I5o
	+X0jyLjTeSpyTYRahawz2MHTQg+yYkGYHxWTbDORGVmbfHo4VQbuAX2IwGgdt7p/mwnWIEeSXZM
	0s8LW5FvmoWhTCVG
X-Google-Smtp-Source: AGHT+IEbpRpjdx6tRY4dGAzhLg2bYRXOqGlrwXz7f6U+38Euo4wbU/Is0LiXA4UpTBDQTLM0Tw39QA==
X-Received: by 2002:a05:690c:45c4:b0:6e2:313a:a01e with SMTP id 00721157ae682-6eee0a45f56mr44410497b3.32.1732286015251;
        Fri, 22 Nov 2024 06:33:35 -0800 (PST)
Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com. [209.85.128.177])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6eedfe2a240sm4682017b3.31.2024.11.22.06.33.34
        for <linux-can@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 22 Nov 2024 06:33:34 -0800 (PST)
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-6e2e41bd08bso28841277b3.2
        for <linux-can@vger.kernel.org>; Fri, 22 Nov 2024 06:33:34 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWCeertuEIUDcvXKOfDGrvmkfCkV4trLbRNLMAdHhd+zJzhOLk2vbm3ZimJ7ia7opvukivKheuEtwo=@vger.kernel.org
X-Received: by 2002:a05:690c:6401:b0:6ee:988b:16d4 with SMTP id
 00721157ae682-6eee0a43352mr38279067b3.29.1732286014182; Fri, 22 Nov 2024
 06:33:34 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241022130439.70d016e9@endymion.delvare> <CAMZ6RqJxb-52eSPqvaESjA-Wd_Jd-=gFO1HWbzxWe3gx7GWDmA@mail.gmail.com>
 <dcced72-7be1-b44-432a-dac2ad7f4cc6@linux-m68k.org> <20241121145017.33ca43f7@endymion.delvare>
In-Reply-To: <20241121145017.33ca43f7@endymion.delvare>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Fri, 22 Nov 2024 15:33:21 +0100
X-Gmail-Original-Message-ID: <CAMuHMdXU8tMPbHMDZmU=0xd-X6OqxO_3j=iLDR2XQ4q3URw2RQ@mail.gmail.com>
Message-ID: <CAMuHMdXU8tMPbHMDZmU=0xd-X6OqxO_3j=iLDR2XQ4q3URw2RQ@mail.gmail.com>
Subject: Re: [PATCH] can: rockchip_canfd: Drop obsolete dependency on COMPILE_TEST
To: Jean Delvare <jdelvare@suse.de>
Cc: Vincent MAILHOL <mailhol.vincent@wanadoo.fr>, linux-can@vger.kernel.org, 
	kernel@pengutronix.de, Marc Kleine-Budde <mkl@pengutronix.de>, Miguel Ojeda <ojeda@kernel.org>, 
	Masahiro Yamada <masahiroy@kernel.org>, Andrew Morton <akpm@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Jean,

On Thu, Nov 21, 2024 at 2:50=E2=80=AFPM Jean Delvare <jdelvare@suse.de> wro=
te:
> On Tue, 12 Nov 2024 12:15:06 +0100 (CET), Geert Uytterhoeven wrote:
> > On Tue, 22 Oct 2024, Vincent MAILHOL wrote:
> > > On Tue. 22 Oct. 2024 at 20:06, Jean Delvare <jdelvare@suse.de> wrote:
> > >> Since commit 0166dc11be91 ("of: make CONFIG_OF user selectable"), OF
> > >> can be enabled on all architectures. Therefore depending on
> > >> COMPILE_TEST as an alternative is no longer needed.
> > >
> > > I understand the motivation behind this patch, but for me, as a
> > > maintainer, it becomes more work when I want to do a compile test.
> > > Before I would have needed to only select COMPILE_TEST but now, I
> > > would need to remember to also select OF for that driver to appear in
> > > the menuconfig.
> >
> > IMHO these are two different things: to get a working driver, you need
> > to enable OF;
>
> True.
>
> >(...) to do (may be limited, i.e. may not give a working driver)
> > compile-testing, you need to enable COMPILE_TEST.
>
> No, you don't *need* it. Enabling COMPILE_TEST is (or was) one way to
> do compile-testing, but it was not the only way. Which is the reason
> why it was dropped.

You could still do it the other way, by enabling CONFIG_OF.

> Your reasoning would hold only if building a limited, maybe not-working
> driver, was a purpose in itself. I personally can't see any value in
> doing this.

It may help detecting more configuration issues using randconfig.

Gr{oetje,eeting}s,

                        Geert

--=20
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k=
.org

In personal conversations with technical people, I call myself a hacker. Bu=
t
when I'm talking to journalists I just say "programmer" or something like t=
hat.
                                -- Linus Torvalds

