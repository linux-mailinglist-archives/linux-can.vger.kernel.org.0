Return-Path: <linux-can+bounces-562-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 096F18BBCEF
	for <lists+linux-can@lfdr.de>; Sat,  4 May 2024 18:00:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3601B1C20E10
	for <lists+linux-can@lfdr.de>; Sat,  4 May 2024 16:00:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A74741741;
	Sat,  4 May 2024 16:00:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="hPvSedsp"
X-Original-To: linux-can@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C764023767;
	Sat,  4 May 2024 16:00:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714838406; cv=none; b=Uzc7a0VAWhd6mNEv8txU7+Tc/CHwBKmhM9Z/RMcwOqYy9qn701XIfeNlFj1bAr2IhqlKQ1cQonGLt5Ju9CEe91e549rr0Quhypb+FC4JBwGA0wDBL+tsjyR9gSr+FF0m1bi15iujyFntsemzzs7GCqXAJT9YkPnPEhSYfY7OWBw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714838406; c=relaxed/simple;
	bh=2CfHE6U1TpkNccPPQ+ztJD0Glq/+yNTjt96lxseYs9w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AFC2ixPzORGB+yeuuNlVAqLTKB6Jg8QMGKhRWTUlVuCWv2Tn3X3632Gry+Pu8V1XpBw869a9Lw981YKLIem/7QLRYHnJxCMFYhKx6r2e3f0afWBAhwglkn7Dir0xfPIFgFqYIH86xpQczT+szFXkpfy340n92oqro5Au6y/hdLg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=hPvSedsp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D204C072AA;
	Sat,  4 May 2024 16:00:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1714838405;
	bh=2CfHE6U1TpkNccPPQ+ztJD0Glq/+yNTjt96lxseYs9w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hPvSedspztdtHSPN3XsMQ+YePzhvGV6PXZbpqNBYIQKQGzEhgcWZNr+okyglg99rQ
	 0yEk8VpMdXRQp+bRoBPshGJKkBJSqqs6Rp8o4y26mTU8wBsCgnyuGVkEcjEOyi4wsW
	 10UmPB7I7bt1NVTHNn/zWY6PsJR864PffTHSLVb4=
Date: Sat, 4 May 2024 18:00:01 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Christoph Fritz <christoph.fritz@hexdev.de>
Cc: Jiri Slaby <jirislaby@kernel.org>,
	Oliver Hartkopp <socketcan@hartkopp.net>,
	Marc Kleine-Budde <mkl@pengutronix.de>,
	Vincent Mailhol <mailhol.vincent@wanadoo.fr>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>,
	Sebastian Reichel <sre@kernel.org>,
	Linus Walleij <linus.walleij@linaro.org>,
	Andreas Lauser <andreas.lauser@mercedes-benz.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Pavel Pisa <pisa@cmp.felk.cvut.cz>, linux-can@vger.kernel.org,
	netdev@vger.kernel.org, devicetree@vger.kernel.org,
	linux-input@vger.kernel.org, linux-serial@vger.kernel.org
Subject: Re: [PATCH v3 03/11] tty: serdev: Add flag buffer aware
 receive_buf_fp()
Message-ID: <2024050410-gigolo-giddily-97b6@gregkh>
References: <20240502182804.145926-1-christoph.fritz@hexdev.de>
 <20240502182804.145926-4-christoph.fritz@hexdev.de>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240502182804.145926-4-christoph.fritz@hexdev.de>

On Thu, May 02, 2024 at 08:27:56PM +0200, Christoph Fritz wrote:
> This patch introduces an additional receive buffer callback variation
> besides the already existing receive_buf(). This new callback function
> also passes the flag buffer (TTY_NORMAL, TTY_BREAK, and friends).
> 
> If defined, this function gets prioritized and called instead of the
> standard receive_buf().
> 
> An alternative approach could have been to enhance the receive_buf()
> function and update all drivers that use it.

Please, let's do that instead of adding random letters at the end of a
function pointer :)

> Signed-off-by: Christoph Fritz <christoph.fritz@hexdev.de>
> ---
>  drivers/tty/serdev/serdev-ttyport.c |  2 +-
>  include/linux/serdev.h              | 17 ++++++++++++++---
>  2 files changed, 15 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/tty/serdev/serdev-ttyport.c b/drivers/tty/serdev/serdev-ttyport.c
> index 3d7ae7fa50186..bb47691afdb21 100644
> --- a/drivers/tty/serdev/serdev-ttyport.c
> +++ b/drivers/tty/serdev/serdev-ttyport.c
> @@ -32,7 +32,7 @@ static size_t ttyport_receive_buf(struct tty_port *port, const u8 *cp,
>  	if (!test_bit(SERPORT_ACTIVE, &serport->flags))
>  		return 0;
>  
> -	ret = serdev_controller_receive_buf(ctrl, cp, count);
> +	ret = serdev_controller_receive_buf(ctrl, cp, fp, count);
>  
>  	dev_WARN_ONCE(&ctrl->dev, ret > count,
>  				"receive_buf returns %zu (count = %zu)\n",
> diff --git a/include/linux/serdev.h b/include/linux/serdev.h
> index ff78efc1f60df..c6ef5a8988e07 100644
> --- a/include/linux/serdev.h
> +++ b/include/linux/serdev.h
> @@ -23,11 +23,17 @@ struct serdev_device;
>   * struct serdev_device_ops - Callback operations for a serdev device
>   * @receive_buf:	Function called with data received from device;
>   *			returns number of bytes accepted; may sleep.
> + * @receive_buf_fp:	Function called with data and flag buffer received
> + *			from device; If defined, this function gets called
> + *			instead of @receive_buf;
> + *			returns number of bytes accepted; may sleep.

I don't remember waht "fp" means here, and you don't document it, so
let's just have one recieve_buf() callback please.

thanks,

greg k-h

