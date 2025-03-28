Return-Path: <linux-can+bounces-3283-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 04F80A74DB0
	for <lists+linux-can@lfdr.de>; Fri, 28 Mar 2025 16:27:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 92C9917726E
	for <lists+linux-can@lfdr.de>; Fri, 28 Mar 2025 15:27:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42A1823CB;
	Fri, 28 Mar 2025 15:27:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="oO8yOD1N"
X-Original-To: linux-can@vger.kernel.org
Received: from out.smtpout.orange.fr (out-69.smtpout.orange.fr [193.252.22.69])
	(using TLSv1.2 with cipher AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F11A1D63E3;
	Fri, 28 Mar 2025 15:27:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.252.22.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743175651; cv=none; b=GYgWVL+ooOta+wHrQ2uLiOWbfFc8WMCeSFkjl8Ypm1d/BAp1U31nSLZgBJ0V/etW+0Ez7CLD9GVk5AgZR2pqQ0x4authsXumMzLJgHJbhecm2V/AHlXFDNnMcCLaRi16T773uh0bjHWjzGBM1a6Ypp5rU/qqm/k6+PSEEhY5C50=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743175651; c=relaxed/simple;
	bh=seNQAXYu46BGiD9PNQgOf5zKjKlNXX3ldlQGb4/TwOY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XfqCbgQeW1pEoX/0zkMdTbFSp2wYljnwTqA3xp9OxmAQI5EyVoFJqJiTuzZ+S/bEvXniG0aZhywLMOlnlMfTj5H77hJgPK+37fpNGqXDrhuaTrZ5d8+SPLJIe6e5IuQaBkOvbGDy7aza/QLgthldGF1WdejL1Kmdtn5r1oVAueo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=wanadoo.fr; dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b=oO8yOD1N; arc=none smtp.client-ip=193.252.22.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Received: from [172.16.82.72] ([124.33.176.97])
	by smtp.orange.fr with ESMTPA
	id yBc8tfTPaVyltyBcBteYpL; Fri, 28 Mar 2025 16:27:27 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1743175647;
	bh=AVg2uZDHQ7w0dLhGR1t9x47BHfEKZTYIgHOeAeK7/Ss=;
	h=Message-ID:Date:MIME-Version:Subject:To:From;
	b=oO8yOD1NFY2Wi2OyAv/YalRdXOkgvWzPGASIsEU99gME4r3NRAu6i75RHtTlUxX81
	 ORt9gtbC131vdBNuEicwQP4Ye8etX3FOh8yzCpQiVnT5sEW+9ERHtgwJgPgvgrEH9Y
	 nFR6FZRLXQtFm6zB0r6qJgTWd5wrcYye42qlKCVDgGLuakNayPL0Kjon+oFxSqFqQL
	 z/BTc8sZs2ggoKrSp2PC00IOUl+lCrisUPo8FAqTUwP26ad7LUu6vqXX6e8ugnRT1A
	 qMg3dX3C14q7f/YT+f/dXXvf8Jh1+nHI1iBkhBsi+JCOx52DT01EJ7Tcd6kExaWey3
	 tnuxXR3xtiAGA==
X-ME-Helo: [172.16.82.72]
X-ME-Auth: bWFpbGhvbC52aW5jZW50QHdhbmFkb28uZnI=
X-ME-Date: Fri, 28 Mar 2025 16:27:27 +0100
X-ME-IP: 124.33.176.97
Message-ID: <987d16e5-2fc0-40f0-a168-5c59165752b0@wanadoo.fr>
Date: Sat, 29 Mar 2025 00:27:19 +0900
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 17/18] can: rcar_canfd: Enhance multi_channel_irqs
 handling
To: Biju Das <biju.das.jz@bp.renesas.com>
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>,
 Geert Uytterhoeven <geert+renesas@glider.be>,
 =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>,
 linux-can@vger.kernel.org,
 Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>,
 Biju Das <biju.das.au@gmail.com>, linux-renesas-soc@vger.kernel.org,
 Marc Kleine-Budde <mkl@pengutronix.de>
