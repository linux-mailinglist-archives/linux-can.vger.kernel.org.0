Return-Path: <linux-can+bounces-5986-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 94CC5CEE4B9
	for <lists+linux-can@lfdr.de>; Fri, 02 Jan 2026 12:16:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 590B9300F59C
	for <lists+linux-can@lfdr.de>; Fri,  2 Jan 2026 11:16:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4802D285CBA;
	Fri,  2 Jan 2026 11:16:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KxBRLCP9"
X-Original-To: linux-can@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14B1B2264AA;
	Fri,  2 Jan 2026 11:16:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767352576; cv=none; b=KdRRLq1zmWXj4vo1/QaUIQtd4CRIYIuih6oFoi0/fImmptoy9VTdekf/lDr1wYjjurOreRVdTLR5TSWKsKPlbK2UM51eQF86tXUv27cyfhIFX3ErvnFihXztw3vpvZSSraOO6FpHOTu6HXcj+w7c2bh3OHlfnzuKVK6viPqhL/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767352576; c=relaxed/simple;
	bh=dpxT0WKNHRik/eHSklywmLtNYi1yzDw7ihV/V23fxjU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pVWXrN92glweTnAgjlPwaEya42z9AejXTO4Ht377/cesQ+DxYgrWRUU54KMSMm3r+mXb5P1aFUcIkQT6nmdtIhBX0jCqO+pRbqquSfoXEtKKil/k5h6pMaZ145f437PELCq+7yaR2Tsszgk4Qa3YOo1tlHNoFYi7/K8r3caOgeY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KxBRLCP9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F34BBC116B1;
	Fri,  2 Jan 2026 11:16:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767352575;
	bh=dpxT0WKNHRik/eHSklywmLtNYi1yzDw7ihV/V23fxjU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=KxBRLCP9sfZzxN2+/HXmxyiyxxP1uEEUc5kZg2U2DmLIqDF7B9h/1iNnXihjOEKy+
	 aA5JmkqfiM0qYMTURPGCN3HXci9X8Q60pEsxAjY6bzI12kzRHdcT3NbeAKYWfHrVtx
	 35Au068apfsr3hRC49pr9Rg2kEYi6doDR2Y7k2cZlKFDeFwwzZz4MuGF+04fYtJsEm
	 3jp5d4NAUoEsVGMiUp5dBGgJpZo4iFupndqbdwiCuzsZqzDUc/vusfK2S7q/5yVeoo
	 Qjsg9gSh0FVrRZX0cP/O3HGdJKoiFY89vtbwrSqLJQxdsajaEk8ZveRGhXoJOcwqEc
	 gMogGDUKJe8nA==
Date: Fri, 2 Jan 2026 12:16:13 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Prabhakar <prabhakar.csengg@gmail.com>
Cc: Marc Kleine-Budde <mkl@pengutronix.de>, 
	Vincent Mailhol <mailhol@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Geert Uytterhoeven <geert+renesas@glider.be>, Magnus Damm <magnus.damm@gmail.com>, 
	Biju Das <biju.das.jz@bp.renesas.com>, linux-can@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Fabrizio Castro <fabrizio.castro.jz@renesas.com>, Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: Re: [PATCH v2 1/4] dt-bindings: can: renesas,rcar-canfd: Specify
 reset-names
Message-ID: <20260102-quirky-hornet-of-downpour-ddda69@quoll>
References: <20251230115814.53536-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20251230115814.53536-2-prabhakar.mahadev-lad.rj@bp.renesas.com>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20251230115814.53536-2-prabhakar.mahadev-lad.rj@bp.renesas.com>

On Tue, Dec 30, 2025 at 11:58:11AM +0000, Prabhakar wrote:
> From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> 
> Specify the expected reset-names for the Renesas CAN-FD controller on
> RZ/G2L and RZ/G3E SoCs.

You should explain here from where you got the actual names.

Otherwise you got following review:

> 
> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> ---
> v1->v2:
> - Moved reset-names to top-level properties.
> ---
>  .../bindings/net/can/renesas,rcar-canfd.yaml  | 33 +++++++++++--------
>  1 file changed, 19 insertions(+), 14 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/net/can/renesas,rcar-canfd.yaml b/Documentation/devicetree/bindings/net/can/renesas,rcar-canfd.yaml
> index e129bdceef84..9bfd4f44e4d4 100644
> --- a/Documentation/devicetree/bindings/net/can/renesas,rcar-canfd.yaml
> +++ b/Documentation/devicetree/bindings/net/can/renesas,rcar-canfd.yaml
> @@ -122,6 +122,11 @@ properties:
>  
>    resets: true
>  
> +  reset-names:
> +    items:
> +      - const: rstp_n
> +      - const: rstc_n

rst seems redundant. _n as well. Are these names from datasheet? How are
they called in this device (not the soc) datasheet exactly? Because it
feels you use pin or SoC names which is not useful.

Best regards,
Krzysztof


