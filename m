Return-Path: <linux-can+bounces-1064-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C9046941AA2
	for <lists+linux-can@lfdr.de>; Tue, 30 Jul 2024 18:45:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CB7B1B26B68
	for <lists+linux-can@lfdr.de>; Tue, 30 Jul 2024 16:34:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B522E183CDA;
	Tue, 30 Jul 2024 16:34:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M/dYvO4R"
X-Original-To: linux-can@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 868CC148848;
	Tue, 30 Jul 2024 16:34:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722357285; cv=none; b=VIBkr1Eq3Hh+cSBqKtKdBj6VZZDjLbJ+FAkqqJgmA+dTt7cVwxe+UYR5hvWyc4Cl//m2CO2+otUoAa1DqaOtJeTT+jtgYp1oj5bNy+7tI6nuGrWBMby6F2RJRr23LVMVPlEzzbXTAnMPvNGnqfBCmo2TvOid1dbMLk6m2CWYylE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722357285; c=relaxed/simple;
	bh=G9ikuJcjOM6lRnDGx2+KjEI9uk3Qo6wAMBrn7JW8/PE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KXNAd3akTZ0pZm/2zznTFKQqoKwbthyzdToTNT+VnngwObkFH5Ykr3MWD/WZQNTmZMIlyfziJJdU5n2KNbJgtlo4bIYr8pv8j1EUdgRb1CIiprcAzR7Zy5bpMYftghDWKh2n7M6ay0dUOwu+awL5JbYTsjnTmh2XA+MVOvuqIJI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M/dYvO4R; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B117FC4AF0E;
	Tue, 30 Jul 2024 16:34:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722357285;
	bh=G9ikuJcjOM6lRnDGx2+KjEI9uk3Qo6wAMBrn7JW8/PE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=M/dYvO4Rak/GvwbHbP3XBA2GKvEbVfxJ5RPGDOdkIptWPRqt3iXNcrh4/pzOuizhj
	 T/po1HWUoYEFqatwSb4TNjEVkwb16i5vYihnYXumXfzZnsfH/tStBUThLD3OCa2oH/
	 8mv6OI2HBE04g0m5sKGSHGT57781NMXDLaQMVxf2CoejN+TLqq6HETcXUcp5wGmnBs
	 3bZQbn+e8reB6gXe1c6snRkM2dkYJL/T5bPyi3zGMLIuvjRoULxjDaRAnfYq4P9yaq
	 sq5Y/DmiqWiE9PoKLTWh86ZACxEYtc05gt5a3rWf28ReYCkRHabDs5kVQ0JhwWC3mQ
	 uu/l97QrByyXQ==
Date: Tue, 30 Jul 2024 17:34:39 +0100
From: Simon Horman <horms@kernel.org>
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: kernel@pengutronix.de, Vincent Mailhol <mailhol.vincent@wanadoo.fr>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Heiko Stuebner <heiko@sntech.de>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Elaine Zhang <zhangqing@rock-chips.com>,
	David Jander <david.jander@protonic.nl>, linux-can@vger.kernel.org,
	netdev@vger.kernel.org, devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH can-next 04/21] can: rockchip_canfd: add driver for
 Rockchip CAN-FD controller
Message-ID: <20240730163439.GA1967603@kernel.org>
References: <20240729-rockchip-canfd-v1-0-fa1250fd6be3@pengutronix.de>
 <20240729-rockchip-canfd-v1-4-fa1250fd6be3@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240729-rockchip-canfd-v1-4-fa1250fd6be3@pengutronix.de>

On Mon, Jul 29, 2024 at 03:05:35PM +0200, Marc Kleine-Budde wrote:
> Add driver for the Rockchip CAN-FD controller.
> 
> The IP core on the rk3568v2 SoC has 12 documented errata. Corrections
> for these errata will be added in the upcoming patches.
> 
> Since several workarounds are required for the TX path, only add the
> base driver that only implements the RX path.
> 
> Although the RX path implements CAN-FD support, it's not activated in
> ctrlmode_supported, as the IP core in the rk3568v2 has problems with
> receiving or sending certain CAN-FD frames.
> 
> Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>

...

> +static void rkcanfd_get_berr_counter_raw(struct rkcanfd_priv *priv,
> +					 struct can_berr_counter *bec)
> +{
> +	struct can_berr_counter bec_raw;
> +
> +	bec->rxerr = rkcanfd_read(priv, RKCANFD_REG_RXERRORCNT);
> +	bec->txerr = rkcanfd_read(priv, RKCANFD_REG_TXERRORCNT);
> +	bec_raw = *bec;

nit: bec_raw is assigned but otherwise unused
     although this is addressed in patch 15 of this series.

> +}

...

