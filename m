Return-Path: <linux-can+bounces-1440-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C392D971262
	for <lists+linux-can@lfdr.de>; Mon,  9 Sep 2024 10:44:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6655E1F21319
	for <lists+linux-can@lfdr.de>; Mon,  9 Sep 2024 08:44:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B074D1B14F3;
	Mon,  9 Sep 2024 08:44:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="caX8MYpZ"
X-Original-To: linux-can@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BDBB17557C;
	Mon,  9 Sep 2024 08:44:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725871494; cv=none; b=VetptKry2nHjoP5RIHI6DM58jWApLmA4c+U+zKWQnu7KJ7NQvvVFCspvwWuODqzIZy5tk+gnKS6GcLxkzM77ZA3fFlQUHATxJ6ojRapLL2UkvEkNGzuW5Ym8h1IN8jB62UqTZjvxa9SC60lCLK3GcoicQF85covXhX6wdUYnK4E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725871494; c=relaxed/simple;
	bh=pxwM3hSVCglKIf6EY3IGEl3ujf1W94/lMRDKTRO7k1Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=d2/0k8wdaPzh//AjgzqZo+aSh0J6G/z0y0k2Q2BBqBjhvM5rnQP9SbPxjFZyE13FWwT/o9tXhPfVm6wa0KOnMBFCKzFwPxAGv45jHDTHRInhZpn9FBFPBkkMUn+60dwWk/elt7On3H/94EM5BMlvl0UpSUgGVgG5vwWSTLrIlQk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=caX8MYpZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 27DBDC4CEC5;
	Mon,  9 Sep 2024 08:44:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725871494;
	bh=pxwM3hSVCglKIf6EY3IGEl3ujf1W94/lMRDKTRO7k1Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=caX8MYpZb9kl5CtRpFChwjoo+mPfLkxCM4HtGqCmEm0QDaIhRoPIprkfXTtm+JAas
	 LmNd9As91CDNi38gy9YLO++ILkd4S0cr7q1S424GVVGq4BoptWsrldGI3pGz+et2V8
	 qo6Z2VLIUCbTW+fQcZWYx6Bu3vOXTXEdr0yUm33/HMZaallcrdBwEE5B/hyJedujsl
	 vMXHkUd36/2BzPM2fi33MeyJ8MoHEXK4h5TjjhcOfKHjFSmw8K4xNPWLZnjf8nlVqi
	 iHXTe9OQbM5STDecrBzkNQA2XIMM21gDE0b27c27+p4LPDr02+RpIyS3UbkTEVE+j+
	 JFT7sSQOXZ2Sg==
Date: Mon, 9 Sep 2024 09:44:48 +0100
From: Simon Horman <horms@kernel.org>
To: Nathan Chancellor <nathan@kernel.org>
Cc: Marc Kleine-Budde <mkl@pengutronix.de>, kernel@pengutronix.de,
	Vincent Mailhol <mailhol.vincent@wanadoo.fr>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Heiko Stuebner <heiko@sntech.de>, linux-can@vger.kernel.org,
	netdev@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org, llvm@lists.linux.dev,
	patches@lists.linux.dev
Subject: Re: [PATCH] can: rockchip_canfd: fix return type of
 rkcanfd_start_xmit()
Message-ID: <20240909084448.GU2097826@kernel.org>
References: <20240906-rockchip-canfd-wifpts-v1-1-b1398da865b7@kernel.org>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240906-rockchip-canfd-wifpts-v1-1-b1398da865b7@kernel.org>

On Fri, Sep 06, 2024 at 01:26:41PM -0700, Nathan Chancellor wrote:
> With clang's kernel control flow integrity (kCFI, CONFIG_CFI_CLANG),
> indirect call targets are validated against the expected function
> pointer prototype to make sure the call target is valid to help mitigate
> ROP attacks. If they are not identical, there is a failure at run time,
> which manifests as either a kernel panic or thread getting killed. A
> warning in clang aims to catch these at compile time, which reveals:
> 
>   drivers/net/can/rockchip/rockchip_canfd-core.c:770:20: error: incompatible function pointer types initializing 'netdev_tx_t (*)(struct sk_buff *, struct net_device *)' (aka 'enum netdev_tx (*)(struct sk_buff *, struct net_device *)') with an expression of type 'int (struct sk_buff *, struct net_device *)' [-Werror,-Wincompatible-function-pointer-types-strict]
>     770 |         .ndo_start_xmit = rkcanfd_start_xmit,
>         |                           ^~~~~~~~~~~~~~~~~~
> 
> ->ndo_start_xmit() in 'struct net_device_ops' expects a return type of
> 'netdev_tx_t', not 'int' (although the types are ABI compatible). Adjust
> the return type of rkcanfd_start_xmit() to match the prototype's to
> resolve the warning.
> 
> Fixes: ff60bfbaf67f ("can: rockchip_canfd: add driver for Rockchip CAN-FD controller")
> Signed-off-by: Nathan Chancellor <nathan@kernel.org>

Thanks, I was able to reproduce this problem at build time
and that your patch addresses it.

Reviewed-by: Simon Horman <horms@kernel.org>

