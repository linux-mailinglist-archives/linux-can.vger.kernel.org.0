Return-Path: <linux-can+bounces-1215-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DD4F962D7C
	for <lists+linux-can@lfdr.de>; Wed, 28 Aug 2024 18:16:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4FCD61C227CE
	for <lists+linux-can@lfdr.de>; Wed, 28 Aug 2024 16:16:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD9591A2C0F;
	Wed, 28 Aug 2024 16:16:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RdaKJ+g0"
X-Original-To: linux-can@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 751521A254B;
	Wed, 28 Aug 2024 16:16:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724861789; cv=none; b=m9QzOysWWy9Sp60dXxakDFUEl4Y9DH4axM6Otb0JbVOCfwHBZ4R8Xw3dYrMWbKO3aFWQGz4pUTxPMfjYnfVFd1dr/vu4PjRQY9ACyA9140rznDO8PoG+QjmnMG3t5a+LVfmdxNPYkkE1oul8jI9QnCnDW6zm9lGJxCA5/EsFc7k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724861789; c=relaxed/simple;
	bh=5ehrFnCc+o7/6cA9eQPVNURWyEXSWTlwyaEFrwFQhZc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=a9SGPkFoNZo19bfUJCSpRmbxk3HOq0TJjklfqn5ehbRaiBWvTDW2aCTOl1L2F9XkVK0o1W+MgUktO/kzE1XFGvrZxn8fQ0HEN3qI92x5cntPU3ZV6/7c3PrjJtc/W7hqEGw0XXKfWOFjIi1EKSL7boB9Zcf2GIj/0C3u1w5BvKs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RdaKJ+g0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B4A4C4FF6C;
	Wed, 28 Aug 2024 16:16:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724861789;
	bh=5ehrFnCc+o7/6cA9eQPVNURWyEXSWTlwyaEFrwFQhZc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=RdaKJ+g0foDLngSIME/eH0SuqkPcXepecMqvquw7sJANaAgAS9Jlw97jeTif2NKsw
	 dZ+5UTnLcUoJ1ad5+UU8Cs0TTCJTQr9NmPv8D5bkp2FtIDe9LWp5qHQELGWy4atngv
	 AII4OxkStsPAd86xz6bq30kOMopxtk3kEWlo5jlmfz9xuZmobwDAHofgWqimNoFbrh
	 X2UNFAUl6JjF2DvZEGrKJ2WrMT4+9Jmf1PbB52pPxBJbgj2kBQds1RreQ9UH82b/4V
	 ags+Fj0rpLo9WcAFAzUweELdXdH2heMxMR0vNc5+HT01o5KN9IHjg+IpygLe4q5elJ
	 fRK7re4LGYjSA==
Date: Wed, 28 Aug 2024 17:16:24 +0100
From: Simon Horman <horms@kernel.org>
To: "Rob Herring (Arm)" <robh@kernel.org>
Cc: Marc Kleine-Budde <mkl@pengutronix.de>,
	Vincent Mailhol <mailhol.vincent@wanadoo.fr>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	linux-can@vger.kernel.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net: can: cc770: Simplify parsing DT properties
Message-ID: <20240828161624.GS1368797@kernel.org>
References: <20240828131902.3632167-1-robh@kernel.org>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240828131902.3632167-1-robh@kernel.org>

On Wed, Aug 28, 2024 at 08:19:02AM -0500, Rob Herring (Arm) wrote:
> Use of the typed property accessors is preferred over of_get_property().
> The existing code doesn't work on little endian systems either. Replace
> the of_get_property() calls with of_property_read_bool() and
> of_property_read_u32().
> 
> Signed-off-by: Rob Herring (Arm) <robh@kernel.org>

...

> diff --git a/drivers/net/can/cc770/cc770_platform.c b/drivers/net/can/cc770/cc770_platform.c
> index 13bcfba05f18..9993568154f8 100644
> --- a/drivers/net/can/cc770/cc770_platform.c
> +++ b/drivers/net/can/cc770/cc770_platform.c
> @@ -71,16 +71,9 @@ static int cc770_get_of_node_data(struct platform_device *pdev,
>  				  struct cc770_priv *priv)
>  {
>  	struct device_node *np = pdev->dev.of_node;
> -	const u32 *prop;
> -	int prop_size;
> -	u32 clkext;
> -
> -	prop = of_get_property(np, "bosch,external-clock-frequency",
> -			       &prop_size);
> -	if (prop && (prop_size ==  sizeof(u32)))
> -		clkext = *prop;
> -	else
> -		clkext = CC770_PLATFORM_CAN_CLOCK; /* default */
> +	u32 clkext = CC770_PLATFORM_CAN_CLOCK, clkout = 0;

Marc,

Could you clarify if reverse xmas tree ordering - longest line to shortest
- of local variables is desired for can code? If so, I'm flagging that the
above now doesn't follow that scheme.

> +
> +	of_property_read_u32(np, "bosch,external-clock-frequency", &clkext);
>  	priv->can.clock.freq = clkext;
>  
>  	/* The system clock may not exceed 10 MHz */

...

> @@ -109,20 +102,16 @@ static int cc770_get_of_node_data(struct platform_device *pdev,
>  	if (of_property_read_bool(np, "bosch,polarity-dominant"))
>  		priv->bus_config |= BUSCFG_POL;
>  
> -	prop = of_get_property(np, "bosch,clock-out-frequency", &prop_size);
> -	if (prop && (prop_size == sizeof(u32)) && *prop > 0) {
> -		u32 cdv = clkext / *prop;
> -		int slew;
> +	of_property_read_u32(np, "bosch,clock-out-frequency", &clkout);
> +	if (clkout > 0) {
> +		u32 cdv = clkext / clkout;
> +		u32 slew;
>  
>  		if (cdv > 0 && cdv < 16) {
>  			priv->cpu_interface |= CPUIF_CEN;
>  			priv->clkout |= (cdv - 1) & CLKOUT_CD_MASK;
>  
> -			prop = of_get_property(np, "bosch,slew-rate",
> -					       &prop_size);
> -			if (prop && (prop_size == sizeof(u32))) {
> -				slew = *prop;
> -			} else {
> +			if (of_property_read_u32(np, "bosch,slew-rate", &slew)) {
>  				/* Determine default slew rate */
>  				slew = (CLKOUT_SL_MASK >>
>  					CLKOUT_SL_SHIFT) -

Rob,

The next few lines look like this:

					((cdv * clkext - 1) / 8000000);
				if (slew < 0)
					slew = 0;

But slew is now unsigned, so this check will always be false.

Flagged by Smatch and Coccinelle.

