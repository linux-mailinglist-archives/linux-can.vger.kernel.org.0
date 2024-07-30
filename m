Return-Path: <linux-can+bounces-1066-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3093A941A79
	for <lists+linux-can@lfdr.de>; Tue, 30 Jul 2024 18:44:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E43E4284892
	for <lists+linux-can@lfdr.de>; Tue, 30 Jul 2024 16:44:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFE9E1898E0;
	Tue, 30 Jul 2024 16:44:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CLM52lno"
X-Original-To: linux-can@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87A2818801C;
	Tue, 30 Jul 2024 16:44:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722357847; cv=none; b=EYIaTw88s4RP3iCAsUca0f3r/jBoAYRvW+nS5qr8jCgi6Z5sYlkGdMusBCuIrAzW+xccXsYM1b8zCHrL9QNKZSO0vcHMdz2JBDKX2bdZEINnOm2vmd4k7Y0gzHJHhDm+AxyA1dZ2GWs3kdbSnMxkIg+NSAv+WAv88mRppihnuNM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722357847; c=relaxed/simple;
	bh=Rftd5SMFzgvkrqtKYeOg6P+2kJ52Nckqpi9+qfZgqvc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=efK/WS3/FmIEFOPH7RQNCuXEWF0mpnL+tHHX+AcLjnXJ06nTTM/LFltUklAqI/pA9GCd7qKzFGirN1zeWiH6dlNWd/oEaATVb565fK4jCpYLFOPxIbj2po9nvWHfI64TtoFteN55+LosaRA9Hqr3dZls7qEx6Ya56GJBT0QAIo0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CLM52lno; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BEF2EC32782;
	Tue, 30 Jul 2024 16:44:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722357847;
	bh=Rftd5SMFzgvkrqtKYeOg6P+2kJ52Nckqpi9+qfZgqvc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=CLM52lnozQsI4sXRr0KOts2j9HhXwa/TsStKURYBcCScyOTqEwo8mdBIAXfH6uP+A
	 5lOv8LY9BPSu+BifTimHjr6LBDCDVtkMaSFDT3qDbk26yxtgvb5aadvp191B7qTRxX
	 Bi6CW+eHp0OcxJHeKIvmL7ck2PaX3oefXgD3+1Z5QwscC4HXd/3LyH/3rhGLIZeka5
	 5YB0ISkkCiSPR3WjApCOJ5GqCgPlphKBiYx/cwjwTfxoXAeiyNH12chjCkWylQCn0T
	 8qMm1KxBlF9LN+RqaGbRfYibpVLWf5iPPnfh8G/JuHMPtJXb4fGzOg78zlVh9vugS8
	 go6EvMm6NPVQQ==
Date: Tue, 30 Jul 2024 17:44:01 +0100
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
Subject: Re: [PATCH can-next 12/21] can: rockchip_canfd: add TX PATH
Message-ID: <20240730164401.GD1967603@kernel.org>
References: <20240729-rockchip-canfd-v1-0-fa1250fd6be3@pengutronix.de>
 <20240729-rockchip-canfd-v1-12-fa1250fd6be3@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240729-rockchip-canfd-v1-12-fa1250fd6be3@pengutronix.de>

On Mon, Jul 29, 2024 at 03:05:43PM +0200, Marc Kleine-Budde wrote:
> The IP core has a TX event FIFO. In other IP cores, this type of FIFO
> normally contains the event that a CAN frame has been successfully
> sent. However, the IP core on the rk3568v2 the FIFO also holds events
> of unsuccessful transmission attempts.
> 
> It turned out that the best way to work around this problem is to set
> the IP core to self-receive mode (RXSTX), filter out the self-received
> frames and insert them into the complete TX path.
> 
> Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>

...

> diff --git a/drivers/net/can/rockchip/rockchip_canfd-tx.c b/drivers/net/can/rockchip/rockchip_canfd-tx.c

...

> +void rkcanfd_handle_tx_done_one(struct rkcanfd_priv *priv, const u32 ts,
> +				unsigned int *frame_len_p)
> +{
> +	struct net_device_stats *stats = &priv->ndev->stats;
> +	unsigned int tx_tail;
> +	struct sk_buff *skb;
> +
> +	tx_tail = rkcanfd_get_tx_tail(priv);
> +	skb = priv->can.echo_skb[tx_tail];

nit: skb is set but otherwise unused in this function.

> +	stats->tx_bytes +=
> +		can_rx_offload_get_echo_skb_queue_timestamp(&priv->offload,
> +							    tx_tail, ts,
> +							    frame_len_p);
> +	stats->tx_packets++;
> +}

...

