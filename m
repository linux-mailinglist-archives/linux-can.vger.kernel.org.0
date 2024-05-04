Return-Path: <linux-can+bounces-559-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9003A8BBB98
	for <lists+linux-can@lfdr.de>; Sat,  4 May 2024 14:49:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D17EBB215BE
	for <lists+linux-can@lfdr.de>; Sat,  4 May 2024 12:49:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0153A22612;
	Sat,  4 May 2024 12:49:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qHG9jkQM"
X-Original-To: linux-can@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE65457CAE;
	Sat,  4 May 2024 12:49:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714826953; cv=none; b=a7z0WlrR1Xh65IevCnivXG1s3YKANifmKN+lh1v6Xjqp98pdohwkWvMXG8tfsp2ywLFpNZrBE9mWIt+2oVRvpKv1M/ihyktZjuDsvQSKnKz9nJXNO+wc0BTbgNHdRP2E5FYZ/iCv3vMQCe+PVJj2hiMMPQy4Oo6CGogJEiYwM38=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714826953; c=relaxed/simple;
	bh=L9wv45Em8bE+QdzHN+ZzOr0q0nVv0NR8uv/oDTyGCBI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FQqAFHLVvVZgety4BHDwKr+D/cf2ntOpCVb02k8jQVD9brWKxpopdM7Wd0ixpXHbE7L0i8EaZkItha4GYhZq9jVD/DNC81vBihPj+XUHjzKBaAk/90lJ7VobuoqA9qH1ayJTZ/mrBU18LbMRYO08CdbSWzFUQOcqaoAK3vEqJtI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qHG9jkQM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A776BC072AA;
	Sat,  4 May 2024 12:49:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714826953;
	bh=L9wv45Em8bE+QdzHN+ZzOr0q0nVv0NR8uv/oDTyGCBI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qHG9jkQM8K0a//HPJ659OF/sg3x4Wuq71cSamSewKjSphBYxQhNPBXcWA1P+i7qHl
	 RY/B0okoLc6T6pcYjk+qTZKk7mzb4FI5vJbRxVYRcNzDvz3FEj04kmnFoDz4sqxhg7
	 ODAW9OYTvoWEUjhMXW9DDCqAresjetRTpLGJFQ3bBEJKFu81t2k298cClSkhhxy1mn
	 U75M1GcEXK0TSE9VRsxj5tBorA8ZCjAZgo5AHgOTiWyn7bKfCkTCgHyq7UCBKNQeeO
	 fQUeN5XxZEo8yjOwS/gSpF4KI1vzoX4gf2e2crVyxQkJ6Iaxg4OXU1NUtlhJesJl+a
	 7+a15hFbojwjQ==
Date: Sat, 4 May 2024 13:49:04 +0100
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
Subject: Re: [PATCH v2 01/12] can: Add LIN bus as CAN abstraction
Message-ID: <20240504124904.GJ3167983@kernel.org>
References: <20240502075534.882628-1-christoph.fritz@hexdev.de>
 <20240502075534.882628-2-christoph.fritz@hexdev.de>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240502075534.882628-2-christoph.fritz@hexdev.de>

On Thu, May 02, 2024 at 09:55:23AM +0200, Christoph Fritz wrote:
> This patch adds a LIN (local interconnect network) bus abstraction on
> top of CAN.  It is a glue driver adapting CAN on one side while offering
> LIN abstraction on the other side. So that upcoming LIN device drivers
> can make use of it.
> 
> Tested-by: Andreas Lauser <andreas.lauser@mercedes-benz.com>
> Signed-off-by: Christoph Fritz <christoph.fritz@hexdev.de>

...

> diff --git a/drivers/net/can/lin.c b/drivers/net/can/lin.c

...

> +struct lin_device *register_lin(struct device *dev,
> +				const struct lin_device_ops *ldops)
> +{
> +	struct net_device *ndev;
> +	struct lin_device *ldev;
> +	int ret;
> +
> +	if (!ldops || !ldops->ldo_tx || !ldops->update_bitrate  ||
> +	    !ldops->ldo_open || !ldops->ldo_stop) {
> +		netdev_err(ndev, "missing mandatory lin_device_ops\n");

Hi Christoph,

The line above uses ndev, but ndev is not initialised
until a few lines further down.

Flagged by Smatch.

> +		return ERR_PTR(-EINVAL);
> +	}
> +
> +	ndev = alloc_candev(sizeof(struct lin_device), 1);
> +	if (!ndev)
> +		return ERR_PTR(-ENOMEM);
> +
> +	ldev = netdev_priv(ndev);
> +
> +	ldev->ldev_ops = ldops;
> +	ndev->netdev_ops = &lin_netdev_ops;
> +	ndev->flags |= IFF_ECHO;
> +	ndev->mtu = CANFD_MTU;
> +	ldev->can.bittiming.bitrate = LIN_DEFAULT_BAUDRATE;
> +	ldev->can.ctrlmode = CAN_CTRLMODE_LIN;
> +	ldev->can.ctrlmode_supported = 0;
> +	ldev->can.bitrate_const = lin_bitrate;
> +	ldev->can.bitrate_const_cnt = ARRAY_SIZE(lin_bitrate);
> +	ldev->can.do_set_bittiming = lin_set_bittiming;
> +	ldev->ndev = ndev;
> +	ldev->dev = dev;
> +
> +	SET_NETDEV_DEV(ndev, dev);
> +
> +	ret = lin_set_bittiming(ndev);
> +	if (ret) {
> +		netdev_err(ndev, "set bittiming failed\n");
> +		goto exit_candev;
> +	}
> +
> +	ret = register_candev(ndev);
> +	if (ret)
> +		goto exit_candev;
> +
> +	ldev->lin_ids_kobj = kobject_create_and_add("lin_ids", &ndev->dev.kobj);
> +	if (!ldev->lin_ids_kobj) {
> +		netdev_err(ndev, "Failed to create sysfs directory\n");
> +		ret = -ENOMEM;
> +		goto exit_unreg;
> +	}
> +
> +	ret = lin_create_sysfs_id_files(ndev);
> +	if (ret) {
> +		netdev_err(ndev, "Failed to create sysfs entry: %d\n", ret);
> +		goto exit_kobj_put;
> +	}
> +
> +	/* Using workqueue as tx over USB/SPI/... may sleep */
> +	ldev->wq = alloc_workqueue(dev_name(dev), WQ_FREEZABLE | WQ_MEM_RECLAIM,
> +				   0);
> +	if (!ldev->wq)
> +		goto exit_rm_files;

The goto above will result in: return ERR_PTR(ret)
But ret is 0 here. Should it be set to a negative error value?

Also flagged by Smatch.

> +
> +	INIT_WORK(&ldev->tx_work, lin_tx_work_handler);
> +
> +	netdev_info(ndev, "LIN initialized.\n");
> +
> +	return ldev;
> +
> +exit_rm_files:
> +	lin_remove_sysfs_id_files(ndev);
> +exit_kobj_put:
> +	kobject_put(ldev->lin_ids_kobj);
> +exit_unreg:
> +	unregister_candev(ndev);
> +exit_candev:
> +	free_candev(ndev);
> +	return ERR_PTR(ret);
> +}
> +EXPORT_SYMBOL_GPL(register_lin);

...

