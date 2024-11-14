Return-Path: <linux-can+bounces-2030-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4ABE89C856F
	for <lists+linux-can@lfdr.de>; Thu, 14 Nov 2024 10:00:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 00C122846F8
	for <lists+linux-can@lfdr.de>; Thu, 14 Nov 2024 09:00:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BBB81DE3C5;
	Thu, 14 Nov 2024 09:00:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="PbWOKbBF"
X-Original-To: linux-can@vger.kernel.org
Received: from smtp.smtpout.orange.fr (smtp-14.smtpout.orange.fr [80.12.242.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 718591DD88E;
	Thu, 14 Nov 2024 09:00:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.12.242.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731574807; cv=none; b=tiIgpN/tuMb/DUTCt2+9x9XY8HRHZ72jN6hA8+zIfeStW+Lr2Y0rxAby2U/4G4HbijvgTY2vJtlOktiE14jDfeOstpCkBX1jp9vTRzhIM1Z5PC7r7Ys/KjLDPBkaP5Es9sfMplqBXNUagV8+mzrg1HgOm+msT/4ALF70rdEm1PQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731574807; c=relaxed/simple;
	bh=tHgETJh6q0a6RwLWb3N/BAFGOGfYysZHUouWClPmIVA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ib6nvAtUvB3QrrNJ4We/L+pUuaJ2lrNJlrn4QUw+fdLrzbFvYMeeLRbMm7sruPM7Yl6mfdsGMgx+kzSKlyI8gMfDhtGcloqXfXe/4ehP+UGM+8imaDyDwbfftZmrISu8xRvFXZxmEGFQeMr8iIIX2HhwnKSLEQ7UihzKWR7mqMg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=wanadoo.fr; dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b=PbWOKbBF; arc=none smtp.client-ip=80.12.242.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Received: from [172.16.82.72] ([124.33.176.97])
	by smtp.orange.fr with ESMTPA
	id BVhkt4BxOTH7uBVhltbT91; Thu, 14 Nov 2024 10:00:02 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1731574802;
	bh=qfAPja5nxmvS/eNQ5AEWGMFtdocK7/uYPepg1UWiENo=;
	h=Message-ID:Date:MIME-Version:Subject:To:From;
	b=PbWOKbBFBw06WyKPov8uVaqYo9k6wCqHbAajOfkXPSu+dLmroh9E1XZ2UOM8ApCNL
	 cdt4yLD4c2DaYX0do9NW9TTY+Y9/H44rXI0jouSkCoc+1mOxFz4WBlT6U+VNWmVWNm
	 H33OEMEpwP7tJml1/rAwEt+/KdXiwdt2ZTzFe2CZoNwstvp3X1rLaDKvGqQ4fVxC7s
	 RJvIN4EVZSEGOFEGLhiO805C/47QdLq2/u/lOE3wpWnbojHk+naAq0YcQ7eQnctfpX
	 m51eOdDvG8CbvY8Oeh7FibG/z4qNi5nDhne1BUM8LmxNLkkkTHWJ1yt2hMB4Dzomj2
	 fQOupxlZlUNAA==
X-ME-Helo: [172.16.82.72]
X-ME-Auth: bWFpbGhvbC52aW5jZW50QHdhbmFkb28uZnI=
X-ME-Date: Thu, 14 Nov 2024 10:00:02 +0100
X-ME-IP: 124.33.176.97
Message-ID: <b61e19bb-58ae-42ac-9863-f1149a812261@wanadoo.fr>
Date: Thu, 14 Nov 2024 17:59:54 +0900
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH can-next v3 2/2] can: tcan4x5x: add option for selecting
 nWKRQ voltage
To: Sean Nyekjaer <sean@geanix.com>, Marc Kleine-Budde <mkl@pengutronix.de>
Cc: linux-can@vger.kernel.org, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>
References: <20241112-tcan-wkrqv-v3-0-c66423fba26d@geanix.com>
 <20241112-tcan-wkrqv-v3-2-c66423fba26d@geanix.com>
Content-Language: en-US
From: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
In-Reply-To: <20241112-tcan-wkrqv-v3-2-c66423fba26d@geanix.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Sean,

I found the v3. I was a bit confused because it was hidden before the v2 
in my mailbox: the active thread in v2 bump it to the top, thus 
"shadowing" the v3.

On 12/11/2024 at 23:39, Sean Nyekjaer wrote:
> nWKRQ supports an output voltage of either the internal reference voltage
> (3.6V) or the reference voltage of the digital interface 0 - 6V (VIO).
> Add the devicetree option ti,nwkrq-voltage-vio to set it to VIO.
> Unset nWKRQ is kept at internal reference voltage.
> 
> Signed-off-by: Sean Nyekjaer <sean@geanix.com>

Notwithstanding of bellow nitpick:

Reviewed-by: Vincent Mailhol <mailhol.vincent@wanadoo.fr>

> ---
>   drivers/net/can/m_can/tcan4x5x-core.c | 20 ++++++++++++++++++++
>   drivers/net/can/m_can/tcan4x5x.h      |  2 ++
>   2 files changed, 22 insertions(+)
> 
> diff --git a/drivers/net/can/m_can/tcan4x5x-core.c b/drivers/net/can/m_can/tcan4x5x-core.c
> index 2f73bf3abad889c222f15c39a3d43de1a1cf5fbb..12a375c653cbd255b5dc85faf2f76de397a644ec 100644
> --- a/drivers/net/can/m_can/tcan4x5x-core.c
> +++ b/drivers/net/can/m_can/tcan4x5x-core.c
> @@ -92,6 +92,8 @@
>   #define TCAN4X5X_MODE_STANDBY BIT(6)
>   #define TCAN4X5X_MODE_NORMAL BIT(7)
>   
> +#define TCAN4X5X_NWKRQ_VOLTAGE_VIO BIT(19)
> +
>   #define TCAN4X5X_DISABLE_WAKE_MSK	(BIT(31) | BIT(30))
>   #define TCAN4X5X_DISABLE_INH_MSK	BIT(9)
>   
> @@ -267,6 +269,13 @@ static int tcan4x5x_init(struct m_can_classdev *cdev)
>   	if (ret)
>   		return ret;
>   
> +	if (tcan4x5x->nwkrq_voltage_vio) {
> +		ret = regmap_set_bits(tcan4x5x->regmap, TCAN4X5X_CONFIG,
> +				      TCAN4X5X_NWKRQ_VOLTAGE_VIO);
> +		if (ret)
> +			return ret;
> +	}
> +
>   	return ret;>   }
>   
> @@ -318,6 +327,15 @@ static const struct tcan4x5x_version_info
>   	return &tcan4x5x_versions[TCAN4X5X];
>   }
>   
> +static void tcan4x5x_get_dt_data(struct m_can_classdev *cdev)
> +{
> +	struct tcan4x5x_priv *tcan4x5x = cdev_to_priv(cdev);
> +	struct device_node *np = cdev->dev->of_node;
> +
> +	if (of_property_read_bool(np, "ti,nwkrq-voltage-vio"))
> +		tcan4x5x->nwkrq_voltage_vio = true;

Nitpick: you can directly assign the value. No need for the if.

	tcan4x5x->nwkrq_voltage_vio =
		of_property_read_bool(cdev->dev->of_node,
				      "ti,nwkrq-voltage-vio");

My personal preference is to not declare the np variable because it used 
only once but instead directly use cdev->dev->of_node. See this as a 
suggestion. If you prefer to keep as it is, OK for me :)

