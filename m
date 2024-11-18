Return-Path: <linux-can+bounces-2082-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 99CE99D0B06
	for <lists+linux-can@lfdr.de>; Mon, 18 Nov 2024 09:38:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5F4E9282646
	for <lists+linux-can@lfdr.de>; Mon, 18 Nov 2024 08:38:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D782114A095;
	Mon, 18 Nov 2024 08:38:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b="xMI2PmcG"
X-Original-To: linux-can@vger.kernel.org
Received: from www530.your-server.de (www530.your-server.de [188.40.30.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF80B41C71;
	Mon, 18 Nov 2024 08:38:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=188.40.30.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731919092; cv=none; b=JMGyvvDEzHq8Dr/GegHcKuOuTLlTdiQlvp8srzO5kZF8+uX5cQVZ6bIkj4Xl+61W0VQQAQ2EaeRh4akwNS6Gz6XSmvNKb39w+yjQMTFosiBX7bcYIhreJXeAeUBRoQ0DqSt8Yd2nEjz2lBgqv3FK4GbItlyFluS01QZ8Nr4h45A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731919092; c=relaxed/simple;
	bh=Mg2DqvS2DykVm8ELO3zSX/NqxoFrpfVOjrorNQ6Yv+g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=U/rG8AzPR2Cy1fLnVlcwtgcoam5/dVG/dhSHliZHrxCvvEqA77P83+rLAjDNdLyT+33Jkwzu4RBEmoFpHK2wUVPoVgJ7Kh4JQFLLaZ/0aghd89Z8uV+KhSSWThdT8ULdjLq5ayJNsJ3IJ9oZW1vOPv5/41YjIl7DSauXwZxi9cI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=geanix.com; spf=pass smtp.mailfrom=geanix.com; dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b=xMI2PmcG; arc=none smtp.client-ip=188.40.30.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=geanix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=geanix.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=geanix.com;
	s=default2211; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID; bh=kVWAamB4L0vXXgZc8HB6QQQSIWa6kPeGnIA5GIky6TY=; b=xMI2Pm
	cGaj7DkR9+XkqIMMcoasgntMCnMtkQBA9dvXsvontZYBQkT2+rtKpjlnqjM8yZa98mvOwRZzmJDVO
	k4Eqc9qVtvhgZdBDs4EsMBMM2zepCItwHIKr8m7Ch2C0KZSnSekCUDOpLYmBou1VA3Ne4SsSmSieE
	2Yja2dfRxvp3j9TYW4zuyaCpS0GmOfN0+pqm5K/+6kX4pHYMPTw7Fv1jI5cQ02gpccLqjkelcKCkY
	uLX1VjELxj292rufylNg0dSCce5voeYRr9gp04Xlq5hCP4XBiBWNvFq44nbjIaIsk26an58nEiM5F
	n7uiLJSUA0VdVU9E0+cKS9abi1Qg==;
Received: from sslproxy05.your-server.de ([78.46.172.2])
	by www530.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <sean@geanix.com>)
	id 1tCxGh-0004vU-9c; Mon, 18 Nov 2024 09:37:59 +0100
Received: from [185.17.218.86] (helo=Seans-MacBook-Pro.local)
	by sslproxy05.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <sean@geanix.com>)
	id 1tCxGg-000IZn-2Q;
	Mon, 18 Nov 2024 09:37:58 +0100
Date: Mon, 18 Nov 2024 09:37:58 +0100
From: Sean Nyekjaer <sean@geanix.com>
To: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Cc: Chandrasekar Ramakrishnan <rcsekar@samsung.com>, 
	Marc Kleine-Budde <mkl@pengutronix.de>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, linux-can@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH can-next v2 1/3] can: m_can: add deinit callback
Message-ID: <ijxrgzolqpnnlpgzt22lparoeuqznqxz77ryx7o6tfzc7owp7h@n46bsemyqdxc>
References: <20241115-tcan-standby-v2-0-4eb02026b237@geanix.com>
 <20241115-tcan-standby-v2-1-4eb02026b237@geanix.com>
 <e18c1e3d-4342-4ddc-93d3-975ecc336185@wanadoo.fr>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <e18c1e3d-4342-4ddc-93d3-975ecc336185@wanadoo.fr>
X-Authenticated-Sender: sean@geanix.com
X-Virus-Scanned: Clear (ClamAV 0.103.10/27461/Sun Nov 17 10:35:57 2024)

On Fri, Nov 15, 2024 at 11:23:49PM +0100, Vincent Mailhol wrote:
> On 15/11/2024 at 17:15, Sean Nyekjaer wrote:
> > This is added in preparation for calling standby mode in the tcan4x5x
> > driver or other users of m_can.
> > For the tcan4x5x; If Vsup 12V, standby mode will save 7-8mA, when the
> > interface is down.
> > 
> > Signed-off-by: Sean Nyekjaer <sean@geanix.com>
> > ---
> >  drivers/net/can/m_can/m_can.c | 10 +++++++---
> >  drivers/net/can/m_can/m_can.h |  1 +
> >  2 files changed, 8 insertions(+), 3 deletions(-)
> > 
> > diff --git a/drivers/net/can/m_can/m_can.c b/drivers/net/can/m_can/m_can.c
> > index a7b3bc439ae596527493a73d62b4b7a120ae4e49..667c70f8dc5e7e8b15b667119b63dea1fe667e8a 100644
> > --- a/drivers/net/can/m_can/m_can.c
> > +++ b/drivers/net/can/m_can/m_can.c
> > @@ -1750,12 +1750,16 @@ static void m_can_stop(struct net_device *dev)
> >  
> >  	/* Set init mode to disengage from the network */
> >  	ret = m_can_cccr_update_bits(cdev, CCCR_INIT, CCCR_INIT);
> > -	if (ret)
> > -		netdev_err(dev, "failed to enter standby mode: %pe\n",
> > -			   ERR_PTR(ret));
> >  
> >  	/* set the state as STOPPED */
> >  	cdev->can.state = CAN_STATE_STOPPED;
> > +
> > +	if (!ret && cdev->ops->deinit)
> > +		ret = cdev->ops->deinit(cdev);
> 
> Question: is there a reason not to try to deinit() even if the
> m_can_cccr_update_bits() failed?

Good question.
If the call the m_can core fails, then there bigger problems than setting
the (in nmy case) tcan4x5x in standby mode.

> 
> > +	if (ret)
> > +		netdev_err(dev, "failed to enter standby mode: %pe\n",
> > +			   ERR_PTR(ret));>  }
> >  
> >  static int m_can_close(struct net_device *dev)
> > diff --git a/drivers/net/can/m_can/m_can.h b/drivers/net/can/m_can/m_can.h
> > index 92b2bd8628e6b31370f4accbc2e28f3b2257a71d..6206535341a22a68d7c5570f619e6c4d05e6fcf4 100644
> > --- a/drivers/net/can/m_can/m_can.h
> > +++ b/drivers/net/can/m_can/m_can.h
> > @@ -68,6 +68,7 @@ struct m_can_ops {
> >  	int (*write_fifo)(struct m_can_classdev *cdev, int addr_offset,
> >  			  const void *val, size_t val_count);
> >  	int (*init)(struct m_can_classdev *cdev);
> > +	int (*deinit)(struct m_can_classdev *cdev);
> >  };
> >  
> >  struct m_can_tx_op {
> > 
> 
> Yours sincerely,
> Vincent Mailhol
> 

/Sean

