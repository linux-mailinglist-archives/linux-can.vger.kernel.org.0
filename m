Return-Path: <linux-can+bounces-4262-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D4ACEB2BBAF
	for <lists+linux-can@lfdr.de>; Tue, 19 Aug 2025 10:23:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 862121886C89
	for <lists+linux-can@lfdr.de>; Tue, 19 Aug 2025 08:23:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA45D1A3A80;
	Tue, 19 Aug 2025 08:22:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="E3TQQHMD"
X-Original-To: linux-can@vger.kernel.org
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A66223451CF
	for <linux-can@vger.kernel.org>; Tue, 19 Aug 2025 08:22:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755591776; cv=none; b=bX5Zsrit5q4VUDvtKDOCMfYXa7/WyUhRS9QuebpgYneXCIDfZJTmPzhZxBC5RHAr9owBweFhsKPjmq+tRa4c+sdVTPUgwuJ8Uk9V+iToC2biRQ3Ix5azMqAkIGntp9FNG2OpXccY8c2LDQhjnrmoyrliuJPmv0VKsPiGGfwjbOM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755591776; c=relaxed/simple;
	bh=m7Qft2exuOUoR0wMKCXPDgPvneFrO1oxaOH/gu7phBE=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:From:To:Cc:
	 References:In-Reply-To; b=mJNyBjEbHJ6AMt7A366U3C0sFgNsbXAgEHmgJJMGKlCzvo4ESyQyr8w69dHBtivk0/Jqk+8Ozc5HwfpYesxr+XRAo+kPaMVZuEuXD2RMuWumcqkrP4wDKNbWP8GAxVwmWGuJX6AsjDcgX9QDyaTz46+GCuzwUWKvjFzeBUhywRo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=E3TQQHMD; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-afcb78ead12so707867566b.1
        for <linux-can@vger.kernel.org>; Tue, 19 Aug 2025 01:22:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1755591772; x=1756196572; darn=vger.kernel.org;
        h=in-reply-to:references:cc:to:from:subject:message-id:date
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=L1Njkru38l0QOoJlAufglEomIeGj1U8B+0WCyzenuAc=;
        b=E3TQQHMD1Xh9mQGwkCZhSk/Q3AF1flCcNIb7dc/5XKBhyH+wF59p+rf96GdTMEX59g
         qUxxJBO2AHhXCkMK1k3iaroRVt+fgNDAKZp3Mq5H7vBijt+tswOEPluxeAWxdO+sOkZC
         fo9XBca32zDxfjopOtE1XGK8yzxuKyyyQDDy7mV/mgkXwtqAK8MjghyZKHtxVLP56yvC
         L85Ivr9wgvSZvZ+XSrlyvGdRIRRjSh08yzejn0AOmmAECUQxzWUujVqHpxkWkV91Pdwb
         EIP3M179brlFObMlb7w7msfJDs7Rf2T/tpyVqSnWvRbs150IC2JnF9MDo3+/s3GnIJ3d
         g2Qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755591772; x=1756196572;
        h=in-reply-to:references:cc:to:from:subject:message-id:date
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=L1Njkru38l0QOoJlAufglEomIeGj1U8B+0WCyzenuAc=;
        b=r5anWooR5VFGVs3uTEyaFDeYYHwvzyi+A6oPgAiOsInshGhQyVRXGD14+XHOIdl1IJ
         srichTmUnb1U9UQhnMUv0es59ArXeowpVhkvZKc8M/RRdeUK+VxlZ6qrA/t+LQqcxyef
         leCubG4W5PboTubEyGO5/+y1lSbzU1W6ib/Ji0dD5goFFAAd2KdpKqhmN+t1BNlHLs70
         NhFLOV6b75M2WOyoKKyhLbpFe3jrFiELxuvNsx4ID7e0ljFvdeFzrHHygYSMaTwTHdEt
         WcwS7voa2k9SmAn2I/crrLhLYzz3Q/adVH4f7+V6ZOSrqt/VdgmUW9GBVcmIlQEwsCOl
         UWzQ==
X-Gm-Message-State: AOJu0Yz6zg5Qo7CkfdVcfQNygEzQ2H9yi+bnaHFqi2HCOy+OcM2pZmMP
	iCggjsaRTin/I92yMbMhixNx11xmMrdziHuuJFmN5ZffhrDWxxKe4nrmkahnNyv/cpY=
X-Gm-Gg: ASbGncvjdb2b1utWyyly+BZgaUTAvNJudvjbyYYn7lRSW1mogmz8rYIvCEXLVi2bA7r
	1cUyR8kEHgdcBQSLKAujQn1zd2F+WqjO2eA0L3hnNzMAUckXxloQ850x7j+8Kqpe/6Gzt6bHMzK
	+D1FHJZgU/svbuS0DjXaWyVgf3sUnJ19CAlPDPESJn2Xt7LkO9cm2s30Y5YkuogSBLWSSKhtYNY
	gor992HuXAWwqTXFnuu3fzeRPAgz0wlu9ugLSwXUG3W1Qk8SruGZ5uBRFraVJhoDDNCuNIiQCoi
	QcdR67B5SUe+ZXHlehTjeOgV5p/vWfG84ihcziyVYq4oxHTEcQOanBjyC0sz4oAqq9XF5MU+739
	bvjT5zhVzs2Pz5wXwKFcWbRKE
