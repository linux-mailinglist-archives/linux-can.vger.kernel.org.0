Return-Path: <linux-can+bounces-3876-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CCB3AE0A70
	for <lists+linux-can@lfdr.de>; Thu, 19 Jun 2025 17:30:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 50AAB3B373F
	for <lists+linux-can@lfdr.de>; Thu, 19 Jun 2025 15:29:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFCEC2376EB;
	Thu, 19 Jun 2025 15:29:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X4DGq0Ii"
X-Original-To: linux-can@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97888234987;
	Thu, 19 Jun 2025 15:29:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750346990; cv=none; b=qk7zwKVGfLsfGlq/ATkw9E2Qie8aLj7oNil41h2YWsIWZzM85UfclLCULUTfxB1+ewc60/IQY+UGfa8/1uK0ndVhQaySkmrn5cM794JLg3dBUH+KyQPwwJsbALEzC4efwgwmx00W7OZYl8PoIiMF5PMvj4O6DJiXy0luhaehKlc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750346990; c=relaxed/simple;
	bh=ZSB2w2pDNXAaKy02ne9tEPm0Aw1qypvq3SEaQ7Srs8Y=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=DUFFQ0VgGu/W+VF9tciWDYPfZeg4vRZpzCORz1AuiOE80IYSxkqWrQDlkr1aS4QKBtbYRRQcwajc5ALdypWwE9HNTEnICzhcxCj7u16bu3pcPFnw32T0HWmw2cTNntawGKaqbXBSBorkgtZbWdhOeUbNAn/StQQR8l/e5PRD/r0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X4DGq0Ii; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29D90C4CEEA;
	Thu, 19 Jun 2025 15:29:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750346990;
	bh=ZSB2w2pDNXAaKy02ne9tEPm0Aw1qypvq3SEaQ7Srs8Y=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=X4DGq0IizGuIk6r5CxkyYx/g7ofGRTY3GyjSjc8deeXLTd9WkaCexvt4MDjT6e5fC
	 Fj1jjpzs8KlsHiiZvdCBkx4cubU5fUg5SbAGokDdDSNf7ZrDoct1dB6tn7dgxaRPsK
	 0wVJx94ld48e2S8kZIwez/I8BHoAjjVjC1iph5xHbR0CS2BvN/W7xckNBX3J21IhYp
	 qT0Z94cIKWfQywNpiS17Od3Hri7l5huWWDd0WVkFCG3QUfsLPMchJKq9xOO+kdFHFj
	 kXRzOZB12W233eaisWXDLK979FOa+mZNV2LhdGIM9xPXU1Qw5Mv/UH8J6a0r4Gu2Zk
	 a3ezRaIaOyrgw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70CD138111DD;
	Thu, 19 Jun 2025 15:30:19 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next 01/10] can: rcar_canfd: Consistently use ndev for
 net_device pointers
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175034701825.902685.14496314972839844896.git-patchwork-notify@kernel.org>
Date: Thu, 19 Jun 2025 15:30:18 +0000
References: <20250618092336.2175168-2-mkl@pengutronix.de>
In-Reply-To: <20250618092336.2175168-2-mkl@pengutronix.de>
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
 linux-can@vger.kernel.org, kernel@pengutronix.de, geert+renesas@glider.be,
 mailhol.vincent@wanadoo.fr

Hello:

This series was applied to netdev/net-next.git (main)
by Marc Kleine-Budde <mkl@pengutronix.de>:

On Wed, 18 Jun 2025 11:19:55 +0200 you wrote:
> From: Geert Uytterhoeven <geert+renesas@glider.be>
> 
> Most net_device pointers are named "ndev", but some are called "dev".
> Increase uniformity by always using "ndev".
> 
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> Reviewed-by: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
> Link: https://patch.msgid.link/7593bdd484a35999030865f90e4c9063b22d2a54.1749655315.git.geert+renesas@glider.be
> Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
> 
> [...]

Here is the summary with links:
  - [net-next,01/10] can: rcar_canfd: Consistently use ndev for net_device pointers
    https://git.kernel.org/netdev/net-next/c/df6b192e25df
  - [net-next,02/10] can: rcar_canfd: Remove bittiming debug prints
    https://git.kernel.org/netdev/net-next/c/a62781343160
  - [net-next,03/10] can: rcar_canfd: Add helper variable ndev to rcar_canfd_rx_pkt()
    https://git.kernel.org/netdev/net-next/c/4e5974f5515b
  - [net-next,04/10] can: rcar_canfd: Add helper variable dev to rcar_canfd_reset_controller()
    https://git.kernel.org/netdev/net-next/c/1f9b5003d4ba
  - [net-next,05/10] can: rcar_canfd: Simplify data access in rcar_canfd_{ge,pu}t_data()
    https://git.kernel.org/netdev/net-next/c/f5e3150b1a0f
  - [net-next,06/10] can: rcar_canfd: Repurpose f_dcfg base for other registers
    https://git.kernel.org/netdev/net-next/c/e4d8eb97a469
  - [net-next,07/10] can: rcar_canfd: Rename rcar_canfd_setrnc() to rcar_canfd_set_rnc()
    https://git.kernel.org/netdev/net-next/c/1b76dca8fd89
  - [net-next,08/10] can: rcar_canfd: Share config code in rcar_canfd_set_bittiming()
    https://git.kernel.org/netdev/net-next/c/0a0c94c682fd
  - [net-next,09/10] can: rcar_canfd: Return early in rcar_canfd_set_bittiming() when not FD
    https://git.kernel.org/netdev/net-next/c/0acd46190ea2
  - [net-next,10/10] can: rcar_canfd: Add support for Transceiver Delay Compensation
    https://git.kernel.org/netdev/net-next/c/586d5eecdf14

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



