Return-Path: <linux-can+bounces-3968-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DF07B01F21
	for <lists+linux-can@lfdr.de>; Fri, 11 Jul 2025 16:29:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1DE423BBF89
	for <lists+linux-can@lfdr.de>; Fri, 11 Jul 2025 14:29:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61D372E6D1A;
	Fri, 11 Jul 2025 14:29:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iknN2LpQ"
X-Original-To: linux-can@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3955A3C0C;
	Fri, 11 Jul 2025 14:29:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752244185; cv=none; b=MBtTe2j/X7kJno1vZCCxvjUB+bp2Sxy9S2v/q626YBvyTUEri7d+sPsQjbSNl5PYgJTZfZA6iSbQAWkJcpmGOuX3z6nNHrvCVEBbhNVW703qGuIP2g+oaSUuWBYs1JMD5JD35fEUsTVrjOmayNy+SBrviE15qOPU9oV4pQ71DaE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752244185; c=relaxed/simple;
	bh=lC808y0m3dQ+DJ0zaWPL0odZGKbrweD5iumrSQ9IGeg=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Xj/drm/g2NfSsvMw6OKkJX6ljgq9PxviIg5M7Z5LqvdRxNQ7+ZxnGBJJqZov/vRUD9HYsdIEuxUT6MK4d7JmlYAKAFqPkF9Iho7qrei6yk+db0VA9cw3JDJuUcz4bE6hmFpfZarl/sVxujv9v/5LNsr4oNe+5UDIj0On63JmnUg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iknN2LpQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A8273C4CEED;
	Fri, 11 Jul 2025 14:29:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752244184;
	bh=lC808y0m3dQ+DJ0zaWPL0odZGKbrweD5iumrSQ9IGeg=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=iknN2LpQnAgIi08fOQMM44K8dFY0ek0irFWXA4CaZ+vQIESkpSVmJ9CDDg0eQG1em
	 cjlj5z5NESFQgKTS6DYzF93NMI/a/AvabTEeVUEWu0eoXEWOPhaS+NCCht+0Xb/QNC
	 jCk8qatQLw1oQlXUqjZWu4tVvqVmRcIUVILrb3ia1Ny+tIwaWRY5NOmX5PYBX/QP0v
	 vSo1EkhPxWk7/Be+8v8jHsIEyVI8xoSUVFx1fje/V+apKluPMLxHsduFC1i2FOGT6L
	 VYCDLTkXubsuJ5tqHKlSwBZfOzQo8ykly5T/72EU0IJFjay3ku4l180etbJu8vYvWQ
	 T9j4ZFjFNyHeg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id D6025383B275;
	Fri, 11 Jul 2025 14:30:07 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] can: m_can: m_can_handle_lost_msg(): downgrade msg
 lost
 in rx message to debug level
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175224420667.2290845.4946312028220390967.git-patchwork-notify@kernel.org>
Date: Fri, 11 Jul 2025 14:30:06 +0000
References: <20250711102451.2828802-2-mkl@pengutronix.de>
In-Reply-To: <20250711102451.2828802-2-mkl@pengutronix.de>
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
 linux-can@vger.kernel.org, kernel@pengutronix.de, sean@geanix.com,
 mailhol.vincent@wanadoo.fr

Hello:

This patch was applied to netdev/net.git (main)
by Marc Kleine-Budde <mkl@pengutronix.de>:

On Fri, 11 Jul 2025 12:22:28 +0200 you wrote:
> From: Sean Nyekjaer <sean@geanix.com>
> 
> Downgrade the "msg lost in rx" message to debug level, to prevent
> flooding the kernel log with error messages.
> 
> Fixes: e0d1f4816f2a ("can: m_can: add Bosch M_CAN controller support")
> Reviewed-by: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
> Signed-off-by: Sean Nyekjaer <sean@geanix.com>
> Link: https://patch.msgid.link/20250711-mcan_ratelimit-v3-1-7413e8e21b84@geanix.com
> [mkl: enhance commit message]
> Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
> 
> [...]

Here is the summary with links:
  - [net] can: m_can: m_can_handle_lost_msg(): downgrade msg lost in rx message to debug level
    https://git.kernel.org/netdev/net/c/58805e9cbc6f

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



