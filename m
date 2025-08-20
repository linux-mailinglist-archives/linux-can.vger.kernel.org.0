Return-Path: <linux-can+bounces-4268-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3829CB2D711
	for <lists+linux-can@lfdr.de>; Wed, 20 Aug 2025 10:51:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 53B08188677B
	for <lists+linux-can@lfdr.de>; Wed, 20 Aug 2025 08:50:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 138632D24AD;
	Wed, 20 Aug 2025 08:49:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="0uuRyM/B"
X-Original-To: linux-can@vger.kernel.org
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB9B02848A6
	for <linux-can@vger.kernel.org>; Wed, 20 Aug 2025 08:49:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755679791; cv=none; b=dA9NFUnSRxC1gXr9xW0trir6kCKerT80hq5b1gmTUkvcNdMqhQykRHsxJEKRuIjEKeUDMr+tp/baHuaDKOlwo687itZYf2OTaeidbDl9YAABtXsJ7viy6NHG+l2Z+O+xhjCDG0ruxJTHmfVdlF1MQx6W0/fpDD8qwxewgWeM/fY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755679791; c=relaxed/simple;
	bh=qFhkYvrRp7AirHWWxvfX7YWMZrsd/N2izDV0tPPBvwk=;
	h=Mime-Version:Content-Type:Date:Message-Id:To:Cc:Subject:From:
	 References:In-Reply-To; b=DDUEdo5LoACz7gWXmvHsDWcwVsyJnG27/9o1F3fTyNufhrFziqh77XYkfkDKHM5l7UAh1yC9AtrKLjEi7yq/FhSaK1z5R2bMKu6O/VaLI11C7RdvKmM50Euu6zteYUGBIOhlWh05W1TvAAvlvQp9iMM/MG1fsplHLb66jeOLVfM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=0uuRyM/B; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-6188b5b1f1cso7253061a12.0
        for <linux-can@vger.kernel.org>; Wed, 20 Aug 2025 01:49:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1755679786; x=1756284586; darn=vger.kernel.org;
        h=in-reply-to:references:from:subject:cc:to:message-id:date
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=JViXp0Y0lLXSI2URB8pEEd6pa4M2m712xo7ltwZk2E0=;
        b=0uuRyM/B9N0JXX2/Xk7TGwsOJ/ILYPcIHmJPhmrEg8AlGMA3l+8Yb495d1C5VxRfb/
         a/tij9xGDvAU7jERtUIJAmRmrDmV6I31D4xEfIhaqfHV5U78UbKddYgpR2XQEXqIGk+Y
         bACXPyRULgrqc6mo9OUJ3TWSzOCGSfWGvwWsWNdba9qT/rV5fcreC2uhktn4VI2RfbKs
         OLQdToqVCH1Usd/5sIY6QuEYXEnlTZR8Y+vRIhCRNEyQF0bCz6qs0ohqJtQc0e5gX9mY
         B9cKsEpPlCtvDuQA8Dj68GYLMQC6ZwgeNgIMplVrTVOoRSSPYQ0sisn7QG2BEOlBQodB
         tkQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755679786; x=1756284586;
        h=in-reply-to:references:from:subject:cc:to:message-id:date
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JViXp0Y0lLXSI2URB8pEEd6pa4M2m712xo7ltwZk2E0=;
        b=l2UDKX+ZCdr3bOIzQMAMKufutlyJJvXA0TROBrJbp71iDeREf3hewBDIP0gaKI86v+
         VMTLz1f3SnDP7nq8bOogY/Top7G0DLrFn4TAQ5sH9/TRzwsxulrAFLN10Q2syGPKOdmw
         nlFZeSSUq2kadx3lodWr49soMi9loGOByk+z5MH7it0gWfuFoFy+xbItvUWfEcYydp0+
         LtOJzzEA6tD9hGzDpS7B2J7VN/7qNm2PIcuUQFPRFF7yHEybgSpHJhZ0KJ1DNPumVZxL
         nc4AYPGhEmIACmrkuGUDkjTkqNyLTLyXyAWxU89Sy/whKvpwn3vdhfq0h//xlmRaHKVk
         CvtQ==
X-Gm-Message-State: AOJu0Yxmx0jQO5GaRdGqB7+n1DFo2+ScoowHBwbkWOLtkHP1Wle9Md8C
	s1wCoMofkkNYnU39x0nabrGun4rB0+AG1l+qEIbXuKgVMMkdDexxcC2iTIlC1xYsDOI=
