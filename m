Return-Path: <linux-can+bounces-3978-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 28679B04D0C
	for <lists+linux-can@lfdr.de>; Tue, 15 Jul 2025 02:40:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 647B44A1189
	for <lists+linux-can@lfdr.de>; Tue, 15 Jul 2025 00:40:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86BA618DB1A;
	Tue, 15 Jul 2025 00:39:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HMuBBmp+"
X-Original-To: linux-can@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59657185B67;
	Tue, 15 Jul 2025 00:39:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752539995; cv=none; b=lX+my/8JEXM8e3vM7YEpenh81cshswEcCTya51l/no5xe/WAmBq4fb0HIy1wo9LKNR9CNog3B+ARob9G+T8LBx8cQq1XljwutTNBN5Ty1fjk6kNq2gKceHoot1zzPghnRo+IlwqLRYAMiMoV3kc9z+2MThpPLmUJb66VVGFAdvQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752539995; c=relaxed/simple;
	bh=4OTBerQK+S3XsRQd4Ms0o7YijzlevXJqzB8iNZIbdOw=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Ue1MG95S2FAhML/uBuotKk6+mv1dDS22hdcjkmmVYgDwoow44rkTazr5qp2ym29iP5VtU1qyoFTwNoVlErD+8SQ/UfTLSlXBVEvY6+xbyG5JYe5nr7qcFFSZW5JqqTA5Y0fLA7utopVPq3T2SGzSTwMMmIohy7hgzDPOe/8uFak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HMuBBmp+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B56DC4CEED;
	Tue, 15 Jul 2025 00:39:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752539995;
	bh=4OTBerQK+S3XsRQd4Ms0o7YijzlevXJqzB8iNZIbdOw=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=HMuBBmp+XHgl9TmJLV/aV82kSP2PP1RXcXtisXE17hO8JZRbBkxlBhK5/xDsFAb1V
	 wb18KpAlG1sbk9iWI3KlPtCT7NRxgWD99ryzFDlCIft9wvsI8WOKtw7wnA1coBtB4z
	 QV5QmRCZVJ0omDpkClhncrZFFk0d6yQcTWFrGtNAIAniDIURHr9ZaUbv82+wPdJ19R
	 edMGFtsHDM7PdgiMUOuoqdyL+w4fEjNsYZBXc7f96Oa6VIz6EHkvEzYMTVUZ80MZ1y
	 cM4mTH5E1HgALhPKLdu/IXrnvxyWlqhRRNDT8rjBF0CM9xtDjuOvl2HBHYnUYuxlUQ
	 wRP7ZuwCQZxpg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33CB5383B276;
	Tue, 15 Jul 2025 00:40:17 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next 1/2] can: rcar_can: Convert to
 DEFINE_SIMPLE_DEV_PM_OPS()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175254001601.4040142.14122920462867541735.git-patchwork-notify@kernel.org>
Date: Tue, 15 Jul 2025 00:40:16 +0000
References: <20250711101706.2822687-2-mkl@pengutronix.de>
In-Reply-To: <20250711101706.2822687-2-mkl@pengutronix.de>
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
 linux-can@vger.kernel.org, kernel@pengutronix.de, geert+renesas@glider.be

Hello:

This series was applied to netdev/net-next.git (main)
by Marc Kleine-Budde <mkl@pengutronix.de>:

On Fri, 11 Jul 2025 12:15:08 +0200 you wrote:
> From: Geert Uytterhoeven <geert+renesas@glider.be>
> 
> Convert the Renesas R-Car CAN driver from SIMPLE_DEV_PM_OPS() to
> DEFINE_SIMPLE_DEV_PM_OPS() and pm_sleep_ptr().  This lets us drop the
> __maybe_unused annotations from its suspend and resume callbacks, and
> reduces kernel size in case CONFIG_PM or CONFIG_PM_SLEEP is disabled.
> 
> [...]

Here is the summary with links:
  - [net-next,1/2] can: rcar_can: Convert to DEFINE_SIMPLE_DEV_PM_OPS()
    https://git.kernel.org/netdev/net-next/c/25883e286e7a
  - [net-next,2/2] can: rcar_canfd: Drop unused macros
    https://git.kernel.org/netdev/net-next/c/0e6639c8505d

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



