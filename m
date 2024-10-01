Return-Path: <linux-can+bounces-1585-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 68EBD98BC9F
	for <lists+linux-can@lfdr.de>; Tue,  1 Oct 2024 14:49:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 25B4E283B1F
	for <lists+linux-can@lfdr.de>; Tue,  1 Oct 2024 12:49:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 119EC1C2458;
	Tue,  1 Oct 2024 12:48:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="HDWaNsk4"
X-Original-To: linux-can@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 285941C243F
	for <linux-can@vger.kernel.org>; Tue,  1 Oct 2024 12:48:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727786932; cv=none; b=u9IvvpRaeO0MQym8CImNX5N6xWtIH1DEhDKyjCJrZtuwwpyhXF6FFfL375v3/579D57Fl6lfgyc6/C+4hBWTxfFI/XnlWEJi7asu5EcdIW9bqlNXIhB7U2ojg+jrKlA3stT4Hnkae9ZCftva73hNljjLiSCkb2vSC3JbA/f6yt8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727786932; c=relaxed/simple;
	bh=nEWKxUMdWGMgW+gWKBVVzHfEaP+asrwjJF9LsvCw53M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fBommeOXExN3SWapOwrYFWULFAsRB7rCprCYOH+r+/Jg4GXVhLZ//8LeszN1lfdX6bUOrHVNL2CITGr4V+G6rcZTcwdSV3jp2YXWHsW+H6Tjm1dHwhLTKCjN61+HRpnzgS5Dod400gqYDngP/d44Le3zNeR2/F4N7onlt6g12yU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=HDWaNsk4; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-42cbface8d6so67132345e9.3
        for <linux-can@vger.kernel.org>; Tue, 01 Oct 2024 05:48:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1727786928; x=1728391728; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=5hMOGW80f+NuaOEi+vwiPlVKT7oesKr1VRHb22CCczw=;
        b=HDWaNsk4tLdLh1d6A2E5uulq/XYYrDX/LdDP8y1z6aI+eh8D1a+ruHBEbdm9MFASeV
         s3L5SnFrBwtmTKXbWcRJZrvoD+1mKM81t48XnBq4Q7z8a+Mi49Kvt/OCiX7YOtRuwhNW
         ySzPEm0KAS1xEj/1RIspYxFg5J3WQqMQvL5AMmpflNBmJlwmkeocyRVajh3M/6E1ycvH
         eLCk+d/btsIdaFbMub9RUD4ZXX6lMZCNf0X4k0/J/ZdplnCgnJCRZsAPaLcSCaEiUWdZ
         cMnWsMkMaAmLP4/QYw40GqcYZa8XZfHjGoKISbPk2basGgbjrg/Um9AOihu5TeGAtd7T
         +LBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727786928; x=1728391728;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5hMOGW80f+NuaOEi+vwiPlVKT7oesKr1VRHb22CCczw=;
        b=Q5BafhaX1GT521MrPm5J4HkCJqePRvAeJVZUxNmJhMcBJ1Qvvf4HssFndKw53lxG1b
         XdtBhLW9M5/QFuz7L9/BiO5uN7MPnHG/eodiTXKL5aljjCe86OSvDHPF/JjL6Jsmrz+4
         hVHzJlb8lisgaevQZuNEacrViTYS7+A03DiOOmp2hbQ2/NYdhM05Zf9MBBYY9uRZFtvl
         LlYS85jODYQEw2/TzGVOQkV3u07fvUOAZ0RARCja2AqaFZmS6XNf/3fXnI4dnpiSjj//
         1UgbzFb2dASE0DQnwDrD8/2Mi82n49JqoMR5+TDPsRSEOXWE2O+g/AL2/n5wcfFdYaWR
         oc+Q==
X-Forwarded-Encrypted: i=1; AJvYcCXJN27B1XBwcXfKrJf9+m6y52SxT0+IEOjtHog4VetOHO19Ew183PxJ3dcum+WGiFL2/AO0xChcwSA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yys5c9U4o37fYxhreNi6NYO1XEco3szJQ/XO9msR7SNhZFs3KFj
	TbcZH2+s1fZDlJdGxq1Z8VX/3sJpI4JMQltyuJ/FE5evKrFymy2yYAlXdMlhQr4=
