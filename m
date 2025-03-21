Return-Path: <linux-can+bounces-3191-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 34473A6B3AB
	for <lists+linux-can@lfdr.de>; Fri, 21 Mar 2025 05:28:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 65C113AC23D
	for <lists+linux-can@lfdr.de>; Fri, 21 Mar 2025 04:27:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE12F1E376E;
	Fri, 21 Mar 2025 04:27:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="KxUvipl/"
X-Original-To: linux-can@vger.kernel.org
Received: from out.smtpout.orange.fr (out-72.smtpout.orange.fr [193.252.22.72])
	(using TLSv1.2 with cipher AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7ABCB664;
	Fri, 21 Mar 2025 04:27:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.252.22.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742531270; cv=none; b=HMkS6pLZy1ZSVBTOCj48lgXaQTLjk/JW8+yB1R/5d8S6gbbCBP9F4X8XnLmymCdTxbXY83n8GFlrBrQdpmO+r9CDQ7hmYx34Y5Mh7FjshJLXVRHu7GzCsKKuoFrMPjvt3+aamfN8rzYwyJfF1cObCrKqo0k1SSWPP769MK3e4X8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742531270; c=relaxed/simple;
	bh=C7HXbRAAikkBwHspUHiehLT+PSVXQ2/fzwqlCI0p5vc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WkWcEUYOp/z0NXwodu0xB+fIQJrnMERQuZQYJo8t5ja2ZVb0Iur0KHgkbhUk4AuwQx6iyGfKNA99jsZK2ghKAsa6wa4mcOxreKM7xENvQAmcONAgonxh+DjWUXzvGXjLmSLdSvydddHC6ShE5lMLH/LnR3MCxlI+dh48zdbpjrc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=wanadoo.fr; dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b=KxUvipl/; arc=none smtp.client-ip=193.252.22.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Received: from [172.16.82.72] ([124.33.176.97])
	by smtp.orange.fr with ESMTPA
	id vTpqtuCVJpih5vTpvtXDey; Fri, 21 Mar 2025 05:18:29 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1742530710;
	bh=RfTovQ5pBBPXl/sQntAxGWbDNnwENYAK9Bt2Ch93r58=;
	h=Message-ID:Date:MIME-Version:Subject:To:From;
	b=KxUvipl/mBH9mc3/+Jxp2x1493gZQeZOd7O1dWUrPtM6thSRht5eemzsz0bAhoVki
	 UK6CTEtCyIr0B2njVsiL/Rbr4irCB0+2uOw5H+lalCF9jyZTppgCSLooDDJSUxSqiP
	 KLwOa3oQaBRKfU1w7HcWDEh8qDV9uKdiX8SEa3TJYLNcfQMoUqnv/Y+c4nKoVmstXw
	 QtOzdhj2FmatopgmqctXNjsEuD+W5CATzJW4ecmjZKK+YxcyTexp8CHwQ510jgHD3x
	 Q85cTm7l4Tdfae2YGjxEcK0z2m8NKPbDmVd5zGOqFiHSeZzl8e/qDzEFkGwqSLiRK8
	 h/GCI4MlrBSDQ==
X-ME-Helo: [172.16.82.72]
X-ME-Auth: bWFpbGhvbC52aW5jZW50QHdhbmFkb28uZnI=
X-ME-Date: Fri, 21 Mar 2025 05:18:30 +0100
X-ME-IP: 124.33.176.97
Message-ID: <7805e0db-7c17-438d-9985-f4feec644da6@wanadoo.fr>
Date: Fri, 21 Mar 2025 13:18:18 +0900
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] phy: can-transceiver: Re-instate "mux-states" property
 presence check
To: Geert Uytterhoeven <geert+renesas@glider.be>,
 Rob Herring <robh@kernel.org>
Cc: linux-can@vger.kernel.org, linux-phy@lists.infradead.org,
 linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
 Marc Kleine-Budde <mkl@pengutronix.de>, Vinod Koul <vkoul@kernel.org>,
 Kishon Vijay Abraham I <kishon@kernel.org>, Peter Rosin <peda@axentia.se>,
 Aswath Govindraju <a-govindraju@ti.com>,
 Biju Das <biju.das.jz@bp.renesas.com>
