Return-Path: <linux-can+bounces-3691-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 23BA1AC4308
	for <lists+linux-can@lfdr.de>; Mon, 26 May 2025 18:30:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D6C1D3AE403
	for <lists+linux-can@lfdr.de>; Mon, 26 May 2025 16:30:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DB12212D9D;
	Mon, 26 May 2025 16:30:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZLghaKxS"
X-Original-To: linux-can@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5635519AD48;
	Mon, 26 May 2025 16:30:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748277018; cv=none; b=aWCOF6G1Xv94zIsXJ1hJvMVfmSlRhAz8O6s/XPmYSajs86gLTPyuhLmKh8qDX/oSInzWitD+hZ5gnQKR0pR9qcV8VgcfEh+rZyC4ls/XzgTV8ZQ846RFGFm3lC0k1o1GwXiVIOe/3hrDxOE4cxBl2WfvagDSBK/9IuU8V5xkt98=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748277018; c=relaxed/simple;
	bh=8wAWrp+QixMFM6Bq8Xa3GczatIDcWYQvgC7NsXDkqQ4=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=ccEDd6MD4sKmmOr3kbkaTbAy9p4MI6g9KrfFaFkgwkOOHKog9U6uNLj3OPzXPUZYsc4xL1gr0fZnog2ksGmpCf2fMlf2WvKjf6ZR+8WXCghDr/cIghBA79/p/ENPHKz7baaQ30fQyqCC4CUvBWsWhGk1EvbuhRBv7MUA+Ws9Yy0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZLghaKxS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB900C4CEE7;
	Mon, 26 May 2025 16:30:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748277017;
	bh=8wAWrp+QixMFM6Bq8Xa3GczatIDcWYQvgC7NsXDkqQ4=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=ZLghaKxSYoRsaEt1a2QcTvIgz4f3+yp6D7zOSQMgCG7Y7K3HR3eKfArmvEuakBVdu
	 3PIXfWxVeZ2809tzEd11fJ2pHVYu3hwyQJnX+D5+aKL7VMjximbNSA3xHS9e9UHRiH
	 uewz//lrtKYmmZq6PR7J17hlZ3ZndlWO/idCwSm7Lr+dWw0Z1cAL9RwcvZal5XAF6Z
	 wtst0X5qrwdFbzq/nglkYbPB/qR2wUGMPbd4engZY3d63dKt/rGYvqOBPZPY06muDP
	 l6jaOoudE8ozXIwSpRoXQCSyG4hwjbgCcDiXtkJXlLw1rkEGeFdeK58Al6tlhY6imG
	 oo3tKRYFc9E6Q==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70D903805D8E;
	Mon, 26 May 2025 16:30:53 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next 01/22] dt-bindings: can: renesas,rcar-canfd: Simplify
 the conditional schema
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174827705225.975563.5032451834623900122.git-patchwork-notify@kernel.org>
Date: Mon, 26 May 2025 16:30:52 +0000
References: <20250522084128.501049-2-mkl@pengutronix.de>
In-Reply-To: <20250522084128.501049-2-mkl@pengutronix.de>
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
 linux-can@vger.kernel.org, kernel@pengutronix.de, biju.das.jz@bp.renesas.com,
 conor.dooley@microchip.com, geert+renesas@glider.be

Hello:

This series was applied to netdev/net-next.git (main)
by Marc Kleine-Budde <mkl@pengutronix.de>:

On Thu, 22 May 2025 10:36:29 +0200 you wrote:
> From: Biju Das <biju.das.jz@bp.renesas.com>
> 
> RZ/G3E SoC has 20 interrupts, 2 resets and 6 channels that need more
> branching with conditional schema. Simplify the conditional schema with
> if statements rather than the complex if-else statements to prepare for
> supporting RZ/G3E SoC.
> 
> [...]

