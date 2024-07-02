Return-Path: <linux-can+bounces-939-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3853291ED6C
	for <lists+linux-can@lfdr.de>; Tue,  2 Jul 2024 05:20:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DE4001F22E38
	for <lists+linux-can@lfdr.de>; Tue,  2 Jul 2024 03:20:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF10F225CF;
	Tue,  2 Jul 2024 03:20:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HI+B9hUU"
X-Original-To: linux-can@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94DD314293;
	Tue,  2 Jul 2024 03:20:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719890431; cv=none; b=UYhkuwbV/1zIJXNkCTa3mZHSoLwlxc5GLDJ5S+vXFdbrN2XIN4Giw+C2WZYXLWrBM0hV45YCEddnCfXjMM9YDR6p84nqzID60+UJixFWWPhRxqAT+sOgkyfOCo+XIpCHFP5U7xg4blTfTWORcKVTr9iY6Jx/xrSqNB7xdl+yRDA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719890431; c=relaxed/simple;
	bh=8SwA2nIhj41tQzxjrQG5hMHOvRhYR1wjkAviDns83Hs=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=mOS+z2mdHkdwP/FVXUtrpmwe9opfELs4F7LS4oMRARNfSaKmTi2xgBq+b4kKJTjWBtGOFCc4za5EGr2SCbB+shLHFVYVmkflVXixtAIYv/AitsvhhrDRD2U58+BKPFej5YuYtrAGMquGt6GrKszsJs8qblfzzLLblHvUfytQp2c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HI+B9hUU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 70DC8C4AF0A;
	Tue,  2 Jul 2024 03:20:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719890431;
	bh=8SwA2nIhj41tQzxjrQG5hMHOvRhYR1wjkAviDns83Hs=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=HI+B9hUUXoNgJk7/C2nWFV7AM7Skrusk/ybvSaH9l7O57nE4oWA4m/o742EJ89wJi
	 eIFl4RGBRxx+iiPvZ4g8+v/6Gc4lxRGosxZpHuj2GKmVHD1zBdtOHCmtbFPW9aygvE
	 iI+oLJsTW07J12TlUUTB/EqICqZacJPVnhi/LU3l6sTwqyR7wC+eFcpNCc4XG4aL05
	 1gGaUOk6E9hFdVxBGHVOdjdV1FuLWJkzY4h8ouMfTmME+7KvmCcIdE2VxTVVm8zZB4
	 cyK1P1cdTiWnZ2q0bRyoMvmjixuPNFuGsFDkBAnn2Q9HbiRsbXJKK8Qb0PFQ/Vni9e
	 tECJMyijz2GhA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 6659AC43446;
	Tue,  2 Jul 2024 03:20:31 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next 01/14] can: rcar_canfd: Simplify clock handling
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171989043141.2079.6249590029135979872.git-patchwork-notify@kernel.org>
Date: Tue, 02 Jul 2024 03:20:31 +0000
References: <20240629114017.1080160-2-mkl@pengutronix.de>
In-Reply-To: <20240629114017.1080160-2-mkl@pengutronix.de>
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
 linux-can@vger.kernel.org, kernel@pengutronix.de, geert+renesas@glider.be,
 wsa+renesas@sang-engineering.com, mailhol.vincent@wanadoo.fr

Hello:

This series was applied to netdev/net-next.git (main)
by Marc Kleine-Budde <mkl@pengutronix.de>:

On Sat, 29 Jun 2024 13:36:15 +0200 you wrote:
> From: Geert Uytterhoeven <geert+renesas@glider.be>
> 
> The main CAN clock is either the internal CANFD clock, or the external
> CAN clock.  Hence replace the two-valued enum by a simple boolean flag.
> Consolidate all CANFD clock handling inside a single branch.
> 
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> Reviewed-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
> Reviewed-by: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
> Link: https://lore.kernel.org/all/2cf38c10b83c8e5c04d68b17a930b6d9dbf66f40.1716973640.git.geert+renesas@glider.be
> Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
> 
> [...]

Here is the summary with links:
  - [net-next,01/14] can: rcar_canfd: Simplify clock handling
    https://git.kernel.org/netdev/net-next/c/dd20d16dae83
  - [net-next,02/14] can: rcar_canfd: Improve printing of global operational state
    https://git.kernel.org/netdev/net-next/c/0c1d0a69c5e7
  - [net-next,03/14] can: rcar_canfd: Remove superfluous parentheses in address calculations
    https://git.kernel.org/netdev/net-next/c/f9a83965d40e
  - [net-next,04/14] can: m_can: Constify struct m_can_ops
    https://git.kernel.org/netdev/net-next/c/62d73261a0cf
  - [net-next,05/14] can: gs_usb: add VID/PID for Xylanta SAINT3 product family
    https://git.kernel.org/netdev/net-next/c/69e2326a21ef
  - [net-next,06/14] can: mcp251xfd: properly indent labels
    https://git.kernel.org/netdev/net-next/c/51b2a7216122
  - [net-next,07/14] can: mcp251xfd: update errata references
    https://git.kernel.org/netdev/net-next/c/71c45e6e0b42
  - [net-next,08/14] can: mcp251xfd: move mcp251xfd_timestamp_start()/stop() into mcp251xfd_chip_start/stop()
    https://git.kernel.org/netdev/net-next/c/a7801540f325
  - [net-next,09/14] can: mcp251xfd: clarify the meaning of timestamp
    https://git.kernel.org/netdev/net-next/c/e793c724b48c
  - [net-next,10/14] can: mcp251xfd: mcp251xfd_handle_rxif_ring_uinc(): factor out in separate function
    https://git.kernel.org/netdev/net-next/c/d49184b7b585
  - [net-next,11/14] can: mcp251xfd: rx: prepare to workaround broken RX FIFO head index erratum
    https://git.kernel.org/netdev/net-next/c/85505e585637
  - [net-next,12/14] can: mcp251xfd: rx: add workaround for erratum DS80000789E 6 of mcp2518fd
    https://git.kernel.org/netdev/net-next/c/24436be590c6
  - [net-next,13/14] can: mcp251xfd: tef: prepare to workaround broken TEF FIFO tail index erratum
    https://git.kernel.org/netdev/net-next/c/b8e0ddd36ce9
  - [net-next,14/14] can: mcp251xfd: tef: update workaround for erratum DS80000789E 6 of mcp2518fd
    https://git.kernel.org/netdev/net-next/c/3a0a88fcbaf9

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



