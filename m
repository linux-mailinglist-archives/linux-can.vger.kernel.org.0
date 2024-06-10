Return-Path: <linux-can+bounces-721-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AAF4B9028DF
	for <lists+linux-can@lfdr.de>; Mon, 10 Jun 2024 20:44:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4C5E11F2244B
	for <lists+linux-can@lfdr.de>; Mon, 10 Jun 2024 18:44:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F264214B975;
	Mon, 10 Jun 2024 18:44:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CZ+beWLq"
X-Original-To: linux-can@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C20B42B9D7;
	Mon, 10 Jun 2024 18:44:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718045063; cv=none; b=s66Ys7lmcMf5iOjRBWwwH4Dn5/8gLxWmr8q6f0gIe3YzjxB6UBzKJe2JTGmPbgDI8qQTNxab/x5yDz9rdqGoiBulLF8NKnGGr0tl0kzgW+iejsZoewYuiHuXl8LDKLHQpTrUtFQZC5DK2V41HGGE47yKw2HmzzKotRHE4hdYf1c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718045063; c=relaxed/simple;
	bh=rYyx2+GiqV8GIQqzWxixzWXChxHl8YrUdrLogr5gXV4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GZTDynn+RMgKas0nDLnisWrEV6eAZKBWVwgl9eJ7MXIjhQYD7IUiCnxqXvB3ngIRO1vXh5VhDMgRAhbJ+tfriEEQmPvj1+Oxk2+VgljZ+pkgbR/GCc7nc8ZnQoeR+LRDxzFmIbM1c7BpeEyZy6RzI/f/MMqU9ATWjWS67S4RhQ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CZ+beWLq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C7A6C4AF1A;
	Mon, 10 Jun 2024 18:44:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718045063;
	bh=rYyx2+GiqV8GIQqzWxixzWXChxHl8YrUdrLogr5gXV4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=CZ+beWLqdfEW6ac/bIBuh6JIHW5ZeWS79IKxPlID3vI7CusqwbVhJduE5jXulDm/W
	 xsz9EOLXZq8tWws85lw8mGrZORO47FAoG8f8YhC7ZVXP2DAKTeaWS2En0nakZioSfc
	 doWSt8s375SyraZ5OmpVlF8vVw1SIugj4XBdOxZ+V0AZ5k5UK/RX1A4V8Cmd/DMGK6
	 hXnRnzwR/xqLQOkBPI47YrPNM+hEg6jRzNxpX6YPEolHjm/f5Gfg3BijKa+EJDXRj8
	 bKpu+BUbU/uKGCr4uf1xeH/e1Nd2lwDIbSty+w+qwzN2bM2Lx31gJAXsQvJpI8fE4+
	 RkR1oCg0xIDVg==
Date: Mon, 10 Jun 2024 11:44:22 -0700
From: Kees Cook <kees@kernel.org>
To: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Cc: Marc Kleine-Budde <mkl@pengutronix.de>, linux-can@vger.kernel.org,
	Thomas Kopp <thomas.kopp@microchip.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	"Gustavo A . R . Silva" <gustavoars@kernel.org>,
	netdev@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH 2/2] can: mcp251xfd: decorate mcp251xfd_rx_ring.obj with
 __counted_by()
Message-ID: <202406101136.1AC33DD084@keescook>
References: <20240609045419.240265-1-mailhol.vincent@wanadoo.fr>
 <20240609045419.240265-3-mailhol.vincent@wanadoo.fr>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240609045419.240265-3-mailhol.vincent@wanadoo.fr>

On Sun, Jun 09, 2024 at 01:54:19PM +0900, Vincent Mailhol wrote:
> A new __counted_by() attribute was introduced in [1]. It makes the
> compiler's sanitizer aware of the actual size of a flexible array
> member, allowing for additional runtime checks.
> 
> Apply the __counted_by() attribute to the obj flexible array member of
> struct mcp251xfd_rx_ring.
> 
> Note that the mcp251xfd_rx_ring.obj member is polymorphic: it can be
> either of:
> 
>   * an array of struct mcp251xfd_hw_rx_obj_can
>   * an array of struct mcp251xfd_hw_rx_obj_canfd
> 
> The canfd type was chosen in the declaration by the original author to
> reflect the upper bound. We pursue the same logic here: the sanitizer
> will only see the accurate size of canfd frames. For classical can
> frames, it will see a size bigger than the reality, making the check
> incorrect but silent (false negative).
> 
> [1] commit dd06e72e68bc ("Compiler Attributes: Add __counted_by macro")
> Link: https://git.kernel.org/torvalds/c/dd06e72e68bc
> 
> CC: Kees Cook <kees@kernel.org>
> Signed-off-by: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
> ---
>  drivers/net/can/spi/mcp251xfd/mcp251xfd.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/net/can/spi/mcp251xfd/mcp251xfd.h b/drivers/net/can/spi/mcp251xfd/mcp251xfd.h
> index 24510b3b8020..b7579fba9457 100644
> --- a/drivers/net/can/spi/mcp251xfd/mcp251xfd.h
> +++ b/drivers/net/can/spi/mcp251xfd/mcp251xfd.h
> @@ -565,7 +565,7 @@ struct mcp251xfd_rx_ring {
>  	union mcp251xfd_write_reg_buf uinc_buf;
>  	union mcp251xfd_write_reg_buf uinc_irq_disable_buf;
>  	struct spi_transfer uinc_xfer[MCP251XFD_FIFO_DEPTH];
> -	struct mcp251xfd_hw_rx_obj_canfd obj[];
> +	struct mcp251xfd_hw_rx_obj_canfd obj[] __counted_by(obj_num);
>  };
>  
>  struct __packed mcp251xfd_map_buf_nocrc {

This one seems safe:

                rx_ring = kzalloc(sizeof(*rx_ring) + rx_obj_size * rx_obj_num,
                                  GFP_KERNEL);
		...
                rx_ring->obj_num = rx_obj_num;

But I would like to see the above allocation math replaced with
struct_size() usage:

                rx_ring = kzalloc(struct_size(rx_ring, obj, rx_obj_num), GFP_KERNEL);

But that leaves me with a question about the use of rx_obj_size in the
original code. Why is this a variable size? rx_ring has only struct
mcp251xfd_hw_rx_obj_canfd objects in the flexible array...

I suspect that struct mcp251xfd_rx_ring needs to actually be using a
union for its flexible array, but I can't find anything that is casting
struct mcp251xfd_rx_ring::obj to struct mcp251xfd_hw_rx_obj_can.

I'm worried about __counted_by getting used here if the flexible array
isn't actually the right type.

-- 
Kees Cook

