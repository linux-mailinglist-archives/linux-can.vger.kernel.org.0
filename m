Return-Path: <linux-can+bounces-1158-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 682A7949DEE
	for <lists+linux-can@lfdr.de>; Wed,  7 Aug 2024 04:50:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9935A1C2177D
	for <lists+linux-can@lfdr.de>; Wed,  7 Aug 2024 02:50:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7617A372;
	Wed,  7 Aug 2024 02:50:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZfXfvnrd"
X-Original-To: linux-can@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C04218D63E;
	Wed,  7 Aug 2024 02:50:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722999037; cv=none; b=hOl3PkHBfM1y1m+gkA6JSvGQ6q+1yvazTVTmmVBUB2T0zG7zUhkRQcVZtTjAjp9rq3DeYqTSr6zH79LE6X7xGM1WgO0khILQWzr4RbPKMUqyBRj3K+/H6bpRtf1lZfMa6LWUF3eW167fdaP53pj0O4h4ZiRfolfNd5HCAXbK2Mw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722999037; c=relaxed/simple;
	bh=VfXCIrq8JIJIr9+Xz1lnsdHDMCL06H2sAJGsiXp29kc=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=ecrfcJtrBIoIz1ABh6M1iFYwBpiKJ8Xx6cdeXgJPyvTIFvhQ91B4pkZ/yeNM6tHl7vmRywFpCVi9F829uziFPUpDJRmOgxx/9yKL4szoTYyKKVql2DBYGT0IRg3Tb7wrel748mAcx8ZjoThlVu9Km29xTitI27q2oFdYDihWad8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZfXfvnrd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B6941C32786;
	Wed,  7 Aug 2024 02:50:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722999036;
	bh=VfXCIrq8JIJIr9+Xz1lnsdHDMCL06H2sAJGsiXp29kc=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=ZfXfvnrdUbZTwyTL3nB4pcp1PBAzCR9sNDukS4kQBrihjPxRcg+YryGHUH7yXX24N
	 LHWthyY/q9R3JNWxml5eMLprZjMOa8Z18RBMroxONkGEWmxaVVpJIFUpbbfbz9fbBt
	 g6as0gGuVQe8K9imglHcmaTPibrTpyQH8JYlwLRNkCaBZ/ua/C4t0AGzGDeQIxQ5eU
	 MKVVJjIC15JzbXLZikaYaV/gDnKzUsoxZF864fd/8Y5ULyE0TuYXcGCTposppf5Yy6
	 pAGMK0Qe/dRpPZwoIvDfKLmvfDFkTYW8Rs6g5E2nquYqLN+X8jDsENOvp4VToyNvY0
	 jf0AAs1ASXK2g==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADEB739EFA73;
	Wed,  7 Aug 2024 02:50:36 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next 01/20] dt-bindings: can: fsl,flexcan: add common
 'can-transceiver' for fsl,flexcan
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172299903552.1825432.3401001607590903090.git-patchwork-notify@kernel.org>
Date: Wed, 07 Aug 2024 02:50:35 +0000
References: <20240806074731.1905378-2-mkl@pengutronix.de>
In-Reply-To: <20240806074731.1905378-2-mkl@pengutronix.de>
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
 linux-can@vger.kernel.org, kernel@pengutronix.de, Frank.Li@nxp.com,
 robh@kernel.org

Hello:

This series was applied to netdev/net-next.git (main)
by Marc Kleine-Budde <mkl@pengutronix.de>:

On Tue,  6 Aug 2024 09:41:52 +0200 you wrote:
> From: Frank Li <Frank.Li@nxp.com>
> 
> Add common 'can-transceiver' children node for fsl,flexcan.
> 
> Fix below warning:
> arch/arm64/boot/dts/freescale/fsl-ls1028a-rdb.dtb: can@2180000: 'can-transceiver' does not match any of the regexes: 'pinctrl-[0-9]+'
>         from schema $id: http://devicetree.org/schemas/net/can/fsl,flexcan.yaml#
> 
> [...]

