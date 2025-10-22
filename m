Return-Path: <linux-can+bounces-5263-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AE092BF9886
	for <lists+linux-can@lfdr.de>; Wed, 22 Oct 2025 02:51:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5F9B919C6A3D
	for <lists+linux-can@lfdr.de>; Wed, 22 Oct 2025 00:51:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87F101EBFF7;
	Wed, 22 Oct 2025 00:50:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kOzD9d/0"
X-Original-To: linux-can@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E52F1E9B0D;
	Wed, 22 Oct 2025 00:50:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761094242; cv=none; b=cEEjaqE7dsM38Lw2J2m/kDMJdUkKmSiutgghzRVvGCqf4T3SJtxyhoIrqasgswtG75rOTBcH2yMOHSI41CUAUtRAPXFjqY9iaTxVsfb7B0Pit5qsiN5i93hfacemFS6nrJA7dk911KxXknuC5AaOzScSmtbb5JokOzJuG9diJrQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761094242; c=relaxed/simple;
	bh=tjEilBQnJnsjZRE6OEEf6WjEwYE/W1ikIransj4DunI=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=TtzlY1y2fynMunrEo1nW9KT9feiXPSjp5ljopOCLcMivkISQLBpCAmJpNs3/U9pZVsY4ROdW6kngkvBJ5gKcDaWulYCQP5QzAm2flMje7z61jmNPUdUUYyHjhFsqAeTiPRHgx5kAd4i8NtCziNoc7dQRdUPWkfh1ZMlqZ+LCO7o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kOzD9d/0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 266B3C4CEFF;
	Wed, 22 Oct 2025 00:50:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761094242;
	bh=tjEilBQnJnsjZRE6OEEf6WjEwYE/W1ikIransj4DunI=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=kOzD9d/0dc0S/Z6d7TkryA6ySYjthOwV96+7rKOtSOJH5qp31vEF5D5J64D81vCTd
	 MGbmJgWfQR7e899b5MS01Xsw7U2iMNGw4ikw6rZnw/DqwrUtJvEMHuCRe3QS6zoXJ7
	 t1D8j3inL4psiMAL6IX5AvZhkqDPKezhhev4YyScvarbtyg3CCbb7/5t6mSM0Pwron
	 PayaTUo4OjuWPcQH1EWkLVnj/3y80/g8UwkZGQx35ebrykGnZlOzVl+kMjZmjov/lf
	 l8mkJCvLMP6ikvrAQYLE2mezM1BpxCkwU7fYPTuticB0I65BNWFcug8qyhudOPqZ+b
	 ikbdk1vEZ5u5Q==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADEB13A55FA6;
	Wed, 22 Oct 2025 00:50:24 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net 1/4] can: bxcan: bxcan_start_xmit(): use
 can_dev_dropped_skb() instead of can_dropped_invalid_skb()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176109422326.1291118.3062746370710929098.git-patchwork-notify@kernel.org>
Date: Wed, 22 Oct 2025 00:50:23 +0000
References: <20251020152516.1590553-2-mkl@pengutronix.de>
In-Reply-To: <20251020152516.1590553-2-mkl@pengutronix.de>
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
 linux-can@vger.kernel.org, kernel@pengutronix.de

Hello:

This series was applied to netdev/net.git (main)
by Marc Kleine-Budde <mkl@pengutronix.de>:

On Mon, 20 Oct 2025 17:22:22 +0200 you wrote:
> In addition to can_dropped_invalid_skb(), the helper function
> can_dev_dropped_skb() checks whether the device is in listen-only mode and
> discards the skb accordingly.
> 
> Replace can_dropped_invalid_skb() by can_dev_dropped_skb() to also drop
> skbs in for listen-only mode.
> 
> [...]

Here is the summary with links:
  - [net,1/4] can: bxcan: bxcan_start_xmit(): use can_dev_dropped_skb() instead of can_dropped_invalid_skb()
    https://git.kernel.org/netdev/net/c/3a20c444cd12
  - [net,2/4] can: esd: acc_start_xmit(): use can_dev_dropped_skb() instead of can_dropped_invalid_skb()
    https://git.kernel.org/netdev/net/c/0bee15a5caf3
  - [net,3/4] can: rockchip-canfd: rkcanfd_start_xmit(): use can_dev_dropped_skb() instead of can_dropped_invalid_skb()
    https://git.kernel.org/netdev/net/c/3a3bc9bbb3a0
  - [net,4/4] can: netlink: can_changelink(): allow disabling of automatic restart
    https://git.kernel.org/netdev/net/c/8e93ac51e4c6

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



