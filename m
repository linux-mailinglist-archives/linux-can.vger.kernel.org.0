Return-Path: <linux-can+bounces-3277-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 297BEA74BF9
	for <lists+linux-can@lfdr.de>; Fri, 28 Mar 2025 15:05:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 506091B60C05
	for <lists+linux-can@lfdr.de>; Fri, 28 Mar 2025 13:56:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 212E92F37;
	Fri, 28 Mar 2025 13:56:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="p1xMhrLQ"
X-Original-To: linux-can@vger.kernel.org
Received: from out.smtpout.orange.fr (out-71.smtpout.orange.fr [193.252.22.71])
	(using TLSv1.2 with cipher AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C161218309C;
	Fri, 28 Mar 2025 13:56:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.252.22.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743170170; cv=none; b=EaTBfEWZgAlNgg/4SbL1VkRokQthvwHeu2Z9Xkv5Yd65IPfoYy3vhnqcj8nKcGDIXUXkao6lPF53XL3n13NobJVPLzpvHKpA9QBmR3S3TSmD/X+jh8+rAztb3yuTPrd5QDREHsOn7QkEOLIQUcm8/+j2J2Id4xDkyCWm+yf2mnI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743170170; c=relaxed/simple;
	bh=qbW+KWdrql8l1bT4IABuVPLjj9PI/sCd0oUKtTmNegc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iK1czI5pba61ErV49ItZxwuePTVh0JodufjqLqeFdWl5udjBJGKqJkgwTwvpUgN789dtNeo8iAdDNxPUy8Je7w6IT6GXwCVPDRTQ8U9+W7NfVBBGPFMgdRD47/MQkSqtgOMd9Yb2UHHaEBAJFMU/Zaf+MEYiiK9rtSFdpXZEOjY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=wanadoo.fr; dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b=p1xMhrLQ; arc=none smtp.client-ip=193.252.22.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Received: from [172.16.82.72] ([124.33.176.97])
	by smtp.orange.fr with ESMTPA
	id yABgtCHPmyvSyyABktqRb7; Fri, 28 Mar 2025 14:56:04 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1743170164;
	bh=8jNoKGX5GPxFjK291/BN93eU2gU71JkSOM1fojiBDDA=;
	h=Message-ID:Date:MIME-Version:Subject:To:From;
	b=p1xMhrLQG4Z3gh+oS4I4rmmFSJDMoScFHu3Cm5Uwc9hMPUE5hVSXbbXA+3VS0f0FD
	 86tQbFc3MRdXsJ4+sGwhPvHxQLqrzTH93Vig+6TGNskJzupXxeonXDW5awGLtkGvQP
	 scdiiKoGXVQ11QdzwmfiA8voIWyxKW84K6d1AalDFU1oMuyCNHmO20ZOsa1iVGF66q
	 xSsBY48MM0XAXjRuSG2orYWN2Q9DgFjpAfQO5KjC3yk1h3bbT3ZlqbxNmCwSMYt66/
	 TIVw5+I/dbUgdt2o4PCEb2PMzM/RoC6k0Wtd4xzIH1kh8sxLNnM6IR/z30UMXHNmb6
	 F0PbbPAGK8Mbg==
X-ME-Helo: [172.16.82.72]
X-ME-Auth: bWFpbGhvbC52aW5jZW50QHdhbmFkb28uZnI=
X-ME-Date: Fri, 28 Mar 2025 14:56:04 +0100
X-ME-IP: 124.33.176.97
Message-ID: <7e12d0d3-a4f6-477d-8c78-71444734429f@wanadoo.fr>
Date: Fri, 28 Mar 2025 22:55:56 +0900
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 11/18] can: rcar_canfd: Add {nom,data}_bittiming
 variables to struct rcar_canfd_hw_info
To: Biju Das <biju.das.jz@bp.renesas.com>,
 Marc Kleine-Budde <mkl@pengutronix.de>
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>,
 Geert Uytterhoeven <geert+renesas@glider.be>,
 =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>,
 linux-can@vger.kernel.org,
 Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>,
 Biju Das <biju.das.au@gmail.com>, linux-renesas-soc@vger.kernel.org
