Return-Path: <linux-can+bounces-5043-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 709A1BA5468
	for <lists+linux-can@lfdr.de>; Sat, 27 Sep 2025 00:01:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5CE457AAD90
	for <lists+linux-can@lfdr.de>; Fri, 26 Sep 2025 21:59:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B38E27702D;
	Fri, 26 Sep 2025 22:01:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Anw9x5cC"
X-Original-To: linux-can@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 634162367CC;
	Fri, 26 Sep 2025 22:01:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758924079; cv=none; b=aobPUjMGYe3jSa7uM3LFrI5rVQMO+7+T2EbgNOTQsy+kOgVohovd2ODM9SEexssENdJT99xh9plHSoZdX5t0XdIA7zz8brvszb7mZA/T/pP3zZ0jDYe7CRcIKveELc6mU8LtCad6LJLYBJQ9H+1LKmgb/jmzh2ODRXpnS748eSg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758924079; c=relaxed/simple;
	bh=3fKdGwxJfddl3y0Wsp+aZkE/h5XIh7Po0ZOWIhUTxLc=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=SGeG5tu3BONvOhrZe91gk11fPGTLz5PHI6Sf91jr6J8wDJ6lQCxGbLBiy9QCtRIyRo4AvJ0cXBHlNLsfJ4oCJ16P2xY3OaXM/pUIWnPSaLm580lgm48pgAcjHNd5xCKO/RIi0CK/lM0/B4vHnhH/lGA9DX7VNoaA54guR/qrZCQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Anw9x5cC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 01D4FC4CEF4;
	Fri, 26 Sep 2025 22:01:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758924079;
	bh=3fKdGwxJfddl3y0Wsp+aZkE/h5XIh7Po0ZOWIhUTxLc=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Anw9x5cCyfd3gEcsXSbFoyz2WWsddL4bZ68buUU7ItLJd7B/Pg5GsAWpn2NWB+g92
	 LBPGCDGLYS/cbDTxRMucYgypxrXuHJcVL6lC5I7wyTPpEfO88q7/C4Q4PUwUtPTdQQ
	 VGdJta5h156gTEHYO3PilS1zOQBPSTefTMOe6S+zt5P8rcTwY3KdML8/abXjtGIQZU
	 HE7m8VoiD0+wS/NyofsrbUUyzg445/mxnCsjtSEWs2kg7wlLB65E4B/3R+sqe8RZwS
	 jrvHUayo1lMjIPxm6kOCjJUGeWzCSQKERGN4y7uvSCP2PdtxGdUQCkFCKbuteqEvx4
	 2qYriJk44Lsfg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70FDA39D0C3F;
	Fri, 26 Sep 2025 22:01:15 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next 01/48] can: m_can: use us_to_ktime() where
 appropriate
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175892407426.73145.15479318496670639138.git-patchwork-notify@kernel.org>
Date: Fri, 26 Sep 2025 22:01:14 +0000
References: <20250925121332.848157-2-mkl@pengutronix.de>
In-Reply-To: <20250925121332.848157-2-mkl@pengutronix.de>
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
 linux-can@vger.kernel.org, kernel@pengutronix.de, zhao.xichao@vivo.com,
 mailhol@kernel.org

Hello:

This series was applied to netdev/net-next.git (main)
by Marc Kleine-Budde <mkl@pengutronix.de>:

On Thu, 25 Sep 2025 14:07:38 +0200 you wrote:
> From: Xichao Zhao <zhao.xichao@vivo.com>
> 
> The tx_coalesce_usecs_irq are more suitable for using the
> us_to_ktime(). This can make the code more concise and
> enhance readability.
> 
> Signed-off-by: Xichao Zhao <zhao.xichao@vivo.com>
> Reviewed-by: Vincent Mailhol <mailhol@kernel.org>
> Link: https://patch.msgid.link/20250825090904.248927-1-zhao.xichao@vivo.com
> [mkl: remove not needed line break]
> Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
> 
> [...]

