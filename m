Return-Path: <linux-can+bounces-6165-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A283CD24702
	for <lists+linux-can@lfdr.de>; Thu, 15 Jan 2026 13:23:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id A50AF30082EE
	for <lists+linux-can@lfdr.de>; Thu, 15 Jan 2026 12:23:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F136C39446F;
	Thu, 15 Jan 2026 12:23:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KUTUj/hH"
X-Original-To: linux-can@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDF8E393DD4;
	Thu, 15 Jan 2026 12:23:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768479819; cv=none; b=aESNnNlywnDlAO5HVtr4SWV8PNzXadnNKGGto2TwIUFeyLqPw35jAEJ7ZNpQECQqWGeoyRp9ZT1NhOthLQybvszjDz82zLDjKv5dCauyhecDgypBL/FBqHYv9l0cFflldqcjcTApAguLsZYiRuh1bObHUqbV5crJb//FgEe4tmw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768479819; c=relaxed/simple;
	bh=fFmSM/hVjBlWoP/bvoORXUI2Ig1WhL/IDaETPBRXU5M=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=fAb0GU3x/M4WYnBrAwhl/Q5uTqUvmCX+dKWDs8HUrQcOxJXhHaPvxlCHMu9UTTmiEs74Sls1dFT+Qh0jLCa13Q8NKleYBMibtSzbZfQcNhwmtkRNqWeI7GfP4O+3U6MkvOsUq2/oS6M6tAELiX7qluub8d41mPrVD1tcj7wsIIo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KUTUj/hH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 70EB0C116D0;
	Thu, 15 Jan 2026 12:23:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768479819;
	bh=fFmSM/hVjBlWoP/bvoORXUI2Ig1WhL/IDaETPBRXU5M=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=KUTUj/hHx12ueidi4Z0SBVs/cDiS5TZZvCU3hzkjtQOqyCE+bgo6sWDjp6e6iq4/v
	 2DP+WRPgj/+wT7bNBUMhpFsc8gYUc2Pe89nY3v0ZVBK+Kgv65xOtqVs+1InzhmRM6l
	 yOfIDtm76mgOv28aXW7fv5KgT1R6Ez5nsyY8KAST5QTzkNNT2b52kP0TGeL5F+Z1IM
	 jBc8j3OtCU/AmpKCFcSkH13IbjEnhqx506NpgO+mhbci9hej9xtQ1JpmtBkGNsxKEH
	 Dae7maJGd2DPo3tvCt8x6tQ5Hl7NkjHoiIvDnqhZia/uusVP58nIzrn+WB/jSO8DTd
	 K5hGPuJGu9f6Q==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id F304E3809A82;
	Thu, 15 Jan 2026 12:20:12 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net 1/4] Revert "can: raw: instantly reject unsupported
 CAN
 frames"
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176847961180.3970738.13022780012071262607.git-patchwork-notify@kernel.org>
Date: Thu, 15 Jan 2026 12:20:11 +0000
References: <20260115090603.1124860-2-mkl@pengutronix.de>
In-Reply-To: <20260115090603.1124860-2-mkl@pengutronix.de>
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
 linux-can@vger.kernel.org, kernel@pengutronix.de, socketcan@hartkopp.net,
 arnd@arndb.de, mailhol@kernel.org

Hello:

This series was applied to netdev/net.git (main)
by Marc Kleine-Budde <mkl@pengutronix.de>:

On Thu, 15 Jan 2026 09:57:08 +0100 you wrote:
> From: Oliver Hartkopp <socketcan@hartkopp.net>
> 
> This reverts commit 1a620a723853a0f49703c317d52dc6b9602cbaa8
> 
> and its follow-up fixes for the introduced dependency issues.
> 
> commit 1a620a723853 ("can: raw: instantly reject unsupported CAN frames")
> commit cb2dc6d2869a ("can: Kconfig: select CAN driver infrastructure by default")
> commit 6abd4577bccc ("can: fix build dependency")
> commit 5a5aff6338c0 ("can: fix build dependency")
> 
> [...]

Here is the summary with links:
  - [net,1/4] Revert "can: raw: instantly reject unsupported CAN frames"
    https://git.kernel.org/netdev/net/c/4650ff58a1b9
  - [net,2/4] can: propagate CAN device capabilities via ml_priv
    https://git.kernel.org/netdev/net/c/166e87329ce6
  - [net,3/4] can: raw: instantly reject disabled CAN frames
    https://git.kernel.org/netdev/net/c/faba5860fcf9
  - [net,4/4] net: can: j1939: j1939_xtp_rx_rts_session_active(): deactivate session upon receiving the second rts
    https://git.kernel.org/netdev/net/c/1809c82aa073

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



