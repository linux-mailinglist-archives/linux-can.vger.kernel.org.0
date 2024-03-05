Return-Path: <linux-can+bounces-359-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 46A678721BE
	for <lists+linux-can@lfdr.de>; Tue,  5 Mar 2024 15:40:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D9B321F23DA2
	for <lists+linux-can@lfdr.de>; Tue,  5 Mar 2024 14:40:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BCC2126F2B;
	Tue,  5 Mar 2024 14:40:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bZqIYLol"
X-Original-To: linux-can@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D882A126F21;
	Tue,  5 Mar 2024 14:40:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709649630; cv=none; b=uwFt9HS7CMKX8lUxGRdUxNnXrbhUWD6Sc39mFH6sX63fNkIeGhDByxtMb4dHYzbYhQiDC6qOcm7v/TBBMY5h5r3CadEIjmIYuvo4GzJfDqz8kXnTRWWROo/d7bVMlq0vwFUL2c1CEsj9Bi2BjmwS5BCG3yuFdnTHlH6tjOdVmIY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709649630; c=relaxed/simple;
	bh=wtfISWxuBL6gpZVIdQu65vHX1VbCAxch2sdGL2fIgRU=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=IFeQ94GyBI8JC2eO2tOd+qIfS4nwU0Jo3A17GvDdiIhYS9Z9eU4XcwwDbLKN1RdEGoJJKTVBXeWUnk0lpccRE6PPD8I4RdzcJpAicpH2RuErmWqwZ/xYC+GNrnj1r9ghI9W4OYo9JXebGIeVHo2acEZsOGcMmQidj0N1JIrUOYM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bZqIYLol; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 67474C433B2;
	Tue,  5 Mar 2024 14:40:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709649630;
	bh=wtfISWxuBL6gpZVIdQu65vHX1VbCAxch2sdGL2fIgRU=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=bZqIYLolH+S8k6WpYKowvufjV9ZYwQHp6XKDjO6yKoxKE+Uy1cRFo6JOs6nQd4s0d
	 GGSHCGW4Vjsu0ZNP5sZREno8BhmS12gYNVQ+3vJ9ozQqYelIXIVrLQOGwdqi8kVEM+
	 KHT0oOpMseHtMjRPEFpeLtLCiZNWw43Zo1ecYCJwATJIsvCCaw+uFQcz6qz758Vm3m
	 JA7UhK9YkL3oseWnO2qMQX2rNH0ozJR+iGGSq/XH2XB9UCUcL6ERg3Zci7eSP3KBNs
	 Bo/UgQNDBcCB8rMc1FWGqKgj+V5o+/I1vIViPEDFP+OrB4Z8fGqEqukhAZeKK2Qai5
	 oIzZBb4nOhZKg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 502EED84BDE;
	Tue,  5 Mar 2024 14:40:30 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next 1/4] can: kvaser_usb: Add support for Leaf v3
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170964963032.12526.7900714399345532932.git-patchwork-notify@kernel.org>
Date: Tue, 05 Mar 2024 14:40:30 +0000
References: <20240304092051.3631481-2-mkl@pengutronix.de>
In-Reply-To: <20240304092051.3631481-2-mkl@pengutronix.de>
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
 linux-can@vger.kernel.org, kernel@pengutronix.de, extja@kvaser.com

Hello:

This series was applied to netdev/net-next.git (main)
by Marc Kleine-Budde <mkl@pengutronix.de>:

On Mon,  4 Mar 2024 10:13:55 +0100 you wrote:
> From: Jimmy Assarsson <extja@kvaser.com>
> 
> Add support for Kvaser Leaf v3, based on the hydra platform.
> 
> Signed-off-by: Jimmy Assarsson <extja@kvaser.com>
> Link: https://lore.kernel.org/all/20240223095217.43783-1-extja@kvaser.com
> Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
> 
> [...]

Here is the summary with links:
  - [net-next,1/4] can: kvaser_usb: Add support for Leaf v3
    https://git.kernel.org/netdev/net-next/c/0b40cd9b4ecc
  - [net-next,2/4] can: kvaser_pciefd: Add support for Kvaser PCIe 8xCAN
    https://git.kernel.org/netdev/net-next/c/9b221ba452aa
  - [net-next,3/4] can: gs_usb: gs_cmd_reset(): use cpu_to_le32() to assign mode
    https://git.kernel.org/netdev/net-next/c/ef488e47e060
  - [net-next,4/4] can: mcp251xfd: __mcp251xfd_get_berr_counter(): use CAN_BUS_OFF_THRESHOLD instead of open coding it
    https://git.kernel.org/netdev/net-next/c/79f7319908fb

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



