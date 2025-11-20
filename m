Return-Path: <linux-can+bounces-5505-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D3C6C72BA8
	for <lists+linux-can@lfdr.de>; Thu, 20 Nov 2025 09:10:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sin.lore.kernel.org (Postfix) with ESMTPS id A65072A357
	for <lists+linux-can@lfdr.de>; Thu, 20 Nov 2025 08:09:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 733D0302758;
	Thu, 20 Nov 2025 08:09:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pB7GZUBs"
X-Original-To: linux-can@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41F732848A8;
	Thu, 20 Nov 2025 08:09:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763626149; cv=none; b=rwIjARNDUB8+Q6s9Te/f/2wx6TLFXg3CoCx14iTW92k3t+p8jbcqyPZvaYu5GWG0HH9DuEbLlncElMiCoIwtGkJG9Bt2u1EMDUghQBEvRIVwQSuUTv8gKL5GIZFuYWbf93t+fPjZtvZRXkuUue81UzMSLGZ/jSGCKHdWInVtRy4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763626149; c=relaxed/simple;
	bh=+ZWe1Hac0pHN3+FJ8e9MAam7O24cZIiVQZ5o1J0qM7M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KpF58uP9vkU2QkP9RpR3s2UE4gALZI5bcAOougUCWk66GYmygVm5dokwvdGt1sCzTDUHG/28C9D6ps5rOHYtNqs0CPdH3xFOtUjO/kFvyXPk/DF/ZjUhIXC77Atkai7jC/j+w3oDDAdC1ARRsb71S0S1X8Uaqj0MGCxqlezlgh8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pB7GZUBs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 49C44C4CEF1;
	Thu, 20 Nov 2025 08:09:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763626148;
	bh=+ZWe1Hac0pHN3+FJ8e9MAam7O24cZIiVQZ5o1J0qM7M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=pB7GZUBssZwPL+eaGWXALOfGHECsNKbqNF93tDJNcy1onMJzLUpRbDy9hl9sHSSf3
	 hVWG+kwQILkKdNeEXlUY08GRvZgvTnnTHW8aJGM0359QS7lsSpum6KkXcFwQyn1NSa
	 ENzYlz2kQJjqLA82wWbZE3YR4+uayPQtNx/dOuJyjClMsUexlOxf0roRZKpc4Hd2M3
	 V5ZPs3EGqdBFCDiKyb+p0orkrAEV4W8ki1RqSJw20LgPAyu92JWsDi5y68GpOEjOgO
	 x7UWPlEMHDXmRbBy40iFKIBuG5lPHjW2v5M41qmcOrQp2ERyc/tQ8jNFNoHeYSmYSh
	 oVdy0543ilbyA==
Date: Thu, 20 Nov 2025 09:09:06 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Biju <biju.das.au@gmail.com>
Cc: Marc Kleine-Budde <mkl@pengutronix.de>, 
	Vincent Mailhol <mailhol@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Geert Uytterhoeven <geert+renesas@glider.be>, Magnus Damm <magnus.damm@gmail.com>, 
	Biju Das <biju.das.jz@bp.renesas.com>, Fabrizio Castro <fabrizio.castro.jz@renesas.com>, 
	linux-can@vger.kernel.org, devicetree@vger.kernel.org, linux-renesas-soc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: Re: [PATCH 1/2] dt-bindings: can: renesas,rcar-canfd: Document
 renesas,fd-only property
Message-ID: <20251120-statuesque-heavy-herring-e915f6@kuoka>
References: <20251118141840.267652-1-biju.das.jz@bp.renesas.com>
 <20251118141840.267652-2-biju.das.jz@bp.renesas.com>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20251118141840.267652-2-biju.das.jz@bp.renesas.com>

On Tue, Nov 18, 2025 at 02:18:34PM +0000, Biju wrote:
> From: Biju Das <biju.das.jz@bp.renesas.com>
> 
> The CANFD on RZ/{G2L,G3E} and R-Car Gen4 support 3 modes FD-Only mode,
> Classical CAN mode and CAN-FD mode. In FD-Only mode, communication in
> Classical CAN frame format is disabled. Document renesas,fd-only to handle
> this mode. As these SoCs support 3 modes, update the description of
> renesas,no-can-fd property.
> 
> Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
> ---
>  .../bindings/net/can/renesas,rcar-canfd.yaml       | 14 +++++++++++---
>  1 file changed, 11 insertions(+), 3 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/net/can/renesas,rcar-canfd.yaml b/Documentation/devicetree/bindings/net/can/renesas,rcar-canfd.yaml
> index f4ac21c68427..bf9a7d5288d3 100644
> --- a/Documentation/devicetree/bindings/net/can/renesas,rcar-canfd.yaml
> +++ b/Documentation/devicetree/bindings/net/can/renesas,rcar-canfd.yaml
> @@ -125,9 +125,17 @@ properties:
>    renesas,no-can-fd:
>      $ref: /schemas/types.yaml#/definitions/flag
>      description:
> -      The controller can operate in either CAN FD only mode (default) or
> -      Classical CAN only mode.  The mode is global to all channels.
> -      Specify this property to put the controller in Classical CAN only mode.
> +      The controller can operate in either CAN-FD mode (default) or FD-Only
> +      mode (RZ/{G2L,G3E} and R-Car Gen4) or Classical CAN mode. Specify this
> +      property to put the controller in Classical CAN mode.
> +
> +  renesas,fd-only:
> +    $ref: /schemas/types.yaml#/definitions/flag
> +    description:
> +      The CANFD on RZ/{G2L,G3E} and R-Car Gen4 SoCs support 3 modes FD-Only
> +      mode, Classical CAN mode and CAN-FD mode (default). In FD-Only mode,
> +      communication in Classical CAN frame format is disabled. Specify this
> +      property to put the controller in FD-Only mode.

It should really be just an enum since the beginning - representing the
mode of operation. Now you need to complex oneOf to disallow usage of
both.

You also claim not all devices support this, so you need to disallow it
per variant.

Best regards,
Krzysztof


