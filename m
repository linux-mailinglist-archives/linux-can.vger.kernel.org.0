Return-Path: <linux-can+bounces-4269-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AE69EB2D773
	for <lists+linux-can@lfdr.de>; Wed, 20 Aug 2025 11:04:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6D0011887B5E
	for <lists+linux-can@lfdr.de>; Wed, 20 Aug 2025 09:01:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 251352D9496;
	Wed, 20 Aug 2025 09:01:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="C3o1rd4Y"
X-Original-To: linux-can@vger.kernel.org
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 988E31FF7D7
	for <linux-can@vger.kernel.org>; Wed, 20 Aug 2025 09:00:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755680462; cv=none; b=PligsEVC/9D5LBcctq/pZM1UxsM+1cBCCL+dS9PXZT76WC4AdO72zisTqaSMeyQPY45csqncGm+e0HR2wb3Wfxn+l9odqdKS2uTn1FeNRi8HcYjm8C9ZgDYvYs38aS9WCQiJueudM8Za/XH4x39/N9RhABu/wJJUbbKJcbwodoE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755680462; c=relaxed/simple;
	bh=6LsHJgo+tKRzzkgQLAaAT5JkHxEvAMEFQZX1rXQC0Ns=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=u6Kb5povvhYJhH5I01ic+ePJBDyjw8O9wYaYGfWRvROQgxNuga24IKrKZm8W1FVU+Ur80AFqXQdTBiec7Srs3/7L+/nya8xthx7oMOvwnOXR0sJEFsrILMo3CyuJYdx5RHhiUpcW8B6OiRYcWIw3AHhKGOwd/lOcEVgfl2vXRaw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=C3o1rd4Y; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-6188b5f620dso6997134a12.0
        for <linux-can@vger.kernel.org>; Wed, 20 Aug 2025 02:00:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1755680457; x=1756285257; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Z03jrGTI9dQg5eIa9TV41Lj6FCs5xJJf0R8hPNlQSBk=;
        b=C3o1rd4Y7aIewY1z+SPmXxdxgpgllaurCQR867mgGOizTDzY6Wp6nq839aWnq7FV0d
         afQDCRzAoYeCHxLxDST80r1U3M3bjLeNEYFLofzdiLFxupdZHsHz+cIr23zZOyLQRKQc
         yN7f2uTt68MYgpoN/BB6pD+7qpludD1W/8O3koiZXCrSdfRGCS6VfSA0Rxb7S9s+0I2q
         Dpb16ykqFznOQ2axpo1ZpvR2aYiITqgvPlEJTNr+PmNwOHZUCgwSUE8wHFrolQ7Zut16
         frjP2/aQkMwoBzRMrNyDADezl8yRuB5DZaAkBx47Jr5t7EW5kVxd9rhCMZadP9vLeXbu
         Nj3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755680457; x=1756285257;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Z03jrGTI9dQg5eIa9TV41Lj6FCs5xJJf0R8hPNlQSBk=;
        b=Dj/h1aU69zznjbXFUdMsFtGi5v4fXGaCDiUBlnmcw6MJVPV9xjyPSwtHdE6YNUvVFD
         Tiu/VHO85DRjLHQsc/CVdOKqlIhIDnVl26vrNKHADCkCz88pLFdg0p+vLkrtluVQsMf1
         6cmb6tDNAB8mJNNeU6HEITWKRdR+EPBTP1otpSEi7pieQoGdOmclo1OuYSZmiLsxeKdF
         XXKVPOvCmTYL4lef6RkQgIYBEknn4ANzZnAA/INNNiDOMrN+o2gJ4x+8qt8uejEa1TcL
         aG3/nC/3Ob48KM1GSh7diBXBKbwJAEt0UlxQ3WcShmI5S6nfJ5QJnexKiflxi2khA6m+
         pbiQ==
X-Gm-Message-State: AOJu0YysW+CHtccdMhOOPCgQJGGp/8rBtumkJs7GAvJIMN0a0njt5vFh
	HTyqxIPPt3oQglgl76aMf2tCH/EFhB5nWqVauSxcAT2ZHG1El89IoDAJcw/D630O/fk=
X-Gm-Gg: ASbGncsPtMeHUF/jMyr9lkbTq4erlx9++gAPzYu/Ko9EshKr8PgqdOfzmmSQLEh/ALN
	fMIJ2H6RsQTs1euAC0iMxXmdz7PZnsXoJUxgJ33IG5r3QtEDHY7TF7oOu0BheMFVtSJ8ENkXsRC
	mIleY5aUeKQZsSq/r3lyB+6BiTwA2Wo5R/UedRuWBJiL23KFI7AqGyNFDsBRyJ38ym5azJdiJVI
	tdXm24Zx+kffusgYO0Inpjggm/ZB6gtNXPL6fVwx9wx85mEA6BnnSAGNnIBs+ooby7MvONAMrpN
	g72q+MaadlDdWusk7BeijZJVHeoWK8/c4uG1miPMLOj/frtuaY/qCapco0jR3eOpp0HUh2zDqw/
	x4NRyzyqI4l3PNW0am9k+RCbn
