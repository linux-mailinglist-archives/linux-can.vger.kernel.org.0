Return-Path: <linux-can+bounces-4487-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C5C9AB45052
	for <lists+linux-can@lfdr.de>; Fri,  5 Sep 2025 09:52:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DA1A53A6E3C
	for <lists+linux-can@lfdr.de>; Fri,  5 Sep 2025 07:52:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 188792F0671;
	Fri,  5 Sep 2025 07:52:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PokDf1fI"
X-Original-To: linux-can@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7E1F2EAD05;
	Fri,  5 Sep 2025 07:52:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757058743; cv=none; b=gWi216H1EmlIjarCdA5zr0heHIuHvMpTaDPDmWCREP0xwGNy0vTa6Ej0q3zEW9bR/P0DICT4KCaxbh8rz1QrmfLy9pjJvG3T3uA1z9Hu7cG/NXndoIZBHi1ZvUgBP5Wk1Tp+LzPoun8FXH95ucDsz0Sj2sO271rv7Xmj8vMe+fY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757058743; c=relaxed/simple;
	bh=Wf9m/dqTEtlJyt6WAhKzaW88Y/FSRjgusk/yxfNl3ME=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EzoXWqb1gFmUlwOjk2xI6q3K8tk1AlsfzpUj9XRuUARy16Rcjn2jvg+j+DldPrtRpBEQB+H2MwfNO+tgSNxECcUSx8+2wg5/G/5KS/wASxBcFtTBPnayQGz6qn+41l0DGPvNw9kxcE7mfnvI5CIj4oQFQFRGdTOcIGct8VBG7YI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PokDf1fI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CED12C4CEF1;
	Fri,  5 Sep 2025 07:52:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757058742;
	bh=Wf9m/dqTEtlJyt6WAhKzaW88Y/FSRjgusk/yxfNl3ME=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=PokDf1fI8lHcYnnnNnkfnD9eoHOYMme+d8PieowgfYCm9lyo9OhHIWdNyJE/kG3iS
	 jBVU3qgdWWjJrfWp6A/rBLe/N7EtGRlFbCdnK/qWMgu/rRDnOY19eXHccJr3i5kzLF
	 lImkVOyL9X26QNefgqUwFufn2m0NDqi3keOdQJHQRKzJ3328h4c7lXSvSFpfPxNjX1
	 VFDJ4o0kaeVF6vk6ZD3voU2kPzrle/4E167LSxC4+gCH+xqIMKP3aOPkIc1XKkrwkH
	 5JaDBIpSE2dS23NmcHzh1b0Heyb/86/ljIE2DHlsab2SRsq0O75Lqt5aq80KPT0l6d
	 yZHerR9GLaj3Q==
Date: Fri, 5 Sep 2025 09:52:19 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Peng Fan <peng.fan@nxp.com>
Cc: Marc Kleine-Budde <mkl@pengutronix.de>, 
	Vincent Mailhol <mailhol.vincent@wanadoo.fr>, Vinod Koul <vkoul@kernel.org>, 
	Kishon Vijay Abraham I <kishon@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Aswath Govindraju <a-govindraju@ti.com>, Shawn Guo <shawnguo@kernel.org>, 
	Sascha Hauer <s.hauer@pengutronix.de>, Pengutronix Kernel Team <kernel@pengutronix.de>, 
	Fabio Estevam <festevam@gmail.com>, Frank Li <frank.li@nxp.com>, Haibo Chen <haibo.chen@nxp.com>, 
	linux-can@vger.kernel.org, linux-phy@lists.infradead.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v5 1/9] dt-bindings: phy: ti,tcan104x-can: Document NXP
 TJA105X/1048
Message-ID: <20250905-elite-enthusiastic-zebu-fec55c@kuoka>
References: <20250904-can-v5-0-23d8129b5e5d@nxp.com>
 <20250904-can-v5-1-23d8129b5e5d@nxp.com>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250904-can-v5-1-23d8129b5e5d@nxp.com>

On Thu, Sep 04, 2025 at 04:36:44PM +0800, Peng Fan wrote:
> The TJA1048 is a dual high-speed CAN transceiver with sleep mode supported
> and no EN pin.
> 
> The TJA1051 is a high-speed CAN transceiver with slient mode supported,
> but only TJA1051T/E has EN pin. To make it simple, make enable-gpios as
> optional for TJA1051.
> 
> The TJA1057 is a high-speed CAN transceiver with slient mode supported
> and no EN pin.
> 
> Signed-off-by: Peng Fan <peng.fan@nxp.com>
> ---
>  .../devicetree/bindings/phy/ti,tcan104x-can.yaml   | 69 +++++++++++++++++++++-
>  1 file changed, 66 insertions(+), 3 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/phy/ti,tcan104x-can.yaml b/Documentation/devicetree/bindings/phy/ti,tcan104x-can.yaml
> index 4a8c3829d85d3c4a4963750d03567c1c345beb91..124493f360516eb203e8711cb96789258dd01119 100644
> --- a/Documentation/devicetree/bindings/phy/ti,tcan104x-can.yaml
> +++ b/Documentation/devicetree/bindings/phy/ti,tcan104x-can.yaml
> @@ -22,16 +22,26 @@ properties:
>        - enum:
>            - ti,tcan1042
>            - ti,tcan1043
> +          - nxp,tja1048
> +          - nxp,tja1051
> +          - nxp,tja1057
>            - nxp,tjr1443
>  
>    '#phy-cells':
> -    const: 0
> +    enum: [0, 1]
>  
> -  standby-gpios:
> +  silent-gpios:
>      description:
> -      gpio node to toggle standby signal on transceiver
> +      gpio node to toggle silent signal on transceiver
>      maxItems: 1
>  
> +  standby-gpios:
> +    description:
> +      gpio node to toggle standby signal on transceiver. For two Items, item 1
> +      is for stbn1, item 2 is for stbn2.
> +    minItems: 1
> +    maxItems: 2
> +
>    enable-gpios:
>      description:
>        gpio node to toggle enable signal on transceiver
> @@ -53,6 +63,59 @@ required:
>    - compatible
>    - '#phy-cells'
>  
> +allOf:
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            const: nxp,tja1048
> +    then:
> +      properties:
> +        '#phy-cells':
> +          const: 1
> +        enable-gpios: false
> +        silent-gpios: false
> +        standby-gpios:
> +          minItems: 2
> +    else:
> +      properties:
> +        '#phy-cells':
> +          const: 0
> +        standby-gpios:
> +          maxItems: 1
> +
> +  - if:
> +      properties:
> +        compatible:
> +          enum:
> +            - nxp,tja1051
> +            - nxp,tja1057
> +    then:
> +      properties:
> +        silent-gpios: true
> +    else:
> +      properties:
> +        silent-gpios: false
> +
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            const: nxp,tja1051

This is here and in if earlier. Just keep in only one place. Also
earlier else also touches standby-gpios, so you basically have it in
multiple places.

Just define if:then:, without any else:, for each variant.

> +    then:
> +      properties:
> +        standby-gpios: false
> +
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            const: nxp,tja1057

This as well.

> +    then:
> +      properties:
> +        enable-gpios: false
> +        standby-gpios: false
> +
>  additionalProperties: false
>  
>  examples:
> 
> -- 
> 2.37.1
> 

