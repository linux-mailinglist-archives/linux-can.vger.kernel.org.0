Return-Path: <linux-can+bounces-3413-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EA8FA905A1
	for <lists+linux-can@lfdr.de>; Wed, 16 Apr 2025 16:10:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4EA8F464960
	for <lists+linux-can@lfdr.de>; Wed, 16 Apr 2025 14:08:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 981811FCFF8;
	Wed, 16 Apr 2025 13:58:58 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from mail-vk1-f180.google.com (mail-vk1-f180.google.com [209.85.221.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6C8021ABB2;
	Wed, 16 Apr 2025 13:58:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744811938; cv=none; b=c6xePBZsArvOky+NLcClgaiSKCTfGBNpkSoVQlJmY2sxR4TLMinHzCf7d8Hqm+MFDPOdAo4OW9VmkgfWgHx/OJYOHcaY/LtRWtr+3GxmIxhFLUupsAw7ZmIxsPvDonwrc6dTbhKx/N1lTpivrrqXbafOvRVTC/Ktz7RL+SdNrxg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744811938; c=relaxed/simple;
	bh=nzdVN3NX9LFfBEOIU8TRPQlmG8w3Rh9Iw66tFUfhGvs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YkQMOhmBGcUrOeNIEAmxCC+eL88JgXyiQQBDekIdapzxJgrRJbHdI80IiiimX3sRV27rdECKcgmj8/XgetpbkwXf00bqG32PFgBGf2RBOztPaIGuj9acy//90ahj4sWntNMceoP1DHgt0x0dYhnLRKkb5H+3COaZDfMmd1Om/Tc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f180.google.com with SMTP id 71dfb90a1353d-5290be1aedcso639803e0c.1;
        Wed, 16 Apr 2025 06:58:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744811934; x=1745416734;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bdzxr6Mze7jNtZagLXMTAP+Egtg7UtTgUd3rtPbcGPg=;
        b=XvuyrSzo2m1x7I8ZO6OSbW/i0QvrD5LmEvWn++ExD00JdNl2fZ0G2fvnemzuDPxqrv
         OenRipJ4lC5OoNqUAt8bheFhY7Fk49/t1GXstYWpQFd0c42NITbVrkQerDXo3V1wCk6F
         UkZUNKiUM2u6/WXPjL+hIpvF4Vh5ZWBPLRNw6I8J5FJYNiaNt3FwWL0aJMeopjH8uhPD
         0Qj9Bus4V1PpXThFdncehsmfFjSzDjrmNbvvVDrGNpPWUoTDSbf+N2GbuLPxS8zPZ4l4
         CzidpllI+yluTBRXa01fLjSO8pafxk/BEgC/Q1LZ9UonRxdws+NK3f4vsqdlj5fyOk6G
         Yxjw==
X-Forwarded-Encrypted: i=1; AJvYcCWa3aelqQoqVhlI8iH4fHP67zJIUEq5pAkuJ1i2yaO3xO1C1YjLAU3tDTMGUfI/WM0t2s5byXu1K05VKx/itTS6nwA=@vger.kernel.org, AJvYcCXp4cGoWImLpaMekxZRIW3x9oh4KhwwrCSndJbeI6/LEWPdWYtfVCGj/9w0sFHcH+t71thAY04VW/E=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx30zuBE2krbY6OTn+2M0AyiLRmcXN7BPklhLVSFyfZcqosPafA
	3liTtwmp/pYskOnnX33FNkEJgiU061dzDrATweGq5fi6xSqOjs6zATxRGccx
X-Gm-Gg: ASbGnct21aTHkaWkufH/meLSPy1sgNp2sMlbTH7OtKGh0e77Cy8cN39XaHL8x/0sHe0
	wVNO9cL3s+j04Pdaw/SqiEBR+A7PJOAX1PrWji8jJaQG6cEHtG3c4WmS95vg9F+VN2MJCx+vnVk
	P8AokVZL9iwKZkyDOHkjqqmAxrd6Lr/rSp3MQo6VaxTYvBQcm7zR0jdeswVwMjY1AtfawsF+x1T
	4qDQ3HOmbR9+dTl7RP5AK0WST2w8vX9npTv4t+z8smAPA90qnsYJXk22SbAgK98u3OMlbiOmndN
	fVJVDDk1+W1+DeqGSGEgsn1ITtz6nd2nHFo2WF2IrRJ3f5KBnLu1gD/wmgSj6XqpOlbsQ4CpLfc
	3JZ4=
X-Google-Smtp-Source: AGHT+IHR0OyJqvnptTSvJv/snJw2iPi+sQdJ5slAdz3OZtseVDLoQcZAKR4fVukdjc5U4L3lXMgqQg==
X-Received: by 2002:a05:6102:c9:b0:4c0:435b:5dd2 with SMTP id ada2fe7eead31-4cb59649140mr827272137.1.1744811933827;
        Wed, 16 Apr 2025 06:58:53 -0700 (PDT)
Received: from mail-ua1-f54.google.com (mail-ua1-f54.google.com. [209.85.222.54])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-875560e4a9asm3135321241.6.2025.04.16.06.58.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Apr 2025 06:58:53 -0700 (PDT)
Received: by mail-ua1-f54.google.com with SMTP id a1e0cc1a2514c-86d6fd581f4so753593241.1;
        Wed, 16 Apr 2025 06:58:53 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWGjXGIEG1AriO1Ky8Z1DxZOOiuV31t0Td0n73z7ioLRcHF/SNw4imqR9ggosvTUUE0cREX8eKkGpI=@vger.kernel.org, AJvYcCWjGVQLyd3PAve9ciTMkUveDDo6Vul7FRpP91rPwOqJWbKuF7dKbE0ZrKpGvTJeaq1Q/gfmLI7INBV35V1FOiMqRsY=@vger.kernel.org
X-Received: by 2002:a67:e986:0:b0:4c1:492a:d75b with SMTP id
 ada2fe7eead31-4cb59648d7dmr867050137.2.1744811933168; Wed, 16 Apr 2025
 06:58:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250402102226.28032-1-biju.das.jz@bp.renesas.com> <20250402102226.28032-17-biju.das.jz@bp.renesas.com>
In-Reply-To: <20250402102226.28032-17-biju.das.jz@bp.renesas.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 16 Apr 2025 15:58:41 +0200
X-Gmail-Original-Message-ID: <CAMuHMdXpvbhu7n8BhanvY9cPFANsAa27iuNBS4_=NKJsU6tzcA@mail.gmail.com>
X-Gm-Features: ATxdqUHIuN0FvZhwPLrMMyYkMmBNOCmOVGkFywdCGJQVmipKu2aBWUj5hDGqUuY
Message-ID: <CAMuHMdXpvbhu7n8BhanvY9cPFANsAa27iuNBS4_=NKJsU6tzcA@mail.gmail.com>
Subject: Re: [PATCH v8 16/19] can: rcar_canfd: Add sh variable to struct rcar_canfd_hw_info
To: Biju Das <biju.das.jz@bp.renesas.com>
Cc: Marc Kleine-Budde <mkl@pengutronix.de>, Vincent Mailhol <mailhol.vincent@wanadoo.fr>, 
	Wolfram Sang <wsa+renesas@sang-engineering.com>, 
	=?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <u.kleine-koenig@baylibre.com>, 
	linux-can@vger.kernel.org, 
	Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>, Biju Das <biju.das.au@gmail.com>, 
	linux-renesas-soc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Wed, 2 Apr 2025 at 12:23, Biju Das <biju.das.jz@bp.renesas.com> wrote:
> R-Car Gen3 and Gen4 have some differences in the shift bits. Introduce a
> struct rcar_canfd_shift_data to hold these values and add the struct
> rcar_canfd_shift_data variable sh to struct rcar_canfd_hw_info to handle
> these differences. After this, drop the unused functions reg_gen4() and
> is_gen4().
>
> Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
> ---
> v7->v8:
>  * Updated commit description.
>  * Started using struct rcar_canfd_shift_data instead of LUT.
>  * Dropped the tag.

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