X-Google-Smtp-Source: AGHT+IHW2dicTy3yGboJa9JdIUQESQQwH/9XKIgWlgnf8mQ7nWVG8Q1I6ddPzQWXYQZwJT2YTZb0LA==
X-Received: by 2002:a05:600c:46c5:b0:42c:b62c:9f0d with SMTP id 5b1f17b1804b1-42f5844c0acmr163017255e9.17.1727786928310;
        Tue, 01 Oct 2024 05:48:48 -0700 (PDT)
Received: from localhost ([2001:4091:a245:8155:c84f:5b4a:8d3f:75b2])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42f73d75941sm12044075e9.1.2024.10.01.05.48.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Oct 2024 05:48:47 -0700 (PDT)
Date: Tue, 1 Oct 2024 14:48:46 +0200
From: Markus Schneider-Pargmann <msp@baylibre.com>
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: Chandrasekar Ramakrishnan <rcsekar@samsung.com>, 
	Vincent Mailhol <mailhol.vincent@wanadoo.fr>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Tony Lindgren <tony@atomide.com>, Judith Mendez <jm@ti.com>, 
	linux-can@vger.kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	kernel@pengutronix.de
Subject: Re: [PATCH] can: m_can: m_can_close(): don't call free_irq() for
 IRQ-less devices
Message-ID: <agcndznzxzme552ftebopyu326el4aikq5n6azj3rf4nijxbda@crv5zxjxbdek>
References: <20240930-m_can-cleanups-v1-1-001c579cdee4@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="zz4jmmcrvmrsmrv6"
Content-Disposition: inline
In-Reply-To: <20240930-m_can-cleanups-v1-1-001c579cdee4@pengutronix.de>


--zz4jmmcrvmrsmrv6
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 30, 2024 at 07:45:57PM GMT, Marc Kleine-Budde wrote:
> In commit b382380c0d2d ("can: m_can: Add hrtimer to generate software
> interrupt") support for IRQ-less devices was added. Instead of an
> interrupt, the interrupt routine is called by a hrtimer-based polling
> loop.
>=20
> That patch forgot to change free_irq() to be only called for devices
> with IRQs. Fix this, by calling free_irq() conditionally only if an
> IRQ is available for the device (and thus has been requested
> previously).
>=20
> Fixes: b382380c0d2d ("can: m_can: Add hrtimer to generate software interr=
upt")
> Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>

Reviewed-by: Markus Schneider-Pargmann <msp@baylibre.com>

Best
Markus

> ---
>  drivers/net/can/m_can/m_can.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/net/can/m_can/m_can.c b/drivers/net/can/m_can/m_can.c
> index a978b960f1f1e1e8273216ff330ab789d0fd6d51..16e9e7d7527d9762d73a7ec47=
940c73c0976e05d 100644
> --- a/drivers/net/can/m_can/m_can.c
> +++ b/drivers/net/can/m_can/m_can.c
> @@ -1765,7 +1765,8 @@ static int m_can_close(struct net_device *dev)
>  	netif_stop_queue(dev);
> =20
>  	m_can_stop(dev);
> -	free_irq(dev->irq, dev);
> +	if (dev->irq)
> +		free_irq(dev->irq, dev);
> =20
>  	m_can_clean(dev);
> =20
>=20
> ---
> base-commit: d505d3593b52b6c43507f119572409087416ba28
> change-id: 20240930-m_can-cleanups-53ce4276f1b1
>=20
> Best regards,
> --=20
> Marc Kleine-Budde <mkl@pengutronix.de>
>=20
>=20

--zz4jmmcrvmrsmrv6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTd8KHufh7XoFiu4kEkjLTi1BWuPwUCZvvvpAAKCRAkjLTi1BWu
PwlwAP4rSwbPxvY6TJiABaBt5NYMGfVWNTMZHh2z/hynxz8VyQEAlPEgEKtQYxj7
ipvfvbZZFy/uHxZL1VsM094tkn3hgQI=
=khhN
-----END PGP SIGNATURE-----

--zz4jmmcrvmrsmrv6--

