Return-Path: <linux-can+bounces-4627-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B0E29B511AC
	for <lists+linux-can@lfdr.de>; Wed, 10 Sep 2025 10:42:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0AEAC448046
	for <lists+linux-can@lfdr.de>; Wed, 10 Sep 2025 08:42:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8FD03101DE;
	Wed, 10 Sep 2025 08:41:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="xG3wBtqw"
X-Original-To: linux-can@vger.kernel.org
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C34192BF3CC
	for <linux-can@vger.kernel.org>; Wed, 10 Sep 2025 08:41:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757493712; cv=none; b=H6IJRypxVq1bF+OU3D5a94zNRN5r9a7gPQurJ3qlhGXMw0rooiaSWi49WqmwTG7STXw6kqKC31BA+Iw3OdX1Vcjpnk+lJwmNB9BhrCahE4TUQLVedH7s6RvnaI49RFfdC5pgT0OgoeVwJNqL5cewN2faiCghIdW+tZSfYwC0cAE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757493712; c=relaxed/simple;
	bh=8BYfSHtHTpHBWXb4w05N17dIDEdh483y9XhV1TMwVBA=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=pLXijYi2UO8ugMVGYSCk34Ci4fz7PWRsuUz8CeNElYU1GF6estX/Yir+IT7R3QDhHhSi5BigGDHHSvW10DccDZgc1SPhMyKi2jRbSZzoXi7M1ZAQKqiHr4I30/okiJtSnGjBtZ8uriVoF3f4fLgtKJQBPR+UX+bPC5yA/oOqrOo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=xG3wBtqw; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-b0787fc3008so81068466b.3
        for <linux-can@vger.kernel.org>; Wed, 10 Sep 2025 01:41:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1757493708; x=1758098508; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=qSif0aXJJp0kSU7OZvdmQspKrVD0dDMIeIyzSM258Dg=;
        b=xG3wBtqwXx8nj6SiOXx6dmAmsucmcNhpQm2FaIrsjkQuRPJpRoGNegce4BYcA2nC3f
         OpJ+EFfZZGV7fx1j0ynfQEF/falPddtxS37NEfc02bIj54tB8oJMF8Dg2OzDaYBCYr4n
         5L9gaK72nVYY6GD0214GOXrSsbiRahVRZ9+pNUuTXjDXmZsZGaSnGKlazILjzhCrLgeL
         1pKKSFYEyoC2xszzUTobsL4dYJ7mkba7AaRE7rUqmr6dc0OXy11e1FSbWB6yIbnEeTfg
         uZ5OsX3JIk2nu8WU+EtqhnmU1GscYE7TJIvTjgBf4eHXotNoY0bLm3EkGve++HOOqfzo
         ohHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757493708; x=1758098508;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qSif0aXJJp0kSU7OZvdmQspKrVD0dDMIeIyzSM258Dg=;
        b=XWsBcY3AGIV+tIUwnxZG68eRX56d3wRrSfVjw+9S+P5Va6d7szXkzXZEpvJNCnMvkF
         Vs2vq0uulngBTqmEfi/63/vOWWRzDeZtPoJnjABgAPl8Q8RL7mA/lT8jFf90CJm3L4FI
         6iz1Bx4b8a1M2GPKMxoxVhd0nn+DjGwXHVvY90aWyH8aFqs/O3u3fnpDflaibgy4+2lJ
         8/vHUF11HKsW3jPDQnbeQOqcom1ZADgwK5yiDymg4XissHbBgqCSF8KRzy2uCkaaG+ny
         ZIn3Id28v2Xx4Mn2jGd2hZpnt1vrgOoE0iWWjPY4h7qp6rMZZmAGzzVYca3va4fT1gCo
         WN/w==
X-Gm-Message-State: AOJu0Yxky5pvrvtmRSJ8HvkhhKGV4/Ka7LdOdIsiKyiv5rIgetIkLlGD
	dHHQ6I4RhbIC++afIYnK4/qd8kiNMX4njwpZK5JELCoNM14U/gfxjrM/kw9fHvGy2U0=
X-Gm-Gg: ASbGncub69By8g+hLgNpi+cpU2Oce319i+urKlm2Ez9FD4FLol3rtD/6Z4wAwDBTE1m
	TMlMbhMTZ/5uqHzimA/xgl+Xt1mbHVXFCPzFp3CY5SWFAwB2XQeEFc3cPLABwND19/267dcrvqe
	tgjRWcmIVEEUe2W6AoVuZZqpw0w0oND8I4s95vhP1hhRPoU+Og9C01maoGYzIOYI6wX1SHaBc4l
	3TVD8xk9pVITnwlbFt/OCQ/L/Gd9jbgJJl0EkAkMz6QdBMVVVndhyGafKQws/Tm2el8skRzLLZa
	0UHu1ugEOkdw83GlqKwzkBsfcsyzNpyL7ZE1n2NLsvE0F+5LlC3dGfowlgRb/QwWqgbYoUli6At
	gvJNQMBs+AzSp4bI=
