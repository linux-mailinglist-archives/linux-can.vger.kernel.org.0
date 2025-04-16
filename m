Return-Path: <linux-can+bounces-3407-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A121DA8AE77
	for <lists+linux-can@lfdr.de>; Wed, 16 Apr 2025 05:40:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B5FF07A61CA
	for <lists+linux-can@lfdr.de>; Wed, 16 Apr 2025 03:39:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89F301F30B3;
	Wed, 16 Apr 2025 03:40:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FnCDLEsj"
X-Original-To: linux-can@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D5E417B425;
	Wed, 16 Apr 2025 03:40:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744774840; cv=none; b=SnOKGhxXsZYY6H3+Qlreaqq0qc61pIT6HDeMruRyKTbm3DErwKgMRxl5a0fSL3go+c2qLCorN6IJ/L7IU+N+7hsOx/oTYGn6REXcWzOJSjaLy7vS5BiTPUBQSjoIoY6xFD4aUEPhZeEzfAJ825hva+UxTkltBse+mMCuiu1NeyE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744774840; c=relaxed/simple;
	bh=npb5Oiag6lEX6gLWdkhlApJNRtH09xluxo0HEh0O114=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=PUIodxgml0unyBQI/I4KTiuqu0I6zLXA4tKgu1lqijUGTqZtptPKZoBfJCyTX6Z83kbOXyUTy9vmrfe3cTQ94qUf6e9OZ4LeeDuS24HdOC1VKluIUeVKAZB/HkTDKAlQfapHtcVtLwxMzcM+j91uBC9rsyO6xODqSAfjdi0nwCA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FnCDLEsj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA8D4C4CEE2;
	Wed, 16 Apr 2025 03:40:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744774839;
	bh=npb5Oiag6lEX6gLWdkhlApJNRtH09xluxo0HEh0O114=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=FnCDLEsjIrTxT53P+lbN7cuPO/bUsPZ/MKTMC8UHENNiFALfNuWHoqV4kqhmJMImP
	 rZBs/aTl7tF8adMombAfXLhlTEmIvnuqdO40ThErY5x1Fic7shaCqvfPNMd+5l8GBZ
	 yIG5Mdomw22m1k4MvHIt38jbbJK7mZ5poAWzlbZw988PlL24Vjq8MN4UDaMiy2uWw6
	 uR+5CmvLzKTbQ2b2M7ViWOOPQRhQzSFlCABbQdxLrceoWqBxfHBiX27j5UnmldeCXp
	 c6EbQXLcNBzjeTsImG6ZPGDiM+4E/wXVD2Qu3suBrxhRiLI89Qy44uNSHnLmOt89ve
	 vg02sF1/0ZEeg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EAD523822D55;
	Wed, 16 Apr 2025 03:41:18 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net 1/2] can: fix missing decrement of j1939_proto.inuse_idx
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174477487742.2864810.17953109861867397814.git-patchwork-notify@kernel.org>
Date: Wed, 16 Apr 2025 03:41:17 +0000
References: <20250415103401.445981-2-mkl@pengutronix.de>
In-Reply-To: <20250415103401.445981-2-mkl@pengutronix.de>
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
 linux-can@vger.kernel.org, kernel@pengutronix.de, dcaratti@redhat.com,
 socketcan@hartkopp.net, o.rempel@pengutronix.de

Hello:

This series was applied to netdev/net.git (main)
by Marc Kleine-Budde <mkl@pengutronix.de>:

On Tue, 15 Apr 2025 12:31:44 +0200 you wrote:
> From: Davide Caratti <dcaratti@redhat.com>
> 
> Like other protocols on top of AF_CAN family, also j1939_proto.inuse_idx
> needs to be decremented on socket dismantle.
> 
> Fixes: 6bffe88452db ("can: add protocol counter for AF_CAN sockets")
> Reported-by: Oliver Hartkopp <socketcan@hartkopp.net>
> Closes: https://lore.kernel.org/linux-can/7e35b13f-bbc4-491e-9081-fb939e1b8df0@hartkopp.net/
> Signed-off-by: Davide Caratti <dcaratti@redhat.com>
> Acked-by: Oleksij Rempel <o.rempel@pengutronix.de>
> Link: https://patch.msgid.link/09ce71f281b9e27d1e3d1104430bf3fceb8c7321.1742292636.git.dcaratti@redhat.com
> Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
> 
> [...]

Here is the summary with links:
  - [net,1/2] can: fix missing decrement of j1939_proto.inuse_idx
    https://git.kernel.org/netdev/net/c/8b1879491472
  - [net,2/2] can: rockchip_canfd: fix broken quirks checks
    https://git.kernel.org/netdev/net/c/6315d93541f8

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