References: <3d7e0d723908284e8cf06ad1f7950c03173178f3.1742483710.git.geert+renesas@glider.be>
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
In-Reply-To: <3d7e0d723908284e8cf06ad1f7950c03173178f3.1742483710.git.geert+renesas@glider.be>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 21/03/2025 at 00:15, Geert Uytterhoeven wrote:
> On the Renesas Gray Hawk Single development board:
> 
>     can-transceiver-phy can-phy0: /can-phy0: failed to get mux-state (0)
> 
> "mux-states" is an optional property for CAN transceivers.  However,
> mux_get() always prints an error message in case of an error, including
> when the property is not present, confusing the user.
> 
> Fix this by re-instating the property presence check (this time using
> the proper API) in a wrapper around devm_mux_state_get().  When the
> multiplexer subsystem gains support for optional muxes, the wrapper can
> just be removed.
> 
> In addition, propagate all real errors upstream, instead of ignoring
> them.

I would like to hear Rob's opinion on this. In d02dfd4ceb2e9f34 Rob
purposely changed the function to ignore errors other than EPROBE_DEFER.

Right now, I do not see a reason not to propagate the other errors, so
I am in favor of this roll back. But maybe we are missing something?

Otherwise, the patch looks good to me. Nice improvement over the v1. I
will wait for Rob's comment to give my review tag.

> Fixes: d02dfd4ceb2e9f34 ("phy: can-transceiver: Drop unnecessary "mux-states" property presence check")
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---
> Alternatively, the multiplexer subsystem needs to gain support for
> getting an optional mux...
> 
> v2:
>   - Add and use devm_mux_state_get_optional(),
>   - No given tags added, as the new solution is different.
> ---
>  drivers/phy/phy-can-transceiver.c | 22 +++++++++++++++-------
>  1 file changed, 15 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/phy/phy-can-transceiver.c b/drivers/phy/phy-can-transceiver.c
> index 2bec70615449f94d..f59caff4b3d4c267 100644
> --- a/drivers/phy/phy-can-transceiver.c
> +++ b/drivers/phy/phy-can-transceiver.c
> @@ -93,6 +93,16 @@ static const struct of_device_id can_transceiver_phy_ids[] = {
>  };
>  MODULE_DEVICE_TABLE(of, can_transceiver_phy_ids);
>  
> +/* Temporary wrapper until the multiplexer subsystem supports optional muxes */
> +static inline struct mux_state *
> +devm_mux_state_get_optional(struct device *dev, const char *mux_name)
> +{
> +	if (!of_property_present(dev->of_node, "mux-states"))
> +		return NULL;
> +
> +	return devm_mux_state_get(dev, mux_name);
> +}
> +
>  static int can_transceiver_phy_probe(struct platform_device *pdev)
>  {
>  	struct phy_provider *phy_provider;
> @@ -114,13 +124,11 @@ static int can_transceiver_phy_probe(struct platform_device *pdev)
>  	match = of_match_node(can_transceiver_phy_ids, pdev->dev.of_node);
>  	drvdata = match->data;
>  
> -	mux_state = devm_mux_state_get(dev, NULL);
> -	if (IS_ERR(mux_state)) {
> -		if (PTR_ERR(mux_state) == -EPROBE_DEFER)> -			return PTR_ERR(mux_state);
> -	} else {
> -		can_transceiver_phy->mux_state = mux_state;
> -	}
> +	mux_state = devm_mux_state_get_optional(dev, NULL);
> +	if (IS_ERR(mux_state))
> +		return PTR_ERR(mux_state);
> +
> +	can_transceiver_phy->mux_state = mux_state;
>  
>  	phy = devm_phy_create(dev, dev->of_node,
>  			      &can_transceiver_phy_ops);

Yours sincerely,
Vincent Mailhol


