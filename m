Return-Path: <linux-can+bounces-6049-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id F130FD0492C
	for <lists+linux-can@lfdr.de>; Thu, 08 Jan 2026 17:55:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 914083065E1A
	for <lists+linux-can@lfdr.de>; Thu,  8 Jan 2026 16:47:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2378E2DB78F;
	Thu,  8 Jan 2026 16:47:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GoIU5kVN"
X-Original-To: linux-can@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13A0229827E;
	Thu,  8 Jan 2026 16:47:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767890831; cv=none; b=XR5TGJ0eJmxMHEJXQGzjSiwuLmt0tEfnjD7/wD23rNOOOATX3CzsBBx9Wc+rFnFkNO2znANMpTeef6DYWqool2ep8NlqEhTStIQgIfk7OZLebd2xxrNIoPuorgQ4o9g9bQ6/k+e2f4+XZ9N4c/eygQ4yTfgfn6MMwJrTMxLuIvU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767890831; c=relaxed/simple;
	bh=kJClJX+0V06PtT2MwKiqkzjY9tj2YHDw8mvU6xDhD1Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DnYHuSU18CvvOKygNJnw7HzNuYAgU55XxgT+0sxyXMGfOt++Uc3AX8rSCKGJh6wwYfJlEMO+zPjjO7tsQE+I3zv++lOzeyJHc85iV8ZUFkpftGoKxUF8xI4ipEPjXOZEarvY/lqyZAlq4583OsWAsXTIak/cLqArIznCr7Hx25E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GoIU5kVN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 94A89C116D0;
	Thu,  8 Jan 2026 16:47:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767890829;
	bh=kJClJX+0V06PtT2MwKiqkzjY9tj2YHDw8mvU6xDhD1Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=GoIU5kVNsO/nyyxqDl5W5K/cEiUMdfaCK+ELslhSlReM75V+fj1YZ5CCbtCJrlxTR
	 5o3lkNSc0qdMlUvNTZEsigdUK3NRcDajTDjHwKG09G1bTk3q9AiimIXaDsmlpEuC4e
	 fAISSNx1aQUEI9ji2Vj4ZFt6YgHP0z8E7q27cSHAFRA3PI6oXubsJJriJ5cJMHxVWB
	 nngSz4Ta5Y9J4783gxBzFcDyzBACT9bjqHmfJ/J6kPsaGIkMGgNIAUQtGZwltPv48y
	 JsJWjxM8KsFvkLarp+Ev+wLIFnaOoqer5cXCNgwZEE8OVslPvTd0nprZcN3QIE7CDM
	 LcOs2dkgrD8Pg==
Date: Thu, 8 Jan 2026 22:16:59 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>
Cc: mkl@pengutronix.de, thomas.kopp@microchip.com, mailhol@kernel.org, 
	robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, andersson@kernel.org, 
	konradybcio@kernel.org, linux-can@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, mukesh.savaliya@oss.qualcomm.com, 
	anup.kulkarni@oss.qualcomm.com
Subject: Re: [PATCH v1 2/2] arm64: dts: qcom: qcs6490-rb3gen2: Enable CAN bus
 controller
Message-ID: <jlynppc5lspzcc2pkz7y6jgd6h2l7e6cparntvxnyx5rnfp54n@tymil62yg4go>
References: <20260108125200.2803112-1-viken.dadhaniya@oss.qualcomm.com>
 <20260108125200.2803112-3-viken.dadhaniya@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260108125200.2803112-3-viken.dadhaniya@oss.qualcomm.com>

On Thu, Jan 08, 2026 at 06:22:00PM +0530, Viken Dadhaniya wrote:
> Enable the MCP2518FD CAN controller on the QCS6490 RB3 Gen2 platform.
> The controller is connected via SPI3 and uses a 40 MHz oscillator.
> A GPIO hog for GPIO0 is included to configure the CAN transceiver in
> Normal mode during boot.
> 

It'd be worth mentioning how you tested the controller.

- Mani

> Signed-off-by: Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>
> ---
>  arch/arm64/boot/dts/qcom/qcs6490-rb3gen2.dts | 30 ++++++++++++++++++++
>  1 file changed, 30 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/qcs6490-rb3gen2.dts b/arch/arm64/boot/dts/qcom/qcs6490-rb3gen2.dts
> index e3d2f01881ae..f2f2925e645a 100644
> --- a/arch/arm64/boot/dts/qcom/qcs6490-rb3gen2.dts
> +++ b/arch/arm64/boot/dts/qcom/qcs6490-rb3gen2.dts
> @@ -44,6 +44,14 @@ chosen {
>  		stdout-path = "serial0:115200n8";
>  	};
>  
> +	clocks {
> +		mcp2518fd_osc: can-clk {
> +			compatible = "fixed-clock";
> +			clock-frequency = <40000000>;
> +			#clock-cells = <0>;
> +		};
> +	};
> +
>  	dp-connector {
>  		compatible = "dp-connector";
>  		label = "DP";
> @@ -1151,6 +1159,28 @@ platform {
>  	};
>  };
>  
> +&spi3 {
> +	status = "okay";
> +
> +	can@0 {
> +		compatible = "microchip,mcp2518fd";
> +		reg = <0>;
> +		interrupts-extended = <&tlmm 7 IRQ_TYPE_LEVEL_LOW>;
> +		clocks = <&mcp2518fd_osc>;
> +		spi-max-frequency = <10000000>;
> +		vdd-supply = <&vreg_l11c_2p8>;
> +		gpio-controller;
> +		#gpio-cells = <2>;
> +
> +		gpio0-hog {
> +			gpio-hog;
> +			gpios = <0 GPIO_ACTIVE_LOW>;
> +			output-high;
> +			line-name = "mcp251xfd-gpio0";
> +		};
> +	};
> +};
> +
>  &swr2 {
>  	status = "okay";
>  
> -- 
> 2.34.1
> 

-- 
மணிவண்ணன் சதாசிவம்

