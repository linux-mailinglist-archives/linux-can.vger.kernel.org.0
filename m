Return-Path: <linux-can+bounces-3602-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CF7CFABDC9D
	for <lists+linux-can@lfdr.de>; Tue, 20 May 2025 16:26:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7D6044E328E
	for <lists+linux-can@lfdr.de>; Tue, 20 May 2025 14:12:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8E4624A04A;
	Tue, 20 May 2025 14:09:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cJgb1qTk"
X-Original-To: linux-can@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81BDD24886F;
	Tue, 20 May 2025 14:09:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747750199; cv=none; b=CjH1XNxkgEuSJjt5ql/V78S7SCSNsr8TwPID0hA+ea/YKrWjjvEeujUhDF8l+zSN+Y0LGJdwbnciRMhcTHlKQynF2P0d1zhyAbUsBpWRFB8pk9hQP6nV5zIKqe/qKAjAS+8q/dl/puOSKSoN7PmGE9BroPRLS9biWJKc6BegPeo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747750199; c=relaxed/simple;
	bh=U7HmJIgAwANTXh8GX3ab1BkDtvTDewIc1iAxfBriVIM=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=KWTsaKKDlRpORzWBKaEug0K9Wcelh62l77vWKrnjh1iMNfTfJnosdOUf6FQDuPSNTilUU3cHuv8Iz2gpfqe5D+qwIGVQT3DhJMU2fgmCG9AYG2G7yyFDRWK/C4naX1vpp3rBPolIoZNa+ZKmKM9Quex1p8i/pqjnjo1Oik5sbJ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cJgb1qTk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 48F6FC4CEEA;
	Tue, 20 May 2025 14:09:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747750199;
	bh=U7HmJIgAwANTXh8GX3ab1BkDtvTDewIc1iAxfBriVIM=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=cJgb1qTkj97hnAsju6x8I1ghB/DcAVB9qQRQV27LQEOfC9Vvc+FCl07xlO+5xsu//
	 Z/J5lf0q04TdKiWwC4HWdlO4UM5+/QTwXmRjv/IjWYkk88q8GJwVY6bYra3obrvTw1
	 R6c8Aa5wyBlTys3AdwPqvfu0bi196O3zo9YWLXqSTC7O63DGlxlELAoicaa6Ggtr74
	 nTlK9AK6SR0QLoBaiFuHPOc9jH6cpNUaXoj7YozStS+/du242yeIRRoz/qY51KuRcq
	 mqIArXtq9nDUTYRb32aL/70Y3mJDIHxSK5Ji5tr7iP/cJ3ApRk2JjqbHUfKko0DDE0
	 nNJhIunn3aDxg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 7169F380AA70;
	Tue, 20 May 2025 14:10:36 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net 1/3] dt-bindings: can: microchip,mcp2510: Fix $id path
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174775023525.1333412.13241067062760119382.git-patchwork-notify@kernel.org>
Date: Tue, 20 May 2025 14:10:35 +0000
References: <20250520091424.142121-2-mkl@pengutronix.de>
In-Reply-To: <20250520091424.142121-2-mkl@pengutronix.de>
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
 linux-can@vger.kernel.org, kernel@pengutronix.de, robh@kernel.org,
 conor.dooley@microchip.com

Hello:

This series was applied to netdev/net.git (main)
by Marc Kleine-Budde <mkl@pengutronix.de>:

On Tue, 20 May 2025 11:11:01 +0200 you wrote:
> From: "Rob Herring (Arm)" <robh@kernel.org>
> 
> The "$id" value must match the relative path under bindings/ and is
> missing the "net" sub-directory.
> 
> Fixes: 09328600c2f9 ("dt-bindings: can: convert microchip,mcp251x.txt to yaml")
> Signed-off-by: "Rob Herring (Arm)" <robh@kernel.org>
> Acked-by: Conor Dooley <conor.dooley@microchip.com>
> Link: https://patch.msgid.link/20250507154201.1589542-1-robh@kernel.org
> Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
> 
> [...]

Here is the summary with links:
  - [net,1/3] dt-bindings: can: microchip,mcp2510: Fix $id path
    https://git.kernel.org/netdev/net/c/69c6d83d7173
  - [net,2/3] can: bcm: add locking for bcm_op runtime updates
    https://git.kernel.org/netdev/net/c/c2aba69d0c36
  - [net,3/3] can: bcm: add missing rcu read protection for procfs content
    https://git.kernel.org/netdev/net/c/dac5e6249159

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



