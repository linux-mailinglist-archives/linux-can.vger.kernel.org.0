Return-Path: <linux-can+bounces-2455-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D7969F726C
	for <lists+linux-can@lfdr.de>; Thu, 19 Dec 2024 03:03:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D47DF1887C70
	for <lists+linux-can@lfdr.de>; Thu, 19 Dec 2024 02:00:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26CB58614E;
	Thu, 19 Dec 2024 02:00:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iOi9iXTP"
X-Original-To: linux-can@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1FDD78F43;
	Thu, 19 Dec 2024 02:00:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734573616; cv=none; b=Q4H4Vai7NOfXjMsIp3gOnqDvn6NoWQHo/lzrimF5y5xH0yV4xAGf2Sogu7no5paxHGOHzHoSSVdB+4x7yd2UGiBAxCwxCIeV809aA0pGZVLWs80oHtNFaHJqGuJ2Xj8bC4uyJgmYc12an8c8niPJyjCiRta7kwwZAoVvOpHJ0fE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734573616; c=relaxed/simple;
	bh=PEBLwfa1cgAGFpGSFRskjctBO5Ns88AYIlFrBdIyZLE=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=DKmrYjox43TH8FAfvu5EBPLWDdzdLZjcOK6mATJjT6HhG+L4jQDmRqiYOsWCYbybwal6+KAqKgABbYHftGBNQQIh26Ilypr48ituRq3vWE0RgWB9+mk+05MUsyZR0judLdJtKP5eLtgQ9KLX88E5G+eN6/mPFzfSEsUUbur9TII=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iOi9iXTP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 740D2C4CECD;
	Thu, 19 Dec 2024 02:00:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734573614;
	bh=PEBLwfa1cgAGFpGSFRskjctBO5Ns88AYIlFrBdIyZLE=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=iOi9iXTP2adzM4d/nA56Y/bmMt5q5TY4Njp4jPzUEn6It7tt8X+AdzZqCikpRrMkd
	 kfi1Z18PAo9XarzO8fXH/PMgrzVZm0xEuFvVlDCX19DPcNK+SmK95u6YEDL3owXjUp
	 mSh3X2xPbD852GqrP2Kp00r9sirvph84KxNem3B1qGq+iwPIHzqUdNlVjndhy5QtEi
	 KXU6aVxyFtpC02KqEOK5AFUKO9Pc9YTopzAmSjxh53+95IpJDzlGoRERCfQf3gocb7
	 cGsf1nfYQicVdhK6VrenOZl6dJ/4i8XRqmclSjsRhqXSXbh2R+Uwk5XVYrN8hV11Gi
	 9H/avPLa72ddQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33DC03805DB1;
	Thu, 19 Dec 2024 02:00:33 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net 1/2] can: m_can: set init flag earlier in probe
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173457363203.1790990.3275795076100390604.git-patchwork-notify@kernel.org>
Date: Thu, 19 Dec 2024 02:00:32 +0000
References: <20241218121722.2311963-2-mkl@pengutronix.de>
In-Reply-To: <20241218121722.2311963-2-mkl@pengutronix.de>
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
 linux-can@vger.kernel.org, kernel@pengutronix.de,
 matthias.schiffer@ew.tq-group.com, msp@baylibre.com

Hello:

This series was applied to netdev/net.git (main)
by Marc Kleine-Budde <mkl@pengutronix.de>:

On Wed, 18 Dec 2024 13:10:27 +0100 you wrote:
> From: Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
> 
> While an m_can controller usually already has the init flag from a
> hardware reset, no such reset happens on the integrated m_can_pci of the
> Intel Elkhart Lake. If the CAN controller is found in an active state,
> m_can_dev_setup() would fail because m_can_niso_supported() calls
> m_can_cccr_update_bits(), which refuses to modify any other configuration
> bits when CCCR_INIT is not set.
> 
> [...]

Here is the summary with links:
  - [net,1/2] can: m_can: set init flag earlier in probe
    https://git.kernel.org/netdev/net/c/fca2977629f4
  - [net,2/2] can: m_can: fix missed interrupts with m_can_pci
    https://git.kernel.org/netdev/net/c/743375f8deee

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



