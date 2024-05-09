Return-Path: <linux-can+bounces-608-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B704C8C137E
	for <lists+linux-can@lfdr.de>; Thu,  9 May 2024 19:07:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 71F81282A68
	for <lists+linux-can@lfdr.de>; Thu,  9 May 2024 17:07:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F6A010A0C;
	Thu,  9 May 2024 17:07:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=fritzc.com header.i=@fritzc.com header.b="rte+Mh4X"
X-Original-To: linux-can@vger.kernel.org
Received: from fritzc.com (mail.fritzc.com [213.160.72.247])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FCF0BE66;
	Thu,  9 May 2024 17:07:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.160.72.247
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715274440; cv=none; b=gFDM4YsU3hDel4ygQZ263gkd6aBklAjYIeQrySKOpscBoK6yDRBOtb8dWTtnDUMOKocZy1v8w7rIfr1b0abugUCVkC76FrEHsOTIVEKQW4lmiuCEUJB90Su0BQfvHnvMXHa01ietDjfnvApXVXmlXHcFNTL2mJ7TGYaHGZfH92M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715274440; c=relaxed/simple;
	bh=k0gFByMqGHNy3MKYMJRe8RyZTM90AqHah86h/xiMaKg=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=iBR00Wm8usbGmJKe+jYZ4pMoXxTlOoJPS9V7FKRQWAYKaStvr39MJ8kIosSjz/YM8715vIiE7VD7c1zbC0XWT17qCDgx4Hr4GfNA/+BWFRr/0pih1amPbrajFyM0Cwq5bZTNxuU59PLGUHrYAgXCCiBCjDwpy3ej91oLLDg1GYk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hexdev.de; spf=pass smtp.mailfrom=hexdev.de; dkim=pass (1024-bit key) header.d=fritzc.com header.i=@fritzc.com header.b=rte+Mh4X; arc=none smtp.client-ip=213.160.72.247
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hexdev.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hexdev.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=fritzc.com;
	s=dkim; h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:
	In-Reply-To:Date:Cc:To:Reply-To:From:Subject:Message-ID:Sender:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=sUztFsMyGZd9hnT+rv/hD8QxRQK2xhAXzjM5dYq9Q+4=; b=rte+Mh4XhnNANibuwvObP/HxSR
	zcjPGtpOuRBhhT/2Uw/tTbuOXfCv0fqBnSnk/J27+VhBLaJywQpr73Yyq7beKucMFEaa+cUx4yHx/
	bBDhuHObt28XGDW36OtkSNKTnM2MVEdUik4BbyqN5WqfmqcKT4Lde+FGg7f/HvAhd+qU=;
Received: from 127.0.0.1
	by fritzc.com with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim latest)
	(envelope-from <christoph.fritz@hexdev.de>)
	id 1s57EX-001jcC-1A;
	Thu, 09 May 2024 19:07:05 +0200
Message-ID: <a447d09485adf8103b7bb738caff79136dc7bf1b.camel@hexdev.de>
Subject: Re: [PATCH v3 09/11] can: lin: Handle rx offload config frames
From: Christoph Fritz <christoph.fritz@hexdev.de>
Reply-To: christoph.fritz@hexdev.de
To: Ilpo =?ISO-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: Jiri Slaby <jirislaby@kernel.org>, Oliver Hartkopp
 <socketcan@hartkopp.net>,  Marc Kleine-Budde <mkl@pengutronix.de>, Vincent
 Mailhol <mailhol.vincent@wanadoo.fr>, "David S . Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
 <kuba@kernel.org>,  Paolo Abeni <pabeni@redhat.com>, Rob Herring
 <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,  Conor Dooley
 <conor+dt@kernel.org>, Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires
 <bentiss@kernel.org>,  Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Sebastian Reichel <sre@kernel.org>, Linus Walleij
 <linus.walleij@linaro.org>, Andreas Lauser
 <andreas.lauser@mercedes-benz.com>,  Jonathan Corbet <corbet@lwn.net>,
 Pavel Pisa <pisa@cmp.felk.cvut.cz>, linux-can@vger.kernel.org,  Netdev
 <netdev@vger.kernel.org>, devicetree@vger.kernel.org,
 linux-input@vger.kernel.org,  linux-serial <linux-serial@vger.kernel.org>
Date: Thu, 09 May 2024 19:07:04 +0200
In-Reply-To: <9cf35451-9d03-e487-c06b-580208ac3a3d@linux.intel.com>
References: <20240502182804.145926-1-christoph.fritz@hexdev.de>
	 <20240502182804.145926-10-christoph.fritz@hexdev.de>
	 <9cf35451-9d03-e487-c06b-580208ac3a3d@linux.intel.com>
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

On Mon, 2024-05-06 at 20:11 +0300, Ilpo Järvinen wrote:
> On Thu, 2 May 2024, Christoph Fritz wrote:
> 
> > The CAN Broadcast Manager now has the capability to dispatch CANFD
> > frames marked with the id LINBUS_RXOFFLOAD_ID. This patch introduces
> > functionality to interpret these specific frames, enabling the
> > configuration of RX offloading within the LIN driver.
> > 
> > Signed-off-by: Christoph Fritz <christoph.fritz@hexdev.de>
> > ---
> >  drivers/net/can/lin.c | 29 +++++++++++++++++++++++++++++
> >  1 file changed, 29 insertions(+)
> > 
> > diff --git a/drivers/net/can/lin.c b/drivers/net/can/lin.c
> > index 95906003666fb..ee2ebea2c865f 100644
> > --- a/drivers/net/can/lin.c
> > +++ b/drivers/net/can/lin.c
> > @@ -194,6 +194,27 @@ static void lin_remove_sysfs_id_files(struct net_device *ndev)
> >  	}
> >  }
> >  
> > +static int lin_setup_rxoffload(struct lin_device *ldev,
> > +			       struct canfd_frame *cfd)
> > +{
> > +	struct lin_responder_answer answ;
> > +
> > +	if (!(cfd->flags & CANFD_FDF))
> > +		return -EMSGSIZE;
> 
> This seems a bit odd error code.

OK, will be changed in v4 to more common -EINVAL.

> 
> > +	BUILD_BUG_ON(sizeof(struct lin_responder_answer) > sizeof(cfd->data));
> > +	memcpy(&answ, cfd->data, sizeof(struct lin_responder_answer));
> 
> 2x sizeof(answ)

OK

...

thanks
  -- Christoph


