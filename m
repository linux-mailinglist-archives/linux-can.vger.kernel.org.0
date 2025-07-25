Return-Path: <linux-can+bounces-4181-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9676AB12793
	for <lists+linux-can@lfdr.de>; Sat, 26 Jul 2025 01:40:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CD85D588030
	for <lists+linux-can@lfdr.de>; Fri, 25 Jul 2025 23:40:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1125325FA0F;
	Fri, 25 Jul 2025 23:40:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cMH+9VGy"
X-Original-To: linux-can@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCCBB258CE8;
	Fri, 25 Jul 2025 23:40:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753486830; cv=none; b=MIuRG+IgCjm9Gc8/+fLcVu6ftX5O8HL63k2PvC+Btw8lXdHf+2WQ8OBCNBEdXkSnBE3sTGax/OaMsjyqsRngVxzhNXfLjoBi2Lna1m4qt6GNnG1vb9FPRNOfaJfTd/j8fIWq678WVK2QeTE8ow0Ft/f1XxgYBa2KCd8/MGUHYUs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753486830; c=relaxed/simple;
	bh=ahsqIjIrQpQxjVjA8lLyeN8fLfZuvSJ7ZWoVl3+SKBI=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=sWvi563f5U4K0gSbg29Z8AFEwgd/0vTEoaU+ZnOsVO0kyn455GgymyTbiawVO0bP0xz6/L+OaWvRiMefcoUdBogCJ0zqvP5NL7T9CjZ5qOArrCtopXSmlFVGA3XGWjFBizDw+h97vYz9dS2LTB6BXyrKMb9a1JMp4Wy4FOHAEnw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cMH+9VGy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7FFADC4CEE7;
	Fri, 25 Jul 2025 23:40:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753486829;
	bh=ahsqIjIrQpQxjVjA8lLyeN8fLfZuvSJ7ZWoVl3+SKBI=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=cMH+9VGypLdy9rbCoZw1WTA6ePO/rDZciaDkmKbgYkDjgp1Bj6k8238QWLBqkP86T
	 9UvnEZrJE/BxCLG8ckB8DqimDXRPXpv62zK8ghOXIatmN1yYe/7+fdmiJjHQ9Mdsss
	 vlK66D471B6uXs/B4n3j1uQIRkFKDU3Z1vx5FVl+M0nHqPpg3uHEBddzfS138qv+pu
	 mKYx7gOz7wk15tnRImfE8B8q0iOwphh7vAhLK0BsG+kUrQIDpYQraUHGFJjS5BxNsp
	 aqYYRMv1JmAB4Hgl2n4N6EBtZqXgXLjaX/k4xjOaM3ql4jNyA0EWJTiQUV0qHEQnsk
	 UDFgeKd0PVjFg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33C45383BF4E;
	Fri, 25 Jul 2025 23:40:48 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next 01/27] can: janz-ican3: use sysfs_emit() in
 fwinfo_show()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175348684700.3447101.5219444722918500838.git-patchwork-notify@kernel.org>
Date: Fri, 25 Jul 2025 23:40:47 +0000
References: <20250725161327.4165174-2-mkl@pengutronix.de>
In-Reply-To: <20250725161327.4165174-2-mkl@pengutronix.de>
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
 linux-can@vger.kernel.org, kernel@pengutronix.de,
 khaledelnaggarlinux@gmail.com

Hello:

This series was applied to netdev/net-next.git (main)
by Marc Kleine-Budde <mkl@pengutronix.de>:

On Fri, 25 Jul 2025 18:05:11 +0200 you wrote:
> From: Khaled Elnaggar <khaledelnaggarlinux@gmail.com>
> 
> As recommended in Documentation/filesystems/sysfs.rst, show() callbacks
> should use sysfs_emit() or sysfs_emit_at() to format values returned to
> userspace. Replace scnprintf() with sysfs_emit() in fwinfo_show().
> 
> Signed-off-by: Khaled Elnaggar <khaledelnaggarlinux@gmail.com>
> Link: https://patch.msgid.link/20250712133609.331904-1-khaledelnaggarlinux@gmail.com
> Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
> 
> [...]