X-Google-Smtp-Source: AGHT+IExNmOsAnAJtqdj679s6TGYzo8sTv/XkpvZFopED68H/ezdLpRsIanj2ZU7Y2gRe1TpbDGmjQ==
X-Received: by 2002:a17:907:6092:b0:b04:6a58:560b with SMTP id a640c23a62f3a-b04b1545011mr1444007166b.39.1757493705475;
        Wed, 10 Sep 2025 01:41:45 -0700 (PDT)
Received: from localhost ([195.52.61.108])
        by smtp.gmail.com with UTF8SMTPSA id a640c23a62f3a-b07833a7cb3sm131465466b.81.2025.09.10.01.41.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Sep 2025 01:41:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: multipart/signed;
 boundary=2e38c85892acb2a28aa9c9c170304678bd4f0f3265d646caeeeb3f8e67ff;
 micalg=pgp-sha512; protocol="application/pgp-signature"
Date: Wed, 10 Sep 2025 10:41:28 +0200
Message-Id: <DCOZIMAYLN8P.23PQEAFQ26ADZ@baylibre.com>
Cc: <linux-can@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <kernel@pengutronix.de>
Subject: Re: [PATCH v2 2/7] can: m_can: only handle active interrupts
From: "Markus Schneider-Pargmann" <msp@baylibre.com>
To: "Marc Kleine-Budde" <mkl@pengutronix.de>, "Chandrasekar Ramakrishnan"
 <rcsekar@samsung.com>, "Vincent Mailhol" <mailhol.vincent@wanadoo.fr>,
 "Patrik Flykt" <patrik.flykt@linux.intel.com>, "Dong Aisheng"
 <b29396@freescale.com>, "Varka Bhadram" <varkabhadram@gmail.com>, "Wu Bo"
 <wubo.oduw@gmail.com>, "Philipp Zabel" <p.zabel@pengutronix.de>
X-Mailer: aerc 0.20.1
References: <20250909-m_can-fix-state-handling-v2-0-af9fa240b68a@pengutronix.de> <20250909-m_can-fix-state-handling-v2-2-af9fa240b68a@pengutronix.de>
In-Reply-To: <20250909-m_can-fix-state-handling-v2-2-af9fa240b68a@pengutronix.de>

--2e38c85892acb2a28aa9c9c170304678bd4f0f3265d646caeeeb3f8e67ff
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8

On Tue Sep 9, 2025 at 7:53 PM CEST, Marc Kleine-Budde wrote:
> The M_CAN IP core has an Interrupt Register (IR) and an Interrupt
> Enable (IE) register. An interrupt is triggered if at least 1 bit is
> set in the bitwise and of IR and IE.
>
> Depending on the configuration not all interrupts are enabled in the
> IE register. However the m_can_rx_handler() IRQ handler looks at all
> interrupts not just the enabled ones. This may lead to handling of not
> activated interrupts.
>
> Fix the problem and mask the irqstatus (IR register) with the
> active_interrupts (cached value of IE register).
>
> Fixes: e0d1f4816f2a ("can: m_can: add Bosch M_CAN controller support")
> Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
> ---
>  drivers/net/can/m_can/m_can.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/drivers/net/can/m_can/m_can.c b/drivers/net/can/m_can/m_can.=
c
> index fe74dbd2c966..16b38e6c3985 100644
> --- a/drivers/net/can/m_can/m_can.c
> +++ b/drivers/net/can/m_can/m_can.c
> @@ -1057,6 +1057,7 @@ static int m_can_poll(struct napi_struct *napi, int=
 quota)
>  	u32 irqstatus;
> =20
>  	irqstatus =3D cdev->irqstatus | m_can_read(cdev, M_CAN_IR);
> +	irqstatus &=3D cdev->active_interrupts;
> =20
>  	work_done =3D m_can_rx_handler(dev, quota, irqstatus);
> =20
> @@ -1243,6 +1244,8 @@ static int m_can_interrupt_handler(struct m_can_cla=
ssdev *cdev)
>  	}
> =20
>  	m_can_coalescing_update(cdev, ir);
> +
> +	ir &=3D cdev->active_interrupts;

m_can_coalescing_update() can change active_interrupts, meaning the
interrupt that caused the interrupt handler to run may be disabled in
active_interrupts above and then masked in this added line. Would that
still work or does it confuse the hardware?

Best
Markus

>  	if (!ir)
>  		return IRQ_NONE;
> =20


--2e38c85892acb2a28aa9c9c170304678bd4f0f3265d646caeeeb3f8e67ff
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iKMEABYKAEsWIQSJYVVm/x+5xmOiprOFwVZpkBVKUwUCaME5uBsUgAAAAAAEAA5t
YW51MiwyLjUrMS4xMSwyLDIRHG1zcEBiYXlsaWJyZS5jb20ACgkQhcFWaZAVSlPh
JwD+O882FfXxbmgBdEqU131VdRliujOf0g8vLBYeCBmbUP8BAMU2SEytkBNKdis0
htuDc2xS83czxVfU4r/5EMimHwcD
=ewUL
-----END PGP SIGNATURE-----

--2e38c85892acb2a28aa9c9c170304678bd4f0f3265d646caeeeb3f8e67ff--

