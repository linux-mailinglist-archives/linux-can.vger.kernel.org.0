Return-Path: <linux-can+bounces-1269-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 273CD966A4F
	for <lists+linux-can@lfdr.de>; Fri, 30 Aug 2024 22:17:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D21F51F239E7
	for <lists+linux-can@lfdr.de>; Fri, 30 Aug 2024 20:17:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79EF21BF815;
	Fri, 30 Aug 2024 20:17:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XqvmAzks"
X-Original-To: linux-can@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5191C1BF7F5;
	Fri, 30 Aug 2024 20:17:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725049046; cv=none; b=XSXKKnHnVuB9n+pQIdLMWK6IPQWG2MoXQnR1knTMMO55LSzBfUpTKSc98hk3BPRzXTq2moWwuBexDzkMeb5wSPKaRa8VjoqmzQHIzkRe4hmB79FyoMAHah0NrdYfvZfjnrvLoURhBTnc2Tt5xyALMFe/69tKWwUKQm/oPKscJ+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725049046; c=relaxed/simple;
	bh=xsB/+fHM6pQvLAZfaAyWJzLUHX0vRSD25TrO5Z6iLkQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Y3pKoc31yiE85a24I5z/0ZMb8Y2ij/s9NnbUG8Str30DGCa6p4CPRYQ9sHSZD0tnbKMi6j2NuQWh9zinaKTg8qp0RCt1BHAaMF/fSQe8lXRVfB8O4Hb2yHd7f9UiTsQIzOPgIR8S+MwL1goJ4cJYPJtWCvnyGcmgcW+Vxvm5lZ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XqvmAzks; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ADC17C4CEC6;
	Fri, 30 Aug 2024 20:17:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725049045;
	bh=xsB/+fHM6pQvLAZfaAyWJzLUHX0vRSD25TrO5Z6iLkQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=XqvmAzkssYSV6geulFG9etWLuQte05Ku2iWA0Y2RBXWdaunyNQKB83OgEwNSAS8HT
	 b4KSft93py1EOp/JTE9f45mh/hMhb7J/sIRctpxGvAzx0NbudTnT/8r94KIIcNl98D
	 W5ekufNRkrk4XSWSf2d+Rld+eKjbF0d9aNuCC7qpPcQdoN+LPq6go0NNv6IYClvatT
	 4uyUBXgNpwtuQm5m+qIw+RZSnH1v8IoI4ku0T3fB/49kduMhhJr9vPZAajw9rweQwh
	 pJ1uSymk7HXeeeze8+7Wkasc/Y2ofDegMmhtqtIqW6ITr5qgKZrnf6ntwfxS2D9pxD
	 AGg5MveJxC1jQ==
Date: Fri, 30 Aug 2024 13:17:24 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: netdev@vger.kernel.org, davem@davemloft.net, linux-can@vger.kernel.org,
 kernel@pengutronix.de, Martin Jocic <martin.jocic@kvaser.com>
Subject: Re: [PATCH net 13/13] can: kvaser_pciefd: Enable 64-bit DMA
 addressing
Message-ID: <20240830131724.7c08eac4@kernel.org>
In-Reply-To: <20240829192947.1186760-14-mkl@pengutronix.de>
References: <20240829192947.1186760-1-mkl@pengutronix.de>
	<20240829192947.1186760-14-mkl@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 29 Aug 2024 21:20:46 +0200 Marc Kleine-Budde wrote:
> +	if (IS_ENABLED(CONFIG_ARCH_DMA_ADDR_T_64BIT))
> +		dma_set_mask_and_coherent(&pcie->pci->dev, DMA_BIT_MASK(64));

This IS_ENABLED() is quite unusual. The driver just advertises its
capability of using 64 addressing. If the platform doesn't support
64b DMA addressing and therefore dma_addr_t is narrower, everything
will still work. I could be wrong, but that's how I understand it.