Here is the summary with links:
  - [net-next,01/27] can: janz-ican3: use sysfs_emit() in fwinfo_show()
    https://git.kernel.org/netdev/net-next/c/21e9b7d11218
  - [net-next,02/27] can: ti_hecc: fix -Woverflow compiler warning
    https://git.kernel.org/netdev/net-next/c/7cae4d04717b
  - [net-next,03/27] can: ti_hecc: Kconfig: add COMPILE_TEST
    https://git.kernel.org/netdev/net-next/c/0e7896b95f2b
  - [net-next,04/27] can: tscan1: Kconfig: add COMPILE_TEST
    https://git.kernel.org/netdev/net-next/c/5323af351e75
  - [net-next,05/27] can: tscan1: CAN_TSCAN1 can depend on PC104
    https://git.kernel.org/netdev/net-next/c/b7d012e59627
  - [net-next,06/27] docs: Fix kernel-doc error in CAN driver
    https://git.kernel.org/netdev/net-next/c/2db7a52ca9ed
  - [net-next,07/27] can: kvaser_pciefd: Add support to control CAN LEDs on device
    https://git.kernel.org/netdev/net-next/c/44f0b630f67e
  - [net-next,08/27] can: kvaser_pciefd: Add support for ethtool set_phys_id()
    https://git.kernel.org/netdev/net-next/c/e74249a00bf1
  - [net-next,09/27] can: kvaser_pciefd: Add intermediate variable for device struct in probe()
    https://git.kernel.org/netdev/net-next/c/69a2cb633c27
  - [net-next,10/27] can: kvaser_pciefd: Store the different firmware version components in a struct
    https://git.kernel.org/netdev/net-next/c/5131f18ffa97
  - [net-next,11/27] can: kvaser_pciefd: Store device channel index
    https://git.kernel.org/netdev/net-next/c/d54b16b40dda
  - [net-next,12/27] can: kvaser_pciefd: Split driver into C-file and header-file.
    https://git.kernel.org/netdev/net-next/c/20bc87ae5149
  - [net-next,13/27] can: kvaser_pciefd: Add devlink support
    https://git.kernel.org/netdev/net-next/c/0d1b337b6d6c
  - [net-next,14/27] can: kvaser_pciefd: Expose device firmware version via devlink info_get()
    https://git.kernel.org/netdev/net-next/c/3d68ecf4173c
  - [net-next,15/27] can: kvaser_pciefd: Add devlink port support
    https://git.kernel.org/netdev/net-next/c/6271c8b82730
  - [net-next,16/27] Documentation: devlink: add devlink documentation for the kvaser_pciefd driver
    https://git.kernel.org/netdev/net-next/c/fed552478e6f
  - [net-next,17/27] can: kvaser_usb: Add support to control CAN LEDs on device
    https://git.kernel.org/netdev/net-next/c/478248f1bc0c
  - [net-next,18/27] can: kvaser_usb: Add support for ethtool set_phys_id()
    https://git.kernel.org/netdev/net-next/c/3d7a3de9eba4
  - [net-next,19/27] can: kvaser_usb: Assign netdev.dev_port based on device channel index
    https://git.kernel.org/netdev/net-next/c/c151b06a087a
  - [net-next,20/27] can: kvaser_usb: Add intermediate variables
    https://git.kernel.org/netdev/net-next/c/827158a67c86
  - [net-next,21/27] can: kvaser_usb: Move comment regarding max_tx_urbs
    https://git.kernel.org/netdev/net-next/c/7506789c5335
  - [net-next,22/27] can: kvaser_usb: Store the different firmware version components in a struct
    https://git.kernel.org/netdev/net-next/c/280eba332b36
  - [net-next,23/27] can: kvaser_usb: Store additional device information
    https://git.kernel.org/netdev/net-next/c/0020f2ba4099
  - [net-next,24/27] can: kvaser_usb: Add devlink support
    https://git.kernel.org/netdev/net-next/c/9505a83fc4e1
  - [net-next,25/27] can: kvaser_usb: Expose device information via devlink info_get()
    https://git.kernel.org/netdev/net-next/c/8720aed90c87
  - [net-next,26/27] can: kvaser_usb: Add devlink port support
    https://git.kernel.org/netdev/net-next/c/aa6a5c995e16
  - [net-next,27/27] Documentation: devlink: add devlink documentation for the kvaser_usb driver
    https://git.kernel.org/netdev/net-next/c/6304c4c8476d

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



