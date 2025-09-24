Return-Path: <linux-can+bounces-4909-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 32DFCB97D6B
	for <lists+linux-can@lfdr.de>; Wed, 24 Sep 2025 02:00:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5B7B219C68C8
	for <lists+linux-can@lfdr.de>; Wed, 24 Sep 2025 00:00:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04951524F;
	Wed, 24 Sep 2025 00:00:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XBA6AimS"
X-Original-To: linux-can@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFF381862;
	Wed, 24 Sep 2025 00:00:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758672022; cv=none; b=oCCi1+gdCGYJZME2gxNhMTOKKDGrNceOtjN6epodfLEtUEuVCORi+G+y/kjcQQB6BgZWDcgm5Xf55jI7oczFMeCRFCoUK7YKJ06FRZTJyDAuZaRubU7nS/canC5hc1b1n/wMFIV+vB/+3UVHnIjk+KK+81BQJf44MSxALYzKRlo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758672022; c=relaxed/simple;
	bh=IPOUXZRpPCKo9EsM7cRGDcNzDaViPFcu5W1XAdj51Js=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=r5lJLabVpy9yhPlI41yRrssM6GgNxIWsreDn4IYauDw1ufgGQu0jEOFqfWX3XizFrHpbydEzAR1IFtUFJOlYQEXdo7oL1ssUhFCWN2qlP9QDUvrdHoE7a6lbxKguVb7IL7iCOKiluRfUEr9LbzHeSPjZwPhqKC9mCjzsxLut/eA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XBA6AimS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5053FC4CEF5;
	Wed, 24 Sep 2025 00:00:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758672022;
	bh=IPOUXZRpPCKo9EsM7cRGDcNzDaViPFcu5W1XAdj51Js=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=XBA6AimSOkk+PviYkned9GW6/ee6J+1DeUr1SZVEOQTgsEG5rnDLSUDyJkSOGt5ad
	 8vqPUMGcbHuh7F/dX7FnGiJtMWwVlVlyBE/uXc8/olF2aIai6ku8lPzy5HgOd9Q8rV
	 ellI8/5vsQy+lxf908PReRaJQdZlJSg+dgEvLliwh6SdaD9OPnMHw7wivkQn0pOq+X
	 XsnsJh39baQgu/b6iry+4nUjTEzNfd391yJs4s/+HtaAvcOH5GpL8WTcIivN46YeGR
	 743F5ME1jIuf6DVTkaMUcbkYOUobRWl6rpS6a+C9x68KE9k6t5PTdXWt9ZUaO2zNUU
	 mi7AQkJmyRirA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 7115A39D0C20;
	Wed, 24 Sep 2025 00:00:20 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net 1/7] can: hi311x: fix null pointer dereference when
 resuming from sleep before interface was enabled
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175867201903.1967235.17720180740461695292.git-patchwork-notify@kernel.org>
Date: Wed, 24 Sep 2025 00:00:19 +0000
References: <20250923073427.493034-2-mkl@pengutronix.de>
In-Reply-To: <20250923073427.493034-2-mkl@pengutronix.de>
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
 linux-can@vger.kernel.org, kernel@pengutronix.de, chenyufeng@iie.ac.cn

Hello:

This series was applied to netdev/net.git (main)
by Marc Kleine-Budde <mkl@pengutronix.de>:

On Tue, 23 Sep 2025 09:32:47 +0200 you wrote:
> From: Chen Yufeng <chenyufeng@iie.ac.cn>
> 
> This issue is similar to the vulnerability in the `mcp251x` driver,
> which was fixed in commit 03c427147b2d ("can: mcp251x: fix resume from
> sleep before interface was brought up").
> 
> In the `hi311x` driver, when the device resumes from sleep, the driver
> schedules `priv->restart_work`. However, if the network interface was
> not previously enabled, the `priv->wq` (workqueue) is not allocated and
> initialized, leading to a null pointer dereference.
> 
> [...]

Here is the summary with links:
  - [net,1/7] can: hi311x: fix null pointer dereference when resuming from sleep before interface was enabled
    https://git.kernel.org/netdev/net/c/6b6968084721
  - [net,2/7] can: rcar_canfd: Fix controller mode setting
    https://git.kernel.org/netdev/net/c/5cff263606a1
  - [net,3/7] can: etas_es58x: populate ndo_change_mtu() to prevent buffer overflow
    https://git.kernel.org/netdev/net/c/38c0abad45b1
  - [net,4/7] can: hi311x: populate ndo_change_mtu() to prevent buffer overflow
    https://git.kernel.org/netdev/net/c/ac1c7656fa71
  - [net,5/7] can: sun4i_can: populate ndo_change_mtu() to prevent buffer overflow
    https://git.kernel.org/netdev/net/c/61da0bd4102c
  - [net,6/7] can: mcba_usb: populate ndo_change_mtu() to prevent buffer overflow
    https://git.kernel.org/netdev/net/c/17c8d794527f
  - [net,7/7] can: peak_usb: fix shift-out-of-bounds issue
    https://git.kernel.org/netdev/net/c/c443be70aaee

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



