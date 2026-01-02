Return-Path: <linux-can+bounces-5987-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 424BFCEE4F6
	for <lists+linux-can@lfdr.de>; Fri, 02 Jan 2026 12:18:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7B04D302F683
	for <lists+linux-can@lfdr.de>; Fri,  2 Jan 2026 11:17:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04BBA2F1FE1;
	Fri,  2 Jan 2026 11:17:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="q2/LKOyS"
X-Original-To: linux-can@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA8022F12DA;
	Fri,  2 Jan 2026 11:17:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767352627; cv=none; b=d23PNSHidZexwGErgQzMyU8oM6yFTY/8kAwbHa/xv3PrrE+nIq13HtegDbptX6WxCiaafUg7e3cl7gPeNpQ1KKP9ekhXTAARNjJ+r+q0nXv5fXmqLr0QM+dwx06vNdNzMiUwNJhVkqGcgYRsS0gBH/J0ORv+d+U3UwdY65ocxvg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767352627; c=relaxed/simple;
	bh=1NG2c1xPzJN5pCySiA1xV1OSVZ9zP4oHbaLcmOSGaLE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=J9lBNbE+dwzYRgfisEWEr1DjqM/ir3XUvrmh6ipqmKhWLnlEjZshRod1c90sKVIf6OSw6+PpwcQ2ufz8OYRxalPRorVQEoEvxc2anRgocQkvKSuh3AYUHwlxu940zryU957MG14HiF8CEQxb5xbqEzBInPQkQzN3xXb3igPbKrg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=q2/LKOyS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 07AEBC16AAE;
	Fri,  2 Jan 2026 11:17:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767352627;
	bh=1NG2c1xPzJN5pCySiA1xV1OSVZ9zP4oHbaLcmOSGaLE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=q2/LKOySZoqq2eeaW57j+fpvhQhcYFK3uYm9jA+9qv6YL8sInPeCOJYG9P9PNTIBQ
	 NxwZP6SCCHPWU7zUpw+FYTCudTkATEC//D60jr8l3sKwi6GLl3GB0d0ytakhw2rujU
	 GI/4lqsZOrFQQCfCXiOUeUmzOhGIpFqwil8V4zRLmCTMqPVAn2tLLM8fT4Hw3SUJjg
	 6gpBF9/w2d0iaNILplcGTRytGMOOC3R9VddZG29PxAgprHGqMy3bAGY9CzXu6zGExS
	 i1Z+SEc9HHg6pRN5hoXQTsWG2oBvf9GNs5dT09NPfPxY5K2mNKIoiKtkqL9gBsR1BY
	 lVfrFzwj1p77A==
Date: Fri, 2 Jan 2026 12:17:05 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Prabhakar <prabhakar.csengg@gmail.com>
Cc: Marc Kleine-Budde <mkl@pengutronix.de>, 
	Vincent Mailhol <mailhol@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Geert Uytterhoeven <geert+renesas@glider.be>, Magnus Damm <magnus.damm@gmail.com>, 
	Biju Das <biju.das.jz@bp.renesas.com>, linux-can@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Fabrizio Castro <fabrizio.castro.jz@renesas.com>, Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: Re: [PATCH v2 2/4] dt-bindings: can: renesas,rcar-canfd: Document
 RZ/V2H(P) and RZ/V2N SoCs
Message-ID: <20260102-thoughtful-koala-of-swiftness-07a5eb@quoll>
References: <20251230115814.53536-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20251230115814.53536-3-prabhakar.mahadev-lad.rj@bp.renesas.com>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20251230115814.53536-3-prabhakar.mahadev-lad.rj@bp.renesas.com>

On Tue, Dec 30, 2025 at 11:58:12AM +0000, Prabhakar wrote:
> From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> 
> Document CANFD IP found on the Renesas RZ/V2H(P) (R9A09G057) and RZ/V2N
> (R9A09G056) SoCs. The CANFD IP on these SoCs are identical to that found
> on the RZ/G3E (R9A09G047) SoC.
> 
> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> ---

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>

Best regards,
Krzysztof


