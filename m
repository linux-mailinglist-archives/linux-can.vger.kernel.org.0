Return-Path: <linux-can+bounces-5823-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A383CAB87E
	for <lists+linux-can@lfdr.de>; Sun, 07 Dec 2025 18:43:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 959D7300C20E
	for <lists+linux-can@lfdr.de>; Sun,  7 Dec 2025 17:43:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9786024677A;
	Sun,  7 Dec 2025 17:43:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W0kWgjAZ"
X-Original-To: linux-can@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68B9B2DC762;
	Sun,  7 Dec 2025 17:43:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765129400; cv=none; b=nd7gRpFgNbFW5Bo1o7m/N8So246EV2UYjxYmFJNZ631MjlPo1JyssyyKl+0G/PK81IfMSWfGuCyBevVWBUj6bLZzcfsgWiyQIehXdkkDfhnXIJFfAfsvIuCoLq12Ft+38w96X/n2xy+UhdJv41upT4TXiFfKOQcFbwafaXfviXQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765129400; c=relaxed/simple;
	bh=MZ60y8MSntpkIDRHsxrqQzjEI81i2XjEURJL5nc2Jzw=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=ItuM6C8aLkxZfyAEjbJtx2bHWTH4NkYInZqkzzWPy0NAwzA4kbgRwyrz0Em+z2MC4ue9bKiaEMFGwJxNZ+I04IkwwIuN9F806lwqkIyJnuA/vIEOcFHyA1QzJtDw3DSggPVGKzN58rI4Yb3lF/ckrh6iHcZlgsMdcSeoMlpne9Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W0kWgjAZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD505C4CEFB;
	Sun,  7 Dec 2025 17:43:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765129399;
	bh=MZ60y8MSntpkIDRHsxrqQzjEI81i2XjEURJL5nc2Jzw=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=W0kWgjAZYeFGLp1xCfzgCM53FomlFIyK2NVIwo8jbT0JCwT9gtbeHDzSjPGYsg5q4
	 OQg9af/CjhcuWaa4YtKrCKEbSrNkWmv318lXlXwTeBvPp5DvPnt647KG3S/XEMcvlk
	 yZQzzTaNKmWQMm7Qwq/hsm8j/OeJrSSv5EfE/zX7FCGc0hqqXaAzyk//k5rtImp3Z+
	 r8OONHVqM6b/lAAUi0f/mc5XhghJmpClST0xRFJNiWhjCVwvqy3VNQcdgDCdGQPO0O
	 SJXBxN7qSK3YnllZ/XdHCDTx1Str+MzLUnCElSzbKBmPnmjw7eWv41ZdzdsFf0i2+v
	 VhcBWdwIHbl0A==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 789193808200;
	Sun,  7 Dec 2025 17:40:17 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH iproute2-next v3 0/7] iplink_can: add CAN XL support
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176512921602.2492763.3355041482753934530.git-patchwork-notify@kernel.org>
Date: Sun, 07 Dec 2025 17:40:16 +0000
References: <20251203-canxl-netlink-v3-0-999f38fae8c2@kernel.org>
In-Reply-To: <20251203-canxl-netlink-v3-0-999f38fae8c2@kernel.org>
To: Vincent Mailhol <mailhol@kernel.org>
Cc: netdev@vger.kernel.org, stephen@networkplumber.org, mkl@pengutronix.de,
 socketcan@hartkopp.net, dsahern@kernel.org, rakuram.e96@gmail.com,
 stephane.grosjean@free.fr, linux-kernel@vger.kernel.org,
 linux-can@vger.kernel.org

Hello:

This series was applied to iproute2/iproute2.git (main)
by Stephen Hemminger <stephen@networkplumber.org>:

On Wed, 03 Dec 2025 19:24:27 +0100 you wrote:
> Support for CAN XL was added to the kernel in [1]. This series is the
> iproute2 counterpart.
> 
> Patches #1 to #3 are clean-ups. They refactor iplink_can's
> print_usage()'s function.
> 
> Patches #4 to #7 add the CAN XL interface to iplink_can.
> 
> [...]

Here is the summary with links:
  - [iproute2-next,v3,1/7] iplink_can: print_usage: fix the text indentation
    https://git.kernel.org/pub/scm/network/iproute2/iproute2.git/commit/?id=cf9261af2303
  - [iproute2-next,v3,2/7] iplink_can: print_usage: change unit for minimum time quanta to mtq
    https://git.kernel.org/pub/scm/network/iproute2/iproute2.git/commit/?id=416cd0814482
  - [iproute2-next,v3,3/7] iplink_can: print_usage: describe the CAN bittiming units
    https://git.kernel.org/pub/scm/network/iproute2/iproute2.git/commit/?id=393dfbb456df
  - [iproute2-next,v3,4/7] iplink_can: add RESTRICTED operation mode support
    https://git.kernel.org/pub/scm/network/iproute2/iproute2.git/commit/?id=ab224334322c
  - [iproute2-next,v3,5/7] iplink_can: add initial CAN XL support
    https://git.kernel.org/pub/scm/network/iproute2/iproute2.git/commit/?id=a52858b06f1a
  - [iproute2-next,v3,6/7] iplink_can: add CAN XL transceiver mode setting (TMS) support
    https://git.kernel.org/pub/scm/network/iproute2/iproute2.git/commit/?id=fea1a11ec3ee
  - [iproute2-next,v3,7/7] iplink_can: add CAN XL TMS PWM configuration support
    https://git.kernel.org/pub/scm/network/iproute2/iproute2.git/commit/?id=24a5a424e3a0

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



