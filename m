Return-Path: <linux-can+bounces-6173-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 52FE7D2E83D
	for <lists+linux-can@lfdr.de>; Fri, 16 Jan 2026 10:09:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 5F2B93033669
	for <lists+linux-can@lfdr.de>; Fri, 16 Jan 2026 09:09:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 401E831B108;
	Fri, 16 Jan 2026 09:09:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KB6qHY9a"
X-Original-To: linux-can@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7380B31A07C
	for <linux-can@vger.kernel.org>; Fri, 16 Jan 2026 09:09:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768554547; cv=pass; b=iWvjR9mC1DOr9hM937XjRH4cwZjWo+BFXqnD+I5iIjgkci0FHbdYh9YG3376irlPGryZEfUB0lO86AcT8Gy9+JTXHSi3mnPg0auVDwzPa6iuxNLsnnE78M35+Q6fqMhr033u92YvxPJn/S0e6K/eDGY+7d+mYrPUCdSvRljnyTo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768554547; c=relaxed/simple;
	bh=PjK03eNHVu54e46b4LG7wzxw1HUYYstUJemKKBLfOos=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lmOxcsVe7HvQBnOfdsasBl+AAH8Oph6ZwEcAIOgF4SHN4/2bhvhN1LpQHUyZ8b314Su1EWPgZ5Wv3VOIsQUyxFPjZLmTCbNTpZfAsOqS9sL3g2ID/lkRXAZOf8OUJ4oeMqjYwYBwR+AqswjrYurGJPu+IkbPKkCy0vDz02pVAKQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KB6qHY9a; arc=pass smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-47d1d8a49f5so10656965e9.3
        for <linux-can@vger.kernel.org>; Fri, 16 Jan 2026 01:09:05 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1768554543; cv=none;
        d=google.com; s=arc-20240605;
        b=NtxCAsoljS1dyFYI/t0rBjUPlHOSjlnV27AqJXMOd3ui8rF6X1wlsFx488q4WTCuzB
         oPMa3OmkwM9u44x1EaXqxy9asKHFSosDAxqq9AdAO3sC5oHTivN0l7Sno2MIlgO7z7qs
         vRpKCIDim0CqKuBUkEO9nsmVr43w0ewi5hR9fBIQBfRnddniWR+0cM3JvEZ2sg9EwUql
         LFFDu5dAeJvBOGrA2Kgz/7xrV8yJaXn0sqwnxi8xoV8ZZjesEY6YwvcY+wOlP5oJb9x4
         xRo1WTsMi6BsPnUdtqlPRznQzO9fhwkMX+kTTaEZDKZtlXnXPipbZxKSgduZsZ7FQ8ri
         gEAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=p3RHWH4ytRePUw0e46MQem9UGA0Z3K6iBpKhJ5leauk=;
        fh=RcRvOS29w96YzNGhphVbe3lLtAsV2BoNBMsT3p8b29w=;
        b=Mw5VU7RqIj/BDK/GeOMJQp9Q+cv041k3ahEzGZtcG3BsjX2wEt9bDlH4SKMMRLeD/K
         tkQTe2y6LoQgOb/f7h+aWb/xPjUExYNKV64xJHNkgVceySqtQov+LhqoijiyHQZQSM67
         FcdGxz+NXl3TQ5HFMXpIZYZitcOdPOsf4sua30PPFcDvEozAJCFIySKQMNpiAYPPQqft
         X2w3f0M7vn3ulnkUn7xAC/gAXvTIuIb9z8cw9hvTzvNTjdQJ3p9WmH2/vXwAuuVi1uAZ
         fc7NLAo9oohu26WqPe4vY8146b/r4jK+TVjuQVrRAShpnzRSizjpmfPXWQQc+9FS4aR7
         ICIA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768554543; x=1769159343; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=p3RHWH4ytRePUw0e46MQem9UGA0Z3K6iBpKhJ5leauk=;
        b=KB6qHY9aUmTlBw53ee9wvSbISR0dx0CFgMdP0XMBBFcmCw1xuCagmejYQTKbQ4tUGd
         VvHZJ//mpdIU5xCmnV06hmvqZpZM4ZseEHfzjtKOnGGLQwVhtDj3VAcj72LYErB5yd+b
         yhDMOO64iHxD+s6nh4Pu7uVuuWqMziMHckk3gnQpYDDCCmzd/yyQjxX7CoWPOnUUxgPL
         3szzRJDiOqWw6elaFH3jERVKRYmsbwus2VRMfCPDO68b2LR26/ZzjZaW3a0TYxYEOwmB
         LAY/sMEEBX6tF+4v1u3gud6y/7nepT2Eekh8FWzjhL4g6cqhdX7emL7zivvibYnhOjHa
         u/mQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768554543; x=1769159343;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=p3RHWH4ytRePUw0e46MQem9UGA0Z3K6iBpKhJ5leauk=;
        b=cfdj5csgYL3UGOvFxlPyAQac80bZlIbfx4/1D8So2Z4dksCSQDQX8/OJToWAZgbHn7
         oOXVPdtGLk83aeFmke/LYaghS81xyhJiEbgbkqUomLYMQIgK7Qiz92vlWXnPxbBOaH5m
         2dYwFHieTrEQRF2DyBbXL9/+vzKtZ++coCR39sx/rF2/ylxjZR0bH7KeNDylmPTB9SBL
         k5jm63VGBESlyZYCq0O22ub28cPtHWk1IXDKgA1TOkb2hG015aDVyq5Cbkgf0ClNusJF
         IMjyifdD07c6slDCGjdm7CZAJUot0IY/nXM9TkCIOhhCIAS3Ggn4TsYQjYqxIM+Ty3Mj
         HQSA==
