Return-Path: <linux-can+bounces-3412-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E82A2A9057B
	for <lists+linux-can@lfdr.de>; Wed, 16 Apr 2025 16:08:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 24542189EC48
	for <lists+linux-can@lfdr.de>; Wed, 16 Apr 2025 14:04:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F5C813D51E;
	Wed, 16 Apr 2025 13:53:38 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from mail-vk1-f174.google.com (mail-vk1-f174.google.com [209.85.221.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B23233010C;
	Wed, 16 Apr 2025 13:53:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744811618; cv=none; b=EZsHYYxZyfURsP/2pvEth8SoZuAAG/lL7xLnyi+iLrTY+nTfZhdguL+gnuFWy5372ai4QljcGNE0GhDiuStag8mzL2+KMPeJclzt70xqCpOSkNNQMDznmSZJ1jWv0gLrqEBojFPKVjHQvhplzr8PeTC7tqK2hkV7G8NpPPVc+E8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744811618; c=relaxed/simple;
	bh=+sbwbRs2Sk/P+srAacWiDoCeFJF3cSplPX3gc+5K6F4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cxFXlJiKLZNSeBdBeILRY5gmtr/nhEWNaXpzjI73/WHdndqe3/zuRcMjF5FG0nnwWAYPXcj1bf1vVOUZOpd+ZoW7UYmZsW+p5FGA5pbckA5OrI5eREoGyxpXXSQi2oUN0f5BHkB1r3j6qMBl+hbbJusAspwaP4YdepA5UPNElEw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f174.google.com with SMTP id 71dfb90a1353d-523f670ca99so2763871e0c.1;
        Wed, 16 Apr 2025 06:53:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744811615; x=1745416415;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=91cHEun/p+z3rkjKiiDOduNGyPZxgvM+wY8yERW5FGs=;
        b=Vkn6ZDkGTr3TOZy+0f9oo5+f7IGaw1NRQoQZv1ua+I2In3L1lMFQZoS4fKDPkJx4Y6
         iJnpmWkifjhGRSj/rAv7b6bnweg8gNV3knea9FZrUWwmp/7uGKe19Lzj7v1jkPKl1zRC
         xelyaAyr64iiuIWjvdPG3IxVxfTmE7Nn+Oj5f+uiPBYqW71c8x5Xyb637AXYIPoXpkV4
         AqokuU6mnL9vFVr+dEUZUj9IwYvyAu2i4dUmyzSTda3+IKPIia06W2oDdEUg9tj/oDUD
         91+LoWBmWHkVgqRTBHZyKgbiP73W8ZQQ/brmqR54KCHt/mdCC6ifIovXXhl0OZlVtNOj
         fOFA==
X-Forwarded-Encrypted: i=1; AJvYcCVk7CmApFNiNQeGh44m5dlOoHFUHx6deQqQMYHhFOBiJRpaNG4AYdTq1DfLwtai+UutWki48L8/YlU=@vger.kernel.org, AJvYcCW7nR/59ivPI2Am7Dq74ApOFWIzTINqZZbWT+2jh3FqBLyJjzb4NYsdFWGnGrtaoa1+dYl1QnDcilwBwiPJxln057M=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy+Q5acJx2yP/50KEKEG8oZUvQqbH2wElCMz0WwmCLZthPNR6I1
	0kPXqv3tQmexyhFB2TpUnsUpQ/HSCcc0LK83WMa6f0WAG0uevxBeyFbmPUIv
X-Gm-Gg: ASbGncua0U3ZYalq7MXqpUx1iOd2ZtXxIJX0pA/YPxltz+cinsXw9mrlQayr1TwlfuI
	+wkWXdGvHZJ0QDl/5EQYeSE4/TXHotRCfF1g9YUkRi2IJ3Hu4lFSLMt4q3MscGTXtqNr8Mc2p5r
	7+cZUJT5xQ1a9hq1B3J51x1WA84dXlYFyo2A4GwVuCOK8QR04OyzmH+WaJemNf4iAgHKDyv2vTk
	nosVeHhZv9mu707h9ln/UXolSumtWdDeG5Re7zmgo4nlObDnXanv5iaSff3m52Cu0/FQBjlbc98
	rb/KursxZYmsZXgIqh7DcRza2G5DJpuHrGbXKuBggEuLq0+LK6V8Uq52eG1b9TDYPW5wzoEU7V7
	f4uFhhdU=
X-Google-Smtp-Source: AGHT+IGecOQco9+CbthL/HDgTBpYpKeNDmSXU91sakbIL/V1tRiC3vujpya6/JMXQGZMgCUNNcn8Ew==
X-Received: by 2002:a05:6122:659e:b0:526:1d98:df80 with SMTP id 71dfb90a1353d-5290da9c73amr1151901e0c.0.1744811615028;
        Wed, 16 Apr 2025 06:53:35 -0700 (PDT)
Received: from mail-vk1-f182.google.com (mail-vk1-f182.google.com. [209.85.221.182])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-527abd9b999sm3111703e0c.26.2025.04.16.06.53.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Apr 2025 06:53:34 -0700 (PDT)
Received: by mail-vk1-f182.google.com with SMTP id 71dfb90a1353d-51eb18130f9so3356537e0c.3;
        Wed, 16 Apr 2025 06:53:34 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCU7EHGXgHOFHt31WLAIXYNOmWTax+j12PI7v8ZH55Lz/RhxqAZRvYGSRb88bKwue5k4z9TZOBeSLxk=@vger.kernel.org, AJvYcCVIBYWvmyFuudm9tmjAMyhhN8v0QHhLn9mTV7sIIn+m0qyirWyVI/3mckGI8lRl5oVqs03tPQya2Ij0qM0x5dkR9B0=@vger.kernel.org
X-Received: by 2002:a05:6122:220a:b0:520:42d3:91c1 with SMTP id
 71dfb90a1353d-5290e1edb64mr961857e0c.10.1744811614545; Wed, 16 Apr 2025
 06:53:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250402102226.28032-1-biju.das.jz@bp.renesas.com> <20250402102226.28032-16-biju.das.jz@bp.renesas.com>
In-Reply-To: <20250402102226.28032-16-biju.das.jz@bp.renesas.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 16 Apr 2025 15:53:22 +0200
X-Gmail-Original-Message-ID: <CAMuHMdU=mssA0pW_CX6V5BzhfQ9RA_OXmBTJ6TfA0uJntTFXOg@mail.gmail.com>
X-Gm-Features: ATxdqUF6bqCcroPDrusQsZXxB-IiJorgDpOIWSc6J3SsF8kD_r0Icw-xE8FwsVI
Message-ID: <CAMuHMdU=mssA0pW_CX6V5BzhfQ9RA_OXmBTJ6TfA0uJntTFXOg@mail.gmail.com>
Subject: Re: [PATCH v8 15/19] can: rcar_canfd: Add struct rcanfd_regs variable
 to struct rcar_canfd_hw_info
To: Biju Das <biju.das.jz@bp.renesas.com>
Cc: Marc Kleine-Budde <mkl@pengutronix.de>, Vincent Mailhol <mailhol.vincent@wanadoo.fr>, 
	Wolfram Sang <wsa+renesas@sang-engineering.com>, 
	=?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <u.kleine-koenig@baylibre.com>, 
	linux-can@vger.kernel.org, 
	Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>, Biju Das <biju.das.au@gmail.com>, 
	linux-renesas-soc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Wed, 2 Apr 2025 at 12:23, Biju Das <biju.das.jz@bp.renesas.com> wrote:
> R-Car Gen3 and Gen4 have some differences in the register offsets. Add a
> struct rcanfd_regs variable regs to struct rcar_canfd_hw_info handle these
> differences.
>
> Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
> ---
> v7->v8:
>  * Started using struct rcanfd_regs instead of LUT.
>  * Updated commit description.
>  * Dropped tag

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

