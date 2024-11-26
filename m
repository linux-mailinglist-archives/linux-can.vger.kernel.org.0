Return-Path: <linux-can+bounces-2221-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CCACC9D9252
	for <lists+linux-can@lfdr.de>; Tue, 26 Nov 2024 08:19:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 915AA28382D
	for <lists+linux-can@lfdr.de>; Tue, 26 Nov 2024 07:19:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 462231922FB;
	Tue, 26 Nov 2024 07:19:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RG7ZnBH4"
X-Original-To: linux-can@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A6981898FC;
	Tue, 26 Nov 2024 07:19:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732605549; cv=none; b=W8NqpT2FyPgZ4UIw1BUubMBasQqSCyku28ELiO5Pa/+nTMQbjU4OpmSKnzFQq8pn3BqCw3t4S9jVcVYu6bk5ya87p9aek3mz0S4VpUUPKTi3qMxKDPsbjJu5KmVLvPb3fIbkS22cGG2vLZze/29wVANlH/ukd7kvedYF2k1AEfE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732605549; c=relaxed/simple;
	bh=/h87k1FDp1WC2VzUI6S8sjWKocwTaIiJ1ZT69Aei16k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hvFlNy7nOH8SmNTAHgBLxUtmon2pCBVcwhcI0m7QQYI8VKlUnGUTvggJ8f7lGnqiNq73/NhvPZw/47aARnYNZijMkN+tqZdvoRz2m5/tzSOGzj37ZJfGWcAIKEAbQAl5EP7h45Gg+OJYhIxq2H/8GP02MIe0Vvo408tNg6o25X8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RG7ZnBH4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99A12C4CED2;
	Tue, 26 Nov 2024 07:19:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732605548;
	bh=/h87k1FDp1WC2VzUI6S8sjWKocwTaIiJ1ZT69Aei16k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=RG7ZnBH4LTJCfQ9mUNJN180Zjq5tHx7KY2IjU+qmvWBydXBh513L/x12lTxEhqXPx
	 yPkWsZ4p3wQdICvAlp3ax2IO92HcRrNbU8JqDLQmTsfymbRaJr0ls/rU/oRy1Y8j7s
	 9nwgeJapxwrPHjK1YkGwjJDJuS+OwiIccdw+qZRwkeQiv6MKNDsx0CZ+QMMghXOHw4
	 SHTjeHsy3kJGLiQIHRO6UuNI3cT5dUxXmr09kNiyM5fqzM+RVKSapE7lS3R7pey0WE
	 Jp8ZEsD0e9KbQu9mdPUc3FWpiDrAYtSsuC8UdYUZm5AWclxgj+2wpw3uQ6WY4vbEiB
	 DmlKuQvrq+yQA==
Date: Tue, 26 Nov 2024 08:19:04 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Ciprian Costea <ciprianmarian.costea@oss.nxp.com>
Cc: Marc Kleine-Budde <mkl@pengutronix.de>, 
	Vincent Mailhol <mailhol.vincent@wanadoo.fr>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, linux-can@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, NXP S32 Linux <s32@nxp.com>, 
	imx@lists.linux.dev, Christophe Lizzi <clizzi@redhat.com>, 
	Alberto Ruiz <aruizrui@redhat.com>, Enric Balletbo <eballetb@redhat.com>, 
	Frank Li <Frank.Li@nxp.com>
Subject: Re: [PATCH v2 1/3] dt-bindings: can: fsl,flexcan: add S32G2/S32G3
 SoC support
Message-ID: <y2fbsxg4pney2iapzcdooxyz6l3pmw6ms2ddupf637svitelbt@wthu23ld5ryq>
References: <20241125163103.4166207-1-ciprianmarian.costea@oss.nxp.com>
 <20241125163103.4166207-2-ciprianmarian.costea@oss.nxp.com>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241125163103.4166207-2-ciprianmarian.costea@oss.nxp.com>

On Mon, Nov 25, 2024 at 06:31:00PM +0200, Ciprian Costea wrote:
> From: Ciprian Marian Costea <ciprianmarian.costea@oss.nxp.com>
> 
> Add S32G2/S32G3 SoCs compatible strings.
> 
> A particularity for these SoCs is the presence of separate interrupts for
> state change, bus errors, MBs 0-7 and MBs 8-127 respectively.
> 
> Increase maxItems of 'interrupts' to 4 for S32G based SoCs and keep the
> same restriction for other SoCs.
> 
> Also, as part of this commit, move the 'allOf' after the required
> properties to make the documentation easier to read.
> 
> Signed-off-by: Ciprian Marian Costea <ciprianmarian.costea@oss.nxp.com>
> Reviewed-by: Frank Li <Frank.Li@nxp.com>

You made multiple changes afterwards, which invalidated the review. See
submitting-patches which explain what to do in such case.

> ---
>  .../bindings/net/can/fsl,flexcan.yaml         | 46 +++++++++++++++++--
>  1 file changed, 42 insertions(+), 4 deletions(-)

...

>      maxItems: 2
> @@ -136,6 +143,37 @@ required:
>    - reg
>    - interrupts
>  
> +allOf:
> +  - $ref: can-controller.yaml#
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            const: nxp,s32g2-flexcan
> +    then:
> +      properties:
> +        interrupts:
> +          items:
> +            - description:
> +                Message Buffer interrupt for mailboxes 0-7

Keep it in one line.

> +            - description:
> +                Interrupt indicating that the CAN bus went to Buss Off state

s/Interrupt indicating that//
Buss Off state status?

> +            - description:
> +                Interrupt indicating that errors were detected on the CAN bus

Error detection?

> +            - description:
> +                Message Buffer interrupt for mailboxes 8-127 (ored)
> +        interrupt-names:
> +          items:
> +            - const: mb_0-7

Choose one: either underscores or hyphens. Keep it consistent in your
bindings.

> +            - const: state
> +            - const: berr
> +            - const: mb_8-127

Choose one: either underscores or hyphens. Keep it consistent in your
bindings.

> +      required:
> +        - compatible
> +        - reg
> +        - interrupts
> +        - interrupt-names

What happened to "else:"? Why all other devices now have up to 4 interrupts?

Best regards,
Krzysztof