X-Google-Smtp-Source: AGHT+IG9lWtoWnwYr1sV2dIFklr/LGgYFqW/ehAo3u/KuYgzO3cIlB5RIbib+Cneh8aXl5/QiU4ngg==
X-Received: by 2002:a17:907:3da6:b0:afa:12c6:26f with SMTP id a640c23a62f3a-afdf00ae024mr169702466b.26.1755680456809;
        Wed, 20 Aug 2025 02:00:56 -0700 (PDT)
Received: from localhost ([195.52.61.108])
        by smtp.gmail.com with UTF8SMTPSA id 4fb4d7f45d1cf-61a92678f45sm1528575a12.18.2025.08.20.02.00.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Aug 2025 02:00:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: multipart/signed;
 boundary=1ae8ba6f514b4cd88d5798840df4bf4af76203035298ca9776addea44178;
 micalg=pgp-sha512; protocol="application/pgp-signature"
Date: Wed, 20 Aug 2025 11:00:51 +0200
Message-Id: <DC74S0QJQ0JV.39VRZ1Y5JSEWS@baylibre.com>
Cc: <linux-can@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <kernel@pengutronix.de>
Subject: Re: [PATCH 4/7] can: m_can: m_can_chip_config(): bring up interface
 in correct state
From: "Markus Schneider-Pargmann" <msp@baylibre.com>
To: "Marc Kleine-Budde" <mkl@pengutronix.de>, "Chandrasekar Ramakrishnan"
 <rcsekar@samsung.com>, "Vincent Mailhol" <mailhol.vincent@wanadoo.fr>,
 "Patrik Flykt" <patrik.flykt@linux.intel.com>, "Dong Aisheng"
 <b29396@freescale.com>, "Fengguang Wu" <fengguang.wu@intel.com>, "Varka
 Bhadram" <varkabhadram@gmail.com>, "Wu Bo" <wubo.oduw@gmail.com>, "Philipp
 Zabel" <p.zabel@pengutronix.de>
X-Mailer: aerc 0.20.1
References: <20250812-m_can-fix-state-handling-v1-0-b739e06c0a3b@pengutronix.de> <20250812-m_can-fix-state-handling-v1-4-b739e06c0a3b@pengutronix.de>
In-Reply-To: <20250812-m_can-fix-state-handling-v1-4-b739e06c0a3b@pengutronix.de>

--1ae8ba6f514b4cd88d5798840df4bf4af76203035298ca9776addea44178
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8

Hi,

On Tue Aug 12, 2025 at 7:36 PM CEST, Marc Kleine-Budde wrote:
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
> ---
>  drivers/net/can/m_can/m_can.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/net/can/m_can/m_can.c b/drivers/net/can/m_can/m_can.=
c
> index b485d2f3d971..310a907cbb7e 100644
> --- a/drivers/net/can/m_can/m_can.c
> +++ b/drivers/net/can/m_can/m_can.c
> @@ -1607,6 +1607,7 @@ static int m_can_chip_config(struct net_device *dev=
)
>  static int m_can_start(struct net_device *dev)
>  {
>  	struct m_can_classdev *cdev =3D netdev_priv(dev);
> +	u32 reg_psr;
>  	int ret;
> =20
>  	/* basic m_can configuration */
> @@ -1617,7 +1618,8 @@ static int m_can_start(struct net_device *dev)
>  	netdev_queue_set_dql_min_limit(netdev_get_tx_queue(cdev->net, 0),
>  				       cdev->tx_max_coalesced_frames);
> =20
> -	cdev->can.state =3D CAN_STATE_ERROR_ACTIVE;
> +	reg_psr =3D m_can_read(cdev, M_CAN_PSR);
> +	cdev->can.state =3D m_can_can_state_get_by_psr(reg_psr);

Previous patch makes sense for use here. But how is the state set back
in operation after mcan was in an error state? Maybe I missed the path
back to CAN_STATE_ERROR_ACTIVE somewhere?

Also CAN_STATE_ERROR_ACTIVE is set in resume() as well, should that also
read the PSR instead?

Ans lastly I don't like the function name, because of the repeated can,
maybe something like m_can_error_state_by_psr()?

Best
Markus

--1ae8ba6f514b4cd88d5798840df4bf4af76203035298ca9776addea44178
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iKMEABYKAEsWIQSJYVVm/x+5xmOiprOFwVZpkBVKUwUCaKWOwxsUgAAAAAAEAA5t
YW51MiwyLjUrMS4xMSwyLDIRHG1zcEBiYXlsaWJyZS5jb20ACgkQhcFWaZAVSlP6
nwEAwBNdmo8OtjsHcGA99xPO0er3RbS+3Oyc+GRhL/z5xWsA/0witQtPQ8gixhSd
rBh2n6W27uhBmAylY9izs2Wem9MJ
=luNr
-----END PGP SIGNATURE-----

--1ae8ba6f514b4cd88d5798840df4bf4af76203035298ca9776addea44178--

