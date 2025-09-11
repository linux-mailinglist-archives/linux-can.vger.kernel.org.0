Return-Path: <linux-can+bounces-4659-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B7EC4B52696
	for <lists+linux-can@lfdr.de>; Thu, 11 Sep 2025 04:40:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2CAA24480F6
	for <lists+linux-can@lfdr.de>; Thu, 11 Sep 2025 02:40:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7C5721D3F5;
	Thu, 11 Sep 2025 02:40:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mrHMwxra"
X-Original-To: linux-can@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EBE621C19D;
	Thu, 11 Sep 2025 02:40:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757558420; cv=none; b=OSQB7WhylzBrXbc9jfRX7mE7+t6RV9rA1Ma0/phGJqihfW9wqsvU89bz0iDsz5pfE5ZWSXnxgZkXFzdgcHRss8jZOdEr6duuhuVGcw19oogD4sLh5GxmLs1r8X8oCvc+mnS10MmjKwfFJoRQZlrmm7Li6tDLoNhgCu6R1XC+qnw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757558420; c=relaxed/simple;
	bh=yXX0ciaOgTLlGLfQZM4ao6VRjuogvEm4zpBWRGse8jw=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=IucGIAvpM8+ey6N+GHvkQag5VKdlF0Fmes56J6YEE2vbEQBJB2vZSXDrZSUTybtxDkf4b0/h0b7GTz+Dafse2PoGfo5ljqSqIZ3iFE81ANbRUoZsAEmMKiaZYdHBno/aTYyedVw5PKuVS9eqku2KIhM/r+4MkenkZd3g5pfsC1s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mrHMwxra; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 64412C4CEF0;
	Thu, 11 Sep 2025 02:40:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757558420;
	bh=yXX0ciaOgTLlGLfQZM4ao6VRjuogvEm4zpBWRGse8jw=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=mrHMwxraLQimqiYHkOhQVy9Niqv4ytL+r76uQMvZ7irGRNiPQsPj+Y7+V6NsoKPgT
	 sj4/iZL2/5S+CqmmUEdhNmihuu7jgHwE9xV3SA3I5FCWZedUltNDfHc9UEjRx5Ddse
	 Jzv0H2yxr1C0o4LNK28InZeN2IPQ1JfVUBogLIvmC7MAbelruQuTpEnAG870EUwBZO
	 e7qoV/XCCkELAHMncHJp/Uvj/RnT4X6KtlNIvx8SnTcL6OlYUsnYbtw7WGPe0wDfb8
	 bhdT3FHi9++Xv+atDkMpi7xjnFeIFILQgTOAPnQyFQKyfq04fphbiAfg4yuYFkDRRi
	 ewB1b0k91xohQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70B80383BF69;
	Thu, 11 Sep 2025 02:40:24 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net 1/7] docs: networking: can: change bcm_msg_head frames
 member to support flexible array
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175755842299.1636514.17401384189174035494.git-patchwork-notify@kernel.org>
Date: Thu, 11 Sep 2025 02:40:22 +0000
References: <20250910162907.948454-2-mkl@pengutronix.de>
In-Reply-To: <20250910162907.948454-2-mkl@pengutronix.de>
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
 linux-can@vger.kernel.org, kernel@pengutronix.de, alex.t.tran@gmail.com,
 socketcan@hartkopp.net

Hello:

This series was applied to netdev/net.git (main)
by Marc Kleine-Budde <mkl@pengutronix.de>:

On Wed, 10 Sep 2025 18:20:21 +0200 you wrote:
> From: Alex Tran <alex.t.tran@gmail.com>
> 
> The documentation of the 'bcm_msg_head' struct does not match how
> it is defined in 'bcm.h'. Changed the frames member to a flexible array,
> matching the definition in the header file.
> 
> See commit 94dfc73e7cf4 ("treewide: uapi: Replace zero-length arrays with
> flexible-array members")
> 
> [...]

Here is the summary with links:
  - [net,1/7] docs: networking: can: change bcm_msg_head frames member to support flexible array
    https://git.kernel.org/netdev/net/c/641427d5bf90
  - [net,2/7] selftests: can: enable CONFIG_CAN_VCAN as a module
    https://git.kernel.org/netdev/net/c/d013ebc3499f
  - [net,3/7] can: j1939: implement NETDEV_UNREGISTER notification handler
    https://git.kernel.org/netdev/net/c/7fcbe5b2c6a4
  - [net,4/7] can: j1939: j1939_sk_bind(): call j1939_priv_put() immediately when j1939_local_ecu_get() failed
    https://git.kernel.org/netdev/net/c/f214744c8a27
  - [net,5/7] can: j1939: j1939_local_ecu_get(): undo increment when j1939_local_ecu_get() fails
    https://git.kernel.org/netdev/net/c/06e02da29f6f
  - [net,6/7] can: xilinx_can: xcan_write_frame(): fix use-after-free of transmitted SKB
    https://git.kernel.org/netdev/net/c/ef79f00be72b
  - [net,7/7] can: rcar_can: rcar_can_resume(): fix s2ram with PSCI
    https://git.kernel.org/netdev/net/c/5c793afa07da

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



