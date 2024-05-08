Return-Path: <linux-can+bounces-595-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BFEB68BF8DD
	for <lists+linux-can@lfdr.de>; Wed,  8 May 2024 10:40:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F11C81C23691
	for <lists+linux-can@lfdr.de>; Wed,  8 May 2024 08:40:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EC3C59B4B;
	Wed,  8 May 2024 08:38:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=fritzc.com header.i=@fritzc.com header.b="KILPThKD"
X-Original-To: linux-can@vger.kernel.org
Received: from fritzc.com (mail.fritzc.com [213.160.72.247])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3F7A53E00;
	Wed,  8 May 2024 08:38:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.160.72.247
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715157488; cv=none; b=Tgieo5H+0HIE1y/zwSYCT1DQfkf3jsvGKJyKasWQh+BUL7nMEMPvObcH6/CtWBsyJ6IhlnYZ2Akpph94NUFkrwJKi/GTjOvoLVBh+DifRlYCa6nUy+leM6zhTssNpC30zm1GzADcuo9hLKO7JT+OiwNsr5/jUayJBuLKNCD/69o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715157488; c=relaxed/simple;
	bh=Ef1wep/PhTbBZLqfc10k/PySfreDf9wUyFGc7eJzthA=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=qge9jkaeJkej3zSefiQNqK3uCkSvEkfNG2QkQ5r2Y3nMAeThmNVcZBmVwMtndZd6pvXnYIY6XhRJx2xI83+k/Qyl2PTd4JtkrcAFdfmikBM6Geh/SNKe6tqB7p+13irU8xRc5XfjL0TscMLJAP8+d1JA+cp5GXuwPd07TxUqmCk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hexdev.de; spf=pass smtp.mailfrom=hexdev.de; dkim=pass (1024-bit key) header.d=fritzc.com header.i=@fritzc.com header.b=KILPThKD; arc=none smtp.client-ip=213.160.72.247
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hexdev.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hexdev.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=fritzc.com;
	s=dkim; h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:
	In-Reply-To:Date:Cc:To:Reply-To:From:Subject:Message-ID:Sender:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=q34xDwpOIYuBXEyGxwytUZEJt75D/MfWylBl9+mCp1Q=; b=KILPThKDFa+8zSIJZoH2T2Qzue
	S8ka4i+MAKocYJ4yYFNobdW3mEe/YktYRWDyOsOuMLqlgHwp3toFuI9FTgHK/BOglgQaWXgX6fjnd
	eogiztd4S/LIJA9hQJotLrdqRO/0HZ/rGoRurP5LHz9VAvsYz2TSibQX/QNlBOWp3D9Q=;
Received: from 127.0.0.1
	by fritzc.com with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim latest)
	(envelope-from <christoph.fritz@hexdev.de>)
	id 1s4coG-001hMF-0S;
	Wed, 08 May 2024 10:37:56 +0200
Message-ID: <7e321216b92651680f0b9adafc11afe27c8a49c3.camel@hexdev.de>
Subject: Re: [PATCH v2 07/12] can: Add support for serdev LIN adapters
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
Date: Wed, 08 May 2024 10:37:54 +0200
In-Reply-To: <20240504131331.GL3167983@kernel.org>
References: <20240502075534.882628-1-christoph.fritz@hexdev.de>
	 <20240502075534.882628-8-christoph.fritz@hexdev.de>
	 <20240504131331.GL3167983@kernel.org>
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

On Sat, 2024-05-04 at 14:13 +0100, Simon Horman wrote:
> On Thu, May 02, 2024 at 09:55:29AM +0200, Christoph Fritz wrote:
> > This commit introduces LIN-Bus support for UART devices equipped with
> > LIN transceivers, utilizing the Serial Device Bus (serdev) interface.
> > 
> > For more details on an adapter, visit: https://hexdev.de/hexlin#tty
> > 
> > Signed-off-by: Christoph Fritz <christoph.fritz@hexdev.de>
> 
> ...
> 
> > diff --git a/drivers/net/can/lin-serdev.c b/drivers/net/can/lin-serdev.c
> 
> ...
> 
> > +static int linser_probe(struct serdev_device *serdev)
> > +{
> > +	struct linser_priv *priv;
> > +	int ret;
> > +
> > +	priv = devm_kzalloc(&serdev->dev, sizeof(*priv), GFP_KERNEL);
> > +	if (!priv)
> > +		return -ENOMEM;
> > +
> > +	ret = kfifo_alloc(&priv->rx_fifo, LINSER_RX_FIFO_SIZE, GFP_KERNEL);
> > +	if (ret)
> > +		return ret;
> > +
> > +	INIT_DELAYED_WORK(&priv->rx_work, linser_process_delayed);
> > +
> > +	priv->serdev = serdev;
> > +	serdev_device_set_drvdata(serdev, priv);
> > +	serdev_device_set_client_ops(serdev, &linser_ops);
> > +
> > +	ret = serdev_device_open(serdev);
> > +	if (ret) {
> > +		dev_err(&serdev->dev, "Unable to open device\n");
> > +		goto err_open;
> > +	}
> > +
> > +	serdev_device_set_flow_control(serdev, false);
> > +	serdev_device_set_break_detection(serdev, true);
> > +	linser_derive_timings(priv, LIN_DEFAULT_BAUDRATE);
> > +
> > +	mutex_init(&priv->resp_lock);
> > +
> > +	priv->lin_dev = register_lin(&serdev->dev, &linser_lindev_ops);
> > +	if (IS_ERR_OR_NULL(priv->lin_dev)) {
> > +		ret = PTR_ERR(priv->lin_dev);
> 
> As per my feedback on an earlier patch in the series,
> in the case where priv->lin_dev is NULL,
> this will result in the function returning 0.
> Is that ok?
> 
> Flagged by Smatch

IS_ERR_OR_NULL() gets IS_ERR() in upcoming v4

Thanks
  -- Christoph

> 
> > +		goto err_register_lin;
> > +	}
> > +
> > +	serdev_device_close(serdev);
> > +	priv->is_stopped = true;
> > +
> > +	return 0;
> > +
> > +err_register_lin:
> > +	serdev_device_close(serdev);
> > +err_open:
> > +	kfifo_free(&priv->rx_fifo);
> > +	return ret;
> > +}
> 
> ...


