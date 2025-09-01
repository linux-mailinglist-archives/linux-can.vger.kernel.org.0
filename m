Return-Path: <linux-can+bounces-4410-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D709B3E4C1
	for <lists+linux-can@lfdr.de>; Mon,  1 Sep 2025 15:24:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5BFD2176DA6
	for <lists+linux-can@lfdr.de>; Mon,  1 Sep 2025 13:24:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2404C33436A;
	Mon,  1 Sep 2025 13:24:38 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from mail-vk1-f175.google.com (mail-vk1-f175.google.com [209.85.221.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 750BA322775;
	Mon,  1 Sep 2025 13:24:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756733078; cv=none; b=eL0OtvKISJqb05FsUZuTEOn9LW3JEDfn10FiKz7Xpcz2yLWYmEvi7BHejIiRTXso0rIIQ8Q3BEJj/d7Kr9KobN17Man28uV/8+iag+VbOy4sh9Z6HAJAlMGVS8ydmVcI8MTwziy9OB4iS8G8VYhHHgUn1JOUDxu283A0l1IcYjs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756733078; c=relaxed/simple;
	bh=rKrYfoPfBBOrA0P7gnSOwuri9R09s712uqIaVZJq5x4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QLz3+CfvsKK+79liA35mxcgUiIBWwr8C111BXjDhp/6a7cr3AEI3WO24+OCIffOacYR7OgUfeAjdaK56WuPCNP/ivUuPwuu41aDpCNyfD1yFSc1MaxxZ0DyftJ2XRJR4LrSCZWSIPzdPnzy83NBuu6fsAlhLVdgGXWiQqI6qGtU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f175.google.com with SMTP id 71dfb90a1353d-54486a29d1aso1048043e0c.1;
        Mon, 01 Sep 2025 06:24:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756733074; x=1757337874;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wzMryIoyTm6AGhQZFb115xZJAQ41K/mzWDtPCHMIf2I=;
        b=s33PrPEgSTRvMGyFKYQMbeA5m1fa+oLb3wb/MiElt0+mdD5DPj56Gp2czSI/k5ZKDT
         cObDCZD/+WpQ1rDLaNi8aMxMGOGvICJmLgX228HXYyQDJEQbLZAfoTXBvqloMMBSt+um
         /96xuJTWbvTtaJrf3abBf20kStA+Z3vZUX5ezpAzJqr0fUL+gUVuNZVQiALadxKN+XYo
         /mNsHOFrPOOQjIzgXr/XqRTRhFwRGE+Ytz3TMAfdCtpszHRQ3ciiHG5QhmaDH/symCgW
         TOLaP1kQDJllTmsO42iHfA5i8EeszuOyphQAGETVmiN7zvECDSnW49Y/PqzldBg5ru/t
         lVEQ==
X-Forwarded-Encrypted: i=1; AJvYcCUvw4Bb5uq8daZKC68Frr+M3xzXb6XP3ExH8Rhb2fyHdO/W1M+f54+3Lb7acquC0eYBV7HN+b/qhYYJ/Yd+@vger.kernel.org, AJvYcCUy4rUbh5lRtnggmFRe7vU/cIwmPYmaDW0psTS9Ud0zJ5qq2yXa99BbMKYZKDonjFAGvZOJLkxXKXwmf6ERjKK66sY=@vger.kernel.org, AJvYcCWKeiBAxC159gAv8j728wAzsXmqNc1nBiu/lLgIGDa8mgi/9ti5GT25HskRuP3pa4o3QH79vld/80w=@vger.kernel.org
X-Gm-Message-State: AOJu0YwdspIBflgRH+LSuMozzyiqk3SsEruR8P+ERLhul9+ntjE+ecuo
	Qa5XrcdeIdUQdHq69JcnGjrnGvloni+53UjExayTP3EQ23ACRLDSyaUfWT8t5Tfp
X-Gm-Gg: ASbGncvyFEHMFpTUZaVCaStPt/nbu93eq6g45IJQSrNT1qoe0RKMcKH3eRxtUikC4QV
	OOCAPHwkZtjuX1CiGadJuwbnwi6pxOkQaND51Zeg87BdgjNjCGi4mP94BFxdU/G02sVGp/6UjKy
	6KqDZZufpNXMfJf0t7LkFaRjfSIsfvEKmCNHNyNUrX5aKgfYs3EcKgpvSZOfFQyxVTSpYYl1Fuo
	VImgHiL7XXIj7DORSoUDhD9iin/pn87FKOKqcP3BgSaWxQMdYSW25da0UEPkGEJ4kWlb8D7kJK7
	Pb+HWP/HW/kX4ENGVldaprC7wRbuPFG62IEjUNbrHqAoDfw1xy12w+qVsQJStZkI1pm07lkvDyl
	Z2QBUae8Pd+3xZh9R3KTZS7pDLFD1/cwC1+EodtVhl9KmShnXlY+4LxJnfsKa
X-Google-Smtp-Source: AGHT+IGZn4VcdTfDtjHA7uptKc2yiRwqXIn6BG6raFCNsQru9pBK1gXKqBW2v6QTzrtYhDWYCvRvlg==
X-Received: by 2002:a05:6122:8c21:b0:541:fdc4:2551 with SMTP id 71dfb90a1353d-544a01d3574mr1861627e0c.3.1756733074055;
        Mon, 01 Sep 2025 06:24:34 -0700 (PDT)
Received: from mail-vs1-f42.google.com (mail-vs1-f42.google.com. [209.85.217.42])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5449131c808sm4236288e0c.13.2025.09.01.06.24.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 01 Sep 2025 06:24:33 -0700 (PDT)
Received: by mail-vs1-f42.google.com with SMTP id ada2fe7eead31-51d14932f27so1619491137.2;
        Mon, 01 Sep 2025 06:24:33 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUUwqFzCl3I9U/y5SFNb6CStqfo8VrjOOKzIaqaf5rUU/vifgGivx2jrsXnlRgPi0B4PgAuxs5Krn4=@vger.kernel.org, AJvYcCWGWNDVZ0GjT2oodCG01YrGyHxR8jYVVeebwOYgtXUIr+Q+T9tII9G33kbv4O539ieu4kuXGhEJD2LEODS8@vger.kernel.org, AJvYcCX497DcE24aup4ENpm+FaTDJ1b26n8SOu+zVTp1ZINEmmuz2zLlxzSSjbCZuGyvsJDmXWeMaqUoi+eExAnO/p6VxbQ=@vger.kernel.org
X-Received: by 2002:a05:6102:6a8c:b0:523:759e:b0cf with SMTP id
 ada2fe7eead31-52b1b8069a9mr1971635137.21.1756733073524; Mon, 01 Sep 2025
 06:24:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250821141429.298324-1-biju.das.jz@bp.renesas.com> <20250821141429.298324-3-biju.das.jz@bp.renesas.com>
In-Reply-To: <20250821141429.298324-3-biju.das.jz@bp.renesas.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 1 Sep 2025 15:24:22 +0200
X-Gmail-Original-Message-ID: <CAMuHMdU8pyRPiS-q5N-WKXLTX+hiNQSR8oPVkoV-VoKHgOp13g@mail.gmail.com>
X-Gm-Features: Ac12FXyyZRPaOTogYWEPKuCuGSscbKQviaYzpAaGc2LL9C_7v_1G-UL6O_yr0BE
Message-ID: <CAMuHMdU8pyRPiS-q5N-WKXLTX+hiNQSR8oPVkoV-VoKHgOp13g@mail.gmail.com>
Subject: Re: [PATCH v2 2/4] can: rcar_canfd: Update RCANFD_CFG_* macros
To: Biju <biju.das.au@gmail.com>
Cc: Marc Kleine-Budde <mkl@pengutronix.de>, Vincent Mailhol <mailhol.vincent@wanadoo.fr>, 
	Magnus Damm <magnus.damm@gmail.com>, Biju Das <biju.das.jz@bp.renesas.com>, 
	linux-can@vger.kernel.org, linux-renesas-soc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, 
	Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>
Content-Type: text/plain; charset="UTF-8"

Hi Biju,

On Thu, 21 Aug 2025 at 16:14, Biju <biju.das.au@gmail.com> wrote:
> From: Biju Das <biju.das.jz@bp.renesas.com>
>
> Update RCANFD_CFG_* macros to give a meaning to the magic number using
> GENMASK macro and extract the values using FIELD_PREP macro.
>
> Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
> ---
> v1->v2:
>  * Moved from patch#4 to patch#2.
>  * Updated commit header and description.
>  * Kept RCANFD_CFG* macro definitions to give a meaning to the magic
>    number using GENMASK macro and used FIELD_PREP to extract value.

> --- a/drivers/net/can/rcar/rcar_canfd.c
> +++ b/drivers/net/can/rcar/rcar_canfd.c
> @@ -103,10 +103,10 @@
>  /* Channel register bits */
>
>  /* RSCFDnCmCFG - Classical CAN only */
> -#define RCANFD_CFG_SJW(x)              (((x) & 0x3) << 24)
> -#define RCANFD_CFG_TSEG2(x)            (((x) & 0x7) << 20)
> -#define RCANFD_CFG_TSEG1(x)            (((x) & 0xf) << 16)
> -#define RCANFD_CFG_BRP(x)              (((x) & 0x3ff) << 0)
> +#define RCANFD_CFG_SJW_MASK            GENMASK(25, 24)
> +#define RCANFD_CFG_TSEG2_MASK          GENMASK(22, 20)
> +#define RCANFD_CFG_TSEG1_MASK          GENMASK(19, 16)
> +#define RCANFD_CFG_BRP_MASK            GENMASK(9, 0)

Upon a second look, I would drop the "_MASK" suffix.

>
>  /* RSCFDnCFDCmNCFG - CAN FD only */
>  #define RCANFD_NCFG_NTSEG2(gpriv, x) \

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

