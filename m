Return-Path: <linux-can+bounces-2314-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CC8F89E111A
	for <lists+linux-can@lfdr.de>; Tue,  3 Dec 2024 03:10:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0450CB2222D
	for <lists+linux-can@lfdr.de>; Tue,  3 Dec 2024 02:10:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E20BC81ADA;
	Tue,  3 Dec 2024 02:10:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JIW+0wl6"
X-Original-To: linux-can@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B036C219E4;
	Tue,  3 Dec 2024 02:10:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733191819; cv=none; b=FqbzwyQ1T/AYsWQOyum3/hcnL3pqFJv6I9FJU7LzA2xwIcsZaR3EWesihESuaPHbs1qmkA+cHDJQece+URt+O52rYW+ZLlrKZKmzXpQkAvsmMWImADbNbl6dsqtGvRj4vYd551LKuj95KRy5Pi9EawRvj+XG8HS04cGrr3yeLQQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733191819; c=relaxed/simple;
	bh=VCw0se1R4PfQJFWrA7XvWz6U4ulPMrfws62VNJxPBjQ=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=g+23C4B86JPHX7UBp9VeqfBErDENdXe/RdnP1sK/9dG+A0P/u8IQzIXXrTHPWGaNyyQUC6eHcPir49AEX9vTXlTgkiwnq/bbW7F8v1tYnynNuQ5SpTpQwK98fY7MQuVver1gIqBZb8j/hkadYfNGjl64rYWvDRTnRz8W9KwAZ1A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JIW+0wl6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1CA07C4CED2;
	Tue,  3 Dec 2024 02:10:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733191819;
	bh=VCw0se1R4PfQJFWrA7XvWz6U4ulPMrfws62VNJxPBjQ=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=JIW+0wl6bIuoLaJml0J5K8aUbsp9YtRiSxHEu0lf4l+tzQqGnZY4FJ70sSMFhR0Lw
	 EhcJ3/SAoxEnlOjUy7gb3tzkrtQx49sQq3wzqpodhOXg/Vewm3ytS7GgsBKQPo6DMw
	 WPFjZRX3zNippafRbpBuX9tGzjiYlP8LET1dVXlzBdasNnvGiu2SOEb+Q/eHyhB3vF
	 T1b2YM0U1oFnhCzU1Z1K5pbmRYzU5Q48EtuCdwoFxxiME3t+kU8KXoyhE6avEiBldw
	 lx+Bd9vB1SJWKKdUYiOgbADOSelxOoqirf+xjvpbcMnA+VotdBWiQWYAqfR+SP+3Tj
	 ta5dfJ6/s0/nQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 7194D3806656;
	Tue,  3 Dec 2024 02:10:34 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net 01/15] can: dev: can_set_termination(): allow sleeping
 GPIOs
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173319183325.3990091.10550590586093973028.git-patchwork-notify@kernel.org>
Date: Tue, 03 Dec 2024 02:10:33 +0000
References: <20241202090040.1110280-2-mkl@pengutronix.de>
In-Reply-To: <20241202090040.1110280-2-mkl@pengutronix.de>
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
 linux-can@vger.kernel.org, kernel@pengutronix.de, nb@tipi-net.de,
 l.sanfilippo@kunbus.com, stable@vger.kernel.org, l.goehrs@pengutronix.de

Hello:

This series was applied to netdev/net.git (main)
by Marc Kleine-Budde <mkl@pengutronix.de>:

On Mon,  2 Dec 2024 09:55:35 +0100 you wrote:
> In commit 6e86a1543c37 ("can: dev: provide optional GPIO based
> termination support") GPIO based termination support was added.
> 
> For no particular reason that patch uses gpiod_set_value() to set the
> GPIO. This leads to the following warning, if the systems uses a
> sleeping GPIO, i.e. behind an I2C port expander:
> 
> [...]

Here is the summary with links:
  - [net,01/15] can: dev: can_set_termination(): allow sleeping GPIOs
    https://git.kernel.org/netdev/net/c/ee1dfbdd8b4b
  - [net,02/15] can: gs_usb: add usb endpoint address detection at driver probe step
    https://git.kernel.org/netdev/net/c/889b2ae9139a
  - [net,03/15] can: c_can: c_can_handle_bus_err(): update statistics if skb allocation fails
    https://git.kernel.org/netdev/net/c/9e66242504f4
  - [net,04/15] can: sun4i_can: sun4i_can_err(): call can_change_state() even if cf is NULL
    https://git.kernel.org/netdev/net/c/ee6bf3677ae0
  - [net,05/15] can: hi311x: hi3110_can_ist(): fix potential use-after-free
    https://git.kernel.org/netdev/net/c/9ad86d377ef4
  - [net,06/15] can: hi311x: hi3110_can_ist(): update state error statistics if skb allocation fails
    https://git.kernel.org/netdev/net/c/ef5034aed9e0
  - [net,07/15] can: m_can: m_can_handle_lec_err(): fix {rx,tx}_errors statistics
    https://git.kernel.org/netdev/net/c/988d4222bf90
  - [net,08/15] can: ifi_canfd: ifi_canfd_handle_lec_err(): fix {rx,tx}_errors statistics
    https://git.kernel.org/netdev/net/c/bb03d568bb21
  - [net,09/15] can: hi311x: hi3110_can_ist(): fix {rx,tx}_errors statistics
    https://git.kernel.org/netdev/net/c/3e4645931655
  - [net,10/15] can: sja1000: sja1000_err(): fix {rx,tx}_errors statistics
    https://git.kernel.org/netdev/net/c/2c4ef3af4b02
  - [net,11/15] can: sun4i_can: sun4i_can_err(): fix {rx,tx}_errors statistics
    https://git.kernel.org/netdev/net/c/595a81988a6f
  - [net,12/15] can: ems_usb: ems_usb_rx_err(): fix {rx,tx}_errors statistics
    https://git.kernel.org/netdev/net/c/72a7e2e74b30
  - [net,13/15] can: f81604: f81604_handle_can_bus_errors(): fix {rx,tx}_errors statistics
    https://git.kernel.org/netdev/net/c/d7b916540c2b
  - [net,14/15] can: mcp251xfd: mcp251xfd_get_tef_len(): work around erratum DS80000789E 6.
    https://git.kernel.org/netdev/net/c/30447a1bc0e0
  - [net,15/15] can: j1939: j1939_session_new(): fix skb reference counting
    https://git.kernel.org/netdev/net/c/a8c695005bfe

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



