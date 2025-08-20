Return-Path: <linux-can+bounces-4271-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C5DF3B2D7EE
	for <lists+linux-can@lfdr.de>; Wed, 20 Aug 2025 11:22:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9F93D16FDCC
	for <lists+linux-can@lfdr.de>; Wed, 20 Aug 2025 09:17:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6222C2F28E0;
	Wed, 20 Aug 2025 09:09:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="WQH9qx2c"
X-Original-To: linux-can@vger.kernel.org
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93AB32DECBA
	for <linux-can@vger.kernel.org>; Wed, 20 Aug 2025 09:09:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755680968; cv=none; b=hY1VMO4X7mH66t/JpYCmoYb0rdGKn+Vo/UwhF2XzXettum4rtNBTqaXzP9vZIzMwAHMQ7srhT4cLDzJFkVZhLu8kzho5i4lQjrS7Lsd/EzIIgQDIxnXXJM3SbjhXXa3YMX5T7c9EbsHSWdFpBAIaxTtXmrLnd4jF+ahbOd+zLiU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755680968; c=relaxed/simple;
	bh=b0Ve3EV0EbnS6J0OaTxdHWhcc3x/hQh592WEkpCF12Q=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:From:To:Cc:
	 References:In-Reply-To; b=mT09kGA3Lkhd+nNbhKAupiljDFhJEZAm4iSL9olY/2+6Qo7fb57YRqR01iAi2kPNZh8lLh0vp94S2SN7mT+xa9k1yHx7ycAUlI5L3vV5PWTtRod+aNM0XrM+qIZdIiZp2RJHeH9donf7Ewcvyr/UMPouMyGysglHC2d9Mu0c3Aw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=WQH9qx2c; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-afcb7aea37cso781044566b.3
        for <linux-can@vger.kernel.org>; Wed, 20 Aug 2025 02:09:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1755680963; x=1756285763; darn=vger.kernel.org;
        h=in-reply-to:references:cc:to:from:subject:message-id:date
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Yn3sHeJOdi0b6yWaJNMSGvIWhjZnoLiL+egoidkdFJY=;
        b=WQH9qx2cMA0ELMjivixiJo+VQOLcLlUqZaVU6LtNsh2XG7CgiEEAar3VZ+0kZDNgbm
         0VKp13DXL4kckNThN/KINKBzalq1ie4IYL/tYl5UhZneWo+cBuz3qyG7lSFFmDCabrtx
         Cy/P8AUKt0NYKJV/H45CFwQzWchVU6DI0EKvUSIl9VIqSUo2YoXnPaG61ECUas3ZxBQl
         i6A6rTOpqomON9jZgc7fLVPHzBWTixwVNwMA9QWnY4v8NzpfWkdT0/J8kxUNpi8vZAUs
         vfyxjSAiI5azphq+3oF43+0ei7N2oRIlERe9DbdFhgX6ExNAnfIJTgmIXzaI/JpXwhNF
         S8CA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755680963; x=1756285763;
        h=in-reply-to:references:cc:to:from:subject:message-id:date
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Yn3sHeJOdi0b6yWaJNMSGvIWhjZnoLiL+egoidkdFJY=;
        b=GaWukqvGjg9ZNXXTB0CMXWdVrVaPqT4aq/UEZCeliKjidm7eCGhMMtTe4tZX7gX82Y
         Nthmq5328Ry3FB1uZMzoHbJc81ThXrHJkvdngAnEg0ryOvNANM8Q0HQFmcBbHda4p0/z
         uGCgGrL4wcSKd9w/SPRx8yTJap8jxw33FzQJDG0iWUnpqCQbIQAEXw/KkqUUTCZYzP2U
         CYuFX2rf3Lwvxr7gr1miF33Rv6JyEJklQDTX1/2jAf2tqJsUaKsEd7mAMExO1tbiZETa
         bRJNt+YzuEckhSZGcYnuYZH1yjrBPQP6T6wwCJYDnVrOgdSiIrJ2uWe6SE2wHLJhnXmh
         svPQ==
X-Gm-Message-State: AOJu0YyXfEECM644KMP1JVieh+VUnEazm4JnrUszd+oD/rRC8LMWvEVU
	QkTlYNrMVtb3506HwvtCICs6bjLtkibqX7MfGrSr22FzVskhymVzhHBxvypeVlYwDA4=
X-Gm-Gg: ASbGncvUswZaefW2XuyFuAo/6oEbmW2sFoWcpOGfZFFnfhyxInD/opEQW4T5LmOJUSX
	blsYWAClaDIgAV/DQsrl11nvjUH9crlsxmTiUjc/ZustSv/hrtljkLbnWDYpvQ2U+TQ83EfcNZO
	Qu8jV1hj71hyUvKYEny7U73eVcg5WHHJNLyzIRh57QT3g7GoeTSHb2EwVMfWu1y5Zv8BCXEquR5
	9Co37z6NCoE+wX4NjirtbIXIQnPGSR/iLNXg9Mp4E1HD+H4ckaR11eyPXAAnCllMOjtWy+dSFAh
	vkXdefWUEX5i8pUmpNzyOMeCamb91JEb/12vnvDlswayAJABrydOcT6Lm+szVyGLMtyeMWvL0Op
	XW3AR2ax01tIldw==
