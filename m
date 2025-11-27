Return-Path: <linux-can+bounces-5747-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 17AE3C8CC72
	for <lists+linux-can@lfdr.de>; Thu, 27 Nov 2025 05:01:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id B6B1134D737
	for <lists+linux-can@lfdr.de>; Thu, 27 Nov 2025 04:01:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77FF529ACDD;
	Thu, 27 Nov 2025 04:00:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KBAJJbsE"
X-Original-To: linux-can@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C5A31E9B22;
	Thu, 27 Nov 2025 04:00:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764216059; cv=none; b=KdMWe3n+iDeg9ml/4faEVPQFxpdCn7DpNXwG80Y1VZNVA60KWSIm8UvQktk9cNvCHs9Errn5v6il0/pwfidLbgCZFEf+Q7714BGg2pZ+DlSM4u0fN/9PFBgVTuoV4Fj2vNezuolG8EztQhjelTWPGQRPY5I8HTL4rjjooVQvj/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764216059; c=relaxed/simple;
	bh=pTrVoHNCoqlghXKp0rth5p2LvoOyvpfZTGzC0j7v+Io=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=ckDVo0blVVd8Eh+4yVJ4/28XEw7y/20qMgB9gtwoQtyCzR8bUzNvl8IBYkTZIpE4dwxVPMHUUgHFQJbOtw2n5kTI0YdudO0Hef2Y8asCr/tiujXnh48KaI757svOZCB+G5JooQ7l28e4WutmVCYmyYE1gw11ffEN39iy4RWCPa8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KBAJJbsE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB7EDC4CEF8;
	Thu, 27 Nov 2025 04:00:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764216058;
	bh=pTrVoHNCoqlghXKp0rth5p2LvoOyvpfZTGzC0j7v+Io=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=KBAJJbsESum0Zvtf2U4wNCfQdJQBmfvU+4HyNzAwljAunVcv17DQnRmNb7N08LUJB
	 9nChuzK7GinpX0Quwi7PVR0sC0NR233VYjp8JmxADUXlUyuYzXV7Y8gE316DJ3decK
	 Par9sGP2EFclMam8AA5f6bCf1XCTRiLNkX5QhuhclSPIUg3TTCV0K9cGjLlZFSmS7t
	 qGAZWfBr1bZ/vPdp9dpQgVC/Db1EyY5E37Jh4tU1eV++PjfDio7nx4Lu+jlSwaibxQ
	 SowmGWhxI021fe4E1Ev16tphu9g0VN8zt4W0cdX4awM0MkG2D9HvvpZfmWtdjTSEz1
	 RSlpwg33w4HLA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADE39380CEF8;
	Thu, 27 Nov 2025 04:00:21 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net 1/8] can: kvaser_usb: leaf: Fix potential infinite
 loop in
 command parsers
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176421602051.2412149.15004873997876598906.git-patchwork-notify@kernel.org>
Date: Thu, 27 Nov 2025 04:00:20 +0000
References: <20251126155713.217105-2-mkl@pengutronix.de>
In-Reply-To: <20251126155713.217105-2-mkl@pengutronix.de>
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
 linux-can@vger.kernel.org, kernel@pengutronix.de, eeodqql09@gmail.com,
 extja@kvaser.com

Hello:

This series was applied to netdev/net.git (main)
by Marc Kleine-Budde <mkl@pengutronix.de>:

On Wed, 26 Nov 2025 16:41:11 +0100 you wrote:
> From: Seungjin Bae <eeodqql09@gmail.com>
> 
> The `kvaser_usb_leaf_wait_cmd()` and `kvaser_usb_leaf_read_bulk_callback`
> functions contain logic to zero-length commands. These commands are used
> to align data to the USB endpoint's wMaxPacketSize boundary.
> 
> The driver attempts to skip these placeholders by aligning the buffer
> position `pos` to the next packet boundary using `round_up()` function.
> 
> [...]

Here is the summary with links:
  - [net,1/8] can: kvaser_usb: leaf: Fix potential infinite loop in command parsers
    https://git.kernel.org/netdev/net/c/0c73772cd2b8
  - [net,2/8] can: sja1000: fix max irq loop handling
    https://git.kernel.org/netdev/net/c/30db4451c7f6
  - [net,3/8] can: gs_usb: gs_usb_xmit_callback(): fix handling of failed transmitted URBs
    https://git.kernel.org/netdev/net/c/516a0cd1c03f
  - [net,4/8] can: gs_usb: gs_usb_receive_bulk_callback(): check actual_length before accessing header
    https://git.kernel.org/netdev/net/c/6fe9f3279f7d
  - [net,5/8] can: gs_usb: gs_usb_receive_bulk_callback(): check actual_length before accessing data
    https://git.kernel.org/netdev/net/c/395d988f9386
  - [net,6/8] can: sun4i_can: sun4i_can_interrupt(): fix max irq loop handling
    https://git.kernel.org/netdev/net/c/76544beea7cf
  - [net,7/8] can: rcar_canfd: Fix CAN-FD mode as default
    https://git.kernel.org/netdev/net/c/6d849ff57372
  - [net,8/8] net/sched: em_canid: fix uninit-value in em_canid_match
    https://git.kernel.org/netdev/net/c/0c922106d7a5

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



