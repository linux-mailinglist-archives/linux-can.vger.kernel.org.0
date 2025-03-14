Return-Path: <linux-can+bounces-3087-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 929A3A613F6
	for <lists+linux-can@lfdr.de>; Fri, 14 Mar 2025 15:47:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 86BAE3BD664
	for <lists+linux-can@lfdr.de>; Fri, 14 Mar 2025 14:46:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D87A21FF60C;
	Fri, 14 Mar 2025 14:46:46 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from mail-vk1-f169.google.com (mail-vk1-f169.google.com [209.85.221.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0F54201013;
	Fri, 14 Mar 2025 14:46:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741963606; cv=none; b=S5nFZ/Iv7pFkBB4yzLotoFn5NdtNv9tYwInTKH7j8jqBjyeQawaWulwB9yb9bBHo65w4gm6/jLV9L4cN2ysZMXe/RVl5MBhGB7zWLgPjr2OdJf1w6Cq+xrvTEwSxX8LySxfh/eQMnFZHcXdndUn/P1EUE6flhplHJ7xglVMKtzA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741963606; c=relaxed/simple;
	bh=ryyapRXG3T4JreSUEVpdRlD+8I0bpKqbRkERwp00IIE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TUYpRGT/cuuLTmiVKv24sfFzmaNMIQ6FFaVf4uqA+zvdMEHbLYdAIYYwIIQorJ1Oo7oSaLjQaT86eRIy7ygts/rH4XUbfSnDxRMZlTO1tVhQ5Mzr9PO0inc9G5XyA9brSR3X3I37YurpRwXT79Ia3aZuee/9Kg1esOfnMyTZZio=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f169.google.com with SMTP id 71dfb90a1353d-523eb86b31aso946925e0c.0;
        Fri, 14 Mar 2025 07:46:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741963603; x=1742568403;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pD9AyI5d7ifqXrI6dLNxxG8JUofr2Dcf6QGi9HmCYVU=;
        b=SswIAW8/odCfF55iyQEFGEJR5CE4DI3+ZfGvmxrvSTdGQgOeAKJU4syH0iF04VPf59
         19qnHP+QafIoDVpKSTsXRrBY9s6GEl76rPgw+TXQVnJEChaVc7daQQaLADhedPqjpCcw
         /8vmyL4ABIBgLJuJI3VgxTU1ixt/2LuT04x2sbEelBBFkbe4ST4YtyEjeVB2F4jHP/Ez
         f4Rgyq/m5G8+CEyffeoCk9skazWMcsQbi4zQoS2SCnDGk+xBQb/IkEMlrk1Ewah+ic9H
         8EYyN+fscs8DckQw3v8UO1ygW8qEGn8Sy3urEV5xGfyB50cVNyEg8dnmDbwa9MPZ6SVQ
         TOGw==
X-Forwarded-Encrypted: i=1; AJvYcCX7m71TsEiBD1QqInOVljxwcilAJD4CwKZqkKNLjI+XqoCDfOgLIdF2/+crfiZyDPVuWacEXsvSEzYFCZYZu4qM/gU=@vger.kernel.org, AJvYcCXm9skrDQyo695YS94i52A9QvXE3b7Pd9e83XIzDAMa6xRyxV05mrP6SaC3tHvWB4B7/vTlVRA/zn8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzULGk8CvZPeAxsra61Rh4Z7C7z/Q31d/zdKW6JE5KM1ayaqQ/W
	V9Y+Z32DmDUrQEa3jR0fmVI2AyCTOGIp9uB0+kF8nZE7XNDWV04/R/L2txKd2Q0=
X-Gm-Gg: ASbGncuDxPHD8WMHpJ89EkV3B1trZFDCx7+lnZ1S3jofcn8Qaq28C7o9XqGXbyJSi5B
	c5HYIFxulouVcVsMIXnoNk2fKgubkbX7HJEKOvGsLxMi+VISHG2j3GOyKB9E9x5Knu4k3QndF6A
	jv7s0orfL3Fs6CYiALNa76O58gtnw3T1pRGMmlGwyhdFwULdhsz8S//GB53CSkN1F+dWgWqLLEs
	T2uS4HxWjotZ7ka5FIQeDkn7RnnggMolMKzJd+6JXfyXkajnU7rkI5P9CWf7q2UrpyvHsx8PsaL
	DmHRF4kpKHEx9IlVwOV1Ijp+gW+ei6G1i2DFXAPjfnOUcoEteK599wWAZH2ISZUxuDYRXoPjlLs
	RmCxpIso=
X-Google-Smtp-Source: AGHT+IE+TWZPHZC5POB62DjoP1zvM8hVz+X/xuVUgLjdthwlj+VTmWnyh1slbJO9d6yHqLcaVbSAcQ==
X-Received: by 2002:a05:6122:169d:b0:520:5a87:6717 with SMTP id 71dfb90a1353d-5244948f300mr1650811e0c.0.1741963603422;
        Fri, 14 Mar 2025 07:46:43 -0700 (PDT)
Received: from mail-ua1-f42.google.com (mail-ua1-f42.google.com. [209.85.222.42])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5243a5a1f2fsm594332e0c.14.2025.03.14.07.46.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 14 Mar 2025 07:46:43 -0700 (PDT)
Received: by mail-ua1-f42.google.com with SMTP id a1e0cc1a2514c-86b9ea43955so912283241.2;
        Fri, 14 Mar 2025 07:46:43 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVCwA7/HGpu1vu2x4bBRG7CVCBz/1d99lN6bJ6mvkWGlzCOQHTLHaLxATO41j3FqVQwL6eOxLehsA/DUr89DBPU9Uo=@vger.kernel.org, AJvYcCWJyBRdeEFKV/r0ZwUYl6Db1TSK2AWFXOrYE51PyoE4TRjCVinWXJJxUbhHyHPZjPiqYzb2bK9/Rs8=@vger.kernel.org
X-Received: by 2002:a05:6102:41aa:b0:4c1:b3a5:9f4 with SMTP id
 ada2fe7eead31-4c383142457mr1806540137.10.1741963602919; Fri, 14 Mar 2025
 07:46:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250306124256.93033-1-biju.das.jz@bp.renesas.com> <20250306124256.93033-6-biju.das.jz@bp.renesas.com>
In-Reply-To: <20250306124256.93033-6-biju.das.jz@bp.renesas.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Fri, 14 Mar 2025 15:46:30 +0100
X-Gmail-Original-Message-ID: <CAMuHMdWM5Ns8LbqRMRnHgrOdtdO2Hi0OmsCGE0Tu69OALT+8kA@mail.gmail.com>
X-Gm-Features: AQ5f1JqU3B-LMtnsVlDWkc4I5deQeztmcgiLR9rOqNSdFFqSOaiCfnDj5IS7buI
Message-ID: <CAMuHMdWM5Ns8LbqRMRnHgrOdtdO2Hi0OmsCGE0Tu69OALT+8kA@mail.gmail.com>
Subject: Re: [PATCH v4 05/11] can: rcar_canfd: Add shared_can_regs variable to
 struct rcar_canfd_hw_info
To: Biju Das <biju.das.jz@bp.renesas.com>
Cc: Marc Kleine-Budde <mkl@pengutronix.de>, Vincent Mailhol <mailhol.vincent@wanadoo.fr>, 
	Wolfram Sang <wsa+renesas@sang-engineering.com>, 
	=?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <u.kleine-koenig@baylibre.com>, 
	linux-can@vger.kernel.org, 
	Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>, Biju Das <biju.das.au@gmail.com>, 
	linux-renesas-soc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Biju,

On Thu, 6 Mar 2025 at 13:43, Biju Das <biju.das.jz@bp.renesas.com> wrote:
> R-Car Gen4 has shared regs for both CAN-FD and Classical CAN operations.
> Add shared_can_regs variable to struct rcar_canfd_hw_info to handle this
> difference.
>
> Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>

Thanks for your patch!

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

One nit below.

> --- a/drivers/net/can/rcar/rcar_canfd.c
> +++ b/drivers/net/can/rcar/rcar_canfd.c
> @@ -517,6 +517,7 @@ struct rcar_canfd_hw_info {
>         unsigned shared_global_irqs:1;  /* Has shared global irqs */
>         unsigned multi_channel_irqs:1;  /* Has multiple channel irqs */
>         unsigned ch_interface_mode:1;   /* Has channel interface mode */
> +       unsigned shared_can_reg:1;      /* Has shared classical can registers */

shared_can_regs?

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

