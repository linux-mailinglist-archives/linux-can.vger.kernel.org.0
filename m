Return-Path: <linux-can+bounces-5881-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C540CCCD7B
	for <lists+linux-can@lfdr.de>; Thu, 18 Dec 2025 17:46:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1A95F3092F1A
	for <lists+linux-can@lfdr.de>; Thu, 18 Dec 2025 16:41:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E0B8346A13;
	Thu, 18 Dec 2025 16:33:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gFaoaa0C"
X-Original-To: linux-can@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9BD82609DC;
	Thu, 18 Dec 2025 16:33:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766075599; cv=none; b=Y0StKPruir0PISI5qNy+CxqpDNjuVurQdHe6d9iI5q37LNs/sNXNKutLKcVBthnF5nVUYfBlSxJIKGURpxuN6m2k176RgJJ2CfE+2gqrx5HlhzzQs2L9aimfH9qVOfFjM3uz4G0YUrs44xVnQB5BObuUak2PxLM0fD/QiHSPUTs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766075599; c=relaxed/simple;
	bh=U/poDQ1BLPtzFfMMDbzqJclH9yMLMTfIZM5O6oRXnYs=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=rQxrAZz+0MgSHi/q9GGS1QfGqcqaw4X44dFHVYNIJubE76+bE74a4XdSYANGRQtS3tU/pOTc1m+d/AaliHr+mZzMJc25XeW8cjXV6IvMqXEugMsff2IctNTFgnwfwkIfKRaLqxRovtEyv2yWticYKZRV2FdfzLVTdlUmA+66FJQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gFaoaa0C; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 61030C4CEFB;
	Thu, 18 Dec 2025 16:33:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766075599;
	bh=U/poDQ1BLPtzFfMMDbzqJclH9yMLMTfIZM5O6oRXnYs=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=gFaoaa0C5Qhs4TpZY3W8/ueDponOl5yjh1V5gkHZCZCo+AHMuAuP9z7IC/OppC0+b
	 XXR1g+egu6yMYIBWRnE0XA+zeL74aqbNEhmp2Iq4uJrmexMGC21hKCjfXqNHnPY64b
	 Ch9MQjUXX3KODwBtd2pHhXt9+agrFKIhZW0pnn/0xzwwQF9o1AF9vlzEZhzYEWXgMX
	 j9NJGTA3KYHIRGENkZCJL25Wq1JuG1HMBogL6ju6/JiJawWEwLI6T1yz9pkXu5ijQA
	 RnuYU1EHjA3k3DwUh8knGyjh+zL2XeaazyeTp8ehG2looTb1iX8PCH5r93fBGyzgEB
	 DoXnQceC/GYXA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id F37A2380A96A;
	Thu, 18 Dec 2025 16:30:09 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net 1/3] can: j1939: make j1939_session_activate() fail if
 device is no longer registered
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176607540880.3039618.105592029985001417.git-patchwork-notify@kernel.org>
Date: Thu, 18 Dec 2025 16:30:08 +0000
References: <20251218123132.664533-2-mkl@pengutronix.de>
In-Reply-To: <20251218123132.664533-2-mkl@pengutronix.de>
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
 linux-can@vger.kernel.org, kernel@pengutronix.de,
 penguin-kernel@I-love.SAKURA.ne.jp,
 syzbot+881d65229ca4f9ae8c84@syzkaller.appspotmail.com,
 o.rempel@pengutronix.de

Hello:

This series was applied to netdev/net.git (main)
by Marc Kleine-Budde <mkl@pengutronix.de>:

On Thu, 18 Dec 2025 10:27:17 +0100 you wrote:
> From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
> 
> syzbot is still reporting
> 
>   unregister_netdevice: waiting for vcan0 to become free. Usage count = 2
> 
> even after commit 93a27b5891b8 ("can: j1939: add missing calls in
> NETDEV_UNREGISTER notification handler") was added. A debug printk() patch
> found that j1939_session_activate() can succeed even after
> j1939_cancel_active_session() from j1939_netdev_notify(NETDEV_UNREGISTER)
> has completed.
> 
> [...]

Here is the summary with links:
  - [net,1/3] can: j1939: make j1939_session_activate() fail if device is no longer registered
    https://git.kernel.org/netdev/net/c/5d5602236f5d
  - [net,2/3] can: j1939: make j1939_sk_bind() fail if device is no longer registered
    https://git.kernel.org/netdev/net/c/46cea215dc94
  - [net,3/3] can: fix build dependency
    https://git.kernel.org/netdev/net/c/5a5aff6338c0

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



