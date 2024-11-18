Return-Path: <linux-can+bounces-2095-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AD4529D169F
	for <lists+linux-can@lfdr.de>; Mon, 18 Nov 2024 18:00:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F02CC280E9C
	for <lists+linux-can@lfdr.de>; Mon, 18 Nov 2024 17:00:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF5831ADFED;
	Mon, 18 Nov 2024 17:00:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RwKJmait"
X-Original-To: linux-can@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2D1518B47E;
	Mon, 18 Nov 2024 17:00:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731949219; cv=none; b=fhHbigHlVgO2+QIMvF4kj3W+FxGDS6NDPJNUVW/tgC1VnVHLmwokM30wi7WrJ1ntj4sPqa4jE+hj+S3f7ILgX4ODZMLbwBn4Ex8GsaGlOFRH9/FpxWcXOjdKkvfCy5GMDOx3O3jIaGEbD+96dg3BfPMlK5VaGth991s0X7KyYpo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731949219; c=relaxed/simple;
	bh=ekE1O8xyEVJFoKtw0C3VA+kT2P+GQt3Yk/reFDaycPU=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=cbQh2XxIGgkiRFWWAwd8fJCSOrf6AVRYa4YqbuBnk82PKMp7PATzATPuMZd5qARD7DOj+17TNN8aDkmcWYr27+i93q3759CriaVpUZ866CoL2+m86YURuzaREfh9PMZSkYn26Dklgrxh7FgM/fuL1J4qUXH6xvUHZ1P6571ngJ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RwKJmait; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 62F61C4CECC;
	Mon, 18 Nov 2024 17:00:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731949219;
	bh=ekE1O8xyEVJFoKtw0C3VA+kT2P+GQt3Yk/reFDaycPU=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=RwKJmaitQhxE25emSDMbNhsN2ui59x3qyMzy5f1yYIWY0L4Ex7m+FqgJtoeDzAKA8
	 Tny44j+yEFbROiB8r+aDBG591EwPxiwMpInKGgvaabLCAykqT8AoDFJbfMT57zYyfN
	 kZP/f0Wj58X9YHtKUSLVKVEwnFeGzGaq+JOIzpeP5leLa1o/7G4stYmJkJatlAqaWX
	 dOygGroPUqEeGaDDdWnJYsYNtUmLI6e053dXNVXHdj0lWlIrguhW47vK8E4JVVumxe
	 6D21fQ8iUulmfFeQ4mawarArAcz5IkL/5HEfZHrW05pD+tH/5ePW83Q0LwGs8hY2iX
	 MRhJ6gCyL2Ksg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EAEF03809A80;
	Mon, 18 Nov 2024 17:00:31 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH iproute2-next v1 0/6] iplink_can: preparation before
 introduction of CAN XL
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173194923075.4109060.18408610499610779344.git-patchwork-notify@kernel.org>
Date: Mon, 18 Nov 2024 17:00:30 +0000
References: <20241112172812.590665-8-mailhol.vincent@wanadoo.fr>
In-Reply-To: <20241112172812.590665-8-mailhol.vincent@wanadoo.fr>
To: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Cc: netdev@vger.kernel.org, stephen@networkplumber.org, dsahern@gmail.com,
 linux-can@vger.kernel.org, mkl@pengutronix.de, socketcan@hartkopp.net,
 mbro1689@gmail.com, linux-kernel@vger.kernel.org

Hello:

This series was applied to iproute2/iproute2-next.git (main)
by David Ahern <dsahern@kernel.org>:

On Wed, 13 Nov 2024 02:27:50 +0900 you wrote:
> An RFC was sent last weekend to kick-off the discussion of the
> introduction of CAN XL: [1] for the kernel side and [2] for the
> iproute2 interface. While the series received some positive feedback,
> it is far from completion. Some work is still needed to:
> 
>   - adjust the nesting of the IFLA_CAN_XL_DATA_BITTIMING_CONST in the
>     netlink interface
> 
> [...]

Here is the summary with links:
  - [iproute2-next,v1,1/6] iplink_can: remove unused FILE *f parameter in three functions
    https://git.kernel.org/pub/scm/network/iproute2/iproute2-next.git/commit/?id=df72757907f3
  - [iproute2-next,v1,2/6] iplink_can: reduce the visibility of tdc in can_parse_opt()
    https://git.kernel.org/pub/scm/network/iproute2/iproute2-next.git/commit/?id=3bd5fb4d57aa
  - [iproute2-next,v1,3/6] iplink_can: remove newline at the end of invarg()'s messages
    https://git.kernel.org/pub/scm/network/iproute2/iproute2-next.git/commit/?id=9b1f33d5a46d
  - [iproute2-next,v1,4/6] iplink_can: use invarg() instead of fprintf()
    https://git.kernel.org/pub/scm/network/iproute2/iproute2-next.git/commit/?id=68aaea862838
  - [iproute2-next,v1,5/6] iplink_can: add struct can_tdc
    https://git.kernel.org/pub/scm/network/iproute2/iproute2-next.git/commit/?id=aac087a0108b
  - [iproute2-next,v1,6/6] iplink_can: rename dbt into fd_dbt in can_parse_opt()
    https://git.kernel.org/pub/scm/network/iproute2/iproute2-next.git/commit/?id=3f2ab9d6070e

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



