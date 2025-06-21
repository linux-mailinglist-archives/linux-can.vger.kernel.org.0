Return-Path: <linux-can+bounces-3885-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BE07AE29B3
	for <lists+linux-can@lfdr.de>; Sat, 21 Jun 2025 17:00:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 96B6E189BA99
	for <lists+linux-can@lfdr.de>; Sat, 21 Jun 2025 15:00:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30C9321D3EC;
	Sat, 21 Jun 2025 14:59:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DMGOdenU"
X-Original-To: linux-can@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02A9A21CC5D;
	Sat, 21 Jun 2025 14:59:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750517994; cv=none; b=gvdsQ/rq3et4fT2loQzNNvV4W804Ta6Z4Gc3LDw0JJpp9aeGTIWhmsPAxLJPLQVvMu9Gz45iYN2NO97gdWtd745cUhfNAUZ18oX8Bz1WkJ5w4QhMkFgP3QQcVgtt0bDCH16ktrdevefKhLpEPq9TbKgGDVQAgt3G/KYkw6F1ZFg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750517994; c=relaxed/simple;
	bh=9qq7NQu5PTKPAheZWyM9SE6Cw1pnneIyXZryk4yd2r4=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=GydqgGZ79xTInftTJvc+QcY62S3GAF1HqkLTlvCPV3JkalWcIuaktcC1jf5+/kFIYX9iuerv9ESYSE1TcPUfnKKraVHxnCCLUSFLYrfKvqxe7fsII2HBrcjv0uXEkoSwVLdXGYs+evfgfBXGayNCIbi2yNCXK9Ex2kagM6NVPCs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DMGOdenU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8DE32C4CEEE;
	Sat, 21 Jun 2025 14:59:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750517993;
	bh=9qq7NQu5PTKPAheZWyM9SE6Cw1pnneIyXZryk4yd2r4=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=DMGOdenUVteNxDG+A35T7EV85KwOtIaBZv+0ds2veixJMINY+p7V4tqigA+4fMwoq
	 MY6uuQ7kngdckGWqP2SiJEkhhtix/3EKksPEkKYaZvXzPkTNtu3I8YxysPzpoyWxlN
	 0iRX4GMpD2dYLrbCTfdMubnLR1e3Xb2I2UL4x9kZYdQoyx30MMo5iInl2HDqd7Pygr
	 qQD+uo5PXIp3YRcdRIRnODoqpD2rFemXixuZ52m7wlPmh7f76ujctps0LMcEoPUc8f
	 UcQxxE8hc2g4TATCMYWI3X6HJPFplxXUVp6O1Ks53jZHfUlDcXvk2bHR6XLnh1Higk
	 g1EElAwSXeFLw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70D9338111DD;
	Sat, 21 Jun 2025 15:00:22 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] can: rcar_canfd: Describe channel-specific FD registers
 using
 C struct
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175051802124.1877807.84993120749211212.git-patchwork-notify@kernel.org>
Date: Sat, 21 Jun 2025 15:00:21 +0000
References: 
 <292b75b3bc8dd95f805f0223f606737071c8cf86.1750327217.git.geert+renesas@glider.be>
In-Reply-To: 
 <292b75b3bc8dd95f805f0223f606737071c8cf86.1750327217.git.geert+renesas@glider.be>
To: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: mailhol.vincent@wanadoo.fr, kuba@kernel.org, mkl@pengutronix.de,
 davem@davemloft.net, biju.das.jz@bp.renesas.com, linux-can@vger.kernel.org,
 netdev@vger.kernel.org, linux-renesas-soc@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 19 Jun 2025 12:13:17 +0200 you wrote:
> The rcar_canfd_f_*() inline functions to obtain channel-specific CAN-FD
> register offsets really describe a memory layout.  Hence replace them by
> a C structure, to simplify the code, and reduce kernel size.
> 
> This also gets rid of warnings about unused rcar_canfd_f_*() inline
> functions, which are reported by recent versions of clang.
> 
> [...]

Here is the summary with links:
  - can: rcar_canfd: Describe channel-specific FD registers using C struct
    https://git.kernel.org/netdev/net-next/c/ab2aa5453bb8

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



