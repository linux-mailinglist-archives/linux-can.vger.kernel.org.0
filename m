Return-Path: <linux-can+bounces-2034-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 78B6C9C8592
	for <lists+linux-can@lfdr.de>; Thu, 14 Nov 2024 10:04:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 38CF62832CF
	for <lists+linux-can@lfdr.de>; Thu, 14 Nov 2024 09:04:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51CFA1DD88E;
	Thu, 14 Nov 2024 09:04:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b="ijfhqiIa"
X-Original-To: linux-can@vger.kernel.org
Received: from www530.your-server.de (www530.your-server.de [188.40.30.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58CA81991CD;
	Thu, 14 Nov 2024 09:04:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=188.40.30.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731575080; cv=none; b=dic5IWTszQjYifIy56pwiEcZRPkx/UgjRaTEJcoI83CPqp2l9yItN1zjGyA28PvEnveTcCJc2zEQNlZbBbcyzA1F5kRU8/3sa1oxQYqZNBeF05MY+nups01YCLF/5sg5iUfyRzVXG12CmEMG9aa+UFX0T1FeJJ16TRoItYQUMGo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731575080; c=relaxed/simple;
	bh=iRPXMOyExoi/69l5RX3rJc18D1pUDb01VAexzrIlrEQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=g0KaTteh5EeuPrxcgBZutt1ActOVHCCPyibli4ZlrWqx6a/hJZRJuIgw2N5cy38C0P8MbE+9/UeB2geNXsTfG4hlRs+4LT3z955aKB4N+5apv+or14SZFrzCbqzR035d/JCRKPksQCPWuYAdLHzYPuiPTbm70eF7EvQT7vUsYNY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=geanix.com; spf=pass smtp.mailfrom=geanix.com; dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b=ijfhqiIa; arc=none smtp.client-ip=188.40.30.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=geanix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=geanix.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=geanix.com;
	s=default2211; h=In-Reply-To:Content-Transfer-Encoding:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID;
	bh=DTask+hWGywo0tXDj4oHwyAVi94Iui8lkNGWuJeSb0w=; b=ijfhqiIaNkSj9Vm9B64Z7ZBM2Z
	DVmR9pHHFBojzICcvhrNdotdtePKjaqRdtGWhQJwckWac4ABDdOhFYgStaWfUG5BlUDgBbLUEBQJI
	JA0l+MHLgu7ousiWQ3Ci70W1VgwbkBjCAaUgdWPlHZKVstKNDco4wXWN45WbYCO+x/JpKbsXvCkgx
	Ne7Ae/THTPKcLxclBAw/DPyRdZEFCeQ6H76zBtG8yYjwwJdvnhgP4Xgnw5+jQ0imFqE3p9yW2Vsq5
	LoixFhmuakyWixoWjfpGHpZonxJ5sDZyX7JFWuvEMMI6Xa9Tvtsbt9ZeQ+D8DJkIKNoGXtiIDxSKx
	B4sa/ESA==;
Received: from sslproxy07.your-server.de ([78.47.199.104])
	by www530.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <sean@geanix.com>)
	id 1tBVmD-000EWr-6H; Thu, 14 Nov 2024 10:04:33 +0100
Received: from [2a06:4004:10df:0:6905:2e05:f1e4:316f] (helo=Seans-MacBook-Pro.local)
	by sslproxy07.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <sean@geanix.com>)
	id 1tBVmC-000H8n-1e;
	Thu, 14 Nov 2024 10:04:32 +0100
Date: Thu, 14 Nov 2024 10:04:31 +0100
From: Sean Nyekjaer <sean@geanix.com>
To: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Cc: Marc Kleine-Budde <mkl@pengutronix.de>, linux-can@vger.kernel.org, 
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>
Subject: Re: [PATCH can-next v3 2/2] can: tcan4x5x: add option for selecting
 nWKRQ voltage
Message-ID: <bmuodxb7xtuwexm7rg6ijepxlyqlwdux37ye2ztwreg7kiynwy@xxt3qvgwebvw>
References: <20241112-tcan-wkrqv-v3-0-c66423fba26d@geanix.com>
 <20241112-tcan-wkrqv-v3-2-c66423fba26d@geanix.com>
 <b61e19bb-58ae-42ac-9863-f1149a812261@wanadoo.fr>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <b61e19bb-58ae-42ac-9863-f1149a812261@wanadoo.fr>
X-Authenticated-Sender: sean@geanix.com
X-Virus-Scanned: Clear (ClamAV 0.103.10/27457/Wed Nov 13 10:35:46 2024)

Hi Vincent,