References: <20250326122003.122976-1-biju.das.jz@bp.renesas.com>
 <20250326122003.122976-18-biju.das.jz@bp.renesas.com>
Content-Language: en-US
From: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Autocrypt: addr=mailhol.vincent@wanadoo.fr; keydata=
 xjMEZluomRYJKwYBBAHaRw8BAQdAf+/PnQvy9LCWNSJLbhc+AOUsR2cNVonvxhDk/KcW7FvN
 LFZpbmNlbnQgTWFpbGhvbCA8bWFpbGhvbC52aW5jZW50QHdhbmFkb28uZnI+wrIEExYKAFoC
 GwMFCQp/CJcFCwkIBwICIgIGFQoJCAsCBBYCAwECHgcCF4AWIQTtj3AFdOZ/IOV06OKrX+uI
 bbuZwgUCZx41XhgYaGtwczovL2tleXMub3BlbnBncC5vcmcACgkQq1/riG27mcIYiwEAkgKK
 BJ+ANKwhTAAvL1XeApQ+2NNNEwFWzipVAGvTRigA+wUeyB3UQwZrwb7jsQuBXxhk3lL45HF5
 8+y4bQCUCqYGzjgEZx4y8xIKKwYBBAGXVQEFAQEHQJrbYZzu0JG5w8gxE6EtQe6LmxKMqP6E
 yR33sA+BR9pLAwEIB8J+BBgWCgAmFiEE7Y9wBXTmfyDldOjiq1/riG27mcIFAmceMvMCGwwF
 CQPCZwAACgkQq1/riG27mcJU7QEA+LmpFhfQ1aij/L8VzsZwr/S44HCzcz5+jkxnVVQ5LZ4B
 ANOCpYEY+CYrld5XZvM8h2EntNnzxHHuhjfDOQ3MAkEK
In-Reply-To: <20250326122003.122976-18-biju.das.jz@bp.renesas.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 26/03/2025 at 21:19, Biju Das wrote:
> Currently multi_channel_irqs has only 2 channels. But RZ/G3E has six
> channels. Enhance multi_channel_irqs handling to support more than two
> channels.
> 
> Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
> Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>

With below nitpicks addressed:

Reviewed-by: Vincent Mailhol <mailhol.vincent@wanadoo.fr>

> ---
> v6->v7:
>  * No change.
> v5->v6:
>  * No change.
> v4->v5:
>  * Collected tag.
> v3->v4:
>  * No change.
> v2->v3:
>  * No change.
> v1->v2:
>  * No change.
> ---
>  drivers/net/can/rcar/rcar_canfd.c | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/net/can/rcar/rcar_canfd.c b/drivers/net/can/rcar/rcar_canfd.c
> index 7ad27087a176..91f5649078c6 100644
> --- a/drivers/net/can/rcar/rcar_canfd.c
> +++ b/drivers/net/can/rcar/rcar_canfd.c
> @@ -1851,16 +1851,19 @@ static int rcar_canfd_channel_probe(struct rcar_canfd_global *gpriv, u32 ch,
>  
>  	if (info->multi_channel_irqs) {
>  		char *irq_name;
> +		char name[10];
>  		int err_irq;
>  		int tx_irq;
>  
> -		err_irq = platform_get_irq_byname(pdev, ch == 0 ? "ch0_err" : "ch1_err");
> +		scnprintf(name, 10, "ch%u_err", ch);

		scnprintf(name, sizeof(name), "ch%u_err", ch);

> +		err_irq = platform_get_irq_byname(pdev, name);
>  		if (err_irq < 0) {
>  			err = err_irq;
>  			goto fail;
>  		}
>  
> -		tx_irq = platform_get_irq_byname(pdev, ch == 0 ? "ch0_trx" : "ch1_trx");
> +		scnprintf(name, 10, "ch%u_trx", ch);

		scnprintf(name, sizeof(name), "ch%u_trx", ch);

> +		tx_irq = platform_get_irq_byname(pdev, name);
>  		if (tx_irq < 0) {
>  			err = tx_irq;
>  			goto fail;

Yours sincerely,
Vincent Mailhol


