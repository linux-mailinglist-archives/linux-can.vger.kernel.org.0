Return-Path: <linux-can+bounces-6117-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D5D7D155AA
	for <lists+linux-can@lfdr.de>; Mon, 12 Jan 2026 22:01:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5B8CC30693C3
	for <lists+linux-can@lfdr.de>; Mon, 12 Jan 2026 21:00:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD170341072;
	Mon, 12 Jan 2026 21:00:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V2PdVyRB"
X-Original-To: linux-can@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8931D340A43;
	Mon, 12 Jan 2026 21:00:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768251621; cv=none; b=SgY920W0PoSCfJAY+ZJ+XuzXpQ1iOaCbGYH+nc6ucZcPRfZrH1P6I64UnZ2zYw/w6m3z8ARVng9dt6ZK0thMKWXJpS+r/wAKPVpgcfZixQApOTUUMGK0O9hYXZuqGkFaUCCBsgruA06U4Df0d2ZtJC6E3gGitFuIy1dDIZa4d8g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768251621; c=relaxed/simple;
	bh=5PmNXY8c9JWJMqljoZbFiS8oZ+pURDpk9kyFp+ADh7U=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=jxztiaHzP57VGsoA70sV0HpAnHP0+kRxjytn+FqlBtnu/wMbp6aR3JaxNQdK3o2aCaLyuO+XkK0/zismO5w41ajawZ0KkbOZ0LB/mXVcDK4vMYq0MakVeHYZv3XRK9VRzsxNKqbojM8ezAxj8yn/iFCCuY8UhDW/V0QG3qtfQUw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V2PdVyRB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 56C3FC19425;
	Mon, 12 Jan 2026 21:00:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768251621;
	bh=5PmNXY8c9JWJMqljoZbFiS8oZ+pURDpk9kyFp+ADh7U=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=V2PdVyRB98+G3yfXHqWeanWSuyErt6+4i5AAJqrvEBLdCcNEYCWqVThT4suqudGZW
	 pQjwlJl7MrHEk4aytYPZa95ryPnSk2TqguGTwWfYkJx6R2RsTSVZH9URIUop8NNuqQ
	 HeVJZWbdpYRXbctpWm8k5kitDufdsZ57ghqiZX4fHA6ym6449hTvi+cRKCc96+8/FZ
	 +y7lVbkHANGs/nH9OdCadIIuAae9Cl1c2fDLNPF39SnyffERTcOpuX9NOiXuRDq6JO
	 ClfjJQiE6yfev5wjJIiq6h1A8S2GHkG8ckiC6jDH8dPGDLcrU5scKt9BhQb2CNNUio
	 U4u5niRAyAGOg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 78D1A380CFD5;
	Mon, 12 Jan 2026 20:56:56 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net 1/3] can: etas_es58x: allow partial RX URB allocation
 to
 succeed
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176825141505.1092878.276430348692974730.git-patchwork-notify@kernel.org>
Date: Mon, 12 Jan 2026 20:56:55 +0000
References: <20260109135311.576033-2-mkl@pengutronix.de>
In-Reply-To: <20260109135311.576033-2-mkl@pengutronix.de>
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
 linux-can@vger.kernel.org, kernel@pengutronix.de, swilczek.lx@gmail.com,
 syzbot+e8cb6691a7cf68256cb8@syzkaller.appspotmail.com, mailhol@kernel.org

Hello:

This series was applied to netdev/net.git (main)
by Marc Kleine-Budde <mkl@pengutronix.de>:

On Fri,  9 Jan 2026 14:46:10 +0100 you wrote:
> From: Szymon Wilczek <swilczek.lx@gmail.com>
> 
> When es58x_alloc_rx_urbs() fails to allocate the requested number of
> URBs but succeeds in allocating some, it returns an error code.
> This causes es58x_open() to return early, skipping the cleanup label
> 'free_urbs', which leads to the anchored URBs being leaked.
> 
> [...]

Here is the summary with links:
  - [net,1/3] can: etas_es58x: allow partial RX URB allocation to succeed
    https://git.kernel.org/netdev/net/c/b1979778e985
  - [net,2/3] can: gs_usb: gs_usb_receive_bulk_callback(): fix URB memory leak
    https://git.kernel.org/netdev/net/c/7352e1d5932a
  - [net,3/3] can: ctucanfd: fix SSP_SRC in cases when bit-rate is higher than 1 MBit.
    https://git.kernel.org/netdev/net/c/e707c591a139

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



