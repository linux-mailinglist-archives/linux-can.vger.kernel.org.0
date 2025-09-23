Return-Path: <linux-can+bounces-4905-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EF12B95C67
	for <lists+linux-can@lfdr.de>; Tue, 23 Sep 2025 14:06:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 12B31168A9B
	for <lists+linux-can@lfdr.de>; Tue, 23 Sep 2025 12:06:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E0463218D2;
	Tue, 23 Sep 2025 12:06:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="s0xWiVPf"
X-Original-To: linux-can@vger.kernel.org
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B08E03218AE
	for <linux-can@vger.kernel.org>; Tue, 23 Sep 2025 12:06:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758629198; cv=none; b=Sewkx1aRzPJFHwkPRnIGRn0U22jSXN6K/qC8IAtAuBVBhkG39FjgRjtLplZidq7AbrYEjwhkfGQkScSdTHB6vmWL1FgoTTIzcxmZWEhfAmhuqfdCh/OdTBNn0/5CobAFLfWqjoas35wUY+UyI3Jvej5I1ZADSFlDkaSVlGnQc1M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758629198; c=relaxed/simple;
	bh=dL6Sbjf2WjXJVDvlHvx9o3+7LVoOtdtJ7JYD541TrmA=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:From:To:Cc:
	 References:In-Reply-To; b=MCYxOB4Dm7/xUGurNOeW29gaGsNAREpGzWEllb/hXpiPmTqGDpgIjbE4VjT/cdZZtk7zLyhk3h3N7ByVz729hE6wgYeaUjHxknuDJBM1A04Zml9zHJ9ipWKN7CwPuQXmigL8BRYhTBIuL6dcrKyba2zcwoV4wKZJ4xHDtTSpfY8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=s0xWiVPf; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-631845b51e2so3741503a12.3
        for <linux-can@vger.kernel.org>; Tue, 23 Sep 2025 05:06:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1758629193; x=1759233993; darn=vger.kernel.org;
        h=in-reply-to:references:cc:to:from:subject:message-id:date
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=TzgYaDcVYTh+uH9MLuxhjeMOWUtDpeDEtCYZFKIrTUE=;
        b=s0xWiVPfNKio9OOCM/E4f8EmqzfWmeq7Z3JfcP1MPCU5k0KwYEIqEibFvgZ/k6xJzx
         6Sc8Sev9x8OfLMyOp6bvwjYTrG+30fHaA4wosy5Mz7F53kKurLse7HGjZ/Yz8+La226K
         FIykxOpE7q1S0QB8Phpvi+XqpSfJFKZ6WXq/yVGzuvZFNv9LASop3TT+9WajjAd9uH2y
         kq4NdVQnqTm5JnA6UclmiF9kngv/68hs9H6YmyvWQUTk1RpByLhx/b4mHinD8pLwVDUC
         lXlJ15q27TNspwoZI6f0FZDUbUFYS2DCNsFqoOarpvT740PxnwHnaYVQIS5GxOgyc4kw
         MsjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758629193; x=1759233993;
        h=in-reply-to:references:cc:to:from:subject:message-id:date
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TzgYaDcVYTh+uH9MLuxhjeMOWUtDpeDEtCYZFKIrTUE=;
        b=jdYPiawHftXkFBUyu9vIDZMEF4az+mhctj/nGXEqvfX6NQnmVottF9uXcjAKnVvH7F
         UaWMA6ICUoSVLVbTRisI3XyrlK0Zkng9lhB9nSPb9KWaX5nX+AwBaL5XQKS5JI2dYOtN
         bzlPn1K2FxOegE6uKJz6e7C4Gv9MZL43x2La4tc883D9o/kZXB8QwP2pICBLR8jaPhTv
         sIr/nwU3VlbfnwfCUv9mxHuIarSiPQMccmZnaRFbpmxhgEudStcqnkswcDXxnxygM+7f
         2usWGymuEth1f5r1Y5YBydhpAGdB4Ipf5AL8ytrXrau3TOaXY9JHk+vPo5TDspqJWy+f
         EIgQ==
X-Gm-Message-State: AOJu0YzvLy3Ls0qKOcNJH7+yNS+JGxaCOM8K9Vt9n+XCUh5S8nxdFIC+
	0DnY/j0FQ+Xm1nLXWcNon3PvhraOGWkV7o5xzlSxTuykKHsv5kzYBf0BNOzFfWG16Vg=
