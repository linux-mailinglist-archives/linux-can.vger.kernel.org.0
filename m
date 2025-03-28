Return-Path: <linux-can+bounces-3260-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 95643A7486A
	for <lists+linux-can@lfdr.de>; Fri, 28 Mar 2025 11:37:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3BC2A17893A
	for <lists+linux-can@lfdr.de>; Fri, 28 Mar 2025 10:37:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DA0F4A35;
	Fri, 28 Mar 2025 10:36:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="HPoVGni6"
X-Original-To: linux-can@vger.kernel.org
Received: from out.smtpout.orange.fr (out-73.smtpout.orange.fr [193.252.22.73])
	(using TLSv1.2 with cipher AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 169021ACECB;
	Fri, 28 Mar 2025 10:36:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.252.22.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743158218; cv=none; b=FXcYC+3BarJ3hXJ2fWkQ8MvcW3qfLgZ79Xp7vP16BGm1IzBZheCXL11l2QdYTySwLCk7Fcz4ZxDEUXoiqpvif+7xUV0vyJDCeF5g/sWI1SaORx9PTBgBJqt0UzcPLcQuBcwZHUB4aB7DF6XaY82nSAiwuZNkwfVcCN7Z4ejQUHg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743158218; c=relaxed/simple;
	bh=RKwGm0t3NLBLtILhOZHTaiiMzbzLEFX8lNXYb61WNiE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bQn4GIksEyf7Abi/oUSsgWLIKbUhKX6aLeB+f1xSPn98p58WQgQxQfuGgFFBUPwM8lkaMZjMY29/m5ffXXzuARKURIYCPmvLWEGOkIN9gjHDLgwT3FSakkLPAcJGHlKIt2ezM8DrEXunpK243Zu1WDf3rgOvZDRX9dY4IPx8Iw8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=wanadoo.fr; dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b=HPoVGni6; arc=none smtp.client-ip=193.252.22.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Received: from [172.16.82.72] ([124.33.176.97])
	by smtp.orange.fr with ESMTPA
	id y74ttxUWgDCLUy74ytqsoU; Fri, 28 Mar 2025 11:36:52 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1743158212;
	bh=TSWyVYmDyHgXemt9QL1W8qoxyHsQnAOHADO1xlW62O0=;
	h=Message-ID:Date:MIME-Version:Subject:To:From;
	b=HPoVGni6j9d89W5HEee/I7d/jF3w1TuicoLHiDtb7j0kSPWmMEK28nairm9kYYaOT
	 u+mVrtvI0vUylVjeL7995NcWI7HEubs714UAopGZjv11bkHyM+zVXHmQvqa4M7mptV
	 BrMeAd2NHd2aMZE7dEB2DA0dXq+rcyZ4gwAtYqRSYGPPkexxTrbprYqcK7ga0sWRiy
	 LEdfNNJbyOw++C52iGC5C9CH+f0Cirk+a6v4GP2G/9v/8V6MGPrcT2T/8TcWo60GmA
	 fzx4UvU2cIEe3gyo+NHTs4AdCn+0mHFrxhnrgWCsG0SgxTJmIkiUAqKrFrPNzdFdXb
	 CDsvkcZZdi9eQ==
X-ME-Helo: [172.16.82.72]
X-ME-Auth: bWFpbGhvbC52aW5jZW50QHdhbmFkb28uZnI=
X-ME-Date: Fri, 28 Mar 2025 11:36:52 +0100
X-ME-IP: 124.33.176.97
Message-ID: <3bf3ec05-d900-494a-954e-633828b4c984@wanadoo.fr>
Date: Fri, 28 Mar 2025 19:36:42 +0900
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 07/18] can: rcar_canfd: Add rnc_stride variable to
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
 <20250326122003.122976-8-biju.das.jz@bp.renesas.com>
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
In-Reply-To: <20250326122003.122976-8-biju.das.jz@bp.renesas.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 26/03/2025 at 21:19, Biju Das wrote:
> R-Car Gen4 packs 2 RNC values in a 32-bit word, whereas R-Car Gen3 packs
> up to 4 values in a 32-bit word. Handle this difference by adding
> rnc_stride variable to struct rcar_canfd_hw_info and update the macro
> RCANFD_GAFLCFG.
> 
> Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
> Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
> ---
> v6->v7:
>  * Collected tag.
> v5->v6:
>  * Replaced RCANFD_RNC_PER_REG macro with rnc_stride variable.
>  * Updated commit description
>  * Dropped Rb tag.
> v5:
>  * New patch.
> ---
>  drivers/net/can/rcar/rcar_canfd.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/net/can/rcar/rcar_canfd.c b/drivers/net/can/rcar/rcar_canfd.c
> index 32d700962d69..0001c8043c25 100644
> --- a/drivers/net/can/rcar/rcar_canfd.c
> +++ b/drivers/net/can/rcar/rcar_canfd.c
> @@ -291,7 +291,7 @@
>  /* RSCFDnCFDGAFLECTR / RSCFDnGAFLECTR */
>  #define RCANFD_GAFLECTR			(0x0098)
>  /* RSCFDnCFDGAFLCFG / RSCFDnGAFLCFG */
> -#define RCANFD_GAFLCFG(ch)		(0x009c + (0x04 * ((ch) / 2)))
> +#define RCANFD_GAFLCFG(gpriv, ch)	(0x009c + (0x04 * ((ch) / (gpriv)->info->rnc_stride)))

