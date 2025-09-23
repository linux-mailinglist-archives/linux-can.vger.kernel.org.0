Return-Path: <linux-can+bounces-4906-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 18280B95C7F
	for <lists+linux-can@lfdr.de>; Tue, 23 Sep 2025 14:10:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 28D8C188AC17
	for <lists+linux-can@lfdr.de>; Tue, 23 Sep 2025 12:10:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55522321440;
	Tue, 23 Sep 2025 12:10:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="1Eb9ob93"
X-Original-To: linux-can@vger.kernel.org
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B4F93218D2
	for <linux-can@vger.kernel.org>; Tue, 23 Sep 2025 12:10:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758629403; cv=none; b=HIJXUbgXnAPZarkJzD9NYoX4somKk8mCDwVyd+3vqLEXBt/+CMlTGHxg7sPacLl3b/LqEVLQ/X+XBGuu2fWW/C2qldKjwpMwFyApPtY1vOdMSX4knwzasnWaG0opvPC3uYrFrw78i8QuiUbrofsrv1kP3iA4MTv+EWFCnWv1G3w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758629403; c=relaxed/simple;
	bh=EonFWRJ3UjvtHaLdhDhLo7aSOlSCxeedQytikJ6JqfM=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=cePsHE4yfuJjZCi/dHhNAHUZl7fjI3M/00bnB6cnsxxWohtfGwmfnGVxA7JSRqVTpjZUlRHPI7tM3MPvFNopHfwODOybu7oB1mpa/5mDJQMRb5Plyb2S9HhOpZyK0P0QhUWTiLEyuyl7M3uaWNVfLI4Uah3cooLP9FvlK2/6paM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=1Eb9ob93; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-62105d21297so9672848a12.0
        for <linux-can@vger.kernel.org>; Tue, 23 Sep 2025 05:10:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1758629399; x=1759234199; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=yyEfxr2Vhr/F2b8FGjwb8lODwV041uqFIsP3xTj5KJE=;
        b=1Eb9ob93IWnDRsio2xRbLUu8PMfDeh8B1gnyxtDtQtP9BxVRY/q3UZU5bBiPpFhNt+
         qVjP4jETW+RAveoLDmUqCE8aOCbhD682HvNkLqVwLPHpHwbZaqPhf74jDQq9ye5cKWCs
         7kLZj4I8w4+tY0nl7O4+XgR0XXdtnauNMgaCYEDp1nmqrNCsifjfjp1Wc7djkk7DcEdW
         Nm/+e613Equvis1VMX6iieYybFfrdb3P7iWZRiv6mNtPxreCnsKReb+mP2ObOt13cG/l
         Mx5N0sGAAAGXWz+nvkYBb/GAuQim4JEAvR4u/XUtINP/GwDbVbpM0wv2vRbKTYceqgc+
         B/1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758629399; x=1759234199;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yyEfxr2Vhr/F2b8FGjwb8lODwV041uqFIsP3xTj5KJE=;
        b=kkTtDhrCehJuQPTDNkBq0zaTivriW70pINN06K57y3kppbYb+7mNYCdjo186NVbqmU
         Gca+tzEQDhaYvbne7WJ+A/9lR2fZNxt++GiC2Rjl2modBe4QgXHcOfzXDczxmynsZ+66
         fGn3jOUQmy5A0F5D9xCMLLCM6tfTOKXogMaH6GcC607C7PVFUUa1H693PyVJu+2fPICb
         nywNUg3+t3fvTYlYSBeEcpOuBsMJAx6MpCpN2mHpVTFvHgZ+DYUg7GLpgKETRQGtgLce
         V0ib+4CKsAGgN1NSuXbPhu0ZcdaprcDRORKWEBiGPik2I63nakMd8wzhh13Tj8Tbro1J
         yZ4A==
X-Gm-Message-State: AOJu0Yz++eGQn+6sjBx/AERsYrn9GPwG1PB9PHQaI7pqs2Edcug9besq
	Vo/+nHMnEfehDZOj/bVKI3v07Oylc12MZ2X3D7rgbt8WiwaXEZIKRhdP61JlkS8KP/4=
X-Gm-Gg: ASbGncvnh3r937zXcx3tqfyLfPYaBlmFoDEFw+AF4wDltNFz8HgAJS9amT2HZIZhzAY
	/Uam4zUNIJkLXQ9Ds01t0u+Ia0Yhr2SIO4T60H37tGzeLSE469zWHIF4M0L+SBUeVdbVU+IkU3Y
	GdczAFdowDyTV5ppXknvIbVaFaWGzLpT5FXyFIB13sm6ECUSfq97PSQ2RgtHjH4J7xmmeDeBWOx
	aweXyKjvgDcjEcd1TlCSCuWdz0WoSlZThmbXUrV+NSS+9AomvKX/bYSXYG4mRj4DWHI0LZr3uM1
	fm41osQgsjsgbY6ecPytba4Aqu6YWNSFr1nBCIKbBo7nmpRCqCW4RJY9Uj9yFZJ6S+ecYBM9VQN
	jJ3wCxjf0ifuM8BA=
