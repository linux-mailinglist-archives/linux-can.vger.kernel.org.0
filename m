Return-Path: <linux-can+bounces-5244-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B199BF450E
	for <lists+linux-can@lfdr.de>; Tue, 21 Oct 2025 03:50:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B908B1893188
	for <lists+linux-can@lfdr.de>; Tue, 21 Oct 2025 01:51:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9174C1A8F6D;
	Tue, 21 Oct 2025 01:50:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DVR05K44"
X-Original-To: linux-can@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66C09C8FE;
	Tue, 21 Oct 2025 01:50:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761011441; cv=none; b=QeW05mPsPIqaeGLoCMBM7a66GJYDVgDF6KGhQLVQ7JMKodXenW2etM04K1JYulaLHvmjaTAeHY0jtPVVbeDqIN2F+l4DUIZciaaQl0ugZAyOs0zACyfN/dF64Yb9ib+FLHrIAcwlux0+WK9HSFNeArItjpGP/XdcQxugu3dIQr0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761011441; c=relaxed/simple;
	bh=NxgXLN8D+JxvQ+xaEdpf+RIA90OuGVK+nwNNDF2ZmkQ=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=LTKt6kbT2wqlx1IS5nqJtBUs/YXHDlIDLvCp6t579NDXM1lkAhvlBw/yUn1V3eJ4AcHG8guCqKRnXQgh2XdxPnHWivTWqsyggFJPrytcW3CNg1I9QKPfcBx1WgU+eDttpwrHxp0ixG9M6e9yOznzXX6TZXDRVgk2TIjbRFqgdsE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DVR05K44; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC0FFC4CEFB;
	Tue, 21 Oct 2025 01:50:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761011440;
	bh=NxgXLN8D+JxvQ+xaEdpf+RIA90OuGVK+nwNNDF2ZmkQ=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=DVR05K44buE/MzyMv/yVZLj3xsslI7DVut2bzy4AlbiM2Ga4DaJTlYFN1KnpTXNfn
	 ew6QPsjQ/aFK9QR/J1I16zgdzrxh2UZZgBLVD7MiJXe32EraP6kxWv4DwX3EuiDbjv
	 S2EIh6Dsi1ITihaEGxhqQNLH/BqxZY2eTesaPz/p3DE8rkEOxy1XdUjjU2T4e/5Qyq
	 SgYswjiaUnxe1JncuvpHabCC8IxN35ne0snGPtBfEmLGPPmkdRiWMln6XgIhgFSRX4
	 j2DdMGFuAmEk1BJpyAEPfRs9eOHuObPDyFheDk+Lqm8PFfWqoHo+5nNhfgSDdCcOwq
	 SvepPGJf0FK/A==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EAE3E3A4102E;
	Tue, 21 Oct 2025 01:50:23 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next 01/13] can: m_can: add support for optional reset
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176101142276.487622.4914639499321852543.git-patchwork-notify@kernel.org>
Date: Tue, 21 Oct 2025 01:50:22 +0000
References: <20251017150819.1415685-2-mkl@pengutronix.de>
In-Reply-To: <20251017150819.1415685-2-mkl@pengutronix.de>
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
 linux-can@vger.kernel.org, kernel@pengutronix.de, p.zabel@pengutronix.de,
 msp@baylibre.com

Hello:

This series was applied to netdev/net-next.git (main)
by Marc Kleine-Budde <mkl@pengutronix.de>:

On Fri, 17 Oct 2025 17:04:09 +0200 you wrote:
> This patch has been split from the original series [1].
> 
> In some SoCs (observed on the STM32MP15) the M_CAN IP core keeps the CAN
> state and CAN error counters over an internal reset cycle. The STM32MP15
> SoC provides an external reset, which is shared between both M_CAN cores.
> 
> Add support for an optional external reset. Take care of shared resets,
> de-assert reset during the probe phase in m_can_class_register() and while
> the interface is up, assert the reset otherwise.
> 
> [...]

Here is the summary with links:
  - [net-next,01/13] can: m_can: add support for optional reset
    https://git.kernel.org/netdev/net-next/c/9271d0ea07c2
  - [net-next,02/13] can: treewide: remove can_change_mtu()
    https://git.kernel.org/netdev/net-next/c/f968a24cad3d
  - [net-next,03/13] dt-bindings: can: m_can: Add wakeup properties
    https://git.kernel.org/netdev/net-next/c/73cc2882b644
  - [net-next,04/13] can: m_can: Map WoL to device_set_wakeup_enable
    https://git.kernel.org/netdev/net-next/c/04d5826b074e
  - [net-next,05/13] can: m_can: Return ERR_PTR on error in allocation
    https://git.kernel.org/netdev/net-next/c/148e125d4e6f
  - [net-next,06/13] can: m_can: Support pinctrl wakeup state
    https://git.kernel.org/netdev/net-next/c/a77a29775373
  - [net-next,07/13] can: m_can: m_can_init_ram(): make static
    https://git.kernel.org/netdev/net-next/c/c6dcc2b321cc
  - [net-next,08/13] can: m_can: hrtimer_callback(): rename to m_can_polling_timer()
    https://git.kernel.org/netdev/net-next/c/60af9dbb63fb
  - [net-next,09/13] net: m_can: convert dev_{dbg,info,err} -> netdev_{dbg,info,err}
    https://git.kernel.org/netdev/net-next/c/293735053eaa
  - [net-next,10/13] can: m_can: m_can_interrupt_enable(): use m_can_write() instead of open coding it
    https://git.kernel.org/netdev/net-next/c/c6cbd24f65f1
  - [net-next,11/13] can: m_can: m_can_class_register(): remove error message in case devm_kzalloc() fails
    https://git.kernel.org/netdev/net-next/c/6218391758b5
  - [net-next,12/13] can: m_can: m_can_tx_submit(): remove unneeded sanity checks
    https://git.kernel.org/netdev/net-next/c/b24b43522eb3
  - [net-next,13/13] can: m_can: m_can_get_berr_counter(): don't wake up controller if interface is down
    https://git.kernel.org/netdev/net-next/c/91a55c72a821

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



