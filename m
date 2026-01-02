Return-Path: <linux-can+bounces-5988-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F8F9CEE517
	for <lists+linux-can@lfdr.de>; Fri, 02 Jan 2026 12:20:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 40D13300CAC6
	for <lists+linux-can@lfdr.de>; Fri,  2 Jan 2026 11:20:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8258C2ECE9B;
	Fri,  2 Jan 2026 11:20:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uXXfL7Kr"
X-Original-To: linux-can@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4832B2E975E;
	Fri,  2 Jan 2026 11:20:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767352854; cv=none; b=Q8T4Ywp46iQWlgm1UdE5/747GoUiKVN4ia5hoVfZKLnlmMx9zWu8tPYpJJc0SZZrXuIAj2VAMqu2UxoEkPgYN4QhBOsykjEM5oXjMhAVxqx6r/C/y9M3+xdHbTMfUGOyP0iJ+C9i5xlGO1SICp6hbJ6VP7WGG/pS/WMG1JP0Iic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767352854; c=relaxed/simple;
	bh=u6hETDAuISK+fNO4VLe+M3TNxNATCr+wZAZBO4GtxbQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jWWHW3UQASa8YIrWIVYrVH4FhdM5Ik3QxbuWXTxbPOAsPQkGTR7/7nqsMMZq5oYYcvq9aSHdvL6k3DvV2Nhh2pAwe0QHMmdt9v2G/bMjYc6dkC0kUtRK1XCV+2clh4Q3coAP3fZHzUK/rE8NMxecQQXXK4arITbeEsMGy/hAO98=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uXXfL7Kr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4CD21C16AAE;
	Fri,  2 Jan 2026 11:20:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767352853;
	bh=u6hETDAuISK+fNO4VLe+M3TNxNATCr+wZAZBO4GtxbQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=uXXfL7Krh9mN+DG0dl2vxhlgBbrqraSEF10sOgCa7NYgm4I5XrLnEcZX7n6/ibuvI
	 sp+ABcdG6PaUl9lIGqei5ZS/Pqe58/WVMC1n3I6heQeTSOrzrtc1MZDxCWiszflm1G
	 6LcT9KzNMbHp1in2MWPq062e4vw0Qt4c2DCOlG213x3h8SX4UO3sotXyhqne3T3F12
	 W6pdYevZ22IiagOylgopM64vzyi8P25eF3SIrNZAsWsv0dl2b7jOjz4Kpliox4RGdW
	 5uK0AfLtW8AZW+2dooJ03Mozxlsph3so4wP3h1myR0ZWDzidK/fsQsyVHWzni8r+6/
	 jjHDvRW8/XszA==
Date: Fri, 2 Jan 2026 12:20:51 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Prabhakar <prabhakar.csengg@gmail.com>
Cc: Marc Kleine-Budde <mkl@pengutronix.de>, 
	Vincent Mailhol <mailhol@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Geert Uytterhoeven <geert+renesas@glider.be>, Magnus Damm <magnus.damm@gmail.com>, 
	Biju Das <biju.das.jz@bp.renesas.com>, linux-can@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Fabrizio Castro <fabrizio.castro.jz@renesas.com>, Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: Re: [PATCH v2 3/4] dt-bindings: can: renesas,rcar-canfd: Document
 RZ/T2H and RZ/N2H SoCs
Message-ID: <20260102-petite-gentle-wasp-81bbb8@quoll>
References: <20251230115814.53536-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20251230115814.53536-4-prabhakar.mahadev-lad.rj@bp.renesas.com>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20251230115814.53536-4-prabhakar.mahadev-lad.rj@bp.renesas.com>

On Tue, Dec 30, 2025 at 11:58:13AM +0000, Prabhakar wrote:
> From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> 
> Document the CAN-FD controller used on the RZ/T2H and RZ/N2H SoCs. The
> CAN-FD IP is largely compatible with the R-Car Gen4 block, but differs
> in that AFLPN and CFTML are different, there is no reset line for the IP,
> and it only supports two channels.
> 
> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> ---
> v1->v2:
> - No changes made.
> ---
>  .../bindings/net/can/renesas,rcar-canfd.yaml  | 26 ++++++++++++++++++-
>  1 file changed, 25 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/net/can/renesas,rcar-canfd.yaml b/Documentation/devicetree/bindings/net/can/renesas,rcar-canfd.yaml
> index fb709cfd26d7..4a83e9e34d67 100644
> --- a/Documentation/devicetree/bindings/net/can/renesas,rcar-canfd.yaml
> +++ b/Documentation/devicetree/bindings/net/can/renesas,rcar-canfd.yaml
> @@ -50,6 +50,12 @@ properties:
>                - renesas,r9a09g057-canfd     # RZ/V2H(P)
>            - const: renesas,r9a09g047-canfd
>  
> +      - const: renesas,r9a09g077-canfd      # RZ/T2H


That's part of other enum with single compatibles.

> +
> +      - items:
> +          - const: renesas,r9a09g087-canfd  # RZ/N2H
> +          - const: renesas,r9a09g077-canfd
> +
>    reg:
>      maxItems: 1
>  
> @@ -179,7 +185,6 @@ required:
>    - clocks
>    - clock-names
>    - power-domains
> -  - resets
>    - assigned-clocks
>    - assigned-clock-rates
>    - channel0
> @@ -243,11 +248,30 @@ allOf:
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

Why is this de-synced with reset-names? Properties are supposed to
behave the same way, not once requiring resets other time requiring
reset-names.

Best regards,
Krzysztof


