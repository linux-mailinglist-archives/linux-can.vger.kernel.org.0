Return-Path: <linux-can+bounces-846-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 09D85913153
	for <lists+linux-can@lfdr.de>; Sat, 22 Jun 2024 03:20:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B8E3E284563
	for <lists+linux-can@lfdr.de>; Sat, 22 Jun 2024 01:20:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C221633;
	Sat, 22 Jun 2024 01:20:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LTEzZ24g"
X-Original-To: linux-can@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 533318BEE;
	Sat, 22 Jun 2024 01:20:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719019237; cv=none; b=LaT01XKhH5Ks+Te5kAHim2ixEgd24R6XGZpvBDEyt0mkUFeWYy0adatA68T8ovGNf3iE6tJ81EfUY37nNSLpdIM8GsTPEKHv6MLeHwsdsVt98X1fgDKOHCMo+WnzQLyK52DIxnu/9Gadvc91pBCI7eFmflATrTIsdK2bJnJNrKg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719019237; c=relaxed/simple;
	bh=SX03R1QAKqYMHT/7BDXtmiylpw+3IjqMhvoveNnBnDc=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=DBvuVPyRgu+WVcbe+uwVxuSt50zj6zbFR3FXLA7CX0d/QI/gu/ghYljh3qPCiNnGmw26qXxpVDZkP45v7Q90cHvjqkT5KYSU4V8unrPMY9U1zChC62YyDCZJdp+BoK80T2TAxwPhgvyXB1tdLWoSBDhyVLwBNFXLY7UYRE/tNxw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LTEzZ24g; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id DF2DAC4AF07;
	Sat, 22 Jun 2024 01:20:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719019236;
	bh=SX03R1QAKqYMHT/7BDXtmiylpw+3IjqMhvoveNnBnDc=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=LTEzZ24g9RZL4d/K5PQ7aYbmfKknkNP5rQIAMYoYqQG7xSrl1N/zcYCP/w6Z5FyCt
	 VjfTSkvTVOcIAw7N+gpfvdVTpiWsV0x0/ZMssgtlDY9j+PM5hiiRVwsmY2k9T9RVKE
	 69pwisxBnW0FZ5hngvRqR8Ll2Z7cPqdhTZJCg5szblxW025kqbFr3iGRx/I28VdUv7
	 k/5J0HIPQructEeISQENa8LUr7QqS9zO3RA+RLQE4GtdzPldRhPmXL8S1Uxmxb2aoE
	 eiHXufBD5YiURaFd6Fu4O8fjfsaONMHHQ1lTj8+HzI1Weg/DtCf1E2ohtRHRSzAf5B
	 t4y1qJXVKMn5g==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id D1D5CC54BB3;
	Sat, 22 Jun 2024 01:20:36 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next 01/24] can: mcp251x: Fix up includes
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171901923685.1383.11857515191105644144.git-patchwork-notify@kernel.org>
Date: Sat, 22 Jun 2024 01:20:36 +0000
References: <20240621080201.305471-2-mkl@pengutronix.de>
In-Reply-To: <20240621080201.305471-2-mkl@pengutronix.de>
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
 linux-can@vger.kernel.org, kernel@pengutronix.de,
 andriy.shevchenko@linux.intel.com, mailhol.vincent@wanadoo.fr

Hello:

This series was applied to netdev/net-next.git (main)
by Marc Kleine-Budde <mkl@pengutronix.de>:

On Fri, 21 Jun 2024 09:48:21 +0200 you wrote:
> From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> 
> This driver is including the legacy GPIO header <linux/gpio.h>
> but the only thing it is using from that header is the wrong
> define for GPIOF_DIR_OUT.
> 
> Fix it up by using GPIO_LINE_DIRECTION_* macros respectively.
> 
> [...]

Here is the summary with links:
  - [net-next,01/24] can: mcp251x: Fix up includes
    https://git.kernel.org/netdev/net-next/c/b1dc3c68e977
  - [net-next,02/24] can: sja1000: plx_pci: Reuse predefined CTI subvendor ID
    https://git.kernel.org/netdev/net-next/c/5ca3801388f8
  - [net-next,03/24] can: Kconfig: remove obsolete help text for slcan
    https://git.kernel.org/netdev/net-next/c/58b34cd646b4
  - [net-next,04/24] dt-bindings: can: xilinx_can: Modify the title to indicate CAN and CANFD controllers are supported
    https://git.kernel.org/netdev/net-next/c/8416ac9c87bd
  - [net-next,05/24] can: isotp: remove ISO 15675-2 specification version where possible
    https://git.kernel.org/netdev/net-next/c/ba63a7e08523
  - [net-next,06/24] can: xilinx_can: Document driver description to list all supported IPs
    https://git.kernel.org/netdev/net-next/c/e562bad35fe3
  - [net-next,07/24] Documentation: networking: document ISO 15765-2
    https://git.kernel.org/netdev/net-next/c/67711e04254c
  - [net-next,08/24] can: mscan: remove unused struct 'mscan_state'
    https://git.kernel.org/netdev/net-next/c/f9f608e38b9c
  - [net-next,09/24] can: kvaser_usb: Add support for Vining 800
    https://git.kernel.org/netdev/net-next/c/2851d357a485
  - [net-next,10/24] can: kvaser_usb: Add support for Kvaser USBcan Pro 5xCAN
    https://git.kernel.org/netdev/net-next/c/96a669a1958f
  - [net-next,11/24] can: kvaser_usb: Add support for Kvaser Mini PCIe 1xCAN
    https://git.kernel.org/netdev/net-next/c/0135c4c6b84c
  - [net-next,12/24] can: kvaser_pciefd: Group #defines together
    https://git.kernel.org/netdev/net-next/c/cdbc9d055fc7
  - [net-next,13/24] can: kvaser_pciefd: Skip redundant NULL pointer check in ISR
    https://git.kernel.org/netdev/net-next/c/ac765219c2c4
  - [net-next,14/24] can: kvaser_pciefd: Remove unnecessary comment
    https://git.kernel.org/netdev/net-next/c/11d186697ceb
  - [net-next,15/24] can: kvaser_pciefd: Add inline
    https://git.kernel.org/netdev/net-next/c/0132a05df1e0
  - [net-next,16/24] can: kvaser_pciefd: Add unlikely
    https://git.kernel.org/netdev/net-next/c/cebfebefaa01
  - [net-next,17/24] can: kvaser_pciefd: Rename board_irq to pci_irq
    https://git.kernel.org/netdev/net-next/c/cbf88a6ba7bb
  - [net-next,18/24] can: kvaser_pciefd: Change name of return code variable
    https://git.kernel.org/netdev/net-next/c/26a1b0fe3f62
  - [net-next,19/24] can: kvaser_pciefd: Move reset of DMA RX buffers to the end of the ISR
    https://git.kernel.org/netdev/net-next/c/48f827d4f48f
  - [net-next,20/24] can: kvaser_pciefd: Add MSI interrupts
    https://git.kernel.org/netdev/net-next/c/dd1f05ba2a99
  - [net-next,21/24] can: hi311x: simplify with spi_get_device_match_data()
    https://git.kernel.org/netdev/net-next/c/1562a49d000c
  - [net-next,22/24] can: mcp251x: simplify with spi_get_device_match_data()
    https://git.kernel.org/netdev/net-next/c/d4383d67a25b
  - [net-next,23/24] can: mcp251xfd: simplify with spi_get_device_match_data()
    https://git.kernel.org/netdev/net-next/c/9cdae370c4ec
  - [net-next,24/24] can: m_can: don't enable transceiver when probing
    (no matching commit)

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



