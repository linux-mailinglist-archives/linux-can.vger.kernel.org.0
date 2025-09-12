Return-Path: <linux-can+bounces-4672-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 97523B545C4
	for <lists+linux-can@lfdr.de>; Fri, 12 Sep 2025 10:44:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E3F8A1CC399C
	for <lists+linux-can@lfdr.de>; Fri, 12 Sep 2025 08:44:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC3872BE03D;
	Fri, 12 Sep 2025 08:43:59 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from mail-vs1-f53.google.com (mail-vs1-f53.google.com [209.85.217.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45704253355
	for <linux-can@vger.kernel.org>; Fri, 12 Sep 2025 08:43:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757666639; cv=none; b=aozG7LBdlPtBOEvOgSARqBNJpcAaDKLura3O7lsPh4ZyNVlV/vR/GT/uII5+fB6DW9NmDyFgdOsBN+8f6Ecd9tQO1GQXlrJKoggmsO7bWQYCj0/U3up2ylkR2DuKAs+ze657vZLvqIdm5G7JaOcaSVlJ6fs0rlMAPMvxvbzcl5o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757666639; c=relaxed/simple;
	bh=y/jJz2ZusSDybe1iPBMjSqne5ow7NABIzFffczF3yyk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BYV3raOruDFgtoul6sMV8qEaDnBiGzJmitx+bw+6wqTusoA7vsdZUYt1/EVLfrd0EFkBNSZo/V0XBp/KIqAD4p+eVrEFJwJYmPxaGM5vTaBKNx41UsVPbgER23KDOwsfePiQ0adoKR3EALGNmtLKqZBVSuy+OdwUf0+dag7NszY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.217.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f53.google.com with SMTP id ada2fe7eead31-55785303d1fso163459137.3
        for <linux-can@vger.kernel.org>; Fri, 12 Sep 2025 01:43:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757666637; x=1758271437;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Op91nehv57YfLzGMLGlCp7oEduF1D2i1sngnXjbKPUY=;
        b=meXUey3N8UdwErA0d7qLAUDSmVM4aNtNDt/wLMSRZlD+Qw0yTx6wyH2KVSoUxMRSL6
         C8B9xnTH6Dsp3zhLGLPP96sF9wwJAzeAuo082x6z97cNRR6hjBZ/WswbGQ4LVUDYpbnm
         E2yl+jXQbEhLLE5vDVxxz+NTzD8+YysMHkk8iJxzyKK2GCP1YT4f/9H6BZpQEqJ/hIAY
         mjpqjfmoMPfGoWFMs+tLWjYXwmiX9OGs1lPsDMDuxxR3XFuKGRyMNEp1tu74SpZBp+5U
         XvarWVUf3Ztwxgs6Qz9VCIkO3cmU23pnyyt1pFmzDfGvZGYoCJ9Jl3HdOVhzvChsB36N
         Clxw==
X-Forwarded-Encrypted: i=1; AJvYcCUx9hAA73kWXcnx+tNpAyRIRJy+IVLRN3vxfhPtdFcMAKyDyQZD3glZoU42OlVYVnlMzcQElf+kqYo=@vger.kernel.org
X-Gm-Message-State: AOJu0YyA/rluyC9lFNRR/MdEjfSIKd2h0gtAtKQ0Ih1a7M/LsEWH1fL5
	weJCix/mwiXOUbUT1rISOwqNqaLC+wNudi6eN0YbZac+F4vr9pymsb/c+7vSZb6j
X-Gm-Gg: ASbGncuc0zmPPG0GhxZk2xB2Ch7mA7a3y5M3vGAW/XKFs7dVo/1OS6Wd/aZ9E3Qbsj0
	9YlixxbQhBZOjHIsV75ggBDboUd2pJQK0QvEjQ1XFET8F9vXLsjdacNRvYbpQSPKuCDTYeoSZ8V
	bi1Pv1NuvAZqS7v2e57YkCLQ2baB8GsdEPLhxEp0M9ehJNid0fO/aoesFpARUbuInJ8aPAalN8b
	HLIJBO60QHYIDujV9hY88f8ILqAB02rX+CYJHSD7iJ4kGSPL/ZJxbD5KSDQ2P/NJLThTrUlkf0H
	T2bO+ilJyd8J+OyYOkJ+5Es65IrBqcjwsLzFEBBd0aCRPjCJqcIzdquDutFF4eV9A0BCSCwPhZx
	hRC5NOsDtMsswgfouBd2Mmm2lXdnE1PbxMes8/4my1jirKwJyiiNDZbqHFod5J/46C4I46L4=
X-Google-Smtp-Source: AGHT+IH1KGh2NkphQJ+GIDrehp4SFfulgZdoLRPOoLnlISGQ4/yRe0ODvPkv6BZgfUCV05xsXVotew==
X-Received: by 2002:a05:6102:418c:b0:529:e9a5:c216 with SMTP id ada2fe7eead31-55608ea0a8cmr941960137.4.1757666636961;
        Fri, 12 Sep 2025 01:43:56 -0700 (PDT)
Received: from mail-vs1-f43.google.com (mail-vs1-f43.google.com. [209.85.217.43])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-8ccd4d1a8d5sm701011241.16.2025.09.12.01.43.56
        for <linux-can@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 12 Sep 2025 01:43:56 -0700 (PDT)
Received: by mail-vs1-f43.google.com with SMTP id ada2fe7eead31-55785303d1fso163453137.3
        for <linux-can@vger.kernel.org>; Fri, 12 Sep 2025 01:43:56 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWi9AiuC5C/1dr0lOgEwRbCxokGc/1GXmIoTLk+es9gF9wdE+G8hss3K2ScweV4x/mtzv9GOoMbg0M=@vger.kernel.org
X-Received: by 2002:a05:6102:f07:b0:522:a762:8e5d with SMTP id
 ada2fe7eead31-5560a011ca5mr932894137.13.1757666636265; Fri, 12 Sep 2025
 01:43:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1755855779.git.geert+renesas@glider.be> <f9198ea3be46f1eb2e27d046e51293df7fb67f46.1755855779.git.geert+renesas@glider.be>
 <TY3PR01MB1134652A3383410EB50783E3A8608A@TY3PR01MB11346.jpnprd01.prod.outlook.com>
In-Reply-To: <TY3PR01MB1134652A3383410EB50783E3A8608A@TY3PR01MB11346.jpnprd01.prod.outlook.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Fri, 12 Sep 2025 10:43:44 +0200
X-Gmail-Original-Message-ID: <CAMuHMdUrqqJEM4VWt5KzjPGkTHL4w5Sx9x1gC-yoRW2jEArMiw@mail.gmail.com>
X-Gm-Features: AS18NWCEc9rh7mbV7HZ3dF7nCk5pwoJB5ewSjxEXrkXmJ5-xyFDYhnGln5x6xVo
Message-ID: <CAMuHMdUrqqJEM4VWt5KzjPGkTHL4w5Sx9x1gC-yoRW2jEArMiw@mail.gmail.com>
Subject: Re: [PATCH/RFC 6/6] can: rcar_canfd: Add suspend/resume support
To: Biju Das <biju.das.jz@bp.renesas.com>
Cc: Marc Kleine-Budde <mkl@pengutronix.de>, Vincent Mailhol <mailhol.vincent@wanadoo.fr>, 
	"linux-can@vger.kernel.org" <linux-can@vger.kernel.org>, 
	"linux-renesas-soc@vger.kernel.org" <linux-renesas-soc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

Hi Biju,

On Fri, 12 Sept 2025 at 09:54, Biju Das <biju.das.jz@bp.renesas.com> wrote:
> With adaption to RZ/G3E for ram_clk [1]

> --- a/drivers/net/can/rcar/rcar_canfd.c
> +++ b/drivers/net/can/rcar/rcar_canfd.c
> @@ -1983,10 +1984,18 @@ static int rcar_canfd_global_init(struct rcar_canfd_global *gpriv)
>                 goto fail_reset2;
>         }
>
> +       /* Enable RAM clock */
> +       err = clk_prepare_enable(gpriv->clk_ram);
> +       if (err) {
> +               dev_err(dev,
> +                       "failed to enable ram clock, error %d\n", err);
> +               goto fail_clk;
> +       }
> +
>         err = rcar_canfd_reset_controller(gpriv);
>         if (err) {
>                 dev_err(dev, "reset controller failed: %pe\n", ERR_PTR(err));
> -               goto fail_clk;
> +               goto fail_ram_clk;
>         }
>
>         /* Controller in Global reset & Channel reset mode */
> @@ -2026,6 +2035,8 @@ static int rcar_canfd_global_init(struct rcar_canfd_global *gpriv)
>         rcar_canfd_disable_global_interrupts(gpriv);
>  fail_clk:
>         clk_disable_unprepare(gpriv->clkp);
> +fail_ram_clk:
> +       clk_disable_unprepare(gpriv->clk_ram);

Should be inserted above fail_clk.

>  fail_reset2:
>         reset_control_assert(gpriv->rstc2);
>  fail_reset1:
> @@ -2045,6 +2056,7 @@ static void rcar_canfd_global_deinit(struct rcar_canfd_global *gpriv, bool full)
>         }
>
>         clk_disable_unprepare(gpriv->clkp);
> +       clk_disable_unprepare(gpriv->clk_ram);

Wrong order.

>         reset_control_assert(gpriv->rstc2);
>         reset_control_assert(gpriv->rstc1);
>  }

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

