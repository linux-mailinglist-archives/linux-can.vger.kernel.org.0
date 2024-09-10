Return-Path: <linux-can+bounces-1470-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6732B9742EE
	for <lists+linux-can@lfdr.de>; Tue, 10 Sep 2024 21:05:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BF5ABB25232
	for <lists+linux-can@lfdr.de>; Tue, 10 Sep 2024 19:05:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BABDF1A4B82;
	Tue, 10 Sep 2024 19:05:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YjSugIze"
X-Original-To: linux-can@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88FC01A08A6;
	Tue, 10 Sep 2024 19:05:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725995128; cv=none; b=jMXKKhgsTsgZBXiJDtprOSXNvac6KgpF0TgFnZb3ReKbGAP0ywzakjNr1zDSk8HNsb8z0WH9KqM1RnxbIkyqFOJFyHBdsQq1mcO++NguKsHUnH9LHRaAbvAyMTG3ksLnHTLkmmSpEEw72X+IIPBmNyDTW7Jdlzwe54ui/CI8sPk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725995128; c=relaxed/simple;
	bh=C3ZeDgPXAfSZWBVnm4n6Mx6Y3fiU3fMZS6UYTtOPrlg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=W0fGQ9i42hXsVhfhjdkcoJWXPc6H1pg76QihtTX+aQjATCWPQ1QuURzxCo0d8UunwMefAkKCXFlWljHHSZxCuM3xs5nqRfLaS5SRKYASe56fEydWUDf+K2rVBMarZws5zsCKFxQfQgom3Bh7ts8WCdsfTq6yVoK/wmDDigaEEj0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YjSugIze; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 37D09C4CEC3;
	Tue, 10 Sep 2024 19:05:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725995128;
	bh=C3ZeDgPXAfSZWBVnm4n6Mx6Y3fiU3fMZS6UYTtOPrlg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=YjSugIzeeRXzHGAJbdqovwScWPHDefcg+9ae1ZDyTfsEdeU6f585fk10WsHZEjz2E
	 EpHRZwbZ4+fWyVsdGg+QLZO6owVh0YfFdqbz3fh2rF7AwRH8VGzLOzNtY1b2zz+h7x
	 tPugLSz2hmgZf+Ki46pc5Len5aMX06ccJcaIvd086t0Jl4fcn4cqqExpkmRBzUiEJQ
	 ZE1s3hwjknbd8Imr/eJ/igayIH3DoVg1sk7AkWW+4y5gjuTpFWnybXmaK6VWpI1DTU
	 bATKAfrlf/B4g8+D12kjDwuUEG/l1J8sJDPhGvn3UGcQgtV/7mzFHlSNar6Ib/aTPp
	 begjABtc63sRg==
Date: Tue, 10 Sep 2024 12:05:25 -0700
From: Nathan Chancellor <nathan@kernel.org>
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: Simon Horman <horms@kernel.org>, kernel@pengutronix.de,
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
Message-ID: <20240910190525.GA1169362@thelio-3990X>
References: <20240906-rockchip-canfd-wifpts-v1-1-b1398da865b7@kernel.org>
 <20240909084448.GU2097826@kernel.org>
 <20240909-arcane-practical-petrel-015d24-mkl@pengutronix.de>
 <20240909143546.GX2097826@kernel.org>
 <20240910-utopian-meticulous-dodo-4ec230-mkl@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240910-utopian-meticulous-dodo-4ec230-mkl@pengutronix.de>

Hi Marc,

