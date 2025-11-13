Return-Path: <linux-can+bounces-5387-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 72049C575E3
	for <lists+linux-can@lfdr.de>; Thu, 13 Nov 2025 13:21:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 781183B7B36
	for <lists+linux-can@lfdr.de>; Thu, 13 Nov 2025 12:20:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28071346FD1;
	Thu, 13 Nov 2025 12:20:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AgRIfmuX"
X-Original-To: linux-can@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1F2433892C;
	Thu, 13 Nov 2025 12:20:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763036453; cv=none; b=B8prnk3oGnyNE5/lxIEexSDzIA3WgocVVvvZ5ZrUvWXAedEweDW2GLAYF6TrWZQwCkcZtBNGrqArTua8Q+9QQcuc38pNr2PI2GKBAr9Pt/TRJAvLCVvxetmWol/8K938bDQHUZVvzsi9FQD5h3nu/k4/xuEwhnV/teYAs9onG1Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763036453; c=relaxed/simple;
	bh=WPZ/PMSUdrsmENqsS8f6oXSkaA59QGpGniqPyKJmJY8=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=gHQ/t+57sMpRr64qO3lVelT4s41vFINbJK3PVTJx7VuOOQTAUFQeNDFiV4AyCc9g7KThaXdW74AElqoFgkA7eDVSmxOM/9i7aquB0t5Go7AHnpJNWHvWEf7FB6hS5gKgKX5uSgoaqG488YgzrW62yWKFVR11MRx+sA19HsITSMA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AgRIfmuX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A8D8C113D0;
	Thu, 13 Nov 2025 12:20:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763036452;
	bh=WPZ/PMSUdrsmENqsS8f6oXSkaA59QGpGniqPyKJmJY8=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=AgRIfmuXaMbFr8JtfBk5Z6Tj1C3u39sak52ZvU1453PVp+C1r5yrdVExb0Lf8ICPJ
	 42hHvB1sTjvERmTGOpHHbuMtAaCsJpYKFOF/0K5zBc7P5Rexuaa3TcoMfJ9F7WpXY+
	 8TalR6TzBbIK7XvbD9Or7PoPYu55ev6zWxStRQk/Gg/4YBDRlFWDU/GgN/b3Hh4MTF
	 zWPjBGVj5jTQlUSxeYqwxo2wW7w4C/LzBZDUMpBoPW7rU6vB4B1+8mFfOxZ5zlTBcq
	 kh7LAfD15AOfDStKsrXXxljjfjLp4CZ3G7L59Y0wqi+jS4vzjJpjWKrvnSrjFzLOlm
	 ndSUIu0f4pFDQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EAE5D3809A04;
	Thu, 13 Nov 2025 12:20:22 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next 01/11] can: convert generic HW timestamp ioctl to
 ndo_hwtstamp callbacks
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176303642176.827815.4793852893285928062.git-patchwork-notify@kernel.org>
Date: Thu, 13 Nov 2025 12:20:21 +0000
References: <20251112184344.189863-2-mkl@pengutronix.de>
In-Reply-To: <20251112184344.189863-2-mkl@pengutronix.de>
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
 linux-can@vger.kernel.org, kernel@pengutronix.de, vadim.fedorenko@linux.dev,
 kory.maincent@bootlin.com, mailhol@kernel.org

Hello:

This series was applied to netdev/net-next.git (main)
by Marc Kleine-Budde <mkl@pengutronix.de>:

On Wed, 12 Nov 2025 19:40:20 +0100 you wrote:
> From: Vadim Fedorenko <vadim.fedorenko@linux.dev>
> 
> Can has generic implementation of ndo_eth_ioctl which implements only HW
> timestamping commands. Implement generic ndo_hwtstamp callbacks and use
> it in drivers instead of generic ioctl interface.
> 
> Signed-off-by: Vadim Fedorenko <vadim.fedorenko@linux.dev>
> Reviewed-by: Kory Maincent <kory.maincent@bootlin.com>
> Reviewed-by: Vincent Mailhol <mailhol@kernel.org>
> Link: https://patch.msgid.link/20251029231620.1135640-2-vadim.fedorenko@linux.dev
> Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
> 
> [...]

Here is the summary with links:
  - [net-next,01/11] can: convert generic HW timestamp ioctl to ndo_hwtstamp callbacks
    (no matching commit)
  - [net-next,02/11] can: peak_canfd: convert to use ndo_hwtstamp callbacks
    https://git.kernel.org/netdev/net-next/c/336e22325830
  - [net-next,03/11] can: peak_usb: convert to use ndo_hwtstamp callbacks
    (no matching commit)
  - [net-next,04/11] can: mcp251x: mcp251x_can_probe(): use dev_err_probe()
    https://git.kernel.org/netdev/net-next/c/5cf236b89f4a
  - [net-next,05/11] can: mcp251xfd: move chip sleep mode into runtime pm
    https://git.kernel.org/netdev/net-next/c/71df9227ba9c
  - [net-next,06/11] can: mcp251xfd: utilize gather_write function for all non-CRC writes
    https://git.kernel.org/netdev/net-next/c/f5982a679a16
  - [net-next,07/11] can: mcp251xfd: add workaround for errata 5
    https://git.kernel.org/netdev/net-next/c/c902835fc6eb
  - [net-next,08/11] can: mcp251xfd: only configure PIN1 when rx_int is set
    https://git.kernel.org/netdev/net-next/c/d35fa005f5e6
  - [net-next,09/11] can: mcp251xfd: add gpio functionality
    https://git.kernel.org/netdev/net-next/c/c6106336ec2b
  - [net-next,10/11] dt-bindings: can: mcp251xfd: add gpio-controller property
    https://git.kernel.org/netdev/net-next/c/6ece6b4c3747
  - [net-next,11/11] can: bxcan: Fix a typo error for assign
    https://git.kernel.org/netdev/net-next/c/b305fbdad4ed

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



