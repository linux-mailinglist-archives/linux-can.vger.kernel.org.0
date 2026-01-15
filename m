Return-Path: <linux-can+bounces-6164-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 05E3ED23DE8
	for <lists+linux-can@lfdr.de>; Thu, 15 Jan 2026 11:14:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 39367301919B
	for <lists+linux-can@lfdr.de>; Thu, 15 Jan 2026 10:12:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEB5735502E;
	Thu, 15 Jan 2026 10:12:40 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from mail-ej1-f67.google.com (mail-ej1-f67.google.com [209.85.218.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3725113D891
	for <linux-can@vger.kernel.org>; Thu, 15 Jan 2026 10:12:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768471960; cv=none; b=WPgipiv8bbKmexwW8B5bDqYfUXcmY13C6hr2arYyWOHebrxvNW+8xufUtXL5SS7aGqHen5xR+ehdSWy2vRfUuwMClDA4dXspo+vHeNljLECu92S+i2Rhci1qv6Kr96uQHDKyq0mE054U7EoIIDeLnYeZXipwl0yxiSywbKObU5k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768471960; c=relaxed/simple;
	bh=8N82thDgrk5p6pX6tvbenU7sVXEEobs2da6ZlAwkjnQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tLyFMmnjqQexAMgc/NcUPNKlalisSZdiyRbA6s0t9g8deUXYqcTGYgoXF2afBOlHFaSl89BPcqiszKqr4zXwq52+mszNq44G/O3gUIxvs7UpSfj2Thf9YRFD8z96rOnc5SUOOwngyGvj5XKdVMKNhJPU+002r5Een6X9biAkSEk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f67.google.com with SMTP id a640c23a62f3a-b8708930695so125296866b.3
        for <linux-can@vger.kernel.org>; Thu, 15 Jan 2026 02:12:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768471957; x=1769076757;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NfY7yocCbDQpyXldKITKmah5CeSNudO2PtXu0jreSTc=;
        b=Eh3o5wx4IdSEaUG+EFu4b2c8fjQ3E18brAR99ZqGA8LctU6wYtxVUpYvki87qfJKQ0
         NGUgE4Y2blikrDQgd6C90wU9m0Wjlp9a4Gw0MAlCRgCM5+v36r8k7QFCQu/fT4tjf8Pu
         I3Tj+aH7QOtVER+PfLy5anpO3hJa+OgU6KlGMvl5gaPsQGGW2QS/hynQNzl9MdR5s180
         oVPjYhGO+MfdDacCvFWensFqwthd+iOfofgfbtLquHcHmN5oUZF2I6tU2/NQCgpYJaXT
         MYizseVGEGdyr4/Ijdd17qS5+K3/hO5L0UoTXgRjklwCYTiWKDmTWQcmExuYNW/0UOlS
         fK3w==
X-Forwarded-Encrypted: i=1; AJvYcCVyjhqFlI1OO6y4k5KvTIZHLP7LsFW4zHHK3Wy3xQ44oRRdID3MF/t45YfdPpZcvrghKvRRYY2bvFg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzTFSIUdg0giZ3bWOnW+JbsSOIjFPZbpl6vBhAoc3XEbrwAh5oO
	z2tye/0NPDoIHfRY+sgCJj+qowB48WMS1qR6FqFqAgZFtLzZhCIHLrv5oGjB9fYNZoJq7w==
X-Gm-Gg: AY/fxX5x3o/P3tlUmJNMbg0cO/XCinIwWwP2hGtr0yL0Mg00QPpFX24ueuhagD57NYX
	7sBEASWld8YfZMFfE7IiHP3RVeTg0yO1PXcQ41aVxGPth7HHYRfSt24PwWCxfbHJbREAdIOkp73
	8OLzGWOikQc6NPJU9K/FQpzVYgKDE7EXX69gLOAxvyJoRIaW/5BiHpVSDpCv7mzbKNed1ndptVz
	xq4K2Pk6GlSNEpoYHGs3NF4caSh9hVCYJSS8DXAiE6GARa05NysuWud+sMI1WekR2Wfo81solxm
	OSEgiyv5ijAnapHFEprv+iF+BAMWWcroYGbxgZicA374rXMVTramP3ZPrcWXowHxOjF7E016KmF
	x6HcneCppS7yoZP9Rn5uHdtkm79V8c4A/rlIZLu9FBjtLLtvYZixkDX6DBVTZLaDdlq3xvdpAo0
	6eMkookDAZchrk01bQWhPtiFxVTfCEv244Ev8oBvPz2iQDKM0+
X-Received: by 2002:a17:907:3d8c:b0:b86:e938:1b1c with SMTP id a640c23a62f3a-b8760fdac43mr506705366b.5.1768471957089;
        Thu, 15 Jan 2026 02:12:37 -0800 (PST)
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com. [209.85.208.52])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b876b6865desm378189766b.12.2026.01.15.02.12.36
        for <linux-can@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 15 Jan 2026 02:12:36 -0800 (PST)
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-64b791b5584so1223078a12.0
        for <linux-can@vger.kernel.org>; Thu, 15 Jan 2026 02:12:36 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVpqXmku/7SNvkll6hLJBPPBFZM+UvhGR7gvy4KpAPcE7tx2mbV0JS2YC2lngjNXnXTAKpg9Dnf1MI=@vger.kernel.org
X-Received: by 2002:a05:6402:234a:b0:64b:4745:11fa with SMTP id
 4fb4d7f45d1cf-653ec101f96mr4387853a12.6.1768471956067; Thu, 15 Jan 2026
 02:12:36 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260114154525.3169992-1-prabhakar.mahadev-lad.rj@bp.renesas.com> <20260114154525.3169992-4-prabhakar.mahadev-lad.rj@bp.renesas.com>
In-Reply-To: <20260114154525.3169992-4-prabhakar.mahadev-lad.rj@bp.renesas.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 15 Jan 2026 11:12:20 +0100
X-Gmail-Original-Message-ID: <CAMuHMdWJhmOcem=Au9xnrUGawjCMEsj=7LJFStcMRH5ZSPpwJw@mail.gmail.com>
X-Gm-Features: AZwV_QjFtS9gX1t1bcoAdGvEBCAD87MgrBFQL_PM1xjp6VHRWBnRuuHz0IuQFJA
Message-ID: <CAMuHMdWJhmOcem=Au9xnrUGawjCMEsj=7LJFStcMRH5ZSPpwJw@mail.gmail.com>
Subject: Re: [PATCH v4 3/4] dt-bindings: can: renesas,rcar-canfd: Document
 RZ/T2H and RZ/N2H SoCs
To: Prabhakar <prabhakar.csengg@gmail.com>
Cc: Marc Kleine-Budde <mkl@pengutronix.de>, Vincent Mailhol <mailhol@kernel.org>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Magnus Damm <magnus.damm@gmail.com>, linux-can@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-renesas-soc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Biju Das <biju.das.jz@bp.renesas.com>, 
	Fabrizio Castro <fabrizio.castro.jz@renesas.com>, 
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Content-Type: text/plain; charset="UTF-8"

On Wed, 14 Jan 2026 at 16:45, Prabhakar <prabhakar.csengg@gmail.com> wrote:
> From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
>
> Document the CAN-FD controller used on the RZ/T2H and RZ/N2H SoCs. The
> CAN-FD IP is largely compatible with the R-Car Gen4 block, but differs
> in that AFLPN and CFTML are different, there is no reset line for the IP,
> and it only supports two channels.
>
> Sync the resets and reset-names schema handling with other CAN-FD SoCs so
> DT validation stays consistent and maintainable.
>
> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> ---
> v3->v4:
> - Dropped Reviewed-by from Geert due to below changes.
> - Updated commit message.
> - Moved single compatible entries into an enum and to below oneOf.
> - Synced the resets/reset-names handling with other similar SoCs.

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
But I am not sure this is better than v3, as it is 15 lines longer.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

