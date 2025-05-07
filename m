Return-Path: <linux-can+bounces-3557-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 56C67AAD317
	for <lists+linux-can@lfdr.de>; Wed,  7 May 2025 04:10:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6A03A3A3B56
	for <lists+linux-can@lfdr.de>; Wed,  7 May 2025 02:09:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B81C18952C;
	Wed,  7 May 2025 02:10:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bhLSJTig"
X-Original-To: linux-can@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33A104A11;
	Wed,  7 May 2025 02:09:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746583800; cv=none; b=MZc/iVSY4fvKu38lyfSHk50FceGeLmI0uU13FY3Jw4UVlHDpM0/ml2uXvXS4qXx/vqs/WSUS7MFiFDdiSzml/0j9+93UL9pvJXv/nrJdFbw2rzrl4wknLE8688y/JrJNpvbcrX0BX7vAtQZBIySvsF7tRI6sc2jO0crvZdhwOA0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746583800; c=relaxed/simple;
	bh=4090HR87qhYEdYmGaOt0ohnlAPYBCgR8ambKKHvt4vM=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=murgF3Y7Faijl0aI87S/rLLMtSJipPIsVt5wpMyEZz4RfkoI3WPFH+ZpCX2ykzYjmY9iqM4/wGnOZ8kfMk5qmggJIryru72QPjxquhjRH8rXTsU9whFc/UCXhcFogPeNCTl6tw1wWod91LcSf9DFet4FuTl9W+fZ1lx4ksA36Gg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bhLSJTig; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A6BCBC4CEE4;
	Wed,  7 May 2025 02:09:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746583799;
	bh=4090HR87qhYEdYmGaOt0ohnlAPYBCgR8ambKKHvt4vM=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=bhLSJTigN5q0MABqslPn9GoGogKy2e5WRCbKjxYNA3LQZMkxvmxpWGw3rZRFJFv2A
	 /pDq6uTr2EhFDfC6z6syJNi27SU24I+kxjYMOtwMSuFCPRJBrxODFCC/FuxUPGkUSN
	 Y6lTTSvQgBdzwURwUkPEFDQOUtdCq0UrRFeJPbwyytnEPzpamSGqlJfOPE2uJbbUB4
	 nOnmh+xbPCK/OkzhqcdE8fy9j9PZAgRv4nVfKL/hm5Pr9mkYmiZ7M7R7rZnwRJGW0Z
	 XoR61K8G+nec5P+2nlp9tgLAvwLYZqsSw5Yfn+ItQlbMmXuGo4W4Cx7AkrWoMwM1wF
	 4jRrl4jRJvT/Q==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EACCA380664B;
	Wed,  7 May 2025 02:10:38 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net 1/6] can: m_can: m_can_class_allocate_dev(): initialize
 spin lock on device probe
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174658383775.1710027.4745665648981488663.git-patchwork-notify@kernel.org>
Date: Wed, 07 May 2025 02:10:37 +0000
References: <20250506135939.652543-2-mkl@pengutronix.de>
In-Reply-To: <20250506135939.652543-2-mkl@pengutronix.de>
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
 linux-can@vger.kernel.org, kernel@pengutronix.de, antonios@mwa.re,
 mailhol.vincent@wanadoo.fr, msp@baylibre.com

Hello:

This series was applied to netdev/net.git (main)
by Marc Kleine-Budde <mkl@pengutronix.de>:

On Tue,  6 May 2025 15:56:17 +0200 you wrote:
> From: Antonios Salios <antonios@mwa.re>
> 
> The spin lock tx_handling_spinlock in struct m_can_classdev is not
> being initialized. This leads the following spinlock bad magic
> complaint from the kernel, eg. when trying to send CAN frames with
> cansend from can-utils:
> 
> [...]

Here is the summary with links:
  - [net,1/6] can: m_can: m_can_class_allocate_dev(): initialize spin lock on device probe
    https://git.kernel.org/netdev/net/c/dcaeeb8ae84c
  - [net,2/6] can: mcp251xfd: fix TDC setting for low data bit rates
    https://git.kernel.org/netdev/net/c/5e1663810e11
  - [net,3/6] can: mcp251xfd: mcp251xfd_remove(): fix order of unregistration calls
    https://git.kernel.org/netdev/net/c/84f5eb833f53
  - [net,4/6] can: rockchip_canfd: rkcanfd_remove(): fix order of unregistration calls
    https://git.kernel.org/netdev/net/c/037ada7a3181
  - [net,5/6] can: mcan: m_can_class_unregister(): fix order of unregistration calls
    https://git.kernel.org/netdev/net/c/0713a1b3276b
  - [net,6/6] can: gw: fix RCU/BH usage in cgw_create_job()
    https://git.kernel.org/netdev/net/c/511e64e13d8c

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



