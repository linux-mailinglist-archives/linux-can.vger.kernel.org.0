Return-Path: <linux-can+bounces-1102-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B8E82945346
	for <lists+linux-can@lfdr.de>; Thu,  1 Aug 2024 21:22:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 30B2EB256FA
	for <lists+linux-can@lfdr.de>; Thu,  1 Aug 2024 19:22:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E03A1494A7;
	Thu,  1 Aug 2024 19:22:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fyJ0OlDS"
X-Original-To: linux-can@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 321921494A4;
	Thu,  1 Aug 2024 19:22:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722540135; cv=none; b=LVTq6aOPpZn2VvyQYnjIh84+zPBzm+Tcfy1SzdOOtU3Abk89+3uS077dk7zDkdwehgo7r7pwbvyshnQezbs7W7vbNbhBopt4lwu2BIeM8w0yQpSJzonYAOleaLegJndq9UCAwxd/WnzWSZqXWI8of1DD8WwZAijStFCE1KUNESo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722540135; c=relaxed/simple;
	bh=etTOiz6nxoka2hkDVBziQ4wSJJjNFpGUAvUQRO9APN4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pxv9vnGk5I4IIEJ+8GMxrpjoYtegEpf1Ms989LO/Q2Mw80CpCnWU3gGaQMVrKpCwj77jI3TsRzeGrs1CurxNS/gpyjZSytnJwcgNlBZZsA+nkp8cE+x+/iOXZw8D4hRLF3Fheadjev3xbRqLjXRpFAdtjEZa0zjA00PRcCBSDUg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fyJ0OlDS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A2CA9C32786;
	Thu,  1 Aug 2024 19:22:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722540134;
	bh=etTOiz6nxoka2hkDVBziQ4wSJJjNFpGUAvUQRO9APN4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fyJ0OlDS6nz2rvMAVZxE898JrmWPBZQ4iT+UCEFLaLYSe2ZmwJ0QKnZAml3yCrqYi
	 Gj/a+RdvM31tGy1br2ZNgGf4vnojnpK0xzuGbPzQlspH1ZJb4JJdXc1hYbkOjp4T2Q
	 ZNTGgK/DET+bNumC04BVk2oaxUiYRa34ilWAFDJYtO5YnM+XhqRuCqskQud/eOMAx8
	 dDpjDURJJqUZ7FYn19Uw/KMYrXeRbJToMaGO3Mv1hvPP2GiFRd/P4mNrkbN5HtD7DD
	 uzbKA1jrvjNGjcLiEGwD557kcHSVBav4n9btuLLahVt8LOEnt/s6PhY7Gof1knVs5x
	 9p+OtK6PfpuSA==
Date: Thu, 1 Aug 2024 20:22:09 +0100
From: Simon Horman <horms@kernel.org>
To: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Marc Kleine-Budde <mkl@pengutronix.de>,
	Vincent Mailhol <mailhol.vincent@wanadoo.fr>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Fabrizio Castro <fabrizio.castro.jz@renesas.com>,
	linux-can@vger.kernel.org, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
	Duy Nguyen <duy.nguyen.rh@renesas.com>
Subject: Re: [PATCH v3] dt-bindings: can: renesas,rcar-canfd: Document R-Car
 V4M support
Message-ID: <20240801192209.GA2495006@kernel.org>
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

On Thu, Aug 01, 2024 at 04:03:17PM +0200, Geert Uytterhoeven wrote:
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

Reviewed-by: Simon Horman <horms@kernel.org>


