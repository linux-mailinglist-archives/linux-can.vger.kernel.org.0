Return-Path: <linux-can+bounces-3666-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FE77AC0A32
	for <lists+linux-can@lfdr.de>; Thu, 22 May 2025 13:00:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1AD1216661B
	for <lists+linux-can@lfdr.de>; Thu, 22 May 2025 11:00:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71200288503;
	Thu, 22 May 2025 11:00:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N9BW4/8W"
X-Original-To: linux-can@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42ED920328;
	Thu, 22 May 2025 11:00:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747911601; cv=none; b=jsd51Jq9Wi0r+MQ75U2JQ8AGHCjUCfJFqyMzXezhrrLLaEJEetbZsKgkr9LTTBDimdEXsjnfo8zzCpA/5X8whSM2tmigPYjw3cJtBPpY9pCmpi9BhmbGUE0uuxvqK0vTeLHdm5c/YsXMG/SHvNF1D6FxKtDFeTxm4/UL0ppxFdQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747911601; c=relaxed/simple;
	bh=HFpUF2RaWj4gSxHDTBnAM8QLGbiYT6gBPG+NojTpX8Y=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=txF5eTi5SREJr90q2UCfm74Oose2pLuXhCHbFnhYeb5lY8KwPdplP4M/rhxCOeZ6ig4X0f3YqiPeZgwfHTvxd0P3FKAHCHt2uouuoKGznx0sguYHPCbe03aJZhR5fWBw+WSB4I+shm+Y5cQiQmb2pu1DzmWDGoZNDJ00+RGiP+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N9BW4/8W; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB413C4CEE4;
	Thu, 22 May 2025 11:00:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747911600;
	bh=HFpUF2RaWj4gSxHDTBnAM8QLGbiYT6gBPG+NojTpX8Y=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=N9BW4/8WbbbmpHzQ9bch0D29iH/MSxh4hJKkzYlGIODey7GgScT2KULR/YRQSRpF7
	 YuFZZpv+NeU3qsS0NefEvsTWgDtQhwXlVlJ5SQBeh7l5EDdbkgAga/rGHOTX1wP06f
	 pMu64ykm+oe/ZKrEerP3p/SGYxknsc8RUdHkGSYvZyNeKWS3Oqun5aNyYT/8hd+wL2
	 ztfo8gdW8+OPc7P7XXNK0m8HeysJmuYfTf6KaqHuo+Fl1c0noGgNe9VgR6DTTCxF8D
	 sLZC3T2uMk37QY4cwYpy5GFmmJb8j87/pHZRIjKDmSSYOiWJURQ0Q5M+l21wLSkZI+
	 tbO1MoNAdxpJg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 71A7D3805D89;
	Thu, 22 May 2025 11:00:37 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net 1/4] can: kvaser_pciefd: Force IRQ edge in case of nested
 IRQ
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174791163626.2831359.15551228783449050494.git-patchwork-notify@kernel.org>
Date: Thu, 22 May 2025 11:00:36 +0000
References: <20250522082344.490913-2-mkl@pengutronix.de>
In-Reply-To: <20250522082344.490913-2-mkl@pengutronix.de>
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
 linux-can@vger.kernel.org, kernel@pengutronix.de, axfo@kvaser.com,
 stable@vger.kernel.org, extja@kvaser.com

Hello:

This series was applied to netdev/net.git (main)
by Marc Kleine-Budde <mkl@pengutronix.de>:

On Thu, 22 May 2025 10:01:31 +0200 you wrote:
> From: Axel Forsman <axfo@kvaser.com>
> 
> Avoid the driver missing IRQs by temporarily masking IRQs in the ISR
> to enforce an edge even if a different IRQ is signalled before handled
> IRQs are cleared.
> 
> Fixes: 48f827d4f48f ("can: kvaser_pciefd: Move reset of DMA RX buffers to the end of the ISR")
> Cc: stable@vger.kernel.org
> Signed-off-by: Axel Forsman <axfo@kvaser.com>
> Tested-by: Jimmy Assarsson <extja@kvaser.com>
> Reviewed-by: Jimmy Assarsson <extja@kvaser.com>
> Link: https://patch.msgid.link/20250520114332.8961-2-axfo@kvaser.com
> Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
> 
> [...]

Here is the summary with links:
  - [net,1/4] can: kvaser_pciefd: Force IRQ edge in case of nested IRQ
    https://git.kernel.org/netdev/net/c/9176bd205ee0
  - [net,2/4] can: kvaser_pciefd: Fix echo_skb race
    https://git.kernel.org/netdev/net/c/8256e0ca6010
  - [net,3/4] can: kvaser_pciefd: Continue parsing DMA buf after dropped RX
    https://git.kernel.org/netdev/net/c/6d820b81c4dc
  - [net,4/4] can: slcan: allow reception of short error messages
    https://git.kernel.org/netdev/net/c/ef0841e4cb08

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



