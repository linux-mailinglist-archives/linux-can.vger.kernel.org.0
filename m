Return-Path: <linux-can+bounces-6228-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 529D7D3B5D3
	for <lists+linux-can@lfdr.de>; Mon, 19 Jan 2026 19:30:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1B5143043579
	for <lists+linux-can@lfdr.de>; Mon, 19 Jan 2026 18:30:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81AFD32936F;
	Mon, 19 Jan 2026 18:30:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pYW5isZ8"
X-Original-To: linux-can@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EFB1329C73;
	Mon, 19 Jan 2026 18:30:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768847422; cv=none; b=LZjU89/YG3wJJNdveAqYU6DUkaRMA1xBjqsN01nJhNObOTSdSEpG2tZJxkHePW4B8DCuHem4EuVWB+BxlWX/Mw2ATyjlcuWhlCtMFYvl6OxRMxhOelqaBD9VS0Hz1MXBdCmUJKwfYtbCJo0KaAC4NjQLRLtuBIpidEckNi5UvgY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768847422; c=relaxed/simple;
	bh=F0Ev5xx/PPOMh7+W9OSUg/B+TA6FxVvmUYbRmiZddIk=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Yhwi/3dDnCggFkRqJ15VutnRP+33rRCraZ1l0iZ4LOzwcCayHdseom2JUbfmGS27HI67x53+4zlyXn/EWpyr+/XWQDL/EXs4b4BtSu/1JskjeCc6Ke/68Cn3gm70KiRIP/QAjYn7/BpNPcFT9KCfzN+HiN3y/R0ZfN/4EqH7QJs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pYW5isZ8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D9471C116C6;
	Mon, 19 Jan 2026 18:30:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768847421;
	bh=F0Ev5xx/PPOMh7+W9OSUg/B+TA6FxVvmUYbRmiZddIk=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=pYW5isZ853wnoCMRQlY0ulTSYQ13ltMv9kcBBH27fIikGkRV+JlLmc5hMLEw3bjJC
	 vhmmJ40ewQpmTL8liCg9ZEsUbi003dEowmIz8ZN0HkEQZ0udow4u6A45h0wH+2sLIv
	 ZR0k79S9o3dekH9i2cW+1cx/r14rWVm8p5GlKYrbOfdmHDYAgmi+ozK9lZq4Lfj1Sr
	 KYDvpdJtkL6phhBCOLQsCmfyVJLMd9QjYpmmAZdTsLJYBFE02uJtFdB9hDByFrjsbD
	 nXUbIeoFqi3tqCPzyAOVre6dwaRnaZHO63lWJwA8MeX5RCryJpcW0yTDRG41M6flqn
	 RMwbaOI4b/Z5g==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 01F223806905;
	Mon, 19 Jan 2026 18:30:21 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net 1/7] can: dev: alloc_candev_mqs(): add missing default
 CAN
 capabilities
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176884741979.92238.4588808335124303475.git-patchwork-notify@kernel.org>
Date: Mon, 19 Jan 2026 18:30:19 +0000
References: <20260116200323.366877-2-mkl@pengutronix.de>
In-Reply-To: <20260116200323.366877-2-mkl@pengutronix.de>
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
 linux-can@vger.kernel.org, kernel@pengutronix.de, socketcan@hartkopp.net

Hello:

This series was applied to netdev/net.git (main)
by Marc Kleine-Budde <mkl@pengutronix.de>:

On Fri, 16 Jan 2026 20:55:47 +0100 you wrote:
> The idea behind series 6c1f5146b214 ("Merge patch series "can: raw: better
> approach to instantly reject unsupported CAN frames"") is to set the
> capabilities of a CAN device (CAN-CC, CAN-FD, CAN-XL, and listen only) [1]
> and, based on these capabilities, reject unsupported CAN frames in the
> CAN-RAW protocol [2].
> 
> This works perfectly for CAN devices configured in CAN-FD or CAN-XL mode.
> CAN devices with static CAN control modes define their capabilities via
> can_set_static_ctrlmode() -> can_set_cap_info(). CAN devices configured by
> the user space for CAN-FD or CAN-XL set their capabilities via
> can_changelink() -> can_ctrlmode_changelink() -> can_set_cap_info().
> 
> [...]

Here is the summary with links:
  - [net,1/7] can: dev: alloc_candev_mqs(): add missing default CAN capabilities
    https://git.kernel.org/netdev/net/c/375629c92fd8
  - [net,2/7] can: gs_usb: gs_usb_receive_bulk_callback(): unanchor URL on usb_submit_urb() error
    https://git.kernel.org/netdev/net/c/79a6d1bfe114
  - [net,3/7] can: ems_usb: ems_usb_read_bulk_callback(): fix URB memory leak
    https://git.kernel.org/netdev/net/c/0ce73a0eb5a2
  - [net,4/7] can: esd_usb: esd_usb_read_bulk_callback(): fix URB memory leak
    https://git.kernel.org/netdev/net/c/5a4391bdc6c8
  - [net,5/7] can: kvaser_usb: kvaser_usb_read_bulk_callback(): fix URB memory leak
    https://git.kernel.org/netdev/net/c/248e8e1a125f
  - [net,6/7] can: mcba_usb: mcba_usb_read_bulk_callback(): fix URB memory leak
    https://git.kernel.org/netdev/net/c/710a7529fb13
  - [net,7/7] can: usb_8dev: usb_8dev_read_bulk_callback(): fix URB memory leak
    https://git.kernel.org/netdev/net/c/f7a980b3b8f8

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



