Return-Path: <linux-can+bounces-6025-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 271DECFEF7C
	for <lists+linux-can@lfdr.de>; Wed, 07 Jan 2026 17:55:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 94A8D300160C
	for <lists+linux-can@lfdr.de>; Wed,  7 Jan 2026 16:55:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D42738759C;
	Wed,  7 Jan 2026 16:37:56 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from mail-vk1-f181.google.com (mail-vk1-f181.google.com [209.85.221.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C62323A9D82
	for <linux-can@vger.kernel.org>; Wed,  7 Jan 2026 16:37:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767803874; cv=none; b=c7X49h9QJcXmNH3muVGA8Xlw9fSZ3bx8bl+cmPGj+/TveN4qwWUG4XtaKSzljpibCj1Xxyfx+tF1gVhEF5G5SJZ/DbtzL035wVHoASAIB/xz/ROwrGnDynTmER3orRiBjff9fifviPLZD5uonG0MagoOCz01IwtyQktLZSxG5ok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767803874; c=relaxed/simple;
	bh=lUkjukYyPvno8s3BJtqS71STl5+uBWJ649WSJU0Z1ms=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aMSskTVGCpGS2gB7ncMARxfuDoZzXpwXI16aEn0r/KnOa5aQWA3xs7CDK60dVTSMymt50lURDKqateA+tDKE4xIf5NGhioGmDx7eTrxGtGlAM96NbVEoen6tjDc/MWgiaX+3l6UH5UytkaCt0H4SYM9yz4rzNACATd6990776m0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f181.google.com with SMTP id 71dfb90a1353d-55b6a66f155so921355e0c.3
        for <linux-can@vger.kernel.org>; Wed, 07 Jan 2026 08:37:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767803866; x=1768408666;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UosJZ8iJR6qWLllsBRVQrPIUMjEsIPO/Cc8wz2jLzzw=;
        b=Xed63SWYMFMP1GDoe8+4vbBirpfocUMv480L4R1hgwH09vXJ5VBVX0TmvUrzbRMPdN
         4LFFsKGnYyOVDlTCVFkk5jGR/RloIBRKakN7fEVmksJgvAwizIgvTyDiOAvXL0zZUn57
         FzzZvhye5IX7L2kyySbDRCBDai6DbCQKWZXtY05aUGau3SuGo4n4cO5+84KPxTBBaWtR
         lhMul/ZWznAc4UlaYVJR0rGT4mJP6RjukSi3EYGBoTsgpVCrXUAL/9xqXiJR9hZcjo0S
         WxBqfb7/5lIfHOsQhon23PUf1ey36/g1qNlv0L2xPvHMkcc7Vf7ml719W6RxoEzK6PWi
         FE1w==
X-Forwarded-Encrypted: i=1; AJvYcCXM3TNQOnWI82JPKTzwN3j0VeZaE2j1PhA4YI6pfwJY2Ap9+Vy8SGsMcKck+JbesZHsFHvcVKxmBaw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxHshpfpikbpQ2uyTyDzcy96McTwz04SQEIQadPaXHy91v6AJLZ
	E+CHXxVmnSrIGahgTDpM22/8w1eD2tG0nzKJ2bRs9fjVwLoTNY3gIQhHdgqdf8KB
X-Gm-Gg: AY/fxX4/x9MJYYqyCejFv4eOI4gwfpSI//cWOVzcb818ydSighzrmXQljFCn60mjgh4
	HrIDg7hEh9nEfDLkO/6bpZ57roqIA6MXE7ttFivXRmInIP1XPX1/5FxBCn9+dvr1Re9IyIQqwqr
	iBRvOFRTYTxyd1iZ0NBWLicJDUMo8HJsk+kjoxYtxLJyHCrvfhuOM0i95y6AbIYP4lGIzsRU12s
	N3BMtozLDMyQFT6OHvbVhNQBVvz9+GQ8LK7EISrA4vxILu9EZng0M0jaFLsXHH9OoXO3ZMFpacy
	HgS0e1637FQFBH14e5ZLZ6iAgcbuTu0Bi2ldOH3ze4r4urECw0za9JvSmVHqqK5ZUGvZ94jw9O+
	bNr8jY2wHS4W3H/kqy2EcquTskhmmok+ySqjtFJimpDUFuLGsQPdIgQ2r0Z9jWah9rF52PcxxRu
	hQy4ICcvJb6pr91JN/081HmUg8ETeKRBFVO0YXz+B33E7g0+E8
X-Google-Smtp-Source: AGHT+IEdyS+7jFFAfkHQ0RQI5Ja9wp+wy8Bl/+2KL8/Ya9kkeW8mtkV9Ey2+zE30tGnaL0cP+5WirA==
X-Received: by 2002:a05:6122:18a5:b0:563:5143:e3ec with SMTP id 71dfb90a1353d-5635143e624mr392433e0c.2.1767803865696;
        Wed, 07 Jan 2026 08:37:45 -0800 (PST)
Received: from mail-vs1-f51.google.com (mail-vs1-f51.google.com. [209.85.217.51])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5633a1ea810sm3382145e0c.5.2026.01.07.08.37.44
        for <linux-can@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 07 Jan 2026 08:37:45 -0800 (PST)
Received: by mail-vs1-f51.google.com with SMTP id ada2fe7eead31-5ecb1d9ac1dso629916137.0
        for <linux-can@vger.kernel.org>; Wed, 07 Jan 2026 08:37:44 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXh2LVztPOzwg9XDHQs0QYPJKB7UcyZAeAY7zhxvneI870vNKP6agGUpvwdUKXjGD22x6kVuUfut+o=@vger.kernel.org
X-Received: by 2002:a05:6102:9d4:b0:5dd:b2ee:4423 with SMTP id
 ada2fe7eead31-5ecb1e904bamr1400550137.11.1767803863532; Wed, 07 Jan 2026
 08:37:43 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251230115814.53536-1-prabhakar.mahadev-lad.rj@bp.renesas.com> <20251230115814.53536-5-prabhakar.mahadev-lad.rj@bp.renesas.com>
In-Reply-To: <20251230115814.53536-5-prabhakar.mahadev-lad.rj@bp.renesas.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 7 Jan 2026 17:37:32 +0100
X-Gmail-Original-Message-ID: <CAMuHMdX5_TkFmgqv29Nddo4bZzEWQrL87kwqTdiLwfq+qMtsXg@mail.gmail.com>
X-Gm-Features: AQt7F2p4l0yE7BHZfa9XEcOswGFhJAJZ7XFevRuwZFhhiVQ4xn01o825gjpFphg
Message-ID: <CAMuHMdX5_TkFmgqv29Nddo4bZzEWQrL87kwqTdiLwfq+qMtsXg@mail.gmail.com>
Subject: Re: [PATCH v2 4/4] can: rcar_canfd: Add RZ/T2H support
To: Prabhakar <prabhakar.csengg@gmail.com>
Cc: Marc Kleine-Budde <mkl@pengutronix.de>, Vincent Mailhol <mailhol@kernel.org>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Magnus Damm <magnus.damm@gmail.com>, Biju Das <biju.das.jz@bp.renesas.com>, 
	linux-can@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Fabrizio Castro <fabrizio.castro.jz@renesas.com>, 
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Content-Type: text/plain; charset="UTF-8"

Hi Prabhakar,

On Tue, 30 Dec 2025 at 12:58, Prabhakar <prabhakar.csengg@gmail.com> wrote:
> From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
>
> The CAN-FD IP on the RZ/T2H SoC is similar to R-Car Gen4, but differs in
> the AFLPN and CFTML bits and supports two channels with eight interrupts.
>
> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

Thanks for your patch!

LGTM, so
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

However, compared to other SoCs, CFDCnNCFG.NSJW[6:0] has:

    0x00: Setting prohibited

Perhaps this is a documentation issue, as the same limitation was
dropped in RZ/V2H Hardware User Manual Rev.1.30?
Linux also has no can_bittiming_const.sjw_min field.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

