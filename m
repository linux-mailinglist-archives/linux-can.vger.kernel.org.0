Return-Path: <linux-can+bounces-3275-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D5AA3A74A2D
	for <lists+linux-can@lfdr.de>; Fri, 28 Mar 2025 13:59:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8BEE73BC68C
	for <lists+linux-can@lfdr.de>; Fri, 28 Mar 2025 12:58:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BADB31EF1D;
	Fri, 28 Mar 2025 12:59:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="bzChFBKe"
X-Original-To: linux-can@vger.kernel.org
Received: from out.smtpout.orange.fr (out-70.smtpout.orange.fr [193.252.22.70])
	(using TLSv1.2 with cipher AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0D472D78A;
	Fri, 28 Mar 2025 12:59:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.252.22.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743166747; cv=none; b=dfHDadPH5N20Sae4f2S65PFnGIEWhT28b7eLgI5f+hpo1X+zCFTMS7z89PFxtHqFJO0IC07qxnCkcImfAG7YvkLH2plYNxtIIdYsHcWIfRLSErLwu3Z1KihdLAt7TVtrB5HKZxlmT7xxNYANHXM+8MoAoqJMnDDxtUKJ4AznbfI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743166747; c=relaxed/simple;
	bh=Cgfd211PcW68WHHc8LTwiKfdRrXBEskTnlck2ixBA98=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LZin79Q/F5GE4z4RxHmbcNVub5w7qOYNW3IIkgoXY6ef3FEaLBSkjUHuaL6gbuGU894YFBIYD6FslDuY41mk8ubsXgZP0f0ZebXf321mg8Oz1OmaaVCWyvxw/pUQvuUMggnD7X4Edf8Pa2847RGG9e3B3yA8SCWExZKbg+2o6oQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=wanadoo.fr; dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b=bzChFBKe; arc=none smtp.client-ip=193.252.22.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Received: from [172.16.82.72] ([124.33.176.97])
	by smtp.orange.fr with ESMTPA
	id y9INte9naVylty9IRtVoCX; Fri, 28 Mar 2025 13:58:54 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1743166734;
	bh=qOj0aFtgm3QCb4V6G8O4Vo7VdZRWB2Y/mUY+LJVXYmE=;
	h=Message-ID:Date:MIME-Version:Subject:To:From;
	b=bzChFBKekWOz2L8Kn8R1S/YDTMOLbkjPL1Q5QbiIuHDpBCwLWbBLrLeb7aZxeAB/6
	 Sp8gzzuAeIHwrCalVbOXcv/uMSOcykVznDgl14kwcTj3htGNVqXCD1S7hFAalwJ1KG
	 mWaMwBl25Y3fK3jECYJUL7su3qAuII+CGYElO3AumDfpBlN+QpEf6xRWRs6Zmtce+c
	 Ftgk0/88UvuNCFR4cLFgdEfRcMbslYWLMdHmvkRlKo60HLYFHkVyUjpvvUecrfqyUz
	 CZQAtOoCzoB5HguenRaY+FkuET4JrfTrQWrLf1orq2dMElkRsqM6O0nWVorfR4rTBs
	 kjO/GgvaK/jVw==
X-ME-Helo: [172.16.82.72]
X-ME-Auth: bWFpbGhvbC52aW5jZW50QHdhbmFkb28uZnI=
X-ME-Date: Fri, 28 Mar 2025 13:58:54 +0100
X-ME-IP: 124.33.176.97
Message-ID: <8a9cf211-bc79-42bc-bfad-555b39124c95@wanadoo.fr>
Date: Fri, 28 Mar 2025 21:58:46 +0900
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 10/18] can: rcar_canfd: Add max_cftml variable to
 struct rcar_canfd_hw_info
To: Biju Das <biju.das.jz@bp.renesas.com>
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>,
 Geert Uytterhoeven <geert+renesas@glider.be>,
 =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>,
 linux-can@vger.kernel.org,
 Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>,
 Biju Das <biju.das.au@gmail.com>, linux-renesas-soc@vger.kernel.org,
 Marc Kleine-Budde <mkl@pengutronix.de>
References: <20250326122003.122976-1-biju.das.jz@bp.renesas.com>
 <20250326122003.122976-11-biju.das.jz@bp.renesas.com>
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
In-Reply-To: <20250326122003.122976-11-biju.das.jz@bp.renesas.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 26/03/2025 à 21:19, Biju Das wrote:
> R-Car Gen3 has CFTML max positional value is 15 whereas on R-Car Gen4 it
> is 31. Add a max_cftml variable to struct rcar_canfd_hw_info to handle
> this difference.
> 
> Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
> Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>

Reviewed-by: Vincent Mailhol <mailhol.vincent@wanadoo.fr>

> ---
> v6->v7:
>  * Collected tag.
> v6:
>  * New patch.
> ---
>  drivers/net/can/rcar/rcar_canfd.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/net/can/rcar/rcar_canfd.c b/drivers/net/can/rcar/rcar_canfd.c
> index 7cef0673fbc8..c37fb85fe478 100644
> --- a/drivers/net/can/rcar/rcar_canfd.c
> +++ b/drivers/net/can/rcar/rcar_canfd.c
> @@ -227,7 +227,7 @@
>  
>  /* RSCFDnCFDCFCCk */
>  #define RCANFD_CFCC_CFTML(gpriv, x)	\
                                    ^
Notwithstanding of above review tag and same as before, please demystify
what this x is.

> -	(((x) & reg_gen4(gpriv, 0x1f, 0xf)) << reg_gen4(gpriv, 16, 20))
> +	(((x) & (gpriv)->info->max_cftml) << reg_gen4(gpriv, 16, 20))
>  #define RCANFD_CFCC_CFM(gpriv, x)	(((x) & 0x3) << reg_gen4(gpriv,  8, 16))
>  #define RCANFD_CFCC_CFIM		BIT(12)
>  #define RCANFD_CFCC_CFDC(gpriv, x)	(((x) & 0x7) << reg_gen4(gpriv, 21,  8))
> @@ -508,6 +508,7 @@ struct rcar_canfd_hw_info {
>  	u8 rnc_stride;
>  	u8 rnc_field_width;
>  	u8 max_aflpn;
> +	u8 max_cftml;
>  	u8 max_channels;
>  	u8 postdiv;
>  	/* hardware features */
> @@ -588,6 +589,7 @@ static const struct rcar_canfd_hw_info rcar_gen3_hw_info = {
>  	.rnc_stride = 4,
>  	.rnc_field_width = 8,
>  	.max_aflpn = 31,
> +	.max_cftml = 15,
>  	.max_channels = 2,
>  	.postdiv = 2,
>  	.shared_global_irqs = 1,
> @@ -598,6 +600,7 @@ static const struct rcar_canfd_hw_info rcar_gen4_hw_info = {
>  	.rnc_stride = 2,
>  	.rnc_field_width = 16,
>  	.max_aflpn = 127,
> +	.max_cftml = 31,
>  	.max_channels = 8,
>  	.postdiv = 2,
>  	.shared_global_irqs = 1,
> @@ -608,6 +611,7 @@ static const struct rcar_canfd_hw_info rzg2l_hw_info = {
>  	.rnc_stride = 4,
>  	.rnc_field_width = 8,
>  	.max_aflpn = 31,
> +	.max_cftml = 15,
>  	.max_channels = 2,
>  	.postdiv = 1,
>  	.multi_channel_irqs = 1,

Yours sincerely,
Vincent Mailhol


