Return-Path: <linux-can+bounces-3091-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DC5AA61401
	for <lists+linux-can@lfdr.de>; Fri, 14 Mar 2025 15:48:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C2F877A636D
	for <lists+linux-can@lfdr.de>; Fri, 14 Mar 2025 14:47:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F24BF1FF5FE;
	Fri, 14 Mar 2025 14:48:08 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from mail-vk1-f180.google.com (mail-vk1-f180.google.com [209.85.221.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 685FE1990BA;
	Fri, 14 Mar 2025 14:48:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741963688; cv=none; b=DdTvlUQapXFZK35jTljG9ycVAebxwac9dF2hs/u3kHKRVjpy8D/5ZPLKO9fSzhGG29GCbYC4DEj1V/MNBS+oVbMKs+B/9ikYNXJ2dQ0CKTKT5VBB2dYTMulWa0DX/Wax3KOU6rgNwFu25XDA4aCtJZHLiu0YxF0Lt8VLE4QTi4g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741963688; c=relaxed/simple;
	bh=6g0TmQlCx9TBacWDvoatVhjugvxgbVclVOgGmVVrJ1k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=K4nPRLtZwbnqPRMz9bMQ4wWrY4yRohrrFkWWyj25LJFn8OJzutCklzup3uokfRt42xKPlHAyae8ytYa6UL9MJ1ypzJUn6Xj1BluIu9bYMp9hEw1g6aWSh59ddsy8/w3muuasCZLxDcT4Jr9DMb9Xvn246jBpJuw/YO9OJR6dSUE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f180.google.com with SMTP id 71dfb90a1353d-51eb1823a8eso1004081e0c.3;
        Fri, 14 Mar 2025 07:48:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741963686; x=1742568486;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=etnPq4HVajUP8F7sSsRj7xU1/cH3ZduQw3e22KDuh7g=;
        b=hrjcuBm0U80qgR7Lm4ekz1TZf9YPwiwYkp7rcuERrCbsogieIyePSvURQJVIGBKALg
         G2vLpPMv+2dXzob6JTUUME+XpZ18qn5LXUMawPrE1JJApR2B2n5U912hSPAtLkAtoGMM
         6XJgfAWtmg6txkBIXuYr1PJhuQXSyPBfmxIDVxRjjRfZVOt30DtjMY7GsIuMgbAFgoBR
         jv7JmTz6cSruQCUwG7+qVzyF3UC4lfqWcmGMFM0k/ovACxXYBrS2KqXRqO/r1wgIh8pw
         rxXUT9t4W03SGiCW2Um+e0EY7Goh/utFx9Ac7I+DxiG2jaRt6c8TdnGPdpTx3K9Ql5D/
         NBVQ==
X-Forwarded-Encrypted: i=1; AJvYcCVc8VW6aZi6ba367OZJy9O601OT2UdWADJYn9lkoZe/KZCM07losyzhrUKvnn77EgkykaNWYjU1n7W1jum/IfMkB5Q=@vger.kernel.org, AJvYcCWo8y0rVRbFvVuDw1YfCzlKl+Kd1zO+uDZjSvJTv5+LOp9YcT9JhJ9mkqAf0fUjyp62lz8u3VbfLog=@vger.kernel.org
X-Gm-Message-State: AOJu0YyqiWvIi8ampnDbVA6uiuzLU1TZIvphtJFiEtQfCz6YEmemDuHJ
	DRZwd29tH4AhYXvWkUK+LfAdF4gIgbEhp819HGVX0RPHQdBcprsgLHTTvAzBv1Y=
X-Gm-Gg: ASbGncvveyBMkYs/mtjEvfkVv5ZkvEQFGAuporbp8IvLRhXOPJaggfhpHFTzTv563Yh
	Uo+U6ICSZ6knFyAedSjd3r8TZTOsLIV8l194y0By5A1PMeO3XCFi5JE20Foxz8Jwv2nsaMG+ElV
	t1GkAtK4Ce+fF6aAWaw0hr98lUO1b+FKobIO+qEgn+zyKjM9TJwSOS2zvOffvaLhyW7bcpSPvFk
	40VZRUa+0bStEGDEJXDzmUe6aYZMYdddV71BMx3AtpC6+6B2SiBy/VUi6L+Mvkx8UkVJkR156pj
	acMAoI53a1G34qHftr/+gpu08G4bXT9cl4LAjKsaGEvduYhwsFzLHKyGHiAT5G/ZNRbgf13ngPy
	3V6Fa3CAydmYYjnKu/jGQDw==
X-Google-Smtp-Source: AGHT+IFWiceqmoNibdru5czhg+uM75vcQWwMpVIrqUtcshDdv5cg9XHWavCtLO4Qi1w5H2gDPl4Fpw==
X-Received: by 2002:a05:6122:6142:b0:524:2fe2:46ba with SMTP id 71dfb90a1353d-52449a440e8mr1824261e0c.11.1741963685714;
        Fri, 14 Mar 2025 07:48:05 -0700 (PDT)
Received: from mail-vk1-f177.google.com (mail-vk1-f177.google.com. [209.85.221.177])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5243a5d753bsm585097e0c.28.2025.03.14.07.48.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 14 Mar 2025 07:48:05 -0700 (PDT)
Received: by mail-vk1-f177.google.com with SMTP id 71dfb90a1353d-51eb1823a8eso1004059e0c.3;
        Fri, 14 Mar 2025 07:48:05 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUj3rBTmg8qOYzwvBvOmE8Hv/9YnIiWXywTbpkgsTK0z9pTpCb6qTOBpv0YIWncPbHIWcymVggcOKFHh8sramB/CVs=@vger.kernel.org, AJvYcCVciE3pv1IKnvQ6kTCDrg9voV+cO4qKknlazlnHqrhx8DsHSs3yKyRmAyqFng+jirDao4bIEkVpAMQ=@vger.kernel.org
X-Received: by 2002:a05:6102:17c9:b0:4c1:7a08:9279 with SMTP id
 ada2fe7eead31-4c38316dae9mr1453700137.15.1741963685132; Fri, 14 Mar 2025
 07:48:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250306124256.93033-1-biju.das.jz@bp.renesas.com> <20250306124256.93033-10-biju.das.jz@bp.renesas.com>
In-Reply-To: <20250306124256.93033-10-biju.das.jz@bp.renesas.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Fri, 14 Mar 2025 15:47:52 +0100
X-Gmail-Original-Message-ID: <CAMuHMdWQQGHdg_bH8+QTwXKOxQb6_M3Hkj5Re4QkGU8BNZ6vhg@mail.gmail.com>
X-Gm-Features: AQ5f1JpZQhtRppLLkpwf9mRQOH-8vb8sF-mX-RFtt_oLSO6sT3TupCfyuRlVAiE
Message-ID: <CAMuHMdWQQGHdg_bH8+QTwXKOxQb6_M3Hkj5Re4QkGU8BNZ6vhg@mail.gmail.com>
Subject: Re: [PATCH v4 09/11] can: rcar_canfd: Add only_internal_clks variable
 to struct rcar_canfd_hw_info
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

Thanks for your patch!

On Thu, 6 Mar 2025 at 13:43, Biju Das <biju.das.jz@bp.renesas.com> wrote:
> All SoCs supports extenal clock, but RZ/G3E has only internal clocks. Add

existing SoCs .... an external

> only_internal_clks to struct rcar_canfd_hw_info to handle this difference.
>
> Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert


--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

