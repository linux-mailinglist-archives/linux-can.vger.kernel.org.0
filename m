Return-Path: <linux-can+bounces-1067-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D73694205A
	for <lists+linux-can@lfdr.de>; Tue, 30 Jul 2024 21:10:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BBB191F24E8E
	for <lists+linux-can@lfdr.de>; Tue, 30 Jul 2024 19:10:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42C0A18B482;
	Tue, 30 Jul 2024 19:10:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tymP8zIv"
X-Original-To: linux-can@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E74718A6C8;
	Tue, 30 Jul 2024 19:10:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722366641; cv=none; b=Loh9E3bC9cCslPOrFyaqgE1SWpSZUL1pwv3gd/xspGPgQfbWtNSrRHOs2lv4+m0laR+gLpcLeif4NkqW7NQGv9uZwIOXWY0/oip+nkcaLgK0/47AfgYenOpbGPVW1/CFeYk3QxiSQhJ6/a63MVW6PZ52z/3+qBreTaHYXQgIje0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722366641; c=relaxed/simple;
	bh=ZA62L/1AWmpvq2gPcEA68cAp/TI3YINGoR9uR6ivx68=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZT7n8BzDbeEJMQ8FfF4K5PrWWsak2ngDJKhCMvMc/CwJLomLPbtqEy0cW9Be2ok2CRMiT0lZ5V9cXAwHsYQyvE2wGSNdEFpZXfUXzm8j1ZrlX5n7sYHrYEr5yFUO/lcR1H4wcDhKNiD//AM6KDM0Utma0EC4K0SiQTX9ZGN6jPc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tymP8zIv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4CB6AC32782;
	Tue, 30 Jul 2024 19:10:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722366640;
	bh=ZA62L/1AWmpvq2gPcEA68cAp/TI3YINGoR9uR6ivx68=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=tymP8zIvoylkYnhSwX3x/jkHNeWAVLplfFzyEYfGvKgbRKe9H1/FJ8LysRKuhnCH2
	 vSKeGmTqn33j48lbZAX5uCbqCkm0m2RGsAqy5v79dmEPGniCarzxhFvRZAaVZth/O6
	 3v8HN7jgxcfk/MUuvRJzhRpbjkSkL/v4Xm3JzW7VyfmM6hwGNg/diyTXDmj+cAbpMb
	 oQ/hzUYlrqAnGOtDy7ZutQIvctBcm23XOb1F5eBlQ4Qliow2kVpqu5Iat2cdr0yAXV
	 UP59Vb/NaVQFYGwjyaAJFQxxz+Ws9xCQ7i6ny4nOv7DAn3IvuMqcYGEUTY7LJdgBV8
	 tX/U15lpvN9Yg==
Date: Tue, 30 Jul 2024 13:10:39 -0600
From: Rob Herring <robh@kernel.org>
To: Markus Schneider-Pargmann <msp@baylibre.com>
Cc: Chandrasekar Ramakrishnan <rcsekar@samsung.com>,
	Marc Kleine-Budde <mkl@pengutronix.de>,
	Vincent Mailhol <mailhol.vincent@wanadoo.fr>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Nishanth Menon <nm@ti.com>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Tero Kristo <kristo@kernel.org>,
	Martin =?iso-8859-1?Q?Hundeb=F8ll?= <martin@geanix.com>,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	Michal Kubiak <michal.kubiak@intel.com>,
	Vibhore Vardhan <vibhore@ti.com>,
	Kevin Hilman <khilman@baylibre.com>, Dhruva Gole <d-gole@ti.com>,
	Conor Dooley <conor@kernel.org>, linux-can@vger.kernel.org,
	netdev@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2 1/7] dt-bindings: can: m_can: Add wakeup properties
Message-ID: <20240730191039.GA1959067-robh@kernel.org>
References: <20240729074135.3850634-1-msp@baylibre.com>
 <20240729074135.3850634-2-msp@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240729074135.3850634-2-msp@baylibre.com>

On Mon, Jul 29, 2024 at 09:41:29AM +0200, Markus Schneider-Pargmann wrote:
> m_can can be a wakeup source on some devices. Especially on some of the
> am62* SoCs pins, connected to m_can in the mcu, can be used to wakeup
> the SoC.
> 
> The wakeup-source property defines on which devices m_can can be used
> for wakeup.
> 
> The pins associated with m_can have to have a special configuration to
> be able to wakeup the SoC. This configuration is described in the wakeup
> pinctrl state while the default state describes the default
> configuration.
> 
> Signed-off-by: Markus Schneider-Pargmann <msp@baylibre.com>
> ---
>  .../bindings/net/can/bosch,m_can.yaml         | 20 +++++++++++++++++++
>  1 file changed, 20 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/net/can/bosch,m_can.yaml b/Documentation/devicetree/bindings/net/can/bosch,m_can.yaml
> index c4887522e8fe..ef63f6b8455d 100644
> --- a/Documentation/devicetree/bindings/net/can/bosch,m_can.yaml
> +++ b/Documentation/devicetree/bindings/net/can/bosch,m_can.yaml
> @@ -106,6 +106,22 @@ properties:
>          maximum: 32
>      minItems: 1
>  
> +  pinctrl-0:
> +    description: Default pinctrl state
> +
> +  pinctrl-1:
> +    description: Wakeup pinctrl state
> +
> +  pinctrl-names:
> +    description:
> +      When present should contain at least "default" describing the default pin
> +      states. The second state called "wakeup" describes the pins in their
> +      wakeup configuration required to exit sleep states.
> +    minItems: 1
> +    items:
> +      - const: default
> +      - const: wakeup
> +
>    power-domains:
>      description:
>        Power domain provider node and an args specifier containing
> @@ -122,6 +138,10 @@ properties:
>      minItems: 1
>      maxItems: 2
>  
> +  wakeup-source:
> +    $ref: /schemas/types.yaml#/definitions/flag

I thought we had a common schema defining the type, but we don't. I'm 
going to add it now. So just need:

wakeup-source: true

> +    description: This device is capable to wakeup the SoC.
> +
>  required:
>    - compatible
>    - reg
> -- 
> 2.45.2
> 

