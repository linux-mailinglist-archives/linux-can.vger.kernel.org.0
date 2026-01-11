Return-Path: <linux-can+bounces-6101-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C795DD0E89E
	for <lists+linux-can@lfdr.de>; Sun, 11 Jan 2026 11:08:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4F89D300E141
	for <lists+linux-can@lfdr.de>; Sun, 11 Jan 2026 10:08:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59FC9330D24;
	Sun, 11 Jan 2026 10:08:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LMlaRMdV"
X-Original-To: linux-can@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33F9386323;
	Sun, 11 Jan 2026 10:08:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768126089; cv=none; b=j86zahcFYG7PbylkvFuzMvJkqMNNzZQH2yfyHMGHOLzIceddWF2nrfPqG/Py8C6bKkv9NeTUg7vY8akp79fyS4SFM+qUl8rF34B0yf9SWmrlSsW901jfOnNJfR2lxk4JZCAPMWZo7+gdIEu8CvnN564WMhmu7cChVG87WlWYPkg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768126089; c=relaxed/simple;
	bh=/gFPYwD/Y5WPhrpj0O6BSmAZ9FneNpoyvRuMkaKLOlI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ak1YjjNr7GwA+lJ6xC1HmehNL2Y7PJ5l4/aQTtaV52jmHBCz6oyQmxLV63PbrIrRnfDAumJP6oZ0YHGni5qWUIYeIoPj7WJmhGMqUwxwuWJXCXkgf2HGFe4CvQoisZes6iYKd0TRiHVuZQBg26CTlVDpDwb0S/QRqRIHYg9zmUs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LMlaRMdV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A6ABC4CEF7;
	Sun, 11 Jan 2026 10:08:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768126088;
	bh=/gFPYwD/Y5WPhrpj0O6BSmAZ9FneNpoyvRuMkaKLOlI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=LMlaRMdV9lReX/AZXLFxEn/GI7M+UBfRSpTFWjjWbMxmRg1SCZNcvN3D1PNBdkzS/
	 UVlx5B2GZ0Fpi5oKoAtGXXCLMQu+KPl+eVGoAPcUKKtPGDvO6/bPB5qYoe8co4CEaV
	 Qbma/pEUtqsjFLBPNF7O069achQWCX75+NY5+obhi6XvjI8ynw14eoFU6d7OU1YfR9
	 grezPkQq1i6XE7Nad5PrA09ImtFfInGF/KBYEfKR4DIz+RV1hqyyjB3s4UyTohJhx/
	 RMH+b9U9DqFYQeN2nZKV/IfaoUiFBfgtSPEM912XS4GcN57diiaXU40EWrvtz9brDc
	 OmW13XBNMFzNw==
Date: Sun, 11 Jan 2026 11:08:06 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Prabhakar <prabhakar.csengg@gmail.com>
Cc: Marc Kleine-Budde <mkl@pengutronix.de>, 
	Vincent Mailhol <mailhol@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Geert Uytterhoeven <geert+renesas@glider.be>, Magnus Damm <magnus.damm@gmail.com>, linux-can@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Biju Das <biju.das.jz@bp.renesas.com>, Fabrizio Castro <fabrizio.castro.jz@renesas.com>, 
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: Re: [PATCH v3 1/4] dt-bindings: can: renesas,rcar-canfd: Specify
 reset-names
Message-ID: <20260111-hysterical-cuddly-swift-2cae53@quoll>
References: <20260109125128.2474156-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20260109125128.2474156-2-prabhakar.mahadev-lad.rj@bp.renesas.com>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260109125128.2474156-2-prabhakar.mahadev-lad.rj@bp.renesas.com>

On Fri, Jan 09, 2026 at 12:51:25PM +0000, Prabhakar wrote:
> From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> 
> Specify the expected reset-names for the Renesas CAN-FD controller on
> RZ/G2L and RZ/G3E SoCs.
> 
> The reset names rstp_n and rstc_n are defined in the SoC hardware manual
> and are already used by the driver since commit 76e9353a80e9 ("can:
> rcar_canfd: Add support for RZ/G2L family"). The reset-names property
> existed previously but was dropped by commit 466c8ef7b66b ("dt-bindings:
> can: renesas,rcar-canfd: Simplify the conditional schema").
> 
> Restore and constrain reset-names in the binding so DT schema checks
> match the actual hardware requirements and driver expectations.
> 
> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> ---
> v2->v3:
> - Updated commit message to clarify that reset-names existed previously
>   but was dropped.

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>

Best regards,
Krzysztof


