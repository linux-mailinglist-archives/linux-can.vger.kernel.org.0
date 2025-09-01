Return-Path: <linux-can+bounces-4408-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C0950B3E473
	for <lists+linux-can@lfdr.de>; Mon,  1 Sep 2025 15:17:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 93E3F17BE79
	for <lists+linux-can@lfdr.de>; Mon,  1 Sep 2025 13:16:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C598188715;
	Mon,  1 Sep 2025 13:16:41 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from mail-vk1-f177.google.com (mail-vk1-f177.google.com [209.85.221.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D2661531E8;
	Mon,  1 Sep 2025 13:16:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756732601; cv=none; b=WWmL1QPaIJcR6NHdYP710GYxQ/8BoJhu0aMGtiYFGVjEvvPyIAl9+C1r4Pe4YdxNFCR6yZ9nyKRf7bEYGdCXNdg9IlmAqqxm9ayPTkx3p+zLNUTVZcYvr/bv/6umQBm/Opp4ZgOP+LWwGLVVAg19YFPdGIC74Nc9gvdRMe63gWI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756732601; c=relaxed/simple;
	bh=EXkMw+rfDaY/b3W8q8CYiOJOTW2nC12iUWMId+zXff4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=S7yhGJKGfQyXF4O2CttJ/CI004hHopNTGwNrYxMzc+LKzqglvefc5Fbfe9H3FWwqZ/apcXO4sEmTxBHOCw602cWagSwzqnxbV2PLQ3l6K8BplRgEML+PbuSu2fB/M5PSj0O1B74Rsw47y/LLMLFTi2uDwZdIpyH8LjJhg4p84xA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f177.google.com with SMTP id 71dfb90a1353d-544af5b745cso853166e0c.0;
        Mon, 01 Sep 2025 06:16:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756732598; x=1757337398;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=M4vm21dS0tITKOYITi0Vz3OqhwroxN/24zqHGcaryPc=;
        b=k64ThNftCCUIgIDE2PmlFLmEFOqK21rn0IS+Cxr4T5el7hKMp4fh8gwbOfoOm1Ffhm
         WuL/FVY0l3nFMNmuGZPq7/N4McIH8d5IA39EiNPHPWvGAzA3Jovq8gbnB9KNdszJYBvi
         EREaQBq5xZ0CUYZDah+L6r+axyDTxIDdTvpWYjfar6D/4LELMY/c4c23lS2Up9Vm5sR/
         CJVApL7JLMyAjmqiHC7TvqLjyoDukRaEKS9i2/z7scQzcMCO1OSLU5qlkaymnI1j8Dbi
         aIzelyso1zptubX7fOhacG3ESo3tfd+Xlwpw0XtiPc89+XrlVpwQ0kh3LKFqMUtQ8BZh
         Y39g==
X-Forwarded-Encrypted: i=1; AJvYcCU1DbioPdAqWoZuesOdgTwLFspTEZKBCXZPzsBZBDwPesLRCNDVgjGAEFHWInYiKFRuyjIozxIP3AErSAny0PFKrVA=@vger.kernel.org, AJvYcCUwlxjus+schurw1Valbut3o8iyX26CT3P+Z9ItZiJHyaFRh/jtro4Uv2bF7jGovxW33sgX3bZGmzE=@vger.kernel.org, AJvYcCVy9PX60ewdWsudIyjAkgxkNHcCa08bl/733uI9o0x4XT9fpiPP68VI6txpC4cHIuiva9yit7zrbWn+QDSP@vger.kernel.org
X-Gm-Message-State: AOJu0Yx8kYvlQj09PZqi4PV7MeredmgOtOMUtbFB71SmGDEJJBsKggMP
	LRBNXnF0cSCxkP2LdIh1c4bLIpfkIgJ6FdLvaLsBj8Qb8AKb+RCmSKMnzizq4J7l
X-Gm-Gg: ASbGncu7UZIKsC3X7MyjLnwVjNFFGyEKzdHFpTk9iPSog/LKSfRREvlXtJY6ALih7KZ
	4gqxN1urlp6OH+gr8TeLkhMyxgchpdsZH3CsIifwG9kxTOrPilykl0fFhjiYQXB5YXIrKC8pqZi
	4U4Xn5FwQjCNq9Ng15GQ6LpYUuzQd991t6hNcbvNFfWXCWhEP8kmE0a+8pq7s7nJUZRhSi3uUKD
	zV2KYpefaiDJ1y1YgogDER9qtIrZYK1LeN0beJz/WSK0OPNOCv0v2n6szt9fGTCUCbrfqzxPpOB
	qMflrechupgwjFtt78N/+IbOHzWHBBEexn+ECvmDhXBUawBpLPnl8LJgIlpo3G55UCZDBy1JOin
	UmqiB4qyJL8Ryl39OL/KDbLRLQ/JaY4/XorCzcDprezd3S3KpmUW8pYEy66aDJpKfa9EnCDIgt+
	epZ/+lKQ==
X-Google-Smtp-Source: AGHT+IE0Y+GTISSI3oX/aDAzwHXEUcbYM0fOes0m/HsvgRH+60XBHCsrnPj3r9QFUMHrvfAteWbaEw==
X-Received: by 2002:a05:6122:4f82:b0:531:236f:1283 with SMTP id 71dfb90a1353d-544a024826cmr2332119e0c.10.1756732597766;
        Mon, 01 Sep 2025 06:16:37 -0700 (PDT)
Received: from mail-vs1-f42.google.com (mail-vs1-f42.google.com. [209.85.217.42])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-544914bcb39sm4233164e0c.27.2025.09.01.06.16.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 01 Sep 2025 06:16:37 -0700 (PDT)
Received: by mail-vs1-f42.google.com with SMTP id ada2fe7eead31-52b2f964888so470542137.2;
        Mon, 01 Sep 2025 06:16:37 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVIfb/kue+lKX+q6V1TC3W08HOCQG4TjfHyokWYmyZRYEiEo2CbduGJ+IEZsq47zhiDIvZTFCn0Iag=@vger.kernel.org, AJvYcCVR1z/4quRC6cy/lMK3IEHvX50qxh/CflOae86KdOk/hPYTd0yrJ+DGUYZIJw+cN3smG7PuSKmaRrSFlzMDGyUryVo=@vger.kernel.org, AJvYcCViub9OUrwNJH+cHD5G8p+hKl+nE6vibtzgq2OGF2iFTV1A+/cze0GG2GY+UWBCDpqqjnKYsMjrL2y2CG8E@vger.kernel.org
X-Received: by 2002:a05:6102:5e94:b0:529:bfd2:382a with SMTP id
 ada2fe7eead31-52b1bf3b89fmr2476923137.32.1756732597303; Mon, 01 Sep 2025
 06:16:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250821141429.298324-1-biju.das.jz@bp.renesas.com> <20250821141429.298324-2-biju.das.jz@bp.renesas.com>
In-Reply-To: <20250821141429.298324-2-biju.das.jz@bp.renesas.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 1 Sep 2025 15:16:26 +0200
X-Gmail-Original-Message-ID: <CAMuHMdUhR1PgfY28uVCN6hQjO9sMRJFiTEUAnAqPX+px6Wp1QQ@mail.gmail.com>
X-Gm-Features: Ac12FXz5MMFkh0UeurQJEvIWlmmprvC8x6xknXxamo0u7vEFGXvDqdSp6trm93E
Message-ID: <CAMuHMdUhR1PgfY28uVCN6hQjO9sMRJFiTEUAnAqPX+px6Wp1QQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/4] can: rcar_canfd: Add shared_bittiming variable to
 struct rcar_canfd_hw_info
To: Biju <biju.das.au@gmail.com>
Cc: Marc Kleine-Budde <mkl@pengutronix.de>, Vincent Mailhol <mailhol.vincent@wanadoo.fr>, 
	Magnus Damm <magnus.damm@gmail.com>, Biju Das <biju.das.jz@bp.renesas.com>, 
	linux-can@vger.kernel.org, linux-renesas-soc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, 
	Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>, 
	Fabrizio Castro <fabrizio.castro.jz@renesas.com>
Content-Type: text/plain; charset="UTF-8"

Hi Biju,

On Thu, 21 Aug 2025 at 16:14, Biju <biju.das.au@gmail.com> wrote:
> From: Biju Das <biju.das.jz@bp.renesas.com>
>
> The calculation formula for nominal bit rate of classical CAN is same as
> that of nominal bit rate of CANFD on the RZ/G3E SoC compared to other SoCs.
> Add shared_bittiming variable to struct rcar_canfd_hw_info to handle this
> difference.
>
> Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
> Reviewed-by: Fabrizio Castro <fabrizio.castro.jz@renesas.com>

Thanks for your patch!

> --- a/drivers/net/can/rcar/rcar_canfd.c
> +++ b/drivers/net/can/rcar/rcar_canfd.c
> @@ -461,6 +461,7 @@ struct rcar_canfd_hw_info {
>         unsigned ch_interface_mode:1;   /* Has channel interface mode */
>         unsigned shared_can_regs:1;     /* Has shared classical can registers */
>         unsigned external_clk:1;        /* Has external clock */
> +       unsigned shared_bittiming:1;    /* Has shared nominal bittiming constants */
>  };
>
>  /* Channel priv data */
> @@ -632,6 +633,7 @@ static const struct rcar_canfd_hw_info rcar_gen3_hw_info = {
>         .ch_interface_mode = 0,
>         .shared_can_regs = 0,
>         .external_clk = 1,
> +       .shared_bittiming = 0,
>  };
>
>  static const struct rcar_canfd_hw_info rcar_gen4_hw_info = {
> @@ -649,6 +651,7 @@ static const struct rcar_canfd_hw_info rcar_gen4_hw_info = {
>         .ch_interface_mode = 1,
>         .shared_can_regs = 1,
>         .external_clk = 1,
> +       .shared_bittiming = 0,

I could find no stricter limitation of the bit timings in classical
CAN mode on R-Car Gen4, so it looks like this should be 1, too...

>  };
>
>  static const struct rcar_canfd_hw_info rzg2l_hw_info = {
> @@ -666,6 +669,7 @@ static const struct rcar_canfd_hw_info rzg2l_hw_info = {
>         .ch_interface_mode = 0,
>         .shared_can_regs = 0,
>         .external_clk = 1,
> +       .shared_bittiming = 0,
>  };
>
>  static const struct rcar_canfd_hw_info r9a09g047_hw_info = {
> @@ -683,6 +687,7 @@ static const struct rcar_canfd_hw_info r9a09g047_hw_info = {
>         .ch_interface_mode = 1,
>         .shared_can_regs = 1,
>         .external_clk = 0,
> +       .shared_bittiming = 1,
>  };
>
>  /* Helper functions */
> @@ -1912,7 +1917,10 @@ static int rcar_canfd_channel_probe(struct rcar_canfd_global *gpriv, u32 ch,
>                 priv->can.fd.do_get_auto_tdcv = rcar_canfd_get_auto_tdcv;
>         } else {
>                 /* Controller starts in Classical CAN only mode */
> -               priv->can.bittiming_const = &rcar_canfd_bittiming_const;
> +               if (gpriv->info->shared_bittiming)

... hence you can just check the existing shared_can_regs flag here,
and don't need to introduce a new flag for shared bittimings?

> +                       priv->can.bittiming_const = gpriv->info->nom_bittiming;
> +               else
> +                       priv->can.bittiming_const = &rcar_canfd_bittiming_const;
>                 priv->can.ctrlmode_supported = CAN_CTRLMODE_BERR_REPORTING;
>         }

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

