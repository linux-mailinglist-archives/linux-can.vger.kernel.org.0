Return-Path: <linux-can+bounces-3865-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C1663ADFACB
	for <lists+linux-can@lfdr.de>; Thu, 19 Jun 2025 03:38:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 783823B1C3F
	for <lists+linux-can@lfdr.de>; Thu, 19 Jun 2025 01:38:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA80F199EBB;
	Thu, 19 Jun 2025 01:38:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="if0kISzx"
X-Original-To: linux-can@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9194F191F98;
	Thu, 19 Jun 2025 01:38:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750297108; cv=none; b=Sx96+ws7cJgKYPQk67o+kq5OTeC4stXCCkuuk7WuqPZ/RZ00MTgl2dyX9pXJMPPmONJ+6EzdFgIBxIn3qTBUYuVEM8XW9wNZoECLTLfT6M2Wm4MYpInZyNZmiXDw14mtkman8n8Ki65ygVghrOnC5RTU0dNXIsN25gy3zULS+64=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750297108; c=relaxed/simple;
	bh=8dqK0X/xgEMesnGwJEtko5EKdKI13uY4kwD97NGPZ50=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SYxgTUcT2EasuAk25WUySn/F25kFXgyr9xiTPmWNEeNtwTUk6TXJiYeBzL8/enKGRPNFTxlXM6DtVT81q+/5yKmuzD2dsbWzf1uWWHfroJOPh3NNsr8AY9Vrdyam00MSmaO1DbV1F0PDjdrlWqcOdBdkF2nQ4XWVWDpJjJroIHY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=if0kISzx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D850DC4CEE7;
	Thu, 19 Jun 2025 01:38:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750297108;
	bh=8dqK0X/xgEMesnGwJEtko5EKdKI13uY4kwD97NGPZ50=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=if0kISzxi8m4sJUodAV5mRPn3XKw+lYLvLHw015V6gYFYWgaEd61AXMkRI31fgycq
	 Xi2vJkr3hTBwJVrB1MZc2udnDOjQeq+Z0wyHg1yDNzXJSj6fLkdWz3oeTjpdtRIR6i
	 FcTgVG7r7VzGXMbqlyB+NjWWP6wkPCf1o7494WILHFYOzIOZnWeDSsVlTsNMa7ieSq
	 6JzwOlfcNy+6fKQuHLrx8l9CRAynTdsS5tsY9c4HESWoV7PaXSI1qQA6KlqLDPZJlM
	 G1C643OTTpaIcXNvggRdBrn/ah6CAoMCNDgz7bCXkbJtA59nmrFcV9i55yTyKt4mTP
	 59YSJbGMw6TAA==
Date: Wed, 18 Jun 2025 18:38:27 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Marc Kleine-Budde <mkl@pengutronix.de>, Geert Uytterhoeven
 <geert+renesas@glider.be>
Cc: netdev@vger.kernel.org, davem@davemloft.net, linux-can@vger.kernel.org,
 kernel@pengutronix.de, Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Subject: Re: [PATCH net-next 06/10] can: rcar_canfd: Repurpose f_dcfg base
 for other registers
Message-ID: <20250618183827.5bebca8f@kernel.org>
In-Reply-To: <20250618092336.2175168-7-mkl@pengutronix.de>
References: <20250618092336.2175168-1-mkl@pengutronix.de>
	<20250618092336.2175168-7-mkl@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 18 Jun 2025 11:20:00 +0200 Marc Kleine-Budde wrote:
> +static inline unsigned int rcar_canfd_f_dcfg(struct rcar_canfd_global *gpriv,
> +					     unsigned int ch)
> +{
> +	return gpriv->info->regs->coffset + 0x00 + 0x20 * ch;
> +}
> +
> +static inline unsigned int rcar_canfd_f_cfdcfg(struct rcar_canfd_global *gpriv,
> +					       unsigned int ch)
> +{
> +	return gpriv->info->regs->coffset + 0x04 + 0x20 * ch;
> +}
> +
> +static inline unsigned int rcar_canfd_f_cfdctr(struct rcar_canfd_global *gpriv,
> +					       unsigned int ch)
> +{
> +	return gpriv->info->regs->coffset + 0x08 + 0x20 * ch;
> +}
> +
> +static inline unsigned int rcar_canfd_f_cfdsts(struct rcar_canfd_global *gpriv,
> +					       unsigned int ch)
> +{
> +	return gpriv->info->regs->coffset + 0x0c + 0x20 * ch;
> +}
> +
> +static inline unsigned int rcar_canfd_f_cfdcrc(struct rcar_canfd_global *gpriv,
> +					       unsigned int ch)
> +{
> +	return gpriv->info->regs->coffset + 0x10 + 0x20 * ch;
> +}

clang is no longer fooled by static inline, it identifies that 4 out of
these functions are never called. I think one ends up getting used in
patch 10 (just looking at warning counts), but the other 3 remain dead
code. Geert, do you have a strong attachment to having all helpers
defined or can we trim this, please?

