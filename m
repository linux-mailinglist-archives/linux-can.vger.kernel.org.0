Return-Path: <linux-can+bounces-1885-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DDAD39BC2FD
	for <lists+linux-can@lfdr.de>; Tue,  5 Nov 2024 03:10:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8B9901F22B49
	for <lists+linux-can@lfdr.de>; Tue,  5 Nov 2024 02:10:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A782752F71;
	Tue,  5 Nov 2024 02:10:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fOzX+5Tj"
X-Original-To: linux-can@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DA784E1C4;
	Tue,  5 Nov 2024 02:10:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730772623; cv=none; b=WANGkvtOUX+UxrlUhdhLFdaZZMqGQjwpstG2/+lAZifabcrBREmGnsI1LkqXH6jBezoDt5uB9kc//Bn4XCoq6MRdBP0KZlQcyCglz8uwu98cMDE+5UlBQWIa3hhhdSejBzexQILze0PBlikQ85A65xBXgGL/2RYwNnWVmg2oP8A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730772623; c=relaxed/simple;
	bh=Po5MaKdUL6RYSi246eSx6gttyBF0y8NCd0d0fj15hts=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=MH7KHNRgDutdo6IdFiPAo3bFHJOlKjPqNcvUpK6x1G0nhcelgo+kVJmHBNaPzg/gbJHcfNcOSVsDTFCsWZIwn4hgLVmYvZUubnZY+gjxjn3Yx5P3MpmfuEcbN/72OtAGM67TL55gNhEuLFoSi4aoRGie1RlXOy7eLeUuV1SyKnY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fOzX+5Tj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 08729C4CED2;
	Tue,  5 Nov 2024 02:10:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730772623;
	bh=Po5MaKdUL6RYSi246eSx6gttyBF0y8NCd0d0fj15hts=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=fOzX+5Tj1H8+F6RU2c6VnfKhPuvwzrG2JwN8ePvhidf1l+jF/w6JTmkVdYgdTJf/v
	 bi8IGKqenFpZMMJiV4HyjRJVow++hnxLzoFQCnGh1hHGesiWoa7fbcm/6LN/EJt2d2
	 T+QI4sJzXgCzUbyoc5C9PVU1o9l25hSt0GxjHG3brzDGxl9gn6hhjo8qQPjua06mEx
	 +u81VlpJqGTyNe8DeSJsqaH2kBE5lF+17LIu9fvj/p3g1i7sC+idv1VmBoD/Ae0lLY
	 hO/q9wqTyu+BFexTjZ3Fkzjz7+/5jxrEONySqaKRHl2YZX9PNQ7GbCb3N1p8VUfDga
	 JKyEmc0JB9SRQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EB4053809A80;
	Tue,  5 Nov 2024 02:10:32 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net 1/8] can: j1939: fix error in J1939 documentation.
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173077263177.87562.17899880515746032832.git-patchwork-notify@kernel.org>
Date: Tue, 05 Nov 2024 02:10:31 +0000
References: <20241104200120.393312-2-mkl@pengutronix.de>
In-Reply-To: <20241104200120.393312-2-mkl@pengutronix.de>
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
 linux-can@vger.kernel.org, kernel@pengutronix.de, alexander.hoelzl@gmx.net,
 o.rempel@pengutronix.de, mailhol.vincent@wanadoo.fr

Hello:

This series was applied to netdev/net.git (main)
by Marc Kleine-Budde <mkl@pengutronix.de>:

On Mon,  4 Nov 2024 20:53:24 +0100 you wrote:
> From: Alexander Hölzl <alexander.hoelzl@gmx.net>
> 
> The description of PDU1 format usage mistakenly referred to PDU2 format.
> 
> Signed-off-by: Alexander Hölzl <alexander.hoelzl@gmx.net>
> Acked-by: Oleksij Rempel <o.rempel@pengutronix.de>
> Acked-by: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
> Link: https://patch.msgid.link/20241023145257.82709-1-alexander.hoelzl@gmx.net
> Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
> 
> [...]

Here is the summary with links:
  - [net,1/8] can: j1939: fix error in J1939 documentation.
    https://git.kernel.org/netdev/net/c/b6ec62e01aa4
  - [net,2/8] can: {cc770,sja1000}_isa: allow building on x86_64
    https://git.kernel.org/netdev/net/c/7b22846f8af5
  - [net,3/8] can: m_can: m_can_close(): don't call free_irq() for IRQ-less devices
    https://git.kernel.org/netdev/net/c/e4de81f9e134
  - [net,4/8] can: c_can: fix {rx,tx}_errors statistics
    https://git.kernel.org/netdev/net/c/4d6d26537940
  - [net,5/8] can: rockchip_canfd: CAN_ROCKCHIP_CANFD should depend on ARCH_ROCKCHIP
    https://git.kernel.org/netdev/net/c/4384b8b6ec46
  - [net,6/8] can: rockchip_canfd: Drop obsolete dependency on COMPILE_TEST
    https://git.kernel.org/netdev/net/c/51e102ec23b2
  - [net,7/8] can: mcp251xfd: mcp251xfd_ring_alloc(): fix coalescing configuration when switching CAN modes
    https://git.kernel.org/netdev/net/c/eb9a839b3d8a
  - [net,8/8] can: mcp251xfd: mcp251xfd_get_tef_len(): fix length calculation
    https://git.kernel.org/netdev/net/c/3c1c18551e6a

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



