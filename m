Return-Path: <linux-can+bounces-2891-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 35DBEA3D4F9
	for <lists+linux-can@lfdr.de>; Thu, 20 Feb 2025 10:40:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 80D8B17D635
	for <lists+linux-can@lfdr.de>; Thu, 20 Feb 2025 09:40:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0264E1EE032;
	Thu, 20 Feb 2025 09:40:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V+wrmWCa"
X-Original-To: linux-can@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC82E1EE006;
	Thu, 20 Feb 2025 09:40:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740044401; cv=none; b=MyKsPVOozFyN9QWF07VpLoIt+0yjNxh1k4eWC2G3cxLdqc7N91goIMRGml6rrVTvmyh7i+T2BFbfyd6j/cxhQDCyFVBiYeBOQ7WL63l6lcGRYCUs0GIvHw/1ImbAMdiVfTCz7n/pDCt5fA20SC7QKCTj//G95VtPaIJP1vrHE0Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740044401; c=relaxed/simple;
	bh=vZzNOT4gALWue5sMR/lAhNhYasWl2rgb+iL4Q8yNsU0=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=p6RQCGwB8oShqlrBrA186qlgnGIXDpcntIRyi66jXIeujb4NP66JL5tArZWUAcnQAWoTLsXINSqirYfha8J4VVoTHQgwx/yPbH8rgXBwbJpZfcou10BRjC0VvJSuhf+OTxRchUXMtw5XJOmlircuBAp9t/TSRto1CcbjMbu7TKI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V+wrmWCa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5587CC4CED1;
	Thu, 20 Feb 2025 09:40:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740044401;
	bh=vZzNOT4gALWue5sMR/lAhNhYasWl2rgb+iL4Q8yNsU0=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=V+wrmWCa0EuKOzodBLcgKwoLyQKn3xJiRnhc3i+Qqb+3WoyulamFtTz8kbfrMvY/J
	 Z72WT2Me/j4d5IdvrNG2pCgThaLWSwvMq5kG2pXafU2nzciYZxUeAYASdbVarJsKsr
	 CyHaOnRpuKU4JNqvx1w5X4aHfsUDkOFhwtMqJOFq+Hmw+mk+e2qDdckFk2Gap+cJgK
	 +I4P33XRmK3EvHrCeXXoAzxRDnJudPufsw8ICLABxFt4e1n4JSa9yfK+O8eVamkLlN
	 6zynTrdktmed7Y15K8mJF75mqX8U2Bv+NdclUS2g3dpmRY4I+hTI342+StvAU4UwhC
	 37dKjn50H4lQQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 3410A380CEE2;
	Thu, 20 Feb 2025 09:40:33 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next 01/12] can: c_can: Drop useless final probe failure
 message
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174004443201.1228909.16478837779381725795.git-patchwork-notify@kernel.org>
Date: Thu, 20 Feb 2025 09:40:32 +0000
References: <20250219113354.529611-2-mkl@pengutronix.de>
In-Reply-To: <20250219113354.529611-2-mkl@pengutronix.de>
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
 linux-can@vger.kernel.org, kernel@pengutronix.de,
 krzysztof.kozlowski@linaro.org, mailhol.vincent@wanadoo.fr

Hello:

This series was applied to netdev/net-next.git (main)
by Marc Kleine-Budde <mkl@pengutronix.de>:

On Wed, 19 Feb 2025 12:21:06 +0100 you wrote:
> From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> 
> Generic probe failure message is useless: does not give information what
> failed and it duplicates messages provided by the core, e.g. from memory
> allocation or platform_get_irq().  It also floods dmesg in case of
> deferred probe, e.g. resulting from devm_clk_get().
> 
> [...]

Here is the summary with links:
  - [net-next,01/12] can: c_can: Drop useless final probe failure message
    https://git.kernel.org/netdev/net-next/c/fd2a0c47fbae
  - [net-next,02/12] can: c_can: Simplify handling syscon error path
    https://git.kernel.org/netdev/net-next/c/6c00b580d1c9
  - [net-next,03/12] can: c_can: Use of_property_present() to test existence of DT property
    https://git.kernel.org/netdev/net-next/c/ab1bc2290fd8
  - [net-next,04/12] can: c_can: Use syscon_regmap_lookup_by_phandle_args
    https://git.kernel.org/netdev/net-next/c/9f0f0345d040
  - [net-next,05/12] dt-bindings: can: fsl,flexcan: add S32G2/S32G3 SoC support
    https://git.kernel.org/netdev/net-next/c/51723790b718
  - [net-next,06/12] can: flexcan: Add quirk to handle separate interrupt lines for mailboxes
    https://git.kernel.org/netdev/net-next/c/8c652cf030a7
  - [net-next,07/12] can: flexcan: add NXP S32G2/S32G3 SoC support
    https://git.kernel.org/netdev/net-next/c/8503a4b1a24d
  - [net-next,08/12] dt-binding: can: mcp251xfd: remove duplicate word
    https://git.kernel.org/netdev/net-next/c/bcb13d33221d
  - [net-next,09/12] can: j1939: Extend stack documentation with buffer size behavior
    https://git.kernel.org/netdev/net-next/c/6b89d89f2147
  - [net-next,10/12] can: canxl: support Remote Request Substitution bit access
    https://git.kernel.org/netdev/net-next/c/e1b2c7e902f7
  - [net-next,11/12] can: gs_usb: add VID/PID for the CANnectivity firmware
    https://git.kernel.org/netdev/net-next/c/32f08b22f3b8
  - [net-next,12/12] can: rockchip_canfd: rkcanfd_chip_fifo_setup(): remove duplicated setup of RX FIFO
    https://git.kernel.org/netdev/net-next/c/d9e1cc087a55

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