Here is the summary with links:
  - [net-next,01/20] dt-bindings: can: fsl,flexcan: add common 'can-transceiver' for fsl,flexcan
    https://git.kernel.org/netdev/net-next/c/ef5e8d34bb9a
  - [net-next,02/20] dt-bindings: can: fsl,flexcan: move fsl,imx95-flexcan standalone
    https://git.kernel.org/netdev/net-next/c/3eea16ba7c69
  - [net-next,03/20] can: flexcan: add wakeup support for imx95
    https://git.kernel.org/netdev/net-next/c/5b512f42e098
  - [net-next,04/20] can: esd_402_pci: Rename esdACC CTRL register macros
    (no matching commit)
  - [net-next,05/20] can: esd_402_pci: Add support for one-shot mode
    https://git.kernel.org/netdev/net-next/c/c20ff3e0d9eb
  - [net-next,06/20] can: kvaser_usb: Add helper functions to convert device timestamp into ktime
    https://git.kernel.org/netdev/net-next/c/7d102d0e4c63
  - [net-next,07/20] can: kvaser_usb: hydra: kvaser_usb_hydra_ktime_from_rx_cmd: Drop {rx_} in function name
    https://git.kernel.org/netdev/net-next/c/7cb0450c1da5
  - [net-next,08/20] can: kvaser_usb: hydra: Add struct for Tx ACK commands
    https://git.kernel.org/netdev/net-next/c/0512cc691a3a
  - [net-next,09/20] can: kvaser_usb: hydra: Set hardware timestamp on transmitted packets
    https://git.kernel.org/netdev/net-next/c/d920dd289ee5
  - [net-next,10/20] can: kvaser_usb: leaf: Add struct for Tx ACK commands
    https://git.kernel.org/netdev/net-next/c/8e7895942ea5
  - [net-next,11/20] can: kvaser_usb: leaf: Assign correct timestamp_freq for kvaser_usb_leaf_imx_dev_cfg_{16,24,32}mhz
    https://git.kernel.org/netdev/net-next/c/dcc8c203318a
  - [net-next,12/20] can: kvaser_usb: leaf: Replace kvaser_usb_leaf_m32c_dev_cfg with kvaser_usb_leaf_m32c_dev_cfg_{16,24,32}mhz
    https://git.kernel.org/netdev/net-next/c/9e1cd0d27276
  - [net-next,13/20] can: kvaser_usb: leaf: kvaser_usb_leaf_tx_acknowledge: Rename local variable
    https://git.kernel.org/netdev/net-next/c/7f3823759751
  - [net-next,14/20] can: kvaser_usb: leaf: Add hardware timestamp support to leaf based devices
    https://git.kernel.org/netdev/net-next/c/8a52e5a0361f
  - [net-next,15/20] can: kvaser_usb: leaf: Add structs for Tx ACK and clock overflow commands
    https://git.kernel.org/netdev/net-next/c/a7cfb2200d85
  - [net-next,16/20] can: kvaser_usb: leaf: Store MSB of timestamp
    https://git.kernel.org/netdev/net-next/c/c644c9698d8d
  - [net-next,17/20] can: kvaser_usb: leaf: Add hardware timestamp support to usbcan devices
    https://git.kernel.org/netdev/net-next/c/0aa639d3b3b9
  - [net-next,18/20] can: kvaser_usb: Remove KVASER_USB_QUIRK_HAS_HARDWARE_TIMESTAMP
    https://git.kernel.org/netdev/net-next/c/51b56a25ed60
  - [net-next,19/20] can: kvaser_usb: Remove struct variables kvaser_usb_{ethtool,netdev}_ops
    https://git.kernel.org/netdev/net-next/c/1a6b249e4b19
  - [net-next,20/20] can: kvaser_usb: Rename kvaser_usb_{ethtool,netdev}_ops_hwts to kvaser_usb_{ethtool,netdev}_ops
    https://git.kernel.org/netdev/net-next/c/88371f85461a

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



