Return-Path: <linux-can+bounces-1448-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BE39971C67
	for <lists+linux-can@lfdr.de>; Mon,  9 Sep 2024 16:23:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 72389B20EA2
	for <lists+linux-can@lfdr.de>; Mon,  9 Sep 2024 14:23:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44B921BA27C;
	Mon,  9 Sep 2024 14:23:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dl4odoGP"
X-Original-To: linux-can@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17E991B9B50;
	Mon,  9 Sep 2024 14:23:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725891804; cv=none; b=XDhVgkYGmMzIiv/jRInkfzcxLyLaKTotjNhqv2bVgOLkLVj5foTN2MhYUhi8AOQes2bI/GvVHosxM+gEgP6znVzmJoQzKR9EsTM6NJtPu6ORcNF0og80Ai//Q7gNblppogvsXtjFXNv/gSagBrCG7oOfs/Q9XhEf1WcLFYXeljw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725891804; c=relaxed/simple;
	bh=kQNUgMMqW2iwr2oAKBhQG32X6tXltITcAFqjMRNSyXY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=I8PPBEpUVn2OzdlpapOc5gJqG0BrkeZsTbOhvEWVBPRypNc8rZKmXP1OF+rlRqFWOfwi7mOSGjrleqykMCHVXNPI6/q+BbUdmdqm3x3mVAgJ0TcMOiID+SSxnCYdfRxp14tY87I3KHCYC1usCbr0H/qt+tl7yN/2eLJYKVHik64=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dl4odoGP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 393C7C4CEC5;
	Mon,  9 Sep 2024 14:23:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725891803;
	bh=kQNUgMMqW2iwr2oAKBhQG32X6tXltITcAFqjMRNSyXY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=dl4odoGPDk3MUUCdQbLXfEPlxfKbjDQqtUOJTe8U98J/G9P2r8gXGTZXfSYYTsL3N
	 cAdEhvX1DpuXRcPSap7JPkXhorFohALU/HXJuz2bPHMhc4Ad46QelmSa+7TyHlarVY
	 kog9TVkgf9YPD1EGbID8ky1iZlPi0PvOAv3zVAu2wfcICLivIuJzbNC9J4C7Od0qRj
	 xZScqLoBUTWa+PO35n8Zo0U9L+K7jNV7tw+hiOoSNBM4Z3nCUzg7zu5a6qbXKvfyx+
	 /4cUvFwNs5G/qVka1SseRhMSXn21yUTPzVzILhqjeVPuTUiDLAVyyTufxQinQ0n5+x
	 juKE6cM8j8x4w==
Date: Mon, 9 Sep 2024 15:23:18 +0100
From: Simon Horman <horms@kernel.org>
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: kernel@pengutronix.de, Vincent Mailhol <mailhol.vincent@wanadoo.fr>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Heiko Stuebner <heiko@sntech.de>, linux-can@vger.kernel.org,
	netdev@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
	kernel test robot <lkp@intel.com>
Subject: Re: [PATCH] can: rockchip_canfd: rkcanfd_timestamp_init(): fix 64
 bit division on 32 bit platforms
Message-ID: <20240909142318.GW2097826@kernel.org>
References: <20240909-can-rockchip_canfd-fix-64-bit-division-v1-1-2748d9422b00@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240909-can-rockchip_canfd-fix-64-bit-division-v1-1-2748d9422b00@pengutronix.de>

On Mon, Sep 09, 2024 at 08:21:49AM +0200, Marc Kleine-Budde wrote:
> On some 32-bit platforms (at least on parisc), the compiler generates
> a call to __divdi3() from the u32 by 3 division in
> rkcanfd_timestamp_init(), which results in the following linker
> error:
> 
> | ERROR: modpost: "__divdi3" [drivers/net/can/rockchip/rockchip_canfd.ko] undefined!
> 
> As this code doesn't run in the hot path, a 64 bit by 32 bit division
> is OK, even on 32 bit platforms. Use an explicit call to div_u64() to
> fix linking.
> 
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202409072304.lCQWyNLU-lkp@intel.com/
> Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>

Reviewed-by: Simon Horman <horms@kernel.org>


