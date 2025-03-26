Return-Path: <linux-can+bounces-3208-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 03619A713DA
	for <lists+linux-can@lfdr.de>; Wed, 26 Mar 2025 10:37:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D473C189609E
	for <lists+linux-can@lfdr.de>; Wed, 26 Mar 2025 09:37:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57D9E1624E5;
	Wed, 26 Mar 2025 09:37:37 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from mail-vk1-f175.google.com (mail-vk1-f175.google.com [209.85.221.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96A1415381A;
	Wed, 26 Mar 2025 09:37:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742981857; cv=none; b=B9Gjs/SuaLmvYTJcdOb59J/uMF1ji/4ZPxsFf/rOkB0hAbUr9BPA++YXIJGW4pgLAEVJwq/cpKrKNfDPzPN7hzzBL7bzUyaQbsoQ0v08ZXSH1iS2kazryqlu0STxFx8SDYq4Q8AOMu3lbSjIPuqlYrjj6qee91d0bqn7yGswHbU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742981857; c=relaxed/simple;
	bh=fNN7GNpDXWB5FshzmdHriBwQYZnuRHGWNzvRiqQwbFw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Qv7dytami3OAkZj3gr7tYF+uRAj4iiEuSDwC/HY8lTwK6ALjat9N9P5Hgt19ZTV69YFzEgyKFNJumXutaFYOg/4tHo46/2ipdb2yIzribDhkyspD4lVY5YN/8q4tj2lHYrBfwVyMo1nSRPWJ4YgsU3yK+mTRl9GtF4CvON7RtGg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f175.google.com with SMTP id 71dfb90a1353d-5259331b31eso3011971e0c.0;
        Wed, 26 Mar 2025 02:37:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742981853; x=1743586653;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6yntMjxTqi13eFHiyDvQIbS9CANZGU9vCY0DlJYZf8Y=;
        b=rTikj4RI1tBYx7KAK+q/dvdjks3nMeayib2XIJEhtaQgYjIl5AU/GeagZCCXUgIn+8
         i1fv4tO+jpCLNrL0q+tvB5b283znYBgnsllYGnSvBHj7eTRa+li3wazrQQMG1d/YeeCu
         DFEz++/X3fR6dRilGiOp/g3HeTgSDfk/Q2Hxg9UUVie1yHW+SbMoLGVcVS4d2M8APPV0
         Vm+ndyQTNotthgxH6iHyIW5reB1TuFHi1Sy5lZpO7aQGJI03HjojPMgb5l2PRC8A6v+C
         HdQvwjNcG3prEUabSkoqkGQzhBDQElIt9HqyOVJatOcrcQauxC9DEAPYbonR+k1TtjfL
         64iw==
X-Forwarded-Encrypted: i=1; AJvYcCUIOUHFRwajunhisN+7eAAyJQ5xj2QWOpgXGnrdl4exCoE/KK6cOulgcCDkTEvN9z7F5x1gjaTlrF8=@vger.kernel.org, AJvYcCXlWOogU60nd2cFGuv8kv9AhRpiclDKXkMsc8rMo929YS5cz8HPsgmtVuIKCa/13awrkcys26mnbg+rok7ZL9SzlEk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxsBF5lmrj/17ZVTHiaSafJqCp08yOwN6jUEYlNfFraCw3TheKP
	En/sD0ttW3H7VtSb+wxNY+X4M6js0fJSUp9jnEaLJ0IyKbvS4rnTHtKTj8yPURc=
X-Gm-Gg: ASbGncuXeOHcxkF39lSKgtKvyZt6LH7TbbJHSVa8/YCsyczdUd9ozhb4eFg9v9Bpxfw
	C8rPrO4BQFrFclToKyT8fPpGr9NoJiR4sWo+oSIWM6Q253iPUxUCViQ9bVfD7S3Z581WCC47XsW
	AJd4f8ff0LT+x3tSw/0R6AIN/AvYWUPS2LHRWBVMawugv9zmI+hH83P5i+4hK04ctwVkQtoIZGH
	v8jjn84KZ5NnKiREVfOqmvFraSCivEk42JJN2zXnOxH2LnrN3SX+sgUjG3ShYvEDhRd3LcaJ5eS
	eYJ0vm8tvXL2QE0yMehN/UnvedUOBprxRjyyLz6qXw79z1IX/L/GZBaWXEXOj239P7zGAnyLOg3
	SgsBvaLczUJ3a6GV2z7h/nw==
X-Google-Smtp-Source: AGHT+IEsDMdO1LukqH/24W5blKW7XDjFNBl/R0uhb5oBxUY8Xo01zzBuQMOH2HSFuOK9L6ypOLUtLg==
X-Received: by 2002:a05:6122:f8b:b0:51f:4151:4834 with SMTP id 71dfb90a1353d-525a84d28fbmr15454973e0c.7.1742981853205;
        Wed, 26 Mar 2025 02:37:33 -0700 (PDT)
Received: from mail-vk1-f170.google.com (mail-vk1-f170.google.com. [209.85.221.170])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-525a71b4841sm2187262e0c.0.2025.03.26.02.37.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Mar 2025 02:37:32 -0700 (PDT)
Received: by mail-vk1-f170.google.com with SMTP id 71dfb90a1353d-5259331b31eso3011950e0c.0;
        Wed, 26 Mar 2025 02:37:32 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCW7MzhUBaw1jFp8m1EcTKkuLC0icm8fqt8ibb0A5i/cJA4+PziI4qQKpPC6HegryLxIOOfdlwy/7N9FSOtbe235Nvc=@vger.kernel.org, AJvYcCX8NVehNaHWaVOdGYyAtL0yHqOPD3iRCtO36ee388twrOfU8QY1MGB27iarj9uPILlWCfQOVx7cqks=@vger.kernel.org
X-Received: by 2002:a05:6102:3e8b:b0:4c1:9159:859c with SMTP id
 ada2fe7eead31-4c50d51d56amr14741252137.15.1742981852057; Wed, 26 Mar 2025
 02:37:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250320091101.33637-1-biju.das.jz@bp.renesas.com> <20250320091101.33637-9-biju.das.jz@bp.renesas.com>
In-Reply-To: <20250320091101.33637-9-biju.das.jz@bp.renesas.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 26 Mar 2025 10:37:20 +0100
X-Gmail-Original-Message-ID: <CAMuHMdWeE=-yx9_m7b7bVrKDQKAW4xVh8A3j4Y0mJfn3wLwYyg@mail.gmail.com>
X-Gm-Features: AQ5f1Jr6-KNlJ61t6_1NKaUP0hyYUv4htC7mU3vH6EaMucMTbrhZ9XUBKdFTH-8
Message-ID: <CAMuHMdWeE=-yx9_m7b7bVrKDQKAW4xVh8A3j4Y0mJfn3wLwYyg@mail.gmail.com>
Subject: Re: [PATCH v6 08/18] can: rcar_canfd: Simplify RCANFD_GAFLCFG_SETRNC macro
To: Biju Das <biju.das.jz@bp.renesas.com>
Cc: Marc Kleine-Budde <mkl@pengutronix.de>, Vincent Mailhol <mailhol.vincent@wanadoo.fr>, 
	Wolfram Sang <wsa+renesas@sang-engineering.com>, 
	=?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <u.kleine-koenig@baylibre.com>, 
	linux-can@vger.kernel.org, 
	Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>, Biju Das <biju.das.au@gmail.com>, 
	linux-renesas-soc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Thu, 20 Mar 2025 at 10:11, Biju Das <biju.das.jz@bp.renesas.com> wrote:
> The shift values in RCANFD_GAFLCFG_SETRNC are dictated by the field width:
>   - R-Car Gen4 packs 2 values in a 32-bit word, using a field width
>     of 16 bits,
>   - R-Car Gen3 packs up to 4 values in a 32-bit word, using a field
>     width of 8 bits.
>
> Add rnc_field_width variable to struct rcar_canfd_hw_info to handle this
> difference and simplify the shift value in RCANFD_GAFLCFG_SETRNC macro by
> using a formula (32 - (n % rnc_stride + 1) * rnc_field_width).
>
> Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
> ---
> v5->6:
>  * Replaced RCANFD_RNC_PER_REG macro with rnc_stride variable.
>  * Updated commit description
>  * Dropped the Rb tag.

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

