Return-Path: <linux-can+bounces-4628-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 395E7B511C4
	for <lists+linux-can@lfdr.de>; Wed, 10 Sep 2025 10:48:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E68333B7D4D
	for <lists+linux-can@lfdr.de>; Wed, 10 Sep 2025 08:48:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A80A230DEA6;
	Wed, 10 Sep 2025 08:47:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="VuE9AfxW"
X-Original-To: linux-can@vger.kernel.org
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED2C1289E0B
	for <linux-can@vger.kernel.org>; Wed, 10 Sep 2025 08:47:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757494078; cv=none; b=XGzZ3JQCuwRp9V2/cFQP89tENlEP9IfOnL+Zt7IHrNbp4bNvyuwcjBlY2uN4OmHYJneJzpdOY1c1mqBnP0abw/tDCb77elnTj3ZczSDta0E851inwjikGePqsThMwcjcNaaHQLtYNoIRadkbfFJhMHxTZerjr93AL7pV9bptkRc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757494078; c=relaxed/simple;
	bh=5Wxy+cByCfGdHHb4M2ZsMYsBI19fkHCRvTB58Mup2WI=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=EFSflwWNaWnVpsXOUJicuCytZI0YqXfBDG8FNJPKAS2vk3vLpZdB9dN1oEHbqQof0b/YvCFb2hgEhIUfAgsELYnlXKefbqR/RznZFog3uaN00eVcBHHdbDwuZhF4RGUKohmQsxeAf7dmJvOrsAbArulk0R1cRyMIbu8nWpfFTCs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=VuE9AfxW; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-aff0775410eso86254566b.0
        for <linux-can@vger.kernel.org>; Wed, 10 Sep 2025 01:47:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1757494074; x=1758098874; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Np8jfN3sYCP+UmiGDdyhOB20Mr6qqzZDL1HeGBXkwGc=;
        b=VuE9AfxW7MCHGW9SdJp/vK5WvuLsuvgOaUFfhpanXsdr+ocKybKrppHJUfKkRZy8yy
         bR+8XctnRcM8W2H+9vP80pKpEaor1gikmPEzehCYPvFHPJpznoi8GTqzoSz/2y7XKIXz
         DnlDdUX2/rSG7Jo+aTptGjH4wBmYgnX/zDsN2klgZGbBsDXlL1poSktyvbc/Oc/73D7f
         aRRnrWSlfzS7lB7kGRE5nUwFFPsknjYJHJ1x7ys1I/8VR/W8H6JEcYPGTTwf5f9FWDDq
         JXDPWEhpM766/up/yLNi/MxRZAbtL5XQHGoOI5x96+LsQrCtvxCaByuuqwvXM/J0ZZbB
         EsUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757494074; x=1758098874;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Np8jfN3sYCP+UmiGDdyhOB20Mr6qqzZDL1HeGBXkwGc=;
        b=LS3uKFU1aMjUfvKDALQuwzW/esA7wLUVr0lWqzo9oeFNCIZtHRONgp+npfqjvgWblU
         zrNdE+2IdFJQH9oqVmxc5vN+MsDCzP/pSTw6E5AJPynsJwQ8tcGxx2D4cYy3zWQjeaZD
         iXK3lh9BzSMW17Qvc6riVMNfF0t/i5prPXrg5oJ04XT/r2fGmEf0mevl0Pq3ZVJCDT2f
         Ki2901Zdm8N0JvTy4HIS5BeMh+IkACSSXuDzRkBLT/vatm1/wk7pjJpze7aGEpZCw7Le
         E9PGTMp72nDnh/kRQUEQns32t9SmSmoN3Sf1KTjmYysnh0NCu01u2DUcTQ5ULxhzcfZI
         Xm3Q==
X-Gm-Message-State: AOJu0YyAIhywUPMcYorCiw49xAXnfXiH4aaD6zNCPyRbfiNNdEq1mlEA
	y4PDTuMDUAi9Y48zh4QUl0LjUvin+F8Eyz1SmqoOSglPf7qZ936o8bY85QAOW0oVN6o=
