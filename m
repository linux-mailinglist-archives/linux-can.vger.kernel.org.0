Return-Path: <linux-can+bounces-2092-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BEB739D1405
	for <lists+linux-can@lfdr.de>; Mon, 18 Nov 2024 16:08:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 43E051F2426E
	for <lists+linux-can@lfdr.de>; Mon, 18 Nov 2024 15:08:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3B271AC45F;
	Mon, 18 Nov 2024 15:05:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b="u/JZFcvZ"
X-Original-To: linux-can@vger.kernel.org
Received: from www530.your-server.de (www530.your-server.de [188.40.30.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B2FC19D899;
	Mon, 18 Nov 2024 15:05:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=188.40.30.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731942350; cv=none; b=t+Tmzz4oR/38NWiZB5dcGUbt1fcxByu7xY/Z33Q6tfa9psZgVuTV4hL2on+rPKJKh/Py335CEnfz7yukeuUH1PYtCp2iSupDAIDmw/gMWimpZL+4PZ7uxPjDeOGY7jHRSt+ULdWaU8EaK1P9RLulH7RdwX1gHd+NjizxanMQjNw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731942350; c=relaxed/simple;
	bh=zyUf+NHwG8bBi0mmSVonh1jxa8hS+rUaveUXHjV+F/U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QZ8zylj9nBlwXacTv5jg+uUUYMDTP7RXVjk0Bz505lq+szg1xAE4J06V1yQzV16hoH5s+Eb99eUlOJ8EbBU8A56JT+giaujv/bgy0ZcIlvPJ8NqV8JxH0j0X8nl4bdP4llBUfCe4J1EuUpvLNJEvAq89XNcE5ULT/MIF8D1Yu/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=geanix.com; spf=pass smtp.mailfrom=geanix.com; dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b=u/JZFcvZ; arc=none smtp.client-ip=188.40.30.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=geanix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=geanix.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=geanix.com;
	s=default2211; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID; bh=Md4nZg9mLXIh/IjbUDufdZzYT81SSfAjRdvm3pkBvKM=; b=u/JZFc
	vZtCHQ9+p5jjn9WJZfx4bIj6CGVJLz/YjdknlQOOIxEC3l6KHmTBtuvBg6ac6zLXc40aLGE5d4U6b
	ugtMB2myEv+3qCVlShZRzHJZy3eK2LWXfPI7nM7GSzvGnuOfy5cyfbRfpX95H9HNf08FHBkahUP18
	Uwx63JokeYNQ7s1EaLg20uL2t/Wb+sZd6IZg2temlCF7PfDrhYqU7SXvLPSbOLnlHwII2pui5PEHG
	J7roo/Y43hXSwqgjyRQO0/4tNMK6cRBOujEhvaFgFEa1AyYeqVqiVIF9qAx5mwPtbi9XWPWWYvvDK
	tu3xLoQWBUaen5oPFadHJGgE0IsA==;
Received: from sslproxy05.your-server.de ([78.46.172.2])
	by www530.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <sean@geanix.com>)
	id 1tD3Jv-0000B2-OB; Mon, 18 Nov 2024 16:05:43 +0100
Received: from [2a06:4004:10df:0:606b:87c0:8e63:75d0] (helo=Seans-MBP.snzone.dk)
	by sslproxy05.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <sean@geanix.com>)
	id 1tD3Jv-000Nxy-0C;
	Mon, 18 Nov 2024 16:05:43 +0100
Date: Mon, 18 Nov 2024 16:05:42 +0100
From: Sean Nyekjaer <sean@geanix.com>
To: Marc Kleine-Budde <mkl@pengutronix.de>, 
	Vincent Mailhol <mailhol.vincent@wanadoo.fr>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>
Cc: linux-can@vger.kernel.org, linux-kernel@vger.kernel.org, 
	devicetree@vger.kernel.org
Subject: Re: [PATCH can-next v5 2/2] can: tcan4x5x: add option for selecting
 nWKRQ voltage
Message-ID: <clwiowhd5jwf7uzbcbexelsspdpflqhshq6ev5wsabhuugemlp@bbktuqgjd2gg>
References: <20241114-tcan-wkrqv-v5-0-a2d50833ed71@geanix.com>
 <20241114-tcan-wkrqv-v5-2-a2d50833ed71@geanix.com>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241114-tcan-wkrqv-v5-2-a2d50833ed71@geanix.com>
