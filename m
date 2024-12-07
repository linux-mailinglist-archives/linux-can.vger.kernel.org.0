Return-Path: <linux-can+bounces-2344-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CF2FB9E7DC9
	for <lists+linux-can@lfdr.de>; Sat,  7 Dec 2024 02:40:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1E2E416D288
	for <lists+linux-can@lfdr.de>; Sat,  7 Dec 2024 01:40:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9506317597;
	Sat,  7 Dec 2024 01:40:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kYChboog"
X-Original-To: linux-can@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 693B1286A9;
	Sat,  7 Dec 2024 01:40:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733535621; cv=none; b=BnPM2ZPG25yzOTeBXgGKVj7+qnMcSSAPcNXB6PdOD4j/OZ7X27XQFAXf293pDfMMmTO+EJbTnzTnbIFMDlgK+MWwH0SMiBCCR+vYT4dvZfmDW8QZRW+Es6bKxM9tWF9obyxRHXF8xuPsyX1P0CbqrgRBVMZBY0DMy4JuwRNsWU0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733535621; c=relaxed/simple;
	bh=tGYgfxWGm/mx2fdk03Ebej7kD+L949m4rooa93oQzLA=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=kQBnwjrimYngzC3+uLJvSLfNsumCDV4bnF6RFLu2jCo9aba+AYFD3eQRLTO2IemieW5D9BDY65u2EwoP28GjJrjdmeLEXVwOWXddS78ZUfrxdrqtPmp1NsR+mKZQGtN1rBC9xxYqC0H1pR2Jgb46PlslreSgpr+8vXHE00+5Y0E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kYChboog; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0783BC4CED1;
	Sat,  7 Dec 2024 01:40:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733535621;
	bh=tGYgfxWGm/mx2fdk03Ebej7kD+L949m4rooa93oQzLA=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=kYChboogydUaLCqkdMzNKANjnFnpC/U87ScB3lwkj4xGGaaHdkpsLPX5ADSB6jX4L
	 QpeTsiy/jIUwA6rmLh47roWxjVpF2mcrTLoa2IxiyknLssq9n50VpKiv69VRrcFmCr
	 tXkgOrxcYSto4ptFtnSpGl5CgndeoR94dAT/j1mVyBFIcCWS6Sbsp6lc4Qf7GsL09L
	 yJiMW0YFQDaspGLyhXLxUMttSX9ugk1ZV621bFsWCrmEestRxyD4yotwADFGu8clea
	 +js4hU3I+xRJJFm7HMMxCjN1HU4NcFcSRtW+eoqnS+TS7877wNlL9CeeshMdGTNgg/
	 snljILPwDzJuA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 366A4380A95C;
	Sat,  7 Dec 2024 01:40:37 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] net: simplify resource acquisition + ioremap
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173353563577.2868165.15707534550533445842.git-patchwork-notify@kernel.org>
Date: Sat, 07 Dec 2024 01:40:35 +0000
References: <20241203231337.182391-1-rosenp@gmail.com>
In-Reply-To: <20241203231337.182391-1-rosenp@gmail.com>
To: Rosen Penev <rosenp@gmail.com>
Cc: netdev@vger.kernel.org, mkl@pengutronix.de, maxime.chevallier@bootlin.com,
 mailhol.vincent@wanadoo.fr, madalin.bucur@nxp.com, sean.anderson@seco.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, hkallweit1@gmail.com,
 linux@armlinux.org.uk, linux-can@vger.kernel.org,
 linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue,  3 Dec 2024 15:13:37 -0800 you wrote:
> get resource + request_mem_region + ioremap can all be done by a single
> function.
> 
> Replace them with devm_platform_get_and_ioremap_resource or\
> devm_platform_ioremap_resource where res is not used.
> 
> Signed-off-by: Rosen Penev <rosenp@gmail.com>
> 
> [...]

Here is the summary with links:
  - net: simplify resource acquisition + ioremap
    https://git.kernel.org/netdev/net-next/c/e36d46b9af68

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



