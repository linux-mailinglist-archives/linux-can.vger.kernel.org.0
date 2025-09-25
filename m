Return-Path: <linux-can+bounces-5031-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 76520BA0A84
	for <lists+linux-can@lfdr.de>; Thu, 25 Sep 2025 18:40:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 365A73AC14E
	for <lists+linux-can@lfdr.de>; Thu, 25 Sep 2025 16:40:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA50D306D26;
	Thu, 25 Sep 2025 16:40:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CXR7wgI8"
X-Original-To: linux-can@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A302623BCE7;
	Thu, 25 Sep 2025 16:40:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758818411; cv=none; b=OHmufsWAi2kxQ+DR9sK5+DPPlmxhZJSs6kyZDoBaElHr/2OstzccD1/0cRPuOKDe05E04sHbm98y06EOCDdwPf5mGi22R/wQa+5DGR0DPdURqEu1hdyDwLZ4VCf1gjsGKzZVupK/2NNjp8OswJQc6G6aPjM/PfIpCJiMl9qszoI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758818411; c=relaxed/simple;
	bh=E/tgal/7gInBMTsUyn9w7u3eHxSWzYb2A3BC9voShHE=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=p2EB/GKUHvfCwLLsfeO1GGvDgGq3tJY3LRhLvQyA9ddI/GujLZEzbKBAfEJwwXf5uI/pdolRBFPaCB13REIZK/MdyNayb+EaRcm3y4QAWCGhVhw+cVx2BquyuxnvDTlPjuE+x3x3uHn03x5aD3YEjB3o1JUCW/jW5PVPl4D1xgs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CXR7wgI8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81E26C4CEF5;
	Thu, 25 Sep 2025 16:40:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758818411;
	bh=E/tgal/7gInBMTsUyn9w7u3eHxSWzYb2A3BC9voShHE=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=CXR7wgI8bFevjO/NFrN6FgSunZGyuBrMLTuTnbmRw+PvtwdqHCzyPw0uvpLlm0X2Q
	 8LhllvnYhIBiqikt4ZDqglictQwsqDkOw9yKl5vfCz6lU0ojrENUD8SPzePrPKmYpb
	 DAdp9LRGUERP9arZvDtWbMwm/5MymwSQ2HRMKmqo38BmHFUc3G4/3O2f8tN0ZpS/X9
	 QfXJ9dzxufqKMov/SQqPvKpnxGYnwvkoyXIJZVrrk97toQqsnSVH31vGL7FvYOKcmm
	 rOV8JAFV5vlapqex5WKs9e3qRbXKDsX8nYsVY8FMNJMC33L89n5pBef01o2z2JKtlI
	 eIYksg0JqCd9Q==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADD2F39D0C9F;
	Thu, 25 Sep 2025 16:40:08 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH iproute2-next 0/3] iplink_can: fix checkpatch.pl warnings
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175881840750.3437203.17651943381195099216.git-patchwork-notify@kernel.org>
Date: Thu, 25 Sep 2025 16:40:07 +0000
References: 
 <20250921-iplink_can-checkpatch-fixes-v1-0-1ddab98560cd@kernel.org>
In-Reply-To: 
 <20250921-iplink_can-checkpatch-fixes-v1-0-1ddab98560cd@kernel.org>
To: Vincent Mailhol <mailhol@kernel.org>
Cc: netdev@vger.kernel.org, stephen@networkplumber.org, dsahern@gmail.com,
 mkl@pengutronix.de, socketcan@hartkopp.net, linux-kernel@vger.kernel.org,
 linux-can@vger.kernel.org

Hello:

This series was applied to iproute2/iproute2.git (main)
by Stephen Hemminger <stephen@networkplumber.org>:

On Sun, 21 Sep 2025 16:32:29 +0900 you wrote:
> This is a clean up series which goes through all the checkpatch
> warnings on ip/iplink_can.c and fixes them one by one. By the end on
> this series, there is only one warning left:
> 
>   WARNING: Prefer __printf(2, 0) over __attribute__((format(printf, 2, 0)))
>   #320: FILE: ip/iplink_can.c:320:
>   +static void __attribute__((format(printf, 2, 0)))
> 
> [...]

Here is the summary with links:
  - [iproute2-next,1/3] iplink_can: fix coding style for pointer format
    https://git.kernel.org/pub/scm/network/iproute2/iproute2.git/commit/?id=bcddc725eef5
  - [iproute2-next,2/3] iplink_can: fix SPDX-License-Identifier tag format
    (no matching commit)
  - [iproute2-next,3/3] iplink_can: factorise the calls to usage()
    (no matching commit)

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



