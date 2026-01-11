Return-Path: <linux-can+bounces-6102-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E660DD0E8CE
	for <lists+linux-can@lfdr.de>; Sun, 11 Jan 2026 11:14:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id B2DEA30042A4
	for <lists+linux-can@lfdr.de>; Sun, 11 Jan 2026 10:14:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82B613314AE;
	Sun, 11 Jan 2026 10:14:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iokG0QTF"
X-Original-To: linux-can@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D28131A7F2;
	Sun, 11 Jan 2026 10:14:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768126444; cv=none; b=djLG4cMTZBwm4fxyYxiS+oeqJYsa6qsQpXq317IZIiIQWZTrHtN0ZblPo90SflkSfuwlNWZ0jJJNgZH6kcgTsCClOfBMFtrpcVT3wWiJUBt19UADNVj3gYWpsyJMfMqg+80XM6FZ1vI6yWCSTSKxT7vuaGzNvmnEVmrS0CjZVfs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768126444; c=relaxed/simple;
	bh=+ccDl6GqNO0RiMjeEsYI8eRopFN+kfLgKVq8/MDfBxw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Lm2kElwicZ66lRMoFrhyA/7YC802E1H3duk0C18f58HGAncNANMwPTrWBQ0TulJJ6YGtRGmUXK43V61mHV1LWoNDZEeyQlikOqE5whz4c3FwazQRaRJVmU3qvbepCxSDcyLJWwd7AYxZ5WZ1ojCnKeh91k3rgJbiuu5LndvK+wA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iokG0QTF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A690DC4CEF7;
	Sun, 11 Jan 2026 10:14:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768126444;
	bh=+ccDl6GqNO0RiMjeEsYI8eRopFN+kfLgKVq8/MDfBxw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=iokG0QTF5DIM2uGPbR1fnatLOOBE8OGwLVHFdi60UjVWd84KmjJzjK1lek1X/KWg8
	 0ylkRVc2dz7bNqp1DDxdtB/IxH8S1kCNnKY/RkfxbUY2MB7AHOB3zU2j9niCHADxmS
	 HzlzMmBj58i25BcLQkPLD943X2q9NSeJvV3YP15APnKYs4uLXDX2mgqkxPySBkTzOW
	 bhFB06y/6+POfrQPP9dRl9XuqWk0fyqnhxum1AXbPzTfbHcUGsIcwmWXPYiiDebuG1
	 40UB+u3hzYqUpzVg9AxGeblJTiffKf+kk2BW1r/0VRdvhGaSEo83kGIF8p9DZjEXVl
	 toAXXVO8fPHog==
Date: Sun, 11 Jan 2026 11:14:01 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Prabhakar <prabhakar.csengg@gmail.com>
Cc: Marc Kleine-Budde <mkl@pengutronix.de>, 
	Vincent Mailhol <mailhol@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Geert Uytterhoeven <geert+renesas@glider.be>, Magnus Damm <magnus.damm@gmail.com>, linux-can@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Biju Das <biju.das.jz@bp.renesas.com>, Fabrizio Castro <fabrizio.castro.jz@renesas.com>, 
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: Re: [PATCH v3 3/4] dt-bindings: can: renesas,rcar-canfd: Document
 RZ/T2H and RZ/N2H SoCs
Message-ID: <20260111-poetic-dark-butterfly-97993f@quoll>
References: <20260109125128.2474156-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20260109125128.2474156-4-prabhakar.mahadev-lad.rj@bp.renesas.com>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260109125128.2474156-4-prabhakar.mahadev-lad.rj@bp.renesas.com>

On Fri, Jan 09, 2026 at 12:51:27PM +0000, Prabhakar wrote:
> From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> 
> Document the CAN-FD controller used on the RZ/T2H and RZ/N2H SoCs. The
> CAN-FD IP is largely compatible with the R-Car Gen4 block, but differs
> in that AFLPN and CFTML are different, there is no reset line for the IP,
> and it only supports two channels.
> 
> The schema already enforces reset-names only for RZ/G2L and RZ/G3E and
> disallows it for all other SoCs, so only the resets property is explicitly
> marked as unsupported for RZ/T2H and RZ/N2H.
> 
> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---
> v2->v3:
> - Grouped single compatible entries into an enum.
> - Updated commit message about disallowing reset-names property.
> - Added Reviewed-by tag.
> 
> v1->v2:
> - No changes made.
> ---
>  .../bindings/net/can/renesas,rcar-canfd.yaml  | 29 +++++++++++++++++--
>  1 file changed, 27 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/net/can/renesas,rcar-canfd.yaml b/Documentation/devicetree/bindings/net/can/renesas,rcar-canfd.yaml
> index fb709cfd26d7..ceb072e0a304 100644
> --- a/Documentation/devicetree/bindings/net/can/renesas,rcar-canfd.yaml
> +++ b/Documentation/devicetree/bindings/net/can/renesas,rcar-canfd.yaml
> @@ -42,7 +42,10 @@ properties:
>                - renesas,r9a07g054-canfd    # RZ/V2L
>            - const: renesas,rzg2l-canfd     # RZ/G2L family
>  
> -      - const: renesas,r9a09g047-canfd     # RZ/G3E
> +      - items:

The convention is enum and that's what I asked. I know it is a nit, but
if I give review now for this code which I disagreed, my disagreement
won't be ever recorded and people in future work will base on this less
preferred syntax.

So again:

- enum:
    - foo
    - bar

> +          - enum:
> +              - renesas,r9a09g047-canfd    # RZ/G3E
> +              - renesas,r9a09g077-canfd    # RZ/T2H
>  
>        - items:
>            - enum:
> @@ -50,6 +53,10 @@ properties:
>                - renesas,r9a09g057-canfd     # RZ/V2H(P)
>            - const: renesas,r9a09g047-canfd
>  
> +      - items:
> +          - const: renesas,r9a09g087-canfd  # RZ/N2H
> +          - const: renesas,r9a09g077-canfd
> +
>    reg:
>      maxItems: 1
>  
> @@ -179,7 +186,6 @@ required:
>    - clocks
>    - clock-names
>    - power-domains
> -  - resets
>    - assigned-clocks
>    - assigned-clock-rates
>    - channel0
> @@ -243,11 +249,30 @@ allOf:
>            minItems: 2
>            maxItems: 2
>  
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            const: renesas,r9a09g077-canfd
> +    then:
> +      properties:
> +        interrupts:
> +          maxItems: 8
> +
> +        interrupt-names:
> +          maxItems: 8
> +
> +        resets: false
> +    else:
> +      required:
> +        - resets

I do not think you are making this binding easy to maintain. You have
now multiple separate ifs AND two ifs with "else:" condition. Try to
understand which condition/description applies to "rcar-gen3". Does it
require resets? Let's look for the compatible in the file - you find
"if:" block requiring reset-names but no "require" for resets. Odd.

As I said last time, these should be alwaysy synced.

The binding was not in a good shape before but you are not improving it.

Best regards,
Krzysztof


