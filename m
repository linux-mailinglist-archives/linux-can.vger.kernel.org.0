Return-Path: <linux-can+bounces-2123-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 96D4D9D35C0
	for <lists+linux-can@lfdr.de>; Wed, 20 Nov 2024 09:45:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EFAEBB21DD0
	for <lists+linux-can@lfdr.de>; Wed, 20 Nov 2024 08:45:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9173189BAD;
	Wed, 20 Nov 2024 08:45:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NyPTUCv1"
X-Original-To: linux-can@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E20A187844;
	Wed, 20 Nov 2024 08:45:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732092309; cv=none; b=JOm6s4DLU/FoQ2yjnTDEPyU2Nh3occWN8L++OUnVaBbG3nSbho36HI6YhxvJRSoQtIrzyjTBHTpAhg3Ozzsz4joclgVWzKbvFM4/bzfxft/0D7b9p9dB4C3wsG8+Myu5kq7F8o0d9vK0U95pimn7pWoxRqrGneeLxdRftad48OE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732092309; c=relaxed/simple;
	bh=ER8VTQjXlCy4Gtz19zbr9xUxz4zX8GUYwLtW74f+WX8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VLU9f8vRWB1idmzrXBXuJ799k85pItLzFpTBJdFVWAJFoTZnUHeVYWUyaBMpcUK47GXQ88bZ+RptNgHLyuxyZ3UCkikzSOQwE5hFwLPOar5Vf2rjh7Mmk5ae3Hu/6CoouaKn7q+F3+t8DeWJMlJyW+r3rBjyQVH32HMNz8YBMvU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NyPTUCv1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 747CEC4CECD;
	Wed, 20 Nov 2024 08:45:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732092309;
	bh=ER8VTQjXlCy4Gtz19zbr9xUxz4zX8GUYwLtW74f+WX8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=NyPTUCv1MRqBxEaO6k8YrsKQ+xO11VNYo157Fi4abm42iDt2wnakdkXhleOacMJ/G
	 Zg2Z93GUUt37lrKVfJ8EldZ8mbZIni2q//EQpv3TiQ2BUd/a1YoFMxGRzJpLgE3+QX
	 rsVeGttAjMnZrR+fjfqpjc6A+8XZ/h7cUeQXON2gzSQU9rnljltoERAASsRC50i110
	 vUiRxm/oKZK1O+kYf+3m5PqI1k5cZ+fdYpitk8Jtb3WAiLVJkrYNXOzBnq6eBg2hOf
	 1/IQ/v7brumbNUdQ4naF6VS/tpNdUKW1hHLYjZ+U+Z9WwcOlNcHtBxY/OGKCDQQZkW
	 3CrLXDBzqhQUA==
Date: Wed, 20 Nov 2024 09:45:05 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Ciprian Costea <ciprianmarian.costea@oss.nxp.com>
Cc: Marc Kleine-Budde <mkl@pengutronix.de>, 
	Vincent Mailhol <mailhol.vincent@wanadoo.fr>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, linux-can@vger.kernel.org, 
	netdev@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	imx@lists.linux.dev, NXP Linux Team <s32@nxp.com>, 
	Christophe Lizzi <clizzi@redhat.com>, Alberto Ruiz <aruizrui@redhat.com>, 
	Enric Balletbo <eballetb@redhat.com>
Subject: Re: [PATCH 1/3] dt-bindings: can: fsl,flexcan: add S32G2/S32G3 SoC
 support
Message-ID: <o4uiphg4lcmdmvibiheyvqa4zmp3kijn7u3qo5c5mofemqaii7@fdn3h2hspks7>
References: <20241119081053.4175940-1-ciprianmarian.costea@oss.nxp.com>
 <20241119081053.4175940-2-ciprianmarian.costea@oss.nxp.com>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241119081053.4175940-2-ciprianmarian.costea@oss.nxp.com>

On Tue, Nov 19, 2024 at 10:10:51AM +0200, Ciprian Costea wrote:
>    reg:
>      maxItems: 1
> @@ -136,6 +138,23 @@ required:
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
> +          minItems: 4
> +          maxItems: 4

Top level says max is 1. You need to keep there widest constraints.

> +    else:
> +      properties:
> +        interrupts:
> +          maxItems: 1

Best regards,
Krzysztof


