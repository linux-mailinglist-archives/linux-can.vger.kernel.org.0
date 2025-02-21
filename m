Return-Path: <linux-can+bounces-2930-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AA612A4034B
	for <lists+linux-can@lfdr.de>; Sat, 22 Feb 2025 00:06:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 36F9B19C5A53
	for <lists+linux-can@lfdr.de>; Fri, 21 Feb 2025 23:05:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0065D202C4A;
	Fri, 21 Feb 2025 23:05:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YmXTk9nv"
X-Original-To: linux-can@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4AF31FBC99;
	Fri, 21 Feb 2025 23:05:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740179128; cv=none; b=FTk29OYy9ItOJ1A4aeWJN5x0WaGH9SLDB3sSV/P9JkWJgQmltUYuDKTmyBAse4hxkDjIFq2OU3UAuWP98GZaljCeZNtvsgtGhXIAgeHxFL6gdinSceTIfDw3G0hGVJAESScBl/0MV2WPxUzxLDUXM+FuA3gywBoyd4AGZGoaJoc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740179128; c=relaxed/simple;
	bh=03Ft+MdsQIGJO6vJjyqtVZOgWYCQ92Iofj9AeHmdSOo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HVoIhwZ6evDRJHX59+D8Ci870lYFQ1lmIkyeN8l8+03Tt3szLGCp4d2gBRvG0oKgta1rtrZrfN87SLzIXcC1NUUbQIP6LH4/5yOAN8pK9dOnv0WzgjSjDolx0c/Rv4VBSGAVorwGHZoOZkrXgZdDt3blw9+WWHv4CwELi9Q8IME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YmXTk9nv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 11662C4CED6;
	Fri, 21 Feb 2025 23:05:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740179128;
	bh=03Ft+MdsQIGJO6vJjyqtVZOgWYCQ92Iofj9AeHmdSOo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=YmXTk9nvYswSV/0KmzCwAhOC05TwSyC/f3YQUi0jSfNf/BUzm4lFSnUpflB6mPkaf
	 gsgc1gjwi+TToDH96aDHj2pWz3J4CYnyJ62EL0B4jRhovo1NQbC/wBEzi1kcWpXp1w
	 FvmKt6CJQbUeJbpoyzwRLS86I2Ct/ZYbSX65xfZLx8NJfsRNMmoRkkAxlEqjRPThgE
	 8Ku0YWu/jwHh5lcyDdlxEavgMF8vkJQEcCeoxSbv8TnywNSYNzeizaXLweeQSOffGC
	 +zQ3IJHGLglkb8KcoLBMI792Em/NS9pwPzhT3EBXJDk1LsV4KsZW6MqrwyovNaWJdd
	 gjEB8qhp1J9QA==
Date: Fri, 21 Feb 2025 17:05:26 -0600
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Biju Das <biju.das.jz@bp.renesas.com>
Cc: Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Magnus Damm <magnus.damm@gmail.com>,
	Fabrizio Castro <fabrizio.castro.jz@renesas.com>,
	Simon Horman <horms@kernel.org>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	stable@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
	linux-can@vger.kernel.org, Marc Kleine-Budde <mkl@pengutronix.de>,
	Duy Nguyen <duy.nguyen.rh@renesas.com>, devicetree@vger.kernel.org,
	Conor Dooley <conor+dt@kernel.org>,
	Vincent Mailhol <mailhol.vincent@wanadoo.fr>,
	Biju Das <biju.das.au@gmail.com>
Subject: Re: [PATCH v2 1/2] dt-bindings: can: renesas,rcar-canfd: Fix typo in
 pattern properties for R-Car V4M
Message-ID: <174017912595.234654.3928820060314078728.robh@kernel.org>
References: <20250220094516.126598-1-biju.das.jz@bp.renesas.com>
 <20250220094516.126598-2-biju.das.jz@bp.renesas.com>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250220094516.126598-2-biju.das.jz@bp.renesas.com>


On Thu, 20 Feb 2025 09:45:11 +0000, Biju Das wrote:
> The Renesas R-Car V4M(R8A779H0) SoC, supports up to four channels.
> Fix the typo 5->4 in pattern properties.
> 
> Fixes: ced52c6ed257 ("dt-bindings: can: renesas,rcar-canfd: Document R-Car V4M support")
> Cc: stable@vger.kernel.org
> Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
> Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
> ---
> v1->v2:
>  * Added Rb tag from Geert
>  *  *  Added the tag Cc:stable@vger.kernel.org
> ---
>  .../devicetree/bindings/net/can/renesas,rcar-canfd.yaml         | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 

Acked-by: Rob Herring (Arm) <robh@kernel.org>


