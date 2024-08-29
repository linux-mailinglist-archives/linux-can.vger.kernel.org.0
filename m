Return-Path: <linux-can+bounces-1218-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CBE28964D7F
	for <lists+linux-can@lfdr.de>; Thu, 29 Aug 2024 20:13:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 13E041C21B9E
	for <lists+linux-can@lfdr.de>; Thu, 29 Aug 2024 18:13:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B430F1B5EC8;
	Thu, 29 Aug 2024 18:13:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pFLwFXLp"
X-Original-To: linux-can@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B3FD14B086;
	Thu, 29 Aug 2024 18:13:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724955215; cv=none; b=Uzdivgu1sEH13YIoaIVOrT3ZszYXYZ73Ym16xWuwnyQUNRnO0l/6ekr66OvMmzrV6WumkywhnAkhmzj8XzANDZzm9DpA2qOTiTVrx0GNvi8ekWray1Cv/dG6QuxgddXuA+9ri+//KzeUnbNHuzg3Ac7r7la+Hbe/3T3pPSTyrQY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724955215; c=relaxed/simple;
	bh=6ZMa9h2VTobODNOsYJeJxc9Xk8h0cW0u66Ff2U8Cr/8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nEyzPuiOFMX4XDywVIzwQVSvj9aRWkrvERGficPUSkBW5X0wYVYdLBrzOXnG0DNNUa2N9Uy9kTYNGIHU3v5XWFvUy6BBmOfCx/12OBfGtBHmSyFtUNxVYcj2Pgjn+LwJLtyQiZDBT+GgUPbs/T1ibsMnSsYVmQVB+D+A2PcNU00=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pFLwFXLp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7BE5AC4CEC1;
	Thu, 29 Aug 2024 18:13:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724955215;
	bh=6ZMa9h2VTobODNOsYJeJxc9Xk8h0cW0u66Ff2U8Cr/8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=pFLwFXLphGK1H8TeghkFhFBpA2dXKWQ6N2/sudFMJBc48I97MASMG12Y14bu5aKDn
	 BD0jmCCLmRCBkFkDEeq39kYWseQJ3DZSBSOKxOPp3oDF5Vaq3I7ZDTjvbtw5TW4MeL
	 DUFSQfOmXxpbod9cKyNjitZSxV0MuE5RK2MDgQhvVIuImi/Ks+oHioJh9M7pK+lfZQ
	 bG+OEzzIB8ZsAKpIMSvM42or8vd69IVjCXQ7siVmHvwrhbRTYGXh/6u7k8gV+apz5m
	 nYAmgA3o7brj/Jca5+WlIFOxnOZYlYhk6oSnMjzI1EO2bl+X72JtZMjpNEe8m+zWAN
	 /GgDV022LrQLg==
Date: Thu, 29 Aug 2024 23:43:31 +0530
From: Vinod Koul <vkoul@kernel.org>
To: Ilya Orazov <ilordash02@gmail.com>
Cc: Marc Kleine-Budde <mkl@pengutronix.de>,
	Vincent Mailhol <mailhol.vincent@wanadoo.fr>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Aswath Govindraju <a-govindraju@ti.com>, linux-can@vger.kernel.org,
	linux-phy@lists.infradead.org, devicetree@vger.kernel.org,
	Conor Dooley <conor.dooley@microchip.com>
Subject: Re: [PATCH v4 1/1] dt-bindings: phy: ti,tcan104x-can: Document
 Microchip ATA6561
Message-ID: <ZtC6S6I/QKihcsyu@vaman>
References: <20240822105238.213019-1-ilordash02@gmail.com>
 <20240822105238.213019-2-ilordash02@gmail.com>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240822105238.213019-2-ilordash02@gmail.com>

On 22-08-24, 13:52, Ilya Orazov wrote:
> Microchip ATA6561 is High-Speed CAN Transceiver with Standby Mode.
> It is pin-compatible with TI TCAN1042 and has a compatible programming
> model, therefore use ti,tcan1042 as fallback compatible.
> 
> Acked-by: Conor Dooley <conor.dooley@microchip.com>
> Signed-off-by: Ilya Orazov <ilordash02@gmail.com>
> ---
>  .../devicetree/bindings/phy/ti,tcan104x-can.yaml    | 13 +++++++++----
>  1 file changed, 9 insertions(+), 4 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/phy/ti,tcan104x-can.yaml b/Documentation/devicetree/bindings/phy/ti,tcan104x-can.yaml
> index 79dad3e89aa6..4a8c3829d85d 100644
> --- a/Documentation/devicetree/bindings/phy/ti,tcan104x-can.yaml
> +++ b/Documentation/devicetree/bindings/phy/ti,tcan104x-can.yaml
> @@ -14,10 +14,15 @@ properties:
>      pattern: "^can-phy"
>  
>    compatible:
> -    enum:
> -      - nxp,tjr1443
> -      - ti,tcan1042
> -      - ti,tcan1043
> +    oneOf:
> +      - items:
> +          - enum:
> +              - microchip,ata6561
> +          - const: ti,tcan1042
> +      - enum:
> +          - ti,tcan1042
> +          - ti,tcan1043
> +          - nxp,tjr1443

No driver/dt for new compatibles?

>  
>    '#phy-cells':
>      const: 0
> -- 
> 2.34.1

-- 
~Vinod

