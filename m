Return-Path: <linux-can+bounces-1503-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 863FE978D63
	for <lists+linux-can@lfdr.de>; Sat, 14 Sep 2024 06:50:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B88C91C22477
	for <lists+linux-can@lfdr.de>; Sat, 14 Sep 2024 04:50:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83B8E381D9;
	Sat, 14 Sep 2024 04:50:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B7scOrXo"
X-Original-To: linux-can@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D1CF36126;
	Sat, 14 Sep 2024 04:50:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726289445; cv=none; b=PMhmwOcCZ1fGN9boiWLlT8oKWySk8scvwiGlc9J4L+dOQDsgPUhTrTg0oqY6EGklcV5Aa0Ov4kUmht+dokdAemvc2jJ5CcZ1CDCKXSG4Px1DuJuqVBmKzV9Fa+Gm/4n8RDC34MFRwf53d38QDZaqZmAwQTIPoHqK1EQRU+hoQyE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726289445; c=relaxed/simple;
	bh=gRr507NH/ty6OKMHJUFiC+WJRDcmui5alYqQCrXBm44=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=oqjqYJkTxK3Sg9FcZCFrsTBlCNHr/M2twQoytkBYFBW+MaZlxVPJn6In3xlK5g5DmqXPBnT6QKJ727vuQsVU7kKBDI8t3MNOJ48Q0t9EgP9CtS6iRyjhSHrBVoLXHMD32iKQZmYPCNi1hueis8cWk4ocVGmsCllaGJhKUqTOoA8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B7scOrXo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DED5FC4CECC;
	Sat, 14 Sep 2024 04:50:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726289444;
	bh=gRr507NH/ty6OKMHJUFiC+WJRDcmui5alYqQCrXBm44=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=B7scOrXoZvQauTWgGYqI+afVbgV5jhUEjBC+n1StwWH6djn43ABXQci6qqJnmSzCD
	 Cb2uwYcW1MQjlr52MAt6YE/mkV4lwXSDGJmO7/pvTSmDnkQxI8NxQmEmUMuda37REq
	 9L8mu3XrtJvhZda0hzNXB1gbRYay39DdPZJ60SjIS9opEHCs9EYIbI0dIXCHciit9t
	 13UIPV27Rkhw6TOLO0DwkNtC8CahYFC8wY7vHoCHIfpVicHr9A844DAZmqOBqyjyRG
	 oEs9PS3TkvmldJAMEB4gvFn/CfxF0bPX6uQWCilBpisFI3iKRI0wdPahVf1g5OIqY/
	 DOuhikdM/gTNA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 7118F3806655;
	Sat, 14 Sep 2024 04:50:47 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next 1/5] can: Switch back to struct
 platform_driver::remove()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172628944601.2462238.12498275139875822806.git-patchwork-notify@kernel.org>
Date: Sat, 14 Sep 2024 04:50:46 +0000
References: <20240912080438.2826895-2-mkl@pengutronix.de>
In-Reply-To: <20240912080438.2826895-2-mkl@pengutronix.de>
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
 linux-can@vger.kernel.org, kernel@pengutronix.de,
 u.kleine-koenig@baylibre.com

Hello:

This series was applied to netdev/net-next.git (main)
by Marc Kleine-Budde <mkl@pengutronix.de>:

On Thu, 12 Sep 2024 09:58:58 +0200 you wrote:
> From: Uwe Kleine-König <u.kleine-koenig@baylibre.com>
> 
> After commit 0edb555a65d1 ("platform: Make platform_driver::remove()
> return void") .remove() is (again) the right callback to implement for
> platform drivers.
> 
> Convert all can drivers to use .remove(), with the eventual goal to drop
> struct platform_driver::remove_new(). As .remove() and .remove_new() have
> the same prototypes, conversion is done by just changing the structure
> member name in the driver initializer.
> 
> [...]

Here is the summary with links:
  - [net-next,1/5] can: Switch back to struct platform_driver::remove()
    https://git.kernel.org/netdev/net-next/c/221013afb459
  - [net-next,2/5] can: usb: Kconfig: Fix list of devices for esd_usb driver
    https://git.kernel.org/netdev/net-next/c/fe1456451a11
  - [net-next,3/5] can: m_can: m_can_chip_config(): mask timestamp wraparound IRQ
    https://git.kernel.org/netdev/net-next/c/709cbd5bb49b
  - [net-next,5/5] can: rockchip_canfd: rkcanfd_handle_error_int_reg_ec(): fix decoding of error code register
    https://git.kernel.org/netdev/net-next/c/a63e10462af6

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



