Return-Path: <linux-can+bounces-269-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BE02A8546D7
	for <lists+linux-can@lfdr.de>; Wed, 14 Feb 2024 11:10:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EE9521C2250B
	for <lists+linux-can@lfdr.de>; Wed, 14 Feb 2024 10:10:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C383D168D0;
	Wed, 14 Feb 2024 10:10:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="roYX25YU"
X-Original-To: linux-can@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B88812B78;
	Wed, 14 Feb 2024 10:10:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707905431; cv=none; b=UzycJsSgVNbaGCLTO7ab8Rq6s7T2UuBCkCcKq7ePqQIKvsO2gYPZvOUK4X/DWQYqkaBwTjYqceyCHbHuaQFMW0TkZnIj6pjM1PkRIvggqSbacdhAwQm7A+Gd8uwfuHlCB+7RxgfQOXl03gVJMk+JLVW5ZZpCmcOMQdOqlBjILuA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707905431; c=relaxed/simple;
	bh=qw+WS0L5bKVv+OzJCiXM3h3B4z14rUGaeRbO1+omU/0=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Mo7BmgpMbnYOueLv8KZ79vP7zRV0Mnq7umk7YwsDj5owLrobVViTDr4IFMBtUdz3J+2ScWk+wqEqwUlWJD042oXpRC3atUH1k8L6aD8dtO7SQJGmgtZlADeW0IY6rxbVswaHnMrNKnppNaIiw+yolTQZxKArhC9hF8zxZcnWLdw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=roYX25YU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id EDF9BC43390;
	Wed, 14 Feb 2024 10:10:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707905431;
	bh=qw+WS0L5bKVv+OzJCiXM3h3B4z14rUGaeRbO1+omU/0=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=roYX25YU1kMTwKjQ6UaLF7G+bWr5QdJVkW1iG/VNEWL0FmCvZZsUkL88S2WCSdJSG
	 tx08Bb+RPQJM+8DSqYYuogI0Kbi4g/fBuZP2QipzshnGgOByyS0rEPmUzz5WqeL8+s
	 KzJFRurgAYQfLt5CpznjOiLc1Ae9SepBLiprp/SBkkNpSjGAdIRhc6heaEkGbX93kA
	 qSvighpb/88aNhy94pteZe3j+4ciMGvwI+uI3t4HfApvL2abljLeKbDUnhONKlhjrH
	 dZN09zuLsRHKgv+c0zti1Vsui2+/jZ7OuW7L5XsvK18MCyWUzUwoxLj7k2lsHgypdS
	 ynimI5AyW1BQQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id D7C89D84BCE;
	Wed, 14 Feb 2024 10:10:30 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next 01/23] can: bcm: add recvmsg flags for own,
 local and remote traffic
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170790543087.15773.1428839431750417511.git-patchwork-notify@kernel.org>
Date: Wed, 14 Feb 2024 10:10:30 +0000
References: <20240213113437.1884372-2-mkl@pengutronix.de>
In-Reply-To: <20240213113437.1884372-2-mkl@pengutronix.de>
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
 linux-can@vger.kernel.org, kernel@pengutronix.de,
 nicolas.maier.dev@gmail.com, socketcan@hartkopp.net

Hello:

This series was applied to netdev/net-next.git (main)
by Marc Kleine-Budde <mkl@pengutronix.de>:

On Tue, 13 Feb 2024 12:25:04 +0100 you wrote:
> From: Nicolas Maier <nicolas.maier.dev@gmail.com>
> 
> CAN RAW sockets allow userspace to tell if a received CAN frame comes
> from the same socket, another socket on the same host, or another host.
> See commit 1e55659ce6dd ("can-raw: add msg_flags to distinguish local
> traffic"). However, this feature is missing in CAN BCM sockets.
> 
> [...]

Here is the summary with links:
  - [net-next,01/23] can: bcm: add recvmsg flags for own, local and remote traffic
    https://git.kernel.org/netdev/net-next/c/fec846fa7edd
  - [net-next,02/23] can: isotp: support dynamic flow control parameters
    https://git.kernel.org/netdev/net-next/c/e1aa35e16399
  - [net-next,03/23] MAINTAINERS: add Stefan Mätje as maintainer for the esd electronics GmbH PCIe/402 CAN drivers
    https://git.kernel.org/netdev/net-next/c/4dcd08b9676a
  - [net-next,04/23] can: esd: add support for esd GmbH PCIe/402 CAN interface family
    https://git.kernel.org/netdev/net-next/c/9721866f07e1
  - [net-next,05/23] can: m_can: Start/Cancel polling timer together with interrupts
    https://git.kernel.org/netdev/net-next/c/a163c5761019
  - [net-next,06/23] can: m_can: Move hrtimer init to m_can_class_register
    https://git.kernel.org/netdev/net-next/c/ba72f6c78b9b
  - [net-next,07/23] can: m_can: Write transmit header and data in one transaction
    https://git.kernel.org/netdev/net-next/c/4248ba9ea24f
  - [net-next,08/23] can: m_can: Implement receive coalescing
    https://git.kernel.org/netdev/net-next/c/07f25091ca02
  - [net-next,09/23] can: m_can: Implement transmit coalescing
    https://git.kernel.org/netdev/net-next/c/ec390d087617
  - [net-next,10/23] can: m_can: Add rx coalescing ethtool support
    https://git.kernel.org/netdev/net-next/c/9515223bd0bb
  - [net-next,11/23] can: m_can: Add tx coalescing ethtool support
    https://git.kernel.org/netdev/net-next/c/e55b963e4e94
  - [net-next,12/23] can: m_can: Use u32 for putidx
    https://git.kernel.org/netdev/net-next/c/14f0a0a4407e
  - [net-next,13/23] can: m_can: Cache tx putidx
    https://git.kernel.org/netdev/net-next/c/80c5bac02a82
  - [net-next,14/23] can: m_can: Use the workqueue as queue
    https://git.kernel.org/netdev/net-next/c/e668673ed399
  - [net-next,15/23] can: m_can: Introduce a tx_fifo_in_flight counter
    https://git.kernel.org/netdev/net-next/c/1fa80e23c150
  - [net-next,16/23] can: m_can: Use tx_fifo_in_flight for netif_queue control
    https://git.kernel.org/netdev/net-next/c/7508a10ca295
  - [net-next,17/23] can: m_can: Implement BQL
    https://git.kernel.org/netdev/net-next/c/251f913d19a8
  - [net-next,18/23] can: m_can: Implement transmit submission coalescing
    https://git.kernel.org/netdev/net-next/c/c306c3873de0
  - [net-next,19/23] can: change can network drivers maintainer
    https://git.kernel.org/netdev/net-next/c/7af9682d9eab
  - [net-next,20/23] can: kvaser_pciefd: Add support for Kvaser M.2 PCIe 4xCAN
    https://git.kernel.org/netdev/net-next/c/85216f56bde7
  - [net-next,21/23] can: softing: remove redundant NULL check
    https://git.kernel.org/netdev/net-next/c/383de5664c87
  - [net-next,22/23] can: canxl: add virtual CAN network identifier support
    https://git.kernel.org/netdev/net-next/c/c83c22ec1493
  - [net-next,23/23] MAINTAINERS: can: xilinx_can: remove Naga Sureshkumar Relli
    https://git.kernel.org/netdev/net-next/c/73b8f5015889

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



