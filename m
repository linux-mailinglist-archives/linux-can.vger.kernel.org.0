Return-Path: <linux-can+bounces-1422-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B46BD96DA10
	for <lists+linux-can@lfdr.de>; Thu,  5 Sep 2024 15:20:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DF9051C22F55
	for <lists+linux-can@lfdr.de>; Thu,  5 Sep 2024 13:20:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A2FE19D064;
	Thu,  5 Sep 2024 13:20:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CWWzD5L1"
X-Original-To: linux-can@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5A3047796;
	Thu,  5 Sep 2024 13:20:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725542437; cv=none; b=U/S/OJwiMz2CilOurW8sLwTWRl7RqwcwaiH5sxWogK2/wmoziSZ0zH38aJS02nvRaMsIS7tTd6YwjaOddNOQXlcb6DD/jzZaA6VQK1yibPcGTEQMMVxDE+t+7gilgyzxfgtz92ekQGEKZZcyjxkfDgpLGq3EGjf5vO5HZ6xb0Ak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725542437; c=relaxed/simple;
	bh=TIvH7U28cEYJfvEHwcZsfuLAV3PIB2hSzXzFG+rT9E0=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=M+WEVn0VrIkNp82p+Y07eoSet6LnWWRgc/k+BCKksNx+RA94VUePwtrGhkNX4foEfCfHFKV3mw/wwHnzlLb6XmUatZ2RE5FvttQVeQuLCQb+dFT8LtOMyK9Xq0GB7z5Dljg1y/bUvDL/bdD0rWG4xC20wy5I80BK04m7TOSTPbU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CWWzD5L1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 64F98C4CEC3;
	Thu,  5 Sep 2024 13:20:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725542435;
	bh=TIvH7U28cEYJfvEHwcZsfuLAV3PIB2hSzXzFG+rT9E0=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=CWWzD5L1uEGlzZUao3qLZKpUzsSNQi+lcY59TvmqVI1OefmOtt5MxWFe0KO9t3ve9
	 wueGPC3KxLs641sB5LJttVHwposAnXHYox27G8tQLpAN2vbza30Yh9NCg96nTm4FWl
	 s3B6eQYFr8gjqTibIAN5CnHbOT0swUnCnQiQTG1+R/f7FqGqDUuEWPjOiB4VBBGXJJ
	 nJ/zy7uTK526gVVzgdvxUBXFEkw5X12JZUYAKcZg32g3tWeI9RJKZi3eQyidmeTNQn
	 EBfOd6rB0hQsHwV1h6qAuMoP9QGQfa84ouMliNqYRp+8hjNCElZdl+03g9v4FxNEir
	 8H4HWFCqIXNEQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70D743806651;
	Thu,  5 Sep 2024 13:20:37 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next 01/18] dt-bindings: can: rockchip_canfd: add rockchip
 CAN-FD controller
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172554243626.1687913.5623663966016175191.git-patchwork-notify@kernel.org>
Date: Thu, 05 Sep 2024 13:20:36 +0000
References: <20240904130256.1965582-2-mkl@pengutronix.de>
In-Reply-To: <20240904130256.1965582-2-mkl@pengutronix.de>
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
 linux-can@vger.kernel.org, kernel@pengutronix.de, zhangqing@rock-chips.com,
 a1ba.omarov@gmail.com, robh@kernel.org, heiko@sntech.de

Hello:

This series was applied to netdev/net-next.git (main)
by Marc Kleine-Budde <mkl@pengutronix.de>:

On Wed,  4 Sep 2024 14:55:17 +0200 you wrote:
> Add documentation for the rockchip rk3568 CAN-FD controller.
> 
> Co-developed-by: Elaine Zhang <zhangqing@rock-chips.com>
> Signed-off-by: Elaine Zhang <zhangqing@rock-chips.com>
> Tested-by: Alibek Omarov <a1ba.omarov@gmail.com>
> Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
> Reviewed-by: Heiko Stuebner <heiko@sntech.de>
> Link: https://patch.msgid.link/20240904-rockchip-canfd-v5-1-8ae22bcb27cc@pengutronix.de
> Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
> 
> [...]

Here is the summary with links:
  - [net-next,01/18] dt-bindings: can: rockchip_canfd: add rockchip CAN-FD controller
    https://git.kernel.org/netdev/net-next/c/8b2f4d01f56c
  - [net-next,02/18] can: rockchip_canfd: add driver for Rockchip CAN-FD controller
    https://git.kernel.org/netdev/net-next/c/ff60bfbaf67f
  - [net-next,03/18] can: rockchip_canfd: add quirks for errata workarounds
    https://git.kernel.org/netdev/net-next/c/bbc783bb7142
  - [net-next,04/18] can: rockchip_canfd: add quirk for broken CAN-FD support
    https://git.kernel.org/netdev/net-next/c/bbdffb341498
  - [net-next,05/18] can: rockchip_canfd: add support for rk3568v3
    https://git.kernel.org/netdev/net-next/c/c158f22fe556
  - [net-next,06/18] can: rockchip_canfd: add notes about known issues
    https://git.kernel.org/netdev/net-next/c/fb999a5f9906
  - [net-next,07/18] can: rockchip_canfd: rkcanfd_handle_rx_int_one(): implement workaround for erratum 5: check for empty FIFO
    https://git.kernel.org/netdev/net-next/c/6571354269f8
  - [net-next,08/18] can: rockchip_canfd: rkcanfd_register_done(): add warning for erratum 5
    https://git.kernel.org/netdev/net-next/c/25e024c3491c
  - [net-next,09/18] can: rockchip_canfd: add TX PATH
    https://git.kernel.org/netdev/net-next/c/b6661d73290c
  - [net-next,10/18] can: rockchip_canfd: implement workaround for erratum 6
    https://git.kernel.org/netdev/net-next/c/58d3cc65a241
  - [net-next,11/18] can: rockchip_canfd: implement workaround for erratum 12
    https://git.kernel.org/netdev/net-next/c/83f9bd6bf39d
  - [net-next,12/18] can: rockchip_canfd: rkcanfd_get_berr_counter_corrected(): work around broken {RX,TX}ERRORCNT register
    https://git.kernel.org/netdev/net-next/c/7ba7111b5f9e
  - [net-next,13/18] can: rockchip_canfd: add stats support for errata workarounds
    https://git.kernel.org/netdev/net-next/c/669904d14609
  - [net-next,14/18] can: rockchip_canfd: prepare to use full TX-FIFO depth
    https://git.kernel.org/netdev/net-next/c/ae002cc32ec4
  - [net-next,15/18] can: rockchip_canfd: enable full TX-FIFO depth of 2
    https://git.kernel.org/netdev/net-next/c/a5605d61c7dd
  - [net-next,16/18] can: rockchip_canfd: add hardware timestamping support
    https://git.kernel.org/netdev/net-next/c/4e1a18bab124
  - [net-next,17/18] can: rockchip_canfd: add support for CAN_CTRLMODE_LOOPBACK
    https://git.kernel.org/netdev/net-next/c/edf1dd18c8f9
  - [net-next,18/18] can: rockchip_canfd: add support for CAN_CTRLMODE_BERR_REPORTING
    https://git.kernel.org/netdev/net-next/c/e3b5fa0f081b

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



