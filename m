Return-Path: <linux-can+bounces-5268-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 46206BFF3D7
	for <lists+linux-can@lfdr.de>; Thu, 23 Oct 2025 07:17:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 07C281A02965
	for <lists+linux-can@lfdr.de>; Thu, 23 Oct 2025 05:17:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 195EE23C8CD;
	Thu, 23 Oct 2025 05:17:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BUvUYYEx"
X-Original-To: linux-can@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEBFE157A5A;
	Thu, 23 Oct 2025 05:17:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761196630; cv=none; b=a8l/GIsrBp5Ka3tZAOs2cgq6CGJprOtgwA/oLN2+IvWI0vi7KogIGDnvoEJs0iBVoZFcJaPRJVwmZrrp965A9deUX5J1F3Q/Emi3IKS/hsITSWLbStacMv8OyNoePFyI8g3YIpcgfHEvQFV0/Fr6TSMuh1aCTlSpISbuvsSczhI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761196630; c=relaxed/simple;
	bh=wSiU4i1VN6HLtvNowK3/ZRUnH7MHzaLbuZNOUkxiTJ4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=j2MD5PS+gI4mxlOioh4l+pCr1mB2mVA2PyLTJAOrZRXBt+c4kiFErIVsoDIdU4M+SoBuJ/Wq2YoS/ddQ6RPYZzCUTMidtI0Lfrq+gfmYV35xDZ5UyXcFz3pMqW2iRPXocoWum6Yf87n4hd+3mgaHVAIv7BKmnvkN+RPAeiVbDFY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BUvUYYEx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4679EC4CEE7;
	Thu, 23 Oct 2025 05:16:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761196627;
	bh=wSiU4i1VN6HLtvNowK3/ZRUnH7MHzaLbuZNOUkxiTJ4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=BUvUYYExFEEvOcUyuuJO6p108bLwD4CukVdAL3YICXBCWps9S2wk92BsmQDzO+o6c
	 pDGTxIh3KbKx5I6LH0trzh4mceVbI+LUHjc6JLTw+/8PjAw2zufRbNJhMmdvdcpshw
	 c32W0R2Uwl9lYGthoBTv+5YT9BzWGVdybisEwqcDwawdgpUV+VUqv5kX2xKAKHpTb8
	 6PNeRu/JUVuk6ZIFtAsklv2zZ7FSJiF9mlO/+wr/ylOl1uXGgWQ0+QM5PqzYcMsHCV
	 es5EavQ/UvWm13sERH8B5xejbY1cwv1NeghauHXjBb5BwR36eP/5CMgkUgsyXhT6CL
	 82QvKNHZNb7GQ==
Date: Thu, 23 Oct 2025 10:46:50 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>
Cc: mkl@pengutronix.de, thomas.kopp@microchip.com, 
	mailhol.vincent@wanadoo.fr, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, 
	linus.walleij@linaro.org, brgl@bgdev.pl, linux-can@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, mukesh.savaliya@oss.qualcomm.com, 
	anup.kulkarni@oss.qualcomm.com
Subject: Re: [PATCH v6 0/6] can: mcp251xfd: add gpio functionality
Message-ID: <dvqn5hwvoi36djxkfte2sw2o2nnk7irh6tgt5vmtqgm6t2dbyc@snde7uwlzbia>
References: <20251001091006.4003841-1-viken.dadhaniya@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20251001091006.4003841-1-viken.dadhaniya@oss.qualcomm.com>

On Wed, Oct 01, 2025 at 02:40:00PM +0530, Viken Dadhaniya wrote:
> Hi all,
> 
> The mcp251xfd allows two pins to be configured as GPIOs. This series
> adds support for this feature.
> 
> The GPIO functionality is controlled with the IOCON register which has
> an erratum.
> 
> Patch 1 from https://lore.kernel.org/linux-can/20240429-mcp251xfd-runtime_pm-v1-3-c26a93a66544@pengutronix.de/
> Patch 2 refactor of no-crc functions to prepare workaround for non-crc writes
> Patch 3 is the fix/workaround for the aforementioned erratum
> Patch 4 only configure pin1 for rx-int
> Patch 5 adds the gpio support
> Patch 6 updates dt-binding
> 
> As per Marc's comment on below patch, we aim to get this series into
> linux-next since the functionality is essential for CAN on the RB3 Gen2
> board. As progress has stalled, Take this series forward with minor code
> adjustments. Include a Tested-by tag to reflect validation performed on the
> target hardware.
> 

LGTM! For the series,

Reviewed-by: Manivannan Sadhasivam <mani@kernel.org>

- Mani

> https://lore.kernel.org/all/20240806-industrious-augmented-crane-44239a-mkl@pengutronix.de/
> ---
> Changes in v6:
> - Simplified error handling by directly returning regmap_update_bits() result.
> - Added Acked-By tag.
> - Link to v5: https://lore.kernel.org/all/20250926133018.3071446-1-viken.dadhaniya@oss.qualcomm.com/
> 
> Changes in v5:
> - Removed #ifdef GPIOLIB and added select GPIOLIB in Kconfig
> - Rebased patch on latest baseline
> - Resolved Kernel Test Robot warnings
> - Link to v4: https://lore.kernel.org/all/20250918064903.241372-1-viken.dadhaniya@oss.qualcomm.com/
> 
> Changes in v4:
> - Moved GPIO register initialization into mcp251xfd_register after enabling
>   runtime PM to avoid GPIO request failures when using the gpio-hog
>   property to set default GPIO state.
> - Added Tested-by and Signed-off-by tags.
> - Dropped the 1st and 2nd patches from the v3 series as they have already been merged.
> - Link to v3: https://lore.kernel.org/linux-can/20240522-mcp251xfd-gpio-feature-v3-0-8829970269c5@ew.tq-group.com/
> 
> Changes in v3:
> - Implement workaround for non-crc writes
> - Configure only Pin1 for rx-int feature
> - moved errata check to .gather_write callback function
> - Added MCP251XFD_REG_IOCON_*() macros
> - Added Marcs suggestions
> - Collect Krzysztofs Acked-By
> - Link to v2: https://lore.kernel.org/r/20240506-mcp251xfd-gpio-feature-v2-0-615b16fa8789@ew.tq-group.com
> 
> ---
> Gregor Herburger (5):
>   can: mcp251xfd: utilize gather_write function for all non-CRC writes
>   can: mcp251xfd: add workaround for errata 5
>   can: mcp251xfd: only configure PIN1 when rx_int is set
>   can: mcp251xfd: add gpio functionality
>   dt-bindings: can: mcp251xfd: add gpio-controller property
> 
> Marc Kleine-Budde (1):
>   can: mcp251xfd: move chip sleep mode into runtime pm
> 
>  .../bindings/net/can/microchip,mcp251xfd.yaml |   5 +
>  drivers/net/can/spi/mcp251xfd/Kconfig         |   1 +
>  .../net/can/spi/mcp251xfd/mcp251xfd-core.c    | 273 +++++++++++++++---
>  .../net/can/spi/mcp251xfd/mcp251xfd-regmap.c  | 114 ++++++--
>  drivers/net/can/spi/mcp251xfd/mcp251xfd.h     |   8 +
>  5 files changed, 335 insertions(+), 66 deletions(-)
> 
> -- 
> 2.34.1
> 

-- 
மணிவண்ணன் சதாசிவம்

