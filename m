Return-Path: <linux-can+bounces-1707-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 41CC199FE80
	for <lists+linux-can@lfdr.de>; Wed, 16 Oct 2024 03:51:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7429D1C247C1
	for <lists+linux-can@lfdr.de>; Wed, 16 Oct 2024 01:51:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F84C163A97;
	Wed, 16 Oct 2024 01:50:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M8LpzjbY"
X-Original-To: linux-can@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04CDF13C9B3;
	Wed, 16 Oct 2024 01:50:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729043433; cv=none; b=eZSQlvkIe+x9a896NoHMBA4myo0jOy1MYM5vSLY1P1EcdyvP5QTHMt5G8U5QGQkS1OUG187McJHh7IxzzkKOusU3QfdYKuhnwmcQJkGvj6Qq9m2brPJa7QdnKmEISx728Lz4w8d05wpkZE/ILeK2UzzaPvp08nOwmKYvfQ8QKIM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729043433; c=relaxed/simple;
	bh=//kfzT4z2I3p1+qb6QmkbVbdKWwkHcHb/4X+t3gmAy8=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=XWSFpkDz3ydbG8RkE1xl6M9HWXDBYbJ+ExjN4pp+eGYYku1IO/pphfxHG8+4rW2iiebUnOTtArFFewZK3Ex5pu27sNRExl1ebR7j61ddFWxxtOlZHKyHiO+7bVmVsUUV9pubw8ojjfznzmpobThShvq+dANf6S/+7zA/ip5ofO4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M8LpzjbY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D427C4CECD;
	Wed, 16 Oct 2024 01:50:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729043432;
	bh=//kfzT4z2I3p1+qb6QmkbVbdKWwkHcHb/4X+t3gmAy8=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=M8LpzjbYJW3oUGICZGvuPFYT2fLvvbW1YIGZ/xk3KDquqnl9nF/N+99R6Pk/t3EVR
	 YykV0DqLR7/pOYLfhFAVnPzkwN+AnTGMCQzmlCJ3eMgZohrIAcMFr8vehQoNLgCWV1
	 fIk+wso56eelZ1ZYGALeHkaGQfulpFl98wUuyquorZ7zepUiI7hUyHieDr76s0xC0K
	 EU8ejx9Yy7vCZbXzrS51xJvXTe8rn5kS+ZDwC7Okv3sx2DHFkWvADuVEVDu/9PTy2y
	 BlOcDLZLFkjgP/0ujAb10gPi1OqITv4D6ooM5EKrIOY9SL7N+XkrP768lyStMBs4v6
	 tdUNIsb9qcw+A==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EB3303809A8A;
	Wed, 16 Oct 2024 01:50:38 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v3 0/9] do not leave dangling sk pointers in
 pf->create functions
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172904343748.1354363.11673175872638481979.git-patchwork-notify@kernel.org>
Date: Wed, 16 Oct 2024 01:50:37 +0000
References: <20241014153808.51894-1-ignat@cloudflare.com>
In-Reply-To: <20241014153808.51894-1-ignat@cloudflare.com>
To: Ignat Korchagin <ignat@cloudflare.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 marcel@holtmann.org, johan.hedberg@gmail.com, luiz.dentz@gmail.com,
 socketcan@hartkopp.net, mkl@pengutronix.de, alex.aring@gmail.com,
 stefan@datenfreihafen.org, miquel.raynal@bootlin.com, dsahern@kernel.org,
 willemdebruijn.kernel@gmail.com, linux-bluetooth@vger.kernel.org,
 linux-can@vger.kernel.org, linux-wpan@vger.kernel.org,
 kernel-team@cloudflare.com, kuniyu@amazon.com, alibuda@linux.alibaba.com

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 14 Oct 2024 16:37:59 +0100 you wrote:
> Some protocol family create() implementations have an error path after
> allocating the sk object and calling sock_init_data(). sock_init_data()
> attaches the allocated sk object to the sock object, provided by the
> caller.
> 
> If the create() implementation errors out after calling sock_init_data(),
> it releases the allocated sk object, but the caller ends up having a
> dangling sk pointer in its sock object on return. Subsequent manipulations
> on this sock object may try to access the sk pointer, because it is not
> NULL thus creating a use-after-free scenario.
> 
> [...]

Here is the summary with links:
  - [net-next,v3,1/9] af_packet: avoid erroring out after sock_init_data() in packet_create()
    https://git.kernel.org/netdev/net-next/c/46f2a11cb82b
  - [net-next,v3,2/9] Bluetooth: L2CAP: do not leave dangling sk pointer on error in l2cap_sock_create()
    https://git.kernel.org/netdev/net-next/c/7c4f78cdb8e7
  - [net-next,v3,3/9] Bluetooth: RFCOMM: avoid leaving dangling sk pointer in rfcomm_sock_alloc()
    https://git.kernel.org/netdev/net-next/c/3945c799f12b
  - [net-next,v3,4/9] net: af_can: do not leave a dangling sk pointer in can_create()
    https://git.kernel.org/netdev/net-next/c/811a7ca7320c
  - [net-next,v3,5/9] net: ieee802154: do not leave a dangling sk pointer in ieee802154_create()
    https://git.kernel.org/netdev/net-next/c/b4fcd63f6ef7
  - [net-next,v3,6/9] net: inet: do not leave a dangling sk pointer in inet_create()
    https://git.kernel.org/netdev/net-next/c/9365fa510c6f
  - [net-next,v3,7/9] net: inet6: do not leave a dangling sk pointer in inet6_create()
    https://git.kernel.org/netdev/net-next/c/9df99c395d0f
  - [net-next,v3,8/9] net: warn, if pf->create does not clear sock->sk on error
    https://git.kernel.org/netdev/net-next/c/48156296a08c
  - [net-next,v3,9/9] Revert "net: do not leave a dangling sk pointer, when socket creation fails"
    https://git.kernel.org/netdev/net-next/c/18429e6e0c2a

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



