Return-Path: <linux-can+bounces-2628-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C0414A0FF31
	for <lists+linux-can@lfdr.de>; Tue, 14 Jan 2025 04:30:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A1BFF16942B
	for <lists+linux-can@lfdr.de>; Tue, 14 Jan 2025 03:30:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C56F233525;
	Tue, 14 Jan 2025 03:30:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vBpcZvP/"
X-Original-To: linux-can@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C8DE233127;
	Tue, 14 Jan 2025 03:30:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736825421; cv=none; b=mNA/51CZOYLWIM1ZT6ltJwaNbj+0H+LRO5XRcSE2lpFjnA667PS4Nf7VvsbtKVO/calLIWz5HobxBlkG/EbGeFyN4BULePmVemwb5qFM97YGZAIiaFHbzQSN8XVGMOLs2dH9XR15D+S6qrqw0nZNcCxSdd1agunf/GyJop619SA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736825421; c=relaxed/simple;
	bh=oB1aUJYLNGi8a/CNcOFFslZe22KVsiOmptucLi9/Sqk=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=gTMwXtpvdgjZqBoHWrwkhmZy3W4KExIo+Y3pIio9mXC+i1GIwDlrjGLodDxtp5Mz/TBQqHI/j61XkyiR0/O9g/ScpIDvS756mrTMLpwjtZiuO9VoVUC5KiQB170XuBvWhpWmDy1ICgqgRQuSTiGNQKJtR+7+EFUofe14ipF3dNc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vBpcZvP/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A0DABC4CEDF;
	Tue, 14 Jan 2025 03:30:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736825420;
	bh=oB1aUJYLNGi8a/CNcOFFslZe22KVsiOmptucLi9/Sqk=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=vBpcZvP/757woopiZK+kDeaObvRfmnjIqaBppcx5nujgvY54t1qQDb0qeQFC4HRwV
	 Upm62DZlHoMol6V5qe+WAzbg6DdqPDp59fOtvIkgqpIuN7ghqn9QN14SPybDdek1PC
	 tkEMghOy7TMkmRMMjvZopueQPYpF3FFxM15KFWADz63GRRJWImXzg1UeH+D5diHXhT
	 fMmRHVO0Rb/wcS/oHEAyyla7q40lc0BMrxZBmf0CoWS/Gtaw0Hr71rDiuppojA79Tr
	 tr60benP+f9sUgdLnT53bbeIumn9qc8Wq6Wu17xyvcEk1ettpdETasW4e6JtqmNyPT
	 3kUkCUZDRXFGQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70E01380AA5F;
	Tue, 14 Jan 2025 03:30:44 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] can: grcan: move napi_enable() from under spin lock
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173682544298.3721274.18255521864017199287.git-patchwork-notify@kernel.org>
Date: Tue, 14 Jan 2025 03:30:42 +0000
References: <20250111024742.3680902-1-kuba@kernel.org>
In-Reply-To: <20250111024742.3680902-1-kuba@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org,
 mkl@pengutronix.de, mailhol.vincent@wanadoo.fr, linux-can@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 10 Jan 2025 18:47:42 -0800 you wrote:
> I don't see any reason why napi_enable() needs to be under the lock,
> only reason I could think of is if the IRQ also took this lock
> but it doesn't. napi_enable() will soon need to sleep.
> 
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> ---
> Marc, if this is correct is it okay for me to take via net-next
> directly? I have a bunch of patches which depend on it.
> 
> [...]

Here is the summary with links:
  - [net-next] can: grcan: move napi_enable() from under spin lock
    https://git.kernel.org/netdev/net-next/c/7c125d5b767b

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