On Thu, Nov 14, 2024 at 05:59:54PM +0100, Vincent Mailhol wrote:
> Hi Sean,
> 
> I found the v3. I was a bit confused because it was hidden before the v2 in
> my mailbox: the active thread in v2 bump it to the top, thus "shadowing" the
> v3.
> 
> On 12/11/2024 at 23:39, Sean Nyekjaer wrote:
> > nWKRQ supports an output voltage of either the internal reference voltage
> > (3.6V) or the reference voltage of the digital interface 0 - 6V (VIO).
> > Add the devicetree option ti,nwkrq-voltage-vio to set it to VIO.
> > Unset nWKRQ is kept at internal reference voltage.
> > 
> > Signed-off-by: Sean Nyekjaer <sean@geanix.com>
> 
> Notwithstanding of bellow nitpick:
> 
> Reviewed-by: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
> 
> > ---
> >   drivers/net/can/m_can/tcan4x5x-core.c | 20 ++++++++++++++++++++
> >   drivers/net/can/m_can/tcan4x5x.h      |  2 ++
> >   2 files changed, 22 insertions(+)
> > 
> > diff --git a/drivers/net/can/m_can/tcan4x5x-core.c b/drivers/net/can/m_can/tcan4x5x-core.c
> > index 2f73bf3abad889c222f15c39a3d43de1a1cf5fbb..12a375c653cbd255b5dc85faf2f76de397a644ec 100644
> > --- a/drivers/net/can/m_can/tcan4x5x-core.c
> > +++ b/drivers/net/can/m_can/tcan4x5x-core.c
> > @@ -92,6 +92,8 @@
> >   #define TCAN4X5X_MODE_STANDBY BIT(6)
> >   #define TCAN4X5X_MODE_NORMAL BIT(7)
> > +#define TCAN4X5X_NWKRQ_VOLTAGE_VIO BIT(19)
> > +
> >   #define TCAN4X5X_DISABLE_WAKE_MSK	(BIT(31) | BIT(30))
> >   #define TCAN4X5X_DISABLE_INH_MSK	BIT(9)
> > @@ -267,6 +269,13 @@ static int tcan4x5x_init(struct m_can_classdev *cdev)
> >   	if (ret)
> >   		return ret;
> > +	if (tcan4x5x->nwkrq_voltage_vio) {
> > +		ret = regmap_set_bits(tcan4x5x->regmap, TCAN4X5X_CONFIG,
> > +				      TCAN4X5X_NWKRQ_VOLTAGE_VIO);
> > +		if (ret)
> > +			return ret;
> > +	}
> > +
> >   	return ret;>   }
> > @@ -318,6 +327,15 @@ static const struct tcan4x5x_version_info
> >   	return &tcan4x5x_versions[TCAN4X5X];
> >   }
> > +static void tcan4x5x_get_dt_data(struct m_can_classdev *cdev)
> > +{
> > +	struct tcan4x5x_priv *tcan4x5x = cdev_to_priv(cdev);
> > +	struct device_node *np = cdev->dev->of_node;
> > +
> > +	if (of_property_read_bool(np, "ti,nwkrq-voltage-vio"))
> > +		tcan4x5x->nwkrq_voltage_vio = true;
> 
> Nitpick: you can directly assign the value. No need for the if.
> 
> 	tcan4x5x->nwkrq_voltage_vio =
> 		of_property_read_bool(cdev->dev->of_node,
> 				      "ti,nwkrq-voltage-vio");
> 
> My personal preference is to not declare the np variable because it used
> only once but instead directly use cdev->dev->of_node. See this as a
> suggestion. If you prefer to keep as it is, OK for me :)

It looks a lot cleaner :)
Just send v4, with some commit messange changens from Marc.
I will update and sent v5

> 
> > +}
> > +
> >   static int tcan4x5x_get_gpios(struct m_can_classdev *cdev,
> >   			      const struct tcan4x5x_version_info *version_info)
> >   {
> > @@ -453,6 +471,8 @@ static int tcan4x5x_can_probe(struct spi_device *spi)
> >   		goto out_power;
> >   	}
> > +	tcan4x5x_get_dt_data(mcan_class);
> > +
> >   	tcan4x5x_check_wake(priv);
> >   	ret = tcan4x5x_write_tcan_reg(mcan_class, TCAN4X5X_INT_EN, 0);
> > diff --git a/drivers/net/can/m_can/tcan4x5x.h b/drivers/net/can/m_can/tcan4x5x.h
> > index e62c030d3e1e5a713c997e7c8ecad4a44aff4e6a..203399d5e8ccf3fd7a26b54d8356fca9d398524c 100644
> > --- a/drivers/net/can/m_can/tcan4x5x.h
> > +++ b/drivers/net/can/m_can/tcan4x5x.h
> > @@ -42,6 +42,8 @@ struct tcan4x5x_priv {
> >   	struct tcan4x5x_map_buf map_buf_rx;
> >   	struct tcan4x5x_map_buf map_buf_tx;
> > +
> > +	bool nwkrq_voltage_vio;
> >   };
> >   static inline void
> > 
> 
> Yours sincerely,
> Vincent Mailhol
> 

/Sean

