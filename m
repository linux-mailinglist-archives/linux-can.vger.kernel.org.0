Return-Path: <linux-can+bounces-680-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E5A7C8CE0C3
	for <lists+linux-can@lfdr.de>; Fri, 24 May 2024 07:48:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A1998281FFF
	for <lists+linux-can@lfdr.de>; Fri, 24 May 2024 05:48:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D81193EA7B;
	Fri, 24 May 2024 05:48:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="tMGmaw6y"
X-Original-To: linux-can@vger.kernel.org
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 237C079C2;
	Fri, 24 May 2024 05:48:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.248
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716529718; cv=none; b=h2JICjo5fW3Fr9ixRr9TL2qhOT3VyQ5U0GiXoJGqp3yLLxzxPeghsoek+rw3T4bdgOSAmJPWibMcUm/X7ngu3RGeIATRRlVBfAfwvpwbAZAEQtsMX9Jx1uvPV/HIS96xb08VQ0fGQNFSeCrrJSIDvOfqZhp49E1UELEaGFA0d44=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716529718; c=relaxed/simple;
	bh=mR6c80AZRglI+5ltlZH/pd9F75W8YItn0ClVJ49BOWc=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=J+mzH3C0rqDThoWNMcvqRNKvauJ9yZTDYeUTNb77a4yuE+81G31b9vp30KV3JVf6yqwrfF7zzm7MJLhhfd+QkTkzdpzNz75pAC07QCc+LULga/Ie/hQSFnq7R8s1iU6zYTHtdUpQhCyj3Zmbql3aASPE29NWfNjvRcpZ6kL3d3w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=tMGmaw6y; arc=none smtp.client-ip=198.47.23.248
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
	by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 44O5m2rU105333;
	Fri, 24 May 2024 00:48:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1716529682;
	bh=ZYd1faE1iYTixFys7LnnH+BWOHbqOeJMu5f3vjfUKSQ=;
	h=Date:From:To:CC:Subject:References:In-Reply-To;
	b=tMGmaw6yopSTiNhgEyMPCNLxz5ege8yP56UOZAkJeG9MATONCLB7e2q471oK1kTuJ
	 0o+uRYNq9g2QMxdJCppToHAWpGqtk6gCuEUVcUmQ47W8tCN3C0Am/Ki1JPjfNWaFlK
	 XnJZaqmDjOOVrWcA6C4hV19RgT7LWQ8/bFTPNFw0=
Received: from DFLE101.ent.ti.com (dfle101.ent.ti.com [10.64.6.22])
	by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 44O5m2ip012660
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 24 May 2024 00:48:02 -0500
Received: from DFLE103.ent.ti.com (10.64.6.24) by DFLE101.ent.ti.com
 (10.64.6.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 24
 May 2024 00:48:01 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 24 May 2024 00:48:01 -0500
Received: from localhost (uda0133052.dhcp.ti.com [128.247.81.232])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 44O5m1Gs090950;
	Fri, 24 May 2024 00:48:01 -0500
Date: Fri, 24 May 2024 00:48:01 -0500
From: Nishanth Menon <nm@ti.com>
To: Markus Schneider-Pargmann <msp@baylibre.com>
CC: Chandrasekar Ramakrishnan <rcsekar@samsung.com>,
        Marc Kleine-Budde
	<mkl@pengutronix.de>,
        Vincent Mailhol <mailhol.vincent@wanadoo.fr>,
        "David S
 . Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub
 Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Rob Herring
	<robh@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Vignesh Raghavendra <vigneshr@ti.com>, Tero Kristo <kristo@kernel.org>,
        Vibhore Vardhan <vibhore@ti.com>, Kevin
 Hilman <khilman@baylibre.com>,
        Dhruva Gole <d-gole@ti.com>,
        Martin
 =?utf-8?Q?Hundeb=C3=B8ll?= <martin@geanix.com>,
        Simon Horman
	<horms@kernel.org>, <linux-can@vger.kernel.org>,
        <netdev@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH 7/7] arm64: dts: ti: k3-am62p-mcu: Mark mcu_mcan0/1 as
 wakeup-source
Message-ID: <20240524054801.fhcjwtpdpic3tkpe@finlike>
References: <20240523075347.1282395-1-msp@baylibre.com>
 <20240523075347.1282395-8-msp@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240523075347.1282395-8-msp@baylibre.com>
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

On 09:53-20240523, Markus Schneider-Pargmann wrote:
> From: Vibhore Vardhan <vibhore@ti.com>
> 
> mcu_mcan0 and mcu_mcan1 can be wakeup sources for the SoC. Mark them
> accordingly in the devicetree. Based on the patch for AM62a.
> 
> Signed-off-by: Vibhore Vardhan <vibhore@ti.com>
> Signed-off-by: Markus Schneider-Pargmann <msp@baylibre.com>
> ---
>  arch/arm64/boot/dts/ti/k3-am62p-mcu.dtsi | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/ti/k3-am62p-mcu.dtsi b/arch/arm64/boot/dts/ti/k3-am62p-mcu.dtsi
> index b973b550eb9d..e434b258e90c 100644
> --- a/arch/arm64/boot/dts/ti/k3-am62p-mcu.dtsi
> +++ b/arch/arm64/boot/dts/ti/k3-am62p-mcu.dtsi
> @@ -162,6 +162,7 @@ mcu_mcan0: can@4e08000 {
>  		interrupts = <GIC_SPI 26 IRQ_TYPE_LEVEL_HIGH>,
>  			     <GIC_SPI 27 IRQ_TYPE_LEVEL_HIGH>;
>  		interrupt-names = "int0", "int1";
> +		wakeup-source;
>  		status = "disabled";
>  	};
>  
> @@ -177,6 +178,7 @@ mcu_mcan1: can@4e18000 {
>  		interrupts = <GIC_SPI 28 IRQ_TYPE_LEVEL_HIGH>,
>  			     <GIC_SPI 29 IRQ_TYPE_LEVEL_HIGH>;
>  		interrupt-names = "int0", "int1";
> +		wakeup-source;
>  		status = "disabled";
>  	};
>  
> -- 
> 2.43.0
> 

Curious:
https://software-dl.ti.com/tisci/esd/latest/2_tisci_msgs/pm/lpm.html#supported-low-power-modes
Does not seem to call out am62p. Is that an documentation oversight?

what happens to j722s?

-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D

