Return-Path: <linux-can+bounces-3093-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BECFBA61404
	for <lists+linux-can@lfdr.de>; Fri, 14 Mar 2025 15:48:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 762247A6118
	for <lists+linux-can@lfdr.de>; Fri, 14 Mar 2025 14:47:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45CD8201013;
	Fri, 14 Mar 2025 14:48:28 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from mail-ua1-f51.google.com (mail-ua1-f51.google.com [209.85.222.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C7BA1FF5FE;
	Fri, 14 Mar 2025 14:48:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741963708; cv=none; b=mG8C4zYY/qDOYd3guLF86UTg6tGQbW1/08HZ5eHyLIdEonxTF7k6DhEAgeO5/8C875IBmFIIA1lLgf6+zclLcCpIkM42ZzX+gycLhWodjrP1EJpPJzGg8NTrLmGw5kazSAdlkRv6kNP4R2l5Nyrrlwz4/1YV9RQrOXr6gtkhSn8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741963708; c=relaxed/simple;
	bh=5fTcQrBhy7k4HG4fvoJbi7zGOnzsu/M5gYneYh+/NVg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UMb0L2RmcmFStx9zQya+FMCvAL2kQhpGXkD6XsxNE/e7YEBX51T2d7eSVhbUk4jwS1vBmtrF6pTBQk3LVNfdeWaC7oR8uEvTzEK/clGG6fzHMn5gvAvxxz9Ny36OvO90o4IKjXDugyO2MZuhz4rXNgQ7w0UoBeihddLtXLkJTJM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.222.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f51.google.com with SMTP id a1e0cc1a2514c-8671441a730so866336241.0;
        Fri, 14 Mar 2025 07:48:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741963705; x=1742568505;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=66DrKpqkB6choMU1worCHFgEcn2xfzUwOUKI1fjZTcU=;
        b=UMsGAD9nMnS250Y0hbDLwOiMVx7IH5oKsmwnljgRja6MLfiiCb4+oedEbsE0ynwmkD
         ojhT/wo5jwD6nhZO1kCv8mfSaO7hs7aUdHfMSibJLiEA0iimm6Et51PGXH/gE8PBIRSd
         6z+MMsUztMOwGefIqoTUnZ78yQsVb7lqgusCC/5FvFJ/poa/sSmbdIUxw6RzpCKuGRDM
         nrj9jPMqE37U+ThorW366sktQ0dF7BoGIvFmx6yI7S9VyO4n4zSMdZbEpUviT/LFr7dT
         RkBtmx2Zy9UBYrwutpE3XLtZbFO1fJIXcPjdR8AeaUfDk8PDQWLSQGn3c6vI25FmL248
         MOVA==
X-Forwarded-Encrypted: i=1; AJvYcCV3tIAZ31hlGk7UkkZj8VdWnZqqhKELYD5JfMJe/THqOmmbtCuq3NcNz3YgRmEhxn/Vm6kntSoJZDE=@vger.kernel.org, AJvYcCWRb1SsdOu1UwPXYlXSUVPeOoKJqzPIseRATo8EBgQR1XrYURyGfrwuGbDfuPF1YI6t3ueT/K9ecXlRGkeoLxA2LIY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxrWUru8rRsUYux+xBx9c3DoYCj3UcUuxdhZQ2gNOst49xnQltg
	1MivooTMxmcakrNFpFmITeBr1Pn468SQKAAUqO6UyJyEQW5nH1yJHZEQiWsOLdM=
X-Gm-Gg: ASbGncsfHWTmNG+/tZ1XzZ4aDxKs4P0vGqaJF5QiAFqCy6P/F6nct+VgdIaulw8diDf
	BcFOXMgZWxNum2yZAbFGlD9//3N0c6g5AF/UO5uqoXWfSggCEs3qRNgx/YaANZiTlp37/NlsC/c
	OWQxQlTQFBsbxkMpS5D4dMIaExj3L5h/Zn/imc2XDUyuZhmrS58ezY1stmbYuDT5O/xXkmwiGDQ
	ET0ltMzAq2NZ3sblzsSlRkOZ6JRbBwAX80XQAfc+WhnJ5i3Bn9EF44557roOBM9vQnQayyTD6F3
	/d6hNQESKxIwKY6dY10SGnlILS6QzFRLgFCTgaE217FvACT4CRhd798edonYxvqaE6vhcCWTKkJ
	PC7Yg51A=
X-Google-Smtp-Source: AGHT+IEcS99Ak5Ecto7JQaR0HPfr3faRB8Poq3caG7wtRYLgkqaiRJmU2eNUuVLpYvGIfowljn2iqg==
X-Received: by 2002:a05:6102:160c:b0:4bb:d062:420 with SMTP id ada2fe7eead31-4c3831103c4mr1811967137.1.1741963704759;
        Fri, 14 Mar 2025 07:48:24 -0700 (PDT)
Received: from mail-ua1-f49.google.com (mail-ua1-f49.google.com. [209.85.222.49])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5243a5a3cd4sm582174e0c.19.2025.03.14.07.48.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 14 Mar 2025 07:48:24 -0700 (PDT)
Received: by mail-ua1-f49.google.com with SMTP id a1e0cc1a2514c-86b31db3c3bso841614241.3;
        Fri, 14 Mar 2025 07:48:24 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVVBrhaNii3zYhuUXTtdFavfarRnoiOWY3Z62k9wtv8scxNLHW0WNVaIwTPC69qoyPPebbT9vMpK0oQVzD4Z5aqnrQ=@vger.kernel.org, AJvYcCWOu8ypUdT5xetYLjtwkBSg/tg5Sy+r0Cv+hmWpBsufDdhS7eoGsdMHykG6skF3LchZra76Sp6RO2k=@vger.kernel.org
X-Received: by 2002:a05:6102:304c:b0:4c1:8928:cefb with SMTP id
 ada2fe7eead31-4c383161fb7mr1793671137.12.1741963704095; Fri, 14 Mar 2025
 07:48:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250306124256.93033-1-biju.das.jz@bp.renesas.com> <20250306124256.93033-12-biju.das.jz@bp.renesas.com>
In-Reply-To: <20250306124256.93033-12-biju.das.jz@bp.renesas.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Fri, 14 Mar 2025 15:48:12 +0100
X-Gmail-Original-Message-ID: <CAMuHMdX_SxAh-T0UzGvJ2rZ=6r3uyDrpHmyVgn1Fv5r51Tpyog@mail.gmail.com>
X-Gm-Features: AQ5f1Jrue-_jA5QwmcQns4KAwRzOzgqDCmdSboEQ9LEONF_HLwQrvQPHIL7SYQE
Message-ID: <CAMuHMdX_SxAh-T0UzGvJ2rZ=6r3uyDrpHmyVgn1Fv5r51Tpyog@mail.gmail.com>
Subject: Re: [PATCH v4 11/11] can: rcar_canfd: Add RZ/G3E support
To: Biju Das <biju.das.jz@bp.renesas.com>
Cc: Marc Kleine-Budde <mkl@pengutronix.de>, Vincent Mailhol <mailhol.vincent@wanadoo.fr>, 
	Wolfram Sang <wsa+renesas@sang-engineering.com>, 
	Geert Uytterhoeven <geert+renesas@glider.be>, 
	=?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <u.kleine-koenig@baylibre.com>, 
	linux-can@vger.kernel.org, 
	Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>, Biju Das <biju.das.au@gmail.com>, 
	linux-renesas-soc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Biju,

On Thu, 6 Mar 2025 at 13:43, Biju Das <biju.das.jz@bp.renesas.com> wrote:
> The CAN-FD IP found on the RZ/G3E SoC is similar to R-Car Gen4, but
> it has no external clock instead it has clk_ram, it has 6 channels
> and supports 20 interrupts. Add support for RZ/G3E CAN-FD driver.
>
> Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>

Thanks for your patch!

> --- a/drivers/net/can/rcar/rcar_canfd.c
> +++ b/drivers/net/can/rcar/rcar_canfd.c
> @@ -1979,6 +1991,7 @@ static int rcar_canfd_probe(struct platform_device *pdev)
>         u32 rule_entry = 0;
>         bool fdmode = true;                     /* CAN FD only mode - default */
>         char name[9] = "channelX";
> +       struct clk *clk_ram;
>         int i;
>
>         info = of_device_get_match_data(dev);
> @@ -2068,6 +2081,11 @@ static int rcar_canfd_probe(struct platform_device *pdev)
>                 gpriv->extclk = !gpriv->info->only_internal_clks;
>         }
>
> +       clk_ram = devm_clk_get_optional_enabled(dev, "ram_clk");
> +       if (IS_ERR(clk_ram))
> +               return dev_err_probe(dev, PTR_ERR(clk_ram),
> +                                    "cannot get ram clock\n");
> +

clk_ram is unused.

>         addr = devm_platform_ioremap_resource(pdev, 0);
>         if (IS_ERR(addr)) {
>                 err = PTR_ERR(addr);

Gr{oetje,eeting}s,

                        Geert


--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