X-Gm-Gg: ASbGncvtCvOwKpdWwedyf217CdjPWSCoIgeiVPkRbalc7CFw/aoXNV2vVxTro0fz6Ko
	EfJEtM6SqrDYZvclw9aqm9SvtrpIzHDAa8hVNcI7wg7RpwLPOr6O8BseQK47FANItfKW6oisLEb
	Xsz8/rwWqDCb/K9bckLwLvLpkCf9S4CTOsloR9tTZi2wwIYBnaLqZzb+aqVen+QVcCyvVDYRAJO
	VT1pI516VuECDe/peck++U43veC3E8iRF5ewXjAd2P92JUpEzdGKDtAG7fIiULqy1Wym1uj1zgG
	jT3+9qREFG/yIV6WvEoO4VOVRizPSZXlYiZ8g+FHdNhZSKqvcBN6PB7ErVkQsnza+2edtzOeGuH
	eMXkWqEpXwaTiORo=
X-Google-Smtp-Source: AGHT+IFFXA9GkG6+WLmmoEATkhmBMPCC6WdDDdJFkTbluD5Nd2yRv1fYzfd/AlqQM/vXH5uJHFTLTg==
X-Received: by 2002:a17:906:ef04:b0:af9:8739:10ca with SMTP id a640c23a62f3a-b0493282aecmr1879849966b.28.1757494074240;
        Wed, 10 Sep 2025 01:47:54 -0700 (PDT)
Received: from localhost ([195.52.61.108])
        by smtp.gmail.com with UTF8SMTPSA id a640c23a62f3a-b078340ddb3sm126731466b.96.2025.09.10.01.47.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Sep 2025 01:47:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: multipart/signed;
 boundary=8030d55e11177121433a9ebb9e4a605ad54d0a0699010de488929059151e;
 micalg=pgp-sha512; protocol="application/pgp-signature"
Date: Wed, 10 Sep 2025 10:47:45 +0200
Message-Id: <DCOZNFLPYZFH.2EWPVI5X452IJ@baylibre.com>
Cc: <linux-can@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <kernel@pengutronix.de>
Subject: Re: [PATCH v2 3/7] can: m_can: m_can_handle_state_errors(): fix CAN
 state transition to Error Active
From: "Markus Schneider-Pargmann" <msp@baylibre.com>
To: "Marc Kleine-Budde" <mkl@pengutronix.de>, "Chandrasekar Ramakrishnan"
 <rcsekar@samsung.com>, "Vincent Mailhol" <mailhol.vincent@wanadoo.fr>,
 "Patrik Flykt" <patrik.flykt@linux.intel.com>, "Dong Aisheng"
 <b29396@freescale.com>, "Varka Bhadram" <varkabhadram@gmail.com>, "Wu Bo"
 <wubo.oduw@gmail.com>, "Philipp Zabel" <p.zabel@pengutronix.de>
X-Mailer: aerc 0.20.1
References: <20250909-m_can-fix-state-handling-v2-0-af9fa240b68a@pengutronix.de> <20250909-m_can-fix-state-handling-v2-3-af9fa240b68a@pengutronix.de>
In-Reply-To: <20250909-m_can-fix-state-handling-v2-3-af9fa240b68a@pengutronix.de>

--8030d55e11177121433a9ebb9e4a605ad54d0a0699010de488929059151e
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8

On Tue Sep 9, 2025 at 7:53 PM CEST, Marc Kleine-Budde wrote:
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

Reviewed-by: Markus Schneider-Pargmann <msp@baylibre.com>