X-Google-Smtp-Source: AGHT+IEfXalOdl7tKNAt6aOs79r9FH8o74RkmYQhdlN7JRgNqLhZEIcij3pckp407AmR7lIZ0rq9dw==
X-Received: by 2002:a17:907:70a:b0:ae0:6a5a:4cd4 with SMTP id a640c23a62f3a-afdf00f90c3mr173557766b.12.1755680962720;
        Wed, 20 Aug 2025 02:09:22 -0700 (PDT)
Received: from localhost ([195.52.61.108])
        by smtp.gmail.com with UTF8SMTPSA id a640c23a62f3a-afded47909asm145675566b.54.2025.08.20.02.09.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Aug 2025 02:09:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: multipart/signed;
 boundary=6db1d471c9c250ed1ed934d67c049fe0a0019dde128316248cc74167230a;
 micalg=pgp-sha512; protocol="application/pgp-signature"
Date: Wed, 20 Aug 2025 11:09:16 +0200
Message-Id: <DC74YGSPTL16.KG2SWZD4L3YV@baylibre.com>
Subject: Re: [PATCH 3/7] can: m_can: m_can_handle_state_errors(): fix CAN
 state transition to Error Active
From: "Markus Schneider-Pargmann" <msp@baylibre.com>
To: "Markus Schneider-Pargmann" <msp@baylibre.com>, "Marc Kleine-Budde"
 <mkl@pengutronix.de>, "Chandrasekar Ramakrishnan" <rcsekar@samsung.com>,
 "Vincent Mailhol" <mailhol.vincent@wanadoo.fr>, "Patrik Flykt"
 <patrik.flykt@linux.intel.com>, "Dong Aisheng" <b29396@freescale.com>,
 "Fengguang Wu" <fengguang.wu@intel.com>, "Varka Bhadram"
 <varkabhadram@gmail.com>, "Wu Bo" <wubo.oduw@gmail.com>, "Philipp Zabel"
 <p.zabel@pengutronix.de>
Cc: <linux-can@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <kernel@pengutronix.de>
X-Mailer: aerc 0.20.1
References: <20250812-m_can-fix-state-handling-v1-0-b739e06c0a3b@pengutronix.de> <20250812-m_can-fix-state-handling-v1-3-b739e06c0a3b@pengutronix.de> <DC74JEKBB6HL.1LJ53UZJ0T0Q9@baylibre.com>
In-Reply-To: <DC74JEKBB6HL.1LJ53UZJ0T0Q9@baylibre.com>

--6db1d471c9c250ed1ed934d67c049fe0a0019dde128316248cc74167230a
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8

