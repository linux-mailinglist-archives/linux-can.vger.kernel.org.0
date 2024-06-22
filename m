Return-Path: <linux-can+bounces-845-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 859F891314F
	for <lists+linux-can@lfdr.de>; Sat, 22 Jun 2024 03:20:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2B37B1F2350A
	for <lists+linux-can@lfdr.de>; Sat, 22 Jun 2024 01:20:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3FDA1FA5;
	Sat, 22 Jun 2024 01:20:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hDcy54tV"
X-Original-To: linux-can@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4329633;
	Sat, 22 Jun 2024 01:20:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719019231; cv=none; b=Jw8Yd6t2MAC5TjsQvWu9CbsMVNd7WZmnvcKLXpgdyXdL0DZ7uLUcnYPPSdEEwebwxGKNjheOXTwEIxKsTJhCocH7MYMxs12Je3oy8iMZOetot4MGfLgjKRSL4oLvnsu9C9FWodoT67hve6vw3UlAHKO0OdVwsBh5AHLbjSPQkU0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719019231; c=relaxed/simple;
	bh=qS50Z94mAvRd6jOyFngt2IluBzkX6dLoaTRS2qGYHAQ=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=oU8uPPBSnwpMxddsrHqcU1aJ/PCUTXOFmJlYjC+o5m3IIleYFoKcNtWagJMo29pvuR8mVXMAsdEVkE6aGUPpPcUn2lRNYq2EmU4fuxo76khgfR/8JslqFLvC2PhxahMgYUwI5qSvv3h0/V9qUPhaMNHrYPxI0x9mKihIKLGPeFU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hDcy54tV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 381E6C3277B;
	Sat, 22 Jun 2024 01:20:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719019231;
	bh=qS50Z94mAvRd6jOyFngt2IluBzkX6dLoaTRS2qGYHAQ=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=hDcy54tV3z+TIGh4o6ytebJ8XViITa8IrLe2YNGCB85Ev1Ac8C9FQvw9xjwhbBPmv
	 qNEKOa61Q3ZmLm7EA03krOgdosedpbPlcCUc63fSFek0UNVlSEMGdeWIzHufmCgLEQ
	 bBnHYUIlnxkS4sicPhGGH/olzhHabX0cxQntKR55H2Df0oDYNlOAvBUW4J/SedhRtM
	 rqYFYR2dYDN3pL2I/u4P6unC8+CoU2hHmF9icYQlGAtD8htzC2BH3AfnzENmWST6eB
	 ELbEtYK3s748fiHDXeFCQvBCXpoN/n4CriK/PMpAG+B2/PI8X4eV24mzmnB5odNckn
	 CJqjbPMgWMHwA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 1854CD2D0E2;
	Sat, 22 Jun 2024 01:20:31 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net 1/5] net: can: j1939: enhanced error handling for tightly
 received RTS messages in xtp_rx_rts_session_new
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171901923109.1383.11282114913538537501.git-patchwork-notify@kernel.org>
Date: Sat, 22 Jun 2024 01:20:31 +0000
References: <20240621121739.434355-2-mkl@pengutronix.de>
In-Reply-To: <20240621121739.434355-2-mkl@pengutronix.de>
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
 linux-can@vger.kernel.org, kernel@pengutronix.de, o.rempel@pengutronix.de,
 syzbot+daa36413a5cedf799ae4@syzkaller.appspotmail.com, stable@vger.kernel.org

Hello:

This series was applied to netdev/net.git (main)
by Marc Kleine-Budde <mkl@pengutronix.de>:

On Fri, 21 Jun 2024 13:23:36 +0200 you wrote:
> From: Oleksij Rempel <o.rempel@pengutronix.de>
> 
> This patch enhances error handling in scenarios with RTS (Request to
> Send) messages arriving closely. It replaces the less informative WARN_ON_ONCE
> backtraces with a new error handling method. This provides clearer error
> messages and allows for the early termination of problematic sessions.
> Previously, sessions were only released at the end of j1939_xtp_rx_rts().
> 
> [...]

Here is the summary with links:
  - [net,1/5] net: can: j1939: enhanced error handling for tightly received RTS messages in xtp_rx_rts_session_new
    https://git.kernel.org/netdev/net/c/d3e2904f71ea
  - [net,2/5] net: can: j1939: Initialize unused data in j1939_send_one()
    https://git.kernel.org/netdev/net/c/b7cdf1dd5d2a
  - [net,3/5] net: can: j1939: recover socket queue on CAN bus error during BAM transmission
    https://git.kernel.org/netdev/net/c/9ad1da14ab3b
  - [net,4/5] can: kvaser_usb: fix return value for hif_usb_send_regout
    https://git.kernel.org/netdev/net/c/0d34d8163fd8
  - [net,5/5] can: mcp251xfd: fix infinite loop when xmit fails
    https://git.kernel.org/netdev/net/c/d8fb63e46c88

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



