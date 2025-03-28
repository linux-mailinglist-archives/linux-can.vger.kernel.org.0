Return-Path: <linux-can+bounces-3281-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 914BEA74DAA
	for <lists+linux-can@lfdr.de>; Fri, 28 Mar 2025 16:26:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 461C23B4C05
	for <lists+linux-can@lfdr.de>; Fri, 28 Mar 2025 15:25:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 796CF4204E;
	Fri, 28 Mar 2025 15:26:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="MzLT7JqW"
X-Original-To: linux-can@vger.kernel.org
Received: from out.smtpout.orange.fr (out-74.smtpout.orange.fr [193.252.22.74])
	(using TLSv1.2 with cipher AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36E0F23CB;
	Fri, 28 Mar 2025 15:25:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.252.22.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743175563; cv=none; b=dABgBCqGiyQPMEfJeuiKldb0udd1ffMmYa2eKEDagIEqnjXdc3n7g/J8lHPBq1JoGpBdfZQKXyJiAPRAWS2/vBa3mpQW7azalJ8FMDG6IEKAxDgQeWaXmaCLpdUoDxBWW7OLWMwR/HF5adbRIrKZlVa00BE6BEHzRTXQuj6h7EA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743175563; c=relaxed/simple;
	bh=NJmQq3+nuFff5yO10g6ZhH2WsaQaTa39pkH3W4jEIfA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nBTwVeP+RSm1hbgf/lTn6ZdginHfMSbven7zaN1KnJPoqDkPZZfQ9gmE1mifDMrFfRY/5wprD3Beo/P9UOvyM7yq4+s/hUgNpdnRBkgdla8ktF/QSYJeUHIpxSWc1cEDp0eBTuTQdGt48ZpLqm+6vwuXjRiGP85WaLgN+7Cfz0c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=wanadoo.fr; dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b=MzLT7JqW; arc=none smtp.client-ip=193.252.22.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Received: from [172.16.82.72] ([124.33.176.97])
	by smtp.orange.fr with ESMTPA
	id yBaet048JDCLUyBait7Bmi; Fri, 28 Mar 2025 16:25:56 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1743175556;
	bh=flTBAYFCzoaspgtlvoo6CMakhNExORAANLgcY+2eurk=;
	h=Message-ID:Date:MIME-Version:Subject:To:From;
	b=MzLT7JqWQidftgqWEfQ+LSEXSHRadzKyw6SPRkyTSipMIt27W0oQVT7sc//Foi/bd
	 tHQyCIwZVLEFnTJ4qb1YFPQuTyWsp/NQ7oC1S+oyKAyabgQ6pN2d9mXaKIrepIq944
	 dlP7ZwBvVQ9yulDrz15A4WKyR2LIOlIacxNMEwM8GOVcZcx9wcKS+mDHoHVl0LXu5X
	 901TKOkLFY2KafVNDN1ODuInCVdj3xu8yHZU0fxJ6ADaDFFj7bMCMWXH7ORQ9Jc4Tp
	 /bVEoM82cozdoyNWZb0otbuQgz8/jQQUa5Ui1dw010VXFHf9ODvlp+PBbrIT8lNQZ9
	 1LkHx/D518W4Q==
X-ME-Helo: [172.16.82.72]
X-ME-Auth: bWFpbGhvbC52aW5jZW50QHdhbmFkb28uZnI=
X-ME-Date: Fri, 28 Mar 2025 16:25:56 +0100
X-ME-IP: 124.33.176.97
Message-ID: <6b663ace-002c-44f9-bbdb-38af8a4e4da3@wanadoo.fr>
Date: Sat, 29 Mar 2025 00:25:47 +0900
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 15/18] can: rcar_canfd: Add shift table to struct
 rcar_canfd_hw_info
To: Biju Das <biju.das.jz@bp.renesas.com>
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>,
 Geert Uytterhoeven <geert+renesas@glider.be>,
 =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>,
 linux-can@vger.kernel.org,
 Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>,
 Biju Das <biju.das.au@gmail.com>, linux-renesas-soc@vger.kernel.org,
 Marc Kleine-Budde <mkl@pengutronix.de>
