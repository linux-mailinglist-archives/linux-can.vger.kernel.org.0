Return-Path: <linux-can+bounces-1501-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 47C69978D4E
	for <lists+linux-can@lfdr.de>; Sat, 14 Sep 2024 06:30:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EAE721F255AF
	for <lists+linux-can@lfdr.de>; Sat, 14 Sep 2024 04:30:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C94DD1758E;
	Sat, 14 Sep 2024 04:30:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kabH2t/M"
X-Original-To: linux-can@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A09AE2107;
	Sat, 14 Sep 2024 04:30:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726288229; cv=none; b=JtxEhYulyz8gS34v/9YR80eg1neZqzHYj/TKV5qHUc/PHi1SBZq16vwanSHcZLs9Mi5uXFknHgyAF8Ya1/0yxK8fw4l3b3N7zHHq9eGfabgUi62C909kUmJI+oDrbqWIr1xD0OWxtRdsEQrKD4/elB/o6k9NQyTFMcLrSKTjCQU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726288229; c=relaxed/simple;
	bh=Pt23YDzsiXIxf86qTthldfNXNvQFdJvxHF/Pisjvi8k=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=qNkrfLBsZ6ScEa+Rp1OerrkFrLsIvJeRVqkwiBHjlfWkKD0D1j1rKr/Z904bPtbgpqYefOZwTPSjhQz6h0uWQljf7kwFAlnW1OIqHdiYeC4CsEt/Wxw00ggaVjKfdFonJZNbl772i3EYJyLq/cRwsMF0C7uM/b9xqojCKuh8my8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kabH2t/M; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28FE7C4CEC0;
	Sat, 14 Sep 2024 04:30:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726288229;
	bh=Pt23YDzsiXIxf86qTthldfNXNvQFdJvxHF/Pisjvi8k=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=kabH2t/M6TX6Q3Zxqlk+gS4k+mq3AcGncXKl7RpHxOw3nmWpdatZN6qcczdQI+irO
	 sXOREKtrkX3/gJoe4YvdKdrJXrmuKEQoRFfwwS5Q0omwOgfGvdZ5MeOJ+Z/DNLPMck
	 r8SPlRjKveQGg7e9moV3f3z9dxe4HXTSJtR3YtIp5tpRHw4Wny0MLXRkLKNh6UygRg
	 Jeyhye+Ffo4xzOEGtNDHyD5vVvvEXFt1ubyE6cFkq1QEdMgu2RXWdAHFHBoOLT3YlM
	 ZWd22fqNVY2UqPiPohe+dW09fFXpOrYqg2/ogES3b59H4fEn79dxPEPiLz578IpKVj
	 +CKSqfJCmz5Gg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id AE5CE3806655;
	Sat, 14 Sep 2024 04:30:31 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net 1/5] can: bcm: Clear bo->bcm_proc_read after
 remove_proc_entry().
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172628823052.2458848.2139057553371045622.git-patchwork-notify@kernel.org>
Date: Sat, 14 Sep 2024 04:30:30 +0000
References: <20240912075804.2825408-2-mkl@pengutronix.de>
In-Reply-To: <20240912075804.2825408-2-mkl@pengutronix.de>
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
 linux-can@vger.kernel.org, kernel@pengutronix.de, kuniyu@amazon.com,
 syzbot+0532ac7a06fb1a03187e@syzkaller.appspotmail.com,
 mailhol.vincent@wanadoo.fr

Hello:

This series was applied to netdev/net.git (main)
by Marc Kleine-Budde <mkl@pengutronix.de>:

On Thu, 12 Sep 2024 09:50:50 +0200 you wrote:
> From: Kuniyuki Iwashima <kuniyu@amazon.com>
> 
> syzbot reported a warning in bcm_release(). [0]
> 
> The blamed change fixed another warning that is triggered when
> connect() is issued again for a socket whose connect()ed device has
> been unregistered.
> 
> [...]

Here is the summary with links:
  - [net,1/5] can: bcm: Clear bo->bcm_proc_read after remove_proc_entry().
    https://git.kernel.org/netdev/net/c/94b0818fa635
  - [net,2/5] can: esd_usb: Remove CAN_CTRLMODE_3_SAMPLES for CAN-USB/3-FD
    https://git.kernel.org/netdev/net/c/75b318954057
  - [net,3/5] can: kvaser_pciefd: Enable 64-bit DMA addressing
    https://git.kernel.org/netdev/net/c/d0fa06408ccf
  - [net,5/5] can: m_can: m_can_close(): stop clocks after device has been shut down
    https://git.kernel.org/netdev/net/c/2c09b50efcad
  - [net-next,4/5] can: rockchip_canfd: rkcanfd_timestamp_init(): rework delay calculation
    (no matching commit)

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



