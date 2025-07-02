Return-Path: <linux-can+bounces-3929-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D98E7AF0CB7
	for <lists+linux-can@lfdr.de>; Wed,  2 Jul 2025 09:37:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E8E601BC71E1
	for <lists+linux-can@lfdr.de>; Wed,  2 Jul 2025 07:38:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92AA7219E8C;
	Wed,  2 Jul 2025 07:37:48 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from mail-vs1-f47.google.com (mail-vs1-f47.google.com [209.85.217.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E43C2236E8;
	Wed,  2 Jul 2025 07:37:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751441868; cv=none; b=lFHDwMRnbCv6GRM29zSEc50UL3wOPC7Idd1IzP4z52dVe/FW4D7kmYIDFSJbG91DV6KkhxIL4urn2AsHqmPqLMIkDZGKo2toyUraXpZiZRCnX8URNL3CYnzea56o0pyTES3b7g66qG5U910KQXUqFg4Ih/vI1ujpllUrdH86/4M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751441868; c=relaxed/simple;
	bh=0cuocMIUY2qgipwdxtV+Tzq02fGz0/hCUSj0KzZAy3w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iamZZqMd7OxKOqBxqfi8NrpPW995zSoV9NTbr7ItcOJambh/oSiN8e5vx3VH7k34q+zXstyFpTOIQipcUpWyVrtDm5UgjRsXpXS5fJXd/qs8Fy2azXOya2gGNNZ5fJP47uETozs7feWyX0RptePztG/2ctVAtR2OQJmqcFjCtKA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.217.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f47.google.com with SMTP id ada2fe7eead31-4e7ade16082so1074669137.1;
        Wed, 02 Jul 2025 00:37:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751441864; x=1752046664;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qzDhxNWDqLt/2XBcAROgu4jg21pPwa7UKkY7d5iZMBM=;
        b=CeJ9fxOgJ2uE84RBhrZj/SPxQGrWZkGpqBfxxEqgIySq1HxpxbUXwwCrS/rCLD7ELJ
         8iWVDJZHh/YmvOTQgDMO5WMFCXQ+Fwen6Eva0WzMvJX9sf2cJr/92opJ6D8VDNGhHoaR
         yiBq2la1/TKbm2S6geqmGCio5Rc4QrgF/zWNbMxhcAD9R/rFmF1q2j2nD9PRw0fs09+X
         +no0QsVxsAi2Qvku53KCeBOiXO7G+ZzKFcxq0OHCQtAF60T+afTCO/1dgD7+CfpFn9kv
         AXKDGXgwAPvLrBFRezI4nKTQGglPZE4+YOZJNzfNNmuWh7IgIamFOitF1Kbuck07qr1g
         7l9g==
X-Forwarded-Encrypted: i=1; AJvYcCVMWyLICsUYLK9+mPW+y6Lai2ZN0/db0csjy2th7TCvyjTKt3ZUp3M63uII/vZLkku22Jbu+XHrkV1HWfsW85W1+5c=@vger.kernel.org, AJvYcCW0fXmBQDUJ9ShgBvQwZXDejDdK6BpXf1SYtOjxtB3ScQra+qGhXU2n3wCjnzUFNgVTwwhMfy2Icyw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxim/Um+p7u/Ix3DXFhRjhUlXNdD3JyX359sbOo1mPu9r6nVsAu
	+zPzoIeKRbaQCTdmvokq4Wa7X3En7S8kFeIKmYamKgtp5zWnKDxnSw4+nrnKOk4z
X-Gm-Gg: ASbGncvf38X5zRtGGrfuAU5JgIHt5mtliV2/F1a7Lrqig2btv677BYwe/Cbz4lJ6G/u
	SwjWeh7hWKhdcKokSUtmizf51RDbKvNAHu2UXRNYDIOFSLlt+bsF4fkVVNbUVvUJ7T5247DrpUc
	zxj54Gdac8GIyj/KzgHB59wFOqr7h+QWPGWTKZofjTqHZBK1EgBP1bzj7n4x5UnpttCm4FWqNHn
	rMslnWPybOFDphvNt5RtRVt0rSek4NFyPKz6XoOzPY0VsLKt2/3R4R6wtM/Hc9Ut8huq4vTOeLw
	tKgrkObj7P4o59C4UA+Laa/w1bwGu21Mh1yFdZpr7r6VGGIr+pNguIJJMQZtD2Yd6A4VE+aDDL0
	0qRoYgV+mD5QZvATz5ODitEBP
X-Google-Smtp-Source: AGHT+IEIDnURumR22zSn6UsJZxMaGiVhWByPO5Nw05E8+J7YFYsFcttWB9j+H6vtzbSsZEu4eRgf0w==
X-Received: by 2002:a05:6102:3587:b0:4e5:8c2a:fbee with SMTP id ada2fe7eead31-4f161230abemr665367137.15.1751441863555;
        Wed, 02 Jul 2025 00:37:43 -0700 (PDT)
Received: from mail-ua1-f47.google.com (mail-ua1-f47.google.com. [209.85.222.47])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-4ee4cb724ecsm1787718137.16.2025.07.02.00.37.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 02 Jul 2025 00:37:43 -0700 (PDT)
Received: by mail-ua1-f47.google.com with SMTP id a1e0cc1a2514c-87ed3b792a2so798396241.3;
        Wed, 02 Jul 2025 00:37:43 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWEV21+/4VpFSSO4aRzvH9m8vWH2+rLELsoCFdBX2bEXsZlvWMT1CNI5+OLgx7Ke22ncqnQWWepn5VGgjJ6ucpf1sg=@vger.kernel.org, AJvYcCWRSMFFWIKcq6GSnLpNY1qV9IwOkiwd2j1Rj68qwXo33iXdNXdAMsT1+O5FwGqZPmAhprIB0R4CVEU=@vger.kernel.org
X-Received: by 2002:a05:6102:4b1b:b0:4e5:a394:16cb with SMTP id
 ada2fe7eead31-4f16107b1a1mr699354137.7.1751441862666; Wed, 02 Jul 2025
 00:37:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250629150417.97784-1-biju.das.jz@bp.renesas.com>
In-Reply-To: <20250629150417.97784-1-biju.das.jz@bp.renesas.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 2 Jul 2025 09:37:30 +0200
X-Gmail-Original-Message-ID: <CAMuHMdXK9ZBpgPSE32Zya-nVBXQw25=2-g5pnixjFOoyOkrrvg@mail.gmail.com>
X-Gm-Features: Ac12FXwtv2XR1uUhcWOWqo-MJTSpu3hhBbAj25tUW75zxUNzcJWB8H2tjtZs0j4
Message-ID: <CAMuHMdXK9ZBpgPSE32Zya-nVBXQw25=2-g5pnixjFOoyOkrrvg@mail.gmail.com>
Subject: Re: [PATCH] can: rcar_canfd: Drop unused macros
To: Biju Das <biju.das.jz@bp.renesas.com>
Cc: Marc Kleine-Budde <mkl@pengutronix.de>, Vincent Mailhol <mailhol.vincent@wanadoo.fr>, 
	Magnus Damm <magnus.damm@gmail.com>, linux-can@vger.kernel.org, 
	linux-renesas-soc@vger.kernel.org, 
	Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>, Biju Das <biju.das.au@gmail.com>
Content-Type: text/plain; charset="UTF-8"

Hi Biju,

On Sun, 29 Jun 2025 at 17:04, Biju Das <biju.das.jz@bp.renesas.com> wrote:
> Drop unused macros from the rcar_canfd.c.
>
> Reported-by: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
> Closes: https://lore.kernel.org/all/7ff93ff9-f578-4be2-bdc6-5b09eab64fe6@wanadoo.fr/
> Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>

Thanks for your patch!

> --- a/drivers/net/can/rcar/rcar_canfd.c
> +++ b/drivers/net/can/rcar/rcar_canfd.c
> @@ -51,25 +51,17 @@
>  #define RCANFD_GCFG_EEFE               BIT(6)
>  #define RCANFD_GCFG_CMPOC              BIT(5)  /* CAN FD only */
>  #define RCANFD_GCFG_DCS                        BIT(4)
> -#define RCANFD_GCFG_DCE                        BIT(1)
> -#define RCANFD_GCFG_TPRI               BIT(0)

Does it make sense to remove all simple bit definitions?
They serve as documentation.

[...]

> @@ -121,15 +108,9 @@
>  #define RCANFD_NCFG_NBRP(x)            (((x) & 0x3ff) << 0)
>
>  /* RSCFDnCFDCmCTR / RSCFDnCmCTR */
> -#define RCANFD_CCTR_CTME               BIT(24)

CTME will be needed for adding listen-only and loopback support.
Of course it can be added back later...

>  #define RCANFD_CCTR_ERRD               BIT(23)
>  #define RCANFD_CCTR_BOM_MASK           (0x3 << 21)
> -#define RCANFD_CCTR_BOM_ISO            (0x0 << 21)
>  #define RCANFD_CCTR_BOM_BENTRY         (0x1 << 21)
> -#define RCANFD_CCTR_BOM_BEND           (0x2 << 21)

If the driver uses one of the possible field values, why not keep the
other values for documentation purposes?

> -#define RCANFD_CCTR_TDCVFIE            BIT(19)
> -#define RCANFD_CCTR_SOCOIE             BIT(18)
> -#define RCANFD_CCTR_EOCOIE             BIT(17)
>  #define RCANFD_CCTR_TAIE               BIT(16)
>  #define RCANFD_CCTR_ALIE               BIT(15)
>  #define RCANFD_CCTR_BLIE               BIT(14)

> @@ -196,13 +169,6 @@
>  #define RCANFD_FDCFG_TDCOC             BIT(8)
>
>  /* RSCFDnCFDCmFDSTS */
> -#define RCANFD_FDSTS_SOC               GENMASK(31, 24)
> -#define RCANFD_FDSTS_EOC               GENMASK(23, 16)
> -#define RCANFD_GEN4_FDSTS_TDCVF                BIT(15)
> -#define RCANFD_GEN4_FDSTS_PNSTS                GENMASK(13, 12)
> -#define RCANFD_FDSTS_SOCO              BIT(9)
> -#define RCANFD_FDSTS_EOCO              BIT(8)
> -#define RCANFD_FDSTS_TDCVF             BIT(7)

Does it make sense to remove all simple bit and proper mask definitions?
They serve as documentation.

>  #define RCANFD_FDSTS_TDCR              GENMASK(7, 0)
>
>  /* RSCFDnCFDRFCCx */
> @@ -215,7 +181,6 @@
>  /* RSCFDnCFDRFSTSx */
>  #define RCANFD_RFSTS_RFIF              BIT(3)
>  #define RCANFD_RFSTS_RFMLT             BIT(2)
> -#define RCANFD_RFSTS_RFFLL             BIT(1)
>  #define RCANFD_RFSTS_RFEMP             BIT(0)
>
>  /* RSCFDnCFDRFIDx */
> @@ -224,8 +189,6 @@
>
>  /* RSCFDnCFDRFPTRx */
>  #define RCANFD_RFPTR_RFDLC(x)          (((x) >> 28) & 0xf)
> -#define RCANFD_RFPTR_RFPTR(x)          (((x) >> 16) & 0xfff)
> -#define RCANFD_RFPTR_RFTS(x)           (((x) >> 0) & 0xffff)

OK, as macros like this will probably be reworked anyway when these
ever become used with FIELD_{GET,PREP}(), .e.g

    #define RCANFD_RFPTR_RFDLC    GENMASK(31, 28)

> @@ -298,16 +256,10 @@
>  #define RCANFD_GSTS                    (0x008c)
>  /* RSCFDnCFDGERFL / RSCFDnGERFL */
>  #define RCANFD_GERFL                   (0x0090)
> -/* RSCFDnCFDGTSC / RSCFDnGTSC */
> -#define RCANFD_GTSC                    (0x0094)

Note that removed register offsets will become anonymous gaps when the
register offsets are replaced by C structs, cfr. commit ab2aa5453bb83d05
("can: rcar_canfd: Describe channel-specific FD registers using C struct").

>  /* RSCFDnCFDGAFLECTR / RSCFDnGAFLECTR */
>  #define RCANFD_GAFLECTR                        (0x0098)
>  /* RSCFDnCFDGAFLCFG / RSCFDnGAFLCFG */
>  #define RCANFD_GAFLCFG(w)              (0x009c + (0x04 * (w)))
> -/* RSCFDnCFDRMNB / RSCFDnRMNB */
> -#define RCANFD_RMNB                    (0x00a4)
> -/* RSCFDnCFDRMND / RSCFDnRMND */
> -#define RCANFD_RMND(y)                 (0x00a8 + (0x04 * (y)))
>
>  /* RSCFDnCFDRFCCx / RSCFDnRFCCx */
>  #define RCANFD_RFCC(gpriv, x)          ((gpriv)->info->regs->rfcc + (0x04 * (x)))

> @@ -482,23 +358,11 @@ struct rcar_canfd_f_c {
>         (RCANFD_F_CFOFFSET(gpriv) + 0x0c + (0x180 * (ch)) + (0x80 * (idx)) + \
>          (0x04 * (df)))
>
> -/* RSCFDnCFDTMXXp -> RCANFD_F_TMXX(p) */
> -#define RCANFD_F_TMID(p)               (0x4000 + (0x20 * (p)))
> -#define RCANFD_F_TMPTR(p)              (0x4004 + (0x20 * (p)))
> -#define RCANFD_F_TMFDCTR(p)            (0x4008 + (0x20 * (p)))
> -#define RCANFD_F_TMDF(p, b)            (0x400c + (0x20 * (p)) + (0x04 * (b)))
> -
> -/* RSCFDnCFDTHLACCm */
> -#define RCANFD_F_THLACC(m)             (0x6000 + (0x04 * (m)))
> -/* RSCFDnCFDRPGACCr */
> -#define RCANFD_F_RPGACC(r)             (0x6400 + (0x04 * (r)))

OK, as probably the high register offsets will never be used.

> -
>  /* Constants */
>  #define RCANFD_FIFO_DEPTH              8       /* Tx FIFO depth */
>  #define RCANFD_NAPI_WEIGHT             8       /* Rx poll quota */
>
>  #define RCANFD_NUM_CHANNELS            8       /* Eight channels max */
> -#define RCANFD_CHANNELS_MASK           BIT((RCANFD_NUM_CHANNELS) - 1)

Yeah, this one was never used.

>
>  #define RCANFD_GAFL_PAGENUM(entry)     ((entry) / 16)
>  #define RCANFD_CHANNEL_NUMRULES                1       /* only one rule per channel */

As the patch is correct:
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

