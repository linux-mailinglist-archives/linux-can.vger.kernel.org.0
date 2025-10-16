Return-Path: <linux-can+bounces-5199-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A39EDBE1283
	for <lists+linux-can@lfdr.de>; Thu, 16 Oct 2025 03:20:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 19EB219C6D5D
	for <lists+linux-can@lfdr.de>; Thu, 16 Oct 2025 01:21:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3311F155A4E;
	Thu, 16 Oct 2025 01:20:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FkinQU7y"
X-Original-To: linux-can@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0318B442C;
	Thu, 16 Oct 2025 01:20:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760577636; cv=none; b=RaWUoiZQ8Y2dl+3/NF+73SHcPk6eMKdgTJXV8QYUXhPmlUPTub9JKaw2RBy2ZkRtRU20NAU8FWGvcGI4591D+ijkzHn1sCh1GySM52Y4gYgsahyEppUBYGE/u53H81NRa3Q8NWA7odagIuCccZm9qUPDWonEUG0G/NzIyZfboCw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760577636; c=relaxed/simple;
	bh=43aNLpaRPMveoFouYsYDj85SLDeKtvsSv7RDL5fKxbY=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=p1oLBXGLeNwPeNVkG7NoOJmr9nKZmG1Kpa4QBpgzRAKEocPAZYEfnoyzPJnXzzEicVSGQdXvH5P8zi9qjGmg8tIeHKpDy2CgrsUgqxd51FgtnYllJvR/X27Wl6DOd5R31+rXzob4UpmlY+5+ZHlTpb8oT7NQ7S2a3rdWQSFlICY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FkinQU7y; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E636C4CEF8;
	Thu, 16 Oct 2025 01:20:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760577635;
	bh=43aNLpaRPMveoFouYsYDj85SLDeKtvsSv7RDL5fKxbY=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=FkinQU7yl2MZv9P1P85CpLRRNka9W4yLFVx/h5VJsT10hpLtc3U92V7jAfXiqqldn
	 DByWYPs5xWMiFi55IM9ZxC0OdTs8iIWqPiG1YfNwMbITJ/Clt0ULP1GCWE+Sqw1kVj
	 l30Q7wzLIdlJ1+yxyPLcEFEt1YlnzcC3G89VBj/ip6qK5hThqwXtFdrLorfCZse3+Q
	 JFK1d7EaF443IO1c69/vqV8Uxx/sS9XAhhqWRj5R0gFbOvWNkC0pzD/1ra5xRb2UbD
	 GPClgxxL6xkY2NyqQ9zDqhB1BGvHahzAjh41Skya0sht4lINpBUQIhJmPHVJtad5VB
	 5cpzsukTwCR3A==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 34187380DBE9;
	Thu, 16 Oct 2025 01:20:21 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net 01/10] can: gs_usb: increase max interface to U8_MAX
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176057762001.1121485.1835557132409188926.git-patchwork-notify@kernel.org>
Date: Thu, 16 Oct 2025 01:20:20 +0000
References: <20251014122140.990472-2-mkl@pengutronix.de>
In-Reply-To: <20251014122140.990472-2-mkl@pengutronix.de>
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
 linux-can@vger.kernel.org, kernel@pengutronix.de, uwu@coelacanthus.name,
 runcheng.lu@hpmicro.com, stable@vger.kernel.org, mailhol@kernel.org

Hello:

This series was applied to netdev/net.git (main)
by Marc Kleine-Budde <mkl@pengutronix.de>:

On Tue, 14 Oct 2025 14:17:48 +0200 you wrote:
> From: Celeste Liu <uwu@coelacanthus.name>
> 
> This issue was found by Runcheng Lu when develop HSCanT USB to CAN FD
> converter[1]. The original developers may have only 3 interfaces
> device to test so they write 3 here and wait for future change.
> 
> During the HSCanT development, we actually used 4 interfaces, so the
> limitation of 3 is not enough now. But just increase one is not
> future-proofed. Since the channel index type in gs_host_frame is u8,
> just make canch[] become a flexible array with a u8 index, so it
> naturally constraint by U8_MAX and avoid statically allocate 256
> pointer for every gs_usb device.
> 
> [...]

Here is the summary with links:
  - [net,01/10] can: gs_usb: increase max interface to U8_MAX
    https://git.kernel.org/netdev/net/c/2a27f6a8fb57
  - [net,02/10] can: gs_usb: gs_make_candev(): populate net_device->dev_port
    https://git.kernel.org/netdev/net/c/a12f0bc764da
  - [net,03/10] can: m_can: m_can_plat_remove(): add missing pm_runtime_disable()
    https://git.kernel.org/netdev/net/c/ba569fb07a7e
  - [net,04/10] can: m_can: m_can_handle_state_errors(): fix CAN state transition to Error Active
    https://git.kernel.org/netdev/net/c/3d9db29b45f9
  - [net,05/10] can: m_can: m_can_chip_config(): bring up interface in correct state
    https://git.kernel.org/netdev/net/c/4942c42fe184
  - [net,06/10] can: m_can: fix CAN state in system PM
    https://git.kernel.org/netdev/net/c/a9e30a22d6f2
  - [net,07/10] can: m_can: replace Dong Aisheng's old email address
    https://git.kernel.org/netdev/net/c/49836ff2f37d
  - [net,08/10] can: remove false statement about 1:1 mapping between DLC and length
    https://git.kernel.org/netdev/net/c/c282993ccd97
  - [net,09/10] can: add Transmitter Delay Compensation (TDC) documentation
    https://git.kernel.org/netdev/net/c/b5746b3e8ea4
  - [net,10/10] can: j1939: add missing calls in NETDEV_UNREGISTER notification handler
    https://git.kernel.org/netdev/net/c/93a27b5891b8

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



