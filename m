Return-Path: <linux-can+bounces-278-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 17E95856225
	for <lists+linux-can@lfdr.de>; Thu, 15 Feb 2024 12:50:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AE71E1F21EFD
	for <lists+linux-can@lfdr.de>; Thu, 15 Feb 2024 11:50:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D89512B164;
	Thu, 15 Feb 2024 11:50:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tksbYUhY"
X-Original-To: linux-can@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FD526350A;
	Thu, 15 Feb 2024 11:50:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707997827; cv=none; b=ZpelHQigrHyelo2vkCpuAX5OGYB3utVxYa/9LN8zTIgd+b9O4Wkz7XYsezpWME1gPhPx+Y/DXbBUuUOdA0CqlKXgYj7Nl9DEPIHZaRJzAq4pgjw0Mcu4axC/tkEszK+KO0yc5SrmPo1QUYzQerMUhxm8pUuTvvhnOD49xHU6rhc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707997827; c=relaxed/simple;
	bh=CJ6RhVSWX8EO1QCTDm3p5CYx/7yaPGtVUXLW4uqRpIU=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=guNaJL8FvThwPwOlsqDlBKU1b1Py2O044ziZ8Y3hVL7c4z3anx6o8GEzEPHx5+gPJNUinDXxJe8+XhMOE4YWYYljfGKZqwVhzDG8x8XPqERNMus3TdAqlXn0zpab02xTt7ZnER0SmdwfOduEDi4Bj4JWGxBLj5vFAPitLjJSoFU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tksbYUhY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id CF784C43390;
	Thu, 15 Feb 2024 11:50:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707997826;
	bh=CJ6RhVSWX8EO1QCTDm3p5CYx/7yaPGtVUXLW4uqRpIU=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=tksbYUhYmHOESZMuc7J+iXDcGfLcLTsuZSqsmhH46UVEZlsLCAiIReUgYS6wD672q
	 n+0NZmbQw1HbRD7kmm27XSNi4neLpHJkChtXgwYwaA8W/d0DM4G5Q/XKd2giAs+zLI
	 VpVy2DMefVLekGqAtK3zI3tOLHTxoZOR9GsOyYchHgGEMIhPFQRTLYPodRVxUGWtkB
	 Nsv94dJ4kcz/zBD7VpuiHh9E7cwBHuP20fmgwULGxE/zDVUdyQZRTvfNJx+XGpXK9o
	 O86ztEjlkzGpjzdbC0w9k4mwfAuMZegSpNiySYcEwg73Rjm4OVcf1S4zTC/wu69kj/
	 X8PAfbZlr/Lyg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id B38DBD8C97D;
	Thu, 15 Feb 2024 11:50:26 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net 1/3] can: j1939: prevent deadlock by changing
 j1939_socks_lock to rwlock
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170799782672.19486.13037464955262911596.git-patchwork-notify@kernel.org>
Date: Thu, 15 Feb 2024 11:50:26 +0000
References: <20240214140348.2412776-2-mkl@pengutronix.de>
In-Reply-To: <20240214140348.2412776-2-mkl@pengutronix.de>
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
 linux-can@vger.kernel.org, kernel@pengutronix.de, astrajoan@yahoo.com,
 syzbot+1591462f226d9cbf0564@syzkaller.appspotmail.com,
 o.rempel@pengutronix.de, stable@vger.kernel.org

Hello:

This series was applied to netdev/net.git (main)
by Marc Kleine-Budde <mkl@pengutronix.de>:

On Wed, 14 Feb 2024 14:59:05 +0100 you wrote:
> From: Ziqi Zhao <astrajoan@yahoo.com>
> 
> The following 3 locks would race against each other, causing the
> deadlock situation in the Syzbot bug report:
> 
> - j1939_socks_lock
> - active_session_list_lock
> - sk_session_queue_lock
> 
> [...]

Here is the summary with links:
  - [net,1/3] can: j1939: prevent deadlock by changing j1939_socks_lock to rwlock
    https://git.kernel.org/netdev/net/c/6cdedc18ba7b
  - [net,2/3] can: j1939: Fix UAF in j1939_sk_match_filter during setsockopt(SO_J1939_FILTER)
    https://git.kernel.org/netdev/net/c/efe7cf828039
  - [net,3/3] can: netlink: Fix TDCO calculation using the old data bittiming
    https://git.kernel.org/netdev/net/c/2aa0a5e65eae

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