References: <20250326122003.122976-1-biju.das.jz@bp.renesas.com>
 <20250326122003.122976-16-biju.das.jz@bp.renesas.com>
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
In-Reply-To: <20250326122003.122976-16-biju.das.jz@bp.renesas.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 26/03/2025 at 21:19, Biju Das wrote:
> R-Car Gen3 and Gen4 have some differences in the shift bits. Add a
> shift table to handle these differences. After this drop the unused
> functions reg_gen4() and is_gen4().
> 
> Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
> Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
> ---
> v6->v7:
>  * No change.
> v5->v6:
>  * No change.
> v4->v5:
>  * Collected tag.
>  * Dropped RCANFD_FIRST_RNC_SH and RCANFD_SECOND_RNC_SH by using a
>    formula (32 - (n % rnc_per_reg + 1) * rnc_field_width.
> v3->v4:
>  * Added prefix RCANFD_* to enum rcar_canfd_shift_id.
> v3:
>  * New patch.
> ---
>  drivers/net/can/rcar/rcar_canfd.c | 69 ++++++++++++++++++++++---------
>  1 file changed, 50 insertions(+), 19 deletions(-)
> 
> diff --git a/drivers/net/can/rcar/rcar_canfd.c b/drivers/net/can/rcar/rcar_canfd.c
> index a96cf499f04b..20e591421cc6 100644
> --- a/drivers/net/can/rcar/rcar_canfd.c
> +++ b/drivers/net/can/rcar/rcar_canfd.c
> @@ -111,13 +111,16 @@
>  
>  /* RSCFDnCFDCmNCFG - CAN FD only */
>  #define RCANFD_NCFG_NTSEG2(gpriv, x) \
> -	(((x) & ((gpriv)->info->nom_bittiming->tseg2_max - 1)) << reg_gen4(gpriv, 25, 24))
> +	(((x) & ((gpriv)->info->nom_bittiming->tseg2_max - 1)) << \
> +	 (gpriv)->info->shift_table[RCANFD_NTSEG2_SH])
>  
>  #define RCANFD_NCFG_NTSEG1(gpriv, x) \
> -	(((x) & ((gpriv)->info->nom_bittiming->tseg1_max - 1)) << reg_gen4(gpriv, 17, 16))
> +	(((x) & ((gpriv)->info->nom_bittiming->tseg1_max - 1)) << \
> +	 (gpriv)->info->shift_table[RCANFD_NTSEG1_SH])
>  
>  #define RCANFD_NCFG_NSJW(gpriv, x) \
> -	(((x) & ((gpriv)->info->nom_bittiming->sjw_max - 1)) << reg_gen4(gpriv, 10, 11))
> +	(((x) & ((gpriv)->info->nom_bittiming->sjw_max - 1)) << \
> +	 (gpriv)->info->shift_table[RCANFD_NSJW_SH])
>  
>  #define RCANFD_NCFG_NBRP(x)		(((x) & 0x3ff) << 0)
>  
> @@ -182,10 +185,12 @@
>  #define RCANFD_DCFG_DSJW(gpriv, x)	(((x) & ((gpriv)->info->data_bittiming->sjw_max - 1)) << 24)
>  
>  #define RCANFD_DCFG_DTSEG2(gpriv, x) \
> -	(((x) & ((gpriv)->info->data_bittiming->tseg2_max - 1)) << reg_gen4(gpriv, 16, 20))
> +	(((x) & ((gpriv)->info->data_bittiming->tseg2_max - 1)) << \
> +	 (gpriv)->info->shift_table[RCANFD_DTSEG2_SH])
>  
>  #define RCANFD_DCFG_DTSEG1(gpriv, x) \
> -	(((x) & ((gpriv)->info->data_bittiming->tseg1_max - 1)) << reg_gen4(gpriv, 8, 16))
> +	(((x) & ((gpriv)->info->data_bittiming->tseg1_max - 1)) << \
> +	 (gpriv)->info->shift_table[RCANFD_DTSEG1_SH])
>  
>  #define RCANFD_DCFG_DBRP(x)		(((x) & 0xff) << 0)
>  
> @@ -227,10 +232,10 @@
>  
>  /* RSCFDnCFDCFCCk */
>  #define RCANFD_CFCC_CFTML(gpriv, x)	\
> -	(((x) & (gpriv)->info->max_cftml) << reg_gen4(gpriv, 16, 20))
> -#define RCANFD_CFCC_CFM(gpriv, x)	(((x) & 0x3) << reg_gen4(gpriv,  8, 16))
> +	(((x) & (gpriv)->info->max_cftml) << (gpriv)->info->shift_table[RCANFD_CFTML_SH])
> +#define RCANFD_CFCC_CFM(gpriv, x)	(((x) & 0x3) << (gpriv)->info->shift_table[RCANFD_CFM_SH])
>  #define RCANFD_CFCC_CFIM		BIT(12)
> -#define RCANFD_CFCC_CFDC(gpriv, x)	(((x) & 0x7) << reg_gen4(gpriv, 21,  8))
> +#define RCANFD_CFCC_CFDC(gpriv, x)	(((x) & 0x7) << (gpriv)->info->shift_table[RCANFD_CFDC_SH])
>  #define RCANFD_CFCC_CFPLS(x)		(((x) & 0x7) << 4)
>  #define RCANFD_CFCC_CFTXIE		BIT(2)
>  #define RCANFD_CFCC_CFE			BIT(0)
> @@ -511,12 +516,24 @@ enum rcar_canfd_reg_offset_id {
>  	RCANFD_CFOFFSET,	/* Transmit/receive FIFO buffer access ID register */
>  };
>  
> +enum rcar_canfd_shift_id {
> +	RCANFD_NTSEG2_SH,	/* Nominal Bit Rate Time Segment 2 Control */
> +	RCANFD_NTSEG1_SH,	/* Nominal Bit Rate Time Segment 1 Control */
> +	RCANFD_NSJW_SH,		/* Nominal Bit Rate Resynchronization Jump Width Control */
> +	RCANFD_DTSEG2_SH,	/* Data Bit Rate Time Segment 2 Control */
> +	RCANFD_DTSEG1_SH,	/* Data Bit Rate Time Segment 1 Control */
> +	RCANFD_CFTML_SH,	/* Common FIFO TX Message Buffer Link */
> +	RCANFD_CFM_SH,		/* Common FIFO Mode */
> +	RCANFD_CFDC_SH,		/* Common FIFO Depth Configuration */
> +};
> +
>  struct rcar_canfd_global;
>  
>  struct rcar_canfd_hw_info {
>  	const struct can_bittiming_const *nom_bittiming;
>  	const struct can_bittiming_const *data_bittiming;
>  	const u16 *regs;
> +	const u8 *shift_table;
>  	u16 num_supported_rules;
>  	u8 rnc_stride;
>  	u8 rnc_field_width;
> @@ -643,10 +660,33 @@ static const u16 rcar_gen4_regs[] = {
>  	[RCANFD_CFOFFSET] = 0x6400,
>  };
>  
> +static const u8 rcar_gen3_shift_table[] = {
> +	[RCANFD_NTSEG2_SH] = 24,
> +	[RCANFD_NTSEG1_SH] = 16,
> +	[RCANFD_NSJW_SH] = 11,
> +	[RCANFD_DTSEG2_SH] = 20,
> +	[RCANFD_DTSEG1_SH] = 16,
> +	[RCANFD_CFTML_SH] = 20,
> +	[RCANFD_CFM_SH] = 16,
> +	[RCANFD_CFDC_SH] = 8,
> +};
> +
> +static const u8 rcar_gen4_shift_table[] = {
> +	[RCANFD_NTSEG2_SH] = 25,
> +	[RCANFD_NTSEG1_SH] = 17,
> +	[RCANFD_NSJW_SH] = 10,
> +	[RCANFD_DTSEG2_SH] = 16,
> +	[RCANFD_DTSEG1_SH] = 8,
> +	[RCANFD_CFTML_SH] = 16,
> +	[RCANFD_CFM_SH] = 8,
> +	[RCANFD_CFDC_SH] = 21,
> +};

Exact same comment as previous patch. A structure looks more appropriate
than an array here.

>  static const struct rcar_canfd_hw_info rcar_gen3_hw_info = {
>  	.nom_bittiming = &rcar_canfd_gen3_nom_bittiming_const,
>  	.data_bittiming = &rcar_canfd_gen3_data_bittiming_const,
>  	.regs = rcar_gen3_regs,
> +	.shift_table = rcar_gen3_shift_table,
>  	.num_supported_rules = 256,
>  	.rnc_stride = 4,
>  	.rnc_field_width = 8,
> @@ -661,6 +701,7 @@ static const struct rcar_canfd_hw_info rcar_gen4_hw_info = {
>  	.nom_bittiming = &rcar_canfd_gen4_nom_bittiming_const,
>  	.data_bittiming = &rcar_canfd_gen4_data_bittiming_const,
>  	.regs = rcar_gen4_regs,
> +	.shift_table = rcar_gen4_shift_table,
>  	.num_supported_rules = 512,
>  	.rnc_stride = 2,
>  	.rnc_field_width = 16,
> @@ -677,6 +718,7 @@ static const struct rcar_canfd_hw_info rzg2l_hw_info = {
>  	.nom_bittiming = &rcar_canfd_gen3_nom_bittiming_const,
>  	.data_bittiming = &rcar_canfd_gen3_data_bittiming_const,
>  	.regs = rcar_gen3_regs,
> +	.shift_table = rcar_gen3_shift_table,
>  	.num_supported_rules = 256,
>  	.rnc_stride = 4,
>  	.rnc_field_width = 8,
> @@ -688,17 +730,6 @@ static const struct rcar_canfd_hw_info rzg2l_hw_info = {
>  };
>  
>  /* Helper functions */
> -static inline bool is_gen4(struct rcar_canfd_global *gpriv)
> -{
> -	return gpriv->info == &rcar_gen4_hw_info;
> -}
> -
> -static inline u32 reg_gen4(struct rcar_canfd_global *gpriv,
> -			   u32 gen4, u32 not_gen4)
> -{
> -	return is_gen4(gpriv) ? gen4 : not_gen4;
> -}
> -
>  static inline void rcar_canfd_update(u32 mask, u32 val, u32 __iomem *reg)
>  {
>  	u32 data = readl(reg);

Yours sincerely,
Vincent Mailhol


