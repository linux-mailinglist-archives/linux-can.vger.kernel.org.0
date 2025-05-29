Return-Path: <linux-can+bounces-3736-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FD88AC7C4F
	for <lists+linux-can@lfdr.de>; Thu, 29 May 2025 13:00:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A919F4A5873
	for <lists+linux-can@lfdr.de>; Thu, 29 May 2025 11:00:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DE2C28E58A;
	Thu, 29 May 2025 10:59:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Luo8sLAM"
X-Original-To: linux-can@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70FE128E57F;
	Thu, 29 May 2025 10:59:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748516394; cv=none; b=EFfLSYYYlJnt8pk7z6dZU/WxOd/6Y3mMSDI4f4NJIOVw57jRUyV4qBxnGxB5xdF57t75dcC6hmVVyvqPoEkPgG4vzB468iP9ySJroo42ZNiPBlFN6QbErgW1EcektIuK6De1x41pKJAQ9nc01QJPbLGG083051EaPgQegMZFIxo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748516394; c=relaxed/simple;
	bh=J9sLd/V0ChLauxiaem4hMIuzMoGYpxF/suHYrXZIaxA=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=kVinhBe7JaAEc+buEafbbkg+dPJviRCo8jGi/oqZecal32dIuQD3BGBwE5MNwFxDpFlSTRCTK0dbG6q2XeL62fRsOvmP5AqiGXfwxVsiFH2b9Xqd/8AOX/4ikRmWqsJmt7d8U9LEZRWqf3wLFxwTKkokKBeMDayT5avH8/VnVcY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Luo8sLAM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3C452C4CEEB;
	Thu, 29 May 2025 10:59:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748516394;
	bh=J9sLd/V0ChLauxiaem4hMIuzMoGYpxF/suHYrXZIaxA=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Luo8sLAMC4uZK6k/CAwCj71uq5Z8db4SQ05bLt4XWeFOrUhMWJ7K0VgjdVawI+c7Q
	 KVpqlqce2ztpCKhQQmc7l0JxU8m9uVDS+MeO59QvT8M36WdSLi2r36HGJ2+8VwhdBW
	 DsU+Sq5xcg3mczJW8PNfOhh/FZry/VlN1cbvyk4miTiBlqoE6iFxQa2Jo+rRRGBwnW
	 PP56RFJRvDAl6VTYrpRVWxGV/XHRyPsppAQ6Y8H0E72JYIGNPCrTmeBL7n32cgjMEI
	 9pvCHRmaU2EXXwE6gXbZDV12lLkGeoOGkFrAocOHZ0w8HDpdQ5iIpPrXtjdF4CODMQ
	 g0RAfcfwhqBWw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33D6F380664F;
	Thu, 29 May 2025 11:00:29 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] can: kvaser_pciefd: refine error prone echo_skb_max
 handling logic
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174851642800.3227009.2907405115218089296.git-patchwork-notify@kernel.org>
Date: Thu, 29 May 2025 11:00:28 +0000
References: <20250529075313.1101820-2-mkl@pengutronix.de>
In-Reply-To: <20250529075313.1101820-2-mkl@pengutronix.de>
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
 linux-can@vger.kernel.org, kernel@pengutronix.de, pchelkin@ispras.ru,
 stable@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Marc Kleine-Budde <mkl@pengutronix.de>:

On Thu, 29 May 2025 09:49:30 +0200 you wrote:
> From: Fedor Pchelkin <pchelkin@ispras.ru>
> 
> echo_skb_max should define the supported upper limit of echo_skb[]
> allocated inside the netdevice's priv. The corresponding size value
> provided by this driver to alloc_candev() is KVASER_PCIEFD_CAN_TX_MAX_COUNT
> which is 17.
> 
> [...]

Here is the summary with links:
  - [net] can: kvaser_pciefd: refine error prone echo_skb_max handling logic
    https://git.kernel.org/netdev/net/c/54ec8b08216f

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



