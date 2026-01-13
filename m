Return-Path: <linux-can+bounces-6127-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6198AD1B07A
	for <lists+linux-can@lfdr.de>; Tue, 13 Jan 2026 20:26:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id D82553002D36
	for <lists+linux-can@lfdr.de>; Tue, 13 Jan 2026 19:26:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF01535CB66;
	Tue, 13 Jan 2026 19:26:01 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from mail-vk1-f194.google.com (mail-vk1-f194.google.com [209.85.221.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D62A342CA7
	for <linux-can@vger.kernel.org>; Tue, 13 Jan 2026 19:26:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768332361; cv=none; b=VtAf17DPzZ5Fo4t46yWckkeojX166nsy1RLQIvABdiqXqNIVNzbs1dTs1ANeYgHs/sZEkfw8vmjTbUFdv4WLVpKNZzgS7x0Mlj+l/93FHzGzgdF8QOvZRpfM63VsVP9/Q9+oyL6QwGM6xrXEfTFMYFQSmuBJBqhW9fZaDSJq4xU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768332361; c=relaxed/simple;
	bh=3ZrwEeBiZv2/57vkV16rP297m0IfYLbOdaycMnUgZvA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LNLU1Bg1YhJ1bjsEoP1pWccbdjV0A5Wd9ZsNSsEU4Cb4ykwoBwBZCAQJoVK87zKRPjJsw24xSDTaesIXlgwCtHd1W0efCJ2rdw/ywsJE50bmcEsMGBCC6CCr+syzYlOhd/oVYWMn4xnHAU/mCBG+by1a2KaKG/fs/MUapsiE3kc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f194.google.com with SMTP id 71dfb90a1353d-563641b24b9so1477268e0c.3
        for <linux-can@vger.kernel.org>; Tue, 13 Jan 2026 11:26:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768332359; x=1768937159;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=lGxD9M4RQU4+hrSLm2mQz70yQm9QgTmeWCOFRtIxY9c=;
        b=o+226c1GzyF3J734cvH0FGKzlQDS1uv1pH+3ZaCNUDQ19ecI/i86NGXHsuuw12R2if
         YnJTuw5gaEZOBIVstN/cAchHwAUJLzHGbKY8CJsfxjX48KdwjugvpzEPUjhEfDHjkpS4
         skQDaPaO7qldR9tmHYvBUGRK0G8D8FXHGNEL+ajfnz0yzPvQzaJLzBBraEKJsw7toxOt
         FtycQh6XWmPGckKibarex63hv0lxCVgWTysHzjiuh9PGvEU2geBAd3+43pPqfdCHulb0
         55FS3I3iSxY0XK5VESI71p5CjD0cx5csEqu/FkmNieJ9pPwgo69+kwQieoyaGq5Lhb+Q
         mF4A==
X-Forwarded-Encrypted: i=1; AJvYcCXSZsUCkGCs2ghIVTibmakjipb4X+Hb1pzqaHJLSz+vGllEZmW5PpDuDkvMFTkqjcEWnChedy9fyJY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzado3EOVyF14j+m+OcpV+3KHzj3vRV4sXUmPz30vg2ulNT6yMr
	333LQPUhnkWd75TFNbgPV8yQ6fFX5d/vTZoKCrNKA4aitDR0RbGqYDvBRCR0F58g7Zs=
X-Gm-Gg: AY/fxX620t8CvNqvIrA50rUW/vU53hV+uQALXFTyn5KQeO4IEWDGenHTlbe9gLnGksp
	j33gGNNlkC74tDxduQaQnvVvKnKkgisrtQT3YkWfki9wn1lAcv+1ei4u0mlNtuWqlpTff0oCPu3
	L8nmP0FpAu3hRwnizWjiuOhD1Q8jIwWcmFK81fTjJz7DSjkZWIH4Xu6iEKol5RQu2OZRFHIPSjy
	vbqvMfdcQnizvkSIAAJzejgErP8hlmEHANmbgbt/X15fdVRtNYWSCadAdHrA3Yn02Ku/8dzEBAx
	Ii3oqbMk6sgcprCsZd0VfJMoDXj5VW8VpK5x4bu4dTWSIO8dkTyHy+6SOCA4M/YDijYJr4kBNG0
	oR9XtyyCUbJBYVO/GZ2x5xDmC9qDGKRCST7EX80MGdopXJrclY0hfrvVczh7r2rvjW5+5WNIZFi
	H4kKss4ZlBf3ILVps5RbUlwuQWleJz3lfgYl4ZCxfr3HKYSU2/+ScB
X-Received: by 2002:a05:6122:3114:b0:563:4d66:359c with SMTP id 71dfb90a1353d-563a08046eemr161269e0c.0.1768332359151;
        Tue, 13 Jan 2026 11:25:59 -0800 (PST)
Received: from mail-vk1-f175.google.com (mail-vk1-f175.google.com. [209.85.221.175])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-563667cf148sm13351556e0c.2.2026.01.13.11.25.58
        for <linux-can@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 13 Jan 2026 11:25:58 -0800 (PST)
Received: by mail-vk1-f175.google.com with SMTP id 71dfb90a1353d-55999cc2a87so2136936e0c.0
        for <linux-can@vger.kernel.org>; Tue, 13 Jan 2026 11:25:58 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCW6A6hZmcJHqJ71u+fntKM+cvz0OZSklq2lBcpt4OBjHc523CtCLwOQUS2ALkOF6dZ+5xmcaDNS++o=@vger.kernel.org
X-Received: by 2002:a05:6122:7cd:b0:563:4a93:a5f4 with SMTP id
 71dfb90a1353d-563a091550dmr145996e0c.4.1768332358235; Tue, 13 Jan 2026
 11:25:58 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260109125128.2474156-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20260109125128.2474156-4-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20260111-poetic-dark-butterfly-97993f@quoll> <CA+V-a8un48Gfqg-K6YToxUgnZawOcb-nQHsBcOfHdpAR7_Uu4Q@mail.gmail.com>
 <dd053cff-af8f-4378-9550-9f99f91cea20@kernel.org> <CA+V-a8tZAUoPxp7NanALW5HmVLMQAprcDXPME5povLT6nH6bTw@mail.gmail.com>
In-Reply-To: <CA+V-a8tZAUoPxp7NanALW5HmVLMQAprcDXPME5povLT6nH6bTw@mail.gmail.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 13 Jan 2026 20:25:47 +0100
X-Gmail-Original-Message-ID: <CAMuHMdUrSUeOFvyX-RhjFV8HfiGtvOvBT-Wd328C4P-j-N0fHw@mail.gmail.com>
X-Gm-Features: AZwV_Qi5VDWrgJaVOTjXTW8AVFjCwxmek62R9X6THbS3twvGucCrR-aVI1pn-1o
Message-ID: <CAMuHMdUrSUeOFvyX-RhjFV8HfiGtvOvBT-Wd328C4P-j-N0fHw@mail.gmail.com>
Subject: Re: [PATCH v3 3/4] dt-bindings: can: renesas,rcar-canfd: Document
 RZ/T2H and RZ/N2H SoCs
To: "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Cc: Krzysztof Kozlowski <krzk@kernel.org>, Marc Kleine-Budde <mkl@pengutronix.de>, 
	Vincent Mailhol <mailhol@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Geert Uytterhoeven <geert+renesas@glider.be>, Magnus Damm <magnus.damm@gmail.com>, 
	linux-can@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Biju Das <biju.das.jz@bp.renesas.com>, 
	Fabrizio Castro <fabrizio.castro.jz@renesas.com>, 
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 12 Jan 2026 at 18:22, Lad, Prabhakar <prabhakar.csengg@gmail.com> w=
rote:
> On Mon, Jan 12, 2026 at 4:30=E2=80=AFPM Krzysztof Kozlowski <krzk@kernel.=
org> wrote:
> > On 12/01/2026 15:04, Lad, Prabhakar wrote:
> > >   - if:
> > >       properties:
> > >         compatible:
> > >           contains:
> > >             # SoCs WITH resets but WITHOUT reset-names
> > >             enum:
> > >               - renesas,rcar-gen3-canfd
> > >               - renesas,rcar-gen4-canfd
> > >     then:
> > >       required:
> > >         - resets
> > >       properties:
> > >         reset-names: false
> > >
> >
> > Yes, although now I wonder why do you have such case... There are no
> > benefits in disallowing reset-names, even for single entries.

Except that I have no idea which of the two names I should use in
case of renesas,rcar-gen3-canfd and renesas,rcar-gen4-canfd, as
the hardware documentation doesn't explain that?  AFAIU it is just
a single, common reset for the whole block...

> Ok, I will update the resets property in patch 1/4 as below. Would you
> prefer reset-names as a required property for single resets?
>
>   reset-names:
>     minItems: 1
>     maxItems: 2
>     items:
>       enum:
>         - rstp_n
>         - rstc_n

I.e. which one should I pick?
<grin>Obviously the first, so dtbs_check succeeds?</grin>

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