On Tue, Sep 10, 2024 at 11:56:56AM +0200, Marc Kleine-Budde wrote:
> On 09.09.2024 15:35:46, Simon Horman wrote:
> > On Mon, Sep 09, 2024 at 10:57:06AM +0200, Marc Kleine-Budde wrote:
> > > On 09.09.2024 09:44:48, Simon Horman wrote:
> > > > On Fri, Sep 06, 2024 at 01:26:41PM -0700, Nathan Chancellor wrote:
> > > > > With clang's kernel control flow integrity (kCFI, CONFIG_CFI_CLANG),
> > > > > indirect call targets are validated against the expected function
> > > > > pointer prototype to make sure the call target is valid to help mitigate
> > > > > ROP attacks. If they are not identical, there is a failure at run time,
> > > > > which manifests as either a kernel panic or thread getting killed. A
> > > > > warning in clang aims to catch these at compile time, which reveals:
> > > > > 
> > > > >   drivers/net/can/rockchip/rockchip_canfd-core.c:770:20: error: incompatible function pointer types initializing 'netdev_tx_t (*)(struct sk_buff *, struct net_device *)' (aka 'enum netdev_tx (*)(struct sk_buff *, struct net_device *)') with an expression of type 'int (struct sk_buff *, struct net_device *)' [-Werror,-Wincompatible-function-pointer-types-strict]
> > > > >     770 |         .ndo_start_xmit = rkcanfd_start_xmit,
> > > > >         |                           ^~~~~~~~~~~~~~~~~~
> > > > > 
> > > > > ->ndo_start_xmit() in 'struct net_device_ops' expects a return type of
> > > > > 'netdev_tx_t', not 'int' (although the types are ABI compatible). Adjust
> > > > > the return type of rkcanfd_start_xmit() to match the prototype's to
> > > > > resolve the warning.
> > > > > 
> > > > > Fixes: ff60bfbaf67f ("can: rockchip_canfd: add driver for Rockchip CAN-FD controller")
> > > > > Signed-off-by: Nathan Chancellor <nathan@kernel.org>
> > > > 
> > > > Thanks, I was able to reproduce this problem at build time
> > > > and that your patch addresses it.
> > > 
> > > FTR: the default clang in Debian unstable, clang-16.0.6 doesn't support
> > > this. With clang-20 from experimental it works, haven't checked older
> > > versions, though.
> > 
> > FTR: I checked using 18.1.8 from here [1][2].
> > 
> > [1] https://mirrors.edge.kernel.org/pub/tools/llvm/
> > [2] https://mirrors.edge.kernel.org/pub/tools/llvm/files/
> 
> I was a bit hasty yesterday, clang-20 and W=1 produces these errors:
> 
> | include/linux/vmstat.h:517:36: error: arithmetic between different enumeration types ('enum node_stat_item' and 'enum lru_list') [-Werror,-Wenum-enum-conversion]
> |   517 |         return node_stat_name(NR_LRU_BASE + lru) + 3; // skip "nr_"
> |       |                               ~~~~~~~~~~~ ^ ~~~
> | 1 error generated.

Unfortunately, this is a completely tangential issue. You can see some
backstory behind it in commit 75b5ab134bb5 ("kbuild: Move
-Wenum-{compare-conditional,enum-conversion} into W=1"). To be honest, I
should consider moving that to W=2...

> However I fail to reproduce the ndo_start_xmit problem. Even with 18.1.8
> from kernel.org.
> 
> 
> The following command (ARCH is unset, compiling x86 -> x86) produces the
> above shown "vmstat.h" problems....
> 
> | $ make LLVM=1 LLVM_IAS=1 LLVM_SUFFIX=-20 drivers/net/can/rockchip/  W=1 CONFIG_WERROR=0

FYI, you could shorten this to just:

  $ make LLVM=-20 drivers/net/can/rockchip/ W=1 CONFIG_WERROR=0

As LLVM_SUFFIX will be set through LLVM and LLVM_IAS has defaulted to 1
since 5.15.

Does CONFIG_WERROR=0 work? It seems like it is still present above.

> ... but not the ndo_start_xmit problem.
> 
> 
> Am I missing a vital .config option?

No, I might not have made it clear in this commit message but this
warning is not on by default. I am looking to turn it on at some point
so I keep up with the warnings that it produces but there is one
subsystem that has several instances and I am unsure of how to solve
them to the maintainer's satisfaction. You can test it by adding

  KCFLAGS=-Wincompatible-function-pointer-types-strict

to your make command above and it should reproduce.

Cheers,
Nathan

