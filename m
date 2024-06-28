Return-Path: <linux-can+bounces-892-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 981EE91C85B
	for <lists+linux-can@lfdr.de>; Fri, 28 Jun 2024 23:44:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4F4951F2664A
	for <lists+linux-can@lfdr.de>; Fri, 28 Jun 2024 21:44:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EBAF80026;
	Fri, 28 Jun 2024 21:41:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N0J0skdv"
X-Original-To: linux-can@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC1FB7F48A;
	Fri, 28 Jun 2024 21:41:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719610904; cv=none; b=dM5FJdBtn0jV6VkNdzqtM0pLBOtfuez2C1CrjbWTuq3i/QJ1Ch1UaPXfuzPnYYM/e5zIY/Cr254JRtxTVcMJMZwKWKlUdMwB+M22hWeCC3L24LvejdAw6EYcA0e6w27gAADP+RbTUkIz65NZiOVfYp3KzA5jB4yR6pDIh8MxjNI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719610904; c=relaxed/simple;
	bh=EaMOHcF4+ZY1s8wbh4ElbToAQrZkbsMN7isSG8r+yCo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SyFLJkIGmMltrIRXklcRZPrFaJjcc2sYxE8YaQRS7OL73g78jKujN/zSuSZSVzADabpyi/Wyuj20JvOEdI4HVe78IX90gyhZyTRzA0LF6ABr1nDAdNnQ6ZKKUkf7pT70WUaezf51U9jnlr+CmKklwok1GQW0lNp9mvnC565yEl0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N0J0skdv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B18DC116B1;
	Fri, 28 Jun 2024 21:41:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719610903;
	bh=EaMOHcF4+ZY1s8wbh4ElbToAQrZkbsMN7isSG8r+yCo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=N0J0skdv0v8hvLu7Z04gLfS3io68IkghmqnQ6az2b76hk32xiEsckZC5pYOgf79GU
	 Ci5XT+EWFWFRSp034PqCSCPeR0vLnvc1gg3hWhW8n0gm8o11jGYW0Hdz0wKuEHCGDs
	 hFUzCLA4rIqWHhF/jEOvpFoheNKf4FI7clViFdZ3+oQ9sr+M8KFwV8QcE9W/3HEpbw
	 QHmVf0xNpgRWkJjXff3CjhW47XdbwxjK2axQ7PZf41p1FxDCXtc4T4sAagLbdfrHo8
	 mo67awh/b0wIiZDV4cJodOldyxbZQ8smg3i+NttuTkQ2W/B30QJjnEWHALvkBCps69
	 /HwO0acDIhUcg==
Date: Fri, 28 Jun 2024 15:41:40 -0600
From: Rob Herring <robh@kernel.org>
To: Frank Li <Frank.Li@nxp.com>
Cc: Marc Kleine-Budde <mkl@pengutronix.de>,
	Vincent Mailhol <mailhol.vincent@wanadoo.fr>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	"open list:CAN NETWORK DRIVERS" <linux-can@vger.kernel.org>,
	"open list:NETWORKING DRIVERS" <netdev@vger.kernel.org>,
	"open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>, imx@lists.linux.dev
Subject: Re: [PATCH 1/1] dt-bindings: can: fsl,flexcan: add can-transceiver
 for fsl,flexcan
Message-ID: <20240628214140.GA255511-robh@kernel.org>
References: <20240625203145.3962165-1-Frank.Li@nxp.com>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240625203145.3962165-1-Frank.Li@nxp.com>

On Tue, Jun 25, 2024 at 04:31:45PM -0400, Frank Li wrote:
> Add 'can-transceiver' children node for fsl,flexcan to allow update
> can-transceiver property.
> 
> Signed-off-by: Frank Li <Frank.Li@nxp.com>
> ---
>  Documentation/devicetree/bindings/net/can/fsl,flexcan.yaml | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/net/can/fsl,flexcan.yaml b/Documentation/devicetree/bindings/net/can/fsl,flexcan.yaml
> index f197d9b516bb2..d003200247b03 100644
> --- a/Documentation/devicetree/bindings/net/can/fsl,flexcan.yaml
> +++ b/Documentation/devicetree/bindings/net/can/fsl,flexcan.yaml
> @@ -80,6 +80,9 @@ properties:
>        node then controller is assumed to be little endian. If this property is
>        present then controller is assumed to be big endian.
>  
> +  can-transceiver:
> +    $ref: can-transceiver.yaml#

       unevaluatedProperties: false

> +
>    fsl,stop-mode:
>      description: |
>        Register bits of stop mode control.
> -- 
> 2.34.1
> 

