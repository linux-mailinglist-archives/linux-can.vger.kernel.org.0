Return-Path: <linux-can+bounces-1866-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AA13F9BB12A
	for <lists+linux-can@lfdr.de>; Mon,  4 Nov 2024 11:33:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 61D001F219C0
	for <lists+linux-can@lfdr.de>; Mon,  4 Nov 2024 10:33:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAB971B0F2F;
	Mon,  4 Nov 2024 10:32:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="qTZnGbOw"
X-Original-To: linux-can@vger.kernel.org
Received: from smtp.smtpout.orange.fr (smtp-22.smtpout.orange.fr [80.12.242.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBDEF1AA78E;
	Mon,  4 Nov 2024 10:32:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.12.242.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730716378; cv=none; b=BVP0bNESxcasVO/yd1E4RWRzIAJqm6PAS+byKR+Belvts84v3Nq1UynXb6m3SxOb12WQWySMuWU5cOeHr51yLQtHX3a5wRP2ZiK+punpDvOL5djP5qOUDgAFMj9cOwKnqGW2+CS8f9Df8pvbRUB+qpIklyoYoAnExffvlaQ90lo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730716378; c=relaxed/simple;
	bh=DhTHzSF/MbKhjvfAVcyTh+RGny34PcR6mXMa7beXc68=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IUYhy0L+EVvvMRPrpqcM3UPksVNMFXgiCqzHKsFYDDDkaIuN4a00/6rtuFAHqYS1rq20tMyCGiTvM8+WHixherpuH35n6GH82wBZzc/ELtrYOsA1NgEGs5sfkopffms+9RjdWxbIn4c9bVgdO+hdWvmighfiMiy2ugkxDaeQLWE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=wanadoo.fr; dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b=qTZnGbOw; arc=none smtp.client-ip=80.12.242.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Received: from mail-ed1-f48.google.com ([209.85.208.48])
	by smtp.orange.fr with ESMTPSA
	id 7uN3tjWIFb5FK7uN3tLy8n; Mon, 04 Nov 2024 11:31:41 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1730716301;
	bh=TIrJOeAjkIO/iW9l0zknXoZmCAhFNmyJRbtzue7NlX4=;
	h=MIME-Version:From:Date:Message-ID:Subject:To;
	b=qTZnGbOw/OTxDrAI9hUijYhxY0x40R4BI2yyA/ue3oSP1QO+fwSqCoFZCLbIh10t9
	 A3Jx7a8zpALRupLpLzD55RpWz/KOT2vT1bZ9YXGCI/63J3KPUFscQbItxv1Fb/mAYS
	 fdCOEd/Uhtbp759+4pUi3eypUr+Xt4xvhxTaH+ceOaZL8eZlaHxTHiTfVrszkh/moj
	 PxqPzG4kg7m+dvfhQOvvB3Mv/Ys9OJbZeqMwT81jC0VfN8kJikD7cxLpimXGtYxuik
	 C473arwzRflcfdslfvbn6VRe0PQ/MBJhJBiIvpGobC6xlz0iYOUQlBgKeKEAsYq1QA
	 9RhIkuucXNsTg==
X-ME-Helo: mail-ed1-f48.google.com
X-ME-Auth: bWFpbGhvbC52aW5jZW50QHdhbmFkb28uZnI=
X-ME-Date: Mon, 04 Nov 2024 11:31:41 +0100
X-ME-IP: 209.85.208.48
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-5ceb75f9631so3793962a12.0;
        Mon, 04 Nov 2024 02:31:41 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUbEsFO99xFY+91QrYyOTzpzjt7W4mkI9a/nSeif9rQ03H5fPt0J8N8wX+XnPJm2edrf/XwN6ph@vger.kernel.org, AJvYcCVV2EUu3A6XKbaAP9fMa1Du5okzH4PLEWeSg1YRs4zqSUN29ta9DXNuQrJbGx4LwqpSIvW8ruToqbY=@vger.kernel.org, AJvYcCVaMkAPCMMDAIL6k8qCMumgHDuuEcda52iBEpS+Unxe3HjzDDyExl7mA8XpAkb+TRtA2/Vgx8zI4UOjzhCJ@vger.kernel.org
X-Gm-Message-State: AOJu0YwEwWELGd4lKG7XP7fSftAW9gZZkmgDzg+cM0EyMIoernMcLy5P
	l1NulDiE4nbbIpTXOG+SUVaNhUztQygKg+1mNXc/XqsUWUvePwvoOJ4t/B5QzhT9PfqJuZ9cV1F
	paSSYqBPxGB9lpedtSx4fRcQ2dlA=
X-Google-Smtp-Source: AGHT+IGEATDreGB0HcaKxrgoZM4H0tce9OAs8bwHUi9hhwDpruLW1LMZaF+TVEuhzUDye4DdaEiYmVCpfwh0M+IdRb0=
X-Received: by 2002:a17:907:cca3:b0:a9e:4b88:e03b with SMTP id
 a640c23a62f3a-a9e4b88e2famr1214120366b.0.1730716301029; Mon, 04 Nov 2024
 02:31:41 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241104084705.5005-1-lucas.liu@siengine.com>
In-Reply-To: <20241104084705.5005-1-lucas.liu@siengine.com>
From: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Date: Mon, 4 Nov 2024 19:31:30 +0900
X-Gmail-Original-Message-ID: <CAMZ6RqJ-O6PcwUrA9azJHq8vJ4_2GEFcqU-8_epHyAoBmeeEuA@mail.gmail.com>
Message-ID: <CAMZ6RqJ-O6PcwUrA9azJHq8vJ4_2GEFcqU-8_epHyAoBmeeEuA@mail.gmail.com>
Subject: Re: [PATCH] can: flexcan: simplify the calculation of priv->mb_count
To: "baozhu.liu" <lucas.liu@siengine.com>
Cc: mkl@pengutronix.de, wg@grandegger.com, davem@davemloft.net, 
	edumazet@google.com, kuba@kernel.org, linux-can@vger.kernel.org, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Liu,

On Mon. 4 Nov. 2024 at 18:05, baozhu.liu <lucas.liu@siengine.com> wrote:
> Since mb is a fixed-size two-dimensional array (u8 mb[2][512]),
> "priv->mb_count = sizeof(priv->regs->mb)/priv->mb_size;",
> this expression calculates mb_count correctly and is more concise.

When using integers,

  (a1 / q) + (a2 / q)

is not necessarily equal to

  (a1 + a2) / q.


If the decimal place of

  sizeof(priv->regs->mb[0]) / priv->mb_size

were to be greater than or equal to 0.5, the result would have changed
because of the rounding.

This is illustrated in https://godbolt.org/z/bfnhKcKPo.

Here, luckily enough, the two valid results are, for CAN CC:

  sizeof(priv->regs->mb[0]) / priv->mb_size = 512 / 16
                                            = 64

and for CAN FD:

  sizeof(priv->regs->mb[0]) / priv->mb_size = 512 / 72
                                            = 14.22

and both of these have no rounding issues.

I am not sure if we should take this patch. It is correct at the end
because you "won a coin flip", but the current code is doing the
correct logical calculation which would always yield the correct
result regardless of the rounding.

> Signed-off-by: baozhu.liu <lucas.liu@siengine.com>
> ---
>  drivers/net/can/flexcan/flexcan-core.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/drivers/net/can/flexcan/flexcan-core.c b/drivers/net/can/flexcan/flexcan-core.c
> index 6d638c939..e3a8bad21 100644
> --- a/drivers/net/can/flexcan/flexcan-core.c
> +++ b/drivers/net/can/flexcan/flexcan-core.c
> @@ -1371,8 +1371,7 @@ static int flexcan_rx_offload_setup(struct net_device *dev)
>         if (priv->devtype_data.quirks & FLEXCAN_QUIRK_NR_MB_16)
>                 priv->mb_count = 16;
>         else
> -               priv->mb_count = (sizeof(priv->regs->mb[0]) / priv->mb_size) +
> -                                (sizeof(priv->regs->mb[1]) / priv->mb_size);
> +               priv->mb_count = sizeof(priv->regs->mb) / priv->mb_size;
>
>         if (priv->devtype_data.quirks & FLEXCAN_QUIRK_USE_RX_MAILBOX)
>                 priv->tx_mb_reserved =

Yours sincerely,
Vincent Mailhol

