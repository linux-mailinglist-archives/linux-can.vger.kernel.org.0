Return-Path: <linux-can+bounces-6023-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DCC4CFEDC8
	for <lists+linux-can@lfdr.de>; Wed, 07 Jan 2026 17:28:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7266232E957E
	for <lists+linux-can@lfdr.de>; Wed,  7 Jan 2026 16:11:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F65A378D83;
	Wed,  7 Jan 2026 16:03:02 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from mail-vs1-f65.google.com (mail-vs1-f65.google.com [209.85.217.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72CF1378D64
	for <linux-can@vger.kernel.org>; Wed,  7 Jan 2026 16:02:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767801779; cv=none; b=u5XNEHHE/YsB1JcFQyM7UYahWAWiKIYcIqQZx1nG8bUYEuNg7FmjwTwyIJk7sBsT7xUfO5TIubnLbqkAk4LFhqX01Mx4By2LXYQGLSAreZQoWLSKgfFpSygeHj+Hf3EJmYgHjA3NvuOw+x8IhwRs5KdISMUJjkYTe+OqzoqWRQQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767801779; c=relaxed/simple;
	bh=9lIABe66qX5B3ULWKN7dRGrBhHh5eVyA9SZWghC2qpw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=r8i2GZ+KE6aRUvswaoxOZEb1Wyloh32mZvVJI9g7yJwG3md1JpyuUOlBOXpbRluWpyoIOv3A+YIf6OOvKdGKUbNe1ftDZucfsfaSSNy+GDQ09mQiHu1uorQSAeE99Ie5za6yEotwYFr+6pJ52b9DTR+yAOOQJw5jkWxNIG0cTFo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.217.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f65.google.com with SMTP id ada2fe7eead31-5deb0b2f685so654203137.0
        for <linux-can@vger.kernel.org>; Wed, 07 Jan 2026 08:02:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767801767; x=1768406567;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8hrZyBiZ9cPjNxWra6rK3FeRhusMqxhmxYkDFplK87w=;
        b=ri4WMSPpOQ1h/NkK+6brErgfPcqfIbyJeW3gT2rhV1HITxruVFz+hX7jccyehhbgIk
         d7QKeUEXBq9pyspPda3wXyX37KyTV0U1eGc9Kqz8xIc7w8Ok/KRaw/ZZ+DUyNTVEEaYd
         XMMBsMS2wMiNgpxVNBEr6zsVPtFicwKn4SdL5Abf9Bz/jYZsso5+o/8NG95TddiIjdgz
         zAkoOadv1bugm3wPPFRpFYk4G18odP0UQYudUlIxhML/udc61u+ItA5xVCOjNeRw1yFM
         gylOA2EVV0OfeF6ChL0rdjf1xMYk8pnMzVFEYNixxPLEhdJ3+4YJZVO22gSpyMacw4ZX
         2F8g==
X-Forwarded-Encrypted: i=1; AJvYcCX99371g/QfLwVF3nHuPUex2ZTEfvSQ6VPEUomFQJkl9/0xo/gvOeF2LuYptSvL6JGaIO/8GBANoK4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxZ8Dr9Mb/itqFzQ9DBmQJfzNiIjSy1yGV7T6aDhcD/ALTYlSo7
	BwmjH+s9h3j7W2gWKKWdDMZtcEh2LMRVbtWbaE0MOZld89+DWz7jMXBis65XLnCBNes=
X-Gm-Gg: AY/fxX6bYZgTMwcP+gRwkCI1Se5OntBBIMRq3qbXkpS/KusH5bADqqJMN3zD8J8UBDW
	Fx4jTT6LYOpVhd9CX8GWrC3O7FlMSaCNZW2L2ssdQOGL/kHBT2igAvkLpcUzdgHLIgFBGkTKiJ8
	dRvCAtLgrdGQ6VaucKiXWVgX0I16H5mv32mUlBGj/sX2SOYGm995d2ZyDaaNOydJ8Po1gheEoow
	4+yjiLfNqz+rp1oX7tzGJq2+iZs9O4uGK1+KqiLlaoogBcmuUEocqXZCgSKYD9ViN/cmavCuqYA
	8TQTPLabDOhxPGbD8XTIONNB/1SpROAGsL7EXfcSN8JYSUwSeHB37Kcjv17LKUKuutCZv+J7c1k
	VGN7Lh2MOZA1IeF9RSDeQsyTKULkggXAyX+phUSFu9P/eNhRQecTGzuVqFDo4kltDadFcEBJpE4
	1TKCwVPkGnvrB62x7UXYFOSNYKByhVgu9cm1roptMytZTZwYqnVdEZ
X-Google-Smtp-Source: AGHT+IFRtCCBul4E0Juv23GS8jlFbBDQT0YM8VRY+clvSH458H8XhN+5slEo8qQ2GtQUWLGwL+GpUw==
X-Received: by 2002:a05:6102:6d0:b0:5d5:f6ae:3914 with SMTP id ada2fe7eead31-5ec8cdfd08bmr1242022137.22.1767801765941;
        Wed, 07 Jan 2026 08:02:45 -0800 (PST)
Received: from mail-vk1-f179.google.com (mail-vk1-f179.google.com. [209.85.221.179])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-5ec772e3300sm3338946137.14.2026.01.07.08.02.45
        for <linux-can@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 07 Jan 2026 08:02:45 -0800 (PST)
Received: by mail-vk1-f179.google.com with SMTP id 71dfb90a1353d-55b22d3b2a6so745990e0c.1
        for <linux-can@vger.kernel.org>; Wed, 07 Jan 2026 08:02:45 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUtEZ5xLwF1HkEglyXCtNvmOW1XVeOPWp5+Bpk8rLYrTZsptbGwSW8UaUuz2gpQff77d7zJC2JE/Y4=@vger.kernel.org
X-Received: by 2002:a05:6122:3383:b0:55e:82c3:e1fb with SMTP id
 71dfb90a1353d-563466b1471mr1147392e0c.10.1767801764769; Wed, 07 Jan 2026
 08:02:44 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251230115814.53536-1-prabhakar.mahadev-lad.rj@bp.renesas.com> <20251230115814.53536-3-prabhakar.mahadev-lad.rj@bp.renesas.com>
In-Reply-To: <20251230115814.53536-3-prabhakar.mahadev-lad.rj@bp.renesas.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 7 Jan 2026 17:02:33 +0100
X-Gmail-Original-Message-ID: <CAMuHMdVQeO6NmrCESnKZkpHWLN6CzrWR-q3VNW7gYMePUP37ig@mail.gmail.com>
X-Gm-Features: AQt7F2q12M6ufG9O3zwEr8RO6qBXtKdp_ZqxDQ3r9v7omAoAEJN2ATl2yMiroJE
Message-ID: <CAMuHMdVQeO6NmrCESnKZkpHWLN6CzrWR-q3VNW7gYMePUP37ig@mail.gmail.com>
Subject: Re: [PATCH v2 2/4] dt-bindings: can: renesas,rcar-canfd: Document
 RZ/V2H(P) and RZ/V2N SoCs
To: Prabhakar <prabhakar.csengg@gmail.com>
Cc: Marc Kleine-Budde <mkl@pengutronix.de>, Vincent Mailhol <mailhol@kernel.org>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Magnus Damm <magnus.damm@gmail.com>, Biju Das <biju.das.jz@bp.renesas.com>, 
	linux-can@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Fabrizio Castro <fabrizio.castro.jz@renesas.com>, 
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Content-Type: text/plain; charset="UTF-8"

On Tue, 30 Dec 2025 at 12:58, Prabhakar <prabhakar.csengg@gmail.com> wrote:
> From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
>
> Document CANFD IP found on the Renesas RZ/V2H(P) (R9A09G057) and RZ/V2N
> (R9A09G056) SoCs. The CANFD IP on these SoCs are identical to that found
> on the RZ/G3E (R9A09G047) SoC.
>
> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

After downloading RZ/V2H Hardware User Manual Rev.1.30, and noticing
CFDCnNCFG.NSJW = 0 is no longer prohibited:

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert


--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

