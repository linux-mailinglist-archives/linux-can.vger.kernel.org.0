Return-Path: <linux-can+bounces-594-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9655B8BF8D5
	for <lists+linux-can@lfdr.de>; Wed,  8 May 2024 10:40:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 51EA9286934
	for <lists+linux-can@lfdr.de>; Wed,  8 May 2024 08:40:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B3807641D;
	Wed,  8 May 2024 08:38:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=fritzc.com header.i=@fritzc.com header.b="TI8Ilyfb"
X-Original-To: linux-can@vger.kernel.org
Received: from fritzc.com (mail.fritzc.com [213.160.72.247])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8BA854794;
	Wed,  8 May 2024 08:37:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.160.72.247
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715157482; cv=none; b=K98gpUJx8Zlzj4FGeaKD32iYQ50v+ijk3wuP7vYnoq1pVH6Myab0ArP9aX2uSz0egBC498Cyi3yoZYtTkRcUt4WBmyP2EQfL1XdHvERB4A9x3MYBCFaw/KZHTQwnGuFGkD6Sqb3AQb6HEcb7OEHhLmxjCKeEdaGoEj5OMzudKIo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715157482; c=relaxed/simple;
	bh=Ymt6mozaZpmsZUFJR/IHGnlk0I5feZGcwlYIOyneKek=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=jGR+SDXGlom9b8or42nv+gxXD6TIUYY6d899D3+6NYG/5iiY9Mdt75A/BHad7B71n7kN9PqOrDkDOZQThxdOFMqEPWzjNRIylOqwdMIdWH5IN4Q+MXf0sWOys75CDVOoGWa4/sdUWc1kekO1U3UsECVbJ7WY8vezs9qVoB3pKGM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hexdev.de; spf=pass smtp.mailfrom=hexdev.de; dkim=pass (1024-bit key) header.d=fritzc.com header.i=@fritzc.com header.b=TI8Ilyfb; arc=none smtp.client-ip=213.160.72.247
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hexdev.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hexdev.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=fritzc.com;
	s=dkim; h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:
	In-Reply-To:Date:Cc:To:Reply-To:From:Subject:Message-ID:Sender:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=/cwWJ2hMCsxHa5oCqbo42OeplSDlKH5HJFgON70WHio=; b=TI8Ilyfby4KeVuwyRX1MiCEsjZ
	gm+QHj0oxkL/6FiMJTs/z/VC+0bOPbtwYXMDKUJjgkTQmUU0PGY4BQ7u0XiwKzCxheL4pO5AAQV0P
	O6R7iVA7HrAyfvEUdMQZ4nknb2bmdyd6s1Rj9hesRknNtKiIsb2ThZXdHPHdNkJE4H/8=;
Received: from 127.0.0.1
	by fritzc.com with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim latest)
	(envelope-from <christoph.fritz@hexdev.de>)
	id 1s4cns-001hLj-2m;
	Wed, 08 May 2024 10:37:33 +0200
Message-ID: <42012e066d3da1ac89b00b793283d03874cd0776.camel@hexdev.de>
Subject: Re: [PATCH v2 01/12] can: Add LIN bus as CAN abstraction
From: Christoph Fritz <christoph.fritz@hexdev.de>
Reply-To: christoph.fritz@hexdev.de
To: Simon Horman <horms@kernel.org>
Cc: Oliver Hartkopp <socketcan@hartkopp.net>, Marc Kleine-Budde
 <mkl@pengutronix.de>, Vincent Mailhol <mailhol.vincent@wanadoo.fr>, "David
 S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>,  Paolo Abeni <pabeni@redhat.com>, Rob
 Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,  Conor
 Dooley <conor+dt@kernel.org>, Jiri Kosina <jikos@kernel.org>, Benjamin
 Tissoires <bentiss@kernel.org>,  Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>, Jiri Slaby <jirislaby@kernel.org>, Sebastian
 Reichel <sre@kernel.org>,  Linus Walleij <linus.walleij@linaro.org>,
 Andreas Lauser <andreas.lauser@mercedes-benz.com>, Jonathan Corbet
 <corbet@lwn.net>, Pavel Pisa <pisa@cmp.felk.cvut.cz>,
 linux-can@vger.kernel.org,  netdev@vger.kernel.org,
 devicetree@vger.kernel.org, linux-input@vger.kernel.org, 
 linux-serial@vger.kernel.org
Date: Wed, 08 May 2024 10:37:31 +0200
In-Reply-To: <20240504124904.GJ3167983@kernel.org>
References: <20240502075534.882628-1-christoph.fritz@hexdev.de>
	 <20240502075534.882628-2-christoph.fritz@hexdev.de>
	 <20240504124904.GJ3167983@kernel.org>
Organization: hexDEV GmbH
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.46.4-2 
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

