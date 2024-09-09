Return-Path: <linux-can+bounces-1453-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E2C2971E09
	for <lists+linux-can@lfdr.de>; Mon,  9 Sep 2024 17:27:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D97861F233C3
	for <lists+linux-can@lfdr.de>; Mon,  9 Sep 2024 15:27:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBA8B39FF2;
	Mon,  9 Sep 2024 15:27:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="frarv78Y"
X-Original-To: linux-can@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8912E219F3;
	Mon,  9 Sep 2024 15:27:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725895659; cv=none; b=s1ZJNMX2+ceRvBD32pXHemXR+Z1F86ejI9lGHIaZgQu8b1tdd589zH3/R2OfH2OIMxX9y72BVg+JBGtu1EkD3iWUJwegizx0NJc/YDDz8zUKHVGclKlmkC3vYzwfORR+ZNHb6hkRXk8dqFkBqOnS1SfKSdtDhIog9zSxRVopwcI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725895659; c=relaxed/simple;
	bh=bkf0FPBXI9ffG3pgzuSvrT/omg9CfDr3n4aP+Ydrft0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AXO2zILBfuQMgMFGQsMohjKinxPGbBMIH5W+3yTwuobyW8Tlkx2sNkNTQ8oEOx6hQwUEofKKdoUL7MK9rgP3z8Y3ATv4XPN0NbfLuy8awVyGDhVvTMx83kXoizT1ri2zUs/NATmve6A36/dprp9bCASISC/ajldiW3K2OzDW7Is=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=frarv78Y; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 39236C4CEC5;
	Mon,  9 Sep 2024 15:27:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725895659;
	bh=bkf0FPBXI9ffG3pgzuSvrT/omg9CfDr3n4aP+Ydrft0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=frarv78YKu9T5tWlwTYmYfDLTkkR7U+/3o3Bys2C8DHmqmwnP4kfag/9hBM0O6KKb
	 vi8KkYkqHU0/rO3NfdLgBNfSvQn+wCs5aU8S9P0amI9KEzw8g4LA+2oyjmn7D5DUzc
	 a3imUOStMdC8AjO7RcUwiMzy/thY2xWuSP58mQV/URkEBNxTRkH+q064e38N/OMvr3
	 vkfZ7g+Ra0Vqu6XMBBfCPKFch3Wj0aRX18jYGIDvHSRksO16P04xaekzRINf7BDyEk
	 bOe1CKZDUGTvf2eCM50SHbgSL79CrZUEYkm4geGBjscqV0GNiE17Kaewgcfq1jH2j/
	 Rx5H/UvGwxmDg==
Date: Mon, 9 Sep 2024 08:27:36 -0700
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
Message-ID: <20240909152736.GA1406978@thelio-3990X>
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

Hi Marc,

On Mon, Sep 09, 2024 at 10:57:06AM +0200, Marc Kleine-Budde wrote:
> On 09.09.2024 09:44:48, Simon Horman wrote:
> > On Fri, Sep 06, 2024 at 01:26:41PM -0700, Nathan Chancellor wrote:
> > >   drivers/net/can/rockchip/rockchip_canfd-core.c:770:20: error: incompatible function pointer types initializing 'netdev_tx_t (*)(struct sk_buff *, struct net_device *)' (aka 'enum netdev_tx (*)(struct sk_buff *, struct net_device *)') with an expression of type 'int (struct sk_buff *, struct net_device *)' [-Werror,-Wincompatible-function-pointer-types-strict]
> > >     770 |         .ndo_start_xmit = rkcanfd_start_xmit,
> > >         |                           ^~~~~~~~~~~~~~~~~~
...
> FTR: the default clang in Debian unstable, clang-16.0.6 doesn't support
> this. With clang-20 from experimental it works, haven't checked older
> versions, though.

Hmmm, interesting, the patch that added
-Wincompatible-function-pointer-types-strict was added in LLVM 16, so it
should work for 16.0.6...

https://github.com/llvm/llvm-project/commits/41ce74e6e983f523d44d3a80be5ae778c35df85a

I don't have easy access to Debian at the moment so I can double check
it later. I would like to get this turned on for the whole kernel soon
but there is still one subsystem that has several instances that I have
not been able to workaround at this point so I've just stuck to adding
it via KCFLAGS when testing.

Cheers,
Nathan