Here is the summary with links:
  - [net-next,01/22] dt-bindings: can: renesas,rcar-canfd: Simplify the conditional schema
    https://git.kernel.org/netdev/net-next/c/466c8ef7b66b
  - [net-next,02/22] dt-bindings: can: renesas,rcar-canfd: Document RZ/G3E support
    https://git.kernel.org/netdev/net-next/c/e623c6e56bdf
  - [net-next,03/22] can: rcar_canfd: Use of_get_available_child_by_name()
    https://git.kernel.org/netdev/net-next/c/56f3dc3ea4ab
  - [net-next,04/22] can: rcar_canfd: Drop RCANFD_GAFLCFG_GETRNC macro
    https://git.kernel.org/netdev/net-next/c/05e7f5a90c30
  - [net-next,05/22] can: rcar_canfd: Update RCANFD_GERFL_ERR macro
    https://git.kernel.org/netdev/net-next/c/b75fcf2af2db
  - [net-next,06/22] can: rcar_canfd: Drop the mask operation in RCANFD_GAFLCFG_SETRNC macro
    https://git.kernel.org/netdev/net-next/c/c9e17c91f165
  - [net-next,07/22] can: rcar_canfd: Add rcar_canfd_setrnc()
    https://git.kernel.org/netdev/net-next/c/6b9f8b53a1f3
  - [net-next,08/22] can: rcar_canfd: Update RCANFD_GAFLCFG macro
    https://git.kernel.org/netdev/net-next/c/a2427e44942b
  - [net-next,09/22] can: rcar_canfd: Add rnc_field_width variable to struct rcar_canfd_hw_info
    https://git.kernel.org/netdev/net-next/c/e9ffa12e02e1
  - [net-next,10/22] can: rcar_canfd: Add max_aflpn variable to struct rcar_canfd_hw_info
    https://git.kernel.org/netdev/net-next/c/2d6cb8ff9416
  - [net-next,11/22] can: rcar_canfd: Add max_cftml variable to struct rcar_canfd_hw_info
    https://git.kernel.org/netdev/net-next/c/04d7a3a4660f
  - [net-next,12/22] can: rcar_canfd: Add {nom,data}_bittiming variables to struct rcar_canfd_hw_info
    https://git.kernel.org/netdev/net-next/c/b5a9f2ec427c
  - [net-next,13/22] can: rcar_canfd: Add ch_interface_mode variable to struct rcar_canfd_hw_info
    https://git.kernel.org/netdev/net-next/c/c10e55101011
  - [net-next,14/22] can: rcar_canfd: Add shared_can_regs variable to struct rcar_canfd_hw_info
    https://git.kernel.org/netdev/net-next/c/836cc711fc18
  - [net-next,15/22] can: rcar_canfd: Add struct rcanfd_regs variable to struct rcar_canfd_hw_info
    https://git.kernel.org/netdev/net-next/c/5026d2acaefa
  - [net-next,16/22] can: rcar_canfd: Add sh variable to struct rcar_canfd_hw_info
    https://git.kernel.org/netdev/net-next/c/c5670c23d67d
  - [net-next,17/22] can: rcar_canfd: Add external_clk variable to struct rcar_canfd_hw_info
    https://git.kernel.org/netdev/net-next/c/e5258b337de2
  - [net-next,18/22] can: rcar_canfd: Enhance multi_channel_irqs handling
    https://git.kernel.org/netdev/net-next/c/0853b7e479a6
  - [net-next,19/22] can: rcar_canfd: Add RZ/G3E support
    https://git.kernel.org/netdev/net-next/c/be53aa052008
  - [net-next,20/22] can: dev: add struct data_bittiming_params to group FD parameters
    https://git.kernel.org/netdev/net-next/c/b803c4a4f788
  - [net-next,21/22] selftests: can: Import tst-filter from can-tests
    https://git.kernel.org/netdev/net-next/c/77442ffa83e8
  - [net-next,22/22] selftests: can: test_raw_filter.sh: add support of physical interfaces
    https://git.kernel.org/netdev/net-next/c/3e20585abf22

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



