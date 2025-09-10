Return-Path: <linux-can+bounces-4630-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A9C22B511E5
	for <lists+linux-can@lfdr.de>; Wed, 10 Sep 2025 10:57:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B235C3A541E
	for <lists+linux-can@lfdr.de>; Wed, 10 Sep 2025 08:57:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62E4E311955;
	Wed, 10 Sep 2025 08:57:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="WjVvp14w"
X-Original-To: linux-can@vger.kernel.org
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B4A231194F
	for <linux-can@vger.kernel.org>; Wed, 10 Sep 2025 08:57:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757494647; cv=none; b=IYveTGqseVw/0czMf/Syj1u3Z2scGbwClPegn+QsavHIs1mv9as3Y+5C3GJRMo7ha2vt9tPuB1gpZzy/lOhuY3MFcQNtCIC1pdIiVMLoqR01GFA6LSNUMQVTMLshIoD69xMWb/Nxy3KLA3OT/cTS/K0dLsTqVrt1EluLrE9CRfw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757494647; c=relaxed/simple;
	bh=qoU3pKTQTic8pv+RfjHcpe00Wy+NEhUJEG/5b653yUM=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:From:To:Cc:
	 References:In-Reply-To; b=Qaq5dj1giTImiXIoR2ag6J8k0Gl0UcgJCMpvPg7l+kjf/m29I1SeWRJObTQT5i+LpkbjcBYTU5qu6X/ICcW4N5IXzx57DTO6DHS9X4Nx/1NpQU1bd/0j9WF/7/aXr67WOtX9Vxa5ZclUmPv7rDyqW6tT6ipSUPeHSdVuTUXZhMU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=WjVvp14w; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-b07883a5feeso83904066b.1
        for <linux-can@vger.kernel.org>; Wed, 10 Sep 2025 01:57:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1757494643; x=1758099443; darn=vger.kernel.org;
        h=in-reply-to:references:cc:to:from:subject:message-id:date
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=heZhxHLHkvE/mBdXQ2bJ/hfBM5y74AYhJs78IlNsTHo=;
        b=WjVvp14wZZ1DaTZ/bSlVHnr3h1ulIADB8FMF9bn2IL+5AXYsAIrCjU8wKACgwXAQKA
         O+5HfVNBDLwETPn94bb84f2fukiLG517lwvxlifn/EPQaKivwEt1+Tzjjk0gZAsrLRgG
         MXMkD8rxoGm4PNW4tdYewzk7mWu+lmTjGTbM9tF4mYLgLFIK3oh3WHNmCR4ETzmCEqui
         QTqdr6GvED4o7V7Q29oiL0p33TzHC+I0O2qDwXoojAYeMQfVdHIp5+sjARD3noDErDYm
         DaABmS0znOfKT7G89uaPI/MtXvS4AsZKj10O3HiLt3adCj6kt8H2GbQumETarvxCxLLp
         YWTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757494643; x=1758099443;
        h=in-reply-to:references:cc:to:from:subject:message-id:date
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=heZhxHLHkvE/mBdXQ2bJ/hfBM5y74AYhJs78IlNsTHo=;
        b=oGpwjW+z5Vrn00QSmQ1MTMl/lqxjntADxkyGJHsRmclnOxdFjFv0Zm8htldoFUkYQD
         cK+XpLLclXtvBEdo60OfbFwmaCqg/eApjlJ63D6XbzQlh31S6xS1rslsjM89KZuxm/ny
         UCRsPVihOcngSGkcTiodFtuOn/3O/lXej8RvxpTyQ94hL0piHWCPS7mcTyvk5SYvxQcW
         CscEn/L0slA2+yplU+YkPkBQtGSD7dHD3P1USinbkrfoGWC++Qhl7roK7abvFdjvAG/G
         fQ4ypYZKtiv40oO5ZJyE3JRAmNAY/Z20yK4UZON4pjL5713UdQKXzIrZVfrJEJiXICZC
         x4fQ==
X-Gm-Message-State: AOJu0YzOG2NpXHJDMiH2Jg+PnorQUAs7Xmox98AYQLsEiksUyqGUlM55
	QWQTaF+B8epSczVLHyFpW0YBcLNHxvEIQ9kF8lwZnxj9rJnl0Mhb0WvxtRA92jUM4SI=
X-Gm-Gg: ASbGncvKQJxPPG3ZAaWVPZB4hotxFQu1zsKKmqRUR0B2RzEJ5hAJp+waYgTExB7sJCR
	za9TIHfUreFPrgixLYFzZ8Q4YyqyfXa75rw33SpNAqNddsU7Z11MgxNFbZNTzEG1LcXeErTqpOb
	CI/sPZ9uM+U+T8CpSvMN5R/7YsRFoKCTm4CmGUQpspGVCmzFG4p3INxRzfDrEqnvmg5A8y5tdv1
	KbPxvs5WkITvizsBgJvcX9h2r20vLndNAXG1LD9ipAVt2kvaO0T/Pu0U2PCfA0NRZktjGkNMKzl
	sHLxqHnnd4aO7tUrkadCiJmhc97YUw3aEkDPKSQGlRdeJOc2F9tVavm39v7YdoTsJyb7xuhC3PZ
	bfQtb+ZTbw32ZNDFCRX1tbT6Uyw==