X-Gm-Gg: ASbGnctCcqwfYweUm/n7IuNlqHRtyan1NMH9RNMrtAslXzOakn8X9cZiIXKO7s4fkm2
	ZbJaQNvIJVP/SMJ9z1YcF6KYNZSL17AVrCpuOKiDKaZcznvEOkzMDqv/mo0/YfnM/Q43OtS0rZD
	UOQlOa9z2Nl620+XQzZYxRRUwqYV6M4/BRqeooOTak3vlQFxRGjYDXhEw8nR7DjsPiGn2k4ghc7
	4/0PR0wRCpUpAqv3VqDZGr/wag8+/+6BYZujnjvAwIUQcsMenIIrhbnlNrdHIDwAZJf34WjaXjP
	CR2EzIVhBrB17U03XYlH/ucdz2P9+aPxxvyxoewfIYrWtIGTpRtMwk4Z8HBw6rMzTHib6XupGT4
	8pScQ9pw8GfO1CYSbaY9strovOA==
X-Google-Smtp-Source: AGHT+IEljb4qDG+o9NStpXxrAsoP6MQE/BdOohuXircqwazFZXZPrU98FQAPprhXvBzxJqY4x9mGwA==
X-Received: by 2002:a05:6402:24c2:b0:62f:be4f:23f9 with SMTP id 4fb4d7f45d1cf-6346780bda3mr1715991a12.20.1758629192888;
        Tue, 23 Sep 2025 05:06:32 -0700 (PDT)
Received: from localhost ([195.52.61.108])
        by smtp.gmail.com with UTF8SMTPSA id 4fb4d7f45d1cf-62fa5d4189bsm10622955a12.19.2025.09.23.05.06.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Sep 2025 05:06:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: multipart/signed;
 boundary=d4d8b7b0c42d01bcf2bf3797a2f5010388e139442df69dd44189344546f3;
 micalg=pgp-sha512; protocol="application/pgp-signature"
Date: Tue, 23 Sep 2025 14:06:19 +0200
Message-Id: <DD060JZB8IFB.3CDD2Q7MM9O31@baylibre.com>
Subject: Re: [PATCH v3 6/6] can: m_can: add optional support for reset
From: "Markus Schneider-Pargmann" <msp@baylibre.com>
To: "Marc Kleine-Budde" <mkl@pengutronix.de>, "Chandrasekar Ramakrishnan"
 <rcsekar@samsung.com>, "Vincent Mailhol" <mailhol@kernel.org>, "Patrik
 Flykt" <patrik.flykt@linux.intel.com>, "Dong Aisheng"
 <b29396@freescale.com>, "Varka Bhadram" <varkabhadram@gmail.com>, "Wu Bo"
 <wubo.oduw@gmail.com>, "Markus Schneider-Pargmann" <msp@baylibre.com>,
 "Philipp Zabel" <p.zabel@pengutronix.de>
Cc: <linux-can@vger.kernel.org>, <kernel@pengutronix.de>
X-Mailer: aerc 0.21.0
References: <20250923-m_can-fix-state-handling-v3-0-06d8baccadbf@pengutronix.de> <20250923-m_can-fix-state-handling-v3-6-06d8baccadbf@pengutronix.de>
In-Reply-To: <20250923-m_can-fix-state-handling-v3-6-06d8baccadbf@pengutronix.de>

--d4d8b7b0c42d01bcf2bf3797a2f5010388e139442df69dd44189344546f3
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8

On Tue Sep 23, 2025 at 11:17 AM CEST, Marc Kleine-Budde wrote:
> In some SoCs (observed on the STM32MP15) the M_CAN IP core keeps the
> CAN state and CAN error counters over an internal reset cycle. The
> STM32MP15 SoC provides an external reset, which is shared between both
> M_CAN cores.
>
> Add support for an optional external reset. Take care of shared
> resets, de-assert reset during the probe phase in
> m_can_class_register() and while the interface is up, assert the reset
> otherwise.
>
> Reviewed-by: Philipp Zabel <p.zabel@pengutronix.de>
> Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>

Reviewed-by: Markus Schneider-Pargmann <msp@baylibre.com>

