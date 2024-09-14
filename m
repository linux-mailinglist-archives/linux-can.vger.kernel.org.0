Return-Path: <linux-can+bounces-1504-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 18D61978D65
	for <lists+linux-can@lfdr.de>; Sat, 14 Sep 2024 06:51:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A6D84287A1A
	for <lists+linux-can@lfdr.de>; Sat, 14 Sep 2024 04:51:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1293249643;
	Sat, 14 Sep 2024 04:50:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PBsPMek1"
X-Original-To: linux-can@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF38036126;
	Sat, 14 Sep 2024 04:50:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726289447; cv=none; b=QzAEB/QvKVMW+s+LIRhCFZ51ZeuOy2NWIdyUPxxLNg4FJgHF3zF67qHo4aJoZS4aSsFJn/IC2n2d5BBz0Qoas2ZyBP+aen0KIAut4lAoFr4ixAybVHpYfitpCOyrUoH6wWjHZ5HCZdlO8wNmIn8FJhgDN2W/Ipuw8cI5qsQ7QT4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726289447; c=relaxed/simple;
	bh=oetWeAh9Ww091js+pKBSxPOY8rlt02pi65xfH8BIMQw=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=ipptX6yC88yza4xnu8px4EPE4ujM65MWcGphsC9YO/fcq+JDw4vgn3ryJANkxccDmjMHQiSY+QLteFSQqzv3YaS6xLl9SzhqA7wS+RzVbIuGUg7EWjOrZsZwJZ6m0eeB5JOcsG1FUP7hJQXyGt/NI0+maAb4MRidQAvGYHJcaHo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PBsPMek1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 65E3BC4CEC0;
	Sat, 14 Sep 2024 04:50:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726289446;
	bh=oetWeAh9Ww091js+pKBSxPOY8rlt02pi65xfH8BIMQw=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=PBsPMek1cmNGZsfDvgG522gpLBano4vhVOeqhAdFQjqA0BaZq8oZnvFTUc57Rwj+C
	 vnDtFmQtbvHSoFvnq3kKRe5dqYKS4llCOBzMagUsCNSHxSW42jNMDQoXD1OT8OjZ5P
	 UPShuN/nEupe8GZ3jCItsiHP+jvA/LpSIqfB0fMTZGKM0AJgRV0cvJL86PpoqJbR8Z
	 wDyZwVQbx+lT4PoXTEEj3vp8riR7kNUmRNT7s/WXzWxcGGahePponC83N67QyGEo4O
	 /W0C4vpj/vATuDQl2LPKzQIrMXXkFHT9KsLgZ7+e+sVVKVvCPJg1tuoy81gnKhmOm6
	 S1S5TUDp+v0DQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EB1F83806655;
	Sat, 14 Sep 2024 04:50:48 +0000 (UTC)
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
 <172628944750.2462238.16531658398450059250.git-patchwork-notify@kernel.org>
Date: Sat, 14 Sep 2024 04:50:47 +0000
References: <20240912075804.2825408-2-mkl@pengutronix.de>
In-Reply-To: <20240912075804.2825408-2-mkl@pengutronix.de>
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
 linux-can@vger.kernel.org, kernel@pengutronix.de, kuniyu@amazon.com,
 syzbot+0532ac7a06fb1a03187e@syzkaller.appspotmail.com,
 mailhol.vincent@wanadoo.fr

Hello:

This series was applied to netdev/net-next.git (main)
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
    (no matching commit)
  - [net,2/5] can: esd_usb: Remove CAN_CTRLMODE_3_SAMPLES for CAN-USB/3-FD
    (no matching commit)
  - [net,3/5] can: kvaser_pciefd: Enable 64-bit DMA addressing
    (no matching commit)
  - [net,5/5] can: m_can: m_can_close(): stop clocks after device has been shut down
    (no matching commit)
  - [net-next,4/5] can: rockchip_canfd: rkcanfd_timestamp_init(): rework delay calculation
    https://git.kernel.org/netdev/net-next/c/cd0983c7f880

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