X-Gm-Gg: ASbGncsIehCFLIGgM8+0szHbUgKwmJBXC7d9qIt5ppgcJxziiV/uBgEGZcUdqjRr50/
	/juf5oAtHkZ5dZMKLLlSkmXLW8Cmq5+RQpqF7Gt5/DnO7dE+dD2fZ+W9Y2sg8V7OS5JmJC+yk1x
	c1vNDkpTK0/NSgBwRXcWDpv58cT210qXxWm1/hAsulW3dUh0+8mMHleBtd3uTNo9oF0XtKtwU0q
	quxCt+mWLD2BEshOzzPybpHkGp6v+Bvdu0UAULhRHAN2I+NgvEWapl0DaV+BQ8lipADOWMiWvKS
	Gs5fxp3eu35LrN9wq2iMBCQ3nv85zfAk0IzLm02+oDvyzRzc21Tow6lBrvADCKHobwp3z4rcibC
	mhtSfYMNsWaEy+m0EX57V+JgM
X-Google-Smtp-Source: AGHT+IHQyjxEUTf10jpunNYcXuMIQ9cW1pml4LUwKfCCddBzi3jxSqjuGV6qLT7AYSccFNR7PjQNZw==
X-Received: by 2002:a17:907:6d0b:b0:af6:2f1d:a73f with SMTP id a640c23a62f3a-afdf029cd2cmr158210066b.53.1755679786081;
        Wed, 20 Aug 2025 01:49:46 -0700 (PDT)
Received: from localhost ([195.52.61.108])
        by smtp.gmail.com with UTF8SMTPSA id a640c23a62f3a-afded30712dsm140843666b.44.2025.08.20.01.49.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Aug 2025 01:49:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: multipart/signed;
 boundary=4f6158a9a8aaddcdedff7701776996a3d79007b2b3773d0e59f492a751ef;
 micalg=pgp-sha512; protocol="application/pgp-signature"
Date: Wed, 20 Aug 2025 10:49:35 +0200
Message-Id: <DC74JEKBB6HL.1LJ53UZJ0T0Q9@baylibre.com>
To: "Marc Kleine-Budde" <mkl@pengutronix.de>, "Chandrasekar Ramakrishnan"
 <rcsekar@samsung.com>, "Vincent Mailhol" <mailhol.vincent@wanadoo.fr>,
 "Patrik Flykt" <patrik.flykt@linux.intel.com>, "Dong Aisheng"
 <b29396@freescale.com>, "Fengguang Wu" <fengguang.wu@intel.com>, "Varka
 Bhadram" <varkabhadram@gmail.com>, "Wu Bo" <wubo.oduw@gmail.com>, "Philipp
 Zabel" <p.zabel@pengutronix.de>
Cc: <linux-can@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <kernel@pengutronix.de>
Subject: Re: [PATCH 3/7] can: m_can: m_can_handle_state_errors(): fix CAN
 state transition to Error Active
From: "Markus Schneider-Pargmann" <msp@baylibre.com>
X-Mailer: aerc 0.20.1
References: <20250812-m_can-fix-state-handling-v1-0-b739e06c0a3b@pengutronix.de> <20250812-m_can-fix-state-handling-v1-3-b739e06c0a3b@pengutronix.de>
In-Reply-To: <20250812-m_can-fix-state-handling-v1-3-b739e06c0a3b@pengutronix.de>

--4f6158a9a8aaddcdedff7701776996a3d79007b2b3773d0e59f492a751ef
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8

Hi,

