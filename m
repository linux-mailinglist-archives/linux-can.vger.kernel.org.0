Return-Path: <linux-can+bounces-4034-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B5879B0E84C
	for <lists+linux-can@lfdr.de>; Wed, 23 Jul 2025 03:49:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A00441C2129B
	for <lists+linux-can@lfdr.de>; Wed, 23 Jul 2025 01:50:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C5D237160;
	Wed, 23 Jul 2025 01:49:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dsZ7F1Yf"
X-Original-To: linux-can@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9A12360;
	Wed, 23 Jul 2025 01:49:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753235388; cv=none; b=A/D3pV4MCwaWykzTgxQZrLUapHggor5fmbyI84N4dE+f/NE+Z4J/qxpcdUsIefz6EX5ePA+CX1eUnrIYrTnufI/M0tcCRKSmQSz74sPt+OfWrj7s/YUdoyezhjhFoyEWsrvy/M0m9M6JYVAHoeU0Y0TV0fFJqZIGHb7EUafJUp8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753235388; c=relaxed/simple;
	bh=S46aXaZJUwkqewFsT8fYXJDPXML7kNl5HkXjA6XHDy8=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=ujr9LCWkZ/W86gRufvVpw+Bx7jiDMVLtMAFylUUjZ0ueR/vKh8PnXuA1+RsYsF8VRzcC/9NokF97CmKasF1EflGCiYhLchzI6+/bnpzW0AJEi6WNwWqQu1wW274McWi68Yl+5wALLVJZ46mlyQY4Cigem9L3BJKxZX5/jx990tk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dsZ7F1Yf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 618E4C4CEEB;
	Wed, 23 Jul 2025 01:49:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753235388;
	bh=S46aXaZJUwkqewFsT8fYXJDPXML7kNl5HkXjA6XHDy8=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=dsZ7F1Yf/Lm7uoJWyXtpTzM50Dd/yHwn9VM/OXWb3NLDkElroRYZi/QgDKVpbPmtK
	 uQLV8ofPt/wO2hD0gAep3/EKHENTppQLM4R+hLh1w/0G8/blaA5kGbVV1FOIhUhcxm
	 +b7aIAcGXOftxffcsmDYFK7ykSepqcMoreUGxwXzkHo69Ad1u7ePAQJ+VfQklj/J4z
	 k5yZwLYy1z43RUNgQDZnNuBcHoYZP8u2IKWIz5sXjAZn8M0BvnIhn3PkPC57Jscf/l
	 RByW9stS4NsbWiYeAXVcsZip9jfLg3IrbTY5vqI5NQnp0hi9KwlesvVKk3k0yxG4r/
	 CAn4CYZBh+CKg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EAD93383BF5D;
	Wed, 23 Jul 2025 01:50:07 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] can: netlink: can_changelink(): fix NULL pointer
 deref of
 struct can_priv::do_set_mode
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175323540664.1021632.5111013951274010808.git-patchwork-notify@kernel.org>
Date: Wed, 23 Jul 2025 01:50:06 +0000
References: <20250722110059.3664104-2-mkl@pengutronix.de>
In-Reply-To: <20250722110059.3664104-2-mkl@pengutronix.de>
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
 linux-can@vger.kernel.org, kernel@pengutronix.de, andrey.lalaev@gmail.com

Hello:

This patch was applied to netdev/net.git (main)
by Marc Kleine-Budde <mkl@pengutronix.de>:

On Tue, 22 Jul 2025 12:58:32 +0200 you wrote:
> Andrei Lalaev reported a NULL pointer deref when a CAN device is
> restarted from Bus Off and the driver does not implement the struct
> can_priv::do_set_mode callback.
> 
> There are 2 code path that call struct can_priv::do_set_mode:
> - directly by a manual restart from the user space, via
>   can_changelink()
> - delayed automatic restart after bus off (deactivated by default)
> 
> [...]

Here is the summary with links:
  - [net] can: netlink: can_changelink(): fix NULL pointer deref of struct can_priv::do_set_mode
    https://git.kernel.org/netdev/net/c/c1f3f9797c1f

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