X-Google-Smtp-Source: AGHT+IHQ6IdI5sz4L18Yu1QZQTvncbAaZVp3nVGEwQGE+IqJb6cAlIJuAKwGy+/BUZFGq/kMFQJjyg==
X-Received: by 2002:a17:906:2a99:b0:af9:885e:d36c with SMTP id a640c23a62f3a-afddd200cefmr130153366b.51.1755591771920;
        Tue, 19 Aug 2025 01:22:51 -0700 (PDT)
Received: from localhost ([195.52.61.108])
        by smtp.gmail.com with UTF8SMTPSA id a640c23a62f3a-afcdd018a78sm952328866b.94.2025.08.19.01.22.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Aug 2025 01:22:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: multipart/signed;
 boundary=b503e628a8fe4bcc91b58492e55f6736818a0e22ecd6078894dcbad57484;
 micalg=pgp-sha512; protocol="application/pgp-signature"
Date: Tue, 19 Aug 2025 10:22:45 +0200
Message-Id: <DC69CAZD1X5T.XGQPHLBKGPTP@baylibre.com>
Subject: Re: [PATCH 1/7] can: m_can: m_can_plat_remove(): add missing
 pm_runtime_disable()
From: "Markus Schneider-Pargmann" <msp@baylibre.com>
To: "Marc Kleine-Budde" <mkl@pengutronix.de>, "Chandrasekar Ramakrishnan"
 <rcsekar@samsung.com>, "Vincent Mailhol" <mailhol.vincent@wanadoo.fr>,
 "Patrik Flykt" <patrik.flykt@linux.intel.com>, "Dong Aisheng"
 <b29396@freescale.com>, "Fengguang Wu" <fengguang.wu@intel.com>, "Varka
 Bhadram" <varkabhadram@gmail.com>, "Wu Bo" <wubo.oduw@gmail.com>, "Philipp
 Zabel" <p.zabel@pengutronix.de>
Cc: <linux-can@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <kernel@pengutronix.de>
X-Mailer: aerc 0.20.1
References: <20250812-m_can-fix-state-handling-v1-0-b739e06c0a3b@pengutronix.de> <20250812-m_can-fix-state-handling-v1-1-b739e06c0a3b@pengutronix.de>
In-Reply-To: <20250812-m_can-fix-state-handling-v1-1-b739e06c0a3b@pengutronix.de>

--b503e628a8fe4bcc91b58492e55f6736818a0e22ecd6078894dcbad57484
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8

On Tue Aug 12, 2025 at 7:36 PM CEST, Marc Kleine-Budde wrote:
> Commit 227619c3ff7c ("can: m_can: move runtime PM enable/disable to
> m_can_platform") moved the PM runtime enable from the m_can core
> driver into the m_can_platform.
>
> That patch forgot to move the pm_runtime_disable() to
> m_can_plat_remove(), so that unloading the m_can_platform driver
> causes an "Unbalanced pm_runtime_enable!" error message.
>
> Add the missing pm_runtime_disable() to m_can_plat_remove() to fix the
> problem.
>
> Cc: Patrik Flykt <patrik.flykt@linux.intel.com>
> Fixes: 227619c3ff7c ("can: m_can: move runtime PM enable/disable to m_can=
_platform")
> Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>

Reviewed-by: Markus Schneider-Pargmann <msp@baylibre.com>

> ---
>  drivers/net/can/m_can/m_can_platform.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/net/can/m_can/m_can_platform.c b/drivers/net/can/m_c=
an/m_can_platform.c
> index b832566efda0..057eaa7b8b4b 100644
> --- a/drivers/net/can/m_can/m_can_platform.c
> +++ b/drivers/net/can/m_can/m_can_platform.c
> @@ -180,7 +180,7 @@ static void m_can_plat_remove(struct platform_device =
*pdev)
>  	struct m_can_classdev *mcan_class =3D &priv->cdev;
> =20
>  	m_can_class_unregister(mcan_class);
> -
> +	pm_runtime_disable(mcan_class->dev);
>  	m_can_class_free_dev(mcan_class->net);
>  }
> =20


--b503e628a8fe4bcc91b58492e55f6736818a0e22ecd6078894dcbad57484
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iKMEABYKAEsWIQSJYVVm/x+5xmOiprOFwVZpkBVKUwUCaKQ0VRsUgAAAAAAEAA5t
YW51MiwyLjUrMS4xMSwyLDIRHG1zcEBiYXlsaWJyZS5jb20ACgkQhcFWaZAVSlNm
MQD/ehJlyjV9qxlZOvdKCqkSom2T+5Mpi2A2cSo+AdV7WcYA/1oPIUAvbvp1Wnd9
cDdrbLzXQ+tlisjks+4a/+Lj/fEF
=BpmN
-----END PGP SIGNATURE-----

--b503e628a8fe4bcc91b58492e55f6736818a0e22ecd6078894dcbad57484--

