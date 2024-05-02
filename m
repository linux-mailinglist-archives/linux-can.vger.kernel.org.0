Return-Path: <linux-can+bounces-534-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CEB38B993D
	for <lists+linux-can@lfdr.de>; Thu,  2 May 2024 12:45:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BB2AC1F2251B
	for <lists+linux-can@lfdr.de>; Thu,  2 May 2024 10:45:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E0D764CE1;
	Thu,  2 May 2024 10:41:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=fritzc.com header.i=@fritzc.com header.b="DDqJ6uWX"
X-Original-To: linux-can@vger.kernel.org
Received: from fritzc.com (mail.fritzc.com [213.160.72.247])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D00B75C60D;
	Thu,  2 May 2024 10:41:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.160.72.247
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714646489; cv=none; b=p7NCMXWlmc5l0TFrYKn+wubv2Ejxjf2gB+Vibr7l3DcS6HmuslFNApJELT9tGHKnbQxVb2wPZaXZslUYqThG+JE2qigiOQgRv0/uEQJnyUjz/hzWxqa73qvQEsogUoK/38lNjYY9AyXnGfwuHfKHXl87keEKxZjvbaROgbhTt14=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714646489; c=relaxed/simple;
	bh=OqJ+yIymupM8os2NNtWYxIDzuic0X9q0L/FNYuyp6NQ=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=uLMzAxtLt+XgVp7LFnWf5hoRuWfyErgdq8swm6k7gHfjkR89a/h3/NHt3aCbf1SfVPE1PBNdB9ebzucGDriCB96KoLTxrFGONftbxkio4RiaF77sFvRHJr9A3j4dKCT/K1x45lPYu+tdLnEnMKsX/hHzvQqYyf0IZTqg3mJLIUU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hexdev.de; spf=pass smtp.mailfrom=hexdev.de; dkim=pass (1024-bit key) header.d=fritzc.com header.i=@fritzc.com header.b=DDqJ6uWX; arc=none smtp.client-ip=213.160.72.247
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hexdev.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hexdev.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=fritzc.com;
	s=dkim; h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:
	In-Reply-To:Date:Cc:To:Reply-To:From:Subject:Message-ID:Sender:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=4UUHAno7rypybrcQtRJnCbtjDnm2b3MTrzNRoHFFT+4=; b=DDqJ6uWXnxC+eCkZQ7gN9aIjkb
	o+Ouhe7Rg91OXbK1/odgrwOFaA6dXxRBbs6uy+CzYzxCFJteto934oK/rKoev1Ntg9s9p+GYVVzIC
	VfVAcwv8kpe+bOYZDEa5Jb6VBisVxPmFjJQH2n9IxGJJcuvjxi7NH887u+P62++5sogo=;
Received: from 127.0.0.1
	by fritzc.com with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim latest)
	(envelope-from <christoph.fritz@hexdev.de>)
	id 1s2TsE-001Z1U-1D;
	Thu, 02 May 2024 12:41:11 +0200
Message-ID: <2ab875b8216dd32d0d1e495a52a20c02a40e3e5d.camel@hexdev.de>
Subject: Re: [PATCH v2 02/12] HID: hexLIN: Add support for USB LIN bus
 adapter
From: Christoph Fritz <christoph.fritz@hexdev.de>
Reply-To: christoph.fritz@hexdev.de
To: Jiri Slaby <jirislaby@kernel.org>
Cc: Oliver Hartkopp <socketcan@hartkopp.net>, Marc Kleine-Budde
 <mkl@pengutronix.de>, Vincent Mailhol <mailhol.vincent@wanadoo.fr>, "David
 S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>,  Paolo Abeni <pabeni@redhat.com>, Rob
 Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,  Conor
 Dooley <conor+dt@kernel.org>, Jiri Kosina <jikos@kernel.org>, Benjamin
 Tissoires <bentiss@kernel.org>,  Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>, Sebastian Reichel <sre@kernel.org>, Linus
 Walleij <linus.walleij@linaro.org>, Andreas Lauser
 <andreas.lauser@mercedes-benz.com>,  Jonathan Corbet <corbet@lwn.net>,
 Pavel Pisa <pisa@cmp.felk.cvut.cz>, linux-can@vger.kernel.org, 
 netdev@vger.kernel.org, devicetree@vger.kernel.org,
 linux-input@vger.kernel.org,  linux-serial@vger.kernel.org
Date: Thu, 02 May 2024 12:41:07 +0200
In-Reply-To: <acf0251e-41b9-410d-a663-ff6c34d2bc3e@kernel.org>
References: <20240502075534.882628-1-christoph.fritz@hexdev.de>
	 <20240502075534.882628-3-christoph.fritz@hexdev.de>
	 <acf0251e-41b9-410d-a663-ff6c34d2bc3e@kernel.org>
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