> ---
>  drivers/net/can/m_can/m_can.c | 27 ++++++++++++++++++++++++---
>  drivers/net/can/m_can/m_can.h |  1 +
>  2 files changed, 25 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/net/can/m_can/m_can.c b/drivers/net/can/m_can/m_can.=
c
> index afbab6ca5833..e6c3b089c368 100644
> --- a/drivers/net/can/m_can/m_can.c
> +++ b/drivers/net/can/m_can/m_can.c
> @@ -23,6 +23,7 @@
>  #include <linux/pinctrl/consumer.h>
>  #include <linux/platform_device.h>
>  #include <linux/pm_runtime.h>
> +#include <linux/reset.h>
> =20
>  #include "m_can.h"
> =20
> @@ -1831,6 +1832,7 @@ static int m_can_close(struct net_device *dev)
> =20
>  	close_candev(dev);
> =20
> +	reset_control_assert(cdev->rst);
>  	m_can_clk_stop(cdev);
>  	phy_power_off(cdev->transceiver);
> =20
> @@ -2073,11 +2075,15 @@ static int m_can_open(struct net_device *dev)
>  	if (err)
>  		goto out_phy_power_off;
> =20
> +	err =3D reset_control_deassert(cdev->rst);
> +	if (err)
> +		goto exit_disable_clks;
> +
>  	/* open the can device */
>  	err =3D open_candev(dev);
>  	if (err) {
>  		netdev_err(dev, "failed to open can device\n");
> -		goto exit_disable_clks;
> +		goto out_reset_control_assert;
>  	}
> =20
>  	if (cdev->is_peripheral)
> @@ -2133,6 +2139,8 @@ static int m_can_open(struct net_device *dev)
>  	else
>  		napi_disable(&cdev->napi);
>  	close_candev(dev);
> +out_reset_control_assert:
> +	reset_control_assert(cdev->rst);
>  exit_disable_clks:
>  	m_can_clk_stop(cdev);
>  out_phy_power_off:
> @@ -2423,15 +2431,24 @@ int m_can_class_register(struct m_can_classdev *c=
dev)
>  		}
>  	}
> =20
> +	cdev->rst =3D devm_reset_control_get_optional_shared(cdev->dev, NULL);
> +	if (IS_ERR(cdev->rst))
> +		return dev_err_probe(cdev->dev, PTR_ERR(cdev->rst),
> +				     "Failed to get reset line\n");
> +
>  	ret =3D m_can_clk_start(cdev);
>  	if (ret)
>  		return ret;
> =20
> +	ret =3D reset_control_deassert(cdev->rst);
> +	if (ret)
> +		goto clk_disable;
> +
>  	if (cdev->is_peripheral) {
>  		ret =3D can_rx_offload_add_manual(cdev->net, &cdev->offload,
>  						NAPI_POLL_WEIGHT);
>  		if (ret)
> -			goto clk_disable;
> +			goto out_reset_control_assert;
>  	}
> =20
>  	if (!cdev->net->irq) {
> @@ -2460,8 +2477,10 @@ int m_can_class_register(struct m_can_classdev *cd=
ev)
>  		 KBUILD_MODNAME, cdev->net->irq, cdev->version);
> =20
>  	/* Probe finished
> -	 * Stop clocks. They will be reactivated once the M_CAN device is opene=
d
> +	 * Assert reset and stop clocks.
> +	 * They will be reactivated once the M_CAN device is opened
>  	 */
> +	reset_control_assert(cdev->rst);
>  	m_can_clk_stop(cdev);
> =20
>  	return 0;
> @@ -2469,6 +2488,8 @@ int m_can_class_register(struct m_can_classdev *cde=
v)
>  rx_offload_del:
>  	if (cdev->is_peripheral)
>  		can_rx_offload_del(&cdev->offload);
> +out_reset_control_assert:
> +	reset_control_assert(cdev->rst);
>  clk_disable:
>  	m_can_clk_stop(cdev);
> =20
> diff --git a/drivers/net/can/m_can/m_can.h b/drivers/net/can/m_can/m_can.=
h
> index bd4746c63af3..7b7600697c6b 100644
> --- a/drivers/net/can/m_can/m_can.h
> +++ b/drivers/net/can/m_can/m_can.h
> @@ -86,6 +86,7 @@ struct m_can_classdev {
>  	struct device *dev;
>  	struct clk *hclk;
>  	struct clk *cclk;
> +	struct reset_control *rst;
> =20
>  	struct workqueue_struct *tx_wq;
>  	struct phy *transceiver;


--d4d8b7b0c42d01bcf2bf3797a2f5010388e139442df69dd44189344546f3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iKMEABYKAEsWIQSJYVVm/x+5xmOiprOFwVZpkBVKUwUCaNKNPRsUgAAAAAAEAA5t
YW51MiwyLjUrMS4xMSwyLDIRHG1zcEBiYXlsaWJyZS5jb20ACgkQhcFWaZAVSlMM
aAD9FO3jQt/fdr9MClW+ZtCSATTGlwBDYc410GwJ2jUNEpABAIWoMCwJhYcqN1ry
+Z0gmz8LEb+C9EAgdOkc/P/CxuID
=/oTU
-----END PGP SIGNATURE-----

--d4d8b7b0c42d01bcf2bf3797a2f5010388e139442df69dd44189344546f3--

