Return-Path: <linux-can+bounces-3531-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 67679AA8DB5
	for <lists+linux-can@lfdr.de>; Mon,  5 May 2025 09:58:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 48A2E7A20AC
	for <lists+linux-can@lfdr.de>; Mon,  5 May 2025 07:57:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDCEE2AF1B;
	Mon,  5 May 2025 07:58:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="tgbMITn2"
X-Original-To: linux-can@vger.kernel.org
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D77971B424A
	for <linux-can@vger.kernel.org>; Mon,  5 May 2025 07:58:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746431920; cv=none; b=WfRQKLoyF8u8k1MAzUZh2RHq0efAeYXodsu+YYCrYABInZBNdOovCV0DOLwq3FOU+08V6sWwRD06sSMSGQbC5Ig4rfuhNOyFEerl7DHzyKD33LqY+iCo+q9ZlfKiH5whJSnmatuSYL7ve8P4L7D2IwOEFJv9N2e5XwVa6rrgoAs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746431920; c=relaxed/simple;
	bh=AmHa3ycc004iyFGHsYYX4kIfuniFqTXHQQYbVxzJKf8=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=USN1xYgNzAo7JEXNN7kM2jr+5zNjVVlAcn8Fs1PqhT0+eKeD0hzRJxJMFNoJylCmZYQzqu0LTh8T5S0gEX5iSniN6Bm9BmGLNKK7j18SjmefgolTPkbHa5dO8tO/i8KtaEmVcM1lyf1TQq0enb6rbtEPFr+BSZcwlFMBlKFaFGo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=tgbMITn2; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-5e5e8274a74so6178560a12.1
        for <linux-can@vger.kernel.org>; Mon, 05 May 2025 00:58:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1746431917; x=1747036717; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=c8qy8x2VM4E33zP+Ul3MQgzUGob/DpDmmEpO6CEf26s=;
        b=tgbMITn2/f2ETTwPFrP93IMlFsLd90+CvfPcVD1QLAFKoBoEeqNFZ15dGAjijEGpya
         +LmSoF87/BIqjb1f4D+D+/RDVQSG1I4fV3uVktjbqQEb+3Y4xsvjfsewYoOSYYSnDp0m
         g3Nsy45eP6ZlpWfsY1rLF+0rmzXBcQNTQhvn8TX0dEOOhOjsRz7INF3y2DRzdbyt6ftd
         FD14xM0bO2yOFSHhzksOuMMTUhl7KOufLk6b1lWIunZq8Iw4Wgm367VkcmJ17+EJNtJo
         MdwlsIk/Tkp9DDoY6dOVevLFMUcdNtCI+O4/H5ikLHX0d+eIaDE+q1PSWtKXOJjLZfpy
         GJyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746431917; x=1747036717;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=c8qy8x2VM4E33zP+Ul3MQgzUGob/DpDmmEpO6CEf26s=;
        b=QSuGT9bc9gnBAFrhg/mfFJJH5uyO0W4vC8G0dY3TR65MXQHeXGE3z7ReHnPIf5f9kB
         dMpdkX6hisB0ZwJrDpTP3TLczhtSRHLDSvXDxfKm3OFDdPHfU1qC7/pUgUCQhs9SXmB1
         AwwyoJu0zjy/YHELo1n/q8qe6JcT+PkvaXF1TQVkOVRKr4lQ4IfH5/Zm71AAfeSQaIhu
         XMEyF2SKDyiQ8Hdo6j3FeYwOiVATsgRFISZLTikSjQiz1XdlsfJA7hRbiegNBFL2LzHh
         SBknMQBLydf5+E+SqARXUdXxIQceiKl4+lrbNNMg4qjRssHQsWJ7y/8GAgsbbp8+vnAU
         TXuQ==
X-Gm-Message-State: AOJu0YzNjSiMTwerBA1YNKjIYeor76FcbNrpDV/2O+WuvQ8PqpTkX8/b
	AEYF0iZBOu04lRRAcp9/3xd1Px+9EnCIPVXf9IMe+jgBnFaLn5Uuui79d1n5aY4=
X-Gm-Gg: ASbGncv6nEDv7+f9zhARjJygzNL6w+uFC1NK5TTAnHbfK/lHX9lJHkoPzvwFEcb3Hpw
	b1tlNO7AB8CZLXil5Yiqkbmr0Uue9pDuzZSFHj9th3EVy+SBZhom/ljsrFB6arKY5Br+fgGAxwd
	DkIQB2S7qNB/ayhp8yBE8sc2p1Ub8Fxla9iwu5EJQX2LQumU19aSjaFnKRSinoIKbUXBMW9o/8x
	rUNladiJTEiWUrunBSQq8w4V/PGReCyswTf7OWprXI3y2QYufEdy8yjt0J3zgw+0Obui2M/X6kL
	cGYyXEVe3NYvbDw6tn1VDyE29pUNOJjsQdy6QofU8VVdEIHnJcyfQHlHlwiSq/3gXuxn6z8kLaU
	fRzThbMaRqg==
