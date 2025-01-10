Return-Path: <linux-can+bounces-2590-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 42F80A09148
	for <lists+linux-can@lfdr.de>; Fri, 10 Jan 2025 13:59:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5F1CD16A10D
	for <lists+linux-can@lfdr.de>; Fri, 10 Jan 2025 12:58:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A33F720E710;
	Fri, 10 Jan 2025 12:58:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A7JLgsx+"
X-Original-To: linux-can@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C86C20DD4D;
	Fri, 10 Jan 2025 12:58:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736513887; cv=none; b=A5yxqx/ShIQ3r247CjCuuCzQ+cYYmF4RJT7IBV/2ig3UYyvpwo4ROJuutkXQYe8Hnk0jAk992NkyByNpNqRAV6c/plm57/pzIJ8glz3ph2bDfSgdWpWJu38HrAFafhQ52PpLPGyTp3LR1onXrDo4NP/22x0HG82ip6VGElimZrY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736513887; c=relaxed/simple;
	bh=e3L/+WGmXvI0ne4C9qbIosTkSiE56kAdgAqvv/mzCHo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ryva5k9ur4m9DArew2vL+S7C9e9EsYeXCTonVravY+cKDt9Njc47fgq73Xdb6jUnqs8FxYndEMNLeJVM4If3EZoVVa1q8jc8nsI1JbsqhQphQ0gEMtFS+SoQW4IelDizE2uSmaJigjSTDqXLSLMNHEvFFXTJQAuw2PTkzs3IwAQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A7JLgsx+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8694FC4CED6;
	Fri, 10 Jan 2025 12:58:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736513887;
	bh=e3L/+WGmXvI0ne4C9qbIosTkSiE56kAdgAqvv/mzCHo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=A7JLgsx+kjR2axR82MuDhFwXiFpJiSAJnvb8fipgbJpPkjsT1PzlMZ3lc2RRcKhxG
	 c2rKde88QouLAO91q2I5CdMJ0+GiT5vzDQiEBULT5v5K1sAgUtj6T0fM2wSvxjHi/d
	 c/j0O74BHcgCvDMz7IkedikwD8tBRveSRuh1ro2rJ//19FQS7+vq5ReLjm61rXLyrU
	 l9a7y7A6iuwFwHGdpj4ADbGiAmIgge/y3kOCkNjPbALMfZa6JUDZbSU5WrIg94uIKY
	 3PQHsY3k9D+lpTzKUImmwH6oUGBZr9dI32tL9GZ1OXXMC9Q8Uv7xBH0HBW1oWGqO01
	 QoIx8O4edJSNQ==
Date: Fri, 10 Jan 2025 12:58:03 +0000
From: Simon Horman <horms@kernel.org>
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
	linux-can@vger.kernel.org, kernel@pengutronix.de,
	Jimmy Assarsson <extja@kvaser.com>
Subject: Re: [PATCH net-next 15/18] can: kvaser_usb: Update stats and state
 even if alloc_can_err_skb() fails
Message-ID: <20250110125803.GF7706@kernel.org>
References: <20250110112712.3214173-1-mkl@pengutronix.de>
 <20250110112712.3214173-16-mkl@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250110112712.3214173-16-mkl@pengutronix.de>

On Fri, Jan 10, 2025 at 12:04:23PM +0100, Marc Kleine-Budde wrote:
> From: Jimmy Assarsson <extja@kvaser.com>
> 
> Ensure statistics, error counters, and CAN state are updated consistently,
> even when alloc_can_err_skb() fails during state changes or error message
> frame reception.
> 
> Signed-off-by: Jimmy Assarsson <extja@kvaser.com>
> Link: https://patch.msgid.link/20241230142645.128244-1-extja@kvaser.com
> Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>

...

> diff --git a/drivers/net/can/usb/kvaser_usb/kvaser_usb_leaf.c b/drivers/net/can/usb/kvaser_usb/kvaser_usb_leaf.c

...

> @@ -1187,11 +1169,18 @@ static void kvaser_usb_leaf_rx_error(const struct kvaser_usb *dev,
>  		if (priv->can.restart_ms &&
>  		    old_state == CAN_STATE_BUS_OFF &&
>  		    new_state < CAN_STATE_BUS_OFF) {
> -			cf->can_id |= CAN_ERR_RESTARTED;
> +			if (cf)
> +				cf->can_id |= CAN_ERR_RESTARTED;
>  			netif_carrier_on(priv->netdev);
>  		}
>  	}
>  
> +	if (!skb) {
> +		stats->rx_dropped++;
> +		netdev_warn(priv->netdev, "No memory left for err_skb\n");
> +		return;
> +	}
> +
>  	switch (dev->driver_info->family) {
>  	case KVASER_LEAF:
>  		if (es->leaf.error_factor) {

Hi Jimmy and Marc,

The next line of this function is:

			cf->can_id |= CAN_ERR_BUSERROR | CAN_ERR_PROT;

Which dereferences cf. However, the check added at the top of
this hunk assumes that cf may be NULL. This doesn't seem consistent.

Flagged by Smatch.

> -- 
> 2.45.2
> 
> 
> 