I find it rather hard to follow the logic here. Your are multiplying by
four and then dividing again to get the good results. Here, I guess that
0x04 represents sizeof(u32), but this needs some thinking to figure that
out.

Wouldn't it be more intuitive to instead store the size in bytes of the
RNC value?

#define RCANFD_GAFLCFG(gpriv, ch) \
	(0x009c + (gpriv)->info->sizeof_rnc * (ch))

This way, no more 0x04 magic number and it is easier to process a
multiplication than a division in your head when reading the code.

>  /* RSCFDnCFDRMNB / RSCFDnRMNB */
>  #define RCANFD_RMNB			(0x00a4)
>  /* RSCFDnCFDRMND / RSCFDnRMND */
> @@ -505,6 +505,7 @@ struct rcar_canfd_global;
>  
>  struct rcar_canfd_hw_info {
>  	u16 num_supported_rules;
> +	u8 rnc_stride;
>  	u8 max_channels;
>  	u8 postdiv;
>  	/* hardware features */
> @@ -582,6 +583,7 @@ static const struct can_bittiming_const rcar_canfd_bittiming_const = {
>  
>  static const struct rcar_canfd_hw_info rcar_gen3_hw_info = {
>  	.num_supported_rules = 256,
> +	.rnc_stride = 4,
>  	.max_channels = 2,
>  	.postdiv = 2,
>  	.shared_global_irqs = 1,
> @@ -589,6 +591,7 @@ static const struct rcar_canfd_hw_info rcar_gen3_hw_info = {
>  
>  static const struct rcar_canfd_hw_info rcar_gen4_hw_info = {
>  	.num_supported_rules = 512,
> +	.rnc_stride = 2,
>  	.max_channels = 8,
>  	.postdiv = 2,
>  	.shared_global_irqs = 1,
> @@ -596,6 +599,7 @@ static const struct rcar_canfd_hw_info rcar_gen4_hw_info = {
>  
>  static const struct rcar_canfd_hw_info rzg2l_hw_info = {
>  	.num_supported_rules = 256,
> +	.rnc_stride = 4,
>  	.max_channels = 2,
>  	.postdiv = 1,
>  	.multi_channel_irqs = 1,
> @@ -797,7 +801,7 @@ static void rcar_canfd_configure_afl_rules(struct rcar_canfd_global *gpriv,
>  			    RCANFD_GAFLECTR_AFLDAE));
>  
>  	/* Write number of rules for channel */
> -	rcar_canfd_set_bit(gpriv->base, RCANFD_GAFLCFG(ch),
> +	rcar_canfd_set_bit(gpriv->base, RCANFD_GAFLCFG(gpriv, ch),
>  			   RCANFD_GAFLCFG_SETRNC(gpriv, ch, num_rules));
>  	if (is_gen4(gpriv))
>  		offset = RCANFD_GEN4_GAFL_OFFSET;


Yours sincerely,
Vincent Mailhol