On Thu, 2024-05-02 at 10:30 +0200, Jiri Slaby wrote:
> On 02. 05. 24, 9:55, Christoph Fritz wrote:
> > This patch introduces driver support for the hexLIN USB LIN bus adapter,
> > enabling LIN communication over USB for both controller and responder
> > modes. The driver interfaces with the CAN_LIN framework for userland
> > connectivity.
> > 
> > For more details on the adapter, visit: https://hexdev.de/hexlin/
> > 
> > Tested-by: Andreas Lauser <andreas.lauser@mercedes-benz.com>
> > Signed-off-by: Christoph Fritz <christoph.fritz@hexdev.de>
> ...
> > --- /dev/null
> > +++ b/drivers/hid/hid-hexdev-hexlin.c
> > @@ -0,0 +1,630 @@
> ...
> > +static int hexlin_stop(struct lin_device *ldev)
> > +{
> > +	struct hid_device *hdev = to_hid_device(ldev->dev);
> > +	struct hexlin_priv_data *priv = hid_get_drvdata(hdev);
> > +
> > +	hid_hw_close(hdev);
> > +
> > +	priv->is_error = true;
> > +	complete(&priv->wait_in_report);
> > +
> > +	mutex_lock(&priv->tx_lock);
> > +	mutex_unlock(&priv->tx_lock);
> 
> This is a weird way to implement a completion. It looks like you need 
> another one.

They are not necessary, even more so when I can drop the
mutex_destroy() below.

> 
> > +	return 0;
> > +}
> ...> +static int hexlin_probe(struct hid_device *hdev,
> > +			const struct hid_device_id *id)
> > +{
> > +	struct hexlin_priv_data *priv;
> > +	int ret;
> > +
> > +	priv = devm_kzalloc(&hdev->dev, sizeof(*priv), GFP_KERNEL);
> > +	if (!priv)
> > +		return -ENOMEM;
> > +
> > +	priv->hid_dev = hdev;
> > +	hid_set_drvdata(hdev, priv);
> > +
> > +	mutex_init(&priv->tx_lock);
> > +
> > +	ret = hid_parse(hdev);
> > +	if (ret) {
> > +		hid_err(hdev, "hid parse failed with %d\n", ret);
> > +		goto fail_and_free;
> > +	}
> > +
> > +	ret = hid_hw_start(hdev, HID_CONNECT_DRIVER);
> > +	if (ret) {
> > +		hid_err(hdev, "hid hw start failed with %d\n", ret);
> > +		goto fail_and_stop;
> > +	}
> > +
> > +	ret = hid_hw_open(hdev);
> > +	if (ret) {
> > +		hid_err(hdev, "hid hw open failed with %d\n", ret);
> > +		goto fail_and_close;
> > +	}
> > +
> > +	init_completion(&priv->wait_in_report);
> > +
> > +	hid_device_io_start(hdev);
> > +
> > +	ret = init_hw(priv);
> > +	if (ret)
> > +		goto fail_and_close;
> > +
> > +	priv->ldev = register_lin(&hdev->dev, &hexlin_ldo);
> > +	if (IS_ERR_OR_NULL(priv->ldev)) {
> > +		ret = PTR_ERR(priv->ldev);
> > +		goto fail_and_close;
> > +	}
> > +
> > +	hid_hw_close(hdev);
> > +
> > +	hid_info(hdev, "hexLIN (fw-version: %u) probed\n", priv->fw_version);
> > +
> > +	return 0;
> > +
> > +fail_and_close:
> > +	hid_hw_close(hdev);
> > +fail_and_stop:
> > +	hid_hw_stop(hdev);
> > +fail_and_free:
> > +	mutex_destroy(&priv->tx_lock);
> > +	return ret;
> > +}
> > +
> > +static void hexlin_remove(struct hid_device *hdev)
> > +{
> > +	struct hexlin_priv_data *priv = hid_get_drvdata(hdev);
> > +
> > +	unregister_lin(priv->ldev);
> > +	hid_hw_stop(hdev);
> > +	mutex_destroy(&priv->tx_lock);
> 
> It is unusual to destroy a mutex. Why do you do that?
> 

Just for code clarity and it should help if someone wants to use
CONFIG_DEBUG_MUTEXES.

To be able to drop the lock/unlock from above, I could add the
lock/unlock here or just drop the mutex_destroy() completely.

I'll just drop it in upcoming v3.

> > +}
> ...
> > +static int __init hexlin_init(void)
> > +{
> > +	return hid_register_driver(&hexlin_driver);
> > +}
> > +
> > +static void __exit hexlin_exit(void)
> > +{
> > +	hid_unregister_driver(&hexlin_driver);
> > +}
> 
> 
> 
> > +
> > +/*
> > + * When compiled into the kernel, initialize after the hid bus.
> > + */
> > +late_initcall(hexlin_init);
> 
> Hmm, why not module_init() then? (And module_hid_driver().)

Looking at the other hid drivers and testing with just

module_hid_driver(hexlin_driver)

works here fine for compiled into the kernel and as a module.

> 
> > +module_exit(hexlin_exit);
> > +
> > +MODULE_LICENSE("GPL");
> > +MODULE_AUTHOR("Christoph Fritz <christoph.fritz@hexdev.de>");
> > +MODULE_DESCRIPTION("LIN bus driver for hexLIN USB adapter");

Thanks
  -- Christoph