X-Google-Smtp-Source: AGHT+IEt2vwUHtHjKBZF2us6O9DmadgnAagqk9KkLFli/Ox9nZChWE5tuK6SmcWYPMKeP8iB58R8VQ==
X-Received: by 2002:a17:906:6a17:b0:b04:25e6:2dc7 with SMTP id a640c23a62f3a-b04b140a60dmr1468322066b.18.1757494642610;
        Wed, 10 Sep 2025 01:57:22 -0700 (PDT)
Received: from localhost ([195.52.61.108])
        by smtp.gmail.com with UTF8SMTPSA id 4fb4d7f45d1cf-62c01bdb977sm2946470a12.53.2025.09.10.01.57.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Sep 2025 01:57:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: multipart/signed;
 boundary=e839a8b678f6ec040c6f11d995a891083537e68a99b38219f0c9d06ab188;
 micalg=pgp-sha512; protocol="application/pgp-signature"
Date: Wed, 10 Sep 2025 10:57:13 +0200
Message-Id: <DCOZUOS67P02.1SZS876C49XTP@baylibre.com>
Subject: Re: [PATCH v2 4/7] can: m_can: m_can_chip_config(): bring up
 interface in correct state
From: "Markus Schneider-Pargmann" <msp@baylibre.com>
To: "Marc Kleine-Budde" <mkl@pengutronix.de>, "Chandrasekar Ramakrishnan"
 <rcsekar@samsung.com>, "Vincent Mailhol" <mailhol.vincent@wanadoo.fr>,
 "Patrik Flykt" <patrik.flykt@linux.intel.com>, "Dong Aisheng"
 <b29396@freescale.com>, "Varka Bhadram" <varkabhadram@gmail.com>, "Wu Bo"
 <wubo.oduw@gmail.com>, "Philipp Zabel" <p.zabel@pengutronix.de>
Cc: <linux-can@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <kernel@pengutronix.de>
X-Mailer: aerc 0.20.1
References: <20250909-m_can-fix-state-handling-v2-0-af9fa240b68a@pengutronix.de> <20250909-m_can-fix-state-handling-v2-4-af9fa240b68a@pengutronix.de>
In-Reply-To: <20250909-m_can-fix-state-handling-v2-4-af9fa240b68a@pengutronix.de>

--e839a8b678f6ec040c6f11d995a891083537e68a99b38219f0c9d06ab188
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8

On Tue Sep 9, 2025 at 7:53 PM CEST, Marc Kleine-Budde wrote:
> In some SoCs (observed on the STM32MP15) the M_CAN IP core keeps the
> CAN state and CAN error counters over an internal reset cycle. An
> external reset is not always possible, due to the shared reset with
> the other CAN core. This caused the core not always be in Error Active
> state when bringing up the controller.
>
> Instead of always setting the CAN state to Error Active in
> m_can_chip_config(), fix this by reading and decoding the Protocol
> Status Regitser (PSR) and set the CAN state accordingly.
>
> Fixes: e0d1f4816f2a ("can: m_can: add Bosch M_CAN controller support")
> Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>

Reviewed-by: Markus Schneider-Pargmann <msp@baylibre.com>

> ---
>  drivers/net/can/m_can/m_can.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/net/can/m_can/m_can.c b/drivers/net/can/m_can/m_can.=
c
> index 3edf01b098a4..efd9c23edd4a 100644
> --- a/drivers/net/can/m_can/m_can.c
> +++ b/drivers/net/can/m_can/m_can.c
> @@ -1620,7 +1620,7 @@ static int m_can_start(struct net_device *dev)
>  	netdev_queue_set_dql_min_limit(netdev_get_tx_queue(cdev->net, 0),
>  				       cdev->tx_max_coalesced_frames);
> =20
> -	cdev->can.state =3D CAN_STATE_ERROR_ACTIVE;
> +	cdev->can.state =3D m_can_state_get_by_psr(cdev);
> =20
>  	m_can_enable_all_interrupts(cdev);
> =20


--e839a8b678f6ec040c6f11d995a891083537e68a99b38219f0c9d06ab188
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iKMEABYKAEsWIQSJYVVm/x+5xmOiprOFwVZpkBVKUwUCaME9aRsUgAAAAAAEAA5t
YW51MiwyLjUrMS4xMSwyLDIRHG1zcEBiYXlsaWJyZS5jb20ACgkQhcFWaZAVSlOP
pAEA/xv1ypzQcN1eVWohScU7gQS0TJo8V0ZWJ2NMrajS0FQBAKSDGYrugKKXCpN/
5Ie6QRWTjmoM1bXa34OObYQzZK0G
=z0YW
-----END PGP SIGNATURE-----

--e839a8b678f6ec040c6f11d995a891083537e68a99b38219f0c9d06ab188--

