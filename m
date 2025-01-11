Return-Path: <linux-can+bounces-2594-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B461A0A164
	for <lists+linux-can@lfdr.de>; Sat, 11 Jan 2025 08:00:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E07A1188DEF2
	for <lists+linux-can@lfdr.de>; Sat, 11 Jan 2025 07:00:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69DEE14F9EB;
	Sat, 11 Jan 2025 07:00:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Drh4gB/D"
X-Original-To: linux-can@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4112C8172A;
	Sat, 11 Jan 2025 07:00:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736578828; cv=none; b=ME9C5fXrnguZ2OUf39qUNPbhGLoUfurpIYAW/TzzUQeB3+KxBwLe20r3EiFCthqP67FJGCj8jDFub/h3WWf+SaexciQui+GBsRDGYdSdZLte/oLBb4KgM2gIL5L1lMoxj5D36VScxXVUgon9UGwbla442sQd7tJMSyQ8bEgF6os=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736578828; c=relaxed/simple;
	bh=cb044/Apa15lPwK9G9VB8pwZ7CbtuU12N98VF2Rg+bo=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=XTg7MADrnehSCEAm9Gej9Tuh6gmTV4S813DlWRagJJcvAjUqNPwpCOCA+3rdAqAV7dj76Gfyn9vp/+8utnFn2fP0c7Y1V7osx4ILjWfIef4dFgmiQpXdm+io43itqrTmDDK/hl7rzWBKJe/1iIA38uvmI6RFN/VJf/+RD790wuA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Drh4gB/D; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA554C4CED2;
	Sat, 11 Jan 2025 07:00:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736578827;
	bh=cb044/Apa15lPwK9G9VB8pwZ7CbtuU12N98VF2Rg+bo=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Drh4gB/DNIyHFdABgj0gkvwRKRvDbF25oD1xenkcwvSX6Gdi5hOZ1XZkF/tKI2O/E
	 Of6ZRZD85/BMLhJasnAk2H7vRBMZf6P3cSWZK3ZieAymyZEYYp6PCHFgzOWtRz8Pmq
	 jNyU7DOqVEe/+y2UFGK1dNpiaB/02lGTf9oHHun7CcAlVW9iMg6tCZMLZ4KQ3yLC1C
	 lMHVpVUhobqfe/w6E1ZE3DeABr6p+tDzsf/oafoGg6+/0jU1ACyGUuNfiU+gT0+Cjt
	 p3X6accotS6EM7MjZDgOQP7QGkL0K6LUi0Qc28IWwBtmBszCm6W2VjPSl6pmTseHCu
	 S7HtKp6CLYDsQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EB7FF380AA57;
	Sat, 11 Jan 2025 07:00:50 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next 01/18] dt-bindings: can: mpfs: add PIC64GX CAN
 compatibility
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173657884987.2317784.6866618632689015212.git-patchwork-notify@kernel.org>
Date: Sat, 11 Jan 2025 07:00:49 +0000
References: <20250110112712.3214173-2-mkl@pengutronix.de>
In-Reply-To: <20250110112712.3214173-2-mkl@pengutronix.de>
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
 linux-can@vger.kernel.org, kernel@pengutronix.de,
 pierre-henry.moussay@microchip.com, conor.dooley@microchip.com

Hello:

This series was applied to netdev/net-next.git (main)
by Marc Kleine-Budde <mkl@pengutronix.de>:

On Fri, 10 Jan 2025 12:04:09 +0100 you wrote:
> From: Pierre-Henry Moussay <pierre-henry.moussay@microchip.com>
> 
> PIC64GX CAN is compatible with the MPFS CAN, only add a fallback
> 
> Signed-off-by: Pierre-Henry Moussay <pierre-henry.moussay@microchip.com>
> Acked-by: Conor Dooley <conor.dooley@microchip.com>
> Reviewed-by: Marc Kleine-Budde <mkl@pengutronix.de>
> Link: https://patch.msgid.link/20240930095449.1813195-2-pierre-henry.moussay@microchip.com
> Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
> 
> [...]

Here is the summary with links:
  - [net-next,01/18] dt-bindings: can: mpfs: add PIC64GX CAN compatibility
    https://git.kernel.org/netdev/net-next/c/130727c37b7e
  - [net-next,02/18] dt-bindings: can: convert tcan4x5x.txt to DT schema
    https://git.kernel.org/netdev/net-next/c/79195755cdeb
  - [net-next,03/18] dt-bindings: can: tcan4x5x: Document the ti,nwkrq-voltage-vio option
    https://git.kernel.org/netdev/net-next/c/6495567981be
  - [net-next,04/18] can: tcan4x5x: add option for selecting nWKRQ voltage
    https://git.kernel.org/netdev/net-next/c/36131b72fb1c
  - [net-next,05/18] can: sun4i_can: continue to use likely() to check skb
    https://git.kernel.org/netdev/net-next/c/bddad4fac9f7
  - [net-next,06/18] can: tcan4x5x: get rid of false clock errors
    https://git.kernel.org/netdev/net-next/c/68d426da13fa
  - [net-next,07/18] dt-bindings: net: can: atmel: Convert to json schema
    https://git.kernel.org/netdev/net-next/c/2351998fd833
  - [net-next,08/18] mailmap: add an entry for Oliver Hartkopp
    https://git.kernel.org/netdev/net-next/c/57769cb9ccba
  - [net-next,09/18] MAINTAINERS: assign em_canid.c additionally to CAN maintainers
    https://git.kernel.org/netdev/net-next/c/1263e69a7c47
  - [net-next,10/18] can: dev: can_get_state_str(): Remove dead code
    https://git.kernel.org/netdev/net-next/c/d50c837675a9
  - [net-next,11/18] can: m_can: add deinit callback
    https://git.kernel.org/netdev/net-next/c/baa8aaf79768
  - [net-next,12/18] can: tcan4x5x: add deinit callback to set standby mode
    https://git.kernel.org/netdev/net-next/c/a1366314703a
  - [net-next,13/18] can: m_can: call deinit/init callback when going into suspend/resume
    https://git.kernel.org/netdev/net-next/c/ad1ddb3bfb0c
  - [net-next,14/18] dt-bindings: can: st,stm32-bxcan: fix st,gcan property type
    https://git.kernel.org/netdev/net-next/c/7e0c2f136d1b
  - [net-next,15/18] can: kvaser_usb: Update stats and state even if alloc_can_err_skb() fails
    https://git.kernel.org/netdev/net-next/c/3749637b71b0
  - [net-next,16/18] can: kvaser_usb: Add support for CAN_CTRLMODE_BERR_REPORTING
    https://git.kernel.org/netdev/net-next/c/0dfa617c3f77
  - [net-next,17/18] can: kvaser_pciefd: Update stats and state even if alloc_can_err_skb() fails
    https://git.kernel.org/netdev/net-next/c/e048c5e55fbc
  - [net-next,18/18] can: kvaser_pciefd: Add support for CAN_CTRLMODE_BERR_REPORTING
    https://git.kernel.org/netdev/net-next/c/9d92fda0e2ad

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



