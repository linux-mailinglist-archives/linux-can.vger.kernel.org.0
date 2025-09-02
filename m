Return-Path: <linux-can+bounces-4422-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CE8DAB40E45
	for <lists+linux-can@lfdr.de>; Tue,  2 Sep 2025 22:00:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 78D6D3A6464
	for <lists+linux-can@lfdr.de>; Tue,  2 Sep 2025 20:00:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE414352068;
	Tue,  2 Sep 2025 20:00:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="hBEgUw2u"
X-Original-To: linux-can@vger.kernel.org
Received: from fllvem-ot04.ext.ti.com (fllvem-ot04.ext.ti.com [198.47.19.246])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2DE5350D58;
	Tue,  2 Sep 2025 19:59:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.246
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756843201; cv=none; b=aVLO1sffH0Utk9X2uPhSHv4AvV0FZaqDw6kNDTbAgp/EhD9Peb3FVdGhWMVGpWPqcXMP5/i8b08R0iG5tXk3+rIh8a98VmWk4wLq+jpxh4dwYg5hM+lXTBUMpxey1zj6Wx7A8eO/44W0be3o6pioxgXTUIT00UO+e/AvhA6IqyI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756843201; c=relaxed/simple;
	bh=K8PqE6yD7VyVJpbq451PthNDx+WFiPWgsV2846fPfes=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:CC:References:
	 In-Reply-To:Content-Type; b=gthMVcL68U18VyvrUI/t0J+1VFIGePeY96KuoJuSILam3YiKtDo9NplbFm4hjQlPCJAsXOn5hkhSsY/i7xueuU1y8RBcUXXGd9kzBCV3yItlf2g062dFpm8/VThU4hJTnLFn5QS9hT+tUyBNmjh7/543SzQYzAC4fqui5JADsZk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=hBEgUw2u; arc=none smtp.client-ip=198.47.19.246
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelvem-sh01.itg.ti.com ([10.180.77.71])
	by fllvem-ot04.ext.ti.com (8.15.2/8.15.2) with ESMTP id 582JxhRU3060822;
	Tue, 2 Sep 2025 14:59:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1756843183;
	bh=PeB7J67e77B/FVOBsTZYzVHCuZ3ynnlku78M2GFf46w=;
	h=Date:From:Subject:To:CC:References:In-Reply-To;
	b=hBEgUw2u5TY4JawQtMAWEIYOO9VdwSOgzIFRsquAhINjD1blO0ZY0ni5wQbmS+zbl
	 2ar4L7JWm/+LQ1lK2/xRyvLboggYKPQSMEPSBvSy3omB/k35YIVsXk4c32t38j/XIB
	 8nQ8DELuEvBC583K6SDXw3fcKJoS7885EXKfJ+tM=
Received: from DFLE105.ent.ti.com (dfle105.ent.ti.com [10.64.6.26])
	by lelvem-sh01.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 582JxhGG2507031
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
	Tue, 2 Sep 2025 14:59:43 -0500
Received: from DFLE113.ent.ti.com (10.64.6.34) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Tue, 2
 Sep 2025 14:59:42 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55 via
 Frontend Transport; Tue, 2 Sep 2025 14:59:42 -0500
Received: from [128.247.81.19] (uda0506412.dhcp.ti.com [128.247.81.19])
	by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 582JxgZ7136329;
	Tue, 2 Sep 2025 14:59:42 -0500
Message-ID: <33a285bc-2fbe-4ff6-ae09-e4c13a098647@ti.com>
Date: Tue, 2 Sep 2025 14:59:42 -0500
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Kendall Willis <k-willis@ti.com>
Subject: Re: [PATCH v9 1/4] dt-bindings: can: m_can: Add wakeup properties
To: Markus Schneider-Pargmann <msp@baylibre.com>,
        Chandrasekar Ramakrishnan
	<rcsekar@samsung.com>,
        Marc Kleine-Budde <mkl@pengutronix.de>, Rob Herring
	<robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
	<conor+dt@kernel.org>
CC: Vishal Mahaveer <vishalm@ti.com>, Kevin Hilman <khilman@baylibre.com>,
        Dhruva Gole <d-gole@ti.com>, Sebin Francis <sebin.francis@ti.com>,
        Akashdeep
 Kaur <a-kaur@ti.com>, Simon Horman <horms@kernel.org>,
        Vincent MAILHOL
	<mailhol.vincent@wanadoo.fr>,
        <linux-can@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <20250820-topic-mcan-wakeup-source-v6-12-v9-0-0ac13f2ddd67@baylibre.com>
 <20250820-topic-mcan-wakeup-source-v6-12-v9-1-0ac13f2ddd67@baylibre.com>
Content-Language: en-US
In-Reply-To: <20250820-topic-mcan-wakeup-source-v6-12-v9-1-0ac13f2ddd67@baylibre.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

On 8/20/25 07:42, Markus Schneider-Pargmann wrote:
> The pins associated with m_can have to have a special configuration to
> be able to wakeup the SoC from some system states. This configuration is
> described in the wakeup pinctrl state while the default state describes
> the default configuration. Also add the sleep state which is already in
> use by some devicetrees.
> 
> Also m_can can be a wakeup-source if capable of wakeup.
> 
> Signed-off-by: Markus Schneider-Pargmann <msp@baylibre.com>
> ---
>   .../devicetree/bindings/net/can/bosch,m_can.yaml   | 25 ++++++++++++++++++++++
>   1 file changed, 25 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/net/can/bosch,m_can.yaml b/Documentation/devicetree/bindings/net/can/bosch,m_can.yaml
> index c4887522e8fe97c3947357b4dbd4ecf20ee8100a..0e00be18a8be681634f25378bb2cdef034dc4e6b 100644
> --- a/Documentation/devicetree/bindings/net/can/bosch,m_can.yaml
> +++ b/Documentation/devicetree/bindings/net/can/bosch,m_can.yaml
> @@ -106,6 +106,26 @@ properties:
>           maximum: 32
>       minItems: 1
>   
> +  pinctrl-0:
> +    description: Default pinctrl state
> +
> +  pinctrl-1:
> +    description: Can be Sleep or Wakeup pinctrl state
> +
> +  pinctrl-2:
> +    description: Can be Sleep or Wakeup pinctrl state

nit: change Sleep and Wakeup to be in quotes, i.e. "wakeup", "sleep"

Other than that, LTGM

Reviewed-by: Kendall Willis <k-willis@ti.com>

> +
> +  pinctrl-names:
> +    description:
> +      When present should contain at least "default" describing the default pin
> +      states. Other states are "sleep" which describes the pinstate when
> +      sleeping and "wakeup" describing the pins if wakeup is enabled.
> +    minItems: 1
> +    items:
> +      - const: default
> +      - const: sleep
> +      - const: wakeup
> +
>     power-domains:
>       description:
>         Power domain provider node and an args specifier containing
> @@ -122,6 +142,11 @@ properties:
>       minItems: 1
>       maxItems: 2
>   
> +  wakeup-source:
> +    $ref: /schemas/types.yaml#/definitions/phandle-array
> +    description:
> +      List of phandles to system idle states in which mcan can wakeup the system.
> +
>   required:
>     - compatible
>     - reg
> 


