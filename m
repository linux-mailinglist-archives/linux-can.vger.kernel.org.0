Return-Path: <linux-can+bounces-416-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A17188858F3
	for <lists+linux-can@lfdr.de>; Thu, 21 Mar 2024 13:20:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 30352281237
	for <lists+linux-can@lfdr.de>; Thu, 21 Mar 2024 12:20:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7747658AA8;
	Thu, 21 Mar 2024 12:20:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eLY6I6Ts"
X-Original-To: linux-can@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5010E224F2;
	Thu, 21 Mar 2024 12:20:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711023627; cv=none; b=ro34JzNr1vF5mr6KTk2NH0+gttrMV6/sNICVhU5pNUcURfsx/uuU0YmNRrMsN8pwxeoE6rl44gZ+/LIUesx5RB2L9LK23muvOxwaMFXFN6yPw4S3/buyRSw2XKM/UN6XTsgSMNSksYzR80ODgOI0tOC9MblJ+wrhDa3u3F0nQD8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711023627; c=relaxed/simple;
	bh=4xODFq2LLOy1tfPRzS4t71xByz+/RagAPrV508MM7Co=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=DfWPnI/f/cLoH2Ps7CxzAf/fChxSWJEOJw/2S8E8N/j8JAcipg6cHrd41CkXc1JI+PHJVlSh7kOARvr2BVrPnypR0pvmgtuSb3nfxEQnRxTdrnzggP+6giXA92cE2TAr6BmnkecaW8kNrWv5/glnssyWnO1+Ct3e4fbjsuEP4JM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eLY6I6Ts; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id D09F7C43390;
	Thu, 21 Mar 2024 12:20:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711023626;
	bh=4xODFq2LLOy1tfPRzS4t71xByz+/RagAPrV508MM7Co=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=eLY6I6TsE/v27/QpTEmYeBQKlyqcIfKkefLMefUvasoreoEK3wKX5ozSPWqI6yDvd
	 89qVvOg5TayYD0leAGRkEFQZCaaH6Shw3gvffNH8lFttLtOElt9q1wxDiJZ+KrYfm0
	 QgKyJ9eS2cZE9YnufL9zpJsaYwwENKG6jNStfc62De9kLmMi90gV34oa65MyAm3El9
	 fV+ep3r36650bqpb+OaQWPZMxBcYGeM1VS7r7BsRwHlsAR6ec/IQL+WfQKXTFTOd30
	 Zn+NyBFK3DFdLDZTAVoB3ROxcc8U7i28pFLpi9t6rKheNpU7bC5WRiL0UqrNjtb7RI
	 A5n8Mrsrs4rMw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id BFFD9D982E3;
	Thu, 21 Mar 2024 12:20:26 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] can: kvaser_pciefd: Add additional Xilinx interrupts
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171102362678.4643.10285446325586255117.git-patchwork-notify@kernel.org>
Date: Thu, 21 Mar 2024 12:20:26 +0000
References: <20240320112144.582741-2-mkl@pengutronix.de>
In-Reply-To: <20240320112144.582741-2-mkl@pengutronix.de>
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
 linux-can@vger.kernel.org, kernel@pengutronix.de, martin.jocic@kvaser.com

Hello:

This patch was applied to netdev/net.git (main)
by Marc Kleine-Budde <mkl@pengutronix.de>:

On Wed, 20 Mar 2024 11:50:26 +0100 you wrote:
> From: Martin Jocić <martin.jocic@kvaser.com>
> 
> Since Xilinx-based adapters now support up to eight CAN channels, the
> TX interrupt mask array must have eight elements.
> 
> Signed-off-by: Martin Jocic <martin.jocic@kvaser.com>
> Link: https://lore.kernel.org/all/2ab3c0585c3baba272ede0487182a423a420134b.camel@kvaser.com
> Fixes: 9b221ba452aa ("can: kvaser_pciefd: Add support for Kvaser PCIe 8xCAN")
> [mkl: replace Link by Fixes tag]
> Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
> 
> [...]

Here is the summary with links:
  - [net] can: kvaser_pciefd: Add additional Xilinx interrupts
    https://git.kernel.org/netdev/net/c/af1752ecdc9c

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



