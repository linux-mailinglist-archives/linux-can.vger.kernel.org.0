Return-Path: <linux-can+bounces-2788-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 07300A30224
	for <lists+linux-can@lfdr.de>; Tue, 11 Feb 2025 04:30:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6C0E31882F8C
	for <lists+linux-can@lfdr.de>; Tue, 11 Feb 2025 03:30:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D11FC1D5AA0;
	Tue, 11 Feb 2025 03:30:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aSVGuwGv"
X-Original-To: linux-can@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A85441D5CCD;
	Tue, 11 Feb 2025 03:30:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739244604; cv=none; b=oKsnHaYlRLz7OHLQE6Cys/kONLlF9iiPw54T/YWYZQZTQRY+oFfC6QNr5Of1V9MdkUh7kaxZvIdF0RdN7IFjEw8ZzdvXUUKHjzPK9rH9wb4N/r02LOERCWPjnphk5tQlfAiNxRyxpbTw9CQaF+sWahSC4sHeRo5wLgBQ3dPfzhE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739244604; c=relaxed/simple;
	bh=mBv5aXOGOSy28qBAESOh3mSl0P8bzvNPXse3HG5iaAo=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=AC8vmGVgu6RnRWX+aJrle5b+iZvFtPrnX47DrA6tUfRNEysjY/0IHQ7RsaiRM6UxzhiorTzFn4lomlO1H0VZ7mPTVBCA7oeD17F8BjQuTpHkhzofKzM0TN/8RvHR/tEDr7JvlVSFkO0LYUr9hTkHZymRdk8LT6ql0/ILBTU0124=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aSVGuwGv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 15C29C4CED1;
	Tue, 11 Feb 2025 03:30:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739244604;
	bh=mBv5aXOGOSy28qBAESOh3mSl0P8bzvNPXse3HG5iaAo=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=aSVGuwGvy6wr/I8w9T0QV57OZ5h6HWva29Mj1TaQjB6ztksAKcC2GdJDjk0f6S1G/
	 MQbRxMvolwjnlFCd9ZU+cQhapxf57F7gig2QBjGXmDYNRQDDLkjhkU/fZ0qa3ZuZuE
	 Iux8Mlz5yijL/bZeVY8Vb3s2Aclm8VxtBBiqXVz4RQ/4gxvLu6VDpsqAGIxHoL+KuL
	 dMg8NoKthsl9ZvFGzf+P3KI2tdKnSXFAJHEeETCcmzHyYf4j99l5v3PPqZxjbMUbpo
	 6q0ffXDJV5avxVvJbLYTMShAUAL4s5WLFSyPjziOczB6KUeqEwy5tTUdrKHgUvgnN8
	 fzIosp0nIP/LQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EB05E380AA7A;
	Tue, 11 Feb 2025 03:30:33 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net 1/6] Documentation/networking: fix basic node example
 document ISO 15765-2
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173924463278.3948401.2091237100978886483.git-patchwork-notify@kernel.org>
Date: Tue, 11 Feb 2025 03:30:32 +0000
References: <20250208115120.237274-2-mkl@pengutronix.de>
In-Reply-To: <20250208115120.237274-2-mkl@pengutronix.de>
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
 linux-can@vger.kernel.org, kernel@pengutronix.de, reyders1@gmail.com,
 horms@kernel.org, socketcan@hartkopp.net

Hello:

This series was applied to netdev/net.git (main)
by Marc Kleine-Budde <mkl@pengutronix.de>:

On Sat,  8 Feb 2025 12:45:14 +0100 you wrote:
> From: Reyders Morales <reyders1@gmail.com>
> 
> In the current struct sockaddr_can tp is member of can_addr. tp is not
> member of struct sockaddr_can.
> 
> Signed-off-by: Reyders Morales <reyders1@gmail.com>
> Reviewed-by: Simon Horman <horms@kernel.org>
> Acked-by: Oliver Hartkopp <socketcan@hartkopp.net>
> Link: https://patch.msgid.link/20250203224720.42530-1-reyders1@gmail.com
> Fixes: 67711e04254c ("Documentation: networking: document ISO 15765-2")
> Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
> 
> [...]

Here is the summary with links:
  - [net,1/6] Documentation/networking: fix basic node example document ISO 15765-2
    https://git.kernel.org/netdev/net/c/d0b197b6505f
  - [net,2/6] can: j1939: j1939_sk_send_loop(): fix unable to send messages with data length zero
    https://git.kernel.org/netdev/net/c/44de577e61ed
  - [net,3/6] can: ctucanfd: handle skb allocation failure
    https://git.kernel.org/netdev/net/c/9bd24927e3ee
  - [net,4/6] can: c_can: fix unbalanced runtime PM disable in error path
    https://git.kernel.org/netdev/net/c/257a2cd3eb57
  - [net,5/6] can: etas_es58x: fix potential NULL pointer dereference on udev->serial
    https://git.kernel.org/netdev/net/c/a1ad2109ce41
  - [net,6/6] can: rockchip: rkcanfd_handle_rx_fifo_overflow_int(): bail out if skb cannot be allocated
    https://git.kernel.org/netdev/net/c/f7f0adfe64de

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



