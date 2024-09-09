Return-Path: <linux-can+bounces-1452-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 435A8971CB8
	for <lists+linux-can@lfdr.de>; Mon,  9 Sep 2024 16:36:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6F1A21C23276
	for <lists+linux-can@lfdr.de>; Mon,  9 Sep 2024 14:36:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFADC1BAEC5;
	Mon,  9 Sep 2024 14:35:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="s1v7sjN3"
X-Original-To: linux-can@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B19591B253B;
	Mon,  9 Sep 2024 14:35:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725892551; cv=none; b=RROIkZ7cPot5Ub0ZyAgtaeiNjt4Zzsa66UTJr8DE8dAqCem5LLDQutPbsRLO15+B23BmKwaJG99znSGEyZO7pYJ5PbKFCJe3zW+8d45X3AflwJMRzF8RK9O/dSBv6hGI7IuIF5nRlIVfZygDI9Y/26Er4PgmKX10i6x0Y+KmW70=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725892551; c=relaxed/simple;
	bh=FZKxzFRyz9Op8EvuEP3cZ3bXtDG2HWdMHdwMe2g59vw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eI89YzlqKPco/tn6esbodzduIpvOGGaVRR+u7VsGS/kvjlHEtHOFGoLrfx28Xv1QTLHathTlGiO9ewI0q9XfnTeNdFeNgZxG8pNYLUoQuu4IGtsQiGjtDDLoYvSNOZ0N2Stv6hdtmucKOPNAKT4r/l/r3R+cIJ4gsxWqmNuyKKo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=s1v7sjN3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A70D5C4CEC5;
	Mon,  9 Sep 2024 14:35:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725892551;
	bh=FZKxzFRyz9Op8EvuEP3cZ3bXtDG2HWdMHdwMe2g59vw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=s1v7sjN3LNrEZl6o3gbfDHJL/srLbCjmQhFTT9iKdRjFei0qYil6a8RA/j709kphV
	 5dt/5lLGlU4JUEf9HDqXDA13POjv3B1tsyQkm6HxD+ogSgqSlk2+fiDnRPWYcae0le
	 E2/MgNhSOdJxBj5n/kowlKW1eAEzlfAhR66Qb+Qjalo8Nh1XuS01FvByl1Gv6CVO+b
	 cBcNQMbEgp5Am40Xxh57lCui4kSPYtYgztxxydnF+MrtWp6rmQZM8HRjdAeoJKeyWz
	 xkIwGRbL4dHCn0baIOZLiV4oILm1sVaSbi3zL6AqG79UPOnkNp2EDRKThVLbpQr2Bf
	 I2TFUukUj/OqQ==
Date: Mon, 9 Sep 2024 15:35:46 +0100
From: Simon Horman <horms@kernel.org>
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: Nathan Chancellor <nathan@kernel.org>, kernel@pengutronix.de,
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
Message-ID: <20240909143546.GX2097826@kernel.org>
References: <20240906-rockchip-canfd-wifpts-v1-1-b1398da865b7@kernel.org>
 <20240909084448.GU2097826@kernel.org>
 <20240909-arcane-practical-petrel-015d24-mkl@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240909-arcane-practical-petrel-015d24-mkl@pengutronix.de>

On Mon, Sep 09, 2024 at 10:57:06AM +0200, Marc Kleine-Budde wrote:
> On 09.09.2024 09:44:48, Simon Horman wrote:
> > On Fri, Sep 06, 2024 at 01:26:41PM -0700, Nathan Chancellor wrote:
> > > With clang's kernel control flow integrity (kCFI, CONFIG_CFI_CLANG),
> > > indirect call targets are validated against the expected function
> > > pointer prototype to make sure the call target is valid to help mitigate
> > > ROP attacks. If they are not identical, there is a failure at run time,
> > > which manifests as either a kernel panic or thread getting killed. A
> > > warning in clang aims to catch these at compile time, which reveals:
> > > 
> > >   drivers/net/can/rockchip/rockchip_canfd-core.c:770:20: error: incompatible function pointer types initializing 'netdev_tx_t (*)(struct sk_buff *, struct net_device *)' (aka 'enum netdev_tx (*)(struct sk_buff *, struct net_device *)') with an expression of type 'int (struct sk_buff *, struct net_device *)' [-Werror,-Wincompatible-function-pointer-types-strict]
> > >     770 |         .ndo_start_xmit = rkcanfd_start_xmit,
> > >         |                           ^~~~~~~~~~~~~~~~~~
> > > 
> > > ->ndo_start_xmit() in 'struct net_device_ops' expects a return type of
> > > 'netdev_tx_t', not 'int' (although the types are ABI compatible). Adjust
> > > the return type of rkcanfd_start_xmit() to match the prototype's to
> > > resolve the warning.
> > > 
> > > Fixes: ff60bfbaf67f ("can: rockchip_canfd: add driver for Rockchip CAN-FD controller")
> > > Signed-off-by: Nathan Chancellor <nathan@kernel.org>
> > 
> > Thanks, I was able to reproduce this problem at build time
> > and that your patch addresses it.
> 
> FTR: the default clang in Debian unstable, clang-16.0.6 doesn't support
> this. With clang-20 from experimental it works, haven't checked older
> versions, though.

FTR: I checked using 18.1.8 from here [1][2].

[1] https://mirrors.edge.kernel.org/pub/tools/llvm/
[2] https://mirrors.edge.kernel.org/pub/tools/llvm/files/



