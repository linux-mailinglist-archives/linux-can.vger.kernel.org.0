Return-Path: <linux-can+bounces-631-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E94B8C3697
	for <lists+linux-can@lfdr.de>; Sun, 12 May 2024 15:08:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 03AE11F210E0
	for <lists+linux-can@lfdr.de>; Sun, 12 May 2024 13:08:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B190821A04;
	Sun, 12 May 2024 13:08:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=fritzc.com header.i=@fritzc.com header.b="RVaywzD1"
X-Original-To: linux-can@vger.kernel.org
Received: from fritzc.com (mail.fritzc.com [213.160.72.247])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5200E12E75;
	Sun, 12 May 2024 13:08:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.160.72.247
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715519329; cv=none; b=mn+6tuEadr4grLaCBaB9JFVVhHN2sBVwqWJGpM+Dksa4XMAOuYhy5a8BbIiDjjAHcWlc9DGQYB7npiKz6NjfljLXcsUWDex8L5KGP3BOT9EOZbEPmsKb3B1h0XGwt2EUOFVTPGMJ0cKhb9eBWQ8CE5swslGMR1hn4fNFNI2+16o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715519329; c=relaxed/simple;
	bh=4dtMV0+T4itEZ3njDueGsSSCXg2qaZAkJUDSJVtpRuM=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=bGonAyGT9bkKFqpIq6DHnfCss+gJR06a1mImaAwfIB2nXKLzTSJdWl9A6IyH2zrz1nDi7orLcpkm8VrndqvWLf3Aa7iSKAIhVHymgojWPr9zIvNmVSmz+IxLsWEstMQgUI+R3tGov1YDOYKMMYQGQ6vh9zDcZmfBDkylCHHKNFI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hexdev.de; spf=pass smtp.mailfrom=hexdev.de; dkim=pass (1024-bit key) header.d=fritzc.com header.i=@fritzc.com header.b=RVaywzD1; arc=none smtp.client-ip=213.160.72.247
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hexdev.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hexdev.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=fritzc.com;
	s=dkim; h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:
	In-Reply-To:Date:Cc:To:Reply-To:From:Subject:Message-ID:Sender:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=/RDTDK04LS9aHKEZT1A3pPZvNdlGdHaOcAg8MrbVz+Q=; b=RVaywzD1qiDcNS0derDvlImqod
	J3qrmVjaO1x0b16KkAV/CmFAdc99Al8n95tuzFqQk8ssvD6OyJJ6n+9FFjFudPv8BrYU0ZaaBLVQ+
	vW5LtCThUmLUoSxZy53eDqTuSNY0j5ZvYLejDciQy+awCZzP7k/k+bPSd8CNaMw5tWlM=;
Received: from 127.0.0.1
	by fritzc.com with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim latest)
	(envelope-from <christoph.fritz@hexdev.de>)
	id 1s68w0-001uX7-29;
	Sun, 12 May 2024 15:08:13 +0200
Message-ID: <3070ec70b2477560f205cc4c34dd84b320831365.camel@hexdev.de>
Subject: Re: [PATCH v4 04/11] tty: serdev: Add method to enable break flags
From: Christoph Fritz <christoph.fritz@hexdev.de>
Reply-To: christoph.fritz@hexdev.de
To: Ilpo =?ISO-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: Jiri Slaby <jirislaby@kernel.org>, Simon Horman <horms@kernel.org>, Greg
 Kroah-Hartman <gregkh@linuxfoundation.org>, Marc Kleine-Budde
 <mkl@pengutronix.de>, Oliver Hartkopp <socketcan@hartkopp.net>, Vincent
 Mailhol <mailhol.vincent@wanadoo.fr>,  "David S . Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
 <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Rob Herring
 <robh@kernel.org>,  Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires
 <bentiss@kernel.org>, Sebastian Reichel <sre@kernel.org>, Linus Walleij
 <linus.walleij@linaro.org>, Andreas Lauser
 <andreas.lauser@mercedes-benz.com>, Jonathan Corbet <corbet@lwn.net>, Pavel
 Pisa <pisa@cmp.felk.cvut.cz>, linux-can@vger.kernel.org, Netdev
 <netdev@vger.kernel.org>,  devicetree@vger.kernel.org,
 linux-input@vger.kernel.org, linux-serial <linux-serial@vger.kernel.org>
Date: Sun, 12 May 2024 15:08:08 +0200
In-Reply-To: <36b0d460-1d96-89d8-db4a-76d735f7ee6b@linux.intel.com>
References: <20240509171736.2048414-1-christoph.fritz@hexdev.de>
	 <20240509171736.2048414-5-christoph.fritz@hexdev.de>
	 <36b0d460-1d96-89d8-db4a-76d735f7ee6b@linux.intel.com>
Organization: hexDEV GmbH
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.46.4-2 
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Fri, 2024-05-10 at 17:21 +0300, Ilpo Järvinen wrote:
> On Thu, 9 May 2024, Christoph Fritz wrote:
...
> > diff --git a/drivers/tty/serdev/core.c b/drivers/tty/serdev/core.c
> > index 613cb356b918d..23a1e76cb553b 100644
> > --- a/drivers/tty/serdev/core.c
> > +++ b/drivers/tty/serdev/core.c
> > @@ -339,6 +339,17 @@ unsigned int serdev_device_set_baudrate(struct serdev_device *serdev, unsigned i
> >  }
> >  EXPORT_SYMBOL_GPL(serdev_device_set_baudrate);
> >  
> > +void serdev_device_set_break_detection(struct serdev_device *serdev, bool enable)
> > +{
> > +	struct serdev_controller *ctrl = serdev->ctrl;
> > +
> > +	if (!ctrl || !ctrl->ops->set_break_detection)
> > +		return;
> 
> Why you need to test for !ctrl?

In our case we don't, it's an extra check like all the other functions
here:

https://elixir.bootlin.com/linux/v6.9-rc7/source/drivers/tty/serdev/core.c#L330

> 
> > +	ctrl->ops->set_break_detection(ctrl, enable);
> 
> I'd use positive logic here:
> 
> 	if (ctrl->ops->set_break_detection)
> 		ctrl->ops->set_break_detection(ctrl, enable);



