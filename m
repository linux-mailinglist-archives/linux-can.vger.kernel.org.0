Return-Path: <linux-can+bounces-2531-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 73EBAA00965
	for <lists+linux-can@lfdr.de>; Fri,  3 Jan 2025 13:42:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 529CE3A3F3A
	for <lists+linux-can@lfdr.de>; Fri,  3 Jan 2025 12:42:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32B1F1A8409;
	Fri,  3 Jan 2025 12:42:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b="O6GsVT1X"
X-Original-To: linux-can@vger.kernel.org
Received: from www530.your-server.de (www530.your-server.de [188.40.30.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAB3E13AD0;
	Fri,  3 Jan 2025 12:42:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=188.40.30.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735908132; cv=none; b=diI/3Gn/LUavjZU5sqD0iulQI0J08XoK3dZekJpKFMdWDB1c/h4t+xvo4IHpr6yTjoegXDX+wSLkna2PBYAWSCQTSZE/MARveDVufaoqO0JmDL5M5EjbYvdfWCK+cw6Cc2t7l+ghgO2IxxFax4tVcFQyB8kO6H6zVF/M7hldJpk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735908132; c=relaxed/simple;
	bh=bO8/dVTnZPvMWTMsHQngFWEhaJho18CdgR5bOVbC8Wo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=i0aScbKHymtMho2pa28sswGvGfp7H65YFbOtRGa5IHO0bAjZNL6Sf/CWxZ4Is63CBY2nPllfgN2iG0vHTQc7/fBsy7wmiDi+w78Q9W8UTbDpfzP2jN2y3FK16bnZHCt/0qabQnLXwL51iebG6dTNhz0uRcKgrr7WbXdi94Z+V6I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=geanix.com; spf=pass smtp.mailfrom=geanix.com; dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b=O6GsVT1X; arc=none smtp.client-ip=188.40.30.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=geanix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=geanix.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=geanix.com;
	s=default2211; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID; bh=63DDlv1B8ESMghis3VptMZqGDW2+EMqgGuNLkv78d9o=; b=O6GsVT
	1XKFgi/a2FK2rPu+nEt1uFWk6P6u1MC7umNuJcjd0wDWg8WJVtMSIymH9D/FH9qvU4vyMNecBLs/T
	SDZ9/Cjh+Ekz4FB5dEhIT//glH4fi6wFgY1znsJaMRT0cTKr6lhk4tWp1nzz7uZxJ2JrF4zsxLyxZ
	s4CW/IE7w2JTOkyNB4pul/hvaNv2fdGBMh9eR/AUbHzclKMLAS4cotS8UvT76N8DNrdoNwNxjKeQG
	9pEUlrucS8/qZjYjJY8zBTzilg91XmxDzQXy1RZZShrupZGZ1Qv9ATvJx57vvHlLghgPRRDMHHTu0
	0f0wF0pp7TXfpo9TKmVxunASTVlA==;
Received: from sslproxy02.your-server.de ([78.47.166.47])
	by www530.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96.2)
	(envelope-from <sean@geanix.com>)
	id 1tTgrM-0003Ff-0T;
	Fri, 03 Jan 2025 13:33:00 +0100
Received: from [2a06:4004:10df:0:9e0:2602:be72:b34a] (helo=Seans-MBP.snzone.dk)
	by sslproxy02.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <sean@geanix.com>)
	id 1tTgrL-000HJ8-1k;
	Fri, 03 Jan 2025 13:32:59 +0100
Date: Fri, 3 Jan 2025 13:32:58 +0100
From: Sean Nyekjaer <sean@geanix.com>
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: Vincent Mailhol <mailhol.vincent@wanadoo.fr>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, linux-can@vger.kernel.org, 
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH can-next v5 2/2] can: tcan4x5x: add option for selecting
 nWKRQ voltage
