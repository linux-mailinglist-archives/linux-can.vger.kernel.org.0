Return-Path: <linux-can+bounces-1555-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C4F9698422A
	for <lists+linux-can@lfdr.de>; Tue, 24 Sep 2024 11:32:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 021491C231EC
	for <lists+linux-can@lfdr.de>; Tue, 24 Sep 2024 09:32:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31B4C1422C7;
	Tue, 24 Sep 2024 09:32:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b="XgMQkuNE"
X-Original-To: linux-can@vger.kernel.org
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93D9228370;
	Tue, 24 Sep 2024 09:32:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727170337; cv=none; b=MXr5JLlkFfS1Ojcyfp/OhfHue+GQxZcB74C+wYG/w8wVlUSC8tEVOXFFLOe37AqsLfWzm3pbhaPvh7UQ14DCFIufBmoKZ5mTJnz/oEB8QIQOorOVHjQ8xupF60gZER2szu32yLIyBKG5Po6dmUR0IprlR0hdMkXbAs+vBJNDGGc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727170337; c=relaxed/simple;
	bh=gp2NHwIbWFlt6fClt8a9EY1QInTrnh6bAf2/oDFsk3s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=a6J298JnOf+QhCZzZYHnEdtcQc7d0pfzsmibG8sZ+F2tIgoryEg9wd4YccdBZWtjPXNqJVzOlTjqd86dbkyJk3P63uL8T2bvZWKdlD031kZp8kF4foCOXcHMyxHWMjaQrUczNHIMMrvdhq5yYoxqr8Qy+HQ5O/dDpkyABzkcU/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b=XgMQkuNE; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de;
	s=gloria202408; h=Content-Type:Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=UGv54ZPch4dldjaHLdymCbKvQ0+65iKRTDiB+9dLMKQ=; b=XgMQkuNEPbTmfKL9s1c+A/kV+T
	qKg9bStvD9OtjJQ8qSw+YqR22Eni9tEyVb+xEVgH7smYY+RaGgofr2C9+jG1mqmE/Xpm+p/V7gmre
	RmcYgomIwXxgK3m/I1nxiLAgXZylKpLVDfEjrQ+incAaQ5J/HNrCas1vu1uBikbeut+32DFXpv7FA
	Q2F5Kwklay2l83N8jxkbTgj9r5KoECXAoWYCtV9dgu8x8HnYTEcQhjVPj1E7/Fwgy0HXa70N/NW8Y
	Lw38bETPsCjEMR/L3NETmUNgcpp0dgaRN49/qZ0M9kvSUf2/2kwRCWWH/yl3zkfHxnleb9s91gnX6
	iFbINuvg==;
Received: from 90-177-212-167.rck.o2.cz ([90.177.212.167] helo=phil.localnet)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1st1tb-0000eW-6G; Tue, 24 Sep 2024 11:31:47 +0200
From: Heiko Stuebner <heiko@sntech.de>
To: Marc Kleine-Budde <mkl@pengutronix.de>, kernel@pengutronix.de,
 Vincent Mailhol <mailhol.vincent@wanadoo.fr>,
 Geert Uytterhoeven <geert+renesas@glider.be>
Cc: "David S . Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, linux-can@vger.kernel.org,
 netdev@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
 Geert Uytterhoeven <geert+renesas@glider.be>
Subject: Re: [PATCH] can: CAN_ROCKCHIP_CANFD should depend on ARCH_ROCKCHIP
Date: Tue, 24 Sep 2024 11:31:45 +0200
Message-ID: <1931378.eGJsNajkDb@phil>
In-Reply-To:
 <a4b3c8c1cca9515e67adac83af5ba1b1fab2fcbc.1727169288.git.geert+renesas@glider.be>
References:
 <a4b3c8c1cca9515e67adac83af5ba1b1fab2fcbc.1727169288.git.geert+renesas@glider.be>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

Am Dienstag, 24. September 2024, 11:15:31 CEST schrieb Geert Uytterhoeven:
> The Rockchip CAN-FD controller is only present on Rockchip SoCs.  Hence
> add a dependency on ARCH_ROCKCHIP, to prevent asking the user about this
> driver when configuring a kernel without Rockchip platform support.
> 
> Fixes: ff60bfbaf67f219c ("can: rockchip_canfd: add driver for Rockchip CAN-FD controller")
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>

makes a lot of sense, and with the compile-test in, it'll still get
test-build

Reviewed-by: Heiko Stuebner <heiko@sntech.de>

> ---
>  drivers/net/can/rockchip/Kconfig | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/net/can/rockchip/Kconfig b/drivers/net/can/rockchip/Kconfig
> index e029e2a3ca4b04df..fd8d9f5eeaa434ac 100644
> --- a/drivers/net/can/rockchip/Kconfig
> +++ b/drivers/net/can/rockchip/Kconfig
> @@ -3,6 +3,7 @@
>  config CAN_ROCKCHIP_CANFD
>  	tristate "Rockchip CAN-FD controller"
>  	depends on OF || COMPILE_TEST
> +	depends on ARCH_ROCKCHIP || COMPILE_TEST
>  	select CAN_RX_OFFLOAD
>  	help
>  	  Say Y here if you want to use CAN-FD controller found on
> 





