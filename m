Return-Path: <linux-can+bounces-6160-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 396CBD23602
	for <lists+linux-can@lfdr.de>; Thu, 15 Jan 2026 10:13:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 791FE30A1319
	for <lists+linux-can@lfdr.de>; Thu, 15 Jan 2026 09:09:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B9D7342173;
	Thu, 15 Jan 2026 09:09:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="U+5YXG2Y"
X-Original-To: linux-can@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78A022C029D;
	Thu, 15 Jan 2026 09:09:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768468159; cv=none; b=rP/bTKrJWeCT+sLZ9F0pZGiwvAUU4ViCF7X9ISDIKN2tITuRDLfD8uPvliZj8W7w/iC+37+WvZSAw/WjroWHqux51BYL5ebIf6V4ntV3pTHejxCtfknFs8fDeQGdfyF+DarNVUG7JyPXDoZPfWqOYA6O16TgNdbZxdba9sm3Dzg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768468159; c=relaxed/simple;
	bh=j2FfIGKRfnEPYzvSe7Oho7jWLI9ZgGOALELDlonxVyY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Dreu132q0k0l9n0Ji8sXyat2yJJ/WyTMhbiDu2M0zb/LbTzsjdONTlJNRv7tJMcaBVAXsHfPLcULnDQ1Lx3a+s1KrH9n3vHx7wJlkibkxRRPXtsQuhMuAQvyLl06rvFO4H1sQc7QLV2Vd8ZvGREKyx+w4IRZKFvKP2FqjzwoDUc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=U+5YXG2Y; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CAD16C116D0;
	Thu, 15 Jan 2026 09:09:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768468159;
	bh=j2FfIGKRfnEPYzvSe7Oho7jWLI9ZgGOALELDlonxVyY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=U+5YXG2YD4lO08H9gCgLRvr7CTvfb303LA3UgJgfwWWP2hsDddULO/+2c85T8vuBE
	 3HxubtMNXf+y8MTMYBrMhP3ln5PADGPq+WSVHmaB89/ZngJG/edD3JBeFiHXePoVJK
	 Ak56Bna8aV+EYuttkD+KPZ5ncgOlQMZXfioWmxR8Zo4zJl8caeFe5zh0eDpkrTUv5R
	 8FOjEzY/gy6+dr5wSdq2YqEyMsQl3FKB1nH7r3nOmhqzB4kFi5DRD0u7ARZHxedFjH
	 QRm947rQCPqhFHPkoOSKHqSeHWeyk5AV/dBrHxvJDA4SGgUaU3Vmt03cEbQy/bRIml
	 sMi8qWC5JDdzA==
Date: Thu, 15 Jan 2026 10:09:16 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Prabhakar <prabhakar.csengg@gmail.com>
Cc: Marc Kleine-Budde <mkl@pengutronix.de>, 
	Vincent Mailhol <mailhol@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Geert Uytterhoeven <geert+renesas@glider.be>, Magnus Damm <magnus.damm@gmail.com>, linux-can@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Biju Das <biju.das.jz@bp.renesas.com>, Fabrizio Castro <fabrizio.castro.jz@renesas.com>, 
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: Re: [PATCH v4 3/4] dt-bindings: can: renesas,rcar-canfd: Document
 RZ/T2H and RZ/N2H SoCs
Message-ID: <20260115-premium-piquant-coua-2f7b4e@quoll>
References: <20260114154525.3169992-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20260114154525.3169992-4-prabhakar.mahadev-lad.rj@bp.renesas.com>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260114154525.3169992-4-prabhakar.mahadev-lad.rj@bp.renesas.com>

On Wed, Jan 14, 2026 at 03:45:24PM +0000, Prabhakar wrote:
> From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> 
> Document the CAN-FD controller used on the RZ/T2H and RZ/N2H SoCs. The
> CAN-FD IP is largely compatible with the R-Car Gen4 block, but differs
> in that AFLPN and CFTML are different, there is no reset line for the IP,
> and it only supports two channels.
> 
> Sync the resets and reset-names schema handling with other CAN-FD SoCs so
> DT validation stays consistent and maintainable.
> 
> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> ---
> v3->v4:
> - Dropped Reviewed-by from Geert due to below changes.
> - Updated commit message.
> - Moved single compatible entries into an enum and to below oneOf.
> - Synced the resets/reset-names handling with other similar SoCs.

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>

Best regards,
Krzysztof