X-Google-Smtp-Source: AGHT+IHQaG3rV5bFMpt/dS5+BCknG5RVxoq7FTvcykoiKdzx+xQTXeuDmhitvREZM+kxtHkutG04XA==
X-Received: by 2002:a05:6402:4541:b0:633:b513:c5be with SMTP id 4fb4d7f45d1cf-634677954dcmr1641931a12.14.1758629398696;
        Tue, 23 Sep 2025 05:09:58 -0700 (PDT)
Received: from localhost ([195.52.61.108])
        by smtp.gmail.com with UTF8SMTPSA id 4fb4d7f45d1cf-62fa5d4357esm10831663a12.23.2025.09.23.05.09.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Sep 2025 05:09:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: multipart/signed;
 boundary=e369e617a2297ea965eefda116473828afec3aa5eea3c8ee730a082cc9de;
 micalg=pgp-sha512; protocol="application/pgp-signature"
Date: Tue, 23 Sep 2025 14:09:49 +0200
Message-Id: <DD0638HHBIQ9.17BNV4QEUMM0H@baylibre.com>
Cc: <linux-can@vger.kernel.org>, <kernel@pengutronix.de>
Subject: Re: [PATCH v3 5/6] can: m_can: m_can_get_berr_counter(): don't wake
 up controller if interface is down
From: "Markus Schneider-Pargmann" <msp@baylibre.com>
To: "Marc Kleine-Budde" <mkl@pengutronix.de>, "Chandrasekar Ramakrishnan"
 <rcsekar@samsung.com>, "Vincent Mailhol" <mailhol@kernel.org>, "Patrik
 Flykt" <patrik.flykt@linux.intel.com>, "Dong Aisheng"
 <b29396@freescale.com>, "Varka Bhadram" <varkabhadram@gmail.com>, "Wu Bo"
 <wubo.oduw@gmail.com>, "Markus Schneider-Pargmann" <msp@baylibre.com>,
 "Philipp Zabel" <p.zabel@pengutronix.de>
X-Mailer: aerc 0.21.0
References: <20250923-m_can-fix-state-handling-v3-0-06d8baccadbf@pengutronix.de> <20250923-m_can-fix-state-handling-v3-5-06d8baccadbf@pengutronix.de>
In-Reply-To: <20250923-m_can-fix-state-handling-v3-5-06d8baccadbf@pengutronix.de>

--e369e617a2297ea965eefda116473828afec3aa5eea3c8ee730a082cc9de
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8

On Tue Sep 23, 2025 at 11:17 AM CEST, Marc Kleine-Budde wrote:
> If the interface is down, the CAN controller might be powered down,
> the clock disabled, and/or it's external reset asserted.
>
> Don't wake up the controller to read the CAN bus error counters, if
> the interface is down.
>
> Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>

Reviewed-by: Markus Schneider-Pargmann <msp@baylibre.com>

> ---
>  drivers/net/can/m_can/m_can.c | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/drivers/net/can/m_can/m_can.c b/drivers/net/can/m_can/m_can.=
c
> index c82ea6043d40..afbab6ca5833 100644
> --- a/drivers/net/can/m_can/m_can.c
> +++ b/drivers/net/can/m_can/m_can.c
> @@ -790,6 +790,10 @@ static int m_can_get_berr_counter(const struct net_d=
evice *dev,
>  	struct m_can_classdev *cdev =3D netdev_priv(dev);
>  	int err;
> =20
> +	/* Avoid waking up the controller if the interface is down */
> +	if (!(dev->flags & IFF_UP))
> +		return 0;
> +
>  	err =3D m_can_clk_start(cdev);
>  	if (err)
>  		return err;


--e369e617a2297ea965eefda116473828afec3aa5eea3c8ee730a082cc9de
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iKMEABYKAEsWIQSJYVVm/x+5xmOiprOFwVZpkBVKUwUCaNKODRsUgAAAAAAEAA5t
YW51MiwyLjUrMS4xMSwyLDIRHG1zcEBiYXlsaWJyZS5jb20ACgkQhcFWaZAVSlNB
+wD/ayoDUCdbBuZWrfC8a30fznuuMwMQ6dPOUCoouW2yqpsBANrOW1DKZvUpXjr7
KtWK+nO2vpjx6RZJwZOvJwjkR/4G
=0tD0
-----END PGP SIGNATURE-----

--e369e617a2297ea965eefda116473828afec3aa5eea3c8ee730a082cc9de--

