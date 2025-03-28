Return-Path: <linux-can+bounces-3261-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 76867A74876
	for <lists+linux-can@lfdr.de>; Fri, 28 Mar 2025 11:39:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EE2C316F2B6
	for <lists+linux-can@lfdr.de>; Fri, 28 Mar 2025 10:39:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B3731DDA20;
	Fri, 28 Mar 2025 10:39:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="b306I0FQ"
X-Original-To: linux-can@vger.kernel.org
Received: from out.smtpout.orange.fr (out-68.smtpout.orange.fr [193.252.22.68])
	(using TLSv1.2 with cipher AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D84ED1DE3B6;
	Fri, 28 Mar 2025 10:39:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.252.22.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743158365; cv=none; b=rvnMcMgRz1MdhCZWCdYEUQFQn+GQOyu5mbucGL8Xwujy2JJdtP8U5MMclM+1BLmEldAZBOHHD1Q2zcCROsVM+t7VWgQznSErlgZw7xjAG672Hu+Xi1ig2RTYwqMnEu4RqaEzaRwy/PbwNy+FVUYViyfLjxIiMUzqj1Cc53UkFs8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743158365; c=relaxed/simple;
	bh=nztEJucQme9maIcpnj1qqJ4JyTqn43EhOFHHEqZl5Vc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oKSTXirTs4kRDPFSoZcwHbT7J4Ji616LtGacN1EiITp0FgXHCPTH4x87aVoB9gG+lF5ZctOUPpejJnFCGj7dEYKQGgyJE8ECujSNgs/TmSeXsz7kYKY+EolPRFz+yH9+TwMb93tuKeOkq/024zn/DWTUoonW2y6vzIecApgjYac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=wanadoo.fr; dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b=b306I0FQ; arc=none smtp.client-ip=193.252.22.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Received: from [172.16.82.72] ([124.33.176.97])
	by smtp.orange.fr with ESMTPA
	id y77At65RDZjv1y77EteckE; Fri, 28 Mar 2025 11:39:12 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1743158352;
	bh=nSoP7Ssu7cAeVLsmK3twYuh4DRAT1gL5xF9uJBRKvOI=;
	h=Message-ID:Date:MIME-Version:Subject:To:From;
	b=b306I0FQGl0SMVIG0LneCNJuC2IXa7zsP+K0O075aBddRQmO9zB13OyrvFgEBCS9e
	 7KjeXyShOIylCzv4mra2F1fN2RBds3VEznKOvfeTmGWfBTfpa82LwrgAZBV59a4A9z
	 bdj+PG4VgQeFMBmWQZPGHirfySq+ZPBmNKvSbUQCoWMbPgiqHKZIiVhJtWVnytaIb8
	 WWsU0WV7SvCPSTx1AVMI557kXXv1kLxcg1Rw2Ibs0GvIjmrkDiQP15io/Prr6fH/gS
	 qCz9BMU3MNOSKbaNl/hbo9tkHwdwOAwzHLaldkxCDWRWXSVP2EGpP/zO7Mxve27oAK
	 C9N0Gylb67rIA==
X-ME-Helo: [172.16.82.72]
X-ME-Auth: bWFpbGhvbC52aW5jZW50QHdhbmFkb28uZnI=
X-ME-Date: Fri, 28 Mar 2025 11:39:12 +0100
X-ME-IP: 124.33.176.97
Message-ID: <ee0f8bff-6dc4-4ddc-a2d2-89ed6fddcc8f@wanadoo.fr>
Date: Fri, 28 Mar 2025 19:39:03 +0900
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 08/18] can: rcar_canfd: Simplify RCANFD_GAFLCFG_SETRNC
 macro
To: Biju Das <biju.das.jz@bp.renesas.com>,
 Marc Kleine-Budde <mkl@pengutronix.de>
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>,
 Geert Uytterhoeven <geert+renesas@glider.be>,
 =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>,
 linux-can@vger.kernel.org,
 Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>,
 Biju Das <biju.das.au@gmail.com>, linux-renesas-soc@vger.kernel.org
