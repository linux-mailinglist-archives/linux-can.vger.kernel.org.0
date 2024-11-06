Return-Path: <linux-can+bounces-1915-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 921FD9BF161
	for <lists+linux-can@lfdr.de>; Wed,  6 Nov 2024 16:17:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4653C1F227D6
	for <lists+linux-can@lfdr.de>; Wed,  6 Nov 2024 15:17:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A17B2036F0;
	Wed,  6 Nov 2024 15:17:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UTiVV26D"
X-Original-To: linux-can@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E72622036E2;
	Wed,  6 Nov 2024 15:17:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730906239; cv=none; b=CFdOEOjhTBAEV1gRDmPT1GC+TEyb+wLwx2hNQAl8DTqj7YOPCNuvRZC/QnbgFtgRA22Y1WFwc7GN/A0kKBFHnXw16hL5pi3bjE1JzfTbRAk0y9sB7fKeBRAnuo8JzQD1Rc2BJPG4rjoCpU9pPdysHp98Mf6JjijXf00VyfuRqpU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730906239; c=relaxed/simple;
	bh=C83+cS1FmxFeYWO4grdtw/TcIlDardzYddF7qf2i1sY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dW3XnyJdThfXzRUXK5Capmz0Lr1302JqHdkWLKxMfqCeiglrOuZQsb5NKYLhDsqEzEVlycqRtJyQ/bNCGk1AOSDiwI9RhCno2AcitZM//GYJtbSJ3i2n5qnVhOwKB51m4lG4MDFuUCnCjWW7l4N/zA/Ox2KvBsZQ2pLu9wcH5cI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UTiVV26D; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C63FFC4CEC6;
	Wed,  6 Nov 2024 15:17:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730906238;
	bh=C83+cS1FmxFeYWO4grdtw/TcIlDardzYddF7qf2i1sY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=UTiVV26DrXcC45caqLHhEMxU5TiEn317mvWJ7DfW+oTrT2FnLowY9e3jA8GcfJRFY
	 dHBi4abr2dT5J8VsZRZxUoxLEz9kUEhgGxqT1iZ/wa0egKJZqQWLbOnN4cd4/52rmz
	 7AfwUOaPUEHCV680Mx8SLb5as7x23TWPtPRVJ6CKFoL+FPtKpYrZvQH5guDp++/pbW
	 myMU1fCXa9jcSWsAFRofcUdf3AZB5Fp72tBmBRcNCfUQNrTWeKHfypt4LUwb0GE4tt
	 gma2EpI3KYVpQ6brHGU6U1awxLQLyco5HCZUdAP2cfNuqbEOMzUNit7Abafso4hIWm
	 tf8zNAieC2xrw==
Date: Wed, 6 Nov 2024 15:17:14 +0000
From: Simon Horman <horms@kernel.org>
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Thomas Kopp <thomas.kopp@microchip.com>,
	Vincent Mailhol <mailhol.vincent@wanadoo.fr>,
	Sven Schuchmann <schuchmann@schleissheimer.de>,
	linux-can@vger.kernel.org, kernel@pengutronix.de,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH can v3] can: mcp251xfd: mcp251xfd_get_tef_len(): fix
 length calculation
Message-ID: <20241106151714.GR4507@kernel.org>
References: <20241104-mcp251xfd-fix-length-calculation-v3-1-608b6e7e2197@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241104-mcp251xfd-fix-length-calculation-v3-1-608b6e7e2197@pengutronix.de>

On Mon, Nov 04, 2024 at 05:42:40PM +0100, Marc Kleine-Budde wrote:
> Commit b8e0ddd36ce9 ("can: mcp251xfd: tef: prepare to workaround
> broken TEF FIFO tail index erratum") introduced
> mcp251xfd_get_tef_len() to get the number of unhandled transmit events
> from the Transmit Event FIFO (TEF).
> 
> As the TEF has no head pointer, the driver uses the TX FIFO's tail
> pointer instead, assuming that send frames are completed. However the
> check for the TEF being full was not correct. This leads to the driver
> stop working if the TEF is full.
> 
> Fix the TEF full check by assuming that if, from the driver's point of
> view, there are no free TX buffers in the chip and the TX FIFO is
> empty, all messages must have been sent and the TEF must therefore be
> full.
> 
> Reported-by: Sven Schuchmann <schuchmann@schleissheimer.de>
> Closes: https://patch.msgid.link/FR3P281MB155216711EFF900AD9791B7ED9692@FR3P281MB1552.DEUP281.PROD.OUTLOOK.COM
> Fixes: b8e0ddd36ce9 ("can: mcp251xfd: tef: prepare to workaround broken TEF FIFO tail index erratum")
> Tested-by: Sven Schuchmann <schuchmann@schleissheimer.de>
> Cc: stable@vger.kernel.org
> Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>

Reviewed-by: Simon Horman <horms@kernel.org>

...