X-Forwarded-Encrypted: i=1; AJvYcCVHhTS6O6bNbqJOlSKb11gzM4MoLcwxOBIsPLnMjD9ZQg8BfMBbvqo3H1kTpo9CyKbmJNKowc2dZug=@vger.kernel.org
X-Gm-Message-State: AOJu0YyO08vq/llzc7EqJyXumG8q27LsnldwslFiWuG4/Gu6LV4KaKth
	FLySYsEQhhLpYym32DOkQURodaTe2uHheZQGJNVxQpMJpbKpWbLSpmfFD+YMiz2G6buNsO8MWiE
	qTEdWxddUlpSnt3EbhxqxwZkCOhHCbpQ=
X-Gm-Gg: AY/fxX77p1RSI+REEmcPacDn70213v0my1kZ9NmaWBRgZ9o/w8A9dsinkS+bmysbizA
	ByMjipGcSooX78DLSL4gTyeD64T/tR8mnwmDm+bqNaPKY9xhkHthEBJeZs+DG3g5ovtb/hKhgkP
	JGJ6jQ7iuTK61h3aJ/eUIbpltIW7oZnSJYOGmvuKrY+1ph14Z9/wEbiYJMX+InYS1e521kVdmA5
	WuYuGSmz0P/65FJk3GDeVLI7JwZR2Hvn+PhEa6q4R8/6P3dY+gjbpVv/OrMMt5Lp3X+NWXZYgCm
	HddQJ9B9AZWWQogJMy5VucphNdNBroZRNzbS15M6cG0h/eXqIflMgCAMAw==
X-Received: by 2002:a05:6000:1865:b0:431:8f8:7f1e with SMTP id
 ffacd0b85a97d-43569bc7bd8mr2589126f8f.48.1768554543273; Fri, 16 Jan 2026
 01:09:03 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251230115814.53536-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20251230115814.53536-5-prabhakar.mahadev-lad.rj@bp.renesas.com> <CAMuHMdX5_TkFmgqv29Nddo4bZzEWQrL87kwqTdiLwfq+qMtsXg@mail.gmail.com>
In-Reply-To: <CAMuHMdX5_TkFmgqv29Nddo4bZzEWQrL87kwqTdiLwfq+qMtsXg@mail.gmail.com>
From: "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Date: Fri, 16 Jan 2026 09:08:33 +0000
X-Gm-Features: AZwV_QgFbQun55gGsT_2ZrF5-QmyzEueFq5_0nBPjc3PDQivLg_YkXjnYFLjBnE
Message-ID: <CA+V-a8u4o7=PXjE6nw9Bfo7Tn8dFoMQB-LGEuqk6skK_7zXCcw@mail.gmail.com>
Subject: Re: [PATCH v2 4/4] can: rcar_canfd: Add RZ/T2H support
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Marc Kleine-Budde <mkl@pengutronix.de>, Vincent Mailhol <mailhol@kernel.org>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Magnus Damm <magnus.damm@gmail.com>, Biju Das <biju.das.jz@bp.renesas.com>, 
	linux-can@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Fabrizio Castro <fabrizio.castro.jz@renesas.com>, 
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Geert,

On Wed, Jan 7, 2026 at 4:37=E2=80=AFPM Geert Uytterhoeven <geert@linux-m68k=
.org> wrote:
>
> Hi Prabhakar,
>
> On Tue, 30 Dec 2025 at 12:58, Prabhakar <prabhakar.csengg@gmail.com> wrot=
e:
> > From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> >
> > The CAN-FD IP on the RZ/T2H SoC is similar to R-Car Gen4, but differs i=
n
> > the AFLPN and CFTML bits and supports two channels with eight interrupt=
s.
> >
> > Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
>
> Thanks for your patch!
>
> LGTM, so
> Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
>
> However, compared to other SoCs, CFDCnNCFG.NSJW[6:0] has:
>
>     0x00: Setting prohibited
>
> Perhaps this is a documentation issue, as the same limitation was
> dropped in RZ/V2H Hardware User Manual Rev.1.30?
>
I got confirmation from the HW team that it's a typo. Similar to
RZ/V2H, setting it to 0x00 results in 1 Tq and this shall be reflected
in the next UM update.

Cheers,
Prabhakar