References: <20250326122003.122976-1-biju.das.jz@bp.renesas.com>
 <20250326122003.122976-9-biju.das.jz@bp.renesas.com>
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
In-Reply-To: <20250326122003.122976-9-biju.das.jz@bp.renesas.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 26/03/2025 at 21:19, Biju Das wrote:
> The shift values in RCANFD_GAFLCFG_SETRNC are dictated by the field width:
>   - R-Car Gen4 packs 2 values in a 32-bit word, using a field width
>     of 16 bits,
>   - R-Car Gen3 packs up to 4 values in a 32-bit word, using a field
>     width of 8 bits.
> 
> Add rnc_field_width variable to struct rcar_canfd_hw_info to handle this
> difference and simplify the shift value in RCANFD_GAFLCFG_SETRNC macro by
> using a formula (32 - (n % rnc_stride + 1) * rnc_field_width).
> 
> Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
> Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
> ---
> v6->7:
>  * Collected tag.
> v5->6:
>  * Replaced RCANFD_RNC_PER_REG macro with rnc_stride variable.
>  * Updated commit description
>  * Dropped the Rb tag.
> v5:
>  * New patch.
> ---
>  drivers/net/can/rcar/rcar_canfd.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/net/can/rcar/rcar_canfd.c b/drivers/net/can/rcar/rcar_canfd.c
> index 0001c8043c25..62cde1efa0c0 100644
> --- a/drivers/net/can/rcar/rcar_canfd.c
> +++ b/drivers/net/can/rcar/rcar_canfd.c
> @@ -89,7 +89,7 @@
>  /* RSCFDnCFDGAFLCFG0 / RSCFDnGAFLCFG0 */
>  #define RCANFD_GAFLCFG_SETRNC(gpriv, n, x) \
>  	(((x) & ((gpriv)->info->num_supported_rules - 1)) << \
> -	 (reg_gen4(gpriv, 16, 24) - ((n) & 1) * reg_gen4(gpriv, 16, 8)))
> +	 (32 - (((n) % (gpriv)->info->rnc_stride + 1) * (gpriv)->info->rnc_field_width)))

I can not follow how this is the same. Let's take the gen4 as an
example. Before:

  (reg_gen4(gpriv, 16, 24) - ((n) & 1) * reg_gen4(gpriv, 16, 8))) =
  16 - ((n & 1) * 16)

So, I have:

	 n	shift value
	---------------------------------
	 0	16 - ((0 & 1) * 16) = 0
	 1	16 - ((1 & 1) * 16) = 16
	 2	16 - ((2 & 1) * 16) = 0
	 3	16 - ((3 & 1) * 16) = 16
	 4	16 - ((4 & 1) * 16) = 0

After:

  (32 - ((n % rnc_stride + 1)) * rnc_field_width) =
  32 - ((n % (2 + 1)) * 16) =
  32 - ((n % 3) * 16)

	 n	shift value
	---------------------------------
	 0	32 - ((0 % 3) * 16) = 32
	 1	32 - ((1 % 3) * 16) = 16
	 2	32 - ((2 % 3) * 16) = 0
	 3	32 - ((3 % 3) * 16) = 32
	 4	32 - ((4 % 3) * 16) = 16

Is there something wrong in my calculation? What am I missing?


More generally, it is really hard to review and understand what this
macro does.

Can add one more patch:

  can: rcar_canfd: turn RCANFD_GAFLCFG_SETRNC into a function

and then apply your change?

I do not see the reason why this needs to be a macro. If you make this a
function, at least, it will be easier to follow what is going on and the
compiler optimizer will inline it anyway so you should not get any penalty.

>  /* RSCFDnCFDGAFLECTR / RSCFDnGAFLECTR */
>  #define RCANFD_GAFLECTR_AFLDAE		BIT(8)
> @@ -506,6 +506,7 @@ struct rcar_canfd_global;
>  struct rcar_canfd_hw_info {
>  	u16 num_supported_rules;
>  	u8 rnc_stride;
> +	u8 rnc_field_width;

Following my previous comment on patch #7, if you replace
rcar_canfd_hw_info->rnc_stride by sizeof_rnc, then you can get the width
with:

  rcar_canfd_hw_info->sizeof_rnc * BITS_PER_BYTE

>  	u8 max_channels;
>  	u8 postdiv;
>  	/* hardware features */
> @@ -584,6 +585,7 @@ static const struct can_bittiming_const rcar_canfd_bittiming_const = {
>  static const struct rcar_canfd_hw_info rcar_gen3_hw_info = {
>  	.num_supported_rules = 256,
>  	.rnc_stride = 4,
> +	.rnc_field_width = 8,
>  	.max_channels = 2,
>  	.postdiv = 2,
>  	.shared_global_irqs = 1,
> @@ -592,6 +594,7 @@ static const struct rcar_canfd_hw_info rcar_gen3_hw_info = {
>  static const struct rcar_canfd_hw_info rcar_gen4_hw_info = {
>  	.num_supported_rules = 512,
>  	.rnc_stride = 2,
> +	.rnc_field_width = 16,
>  	.max_channels = 8,
>  	.postdiv = 2,
>  	.shared_global_irqs = 1,
> @@ -600,6 +603,7 @@ static const struct rcar_canfd_hw_info rcar_gen4_hw_info = {
>  static const struct rcar_canfd_hw_info rzg2l_hw_info = {
>  	.num_supported_rules = 256,
>  	.rnc_stride = 4,
> +	.rnc_field_width = 8,
>  	.max_channels = 2,
>  	.postdiv = 1,
>  	.multi_channel_irqs = 1,


Yours sincerely,
Vincent Mailhol