X-Authenticated-Sender: sean@geanix.com
X-Virus-Scanned: Clear (ClamAV 0.103.10/27462/Mon Nov 18 10:41:19 2024)

Hi Marc,

On Thu, Nov 14, 2024 at 10:14:50AM +0100, Sean Nyekjaer wrote:
> The nWKRQ pin supports an output voltage of either the internal reference
> voltage (3.6V) or the reference voltage of
> the digital interface 0-6V (VIO).
> Add the devicetree option ti,nwkrq-voltage-vio to set it to VIO.
> 
> If this property is omitted the reset default, the internal reference
> voltage, is used.
> 
> Signed-off-by: Sean Nyekjaer <sean@geanix.com>
> Reviewed-by: Marc Kleine-Budde <mkl@pengutronix.de>
> Reviewed-by: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
> ---
>  drivers/net/can/m_can/tcan4x5x-core.c | 20 ++++++++++++++++++++
>  drivers/net/can/m_can/tcan4x5x.h      |  2 ++
>  2 files changed, 22 insertions(+)
> 
> diff --git a/drivers/net/can/m_can/tcan4x5x-core.c b/drivers/net/can/m_can/tcan4x5x-core.c
> index 2f73bf3abad889c222f15c39a3d43de1a1cf5fbb..7213d9894c82d079bf92f1ec62d4eebb500cdfa4 100644
> --- a/drivers/net/can/m_can/tcan4x5x-core.c
> +++ b/drivers/net/can/m_can/tcan4x5x-core.c
> @@ -92,6 +92,8 @@
>  #define TCAN4X5X_MODE_STANDBY BIT(6)
>  #define TCAN4X5X_MODE_NORMAL BIT(7)
>  
> +#define TCAN4X5X_NWKRQ_VOLTAGE_VIO BIT(19)
> +
>  #define TCAN4X5X_DISABLE_WAKE_MSK	(BIT(31) | BIT(30))
>  #define TCAN4X5X_DISABLE_INH_MSK	BIT(9)
>  
> @@ -267,6 +269,13 @@ static int tcan4x5x_init(struct m_can_classdev *cdev)
>  	if (ret)
>  		return ret;
>  
> +	if (tcan4x5x->nwkrq_voltage_vio) {
> +		ret = regmap_set_bits(tcan4x5x->regmap, TCAN4X5X_CONFIG,
> +				      TCAN4X5X_NWKRQ_VOLTAGE_VIO);
> +		if (ret)
> +			return ret;
> +	}
> +
>  	return ret;
>  }
>  
> @@ -318,6 +327,15 @@ static const struct tcan4x5x_version_info
>  	return &tcan4x5x_versions[TCAN4X5X];
>  }
>  
> +static void tcan4x5x_get_dt_data(struct m_can_classdev *cdev)
> +{
> +	struct tcan4x5x_priv *tcan4x5x = cdev_to_priv(cdev);
> +	struct device_node *np = cdev->dev->of_node;

Guess we can remove this line. Sorry

> +
> +	tcan4x5x->nwkrq_voltage_vio =
> +		of_property_read_bool(cdev->dev->of_node, "ti,nwkrq-voltage-vio");
> +}
> +
>  static int tcan4x5x_get_gpios(struct m_can_classdev *cdev,
>  			      const struct tcan4x5x_version_info *version_info)
>  {
> @@ -453,6 +471,8 @@ static int tcan4x5x_can_probe(struct spi_device *spi)
>  		goto out_power;
>  	}
>  
> +	tcan4x5x_get_dt_data(mcan_class);
> +
>  	tcan4x5x_check_wake(priv);
>  
>  	ret = tcan4x5x_write_tcan_reg(mcan_class, TCAN4X5X_INT_EN, 0);
> diff --git a/drivers/net/can/m_can/tcan4x5x.h b/drivers/net/can/m_can/tcan4x5x.h
> index e62c030d3e1e5a713c997e7c8ecad4a44aff4e6a..203399d5e8ccf3fd7a26b54d8356fca9d398524c 100644
> --- a/drivers/net/can/m_can/tcan4x5x.h
> +++ b/drivers/net/can/m_can/tcan4x5x.h
> @@ -42,6 +42,8 @@ struct tcan4x5x_priv {
>  
>  	struct tcan4x5x_map_buf map_buf_rx;
>  	struct tcan4x5x_map_buf map_buf_tx;
> +
> +	bool nwkrq_voltage_vio;
>  };
>  
>  static inline void
> 
> -- 
> 2.46.2
> 

/Sean