> ---
>  drivers/net/can/m_can/m_can.c | 55 ++++++++++++++++++++++++++-----------=
------
>  1 file changed, 33 insertions(+), 22 deletions(-)
>
> diff --git a/drivers/net/can/m_can/m_can.c b/drivers/net/can/m_can/m_can.=
c
> index 16b38e6c3985..3edf01b098a4 100644
> --- a/drivers/net/can/m_can/m_can.c
> +++ b/drivers/net/can/m_can/m_can.c
> @@ -812,6 +812,9 @@ static int m_can_handle_state_change(struct net_devic=
e *dev,
>  	u32 timestamp =3D 0;
> =20
>  	switch (new_state) {
> +	case CAN_STATE_ERROR_ACTIVE:
> +		cdev->can.state =3D CAN_STATE_ERROR_ACTIVE;
> +		break;
>  	case CAN_STATE_ERROR_WARNING:
>  		/* error warning state */
>  		cdev->can.can_stats.error_warning++;
> @@ -841,6 +844,12 @@ static int m_can_handle_state_change(struct net_devi=
ce *dev,
>  	__m_can_get_berr_counter(dev, &bec);
> =20
>  	switch (new_state) {
> +	case CAN_STATE_ERROR_ACTIVE:
> +		cf->can_id |=3D CAN_ERR_CRTL | CAN_ERR_CNT;
> +		cf->data[1] =3D CAN_ERR_CRTL_ACTIVE;
> +		cf->data[6] =3D bec.txerr;
> +		cf->data[7] =3D bec.rxerr;
> +		break;
>  	case CAN_STATE_ERROR_WARNING:
>  		/* error warning state */
>  		cf->can_id |=3D CAN_ERR_CRTL | CAN_ERR_CNT;
> @@ -877,30 +886,33 @@ static int m_can_handle_state_change(struct net_dev=
ice *dev,
>  	return 1;
>  }
> =20
> -static int m_can_handle_state_errors(struct net_device *dev, u32 psr)
> +static enum can_state
> +m_can_state_get_by_psr(struct m_can_classdev *cdev)
> +{
> +	u32 reg_psr;
> +
> +	reg_psr =3D m_can_read(cdev, M_CAN_PSR);
> +
> +	if (reg_psr & PSR_BO)
> +		return CAN_STATE_BUS_OFF;
> +	if (reg_psr & PSR_EP)
> +		return CAN_STATE_ERROR_PASSIVE;
> +	if (reg_psr & PSR_EW)
> +		return CAN_STATE_ERROR_WARNING;
> +
> +	return CAN_STATE_ERROR_ACTIVE;
> +}
> +
> +static int m_can_handle_state_errors(struct net_device *dev)
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
> +	new_state =3D m_can_state_get_by_psr(cdev);
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
> @@ -1031,8 +1043,7 @@ static int m_can_rx_handler(struct net_device *dev,=
 int quota, u32 irqstatus)
>  	}
> =20
>  	if (irqstatus & IR_ERR_STATE)
> -		work_done +=3D m_can_handle_state_errors(dev,
> -						       m_can_read(cdev, M_CAN_PSR));
> +		work_done +=3D m_can_handle_state_errors(dev);
> =20
>  	if (irqstatus & IR_ERR_BUS_30X)
>  		work_done +=3D m_can_handle_bus_errors(dev, irqstatus,


--8030d55e11177121433a9ebb9e4a605ad54d0a0699010de488929059151e
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iKMEABYKAEsWIQSJYVVm/x+5xmOiprOFwVZpkBVKUwUCaME7MRsUgAAAAAAEAA5t
YW51MiwyLjUrMS4xMSwyLDIRHG1zcEBiYXlsaWJyZS5jb20ACgkQhcFWaZAVSlOS
8AEA/Cz2GJhok5svEAkYHHWsmzLyszwnF5r0b55RL8ER42MBAMfpsfCTPI8cu+0P
6IlWMBIo+cSY4NQOgdHs7ffWTvIK
=cVYp
-----END PGP SIGNATURE-----

--8030d55e11177121433a9ebb9e4a605ad54d0a0699010de488929059151e--