Message-ID: <fndziki656cxg353f7bldt7s5dm2ybaq4e2foou3eb74savebx@q6uyltlj2klv>
References: <20241114-tcan-wkrqv-v5-0-a2d50833ed71@geanix.com>
 <20241114-tcan-wkrqv-v5-2-a2d50833ed71@geanix.com>
 <clwiowhd5jwf7uzbcbexelsspdpflqhshq6ev5wsabhuugemlp@bbktuqgjd2gg>
 <20241118-impetuous-mackerel-of-glamour-f482ed-mkl@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241118-impetuous-mackerel-of-glamour-f482ed-mkl@pengutronix.de>
X-Authenticated-Sender: sean@geanix.com
X-Virus-Scanned: Clear (ClamAV 1.0.7/27507/Fri Jan  3 10:40:57 2025)

On Mon, Nov 18, 2024 at 04:14:09PM +0100, Marc Kleine-Budde wrote:
> On 18.11.2024 16:05:42, Sean Nyekjaer wrote:
> > Hi Marc,
> > 
> > On Thu, Nov 14, 2024 at 10:14:50AM +0100, Sean Nyekjaer wrote:
> > > The nWKRQ pin supports an output voltage of either the internal reference
> > > voltage (3.6V) or the reference voltage of
> > > the digital interface 0-6V (VIO).
> > > Add the devicetree option ti,nwkrq-voltage-vio to set it to VIO.
> > > 
> > > If this property is omitted the reset default, the internal reference
> > > voltage, is used.
> > > 
> > > Signed-off-by: Sean Nyekjaer <sean@geanix.com>
> > > Reviewed-by: Marc Kleine-Budde <mkl@pengutronix.de>
> > > Reviewed-by: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
> > > ---
> > >  drivers/net/can/m_can/tcan4x5x-core.c | 20 ++++++++++++++++++++
> > >  drivers/net/can/m_can/tcan4x5x.h      |  2 ++
> > >  2 files changed, 22 insertions(+)
> > > 
> > > diff --git a/drivers/net/can/m_can/tcan4x5x-core.c b/drivers/net/can/m_can/tcan4x5x-core.c
> > > index 2f73bf3abad889c222f15c39a3d43de1a1cf5fbb..7213d9894c82d079bf92f1ec62d4eebb500cdfa4 100644
> > > --- a/drivers/net/can/m_can/tcan4x5x-core.c
> > > +++ b/drivers/net/can/m_can/tcan4x5x-core.c
> > > @@ -92,6 +92,8 @@
> > >  #define TCAN4X5X_MODE_STANDBY BIT(6)
> > >  #define TCAN4X5X_MODE_NORMAL BIT(7)
> > >  
> > > +#define TCAN4X5X_NWKRQ_VOLTAGE_VIO BIT(19)
> > > +
> > >  #define TCAN4X5X_DISABLE_WAKE_MSK	(BIT(31) | BIT(30))
> > >  #define TCAN4X5X_DISABLE_INH_MSK	BIT(9)
> > >  
> > > @@ -267,6 +269,13 @@ static int tcan4x5x_init(struct m_can_classdev *cdev)
> > >  	if (ret)
> > >  		return ret;
> > >  
> > > +	if (tcan4x5x->nwkrq_voltage_vio) {
> > > +		ret = regmap_set_bits(tcan4x5x->regmap, TCAN4X5X_CONFIG,
> > > +				      TCAN4X5X_NWKRQ_VOLTAGE_VIO);
> > > +		if (ret)
> > > +			return ret;
> > > +	}
> > > +
> > >  	return ret;
> > >  }
> > >  
> > > @@ -318,6 +327,15 @@ static const struct tcan4x5x_version_info
> > >  	return &tcan4x5x_versions[TCAN4X5X];
> > >  }
> > >  
> > > +static void tcan4x5x_get_dt_data(struct m_can_classdev *cdev)
> > > +{
> > > +	struct tcan4x5x_priv *tcan4x5x = cdev_to_priv(cdev);
> > > +	struct device_node *np = cdev->dev->of_node;
> > 
> > Guess we can remove this line. Sorry
> 
> ACK. Will fixup here.

Remenber to do the fixup :)

Sorry for the extra work

/Sean

