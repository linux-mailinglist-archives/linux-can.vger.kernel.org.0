Return-Path: <linux-can+bounces-1303-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AE79F969162
	for <lists+linux-can@lfdr.de>; Tue,  3 Sep 2024 04:20:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6BFE4283B1B
	for <lists+linux-can@lfdr.de>; Tue,  3 Sep 2024 02:20:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 688D21CDA1F;
	Tue,  3 Sep 2024 02:20:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="r3ZA9K1j"
X-Original-To: linux-can@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EEC32AEFB;
	Tue,  3 Sep 2024 02:20:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725330033; cv=none; b=Hlg7E8LJdP8qwPXQ5L5s1vS6r6M5oyK2x5m6nHFpAoUPDX8ACeAcPxZWV/EPu8V93e0ZlLRLZ6bjgIJYMjwPiJemL3F0RLknrAvaFErxy//VwQ3GTi/ZzEeXKirbq6JAUMVHcKH+KfKNCOKE/lRWFPT2DX8xrzCS3+4TDeI4d48=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725330033; c=relaxed/simple;
	bh=QTyLz2LMh8eML71Vw0DDULBjl6dQH7qMGlfXEg0mz+I=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=CNwRvuceJKrdUAlYj+PXPsXbOs26Ow91kch6j1ByLfggJ8iuDJRenWFc8OFofgfETiuCJJ8t7Kbdi7SBo9TeoZX3/f5vZUuHu2fI5VWD9tGJ3rKQtvs/azmoxo3bMJdn/mwbllZuw+bOQwCpJ/Z6dPFX6uMdbxUoHRDUNJvucQE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=r3ZA9K1j; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF538C4CEC2;
	Tue,  3 Sep 2024 02:20:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725330032;
	bh=QTyLz2LMh8eML71Vw0DDULBjl6dQH7qMGlfXEg0mz+I=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=r3ZA9K1jZcQ6KflnstupTN3ZyORYp0TrDz2Z++YQ77UrKAqJnT/Faf8P30skYksMv
	 3B4uniCoXKgPqyul0BIVd976WQPy8viDst5lJoFgLqQmwrSA7M2MhJW1iFY9WdMSt9
	 DGRChUCYXhfCiOeuxuSyGTmjVyD6IVfkXmzDPGVULy0QnJBqXRqyu1LhxPdrysdaE9
	 TQbkmx1cXvHqogeqeHP03DkWHgTAQU8yTDsfQCX5Zstat5hGgy5KsdlzCAe++nv1GS
	 grzfHZuQgCYuBmYkvLz77mcgYt6+mHtZopTxjjOtnTjWaNHp1uBLM3fF3xuLpFMHMS
	 TQYOXGyeqMAHw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADEB73805D82;
	Tue,  3 Sep 2024 02:20:34 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next 1/6] dt-bindings: can: renesas,rcar-canfd: Document
 R-Car V4M support
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172533003324.4035616.15956819251099977914.git-patchwork-notify@kernel.org>
Date: Tue, 03 Sep 2024 02:20:33 +0000
References: <20240830214406.1605786-2-mkl@pengutronix.de>
In-Reply-To: <20240830214406.1605786-2-mkl@pengutronix.de>
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
 linux-can@vger.kernel.org, kernel@pengutronix.de, duy.nguyen.rh@renesas.com,
 geert+renesas@glider.be, horms@kernel.org, robh@kernel.org

Hello:

This series was applied to netdev/net-next.git (main)
by Marc Kleine-Budde <mkl@pengutronix.de>:

On Fri, 30 Aug 2024 23:34:34 +0200 you wrote:
> From: Duy Nguyen <duy.nguyen.rh@renesas.com>
> 
> Document support for the CAN-FD Interface on the Renesas R-Car V4M
> (R8A779H0) SoC, which supports up to four channels.
> 
> The CAN-FD module on R-Car V4M is very similar to the one on R-Car V4H,
> but differs in some hardware parameters, as reflected by the Parameter
> Status Information part of the Global IP Version Register.  However,
> none of this parameterization should have any impact on the driver, as
> the driver does not access any register that is impacted by the
> parameterization (except for the number of channels).
> 
> [...]

Here is the summary with links:
  - [net-next,1/6] dt-bindings: can: renesas,rcar-canfd: Document R-Car V4M support
    https://git.kernel.org/netdev/net-next/c/ced52c6ed257
  - [net-next,2/6] dt-bindings: can: convert microchip,mcp251x.txt to yaml
    https://git.kernel.org/netdev/net-next/c/09328600c2f9
  - [net-next,3/6] can: j1939: use correct function name in comment
    https://git.kernel.org/netdev/net-next/c/dc2ddcd136fe
  - [net-next,4/6] can: netlink: avoid call to do_set_data_bittiming callback with stale can_priv::ctrlmode
    https://git.kernel.org/netdev/net-next/c/2423cc20087a
  - [net-next,5/6] can: kvaser_pciefd: Use IS_ENABLED() instead of #ifdef
    https://git.kernel.org/netdev/net-next/c/a9c0fb33fd45
  - [net-next,6/6] can: kvaser_usb: Simplify with dev_err_probe()
    https://git.kernel.org/netdev/net-next/c/0315c0b5ed25

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



