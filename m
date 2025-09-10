Return-Path: <linux-can+bounces-4631-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 16674B5121E
	for <lists+linux-can@lfdr.de>; Wed, 10 Sep 2025 11:05:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 079E43A01AF
	for <lists+linux-can@lfdr.de>; Wed, 10 Sep 2025 09:05:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E4523115BC;
	Wed, 10 Sep 2025 09:05:03 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from mail-ua1-f54.google.com (mail-ua1-f54.google.com [209.85.222.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20A8B24169F;
	Wed, 10 Sep 2025 09:05:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757495102; cv=none; b=bwfI4FgC1+hTx0s8lf7jQwylZgl8D/iLTwKOTMhEroZzyCWgOnG9UU66Mt6AwK6qBsPoXa6t/IV7cY7eZ/RKiVTJP0JTl11FTAHjaOXOJpM7/lMC+ez3oPdM823taqARLP7N1iDAHBenUQZjhL7yqMN29w/aCzSCjUUgu98MoS4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757495102; c=relaxed/simple;
	bh=ULFWEXXpgGK0E2bpHLUDxT3rhQSjMHmb6+xT2tdZ5Fk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pC+GueDDC+DpHDMvhd2dffaDwTuO35tBJ8He6v2wbKFaRdSAreryrExba1ozn6eluFatiDjh4xFbyuQV/xM7HPKDoLnKB3ba8dwwP5/68T46L4QlrDPtkvTej7ghRLZv2PFSIfBhKpCZpEiAwH8ZrZ2/cUl/iwqq2UG6BM/24Vc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.222.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f54.google.com with SMTP id a1e0cc1a2514c-8a756436f44so2634583241.3;
        Wed, 10 Sep 2025 02:05:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757495100; x=1758099900;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZtJrr9PTITmK7BGrapAXxCBLg6i3ssIvP9U7oMzULN0=;
        b=VXIayjO71E4SnzNbp5qLqU7M45cDRA7R7o1k/+OOAvw7+DlAyQ3IDTdzAnO/qLByPM
         hWxFwK4o3zQokqwkMZyF06+6AvG7bVgPjDeXMapr3XEo0UCiNVnjhqQ62ER1HzMo/FRy
         7Nk42jz0ihBgeXfyUn4l4C7uqdnv18OlksBnL4PlH2zWIrXHT/iDykpgYvFfqpuaFuKx
         p0WSeHVy/LbhvyMDW7Atx/bGTxeaqPvDc+T6pjUj/kizid+aX83cZorZWJezHssZ52fS
         lTdBvXB4QYSyEpWu1aRaYVp3icgfxJsmaRyWHkxTludUgLRHQVntJjCPQ1+cgqy1Vvfh
         rtlg==
X-Forwarded-Encrypted: i=1; AJvYcCVR32dYATwS23Pf1frd3ykDo759CsoBFgS421i0cgU0l06GQpoe9HydN++oqj3R3y/GAgMTelVqQr0=@vger.kernel.org, AJvYcCWo9jRvqtLUrXXldAnV2OxNqdNNqIJwqiu+MGLE8VH/PshWFTj+dkk1D9PebXSWQoO2Hl7kuJk9KZo0aDO/@vger.kernel.org, AJvYcCWs/UiUCNJFKOn6pus5CiLD2MLb8kAWPv8BjbfZ5G7VghIocxIL+5/UPcHnCQnCr0Sw/M6z+MQFDAYyI4C3YjLU1/s=@vger.kernel.org
X-Gm-Message-State: AOJu0YyyAsWeAS7asP4j/XJMpO7azCC31akKYIxzk2rKCpbiN3RhQr1B
	Uh4L1LWLQsVIILFIAw2i31qTt7yunjJdoT8tpldSw6w4LnCi0NczN++pNE8uvgRh
X-Gm-Gg: ASbGnctmUYlhU6NeRnYZ7p6UHQbPdd7RKDkc55WEk0lZZQI8KaY6laueX1o6pD90tjG
	IZ0Ppelh/SJmI1+OMeJ2uRJjXTNUzNavpNePzIFU89tNvEL4cuWEs8r/sGudG/KfSoaC91+N+Z/
	IwCU8Bx4B4Vu/uvip7gBv90+xiEzgX+2lKgeQjpczKlLOntGNWOMFXysNtzNKitGH5Zp2hMVVwy
	yaaVc3+vvMLGomiwhm9KvInLMMFn2IHU8nISHEZvQhgWljILkQKJDbupszK4rudi1Nd4tdDdgis
	Fy85+FD11sEQS8mDpZQY8or7wYKJ24wwLi+M7PcEjGXd64xaLOcfU2+R0nGzJgKnIkJQzeRBhSC
	PgIIyd4Lqxn6paoEJcyVxP4AgDlRPW4qe+AQnQvx/52TKrCLAiiv7XyeaT+ZxykJ77bErXk0=
X-Google-Smtp-Source: AGHT+IFeP7J+jcxHryU7Ykdq0/lcNDAds1tRRlGC0Q7rlDHspoim6c7+evYte/axaBH/cs8crxGTcw==
X-Received: by 2002:a05:6102:f0d:b0:51e:609d:316c with SMTP id ada2fe7eead31-53d1afa353fmr5371444137.4.1757495099942;
        Wed, 10 Sep 2025 02:04:59 -0700 (PDT)
Received: from mail-ua1-f44.google.com (mail-ua1-f44.google.com. [209.85.222.44])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-52aef459c9asm12131364137.1.2025.09.10.02.04.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 10 Sep 2025 02:04:59 -0700 (PDT)
Received: by mail-ua1-f44.google.com with SMTP id a1e0cc1a2514c-8a00c77a62dso3839682241.1;
        Wed, 10 Sep 2025 02:04:59 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUiWozjvuVzoCN+FbTF+DA5sSaT075eHn6y2k3ATFirh9wMpbhJkUKgOUoKA6aIOKQ4HL0AWOjnwvc=@vger.kernel.org, AJvYcCUwrZ6YkkiSUqGSG+Lx0wnxs27MSfrVMhbGsGX3DVOT00pFE38ua3VVY/Mp7eekio+7kMMiYSAKcZRdOlvz3+5PNL0=@vger.kernel.org, AJvYcCXmjkHTKZmjh6EIgWh55Pp3Vqid7Pba24caXPI1XtV034nxhwsslhcZ2eVAdn4VZJRYm93NMdEMW8e38Gn+@vger.kernel.org
X-Received: by 2002:a05:6102:54a4:b0:52d:110:a920 with SMTP id
 ada2fe7eead31-53d2490d703mr4945344137.33.1757495098987; Wed, 10 Sep 2025
 02:04:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250908120940.147196-1-biju.das.jz@bp.renesas.com> <20250908120940.147196-2-biju.das.jz@bp.renesas.com>
In-Reply-To: <20250908120940.147196-2-biju.das.jz@bp.renesas.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 10 Sep 2025 11:04:48 +0200
X-Gmail-Original-Message-ID: <CAMuHMdWmMzZ0gCNVAsBOGKDTO4kAF5TTcSo4V+m-_MGfsTo63Q@mail.gmail.com>
X-Gm-Features: AS18NWDiRMennMrQ7xPzz4lgIRsCHjEKRxOXPU6o84iwg9AC9bKttdHY3Q8dbvg
Message-ID: <CAMuHMdWmMzZ0gCNVAsBOGKDTO4kAF5TTcSo4V+m-_MGfsTo63Q@mail.gmail.com>
Subject: Re: [PATCH v3 1/4] can: rcar_canfd: Update bit rate constants for
 RZ/G3E and R-Car Gen4
To: Biju <biju.das.au@gmail.com>
Cc: Marc Kleine-Budde <mkl@pengutronix.de>, Vincent Mailhol <mailhol.vincent@wanadoo.fr>, 
	Magnus Damm <magnus.damm@gmail.com>, Biju Das <biju.das.jz@bp.renesas.com>, 
	linux-can@vger.kernel.org, linux-renesas-soc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, 
	Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>
Content-Type: text/plain; charset="UTF-8"

On Mon, 8 Sept 2025 at 14:09, Biju <biju.das.au@gmail.com> wrote:
> From: Biju Das <biju.das.jz@bp.renesas.com>
>
> The calculation formula for nominal bit rate of classical CAN is same as

the same

> that of nominal bit rate of CANFD on the RZ/G3E and R-Car Gen4 SoCs
> compared to other SoCs. Update nominal bit rate constants.
>
> Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
> ---
> v2->v3:
>  * Replaced "shared_bittiming"->"shared_can_regs" as it is same for RZ/G3E
>    and R-Car Gen4.
>  * Dropped the tags as it is new change.
>  * Updated commit header and description.

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

