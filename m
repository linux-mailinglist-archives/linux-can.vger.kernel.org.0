Return-Path: <linux-can+bounces-5852-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1176DCB5644
	for <lists+linux-can@lfdr.de>; Thu, 11 Dec 2025 10:43:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 5CAA53007E63
	for <lists+linux-can@lfdr.de>; Thu, 11 Dec 2025 09:43:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 536572FCC0F;
	Thu, 11 Dec 2025 09:43:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h5gEkJEu"
X-Original-To: linux-can@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2723E381C4;
	Thu, 11 Dec 2025 09:43:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765446204; cv=none; b=prQTjLl441rMKJjD8mzvDAZgAvVwwSxNKlM1YpW1Ck4bnMgGTlQ0pLr5eoMCc4l6eW0IUH6oCdM4cEK30nch8E1pz2ibh4K+ypSBBrr6+/XFFzX0NfY3Q7TlpZR4MEo3WqeYfPzbObey8KVVia7vMtcBH3gF050xtt3xZSGUf9U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765446204; c=relaxed/simple;
	bh=GJaDJkmnWRTHvmHqWuLfnA/PUIOUXg8pn4fL0gM1KEA=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=koMdchAPRlIyoByJQph6HhEnV2oeXCrC8ia63Pkv3PrC821G+BnM6ev0+qRVKoZM2wBkY8c0ukyjCHFTZx/n2H52w3V+XxdGzFauQgg7NX1TTncJDU3jCDEYPRG58DXGjZ5KEGD9HRPylOcSwC2K3X3C31vznUk7/hAwmXcI2tw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h5gEkJEu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF3A2C116B1;
	Thu, 11 Dec 2025 09:43:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765446203;
	bh=GJaDJkmnWRTHvmHqWuLfnA/PUIOUXg8pn4fL0gM1KEA=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=h5gEkJEu/l0tv4J3gyz7VGy7902Sn1LA3BwJ7w3Xcwutl6VfBAt5R2AI1/S+JkAfD
	 ugDdvqT/FmFn71a0pga6xu8dqkmvNNZCD0XWhynliXU9SdP2gIJRl1jlvu6bXRJ5XD
	 ZViurZAhSQCFl9yRjLzI36pqII6mqgDW4CQB2nFZ/PuTAYPOxuv+onpBaKthNn/Eh1
	 blVHz5SpDYIDZZhKPY5uJ0gFPcunPkPe5bmj/8GvXRJW9ruEK5tEoFBNqyifzuQivY
	 UIFHUxaG23hpH7cZUJzhotYtyUkhDr0rZSNcD/hu4vE3jQ2PqoqlxK8KGr6SrtJ4Lj
	 KyFqYRvTXoQ/Q==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id F2A0C3809A35;
	Thu, 11 Dec 2025 09:40:18 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net 1/2] can: fix build dependency
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176544601752.1308621.3486706619884778020.git-patchwork-notify@kernel.org>
Date: Thu, 11 Dec 2025 09:40:17 +0000
References: <20251210083448.2116869-2-mkl@pengutronix.de>
In-Reply-To: <20251210083448.2116869-2-mkl@pengutronix.de>
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
 linux-can@vger.kernel.org, kernel@pengutronix.de, arnd@arndb.de,
 lkp@intel.com, socketcan@hartkopp.net

Hello:

This series was applied to netdev/net.git (main)
by Marc Kleine-Budde <mkl@pengutronix.de>:

On Wed, 10 Dec 2025 09:32:23 +0100 you wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> A recent bugfix introduced a new problem with Kconfig dependencies:
> 
> WARNING: unmet direct dependencies detected for CAN_DEV
>   Depends on [n]: NETDEVICES [=n] && CAN [=m]
>   Selected by [m]:
>   - CAN [=m] && NET [=y]
> 
> [...]

Here is the summary with links:
  - [net,1/2] can: fix build dependency
    https://git.kernel.org/netdev/net/c/6abd4577bccc
  - [net,2/2] can: gs_usb: gs_can_open(): fix error handling
    https://git.kernel.org/netdev/net/c/3e54d3b4a843

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