On Tue Aug 12, 2025 at 7:36 PM CEST, Marc Kleine-Budde wrote:
> The CAN Error State is determined by the receive and transmit error
> counters. The CAN error counters decrease when reception/transmission
> is successful, so that a status transition back to the Error Active
> status is possible. This transition is not handled by
> m_can_handle_state_errors().
>
> Add the missing detection of the Error Active state to
> m_can_handle_state_errors() and extend the handling of this state in
> m_can_handle_state_change().
>
> Fixes: e0d1f4816f2a ("can: m_can: add Bosch M_CAN controller support")
> Fixes: cd0d83eab2e0 ("can: m_can: m_can_handle_state_change(): fix state =
change")
> Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
> ---
>  drivers/net/can/m_can/m_can.c | 48 ++++++++++++++++++++++++++-----------=
------
>  1 file changed, 29 insertions(+), 19 deletions(-)
>
> diff --git a/drivers/net/can/m_can/m_can.c b/drivers/net/can/m_can/m_can.=
c
> index a51dc0bb8124..b485d2f3d971 100644
> --- a/drivers/net/can/m_can/m_can.c
> +++ b/drivers/net/can/m_can/m_can.c
> @@ -812,6 +812,10 @@ static int m_can_handle_state_change(struct net_devi=
ce *dev,
>  	u32 timestamp =3D 0;
> =20
>  	switch (new_state) {
> +	case CAN_STATE_ERROR_ACTIVE:
> +		/* error active state */

This comment and the one below don't really help IMHO.

> +		cdev->can.state =3D CAN_STATE_ERROR_ACTIVE;
> +		break;
>  	case CAN_STATE_ERROR_WARNING:
>  		/* error warning state */
>  		cdev->can.can_stats.error_warning++;
> @@ -841,6 +845,13 @@ static int m_can_handle_state_change(struct net_devi=
ce *dev,
>  	__m_can_get_berr_counter(dev, &bec);
> =20
>  	switch (new_state) {
> +	case CAN_STATE_ERROR_ACTIVE:
> +		/* error active state */
> +		cf->can_id |=3D CAN_ERR_CRTL | CAN_ERR_CNT;
> +		cf->data[1] =3D CAN_ERR_CRTL_ACTIVE;
> +		cf->data[6] =3D bec.txerr;
> +		cf->data[7] =3D bec.rxerr;
> +		break;
>  	case CAN_STATE_ERROR_WARNING:
>  		/* error warning state */
>  		cf->can_id |=3D CAN_ERR_CRTL | CAN_ERR_CNT;
> @@ -877,30 +888,29 @@ static int m_can_handle_state_change(struct net_dev=
ice *dev,
>  	return 1;
>  }
> =20
> +static enum can_state
> +m_can_can_state_get_by_psr(const u32 psr)
> +{
> +	if (psr & PSR_BO)
> +		return CAN_STATE_BUS_OFF;
> +	if (psr & PSR_EP)
> +		return CAN_STATE_ERROR_PASSIVE;
> +	if (psr & PSR_EW)
> +		return CAN_STATE_ERROR_WARNING;

Why should m_can_handle_state_errors() should be called if none of these
flags are set?

m_can_handle_state_errors() seems to only be called if IR_ERR_STATE
which is defined as:
  #define IR_ERR_STATE	(IR_BO | IR_EW | IR_EP)

This is the for the interrupt register but will the PSR register bits be
set without the interrupt register being set?

Best
Markus

> +
> +	return CAN_STATE_ERROR_ACTIVE;
> +}
> +
>  static int m_can_handle_state_errors(struct net_device *dev, u32 psr)
>  {
>  	struct m_can_classdev *cdev =3D netdev_priv(dev);
> -	int work_done =3D 0;
> +	enum can_state new_state;
> =20
> -	if (psr & PSR_EW && cdev->can.state !=3D CAN_STATE_ERROR_WARNING) {
> -		netdev_dbg(dev, "entered error warning state\n");
> -		work_done +=3D m_can_handle_state_change(dev,
> -						       CAN_STATE_ERROR_WARNING);
> -	}
> +	new_state =3D m_can_can_state_get_by_psr(psr);
> +	if (new_state =3D=3D cdev->can.state)
> +		return 0;
> =20
> -	if (psr & PSR_EP && cdev->can.state !=3D CAN_STATE_ERROR_PASSIVE) {
> -		netdev_dbg(dev, "entered error passive state\n");
> -		work_done +=3D m_can_handle_state_change(dev,
> -						       CAN_STATE_ERROR_PASSIVE);
> -	}
> -
> -	if (psr & PSR_BO && cdev->can.state !=3D CAN_STATE_BUS_OFF) {
> -		netdev_dbg(dev, "entered error bus off state\n");
> -		work_done +=3D m_can_handle_state_change(dev,
> -						       CAN_STATE_BUS_OFF);
> -	}
> -
> -	return work_done;
> +	return m_can_handle_state_change(dev, new_state);
>  }
> =20
>  static void m_can_handle_other_err(struct net_device *dev, u32 irqstatus=
)


--4f6158a9a8aaddcdedff7701776996a3d79007b2b3773d0e59f492a751ef
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iKMEABYKAEsWIQSJYVVm/x+5xmOiprOFwVZpkBVKUwUCaKWMIBsUgAAAAAAEAA5t
YW51MiwyLjUrMS4xMSwyLDIRHG1zcEBiYXlsaWJyZS5jb20ACgkQhcFWaZAVSlM3
TwEAq1gLxJP36AWMgsa325Ay3CrplTqpZ4eOGaLk+fYXvZMBAJVUlpb8epBfGKTC
qyoMnQ3kestXJakt25AiDCbsnZYH
=drWK
-----END PGP SIGNATURE-----

--4f6158a9a8aaddcdedff7701776996a3d79007b2b3773d0e59f492a751ef--