References: <20250326122003.122976-1-biju.das.jz@bp.renesas.com>
 <20250326122003.122976-12-biju.das.jz@bp.renesas.com>
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
In-Reply-To: <20250326122003.122976-12-biju.das.jz@bp.renesas.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 26/03/2025 at 21:19, Biju Das wrote:
> Both R-Car Gen4 and R-Car Gen3 have different bit timing parameters
> Add {nom,data}_bittiming variables to struct rcar_canfd_hw_info to
> handle this difference.
> 
> Since the mask used in the macros are max value - 1, replace that
> as well.
> 
> Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
> Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>

Reviewed-by: Vincent Mailhol <mailhol.vincent@wanadoo.fr>

> ---
> v6->v7:
>  * Collected tag.
>  * Updated 'aswell'->'as well' in commit description.
> v6:
>  * New patch.
> ---
>  drivers/net/can/rcar/rcar_canfd.c | 53 ++++++++++++++++++++++++-------
>  1 file changed, 42 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/net/can/rcar/rcar_canfd.c b/drivers/net/can/rcar/rcar_canfd.c
> index c37fb85fe478..7e7f3c3307ae 100644
> --- a/drivers/net/can/rcar/rcar_canfd.c
> +++ b/drivers/net/can/rcar/rcar_canfd.c
> @@ -111,13 +111,13 @@
>  
>  /* RSCFDnCFDCmNCFG - CAN FD only */
>  #define RCANFD_NCFG_NTSEG2(gpriv, x) \
> -	(((x) & reg_gen4(gpriv, 0x7f, 0x1f)) << reg_gen4(gpriv, 25, 24))
> +	(((x) & ((gpriv)->info->nom_bittiming->tseg2_max - 1)) << reg_gen4(gpriv, 25, 24))
>  
>  #define RCANFD_NCFG_NTSEG1(gpriv, x) \
> -	(((x) & reg_gen4(gpriv, 0xff, 0x7f)) << reg_gen4(gpriv, 17, 16))
> +	(((x) & ((gpriv)->info->nom_bittiming->tseg1_max - 1)) << reg_gen4(gpriv, 17, 16))
>  
>  #define RCANFD_NCFG_NSJW(gpriv, x) \
> -	(((x) & reg_gen4(gpriv, 0x7f, 0x1f)) << reg_gen4(gpriv, 10, 11))
> +	(((x) & ((gpriv)->info->nom_bittiming->sjw_max - 1)) << reg_gen4(gpriv, 10, 11))
>  
>  #define RCANFD_NCFG_NBRP(x)		(((x) & 0x3ff) << 0)
>  
> @@ -179,13 +179,13 @@
>  #define RCANFD_CERFL_ERR(x)		((x) & (0x7fff)) /* above bits 14:0 */
>  
>  /* RSCFDnCFDCmDCFG */
> -#define RCANFD_DCFG_DSJW(gpriv, x)	(((x) & reg_gen4(gpriv, 0xf, 0x7)) << 24)
> +#define RCANFD_DCFG_DSJW(gpriv, x)	(((x) & ((gpriv)->info->data_bittiming->sjw_max - 1)) << 24)
>  
>  #define RCANFD_DCFG_DTSEG2(gpriv, x) \
> -	(((x) & reg_gen4(gpriv, 0x0f, 0x7)) << reg_gen4(gpriv, 16, 20))
> +	(((x) & ((gpriv)->info->data_bittiming->tseg2_max - 1)) << reg_gen4(gpriv, 16, 20))
>  
>  #define RCANFD_DCFG_DTSEG1(gpriv, x) \
> -	(((x) & reg_gen4(gpriv, 0x1f, 0xf)) << reg_gen4(gpriv, 8, 16))
> +	(((x) & ((gpriv)->info->data_bittiming->tseg1_max - 1)) << reg_gen4(gpriv, 8, 16))
>  
>  #define RCANFD_DCFG_DBRP(x)		(((x) & 0xff) << 0)
>  
> @@ -504,6 +504,8 @@
>  struct rcar_canfd_global;
>  
>  struct rcar_canfd_hw_info {
> +	const struct can_bittiming_const *nom_bittiming;
> +	const struct can_bittiming_const *data_bittiming;
>  	u16 num_supported_rules;
>  	u8 rnc_stride;
>  	u8 rnc_field_width;
> @@ -546,7 +548,7 @@ struct rcar_canfd_global {
>  };
>  
>  /* CAN FD mode nominal rate constants */
> -static const struct can_bittiming_const rcar_canfd_nom_bittiming_const = {
> +static const struct can_bittiming_const rcar_canfd_gen3_nom_bittiming_const = {
>  	.name = RCANFD_DRV_NAME,
>  	.tseg1_min = 2,
>  	.tseg1_max = 128,
> @@ -558,8 +560,20 @@ static const struct can_bittiming_const rcar_canfd_nom_bittiming_const = {
>  	.brp_inc = 1,
>  };
>  
> +static const struct can_bittiming_const rcar_canfd_gen4_nom_bittiming_const = {
> +	.name = RCANFD_DRV_NAME,
> +	.tseg1_min = 2,
> +	.tseg1_max = 256,
> +	.tseg2_min = 2,
> +	.tseg2_max = 128,
> +	.sjw_max = 128,
> +	.brp_min = 1,
> +	.brp_max = 1024,
> +	.brp_inc = 1,
> +};
> +
>  /* CAN FD mode data rate constants */
> -static const struct can_bittiming_const rcar_canfd_data_bittiming_const = {
> +static const struct can_bittiming_const rcar_canfd_gen3_data_bittiming_const = {
>  	.name = RCANFD_DRV_NAME,
>  	.tseg1_min = 2,
>  	.tseg1_max = 16,
> @@ -571,6 +585,18 @@ static const struct can_bittiming_const rcar_canfd_data_bittiming_const = {
>  	.brp_inc = 1,
>  };
>  
> +static const struct can_bittiming_const rcar_canfd_gen4_data_bittiming_const = {
> +	.name = RCANFD_DRV_NAME,
> +	.tseg1_min = 2,
> +	.tseg1_max = 32,
> +	.tseg2_min = 2,
> +	.tseg2_max = 16,
> +	.sjw_max = 16,
> +	.brp_min = 1,
> +	.brp_max = 256,
> +	.brp_inc = 1,
> +};
> +
>  /* Classical CAN mode bitrate constants */
>  static const struct can_bittiming_const rcar_canfd_bittiming_const = {
>  	.name = RCANFD_DRV_NAME,
> @@ -585,6 +611,8 @@ static const struct can_bittiming_const rcar_canfd_bittiming_const = {
>  };
>  
>  static const struct rcar_canfd_hw_info rcar_gen3_hw_info = {
> +	.nom_bittiming = &rcar_canfd_gen3_nom_bittiming_const,
> +	.data_bittiming = &rcar_canfd_gen3_data_bittiming_const,
>  	.num_supported_rules = 256,
>  	.rnc_stride = 4,
>  	.rnc_field_width = 8,
> @@ -596,6 +624,8 @@ static const struct rcar_canfd_hw_info rcar_gen3_hw_info = {
>  };
>  
>  static const struct rcar_canfd_hw_info rcar_gen4_hw_info = {
> +	.nom_bittiming = &rcar_canfd_gen4_nom_bittiming_const,
> +	.data_bittiming = &rcar_canfd_gen4_data_bittiming_const,
>  	.num_supported_rules = 512,
>  	.rnc_stride = 2,
>  	.rnc_field_width = 16,
> @@ -607,6 +637,8 @@ static const struct rcar_canfd_hw_info rcar_gen4_hw_info = {
>  };
>  
>  static const struct rcar_canfd_hw_info rzg2l_hw_info = {
> +	.nom_bittiming = &rcar_canfd_gen3_nom_bittiming_const,
> +	.data_bittiming = &rcar_canfd_gen3_data_bittiming_const,
>  	.num_supported_rules = 256,
>  	.rnc_stride = 4,
>  	.rnc_field_width = 8,
> @@ -1795,9 +1827,8 @@ static int rcar_canfd_channel_probe(struct rcar_canfd_global *gpriv, u32 ch,
>  	}
>  
>  	if (gpriv->fdmode) {
> -		priv->can.bittiming_const = &rcar_canfd_nom_bittiming_const;
> -		priv->can.data_bittiming_const =
> -			&rcar_canfd_data_bittiming_const;
> +		priv->can.bittiming_const = gpriv->info->nom_bittiming;
> +		priv->can.data_bittiming_const = gpriv->info->data_bittiming;
>  
>  		/* Controller starts in CAN FD only mode */
>  		err = can_set_static_ctrlmode(ndev, CAN_CTRLMODE_FD);

-- 
Yours sincerely,
Vincent Mailhol


