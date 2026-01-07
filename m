Return-Path: <linux-can+bounces-6026-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CB11CFF61C
	for <lists+linux-can@lfdr.de>; Wed, 07 Jan 2026 19:18:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 75B4A32C73D0
	for <lists+linux-can@lfdr.de>; Wed,  7 Jan 2026 17:15:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BAA23939DC;
	Wed,  7 Jan 2026 16:38:02 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from mail-vk1-f196.google.com (mail-vk1-f196.google.com [209.85.221.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9BDD3A9D82
	for <linux-can@vger.kernel.org>; Wed,  7 Jan 2026 16:37:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767803882; cv=none; b=SNEMWg9EcB9tUI4rEGxWK2YdW9p3iOTMKuaW+VLqx1plLxWa1zP05e1BzkBDC4o5ccw4gRNZQrdqRGucXY4CtRRTpg6lfHVZplY0LcZ6BM+JTUvz2ApXBQEZ5cuh6u4K7OH1sj6As0wPvKq6XXw93Sp5cBNYRCPWDX+VwMZt6yc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767803882; c=relaxed/simple;
	bh=GXHtf0v34l9dMsk5oXU662hmJwODCVQiZecT5r2kdds=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ozqRV1CHvYADm4Zyb9oPcszuT6kjqOEmuMl3BXDXVD1AXbmzTnuNgpcW1WnpyTtOpeAPJ6Q01FqHkWgrpdrE0SWdHT/12yeOpwhbDNpHpR/V/0jwHz5jSJnEc4Wq/OZmlXDsHGXDLx7J8cb8c4/7PtAOP0ad0Oh2290t8x2lVB0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f196.google.com with SMTP id 71dfb90a1353d-559a4d6b511so363527e0c.0
        for <linux-can@vger.kernel.org>; Wed, 07 Jan 2026 08:37:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767803872; x=1768408672;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PKu9A7wTbG+gOHLtE+m+HecdyeAHdeY1vKyGmb5DtV0=;
        b=gLUJ1mspAmohfdDjhJ496b8YLAPo7a8NrzwjVGidfkYwj8e6FnrNEzjS2lyO97l0Zr
         zj144XkveHCh4rpf4fN2p1mF5uDMZPusW++eTY9aEQZ8gx5Ekt6s+sqLRNCs8HqsqQyw
         nxFvyIMWnUWsoZN7D8owAvmb/tXsz0L4Vx6mClJQZSuccDry3dF3EyuX32YcetRFDMfT
         oeun3G+cW8lLrf1hstFoflB5WCvUhz+7n3tugjFLqaLFMITYL2cyahFe9A8+tTCQOcPf
         wKTlGoOhzBKB05NEHb6HSusso0Wo2vErULrdVEajkuXwPNbzoz9Xvxuuuuyr88YM090/
         mASw==
X-Forwarded-Encrypted: i=1; AJvYcCUG6YLllmdsaZRu+HFWuCAoEqYzWE4+rFGdmzwGcNp5vbLsBm7hSU/Ruxv3XPMMnIHbY5292TWkkeY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyGqoHqCo2GexsE/W9r2z6OjRqMhvfzZ27zNjk2bF9EAv0DpcMQ
	4y9Jds9T8yWYC+FA04xA8YGWyrIRQpt9iAulmjHvfyMkKg3NEc/4sgDKFtNb8liEFoo=
X-Gm-Gg: AY/fxX6OlpFuHvPWxEZBGrMfkrYqJFLE61Q8dl1gzstGsVAdi12dSsj2cxNjXdERGrq
	+qU0Bkw0/64aqUjWP24F9H/E3RbIw2XMuK0yUQozNHBOXq02OZ79oHjZSxT7ELeh31v38F4HNYY
	WRm1fkYSxeICsvCqryQLo3tqrE7BZvGFpkoZWDV6xS7rnL2u1oRdhenGia6HdRqJRWmVMlt4nGP
	bRTwBxGXUKmz2hKRFzGPJHRdYpvndQCKyL9gDFMq/DFfbCRZemGG9KCP0NMWmchvhUXDa1HyP5B
	cMPfw4aT5AKR50/SaddXMRDJK89qob7fNjxP5HMPZfN+GWwIpdjGc5HlE8mV4goJTJ6LIZxF+Hl
	noE5lcxJHUF0A76uDEJFfCtKSaE5Ut3bwEicJb/CTNykomLkae43gPdBtNGeuMeHlpmCY/R2g8h
	2accCxjqqlS7DRxtITyOO51jkRde133bqUbFhJ7F+0VS0C/0JR
X-Google-Smtp-Source: AGHT+IHeu9c2auHLYuwYvW80vSX4G/QmDfv4526IWFe+v+uQU8NYzyqz06ypvprOqppLQGBb2FnlyQ==
X-Received: by 2002:a05:6122:d15:b0:544:75d1:15ba with SMTP id 71dfb90a1353d-56347d61e20mr941153e0c.8.1767803871972;
        Wed, 07 Jan 2026 08:37:51 -0800 (PST)
Received: from mail-ua1-f46.google.com (mail-ua1-f46.google.com. [209.85.222.46])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5633a414242sm3401576e0c.16.2026.01.07.08.37.51
        for <linux-can@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 07 Jan 2026 08:37:51 -0800 (PST)
Received: by mail-ua1-f46.google.com with SMTP id a1e0cc1a2514c-944199736ebso467180241.2
        for <linux-can@vger.kernel.org>; Wed, 07 Jan 2026 08:37:51 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCW3q28hygCu9vmZTk2+IngHwoosPQIfUVAqiaeK8eyqQlfEpDzWrIAjrD6Zy2go+Knon6IcfTm9vOk=@vger.kernel.org
X-Received: by 2002:a67:e716:0:b0:5db:3d11:c8d6 with SMTP id
 ada2fe7eead31-5ecb5cb9155mr1165051137.5.1767803871092; Wed, 07 Jan 2026
 08:37:51 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251230115814.53536-1-prabhakar.mahadev-lad.rj@bp.renesas.com> <20251230115814.53536-4-prabhakar.mahadev-lad.rj@bp.renesas.com>
In-Reply-To: <20251230115814.53536-4-prabhakar.mahadev-lad.rj@bp.renesas.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 7 Jan 2026 17:37:39 +0100
X-Gmail-Original-Message-ID: <CAMuHMdWYuq=x1hDb1m9D=H=rY83pqcJztXW37OA-ReXAaitGKA@mail.gmail.com>
X-Gm-Features: AQt7F2qaXZupH8vZG5zoME2d29ysW6TbxB39ZBn0ObCH0qVc70nPQN5riXV-6zE
Message-ID: <CAMuHMdWYuq=x1hDb1m9D=H=rY83pqcJztXW37OA-ReXAaitGKA@mail.gmail.com>
Subject: Re: [PATCH v2 3/4] dt-bindings: can: renesas,rcar-canfd: Document
 RZ/T2H and RZ/N2H SoCs
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
> Document the CAN-FD controller used on the RZ/T2H and RZ/N2H SoCs. The
> CAN-FD IP is largely compatible with the R-Car Gen4 block, but differs
> in that AFLPN and CFTML are different, there is no reset line for the IP,
> and it only supports two channels.
>
> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

For the content:
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert


--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

