Return-Path: <linux-can+bounces-561-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AB858BBBD9
	for <lists+linux-can@lfdr.de>; Sat,  4 May 2024 15:14:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 25C85281FAA
	for <lists+linux-can@lfdr.de>; Sat,  4 May 2024 13:14:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB6EF374C4;
	Sat,  4 May 2024 13:13:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="f55QqJAx"
X-Original-To: linux-can@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B788B2869B;
	Sat,  4 May 2024 13:13:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714828420; cv=none; b=lRbUbAl+/quFKuU/l5d+Z1vziUGed1kb5NN0Qv683csU70W4hmO9nDMf467E3GQPhkTgUGIUwocLfm4wpk7U2rqmhhcLHWih4fTkvsfM7y+tI6b5p0FmoidU5zg/Nyue365Fow/mCJT7sE/ev+1zeVw0ISmMfTTmq3DiuhC3fNE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714828420; c=relaxed/simple;
	bh=mB1V0MUkulAejpMzif3U6Gw3lBLCZIYHOeyQLUDvPjA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=i933ijvYleBJDjZ8AiNA+QhKxW1S/Wx32m8jbTr4SaK2CZvs0zII6Sep55JzmdWi253S/4WSgYbkdtYWvbmCVovF5Bq/e/sD5ZM+o1cT1JCBvZRi/O4UmxI9j0bV/wC7FJMoPtjCdUFc1Mj2rIurDjMSdeMLzwVZSu8YH8WJAWw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=f55QqJAx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 87CF5C32789;
	Sat,  4 May 2024 13:13:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714828420;
	bh=mB1V0MUkulAejpMzif3U6Gw3lBLCZIYHOeyQLUDvPjA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=f55QqJAxT/lIQdmjxJGUyFxh5HNjCIsMMZa7zAaka9pq1d53AX+g4sQI0oaTtrCyx
	 ZGp61wedXpJlm5voqcO3eBfolunlk91fRAobCCxgTKeSHCLcTtB8HX+XCEaOjfainy
	 vCN08QlPHPtGfON5VyyB64vbYMxg2dMD7MFkVTdS6x08rRtZBcHejB1BzEgAuH17Qv
	 v7GUrrh3G/VfYw0hfhYf2iLz56jKL5uTwRWeyhSV0ZHExeYFBbGV/0GMRww8791iuK
	 0DBXUFqz/5LAljDqg5qt1sw3AUMQViJp4rlRRPUwjxxrYwhqD+nKF3gccYjF+syG5c
	 zrKwv+apQ85fw==
Date: Sat, 4 May 2024 14:13:31 +0100
From: Simon Horman <horms@kernel.org>
To: Christoph Fritz <christoph.fritz@hexdev.de>
Cc: Oliver Hartkopp <socketcan@hartkopp.net>,
	Marc Kleine-Budde <mkl@pengutronix.de>,
	Vincent Mailhol <mailhol.vincent@wanadoo.fr>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Sebastian Reichel <sre@kernel.org>,
	Linus Walleij <linus.walleij@linaro.org>,
	Andreas Lauser <andreas.lauser@mercedes-benz.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Pavel Pisa <pisa@cmp.felk.cvut.cz>, linux-can@vger.kernel.org,
	netdev@vger.kernel.org, devicetree@vger.kernel.org,
	linux-input@vger.kernel.org, linux-serial@vger.kernel.org
Subject: Re: [PATCH v2 07/12] can: Add support for serdev LIN adapters
Message-ID: <20240504131331.GL3167983@kernel.org>
References: <20240502075534.882628-1-christoph.fritz@hexdev.de>
 <20240502075534.882628-8-christoph.fritz@hexdev.de>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240502075534.882628-8-christoph.fritz@hexdev.de>

On Thu, May 02, 2024 at 09:55:29AM +0200, Christoph Fritz wrote:
> This commit introduces LIN-Bus support for UART devices equipped with
> LIN transceivers, utilizing the Serial Device Bus (serdev) interface.
> 
> For more details on an adapter, visit: https://hexdev.de/hexlin#tty
> 
> Signed-off-by: Christoph Fritz <christoph.fritz@hexdev.de>

...

> diff --git a/drivers/net/can/lin-serdev.c b/drivers/net/can/lin-serdev.c

...

> +static int linser_probe(struct serdev_device *serdev)
> +{
> +	struct linser_priv *priv;
> +	int ret;
> +
> +	priv = devm_kzalloc(&serdev->dev, sizeof(*priv), GFP_KERNEL);
> +	if (!priv)
> +		return -ENOMEM;
> +
> +	ret = kfifo_alloc(&priv->rx_fifo, LINSER_RX_FIFO_SIZE, GFP_KERNEL);
> +	if (ret)
> +		return ret;
> +
> +	INIT_DELAYED_WORK(&priv->rx_work, linser_process_delayed);
> +
> +	priv->serdev = serdev;
> +	serdev_device_set_drvdata(serdev, priv);
> +	serdev_device_set_client_ops(serdev, &linser_ops);
> +
> +	ret = serdev_device_open(serdev);
> +	if (ret) {
> +		dev_err(&serdev->dev, "Unable to open device\n");
> +		goto err_open;
> +	}
> +
> +	serdev_device_set_flow_control(serdev, false);
> +	serdev_device_set_break_detection(serdev, true);
> +	linser_derive_timings(priv, LIN_DEFAULT_BAUDRATE);
> +
> +	mutex_init(&priv->resp_lock);
> +
> +	priv->lin_dev = register_lin(&serdev->dev, &linser_lindev_ops);
> +	if (IS_ERR_OR_NULL(priv->lin_dev)) {
> +		ret = PTR_ERR(priv->lin_dev);

As per my feedback on an earlier patch in the series,
in the case where priv->lin_dev is NULL,
this will result in the function returning 0.
Is that ok?

Flagged by Smatch

> +		goto err_register_lin;
> +	}
> +
> +	serdev_device_close(serdev);
> +	priv->is_stopped = true;
> +
> +	return 0;
> +
> +err_register_lin:
> +	serdev_device_close(serdev);
> +err_open:
> +	kfifo_free(&priv->rx_fifo);
> +	return ret;
> +}

...