X-Google-Smtp-Source: AGHT+IFZHl2dy4J+tovJB10LLReM42ovfZPhO257ZgiPrn9c3pUOWsbvfuKWtuAGkwm+2riUzR0qbw==
X-Received: by 2002:a05:6402:35c8:b0:5f8:e07c:7746 with SMTP id 4fb4d7f45d1cf-5fab04bfa83mr4760665a12.0.1746431917138;
        Mon, 05 May 2025 00:58:37 -0700 (PDT)
Received: from localhost (dynamic-176-003-040-035.176.3.pool.telefonica.de. [176.3.40.35])
        by smtp.gmail.com with UTF8SMTPSA id 4fb4d7f45d1cf-5fa77b8fbadsm5148712a12.50.2025.05.05.00.58.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 May 2025 00:58:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: multipart/signed;
 boundary=8941660c9a8c947b1652ed122688064937432aafddb64f2deaaf508477a9;
 micalg=pgp-sha512; protocol="application/pgp-signature"
Date: Mon, 05 May 2025 09:58:23 +0200
Message-Id: <D9O2FWGG83V6.L6IQOPRGZL68@baylibre.com>
Cc: <linux-can@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <linux-arm-kernel@lists.infradead.org>,
 <linux-rockchip@lists.infradead.org>, <stable@vger.kernel.org>
Subject: Re: [PATCH 2/3] can: rockchip_canfd: m_can_class_unregister: fix
 order of unregistration calls
From: "Markus Schneider-Pargmann" <msp@baylibre.com>
To: "Marc Kleine-Budde" <mkl@pengutronix.de>, "Manivannan Sadhasivam"
 <manivannan.sadhasivam@linaro.org>, "Thomas Kopp"
 <thomas.kopp@microchip.com>, "Vincent Mailhol"
 <mailhol.vincent@wanadoo.fr>, <kernel@pengutronix.de>, "Heiko Stuebner"
 <heiko@sntech.de>, "Chandrasekar Ramakrishnan" <rcsekar@samsung.com>
X-Mailer: aerc 0.20.1
References: <20250502-can-rx-offload-del-v1-0-59a9b131589d@pengutronix.de>
 <20250502-can-rx-offload-del-v1-2-59a9b131589d@pengutronix.de>
In-Reply-To: <20250502-can-rx-offload-del-v1-2-59a9b131589d@pengutronix.de>

--8941660c9a8c947b1652ed122688064937432aafddb64f2deaaf508477a9
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8

On Fri May 2, 2025 at 4:13 PM CEST, Marc Kleine-Budde wrote:
> If a driver is removed, the driver framework invokes the driver's
> remove callback. A CAN driver's remove function calls
> unregister_candev(), which calls net_device_ops::ndo_stop further down
> in the call stack for interfaces which are in the "up" state.
>
> The removal of the module causes the a warning, as
                                   ^^^
Minor typo here.

Otherwise this looks good to me.

Reviewed-by: Markus Schneider-Pargmann

> can_rx_offload_del() deletes the NAPI, while it is still active,
> because the interface is still up.
>
> To fix the warning, first unregister the network interface, which
> calls net_device_ops::ndo_stop, which disables the NAPI, and then call
> can_rx_offload_del().
>
> Fixes: ff60bfbaf67f ("can: rockchip_canfd: add driver for Rockchip CAN-FD=
 controller")
> Cc: stable@vger.kernel.org
> Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
> ---
>  drivers/net/can/rockchip/rockchip_canfd-core.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/net/can/rockchip/rockchip_canfd-core.c b/drivers/net=
/can/rockchip/rockchip_canfd-core.c
> index 7107a37da36c..c3fb3176ce42 100644
> --- a/drivers/net/can/rockchip/rockchip_canfd-core.c
> +++ b/drivers/net/can/rockchip/rockchip_canfd-core.c
> @@ -937,8 +937,8 @@ static void rkcanfd_remove(struct platform_device *pd=
ev)
>  	struct rkcanfd_priv *priv =3D platform_get_drvdata(pdev);
>  	struct net_device *ndev =3D priv->ndev;
> =20
> -	can_rx_offload_del(&priv->offload);
>  	rkcanfd_unregister(priv);
> +	can_rx_offload_del(&priv->offload);
>  	free_candev(ndev);
>  }
> =20


--8941660c9a8c947b1652ed122688064937432aafddb64f2deaaf508477a9
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iIcEABYKAC8WIQSJYVVm/x+5xmOiprOFwVZpkBVKUwUCaBhvoREcbXNwQGJheWxp
YnJlLmNvbQAKCRCFwVZpkBVKU4zTAP0Yer+WBSFojQ6DiWBCD/1wd9ENW9dsLm7J
ZLeShRvCOAEAgIm8MmcoLnCEO11f0Kg+X9mgAKtZb7OpE86RubTnags=
=jybR
-----END PGP SIGNATURE-----

--8941660c9a8c947b1652ed122688064937432aafddb64f2deaaf508477a9--

