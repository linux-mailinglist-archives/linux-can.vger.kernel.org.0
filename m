Return-Path: <linux-can+bounces-2157-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FF4C9D48DD
	for <lists+linux-can@lfdr.de>; Thu, 21 Nov 2024 09:29:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C9DD128344F
	for <lists+linux-can@lfdr.de>; Thu, 21 Nov 2024 08:29:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D5401CB531;
	Thu, 21 Nov 2024 08:29:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PnAQzOn3"
X-Original-To: linux-can@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2803F1CB329;
	Thu, 21 Nov 2024 08:29:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732177752; cv=none; b=JeIJkvRy5xBVmPKRUAb6SMBvYf1lOK1RP9JUU5Fzi+jZFKE+be07HWyks1L0RAv+DAJ2eGXkm4XQhYeP1EL2gAez1TkvAkCPeXFeg1iSJ4WlclfGsScIFkGzFj/Pwe1dbcWaiUpbTrSTrP4rjwMEQUKayvok4qy2ZNoiGotssNU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732177752; c=relaxed/simple;
	bh=jI8NHi8G+Wq7vsn+8sraQFg2O7HBgJMMZWRRb1whbGk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IS9bAZzYRw6agmLj/kuRaqvgmf85WRpG5ngR63eQPcD+bKpx1PWvKgWzD3ZYYxN5xmpzgiMKkkzIyB6Qso3BP/nVXnynP62ch2PMwKXeTEI8Jj1GLYuY++CJTRATWuw5tJoi3gLd9g16GaCptsKVmPcMYVMltUxxCgojTBusNWE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PnAQzOn3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D175CC4CECC;
	Thu, 21 Nov 2024 08:29:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732177751;
	bh=jI8NHi8G+Wq7vsn+8sraQFg2O7HBgJMMZWRRb1whbGk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=PnAQzOn3eltLr61OwJdBkrNCp84VdxjhOaWdJj5jwupNmUAW+fgCxGdVYi1u+4Uf6
	 w8sOx+eYMqedJv3IH2gCsx+oFCmhqf83fEonTvFR2KABkkaoKyMrxZxVeB8SnarRls
	 lSjeeIR60e3P017SBClhSDCT0XlWz2jLT7UHgwvRcI6cqm0ElOcmI9uzssomnkPen+
	 7mxq4usUuT8tUvZxpbE8QmBanM4sSFdvgybqCsKqrVoBV/CJCcoObnZNo57iFedZsl
	 ZDFGRYk5DBdEXxT2OZlZn0eax+v1BITx3xy68frt9dmCSMGDmJWhA38aVqrm5mvxht
	 AqarzOygFaqvA==
Date: Thu, 21 Nov 2024 09:29:08 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Charan Pedumuru <charan.pedumuru@microchip.com>
Cc: Marc Kleine-Budde <mkl@pengutronix.de>, 
	Vincent Mailhol <mailhol.vincent@wanadoo.fr>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Nicolas Ferre <nicolas.ferre@microchip.com>, Alexandre Belloni <alexandre.belloni@bootlin.com>, 
	Claudiu Beznea <claudiu.beznea@tuxon.dev>, Andrew Lunn <andrew+netdev@lunn.ch>, linux-can@vger.kernel.org, 
	netdev@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] dt-bindings: net: can: atmel: Convert to json schema
Message-ID: <ahftyfnreh27z6jyvdf2wwhhp5rcbkydy6afnkct77ppqlko56@5cvw5bmzcjb6>
References: <20241120-can-v3-1-da5bb4f6128d@microchip.com>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241120-can-v3-1-da5bb4f6128d@microchip.com>

On Wed, Nov 20, 2024 at 01:58:08PM +0530, Charan Pedumuru wrote:
> Convert old text based binding to json schema.
> Changes during conversion:
> - Add a fallback for `microchip,sam9x60-can` as it is compatible with the
>   CAN IP core on `atmel,at91sam9x5-can`.
> - Add the required properties `clock` and `clock-names`, which were
>   missing in the original binding.
> - Update examples and include appropriate file directives to resolve
>   errors identified by `dt_binding_check` and `dtbs_check`.

...

> +examples:
> +  - |
> +    #include <dt-bindings/interrupt-controller/irq.h>
> +    #include <dt-bindings/clock/at91.h>
> +    can@f000c000 {
> +          compatible = "atmel,at91sam9263-can";

If there is going to be any resend - fix the indentation: Use 4 spaces
for example indentation.

No need to resend just for this.

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

---

<form letter>
This is an automated instruction, just in case, because many review tags
are being ignored. If you know the process, you can skip it (please do
not feel offended by me posting it here - no bad intentions intended).
If you do not know the process, here is a short explanation:

Please add Acked-by/Reviewed-by/Tested-by tags when posting new
versions, under or above your Signed-off-by tag. Tag is "received", when
provided in a message replied to you on the mailing list. Tools like b4
can help here. However, there's no need to repost patches *only* to add
the tags. The upstream maintainer will do that for tags received on the
version they apply.

https://elixir.bootlin.com/linux/v6.5-rc3/source/Documentation/process/submitting-patches.rst#L577
</form letter>

Best regards,
Krzysztof


