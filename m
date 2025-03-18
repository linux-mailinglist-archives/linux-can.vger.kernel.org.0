Return-Path: <linux-can+bounces-3154-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E770EA6734D
	for <lists+linux-can@lfdr.de>; Tue, 18 Mar 2025 13:00:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9D70817455A
	for <lists+linux-can@lfdr.de>; Tue, 18 Mar 2025 12:00:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1D2420C03C;
	Tue, 18 Mar 2025 12:00:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jYeRaEet"
X-Original-To: linux-can@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77EC620C034;
	Tue, 18 Mar 2025 12:00:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742299203; cv=none; b=Ractq/UkJ2A7Y6tnvfdaDmK7H26355c1fyBDpgU+AlLIKpat0PB1OBBPNFHHD2UpfhtZw9ZMluAdqAUAs+SrWpfxOq4199LONk5herovA9tONDAYUayjPYeiUgT1yI3aAv/qCo914QkqMQn5TZDNaCg6n/LrMrLhdf1LkTkTQHE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742299203; c=relaxed/simple;
	bh=i5jK+QtJR8Or72WuYAow4hH33tYp7s94FbtddEMhsfI=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=uVP17cfUgXLRc+DAAZQegeTrbYWrZdKTX1mjrQTgZRfGOUF+cA90w7EY8B7OtPla/B9S66fj+aGqBiE47LhohLwEKykmadu5qtFIveLga3yZTpQmdzdTzR65XUk7VpbrThAV/WPbkQpJD7z/6FgHZlsHjZj3P0J9Q3pVbmAAJbI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jYeRaEet; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F872C4CEDD;
	Tue, 18 Mar 2025 12:00:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742299203;
	bh=i5jK+QtJR8Or72WuYAow4hH33tYp7s94FbtddEMhsfI=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=jYeRaEet3jxWpwTNG+6LxOscF0IdRaRSIv19ZSppfkU2UZUPgLXJarKQBYIJj4QyR
	 ZEnfap7wPG4DyG1B56tch3Eu64jU2PTuwJbspS6hK0Bm3m284xQBeRfyoTGLlYrQzl
	 5huiu9awj2ni923yuLce3dHfiFNxvujfFqiR6TnI1CxLm+H6Q+V2jUywypFCbuDF+B
	 ZMJtzCoH3lmHDcD7kj/Mx9D8SrrHdo605NsDNceaXnqtpoqpsfxaDj0h/yh2kEalCa
	 S6YDK9xEij9o8bUcGFA7FNGzw6NZSEXf7O88MyIIWv7piRENIrEBKOGNgok5iu2X3G
	 A4vfpRw/FvOgw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EB348380DBE8;
	Tue, 18 Mar 2025 12:00:39 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next 1/4] dt-bindings: can: fsl,flexcan: add transceiver
 capabilities
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174229923874.283014.6679997707424853179.git-patchwork-notify@kernel.org>
Date: Tue, 18 Mar 2025 12:00:38 +0000
References: <20250314132327.2905693-2-mkl@pengutronix.de>
In-Reply-To: <20250314132327.2905693-2-mkl@pengutronix.de>
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
 linux-can@vger.kernel.org, kernel@pengutronix.de,
 dimitri.fedrau@liebherr.com, conor.dooley@microchip.com

Hello:

This series was applied to netdev/net-next.git (main)
by Marc Kleine-Budde <mkl@pengutronix.de>:

On Fri, 14 Mar 2025 14:19:15 +0100 you wrote:
> From: Dimitri Fedrau <dimitri.fedrau@liebherr.com>
> 
> Currently the flexcan driver does only support adding PHYs by using the
> "old" regulator bindings. Add support for CAN transceivers as a PHY.
> 
> Acked-by: Conor Dooley <conor.dooley@microchip.com>
> Signed-off-by: Dimitri Fedrau <dimitri.fedrau@liebherr.com>
> Link: https://patch.msgid.link/20250312-flexcan-add-transceiver-caps-v4-1-29e89ae0225a@liebherr.com
> Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
> 
> [...]

Here is the summary with links:
  - [net-next,1/4] dt-bindings: can: fsl,flexcan: add transceiver capabilities
    https://git.kernel.org/netdev/net-next/c/6263bad801ec
  - [net-next,2/4] can: flexcan: add transceiver capabilities
    https://git.kernel.org/netdev/net-next/c/d80bfde3c57a
  - [net-next,3/4] dt-bindings: can: fsl,flexcan: add i.MX94 support
    https://git.kernel.org/netdev/net-next/c/958ee3d71577
  - [net-next,4/4] can: add protocol counter for AF_CAN sockets
    https://git.kernel.org/netdev/net-next/c/6bffe88452db

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



