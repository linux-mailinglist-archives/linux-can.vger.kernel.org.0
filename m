Return-Path: <linux-can+bounces-2940-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 89AE6A41AA1
	for <lists+linux-can@lfdr.de>; Mon, 24 Feb 2025 11:19:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 504783ABE8D
	for <lists+linux-can@lfdr.de>; Mon, 24 Feb 2025 10:18:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 899AB2505B3;
	Mon, 24 Feb 2025 10:18:20 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from mail-vs1-f43.google.com (mail-vs1-f43.google.com [209.85.217.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BCB02505AE;
	Mon, 24 Feb 2025 10:18:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740392300; cv=none; b=bLMt1Bgkd5QZe8SEKSay+ROSC6D6Z3QPHa2HYYNHCZATDJbReb7B9AtVh89ADH0O8SIpgjmeoG4c8BpTXDL7lqpjL619J+WrpR6NqB0Bnt0KCfWBOUF7MptlzKTgfC6Mxgot3WwbNKeORtGvLTiktFh0k/ABvQFxWGrDxmLy+0E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740392300; c=relaxed/simple;
	bh=/VpVHJ3s7Jn3EBgryl5k0MVY51tDK0uHrVOkZxmbga8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Z7Y+xLqULBJSzqpT0+07XWmjjgZltrsYkZyIdy5UKxt7stPodXip1VrG4umlQycoXMD6F9dUBWiPcmyrcsUOJpP6mL+LPFpDAvSjrgM9UbNesBmVwwC0nu+XyT9V6KT7ONm/5Tyq4K+1jaUGKXehH5ZTbDQmwjlRpWIetrjkAeE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.217.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f43.google.com with SMTP id ada2fe7eead31-4bd3c887545so2739994137.1;
        Mon, 24 Feb 2025 02:18:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740392296; x=1740997096;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LrlRdIj2CimNW6XnmPiBdulQZl1isrHwMrX3fvUaveI=;
        b=IuklKElCO1cQmsU5B5XQ6N2G2hxtkzMzTEK0SBW+2rbRlB3x5wyqyZPaOJvXLM2c2c
         PA3UYdn7sKLjFAuosaSUXm5XIBwmkrcMMIYi78L4Jcc8lxYhnRW9o/UHwtAo2dZuaJfS
         V/QFJqQRYHoFVNpCH3uNpR8XHINHMesLSSN2gpmaGbrFSSkH5n4pSYDFIlzyFnW11UNd
         8QGR522CczsTzjpskohIDxfX8injGgt5A0g+5jNiiCdZUtM9KrYFcE6iusVyBOuCuz+m
         PukEUVzR/1l7gub+4yDiGx5opSHh7l0KgSJgkt9CVDGxb4fDxPiV7dw2bGg/VXZbSh73
         7oTA==
X-Forwarded-Encrypted: i=1; AJvYcCUfD1sAENhLLe6Kw0NHFaA8wPsn9W3GALAsAb+ntJox50Wj8MHoy2rrV6PA6ugCMJ60I0Y8n+p9cdY=@vger.kernel.org, AJvYcCWe3xikpYZbHXCo2Rxiw+LQ+SGXXfreZbw1EckR7LbHat1cIphe5hf7Loh2gOs2gGLKcx3S9RRW@vger.kernel.org, AJvYcCXaRQA3BOmAz9FVMhIN3HlkTmge7WSVmiEA/wscX7qqxFVBekBHFdR8CUJvkXK/p6BE0x9N9rdE/zeNlmQJ/e7my80=@vger.kernel.org
X-Gm-Message-State: AOJu0YzACEuHYAXa+W95xm3EZzCB3FlcdvExVdUNvsttJF3kCuOhAemf
	7RxGTXv4saMk2a6Z5EU7B9wFtbZWrmmtN5NlXhSiowVg7Qy818thPD9dxrwnk8g=
X-Gm-Gg: ASbGncsfBHh/bAp+9l3pC+//wjNVcfj8skFjJWawWjGLCrarN3rgfwK2BkRZU1ms46L
	QnqS+zm3Tj+yUTlzie/DOoxZFn55cH+jM6banIPzCgs1ZlIQTM7Yb8WY2mSVz2CzCxDfwN3u1nt
	yYJWP1FDRi9g8K8fZ8u0yjClgLO3zYnk4envZdd+1Dqt4PBLddERvgEHgqtflOhdk21S7ydgbMc
	1Q7ryuUZFsPpWiBfQWSbI8lwWI+QeZaXOE9XqrbySt4vRp28VZbq07VETE0qXwhcEfuWkamTJ2I
	DA/2Ioa6o4ZkJLmQMboIMjU6F73v/uBvRMbV7pmjHEyohB7Z6eMpaz8ppx0JSlXx
X-Google-Smtp-Source: AGHT+IFSsR6YRBwn2eCUt/iUKk8khjd2JXLS1qIEzGseREz6RFX5oXlqNj/AjvC4t5zMr7D13qeaiA==
X-Received: by 2002:a05:6102:c14:b0:4bc:82f:b4bc with SMTP id ada2fe7eead31-4bfc02880aamr5662082137.22.1740392295965;
        Mon, 24 Feb 2025 02:18:15 -0800 (PST)
Received: from mail-vs1-f42.google.com (mail-vs1-f42.google.com. [209.85.217.42])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-4be1a9a3822sm3502953137.16.2025.02.24.02.18.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Feb 2025 02:18:15 -0800 (PST)
Received: by mail-vs1-f42.google.com with SMTP id ada2fe7eead31-4bd3a8b88f3so2444952137.0;
        Mon, 24 Feb 2025 02:18:15 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUwoDLcAodx3x6Ll7Ym2Q6TLc/tQ/n2nZJQddYrG2InlbzEsSiCPGZj74Mw7Igd4hZVfd7DOrheOP4=@vger.kernel.org, AJvYcCVdUVBcfwIuHMo3t+uARcv8sKYAeraPlgBIs2u+GlTx0T2erz3a05VHGMuZfgB+2cduCV3Seg45@vger.kernel.org, AJvYcCWj77JfsidKaXhIZhmvFzke17+6Uc4PKeAt69NywOVwK5S+iGt87Ekd7NQT/lMw5yIjHuIosbJ1M5myUTi/TwWO3mc=@vger.kernel.org
X-Received: by 2002:a05:6102:3593:b0:4bb:d7f0:6e7b with SMTP id
 ada2fe7eead31-4bfbffd0cf1mr6338358137.2.1740392295077; Mon, 24 Feb 2025
 02:18:15 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250220094516.126598-1-biju.das.jz@bp.renesas.com> <20250220094516.126598-3-biju.das.jz@bp.renesas.com>
In-Reply-To: <20250220094516.126598-3-biju.das.jz@bp.renesas.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 24 Feb 2025 11:18:03 +0100
X-Gmail-Original-Message-ID: <CAMuHMdVYKPMshDretnZRCaz613p-ME_HxGGDiwk0iYkrL+GzBw@mail.gmail.com>
X-Gm-Features: AWEUYZkygmUhDACpC7iEbloeV0w5GXdg3MO9FhTnEcknUdA1U1h62at_rEbRVv4
Message-ID: <CAMuHMdVYKPMshDretnZRCaz613p-ME_HxGGDiwk0iYkrL+GzBw@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] can: rcar_canfd: Fix page entries in the AFL list
To: Biju Das <biju.das.jz@bp.renesas.com>
Cc: Marc Kleine-Budde <mkl@pengutronix.de>, Vincent Mailhol <mailhol.vincent@wanadoo.fr>, 
	Wolfram Sang <wsa+renesas@sang-engineering.com>, 
	=?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <u.kleine-koenig@baylibre.com>, 
	Rob Herring <robh@kernel.org>, Ulrich Hecht <ulrich.hecht+renesas@gmail.com>, 
	linux-can@vger.kernel.org, 
	Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>, Biju Das <biju.das.au@gmail.com>, 
	linux-renesas-soc@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Biju,

On Thu, 20 Feb 2025 at 10:45, Biju Das <biju.das.jz@bp.renesas.com> wrote:
> There are a total of 96 AFL pages and each page has 16 entries with
> registers CFDGAFLIDr, CFDGAFLMr, CFDGAFLP0r, CFDGAFLP1r holding
> the rule entries (r = 0..15).
>
> Currently, RCANFD_GAFL* macros use a start variable to find AFL entries,
> which is incorrect as the testing on RZ/G3E shows ch1 and ch4
> gets a start value of 0 and the register contents are overwritten.
>
> Fix this issue by using rule_entry corresponding to the channel
> to find the page entries in the AFL list.
>
> Fixes: dd3bd23eb438 ("can: rcar_canfd: Add Renesas R-Car CAN FD driver")
> Cc: stable@vger.kernel.org
> Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>

Thanks for your patch!

I hope to give this a try on White Hawk and Gray Hawk Single, where
I never got any channels beyond the first two to work...

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

