Return-Path: <linux-can+bounces-3850-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DB5CADDF4B
	for <lists+linux-can@lfdr.de>; Wed, 18 Jun 2025 01:00:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C9890189D033
	for <lists+linux-can@lfdr.de>; Tue, 17 Jun 2025 23:00:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DDBF29DB68;
	Tue, 17 Jun 2025 23:00:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="U7C/zaDL"
X-Original-To: linux-can@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4D4F298CA6;
	Tue, 17 Jun 2025 23:00:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750201206; cv=none; b=kLF9QrVBTNl1cOWP9zP9wMunh4bxzxRV6F34egGvnR6hxne5rJrKTw65hrtuQbR0JpbX+bPORf7JEhTStjvBOLN+d3ouYt7fG+d9vHgp8X3CPwgLH9Vh55ry54pLO09ZfYmIOy5bzFo15sXOo34q9zu7xuZPY9J54rXjwHAEpUs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750201206; c=relaxed/simple;
	bh=lCpYwprXV7CwJRsBN3bGZ+l2iUgPR67nqne4oPrW2yE=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=lPAK9q8QM63u4LSrmOcX6wPf2ySYawozR+JQO3RPIykFplaGk9+61334x/xHjRmpVgHMJ1cg4YQRqxPQSPmDJ8QN855n6LQAMnrqjbYt8a9ZkffXT9+MkFOpieCy24RG+vFobMiEPgDnZcI/fW3TqI40at9PKsfFrR3e1defEhs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=U7C/zaDL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C4D3C4CEF3;
	Tue, 17 Jun 2025 23:00:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750201205;
	bh=lCpYwprXV7CwJRsBN3bGZ+l2iUgPR67nqne4oPrW2yE=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=U7C/zaDLDIf6t9o3aiBPLmzyjOEUDajRPIWGx1jXnwjLKXH4aQo4cIPH26Lv+mBy4
	 6PZ9ijFEYFoGdEhUSXKalqIRKZMx448Qw12hOAvEILK6LX0jxfa43hTiiCLlCq9A/p
	 TupCnAjoKVqG24MnRdDFd1tJtBd/75oKo9/S+87oEjzMaK6+U42fluGaABu2kbaSPu
	 iKCBIuMoRq2bPDIalcNjxKnQC9dVZ3oc8wEaKg2Ug13i+X6z5HOKjYTpssZj7wOnJW
	 SPiJVIpnwxdr1RUh7symac+uYpceFqKlyqzBdqSec941my18g/corfH1eVo8MFfxRy
	 EA6hpHfOfifTg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 3425938111DD;
	Tue, 17 Jun 2025 23:00:35 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] can: tcan4x5x: fix power regulator retrieval during
 probe
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175020123399.3727356.275761194504576050.git-patchwork-notify@kernel.org>
Date: Tue, 17 Jun 2025 23:00:33 +0000
References: <20250617155123.2141584-2-mkl@pengutronix.de>
In-Reply-To: <20250617155123.2141584-2-mkl@pengutronix.de>
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
 linux-can@vger.kernel.org, kernel@pengutronix.de, brett.werling@garmin.com,
 stable@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Marc Kleine-Budde <mkl@pengutronix.de>:

On Tue, 17 Jun 2025 17:50:02 +0200 you wrote:
> From: Brett Werling <brett.werling@garmin.com>
> 
> Fixes the power regulator retrieval in tcan4x5x_can_probe() by ensuring
> the regulator pointer is not set to NULL in the successful return from
> devm_regulator_get_optional().
> 
> Fixes: 3814ca3a10be ("can: tcan4x5x: tcan4x5x_can_probe(): turn on the power before parsing the config")
> Signed-off-by: Brett Werling <brett.werling@garmin.com>
> Link: https://patch.msgid.link/20250612191825.3646364-1-brett.werling@garmin.com
> Cc: stable@vger.kernel.org
> Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
> 
> [...]

Here is the summary with links:
  - [net] can: tcan4x5x: fix power regulator retrieval during probe
    https://git.kernel.org/netdev/net/c/db2272054520

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



