Return-Path: <linux-can+bounces-1858-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 37EF69B8C45
	for <lists+linux-can@lfdr.de>; Fri,  1 Nov 2024 08:47:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F20062847AE
	for <lists+linux-can@lfdr.de>; Fri,  1 Nov 2024 07:47:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41323158D94;
	Fri,  1 Nov 2024 07:46:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cQLliR2d"
X-Original-To: linux-can@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10B55155C87;
	Fri,  1 Nov 2024 07:46:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730447207; cv=none; b=nSDLOfoNqkn//XeDJYugaMMuF8aJNi0hEjvvCDCPRLP9fGInN+y1SuTDEUlYhyWRNyNCMujJZLVYGtuuJ+mtj4vlTaCatVUr0oDIzbXRmT+ponbgd7zwQnDUS1Z3qR3ortGARrfO5LsWSWjk5ovsDQrRFpGwAZSxZ7KTTHcZuX4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730447207; c=relaxed/simple;
	bh=HOGO6qnfTi6JeliGEIs8QzEcsFSvN/2bdjhgjAZvHLM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=R9lB7d4CY/eerj0bC7z/UQvYdvwEg4fYD/wybUJ8Ouev/i/yr9SXGSZNACsPYzJ/PpIIzdxwXC9nKmN2WH++yDK9trsNALckCdiKWLPxgbOj+Rm0eJNj5sdw145QfQeXDMrnK5ywDV03e2mehlmHxSSkIP+gDkkel+EKi43wihM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cQLliR2d; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BEF8BC4CECF;
	Fri,  1 Nov 2024 07:46:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730447206;
	bh=HOGO6qnfTi6JeliGEIs8QzEcsFSvN/2bdjhgjAZvHLM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=cQLliR2d2YQkggyQsj2XFHTe/e9vkbOD4wOvXiXtAHe20hwPbzC4F0hc9IUgIyEsn
	 czbDnjfXeR2W0g+eHpont3ihfhdiwhdxzLC7aEBv6EwHv9Zu0nXsSosvnBNYtFgDei
	 XIOCCGrRxVKvodCPBefKbMz0TtT5lO90cszxQicii83mmy5tQ8ufz88h/d2zsO/P9i
	 BQwDRBK/9MrSJiPmF79Ldnsdq/dg4QzL0pXKbx1/abg0UPpMXHsCZgXcVPNRQP3ICd
	 ri9r9hMmI4UDCAubrQoaapVntxdbrT1Qoo4nobzgdjkSCHPvKs4xSzsd9mu3Q7wkcs
	 8p1TKuF/+xcqQ==
Date: Fri, 1 Nov 2024 08:46:42 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Sean Nyekjaer <sean@geanix.com>
Cc: Marc Kleine-Budde <mkl@pengutronix.de>, 
	Vincent Mailhol <mailhol.vincent@wanadoo.fr>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, linux-can@vger.kernel.org, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH 2/2] dt-bindings: can: tcan4x5x: Document the
 ti,nwkrq-voltage-sel option
Message-ID: <apzh3ynzap6ibnrzw7tesnk2iyazeoixg5ah5j4oujtpbcvy7l@bae7nt4ofo6a>
References: <20241031-tcan-wkrqv-v1-0-823dbd12fe4a@geanix.com>
 <20241031-tcan-wkrqv-v1-2-823dbd12fe4a@geanix.com>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241031-tcan-wkrqv-v1-2-823dbd12fe4a@geanix.com>

On Thu, Oct 31, 2024 at 02:24:22PM +0100, Sean Nyekjaer wrote:
> nWKRQ supports an output voltage of either the internal reference voltage
> (3.6V) or the reference voltage of the digital interface 0 - 6V.
> Add the devicetree option ti,nwkrq-voltage-sel to be able to select
> between them.
> 
> Signed-off-by: Sean Nyekjaer <sean@geanix.com>
> ---

Please convert the bindings first to DT schema and only then add new
properties.

Best regards,
Krzysztof


