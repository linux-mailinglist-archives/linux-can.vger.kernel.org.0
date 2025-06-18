Return-Path: <linux-can+bounces-3851-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B4F65ADE0BE
	for <lists+linux-can@lfdr.de>; Wed, 18 Jun 2025 03:40:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9DF19178BB6
	for <lists+linux-can@lfdr.de>; Wed, 18 Jun 2025 01:40:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F7A9199939;
	Wed, 18 Jun 2025 01:40:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dw/g8ufy"
X-Original-To: linux-can@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C800B199396;
	Wed, 18 Jun 2025 01:40:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750210842; cv=none; b=s6o9K1Qf5eHNiVYhEYjfH97w6rxfW2m3nT+gTzI09WPaVmNAD90PaYcp57fjbnrChncR/uTxVlddeCOXJf0uAh8/ZhmvTzgPzAp2ERsqhTJ3NXPX9srzQYQs5iU/7+RNbiM6eKu31KCSklasH0v3RfGP1lhmrcPG51jrKqQIOQw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750210842; c=relaxed/simple;
	bh=dWWHgiEt3tYWTZRgQm02U8aGJUCEgTY0w6sEmnkU+4s=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=EOeaqdgMAwHUXcMNCjSAvVcIz62zJpSucv2Zhr+XXFO6s1D0xvKOVXaoR23InDEzI4OJceUXUZGA/WDPyYjPYB6dwfLoBuQdSIw5ajRVWAIWZcIO+NfSKc82YY1w8aRsIrKc8QeHxWzzLC6vJPJ8EzNBopo/BInmBfRYJLFodC4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dw/g8ufy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 348C4C4CEF0;
	Wed, 18 Jun 2025 01:40:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750210841;
	bh=dWWHgiEt3tYWTZRgQm02U8aGJUCEgTY0w6sEmnkU+4s=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=dw/g8ufyu11VCbuMaNH4zZzsZdGQI+Frv2Bdhof0fbxSnVzrdeBylNSHvRJhDwibv
	 QD3nGymvb8a2VPn8/d/F+xH5C2fcdkUVNUfs9gBSYOYcnoBtQf/YiioPQ8qWhU/1Fi
	 /TwI0Cz59/BlnTyiC5q7u6K6bE2XF85SWcYyM4R8LcW5T8dAQ6pLOup1yl6nQK2rwo
	 tNb+jVEzw8TSsodBpO8MgA6c/kh20BoqSecflSaYFp9EDsbuguuuZnpJU8gCvFN5nQ
	 WmlL/8Ss+ex1zz0eLaE1Kz/w/ns6U8ZH+eTjGkqyptLL6PEMAm3kXr+3w1NQjjOHsu
	 npR4ZTWw/z2xg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EADD338111DD;
	Wed, 18 Jun 2025 01:41:10 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 0/5] net: use new GPIO line value setter callbacks
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175021086974.3761578.16857215533657509710.git-patchwork-notify@kernel.org>
Date: Wed, 18 Jun 2025 01:41:09 +0000
References: <20250616-gpiochip-set-rv-net-v2-0-cae0b182a552@linaro.org>
In-Reply-To: <20250616-gpiochip-set-rv-net-v2-0-cae0b182a552@linaro.org>
To: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: andrew@lunn.ch, olteanv@gmail.com, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 linus.walleij@linaro.org, chester.a.unal@arinc9.com, daniel@makrotopia.org,
 dqfext@gmail.com, sean.wang@mediatek.com, matthias.bgg@gmail.com,
 angelogioacchino.delregno@collabora.com, mkl@pengutronix.de,
 mailhol.vincent@wanadoo.fr, hkallweit1@gmail.com, linux@armlinux.org.uk,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-gpio@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org, linux-can@vger.kernel.org,
 linux-arm-msm@vger.kernel.org, bartosz.golaszewski@linaro.org

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 16 Jun 2025 09:24:03 +0200 you wrote:
> Commit 98ce1eb1fd87e ("gpiolib: introduce gpio_chip setters that return
> values") added new line setter callbacks to struct gpio_chip. They allow
> to indicate failures to callers. We're in the process of converting all
> GPIO controllers to using them before removing the old ones. This series
> converts all GPIO chips implemented under drivers/net/.
> 
> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> 
> [...]

Here is the summary with links:
  - [v2,1/5] net: dsa: vsc73xx: use new GPIO line value setter callbacks
    https://git.kernel.org/netdev/net-next/c/c73832445bf2
  - [v2,2/5] net: dsa: mt7530: use new GPIO line value setter callbacks
    https://git.kernel.org/netdev/net-next/c/4a03562794a3
  - [v2,3/5] net: can: mcp251x: propagate the return value of mcp251x_spi_write()
    https://git.kernel.org/netdev/net-next/c/b9e3c7af9e4d
  - [v2,4/5] net: can: mcp251x: use new GPIO line value setter callbacks
    https://git.kernel.org/netdev/net-next/c/5d31311715b5
  - [v2,5/5] net: phy: qca807x: use new GPIO line value setter callbacks
    https://git.kernel.org/netdev/net-next/c/dea3be40464a

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



