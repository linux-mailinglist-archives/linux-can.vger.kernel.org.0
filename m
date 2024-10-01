Return-Path: <linux-can+bounces-1584-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8371F98BAB0
	for <lists+linux-can@lfdr.de>; Tue,  1 Oct 2024 13:12:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B4B151C219CD
	for <lists+linux-can@lfdr.de>; Tue,  1 Oct 2024 11:12:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6910C1BF325;
	Tue,  1 Oct 2024 11:12:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BxO+YUqS"
X-Original-To: linux-can@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34FDD1BE86E;
	Tue,  1 Oct 2024 11:12:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727781161; cv=none; b=QBoIu9oKAmr3KBaSKqqWSBB+yJhaBY8p1HZrphXIToJN2xOMD7tKVZzjxVKAjeA78sw9ATDGwIe6PTxIeiBw1b81XU5zh9oPvcA9uJvCngIWESCI+SwDLV1isYmOtYvNqy7nIWp60kmVqCGwWuihPxaQ7n80+P+HDB7Cwedhkro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727781161; c=relaxed/simple;
	bh=/CqrtmQd2otdHuRtLOQxMjARIajoRU7qVi8NhtAP1H8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UI9BqF8nw2/A2F7CJoIWxPRjjUneS5+JOGyheLEp5h8grtKgeJm31eW/7URwT7XEBv7Dq9CG9rqV1JItexNoqsGrD/Lf/aDQ5MEQfpK/PNljY4mbpbi0tRt+Is13nmYbCbEXsUo6+Ck31O0qXLadHWgXMKDO9k+HIvaQaXTCc+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BxO+YUqS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D7FEC4CEC6;
	Tue,  1 Oct 2024 11:12:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727781161;
	bh=/CqrtmQd2otdHuRtLOQxMjARIajoRU7qVi8NhtAP1H8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=BxO+YUqSMto0VOZyAq+3R4b9mGnY0O0hBSIog+atyRHSElsEpXU/DGN8JYC4nM621
	 vnfNKxwsdptwzzzNKSf35WUcVZndUabda+pQ8cj7s7W8P9syyVGbj/QPPtvqALFLdH
	 /fVCqjlDiRFKDQXb3RX2zkhWVg2Rdats4JPv7WTROUEBaJKYTBVUtb90yRlDAXOooD
	 N9P2wwB7xw5ekWMk6yNP1GY5992KJRvbsEuQUSnmwIE8Ifl6ufE1kteHfukAWcH7/k
	 vOp0Zk7+r7GrC9W18VqUrC0Bk6j/hh3+CG4qwFB2iwe9CILuSizDGJZQefcjpZyeeL
	 NJn1kGTRpnbig==
Date: Tue, 1 Oct 2024 12:12:36 +0100
From: Simon Horman <horms@kernel.org>
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: Chandrasekar Ramakrishnan <rcsekar@samsung.com>,
	Vincent Mailhol <mailhol.vincent@wanadoo.fr>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Tony Lindgren <tony@atomide.com>, Judith Mendez <jm@ti.com>,
	Markus Schneider-Pargmann <msp@baylibre.com>,
	linux-can@vger.kernel.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, kernel@pengutronix.de
Subject: Re: [PATCH] can: m_can: m_can_close(): don't call free_irq() for
 IRQ-less devices
Message-ID: <20241001111236.GA1352901@kernel.org>
References: <20240930-m_can-cleanups-v1-1-001c579cdee4@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240930-m_can-cleanups-v1-1-001c579cdee4@pengutronix.de>

On Mon, Sep 30, 2024 at 07:45:57PM +0200, Marc Kleine-Budde wrote:
> In commit b382380c0d2d ("can: m_can: Add hrtimer to generate software
> interrupt") support for IRQ-less devices was added. Instead of an
> interrupt, the interrupt routine is called by a hrtimer-based polling
> loop.
> 
> That patch forgot to change free_irq() to be only called for devices
> with IRQs. Fix this, by calling free_irq() conditionally only if an
> IRQ is available for the device (and thus has been requested
> previously).
> 
> Fixes: b382380c0d2d ("can: m_can: Add hrtimer to generate software interrupt")
> Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>

Reviewed-by: Simon Horman <horms@kernel.org>


