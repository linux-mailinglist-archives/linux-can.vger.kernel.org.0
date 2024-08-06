Return-Path: <linux-can+bounces-1151-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 07EAB949687
	for <lists+linux-can@lfdr.de>; Tue,  6 Aug 2024 19:18:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B341D1F23F5B
	for <lists+linux-can@lfdr.de>; Tue,  6 Aug 2024 17:18:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F08244C81;
	Tue,  6 Aug 2024 17:18:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hrXaQzV5"
X-Original-To: linux-can@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B4315A0F5;
	Tue,  6 Aug 2024 17:18:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722964719; cv=none; b=XTrZbRrhN9hZQNjE5HwrzIFNOkeQaf34Z1O3tHcOnZlzXo0YEH0LdU8vrDvsBYGEcQAgbu/R7gQmsGZzmCDPKInAMZjvMf4fbjbJFPf3raj6fpRi5qFrpSWuBCaQ64BASIOhUv1jZHpkaW/Vys5BnN8vPUWD7LDpehA2e6JxOP0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722964719; c=relaxed/simple;
	bh=1GTwqbPu1DRXS3CHjodb5Z+0yALaqUARNmOxa7+ibwQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Vr5bAK1v+TeOxGZou4fFQHSa/8ouMEapV2Iy/wQwcYsF9fHEjFKiny4aHHy99UPNRDJa/4MFtHG3Z0hkqV+bCoazwOOWHXF4IHOW9C7/vWsnc8ZI8VSM+nYOq2dm1ZQzWzwTTPQndKgG3k/bHulEOoGzdPWmAo5nk89F6oFBT3E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hrXaQzV5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 61097C4AF0C;
	Tue,  6 Aug 2024 17:18:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722964718;
	bh=1GTwqbPu1DRXS3CHjodb5Z+0yALaqUARNmOxa7+ibwQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hrXaQzV5OLp1cBVoU02ep1rK415nwGP5UokWusAETNjwR76LaVhzspMByRxFuJWsT
	 0fa2JgpjZ/J8Ac2HOsooKsQvvlPplyo2HhJv+OZoSY//oGoaDzdm7hpNqkGoePKvYg
	 QoenUig9vGTPTMOLejYETyF1ICj2e+LQKM04cnTMnh9eKw+apMNA8bFXI7fBNzl5Zi
	 9vKqZL3t7zaWQl6v1DBpMcig/FEhR8l5plJ302fo2bhExWaLnO9F+/BuYYQau7fZ9U
	 OruGOAdoSqo7zExTwgHjz2mJfvDv1QH0MPmnmNSCikEh1vMgMbDR2AefhnGXyU6sJp
	 /deUODRHopq2Q==
Date: Tue, 6 Aug 2024 11:18:37 -0600
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Fabrizio Castro <fabrizio.castro.jz@renesas.com>,
	netdev@vger.kernel.org, Marc Kleine-Budde <mkl@pengutronix.de>,
	Vincent Mailhol <mailhol.vincent@wanadoo.fr>,
	linux-can@vger.kernel.org, Duy Nguyen <duy.nguyen.rh@renesas.com>,
	Eric Dumazet <edumazet@google.com>, devicetree@vger.kernel.org,
	"David S . Miller" <davem@davemloft.net>,
	linux-renesas-soc@vger.kernel.org, Paolo Abeni <pabeni@redhat.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>
Subject: Re: [PATCH v3] dt-bindings: can: renesas,rcar-canfd: Document R-Car
 V4M support
Message-ID: <172296471618.1826539.5724224646610844294.robh@kernel.org>
References: <68b5f910bef89508e3455c768844ebe859d6ff1d.1722520779.git.geert+renesas@glider.be>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <68b5f910bef89508e3455c768844ebe859d6ff1d.1722520779.git.geert+renesas@glider.be>


On Thu, 01 Aug 2024 16:03:17 +0200, Geert Uytterhoeven wrote:
> From: Duy Nguyen <duy.nguyen.rh@renesas.com>
> 
> Document support for the CAN-FD Interface on the Renesas R-Car V4M
> (R8A779H0) SoC, which supports up to four channels.
> 
> The CAN-FD module on R-Car V4M is very similar to the one on R-Car V4H,
> but differs in some hardware parameters, as reflected by the Parameter
> Status Information part of the Global IP Version Register.  However,
> none of this parameterization should have any impact on the driver, as
> the driver does not access any register that is impacted by the
> parameterization (except for the number of channels).
> 
> Signed-off-by: Duy Nguyen <duy.nguyen.rh@renesas.com>
> [geert: Clarify R-Car V4M differences]
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---
> v3:
>   - Add more clarification,
> 
> v2:
>   - Drop RFC state now it works.
> 
> Changes compared to the BSP:
>   - Restrict number of channels to four.
> ---
>  .../bindings/net/can/renesas,rcar-canfd.yaml  | 22 ++++++++++++++-----
>  1 file changed, 16 insertions(+), 6 deletions(-)
> 

Acked-by: Rob Herring (Arm) <robh@kernel.org>


