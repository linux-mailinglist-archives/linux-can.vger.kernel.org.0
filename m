Return-Path: <linux-can+bounces-2024-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C5CDC9C83EB
	for <lists+linux-can@lfdr.de>; Thu, 14 Nov 2024 08:24:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 604C81F23ABF
	for <lists+linux-can@lfdr.de>; Thu, 14 Nov 2024 07:24:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FDD51EBA17;
	Thu, 14 Nov 2024 07:24:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b="OUyyjhUm"
X-Original-To: linux-can@vger.kernel.org
Received: from www530.your-server.de (www530.your-server.de [188.40.30.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BD4F1E9074;
	Thu, 14 Nov 2024 07:24:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=188.40.30.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731569048; cv=none; b=KGrpwOODJ8fCF8dZBteEpt+vOgr3ma3+1yNwsSkmd94VOw88RsekqRec/zXyDH/uu9sZTdTArBIln6gF0AQkESIv4FWpsI7P18zQYr928les3z5aMNaxWVqtNrC6QWoCs2lbT4UZLpolNNMHMfdysooKf914PNvWUHnzDFAiY/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731569048; c=relaxed/simple;
	bh=0oXXTZpSK42zNfnhHer/3yWYHM0V0XsCs6PD8wB8Ygg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fYW6vCAE2fGuabYx0O0W+rK6ZpJrqyY7ey+Mv5G+PkN/oSSgjQIz6AhJqPC2k9pqH8xQHyhcw4imHnUBtVI+rrDjFj+mrik3bbSacebsSsj8iPMFSdfxV13sg9xRhmD049Sd/+SspEzBx0mdPNwXv4wP3LM1hXm/Bf9WeNcCq8o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=geanix.com; spf=pass smtp.mailfrom=geanix.com; dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b=OUyyjhUm; arc=none smtp.client-ip=188.40.30.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=geanix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=geanix.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=geanix.com;
	s=default2211; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID; bh=jxs8DLr5gwCV7tb13zFSz59Zio5j0Y8gul9bONvYc40=; b=OUyyjh
	Umf48FrsduFe9j/8aPoDaApLPSB9Qs2GyboLT/hxB3YFmD/m+uJh3si3FzJ6wfRDiEjC4QgdpPpKd
	Wkf4JhfQBOh33XIhOG7b6zPdFv7F8uOUaKWxJdexe7yMYcOztC/5lshu5pZ7mcgb7FQJF+NwsF3ad
	16ltB9ZVBbN/nHO6ojN8LoBgBHe8K95kpnoQaQvRJsGKuituOJjMPrtwbeQhw3msc/81dKyw/A2Af
	/vUNZY+oS74mjfOcJB+WRHbXf4g6dQsRpao8S7sJFAX1KjHoShGmzMH16T2bwQEVuOH3VYEFu1CdH
	RNGDmwkj8jsUjkmX9IYhahScKnDg==;
Received: from sslproxy07.your-server.de ([78.47.199.104])
	by www530.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <sean@geanix.com>)
	id 1tBUCp-000ODi-Kj; Thu, 14 Nov 2024 08:23:55 +0100
Received: from [2a06:4004:10df:0:6905:2e05:f1e4:316f] (helo=Seans-MBP.snzone.dk)
	by sslproxy07.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <sean@geanix.com>)
	id 1tBUCo-000JT3-34;
	Thu, 14 Nov 2024 08:23:55 +0100
Date: Thu, 14 Nov 2024 08:23:54 +0100
From: Sean Nyekjaer <sean@geanix.com>
To: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Cc: Marc Kleine-Budde <mkl@pengutronix.de>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, linux-can@vger.kernel.org, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v2 1/2] can: tcan4x5x: add option for selecting nWKRQ
 voltage
Message-ID: <zgyd3zghhwivsr3b4pcipt2wfc26ypavjygd6lu5tg3k6ztwbr@t52w4p5kyvaa>
References: <20241111-tcan-wkrqv-v2-0-9763519b5252@geanix.com>
 <20241111-tcan-wkrqv-v2-1-9763519b5252@geanix.com>
 <CAMZ6Rq++_yecNY-nNL7NK48ZsNPqH0KDRuqvCCGhUur24+7KGA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAMZ6Rq++_yecNY-nNL7NK48ZsNPqH0KDRuqvCCGhUur24+7KGA@mail.gmail.com>
X-Authenticated-Sender: sean@geanix.com
X-Virus-Scanned: Clear (ClamAV 0.103.10/27457/Wed Nov 13 10:35:46 2024)

Hi Vincent,

On Thu, Nov 14, 2024 at 01:53:34PM +0100, Vincent Mailhol wrote:
> On Mon. 11 Nov. 2024 at 17:55, Sean Nyekjaer <sean@geanix.com> wrote:
> > nWKRQ supports an output voltage of either the internal reference voltage
> > (3.6V) or the reference voltage of the digital interface 0 - 6V.
> > Add the devicetree option ti,nwkrq-voltage-sel to be able to select
> > between them.
> > Default is kept as the internal reference voltage.
> >
> > Signed-off-by: Sean Nyekjaer <sean@geanix.com>
> > ---
> >  drivers/net/can/m_can/tcan4x5x-core.c | 35 +++++++++++++++++++++++++++++++++++
> >  drivers/net/can/m_can/tcan4x5x.h      |  2 ++
> >  2 files changed, 37 insertions(+)
> >

[...]

> >
> > +static int tcan4x5x_get_dt_data(struct m_can_classdev *cdev)
> > +{
> > +       struct tcan4x5x_priv *tcan4x5x = cdev_to_priv(cdev);
> > +       struct device_node *np = cdev->dev->of_node;
> > +       u8 prop;
> > +       int ret;
> > +
> > +       ret = of_property_read_u8(np, "ti,nwkrq-voltage-sel", &prop);
> > +       if (!ret) {
> > +               if (prop <= 1)
> > +                       tcan4x5x->nwkrq_voltage = prop;
> > +               else
> > +                       dev_warn(cdev->dev,
> > +                                "nwkrq-voltage-sel have invalid option: %u\n",
> > +                                prop);
> > +       } else {
> > +               tcan4x5x->nwkrq_voltage = 0;
> > +       }
> 
> If the
> 
>   if (prop <= 1)
> 
> condition fails, you print a warning, but you are not assigning a
> value to tcan4x5x->nwkrq_voltage. Is this intentional?
> 
> What about:
> 
>         tcan4x5x->nwkrq_voltage = 0;
>         ret = of_property_read_u8(np, "ti,nwkrq-voltage-sel", &prop);
>         if (!ret) {
>                 if (prop <= 1)
>                         tcan4x5x->nwkrq_voltage = prop;
>                 else
>                         dev_warn(cdev->dev,
>                                  "nwkrq-voltage-sel have invalid option: %u\n",
>                                  prop);
>         }
> 
> so that you make sure that tcan4x5x->nwkrq_voltage always gets a
> default zero value? Else, if you can make sure that tcan4x5x is always
> zero initialized, you can just drop the
> 
>         tcan4x5x->nwkrq_voltage = 0;
> 
> thing.

Thanks for the review.
You are right, so I reworked this for v3:
https://lore.kernel.org/r/20241112-tcan-wkrqv-v3-0-c66423fba26d@geanix.com

> 
> > +       return 0;
> > +}
> > +

[...]

> >
> >

/Sean

