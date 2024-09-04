Return-Path: <linux-can+bounces-1356-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CD7296B57E
	for <lists+linux-can@lfdr.de>; Wed,  4 Sep 2024 10:52:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C085C1C21857
	for <lists+linux-can@lfdr.de>; Wed,  4 Sep 2024 08:52:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1DFB1CC16B;
	Wed,  4 Sep 2024 08:51:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b="LbDdmHAW"
X-Original-To: linux-can@vger.kernel.org
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47D14198A20;
	Wed,  4 Sep 2024 08:51:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725439880; cv=none; b=Ww/yY8zbMjFsXjQjiPAYWKjYEf4DjqFZPYNDRZW1A/+Yq+a3Qwt7tWfEfI4ew/fCNO8ZV8vSgUoieMAblZ5J5E7nZrizMImHuFIGaF5VqYCifRdSCBw3nzQ/uGwwOFJzHxOW5u7HjSnrMOEedAy1TfLtbPz/MzfgB2mobq8PUzU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725439880; c=relaxed/simple;
	bh=adT/SxLb1VcszbcNZfZzr4YWc+2gXp7g/jFbdzDTQ+M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XAWBiCxaYagn7ky/bOIcg/aGADEJyabQByCBn4639olIBP4hhrE8pW6SPFhgYeCARzkJWPGe0qHFqM96fqOnjf8lFiMburzJ0YJqH0/lgXk3lLYz6nEPY7MhzwyjuBG3FapNR1jBqCKWaNHVZlDzu55/4v6qAWc1FGRrlMbVoSQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b=LbDdmHAW; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de;
	s=gloria202408; h=Content-Type:Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=+PEHLdA08PpGmacO7sjfbjoDVLRNrNK/UDyQKZ5It2I=; b=LbDdmHAWCqWq3XPZDDBvu8VSk5
	fcbZrsCciUUIgMyPxvou0l7wVgO9v6cvOrfiTSRf4dt3DpRxyouHBVSTirDhNLQPwiMbSHAzaENC2
	NjpMQbR63gG33QY5o2+IyOAKZXaeazEIwCDEeuP4+YueQWfpZo7mjgqyeOgUl1SeUJVNBxxob17yj
	TXYvhYnQKs7W6cb2U24dwc4icutv9QlU6h3e8gaPmABIBzyWSHm//kg6P++4QFwTq+x76HQSvmOqw
	tM8tvIKxUUf7R7kfFLVa59LOblChXMUZodBXn0sNDr+fIAvxXa7cJAVufwJXW2ZMquTjtN3oz5Y3r
	7R6BMRzQ==;
Received: from i5e860d0f.versanet.de ([94.134.13.15] helo=diego.localnet)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1slljJ-0006a3-Qe; Wed, 04 Sep 2024 10:51:09 +0200
From: Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>
To: kernel@pengutronix.de, Alibek Omarov <a1ba.omarov@gmail.com>,
 Vincent Mailhol <mailhol.vincent@wanadoo.fr>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Philipp Zabel <p.zabel@pengutronix.de>,
 Elaine Zhang <zhangqing@rock-chips.com>,
 David Jander <david.jander@protonic.nl>,
 Marc Kleine-Budde <mkl@pengutronix.de>
Cc: Simon Horman <horms@kernel.org>, linux-can@vger.kernel.org,
 netdev@vger.kernel.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org,
 linux-kernel@vger.kernel.org, Marc Kleine-Budde <mkl@pengutronix.de>,
 David Jander <david@protonic.nl>
Subject:
 Re: [PATCH can-next v5 03/20] arm64: dts: rockchip: mecsbc: add CAN0 and CAN1
 interfaces
Date: Wed, 04 Sep 2024 10:52:54 +0200
Message-ID: <8027881.qOBuL9xsDt@diego>
In-Reply-To: <20240904-rockchip-canfd-v5-3-8ae22bcb27cc@pengutronix.de>
References:
 <20240904-rockchip-canfd-v5-0-8ae22bcb27cc@pengutronix.de>
 <20240904-rockchip-canfd-v5-3-8ae22bcb27cc@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

Am Mittwoch, 4. September 2024, 10:12:47 CEST schrieb Marc Kleine-Budde:
> From: David Jander <david@protonic.nl>
> 
> This patch adds support for the CAN0 and CAN1 interfaces to the board.
> 
> Signed-off-by: David Jander <david@protonic.nl>
> Tested-by: Alibek Omarov <a1ba.omarov@gmail.com>
> Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
> ---
>  arch/arm64/boot/dts/rockchip/rk3568-mecsbc.dts | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/rockchip/rk3568-mecsbc.dts b/arch/arm64/boot/dts/rockchip/rk3568-mecsbc.dts
> index c2dfffc638d1..052ef03694cf 100644
> --- a/arch/arm64/boot/dts/rockchip/rk3568-mecsbc.dts
> +++ b/arch/arm64/boot/dts/rockchip/rk3568-mecsbc.dts
> @@ -117,6 +117,20 @@ &cpu3 {
>  	cpu-supply = <&vdd_cpu>;
>  };
>  
> +&can0 {
> +	compatible = "rockchip,rk3568v3-canfd", "rockchip,rk3568v2-canfd";
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&can0m0_pins>;
> +	status = "okay";
> +};
> +
> +&can1 {
> +	compatible = "rockchip,rk3568v3-canfd", "rockchip,rk3568v2-canfd";
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&can1m1_pins>;
> +	status = "okay";
> +};
> +

cpu3 > can0 ... aka alphabetical sorting of phandles

Reviewed-by: Heiko Stuebner <heiko@sntech.de>

No need to resend for that though.


>  &gmac1 {
>  	assigned-clocks = <&cru SCLK_GMAC1_RX_TX>, <&cru SCLK_GMAC1>;
>  	assigned-clock-parents = <&cru SCLK_GMAC1_RGMII_SPEED>, <&cru CLK_MAC1_2TOP>;
> 
> 





