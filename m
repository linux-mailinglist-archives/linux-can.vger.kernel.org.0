Return-Path: <linux-can+bounces-3282-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DB482A74DAD
	for <lists+linux-can@lfdr.de>; Fri, 28 Mar 2025 16:27:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EEDFE189CE2B
	for <lists+linux-can@lfdr.de>; Fri, 28 Mar 2025 15:27:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A5C31CF5E2;
	Fri, 28 Mar 2025 15:27:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="lT0K9ekg"
X-Original-To: linux-can@vger.kernel.org
Received: from out.smtpout.orange.fr (out-66.smtpout.orange.fr [193.252.22.66])
	(using TLSv1.2 with cipher AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 785D923CB;
	Fri, 28 Mar 2025 15:27:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.252.22.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743175625; cv=none; b=t7LHTJKbDmS4xhGELCGr1Sjqw1ChQAgWH0BrsPOW+DnhMrIwqzb2tQdPZneGy9GtDoi4ffID81tCi/w0YtKQRp/pggoUyFBfXJQyFm3YQ6Ob/mdks6s8dx5lycjHTjUsDnV78V6qIXFeZJgfGElIlXEoMsMOj83u4lPlqYBtwKw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743175625; c=relaxed/simple;
	bh=s2YKd94dc6CdWKeMw1bgbi7tpdxS9/vZQ5+PMWQtnBY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qbXqCLfHDyCB5d4HifEmmD63wxJa0FK1tWY+2mYFyWdYCiMpCHuO/9gLlYZl/9UoFwUBcXAqUhcsOlfRPCqaqB2gKtjakfHlK+ttwd6CzgphBhAJVwowSSAljAk1uTwksL2vauWKqisfkAVNBmFqeIfxLpf9IoJY4JqfvmcNwZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=wanadoo.fr; dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b=lT0K9ekg; arc=none smtp.client-ip=193.252.22.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Received: from [172.16.82.72] ([124.33.176.97])
	by smtp.orange.fr with ESMTPA
	id yBbet8GCMkHP7yBbitqEwG; Fri, 28 Mar 2025 16:26:58 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1743175618;
	bh=dgKEXzqmwPYHLcOi42A1sw3Fe2y2pyHqzBPHfLSSLY0=;
	h=Message-ID:Date:MIME-Version:Subject:To:From;
	b=lT0K9ekgInROFrazQiMRFHQzoXwNwBvS3ogIhmhvj28+Ug6c+6iFAx74QrAHCeZKz
	 X8GQYsEpOeBxzqZImR5mnogneRF77NfTlW/ArTS6ok6f07F7Crl9gAFyDAVFtppIG2
	 04YKdxbgPWPtDVBYXzA9lty1nmDSt1sNivyLvSdUyvSypM0xVjJ/OjYFahr+ulEuzM
	 ADkLJyTGIVMhee3/fvM+lwBt3GCXFpemDAxF7qLQDSZJfkenQ0zux6H+fcOnnHcjGS
	 TpzV50f/6UdbFw/d1skM+0Oh8wdjGiE6htuQtbn2TMPJBirAQRKpUEr7zlYpdIX8Sp
	 M+F58tBWClRRQ==
X-ME-Helo: [172.16.82.72]
X-ME-Auth: bWFpbGhvbC52aW5jZW50QHdhbmFkb28uZnI=
X-ME-Date: Fri, 28 Mar 2025 16:26:58 +0100
X-ME-IP: 124.33.176.97
Message-ID: <1d9719e3-10ff-4cd8-b729-55fea93c37ce@wanadoo.fr>
Date: Sat, 29 Mar 2025 00:26:49 +0900
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 16/18] can: rcar_canfd: Add only_internal_clks variable
 to struct rcar_canfd_hw_info
To: Biju Das <biju.das.jz@bp.renesas.com>
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>,
 Geert Uytterhoeven <geert+renesas@glider.be>,
 =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>,
 linux-can@vger.kernel.org,
 Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>,
 Biju Das <biju.das.au@gmail.com>, linux-renesas-soc@vger.kernel.org,
 Marc Kleine-Budde <mkl@pengutronix.de>
References: <20250326122003.122976-1-biju.das.jz@bp.renesas.com>
 <20250326122003.122976-17-biju.das.jz@bp.renesas.com>
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
In-Reply-To: <20250326122003.122976-17-biju.das.jz@bp.renesas.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 26/03/2025 at 21:19, Biju Das wrote:
> All existing SoCs support an external clock, but RZ/G3E has only internal
> clocks. Add only_internal_clks to struct rcar_canfd_hw_info to handle this
> difference.
> 
> Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
> Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>

A few nits but:

Reviewed-by: Vincent Mailhol <mailhol.vincent@wanadoo.fr>

> ---
> v6->v7:
>  * No change.
> v5->v6:
>  * No change.
> v4->v5:
>  * Collected tag.
>  * Improved commit description by "All SoCs supports extenal clock"->
>    "All existing SoCs support an external clock".
> v3->v4:
>  * No change.
> v2->v3:
>  * No change
> v1->v2:
>  * No change.
> ---
>  drivers/net/can/rcar/rcar_canfd.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/net/can/rcar/rcar_canfd.c b/drivers/net/can/rcar/rcar_canfd.c
> index 20e591421cc6..7ad27087a176 100644
> --- a/drivers/net/can/rcar/rcar_canfd.c
> +++ b/drivers/net/can/rcar/rcar_canfd.c
> @@ -546,6 +546,7 @@ struct rcar_canfd_hw_info {
>  	unsigned multi_channel_irqs:1;	/* Has multiple channel irqs */
>  	unsigned ch_interface_mode:1;	/* Has channel interface mode */
>  	unsigned shared_can_regs:1;	/* Has shared classical can registers */
> +	unsigned only_internal_clks:1;	/* Has only internal clocks */
>  };

By default the fields will be set to false if omitted. I think it is a
bit more readable if you still set them explicitly to zero.

>  /* Channel priv data */
> @@ -2045,7 +2046,7 @@ static int rcar_canfd_probe(struct platform_device *pdev)
>  		fcan_freq = clk_get_rate(gpriv->can_clk) / info->postdiv;
>  	} else {
>  		fcan_freq = clk_get_rate(gpriv->can_clk);
> -		gpriv->extclk = true;
> +		gpriv->extclk = !gpriv->info->only_internal_clks;

Nitpick: if at the end, what matters in the extclk boolean, you may
directly name your field:

  rcar_canfd_hw_info->has_external_clks

and no need for the negation above.

>  	}
>  
>  	addr = devm_platform_ioremap_resource(pdev, 0);

Yours sincerely,
Vincent Mailhol