On Sat, 2024-05-04 at 13:49 +0100, Simon Horman wrote:
> On Thu, May 02, 2024 at 09:55:23AM +0200, Christoph Fritz wrote:
> > This patch adds a LIN (local interconnect network) bus abstraction on
> > top of CAN.  It is a glue driver adapting CAN on one side while offering
> > LIN abstraction on the other side. So that upcoming LIN device drivers
> > can make use of it.
> > 
> > Tested-by: Andreas Lauser <andreas.lauser@mercedes-benz.com>
> > Signed-off-by: Christoph Fritz <christoph.fritz@hexdev.de>
> 
> ...
> 
> > diff --git a/drivers/net/can/lin.c b/drivers/net/can/lin.c
> 
> ...
> 
> > +struct lin_device *register_lin(struct device *dev,
> > +				const struct lin_device_ops *ldops)
> > +{
> > +	struct net_device *ndev;
> > +	struct lin_device *ldev;
> > +	int ret;
> > +
> > +	if (!ldops || !ldops->ldo_tx || !ldops->update_bitrate  ||
> > +	    !ldops->ldo_open || !ldops->ldo_stop) {
> > +		netdev_err(ndev, "missing mandatory lin_device_ops\n");
> 
> Hi Christoph,

Hi Simon

> The line above uses ndev, but ndev is not initialised
> until a few lines further down.
> 
> Flagged by Smatch.

Despite netdev_err() checks validity of ndev, I agree with Smatch: In
upcoming v4 I'll use dev_err() here instead.

> > +		return ERR_PTR(-EINVAL);
> > +	}
> > +
> > +	ndev = alloc_candev(sizeof(struct lin_device), 1);
> > +	if (!ndev)
> > +		return ERR_PTR(-ENOMEM);
> > +
> > +	ldev = netdev_priv(ndev);
> > +
> > +	ldev->ldev_ops = ldops;
> > +	ndev->netdev_ops = &lin_netdev_ops;
> > +	ndev->flags |= IFF_ECHO;
> > +	ndev->mtu = CANFD_MTU;
> > +	ldev->can.bittiming.bitrate = LIN_DEFAULT_BAUDRATE;
> > +	ldev->can.ctrlmode = CAN_CTRLMODE_LIN;
> > +	ldev->can.ctrlmode_supported = 0;
> > +	ldev->can.bitrate_const = lin_bitrate;
> > +	ldev->can.bitrate_const_cnt = ARRAY_SIZE(lin_bitrate);
> > +	ldev->can.do_set_bittiming = lin_set_bittiming;
> > +	ldev->ndev = ndev;
> > +	ldev->dev = dev;
> > +
> > +	SET_NETDEV_DEV(ndev, dev);
> > +
> > +	ret = lin_set_bittiming(ndev);
> > +	if (ret) {
> > +		netdev_err(ndev, "set bittiming failed\n");
> > +		goto exit_candev;
> > +	}
> > +
> > +	ret = register_candev(ndev);
> > +	if (ret)
> > +		goto exit_candev;
> > +
> > +	ldev->lin_ids_kobj = kobject_create_and_add("lin_ids", &ndev->dev.kobj);
> > +	if (!ldev->lin_ids_kobj) {
> > +		netdev_err(ndev, "Failed to create sysfs directory\n");
> > +		ret = -ENOMEM;
> > +		goto exit_unreg;
> > +	}
> > +
> > +	ret = lin_create_sysfs_id_files(ndev);
> > +	if (ret) {
> > +		netdev_err(ndev, "Failed to create sysfs entry: %d\n", ret);
> > +		goto exit_kobj_put;
> > +	}
> > +
> > +	/* Using workqueue as tx over USB/SPI/... may sleep */
> > +	ldev->wq = alloc_workqueue(dev_name(dev), WQ_FREEZABLE | WQ_MEM_RECLAIM,
> > +				   0);
> > +	if (!ldev->wq)
> > +		goto exit_rm_files;
> 
> The goto above will result in: return ERR_PTR(ret)
> But ret is 0 here. Should it be set to a negative error value?
> 
> Also flagged by Smatch.

OK, will get an

ret = -ENOMEM;

> 
> > +
> > +	INIT_WORK(&ldev->tx_work, lin_tx_work_handler);
> > +
> > +	netdev_info(ndev, "LIN initialized.\n");
> > +
> > +	return ldev;
> > +
> > +exit_rm_files:
> > +	lin_remove_sysfs_id_files(ndev);
> > +exit_kobj_put:
> > +	kobject_put(ldev->lin_ids_kobj);
> > +exit_unreg:
> > +	unregister_candev(ndev);
> > +exit_candev:
> > +	free_candev(ndev);
> > +	return ERR_PTR(ret);
> > +}
> > +EXPORT_SYMBOL_GPL(register_lin);
> 
> ...

Thanks
  -- Christoph