> +}
> +
>   static int tcan4x5x_get_gpios(struct m_can_classdev *cdev,
>   			      const struct tcan4x5x_version_info *version_info)
>   {
> @@ -453,6 +471,8 @@ static int tcan4x5x_can_probe(struct spi_device *spi)
>   		goto out_power;
>   	}
>   
> +	tcan4x5x_get_dt_data(mcan_class);
> +
>   	tcan4x5x_check_wake(priv);
>   
>   	ret = tcan4x5x_write_tcan_reg(mcan_class, TCAN4X5X_INT_EN, 0);
> diff --git a/drivers/net/can/m_can/tcan4x5x.h b/drivers/net/can/m_can/tcan4x5x.h
> index e62c030d3e1e5a713c997e7c8ecad4a44aff4e6a..203399d5e8ccf3fd7a26b54d8356fca9d398524c 100644
> --- a/drivers/net/can/m_can/tcan4x5x.h
> +++ b/drivers/net/can/m_can/tcan4x5x.h
> @@ -42,6 +42,8 @@ struct tcan4x5x_priv {
>   
>   	struct tcan4x5x_map_buf map_buf_rx;
>   	struct tcan4x5x_map_buf map_buf_tx;
> +
> +	bool nwkrq_voltage_vio;
>   };
>   
>   static inline void
> 

Yours sincerely,
Vincent Mailhol


