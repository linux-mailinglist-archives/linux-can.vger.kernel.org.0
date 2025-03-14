Return-Path: <linux-can+bounces-3090-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 245B6A613FF
	for <lists+linux-can@lfdr.de>; Fri, 14 Mar 2025 15:48:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 15A8D1897643
	for <lists+linux-can@lfdr.de>; Fri, 14 Mar 2025 14:48:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D06892010EF;
	Fri, 14 Mar 2025 14:48:01 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from mail-vk1-f172.google.com (mail-vk1-f172.google.com [209.85.221.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41B701A83F2;
	Fri, 14 Mar 2025 14:48:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741963681; cv=none; b=u9lAQbnalVck3fCSJHANoHo3c5SmwP1ppZzB9vh+KSBMLMMCK6FvJq/Iw2CGhCEDiaZPC9fsps+1dGvOwakSsVcYRLaLW94tMASZLCcSFUEIDq1rq4bnfXV1F93/C0HjpFDed/dkF0YaCTva8juEJEmSvon/DsFAZo+lt4B8LS4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741963681; c=relaxed/simple;
	bh=HoHTrZHkTIsNgvo30v+MSPUp2QpIjCQOuegDWWaNEm4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=E93XdmuJnJy7PbTvbaqf1p31ZhMHMx/DlQ4VMMnd8ioYARz7CpTN0lZsdB5bMc5TcDzbqP4+kZctlM5tBGyR1HLjRBlgnHBg1NA8qAPoOlv8C22tTCD48/EiKQ5/zyfacOgkXAUZyp3l34yPSYvN2nr6+Denjm1N8W/UJZH9B14=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f172.google.com with SMTP id 71dfb90a1353d-523de538206so841412e0c.2;
        Fri, 14 Mar 2025 07:47:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741963677; x=1742568477;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HAW7merCZwCe9Cy0F+W1WlPzRSmC8G5TdzLoSUV3EcU=;
        b=PyXbAlNTEa/hWdI+wgFaO7EVCK0zye6AZcAUCrW57RD0TnrHeybzr2FBbJHegcFzPp
         ZTThOUpYFxv+POUl2IyCou3H/b8w7+HQAHJVjUrGQc9ee588g6rtnnpptvNn3sj4zpLk
         /YjaYbEB6tkKt/8hjBK6gpQfMSU2igW3WouBkByoAB4OSW37KFDiBposRUkpmIfhPwCd
         gbShS728mBHZJ1sLlj2+0vjv2g0jIdMCrV5KhtE44yxQXFYUHvw6E10rkpbylcPBajMH
         TGkYWzav7Y3Zyl5xlGc5NRbBwfEse6rm8Htb7hRpNOey0KJ4lttIaKymOADCURuL9U6l
         4mDA==
X-Forwarded-Encrypted: i=1; AJvYcCUkC30m7KCouSOeYEBLktwcUFvd2Ae2De0MAKkVYxoMsdcxJYnCXAOZ9cwB0S8wOxOzUCarGipTULx0goUG+00pT4A=@vger.kernel.org, AJvYcCVSp/9d6O0gbS8TsY7K7LF+SE7f/AtQ6stauzVreIkDng0aip3GNVd8tc6n6R3w9jsGIECntF4latY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzvufnbFr7xqoSDnbZmM+A6+HmKJ31nP4JuXPaFXKRjlqyl7SLc
	CUTfX0i/uvpgTjvTV2hI8UMSSilhUHPLI6G7p6CCI1bzj/JFKGxkAUo+PcVbLgo=
X-Gm-Gg: ASbGnctL5tr3h9qATP159ik4+pcW1PXq8lvjRn+sp4oVCr+pcVhgjavvskUF40z88R0
	dinbF1GsBeCISSdqBV56CjuPlw9PKQVEcLF+25c8D8ar3A7QRkXm7eN6oXJv9i376YBJb5CmEUx
	6hcqjmMlt1NpH/JbIkI59kA62Hgxmr3FHquj95OeI4WkoX463+t93F51k+AHIN6Xi+3vljZH/nn
	ohY+xEGOkT2AWw3svSqloM0fooEPeFSt2J81Re4e2gXA+XDo1fXflTF9+mz2Gu8OGV5sLV9eMXY
	bkVoRk16V5nT9+9j3g2nWVczgQQ/pgSOgJLjU91sMrejOJa6ku5pfRZ2mrp1d1QmgXU5H+zFmgf
	u8gfdI9M=
X-Google-Smtp-Source: AGHT+IHtrE/qn3YA3Z2sevT26SP4ZMkxv0FyGsmqekNmQ1gOnIB8pIx/hRuV3OEjTb0UjHVUdvzL4g==
X-Received: by 2002:a05:6122:829a:b0:524:2f10:8bc8 with SMTP id 71dfb90a1353d-524499f7478mr1488921e0c.11.1741963677446;
        Fri, 14 Mar 2025 07:47:57 -0700 (PDT)
Received: from mail-ua1-f51.google.com (mail-ua1-f51.google.com. [209.85.222.51])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5243a5ccc18sm587381e0c.22.2025.03.14.07.47.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 14 Mar 2025 07:47:57 -0700 (PDT)
Received: by mail-ua1-f51.google.com with SMTP id a1e0cc1a2514c-86d69774081so972316241.0;
        Fri, 14 Mar 2025 07:47:56 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCU1iDp76+S9IAVVb8YlBX8AJ/wpArAoikq50HpapPzoZHBwioXyGLEkG0c+xLtopqWicnywDPC1Gng=@vger.kernel.org, AJvYcCXfDXJsZCYXq9UwPpSud68dO0gwiC4B7g7NrSG+8SvbQH6m1SAZhDSih/QdeW/TAfUqT2y6CrK3ZLprSeCpe9mazuw=@vger.kernel.org
X-Received: by 2002:a05:6102:442c:b0:4c2:2beb:b726 with SMTP id
 ada2fe7eead31-4c383139884mr1595694137.10.1741963676402; Fri, 14 Mar 2025
 07:47:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250306124256.93033-1-biju.das.jz@bp.renesas.com> <20250306124256.93033-9-biju.das.jz@bp.renesas.com>
In-Reply-To: <20250306124256.93033-9-biju.das.jz@bp.renesas.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Fri, 14 Mar 2025 15:47:44 +0100
X-Gmail-Original-Message-ID: <CAMuHMdWk5vXSMSz15NBM+dxYRNyov2jFUAOKDrCANLVzJ5-AtA@mail.gmail.com>
X-Gm-Features: AQ5f1JrmnG75xI9elvRycgkRO4QoUTxzMmxSocKc-JNufAYKx3EX63MsFKA2bAE
Message-ID: <CAMuHMdWk5vXSMSz15NBM+dxYRNyov2jFUAOKDrCANLVzJ5-AtA@mail.gmail.com>
Subject: Re: [PATCH v4 08/11] can: rcar_canfd: Add shift table to struct rcar_canfd_hw_info
To: Biju Das <biju.das.jz@bp.renesas.com>
Cc: Marc Kleine-Budde <mkl@pengutronix.de>, Vincent Mailhol <mailhol.vincent@wanadoo.fr>, 
	Wolfram Sang <wsa+renesas@sang-engineering.com>, 
	=?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <u.kleine-koenig@baylibre.com>, 
	linux-can@vger.kernel.org, 
	Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>, Biju Das <biju.das.au@gmail.com>, 
	linux-renesas-soc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Biju,

Thanks for your patch!

On Thu, 6 Mar 2025 at 13:43, Biju Das <biju.das.jz@bp.renesas.com> wrote:
> R-Car Gen3 and Gen4 has some differences in the shift bits. Add a

have

> shift table to handle these differences. After this drop the unused
> functions reg_gen4() and is_gen4().
>
> Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

A suggestion for improvement below.

> --- a/drivers/net/can/rcar/rcar_canfd.c
> +++ b/drivers/net/can/rcar/rcar_canfd.c
> @@ -90,11 +90,13 @@
>  /* RSCFDnCFDGAFLCFG0 / RSCFDnGAFLCFG0 */
>  #define RCANFD_GAFLCFG_SETRNC(gpriv, n, x) \
>         (((x) & (gpriv)->info->mask_table[RCANFD_RNC_MASK]) << \
> -        (reg_gen4(gpriv, 16, 24) - ((n) & 1) * reg_gen4(gpriv, 16, 8)))
> +        ((gpriv)->info->shift_table[RCANFD_FIRST_RNC_SH] - ((n) & 1) * \
> +         (gpriv)->info->shift_table[RCANFD_SECOND_RNC_SH]))

Both shifts are dictated by the field width:
  - R-Car Gen4 packs 2 values in a 32-bit word, using a field width
    of 16 bits,
  - R-Car Gen3 packs up to 4 values in a 32-bit word, using a field
    width of 8 bits.
The odd split in two shifts is due to the MSB-first numbering of
the fields.  Hence I think it would be better to use a field width
parameter, and derive the proper shift value from that (like you have
already done for ICU ;-)

Note that the formula will have to be reworked anyway to support the
third channel on R-Car V3H_2, as "n & "1 will no longer fly here...

>  #define RCANFD_GAFLCFG_GETRNC(gpriv, n, x) \
> -       (((x) >> (reg_gen4(gpriv, 16, 24) - ((n) & 1) * reg_gen4(gpriv, 16, 8))) & \
> -        (gpriv)->info->mask_table[RCANFD_RNC_MASK])
> +       (((x) >> ((gpriv)->info->shift_table[RCANFD_FIRST_RNC_SH] - ((n) & 1) * \
> +                 (gpriv)->info->shift_table[RCANFD_SECOND_RNC_SH])) & \
> +                 (gpriv)->info->mask_table[RCANFD_RNC_MASK])

Gr{oetje,eeting}s,

                        Geert


--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