On Wed Aug 20, 2025 at 10:49 AM CEST, Markus Schneider-Pargmann wrote:
> Hi,
>
> On Tue Aug 12, 2025 at 7:36 PM CEST, Marc Kleine-Budde wrote:
>> The CAN Error State is determined by the receive and transmit error
>> counters. The CAN error counters decrease when reception/transmission
>> is successful, so that a status transition back to the Error Active
>> status is possible. This transition is not handled by
>> m_can_handle_state_errors().
>>
>> Add the missing detection of the Error Active state to
>> m_can_handle_state_errors() and extend the handling of this state in
>> m_can_handle_state_change().
>>
>> Fixes: e0d1f4816f2a ("can: m_can: add Bosch M_CAN controller support")
>> Fixes: cd0d83eab2e0 ("can: m_can: m_can_handle_state_change(): fix state=
 change")
>> Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
>> ---
>>  drivers/net/can/m_can/m_can.c | 48 ++++++++++++++++++++++++++----------=
-------
>>  1 file changed, 29 insertions(+), 19 deletions(-)
>>
>> diff --git a/drivers/net/can/m_can/m_can.c b/drivers/net/can/m_can/m_can=
.c
>> index a51dc0bb8124..b485d2f3d971 100644
>> --- a/drivers/net/can/m_can/m_can.c
>> +++ b/drivers/net/can/m_can/m_can.c
>> @@ -812,6 +812,10 @@ static int m_can_handle_state_change(struct net_dev=
ice *dev,
>>  	u32 timestamp =3D 0;
>> =20
>>  	switch (new_state) {
>> +	case CAN_STATE_ERROR_ACTIVE:
>> +		/* error active state */
>
> This comment and the one below don't really help IMHO.
>
>> +		cdev->can.state =3D CAN_STATE_ERROR_ACTIVE;
>> +		break;
>>  	case CAN_STATE_ERROR_WARNING:
>>  		/* error warning state */
>>  		cdev->can.can_stats.error_warning++;
>> @@ -841,6 +845,13 @@ static int m_can_handle_state_change(struct net_dev=
ice *dev,
>>  	__m_can_get_berr_counter(dev, &bec);
>> =20
>>  	switch (new_state) {
>> +	case CAN_STATE_ERROR_ACTIVE:
>> +		/* error active state */
>> +		cf->can_id |=3D CAN_ERR_CRTL | CAN_ERR_CNT;
>> +		cf->data[1] =3D CAN_ERR_CRTL_ACTIVE;
>> +		cf->data[6] =3D bec.txerr;
>> +		cf->data[7] =3D bec.rxerr;
>> +		break;
>>  	case CAN_STATE_ERROR_WARNING:
>>  		/* error warning state */
>>  		cf->can_id |=3D CAN_ERR_CRTL | CAN_ERR_CNT;
>> @@ -877,30 +888,29 @@ static int m_can_handle_state_change(struct net_de=
vice *dev,
>>  	return 1;
>>  }
>> =20
>> +static enum can_state
>> +m_can_can_state_get_by_psr(const u32 psr)
>> +{
>> +	if (psr & PSR_BO)
>> +		return CAN_STATE_BUS_OFF;
>> +	if (psr & PSR_EP)
>> +		return CAN_STATE_ERROR_PASSIVE;
>> +	if (psr & PSR_EW)
>> +		return CAN_STATE_ERROR_WARNING;
>
> Why should m_can_handle_state_errors() should be called if none of these
> flags are set?
>
> m_can_handle_state_errors() seems to only be called if IR_ERR_STATE
> which is defined as:
>   #define IR_ERR_STATE	(IR_BO | IR_EW | IR_EP)
>
> This is the for the interrupt register but will the PSR register bits be
> set without the interrupt register being set?

After reading the other users of the above function, I do see why this
was added. I am still wondering if there is a way to return to
ERROR_ACTIVE once the errors are cleared from the error register.

Also looking at all the users added for the function above, could you
read the register inside the function? Currently you are adding a
reg variable and a read call for each call to this function.
m_can_handle_state_errors() also doesn't need the psr value with your
refactoring.

Best
Markus

>
> Best
> Markus
>
>> +
>> +	return CAN_STATE_ERROR_ACTIVE;
>> +}
>> +
>>  static int m_can_handle_state_errors(struct net_device *dev, u32 psr)
>>  {
>>  	struct m_can_classdev *cdev =3D netdev_priv(dev);
>> -	int work_done =3D 0;
>> +	enum can_state new_state;
>> =20
>> -	if (psr & PSR_EW && cdev->can.state !=3D CAN_STATE_ERROR_WARNING) {
>> -		netdev_dbg(dev, "entered error warning state\n");
>> -		work_done +=3D m_can_handle_state_change(dev,
>> -						       CAN_STATE_ERROR_WARNING);
>> -	}
>> +	new_state =3D m_can_can_state_get_by_psr(psr);
>> +	if (new_state =3D=3D cdev->can.state)
>> +		return 0;
>> =20
>> -	if (psr & PSR_EP && cdev->can.state !=3D CAN_STATE_ERROR_PASSIVE) {
>> -		netdev_dbg(dev, "entered error passive state\n");
>> -		work_done +=3D m_can_handle_state_change(dev,
>> -						       CAN_STATE_ERROR_PASSIVE);
>> -	}
>> -
>> -	if (psr & PSR_BO && cdev->can.state !=3D CAN_STATE_BUS_OFF) {
>> -		netdev_dbg(dev, "entered error bus off state\n");
>> -		work_done +=3D m_can_handle_state_change(dev,
>> -						       CAN_STATE_BUS_OFF);
>> -	}
>> -
>> -	return work_done;
>> +	return m_can_handle_state_change(dev, new_state);
>>  }
>> =20
>>  static void m_can_handle_other_err(struct net_device *dev, u32 irqstatu=
s)


--6db1d471c9c250ed1ed934d67c049fe0a0019dde128316248cc74167230a
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iKMEABYKAEsWIQSJYVVm/x+5xmOiprOFwVZpkBVKUwUCaKWQvBsUgAAAAAAEAA5t
YW51MiwyLjUrMS4xMSwyLDIRHG1zcEBiYXlsaWJyZS5jb20ACgkQhcFWaZAVSlO1
5wEAp+RM3ri661F8DSVrOwkjIHNK3FRrKMGpvQ9+2ZfBboMBAP+8Apk0qQiDYemC
cBJxINhtFDZRi304P3xDyHHa0FkC
=Epp4
-----END PGP SIGNATURE-----

--6db1d471c9c250ed1ed934d67c049fe0a0019dde128316248cc74167230a--

