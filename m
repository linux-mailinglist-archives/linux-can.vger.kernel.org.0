Return-Path: <linux-can+bounces-335-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B17AA85BEF6
	for <lists+linux-can@lfdr.de>; Tue, 20 Feb 2024 15:40:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 473A728851F
	for <lists+linux-can@lfdr.de>; Tue, 20 Feb 2024 14:40:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E9D96A8D4;
	Tue, 20 Feb 2024 14:40:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TRejuguQ"
X-Original-To: linux-can@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1576E2D796;
	Tue, 20 Feb 2024 14:40:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708440029; cv=none; b=BKlnaRKuixBOhFyxoH0Y3s+Z/XbVbj+KwFVoVPwBa0cZVqnRRYo58GS9m3fSOJ8XrgXWz/wh1yamRHd+RaAupAFJn2QmA7qa1qZj3l9ys6G5qiV4bkyHiyik+MNAWlKeq7zKBfr9vpAyva2CYgnq+VlbcNDfnqh4QeuOVUdZjsE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708440029; c=relaxed/simple;
	bh=btRj75p7biW7mHnfgkStXlULhZr7fFYXhb3zhAH7hRI=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=po21brsRLx75CxsNMZLBU13Bs9Fk1rWpa9SgnS0RZrqRhmztSkZrNypPxdmniY+Z6n3VRTlK0IObDBvik4TcZy2M6ff8DlIFa3sLo8ToP9yTrkR8IaquT/gsy4pl5fp2+t/++6gXd0B3Zl8C549Vcv/DytIwAwJiUPJ3DC00GhE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TRejuguQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 7F76EC433F1;
	Tue, 20 Feb 2024 14:40:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708440028;
	bh=btRj75p7biW7mHnfgkStXlULhZr7fFYXhb3zhAH7hRI=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=TRejuguQcAvMn+qHtkf8c+qBO9ulWh5kily38joSgD/U8aNNBzoWXNH2NoBn7uu9H
	 Hmb/OIfTVUJpMCn5CU5isL8wPYCAr3dgf4EWHwJvlUnbaqZmwO2XD9N1vmymtiGCQ2
	 D19xJhM5RaSkh4tFLYNQ6GoqPLNJxyDtmsVcaMoqcJs4dLHy4KNZjdE6Er0psOXPCu
	 pyDL+Y/BrL3M/uCIzFyF5eLWhM624qAIfMpmvUic3B1nW6PHaw/VgR6kVQrtHcNIcz
	 cbuf3JfgQJ+dDz0AaC7BpcstpjsIqtn6w8Lh924Rz3tSaYBCi2EWo8zHy6pxVYKqQZ
	 RMqZUjQE1Nw7w==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 65F77D990CD;
	Tue, 20 Feb 2024 14:40:28 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next 1/9] can: m_can: remove redundant check for
 pm_clock_support
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170844002841.1951.6610004337773218582.git-patchwork-notify@kernel.org>
Date: Tue, 20 Feb 2024 14:40:28 +0000
References: <20240220085130.2936533-2-mkl@pengutronix.de>
In-Reply-To: <20240220085130.2936533-2-mkl@pengutronix.de>
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
 linux-can@vger.kernel.org, kernel@pengutronix.de,
 francesco.dolcini@toradex.com, msp@baylibre.com

Hello:

This series was applied to netdev/net-next.git (main)
by Marc Kleine-Budde <mkl@pengutronix.de>:

On Tue, 20 Feb 2024 09:46:03 +0100 you wrote:
> From: Francesco Dolcini <francesco.dolcini@toradex.com>
> 
> m_can_clk_start() already skip starting the clock when
> clock support is disabled, remove the redundant check in
> m_can_class_register().
> 
> This also solves the imbalance with m_can_clk_stop() that is called
> afterward in the same function before the return.
> 
> [...]

Here is the summary with links:
  - [net-next,1/9] can: m_can: remove redundant check for pm_clock_support
    https://git.kernel.org/netdev/net-next/c/e517293fd72d
  - [net-next,2/9] dt-bindings: can: tcan4x5x: Document the wakeup-source flag
    https://git.kernel.org/netdev/net-next/c/b00cf4f62969
  - [net-next,3/9] can: m_can: allow keeping the transceiver running in suspend
    https://git.kernel.org/netdev/net-next/c/4a94d7e31cf5
  - [net-next,4/9] can: tcan4x5x: support resuming from rx interrupt signal
    https://git.kernel.org/netdev/net-next/c/b6b640c04446
  - [net-next,5/9] dt-bindings: can: xilinx_can: Add 'xlnx,has-ecc' optional property
    https://git.kernel.org/netdev/net-next/c/7075d733b8e4
  - [net-next,6/9] can: xilinx_can: Add ECC support
    https://git.kernel.org/netdev/net-next/c/8e6fbf7f66dc
  - [net-next,7/9] can: xilinx_can: Add ethtool stats interface for ECC errors
    https://git.kernel.org/netdev/net-next/c/e1d1698eb36c
  - [net-next,8/9] can: raw: fix getsockopt() for new CAN_RAW_XL_VCID_OPTS
    https://git.kernel.org/netdev/net-next/c/c8fba5d6df5e
  - [net-next,9/9] can: raw: raw_getsockopt(): reduce scope of err
    https://git.kernel.org/netdev/net-next/c/00bf80c437dc

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



