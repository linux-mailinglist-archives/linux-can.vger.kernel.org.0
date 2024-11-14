Return-Path: <linux-can+bounces-2051-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0146F9C8649
	for <lists+linux-can@lfdr.de>; Thu, 14 Nov 2024 10:37:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BB5C8284F3B
	for <lists+linux-can@lfdr.de>; Thu, 14 Nov 2024 09:37:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BC541F7074;
	Thu, 14 Nov 2024 09:36:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b="0KKA2r4t"
X-Original-To: linux-can@vger.kernel.org
Received: from www530.your-server.de (www530.your-server.de [188.40.30.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 941AB1E47A5;
	Thu, 14 Nov 2024 09:36:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=188.40.30.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731577015; cv=none; b=V+W97gammJa0pu7Un5KCyVBMfFfLOs3fwDvkTUntAYf4PAcadWbclXpbe9fCwoRlSvrdc5ZHbIX/SIJR6qfiTQE+ngIRgFhelcjIGLnhrKAuE9fS+onfErnqPdf8EN15aYvCPll1N/7woy/gxPEDsO8vTOODUAlFGzeBG3XPfK8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731577015; c=relaxed/simple;
	bh=s3QnhZAO5ROD68rkKDuEW3vLNjp1mRO/dhxlIBhyvFk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nq9slNC8Obp4eGd0yCtwSO8RwPP2x8uLoXwWXsYkCkpZRsFiKW+bPPRQzr2zA5ux0LECOs73FNje5v0ll+dy1OxKzt6iupvP+m1vFQp4+U6mNw2xsHPSWSO8eKg9t5jVjDZHBzO3x0H+WFbnnqvtnH9KapAC06H/vfmBEa27EhM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=geanix.com; spf=pass smtp.mailfrom=geanix.com; dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b=0KKA2r4t; arc=none smtp.client-ip=188.40.30.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=geanix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=geanix.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=geanix.com;
	s=default2211; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID; bh=06DiPo7AE62BwZCT/sxN8094QUu3fzWP1D1lacFySp0=; b=0KKA2r
	4tfV7PGVTnyeMJMLSqJnrz5WElMZqz7UAMo7ygbMP6EP+2Xucg9l9RWHL8qhh/kWBkhjb5sVdVVwO
	7QL82EsuwLUvGLKogS9DT6ID5hNYB8ziuC3ChMSMa0vrHBWSU3kEWEVRjhFXlf+iUu5gsXL5Ay03u
	vCFAUByJcWmdaZjtCq/nkH1Y6MlklDC2H1x99uFx1EVtW0+z2j3el2TRCuDpnKD2QhUTcsnniwWwi
	L5RHPk/9R4U+tRNf5OKkR1TmG2PsY/xpp6SXSJAD2UkV4OBhMBX/nvdZ8CDC1brIjiKfWu3NL4LaQ
	jEgC5b9oRZqk82pQ7CUrQqt05ntA==;
Received: from sslproxy06.your-server.de ([78.46.172.3])
	by www530.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <sean@geanix.com>)
	id 1tBWHR-000M7z-Cv; Thu, 14 Nov 2024 10:36:49 +0100
Received: from [2a06:4004:10df:0:6905:2e05:f1e4:316f] (helo=Seans-MacBook-Pro.local)
	by sslproxy06.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <sean@geanix.com>)
	id 1tBWHQ-000HLH-2O;
	Thu, 14 Nov 2024 10:36:48 +0100
Date: Thu, 14 Nov 2024 10:36:48 +0100
From: Sean Nyekjaer <sean@geanix.com>
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: Simon Horman <horms@kernel.org>, 
	Chandrasekar Ramakrishnan <rcsekar@samsung.com>, Vincent Mailhol <mailhol.vincent@wanadoo.fr>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, linux-can@vger.kernel.org, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] can: m_can: add deinit callback
Message-ID: <cjg6hv4wspgiavym5g2mwrx4ranz4payml37fnhzupp2xvqc6f@ckmweysspqto>
References: <20241111-tcan-standby-v1-0-f9337ebaceea@geanix.com>
 <20241111-tcan-standby-v1-1-f9337ebaceea@geanix.com>
 <20241112144603.GR4507@kernel.org>
 <20241114-energetic-denim-chipmunk-577438-mkl@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241114-energetic-denim-chipmunk-577438-mkl@pengutronix.de>
X-Authenticated-Sender: sean@geanix.com
X-Virus-Scanned: Clear (ClamAV 0.103.10/27457/Wed Nov 13 10:35:46 2024)

On Thu, Nov 14, 2024 at 10:34:23AM +0100, Marc Kleine-Budde wrote:
> On 12.11.2024 14:46:03, Simon Horman wrote:
> > On Mon, Nov 11, 2024 at 11:51:23AM +0100, Sean Nyekjaer wrote:
> > > This is added in preparation for calling standby mode in the tcan4x5x
> > > driver or other users of m_can.
> > > For the tcan4x5x; If Vsup is 12V, standby mode will save 7-8mA, when
> > > the interface is down.
> > > 
> > > Signed-off-by: Sean Nyekjaer <sean@geanix.com>
> > > ---
> > >  drivers/net/can/m_can/m_can.c | 3 +++
> > >  drivers/net/can/m_can/m_can.h | 1 +
> > >  2 files changed, 4 insertions(+)
> > > 
> > > diff --git a/drivers/net/can/m_can/m_can.c b/drivers/net/can/m_can/m_can.c
> > > index a7b3bc439ae596527493a73d62b4b7a120ae4e49..a171ff860b7c6992846ae8d615640a40b623e0cb 100644
> > > --- a/drivers/net/can/m_can/m_can.c
> > > +++ b/drivers/net/can/m_can/m_can.c
> > > @@ -1756,6 +1756,9 @@ static void m_can_stop(struct net_device *dev)
> > >  
> > >  	/* set the state as STOPPED */
> > >  	cdev->can.state = CAN_STATE_STOPPED;
> > > +
> > > +	if (cdev->ops->deinit)
> > > +		cdev->ops->deinit(cdev);
> > 
> > Hi Sean,
> > 
> > Perhaps this implementation is in keeping with other m_can code, but
> > I am wondering if either the return value of the callback be returned to
> > the caller, or the return type of the callback be changed to void?
> > 
> > Similarly for calls to callbacks in in patch 3/3.
> 
> please take care of errors/return values.
> 

Will do.
It's also missing for the init callback. Would you like this series to
fix that?

/Sean