Here is the summary with links:
  - [net-next,01/48] can: m_can: use us_to_ktime() where appropriate
    https://git.kernel.org/netdev/net-next/c/646cb48d4477
  - [net-next,02/48] MAINTAINERS: update Vincent Mailhol's email address
    https://git.kernel.org/netdev/net-next/c/39b8e0fef155
  - [net-next,03/48] can: dev: sort includes by alphabetical order
    https://git.kernel.org/netdev/net-next/c/4827dcc19cc7
  - [net-next,04/48] can: peak: Modification of references to email accounts being deleted
    https://git.kernel.org/netdev/net-next/c/f1880f9cc147
  - [net-next,05/48] can: rcar_canfd: Update bit rate constants for RZ/G3E and R-Car Gen4
    https://git.kernel.org/netdev/net-next/c/100fafc3e461
  - [net-next,06/48] can: rcar_canfd: Update RCANFD_CFG_* macros
    https://git.kernel.org/netdev/net-next/c/726213c8e79a
  - [net-next,07/48] can: rcar_canfd: Simplify nominal bit rate config
    https://git.kernel.org/netdev/net-next/c/02d274adf485
  - [net-next,08/48] can: rcar_canfd: Simplify data bit rate config
    https://git.kernel.org/netdev/net-next/c/33815032b0a6
  - [net-next,09/48] can: rcar_can: Consistently use ndev for net_device pointers
    https://git.kernel.org/netdev/net-next/c/7abf70449369
  - [net-next,10/48] can: rcar_can: Add helper variable dev to rcar_can_probe()
    https://git.kernel.org/netdev/net-next/c/f7844496cba4
  - [net-next,11/48] can: rcar_can: Convert to Runtime PM
    https://git.kernel.org/netdev/net-next/c/1bbff1762638
  - [net-next,12/48] can: rcar_can: Convert to BIT()
    https://git.kernel.org/netdev/net-next/c/bcf4dee47fdf
  - [net-next,13/48] can: rcar_can: Convert to GENMASK()
    https://git.kernel.org/netdev/net-next/c/28f3617c392a
  - [net-next,14/48] can: rcar_can: CTLR bitfield conversion
    https://git.kernel.org/netdev/net-next/c/669abc406812
  - [net-next,15/48] can: rcar_can: TFCR bitfield conversion
    https://git.kernel.org/netdev/net-next/c/75f319455d05
  - [net-next,16/48] can: rcar_can: BCR bitfield conversion
    https://git.kernel.org/netdev/net-next/c/8d930226d3e5
  - [net-next,17/48] can: rcar_can: Mailbox bitfield conversion
    https://git.kernel.org/netdev/net-next/c/729b1c69b8fa
  - [net-next,18/48] can: rcar_can: Do not print alloc_candev() failures
    https://git.kernel.org/netdev/net-next/c/5317225e015c
  - [net-next,19/48] can: rcar_can: Convert to %pe
    https://git.kernel.org/netdev/net-next/c/7207788031b9
  - [net-next,20/48] can: esd_usb: Rework display of error messages
    https://git.kernel.org/netdev/net-next/c/c6e07521431c
  - [net-next,21/48] can: esd_usb: Avoid errors triggered from USB disconnect
    https://git.kernel.org/netdev/net-next/c/37dc3ea4d2a2
  - [net-next,22/48] can: raw: reorder struct uniqframe's members to optimise packing
    https://git.kernel.org/netdev/net-next/c/fc8418eca43d
  - [net-next,23/48] can: raw: use bitfields to store flags in struct raw_sock
    https://git.kernel.org/netdev/net-next/c/890e5198a6e5
  - [net-next,24/48] can: raw: reorder struct raw_sock's members to optimise packing
    https://git.kernel.org/netdev/net-next/c/a146cfaaa0dd
  - [net-next,25/48] can: annotate mtu accesses with READ_ONCE()
    https://git.kernel.org/netdev/net-next/c/c67732d06786
  - [net-next,26/48] can: dev: turn can_set_static_ctrlmode() into a non-inline function
    https://git.kernel.org/netdev/net-next/c/7c7da8aa3fd6
  - [net-next,27/48] can: populate the minimum and maximum MTU values
    https://git.kernel.org/netdev/net-next/c/23049938605b
  - [net-next,28/48] can: enable CAN XL for virtual CAN devices by default
    https://git.kernel.org/netdev/net-next/c/b98aceb65e2c
  - [net-next,29/48] can: dev: move struct data_bittiming_params to linux/can/bittiming.h
    https://git.kernel.org/netdev/net-next/c/cc470fcf1d59
  - [net-next,30/48] can: dev: make can_get_relative_tdco() FD agnostic and move it to bittiming.h
    https://git.kernel.org/netdev/net-next/c/7208385df784
  - [net-next,31/48] can: netlink: document which symbols are FD specific
    https://git.kernel.org/netdev/net-next/c/94040a8f4845
  - [net-next,32/48] can: netlink: refactor can_validate_bittiming()
    https://git.kernel.org/netdev/net-next/c/f5ae5a75412d
  - [net-next,33/48] can: netlink: add can_validate_tdc()
    https://git.kernel.org/netdev/net-next/c/b23a8425cba5
  - [net-next,34/48] can: netlink: add can_validate_databittiming()
    https://git.kernel.org/netdev/net-next/c/3820a415bece
  - [net-next,35/48] can: netlink: refactor CAN_CTRLMODE_TDC_{AUTO,MANUAL} flag reset logic
    https://git.kernel.org/netdev/net-next/c/45be26b7e35a
  - [net-next,36/48] can: netlink: remove useless check in can_tdc_changelink()
    https://git.kernel.org/netdev/net-next/c/2b0a6930ae7c
  - [net-next,37/48] can: netlink: make can_tdc_changelink() FD agnostic
    https://git.kernel.org/netdev/net-next/c/530c918f8cf6
  - [net-next,38/48] can: netlink: add can_dtb_changelink()
    https://git.kernel.org/netdev/net-next/c/2e543af483a9
  - [net-next,39/48] can: netlink: add can_ctrlmode_changelink()
    https://git.kernel.org/netdev/net-next/c/e1a5cd9d6665
  - [net-next,40/48] can: netlink: make can_tdc_get_size() FD agnostic
    https://git.kernel.org/netdev/net-next/c/63888a578016
  - [net-next,41/48] can: netlink: add can_data_bittiming_get_size()
    https://git.kernel.org/netdev/net-next/c/d5f45ef88ba4
  - [net-next,42/48] can: netlink: add can_bittiming_fill_info()
    https://git.kernel.org/netdev/net-next/c/e1a2be5a6967
  - [net-next,43/48] can: netlink: add can_bittiming_const_fill_info()
    https://git.kernel.org/netdev/net-next/c/aaeebdb7a723
  - [net-next,44/48] can: netlink: add can_bitrate_const_fill_info()
    https://git.kernel.org/netdev/net-next/c/d5ee934ee19b
  - [net-next,45/48] can: netlink: make can_tdc_fill_info() FD agnostic
    https://git.kernel.org/netdev/net-next/c/e72f1ba700e3
  - [net-next,46/48] can: calc_bittiming: make can_calc_tdco() FD agnostic
    https://git.kernel.org/netdev/net-next/c/6ffc1230d3a7
  - [net-next,47/48] can: dev: add can_get_ctrlmode_str()
    https://git.kernel.org/netdev/net-next/c/7de54546fff1
  - [net-next,48/48] can: netlink: add userland error messages
    https://git.kernel.org/netdev/net-next/c/6742ca18cb41

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



