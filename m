Return-Path: <linux-can+bounces-3267-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 054FAA748EE
	for <lists+linux-can@lfdr.de>; Fri, 28 Mar 2025 12:05:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 991FE16F68C
	for <lists+linux-can@lfdr.de>; Fri, 28 Mar 2025 11:05:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F04E51DF246;
	Fri, 28 Mar 2025 11:05:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="hpahVgUX"
X-Original-To: linux-can@vger.kernel.org
Received: from out.smtpout.orange.fr (out-68.smtpout.orange.fr [193.252.22.68])
	(using TLSv1.2 with cipher AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63BA9B676;
	Fri, 28 Mar 2025 11:05:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.252.22.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743159953; cv=none; b=VE35194x7gGRV5tdeZQ5VHeBU+mF3vkIxyket2d3OXW1ZrX1QvdRJT6MCUuqdFeh5NZD13nPy29nPphL+TeEgWuZIHk+pFmRBiBF3KmoCCzK93tlqjruye4FhJoTKt2v3g89h0/IGjNQszwXbjq4svAuEAHOY3pOYKfZkrcCqUA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743159953; c=relaxed/simple;
	bh=XcFMrNGVn8byLyr0AzLI7nAD7OmP6kTlUsvi+vXNxWU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=riboQD+Mqz4+Qa9lbxRtHNFfKUajnHqZWrsPhzawwme9VSLgSFm/mu0DNe9y8QDvfG0WCtPWFqJXhwQEJrAXhDkgrU7Fu6+Wd61Z0oevdhnNKOctgmmpdQ7Y3zb6UPDKYDZN1NeQpXLGVEkcCvzQVJNbpuKW/blBJB8CiV/5vEM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=wanadoo.fr; dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b=hpahVgUX; arc=none smtp.client-ip=193.252.22.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Received: from [172.16.82.72] ([124.33.176.97])
	by smtp.orange.fr with ESMTPA
	id y7WvtJojUhqDwy7Wztnj9Y; Fri, 28 Mar 2025 12:05:48 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1743159948;
	bh=WSFImiEWU+feNZAMUTrNm0Q5v8XMFB7mNmiEb1x3oTU=;
	h=Message-ID:Date:MIME-Version:Subject:To:From;
	b=hpahVgUXO4ZULjmti6pl4imI6UeIrX7y3c6oajc9pWDpFwERJDIMnVOfrsQcbXQnS
	 7HBvilS/2pNB5QA5lZwQ4FrptZi4G45Xc94dog2ayVDALwTxIJy0fy/vKz9d45PAGi
	 8bNwZ1uNUovwXDtc5QM52gJoU4lyd2DIPYVaqOZMV3YEVKDz7YZVBfPJQYtHlYGgXX
	 hKWEnnKr/Q96kn4WOwrBlApnI0kFQdE/u2F11aIQchIBzMD30FsqNwvBpH0p7MexKy
	 f9GXBTndauqPsTJx4cK1TuT6eahHZXxrdlYWZr7vxlik+4kNcdHXkE9kMRdfMKPFoc
	 mp1Ug4cqycxKw==
X-ME-Helo: [172.16.82.72]
X-ME-Auth: bWFpbGhvbC52aW5jZW50QHdhbmFkb28uZnI=
X-ME-Date: Fri, 28 Mar 2025 12:05:48 +0100
X-ME-IP: 124.33.176.97
Message-ID: <98b10d18-89ae-4fef-b9e3-f548b88c616f@wanadoo.fr>
Date: Fri, 28 Mar 2025 20:05:40 +0900
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 09/18] can: rcar_canfd: Add max_aflpn variable to
 struct rcar_canfd_hw_info
To: Biju Das <biju.das.jz@bp.renesas.com>,
 Marc Kleine-Budde <mkl@pengutronix.de>
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>,
 Geert Uytterhoeven <geert+renesas@glider.be>,
 =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>,
 linux-can@vger.kernel.org,
 Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>,
 Biju Das <biju.das.au@gmail.com>, linux-renesas-soc@vger.kernel.org
References: <20250326122003.122976-1-biju.das.jz@bp.renesas.com>
 <20250326122003.122976-10-biju.das.jz@bp.renesas.com>
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
In-Reply-To: <20250326122003.122976-10-biju.das.jz@bp.renesas.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 26/03/2025 at 21:19, Biju Das wrote:
> R-Car Gen3 has maximum acceptance filter list page number of 31 whereas on
> R-Car Gen4 it is 127. Add max_aflpn variable to struct rcar_canfd_hw_info
> in order to support RZ/G3E that has max AFLPN of 63.
> 
> Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
> Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>

With below nitpick addressed, you can add my:

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
> index 62cde1efa0c0..7cef0673fbc8 100644
> --- a/drivers/net/can/rcar/rcar_canfd.c
> +++ b/drivers/net/can/rcar/rcar_canfd.c
> @@ -93,7 +93,7 @@
>  
>  /* RSCFDnCFDGAFLECTR / RSCFDnGAFLECTR */
>  #define RCANFD_GAFLECTR_AFLDAE		BIT(8)
> -#define RCANFD_GAFLECTR_AFLPN(gpriv, x)	((x) & reg_gen4(gpriv, 0x7f, 0x1f))
> +#define RCANFD_GAFLECTR_AFLPN(gpriv, x)	((x) & (gpriv)->info->max_aflpn)
                                        ^
While at it, can you rename that x to page_num in the next version? I
don't mind if you do it in the same patch.

I understand it was here before, but that's will be a nice quality of
life improvement.

Please do the same for the other macro which you are modifying  in this
series (I am not asking you to rewrite the full driver, so only do local
improvement on the parts you are touching).

>  /* RSCFDnCFDGAFLIDj / RSCFDnGAFLIDj */
>  #define RCANFD_GAFLID_GAFLLB		BIT(29)
> @@ -507,6 +507,7 @@ struct rcar_canfd_hw_info {
>  	u16 num_supported_rules;
>  	u8 rnc_stride;
>  	u8 rnc_field_width;
> +	u8 max_aflpn;
>  	u8 max_channels;
>  	u8 postdiv;
>  	/* hardware features */
> @@ -586,6 +587,7 @@ static const struct rcar_canfd_hw_info rcar_gen3_hw_info = {
>  	.num_supported_rules = 256,
>  	.rnc_stride = 4,
>  	.rnc_field_width = 8,
> +	.max_aflpn = 31,
>  	.max_channels = 2,
>  	.postdiv = 2,
>  	.shared_global_irqs = 1,
> @@ -595,6 +597,7 @@ static const struct rcar_canfd_hw_info rcar_gen4_hw_info = {
>  	.num_supported_rules = 512,
>  	.rnc_stride = 2,
>  	.rnc_field_width = 16,
> +	.max_aflpn = 127,
>  	.max_channels = 8,
>  	.postdiv = 2,
>  	.shared_global_irqs = 1,
> @@ -604,6 +607,7 @@ static const struct rcar_canfd_hw_info rzg2l_hw_info = {
>  	.num_supported_rules = 256,
>  	.rnc_stride = 4,
>  	.rnc_field_width = 8,
> +	.max_aflpn = 31,
>  	.max_channels = 2,
>  	.postdiv = 1,
>  	.multi_channel_irqs = 1,


Yours sincerely,
Vincent Mailhol


