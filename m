Return-Path: <linux-can+bounces-1912-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 04AFD9BF005
	for <lists+linux-can@lfdr.de>; Wed,  6 Nov 2024 15:24:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 802B1B21AF8
	for <lists+linux-can@lfdr.de>; Wed,  6 Nov 2024 14:24:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 315A22010E5;
	Wed,  6 Nov 2024 14:24:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iNmLl3Ng"
X-Original-To: linux-can@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEDB11D63DF;
	Wed,  6 Nov 2024 14:24:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730903048; cv=none; b=YFCtfRN93xpDM7e5DYWcM6fGc9QHrVFUn7QknGAOHO87H613btTj3aJfYZ5FT7MNf+O/C6nJfOV8OXz9+Aw9mpRmfyEiUSyAyDdJsd6zz7J6y9qbK/+9LLFGZ6rkxQ0Q0T1Io7FDO5s1JWmKjoUiDYIj2iNw0HniYRXx24rebYM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730903048; c=relaxed/simple;
	bh=rGo5g7F9dZ0f0VRnQjTGEr2ZVMLzrCfUAhoUxgHjjkA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CsWg7AZQq3HoaaPBORo4g73QDIwwj0kQBv5voQWdTTcEYPWwhW1szRpByatqmFf0T6kZ7NZyFGQsI2EmbJkH4vqSOUKnFAjDn3D8QZKCEQLafTBOAJfKb8aBuuYO24jjTQlXGkYvOOJzPXjG4ctJy0u4v9hOewfRCAdGjmhjOj4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iNmLl3Ng; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E3D57C4CEC6;
	Wed,  6 Nov 2024 14:24:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730903047;
	bh=rGo5g7F9dZ0f0VRnQjTGEr2ZVMLzrCfUAhoUxgHjjkA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=iNmLl3Nga5QTvYt67YtPDTTkUMvHpj8xd3DyOmIMTeArU3t3Q858OTr/D95CMdI+z
	 4i2PLT+axjK2dKy/3Xbm1yeKssN6VHBpaNSK53amsFYDdzUExVddC59vsFzCLahdSL
	 X4skzyPyXQ+8jz8Z9sbZ25xY+V9yva7jLSlh1eWQxNtrm7U6b9a6IB3fqCG1Flcm3q
	 /FeqDPxU5TPxERXJ70u5qBFM7QI66GBDwxs/RJSACKygv5jGFbljl9TYk/YKqKS42i
	 kceTgUucHLXEseURaEhHyD6s7MygoMJeKjcy7/HbY128e6Nmal0sHyhRGw7nILTDf3
	 OHWBlie7Bbkng==
Date: Wed, 6 Nov 2024 15:24:04 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Sean Nyekjaer <sean@geanix.com>
Cc: Marc Kleine-Budde <mkl@pengutronix.de>, 
	Vincent Mailhol <mailhol.vincent@wanadoo.fr>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, linux-can@vger.kernel.org, 
	netdev@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] dt-bindings: can: convert tcan4x5x.txt to DT schema
Message-ID: <kfcs5hhpkjustyfxxjeecvyw5dbqaqkupppionovdqwyewwdcd@sodle7cc6yv6>
References: <20241105-convert-tcan-v2-1-4b320f3fcf99@geanix.com>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241105-convert-tcan-v2-1-4b320f3fcf99@geanix.com>

On Tue, Nov 05, 2024 at 03:24:34PM +0100, Sean Nyekjaer wrote:
> +  device-wake-gpios:
> +    description:
> +      Wake up GPIO to wake up the TCAN device.
> +      Not available with tcan4552/4553.
> +    maxItems: 1
> +
> +  bosch,mram-cfg:

Last time I wrote:
"You need to mention all changes done to the binding in the commit msg."

Then I wrote again:
"Yeah, CAREFULLY [read][//this was missing, added now] previous review
and respond to all comments or implement all of them (or any
combination). If you leave one comment ignored, it will mean reviewer
has to do same work twice. That's very discouraging and wasteful of my
time."

Then I wrote:
"Where? I pointed out that this is a change. I cannot find it...."

So we are back at the same spot but I waste much more time to respond
and repeat the same.

You must address all comments: either respond, fix or ask for
clarifications. You cannot leave anything ignored.

I am not going to review the rest.

Best regards,
Krzysztof


