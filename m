Return-Path: <linux-can+bounces-7635-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2O+pM68ZB2rnrgIAu9opvQ
	(envelope-from <linux-can+bounces-7635-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Fri, 15 May 2026 15:03:43 +0200
X-Original-To: lists+linux-can@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 49E785501E7
	for <lists+linux-can@lfdr.de>; Fri, 15 May 2026 15:03:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A94513061507
	for <lists+linux-can@lfdr.de>; Fri, 15 May 2026 12:41:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C472D44B66A;
	Fri, 15 May 2026 12:41:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="MI4hhL7x"
X-Original-To: linux-can@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EE623F4129;
	Fri, 15 May 2026 12:41:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778848912; cv=none; b=LuCTYLYKKcCnVvlWZnQQ+X9bMQt1lZ/TU+dGnZNYrE0/ihkbOVMZ6Q1KQGlQqAJBCBf8lz5bMa5geDnF8FaSDxPe9us22HnI1ezllWUOJ99lKBSMPjH1jBREWvOxTGG7lZaNdvhSA2lcI3Pb3tIJn1a3lJ9tlGfyJFO8bjBvfFY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778848912; c=relaxed/simple;
	bh=byBYAVDjaoKlALuDppBYnRFz/zySWNjJSefSLftspx0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LkxqRe0cjhU6ypSE8pjo48R7cilIAGihRAojNDJmrKoKtCk5+Zj6YVYBryPwhOCNJjfFkHTlVcTzAJ0xdOZpc1wvgzg3yjhpD21h9eHV9pju2lCLvSYWKBVFNtLctykHcQof43F1EvT3H+ztZXn8s1pFcu4R6b1LN3oA7E/mxo0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=MI4hhL7x; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=GmifB1ZCgimZhhcProIdhFi1yPDkpQoTGWkF/PVYbRI=; b=MI4hhL7xpbSSCovw03l08oGGxy
	4aCxc3/gYL4DWmKHvrrF6Q3sDAUEp7GH6jVoTWzQ3ZvC9YjK2wKVKwr3Y+PWbjqIVs18fBbYSq/MB
	4I3TwbQ9aH4rXl93K/R7NUuvTjl5CJ7QexImPqsTiO4gx5Ec1kNF8qITUUStvsZVitTE=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wNrrC-0033vB-IM; Fri, 15 May 2026 14:41:34 +0200
Date: Fri, 15 May 2026 14:41:34 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: a0282524688@gmail.com
Cc: tmyu0@nuvoton.com, linusw@kernel.org, brgl@kernel.org,
	linux@roeck-us.net, andi.shyti@kernel.org, lee@kernel.org,
	mkl@pengutronix.de, mailhol@kernel.org,
	alexandre.belloni@bootlin.com, wim@linux-watchdog.org,
	linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
	linux-i2c@vger.kernel.org, linux-can@vger.kernel.org,
	netdev@vger.kernel.org, linux-watchdog@vger.kernel.org,
	linux-hwmon@vger.kernel.org, linux-rtc@vger.kernel.org,
	linux-usb@vger.kernel.org
Subject: Re: [PATCH v4 1/1] mfd: Add Host Interface (HIF) support for Nuvoton
 NCT6694
Message-ID: <ef9449dc-ef2a-415e-8acc-a15f349bac24@lunn.ch>
References: <20260515085746.114361-1-a0282524688@gmail.com>
 <20260515085746.114361-2-a0282524688@gmail.com>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260515085746.114361-2-a0282524688@gmail.com>
X-Rspamd-Queue-Id: 49E785501E7
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[lunn.ch,none];
	R_DKIM_ALLOW(-0.20)[lunn.ch:s=20171124];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-7635-lists,linux-can=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	DKIM_TRACE(0.00)[lunn.ch:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andrew@lunn.ch,linux-can@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-can];
	MID_RHS_MATCH_FROM(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[20]
X-Rspamd-Action: no action

>  MAINTAINERS                         |   1 +
>  drivers/gpio/gpio-nct6694.c         |   7 -
>  drivers/hwmon/nct6694-hwmon.c       |  21 -
>  drivers/i2c/busses/i2c-nct6694.c    |   7 -
>  drivers/mfd/Kconfig                 |  47 +-
>  drivers/mfd/Makefile                |   3 +-
>  drivers/mfd/nct6694-hif.c           | 663 ++++++++++++++++++++++++++++
>  drivers/mfd/nct6694.c               | 111 +++--
>  drivers/net/can/usb/nct6694_canfd.c |   6 -

The networking change here is very small, so my influence as a
networking Maintainer should be considered small.

However, i would say this patch is too big, does too many different
things at once, making it harder to review. Please could you break it
up into lots of small patches, each with good commit messages, and
being obviously correct.

> +F:	drivers/mfd/nct6694-hif.c

Maybe move all the usb code into nct6694-usb.c ?

> - * USB command module type for NCT6694 GPIO controller.
> - * This defines the module type used for communication with the NCT6694
> - * GPIO controller over the USB interface.
> - */
> -#define NCT6694_GPIO_MOD	0xFF
> -
>  #define NCT6694_GPIO_VER	0x90
>  #define NCT6694_GPIO_VALID	0x110
>  #define NCT6694_GPI_DATA	0x120

Moving code from one place to another can be a patch. Just moving code
is quick and easy to review, and it gets it out of more complex
patches which are harder to review.

> +static int nct6694_response_err_handling(struct nct6694 *nct6694, unsigned char err_status)
> +{
> +	switch (err_status) {
> +	case NCT6694_NO_ERROR:
> +		return 0;
> +	case NCT6694_NOT_SUPPORT_ERROR:
> +		dev_err(nct6694->dev, "Command is not supported!\n");
> +		break;

Maybe EOPNOTSUPP?

> +	case NCT6694_NO_RESPONSE_ERROR:
> +		dev_warn(nct6694->dev, "Command received no response!\n");
> +		break;
> +	case NCT6694_TIMEOUT_ERROR:
> +		dev_warn(nct6694->dev, "Command timed out!\n");
> +		break;

Maybe ETIMEDOUT?


> +	case NCT6694_PENDING:
> +		dev_err(nct6694->dev, "Command is pending!\n");
> +		break;

EBUSY?

Having different error codes can make it easier to debug when things
so wrong. But you also have dev_err(), so it is less important.

> -static int nct6694_response_err_handling(struct nct6694 *nct6694, unsigned char err_status)
> +static int nct6694_usb_err_handling(struct nct6694 *nct6694,
> +				    unsigned char err_status)

These renames can happen in one patch. Again, it is quick and easy to
review.

>  
> -	guard(mutex)(&nct6694->access_lock);
> +	guard(mutex)(&udata->access_lock);

This change is not obviously correct. Can moving the lock be made of
patch of its own, with an explanation of why?

> -	nct6694->usb_msg = devm_kzalloc(dev, sizeof(union nct6694_usb_msg), GFP_KERNEL);
> -	if (!nct6694->usb_msg)
> +	udata = devm_kzalloc(dev, sizeof(*udata), GFP_KERNEL);
> +	if (!udata)
>  		return -ENOMEM;
>  
> -	nct6694->int_buffer = devm_kzalloc(dev, sizeof(*nct6694->int_buffer), GFP_KERNEL);
> -	if (!nct6694->int_buffer)
> +	udata->usb_msg = devm_kzalloc(dev, sizeof(*udata->usb_msg), GFP_KERNEL);
> +	if (!udata->usb_msg)
>  		return -ENOMEM;
>  
> -	nct6694->int_in_urb = usb_alloc_urb(0, GFP_KERNEL);
> -	if (!nct6694->int_in_urb)
> +	udata->int_buffer = devm_kzalloc(dev, sizeof(*udata->int_buffer), GFP_KERNEL);
> +	if (!udata->int_buffer)
>  		return -ENOMEM;
>  
> +	udata->int_in_urb = usb_alloc_urb(0, GFP_KERNEL);
> +	if (!udata->int_in_urb)
> +		return -ENOMEM;


In this hunk, diff(1) has done a poor job and made it harder to
review. If i understand the code correctly, udata contains USB
specific data? Maybe call it usdata? That also has the same length as
ntc6694, which has some minor advantages. What you might find is that
if you have a patch adding only the allocation of usbdata, and then a
patch moving things into usbdata, diff(1) does a better job, and the
code is more obviously correct.

> @@ -305,16 +344,15 @@ static int nct6694_usb_probe(struct usb_interface *iface,
>  	}
>  
>  	nct6694->dev = dev;
> -	nct6694->udev = udev;
> +
> +	spin_lock_init(&nct6694->irq_lock);
>  
>  	ida_init(&nct6694->gpio_ida);
>  	ida_init(&nct6694->i2c_ida);
>  	ida_init(&nct6694->canfd_ida);
>  	ida_init(&nct6694->wdt_ida);
>  
> -	spin_lock_init(&nct6694->irq_lock);
> -

Why has the spin_lock_init() moved? Having lots of small patches would
make that stand out, and when you reviewed your own patches, you might
decided to change it back, because it does not appear to be needed.

Given the size of this patch, i'm finding it hard to see the overall
structure. Generally, when you have one device with two different
access mechanisms, you end up with three files, two implementing
access, and the third with the common code. With one big patch, i
don't see this common code.

	Andrew

