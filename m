Return-Path: <linux-can+bounces-3532-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D6C4AAA8DC2
	for <lists+linux-can@lfdr.de>; Mon,  5 May 2025 10:01:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9137C188862D
	for <lists+linux-can@lfdr.de>; Mon,  5 May 2025 08:01:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A304E1E1DE2;
	Mon,  5 May 2025 08:01:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="zht8N0or"
X-Original-To: linux-can@vger.kernel.org
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13BF31D8DFB
	for <linux-can@vger.kernel.org>; Mon,  5 May 2025 08:01:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746432096; cv=none; b=PvfMg1hLg6vPnxmirUOq9chTOsYqaAXALfUWkB5QigWGTuzfSO4zKCT82ncAY2zN5gQy73Yp0RTj32tgEltrwUClBUmA92HegWlkuCPAJmOGrB0AE2LbgCzhiQGRnil6Nnlua2X7IKNs+XIm9Ja5TjKemHA+HQ4+P/unC8alCpI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746432096; c=relaxed/simple;
	bh=9Am8BOf2UXcIbgIf1LWznXDOqFDQaXzGVxzqGJtWZYQ=;
	h=Mime-Version:Content-Type:Date:Message-Id:From:To:Cc:Subject:
	 References:In-Reply-To; b=cWuirKA88GartQ3hheZ1W6V8z4VRbGkXfjXOoDppfVxJOKfbaXlwKGjFAlG3O8a7vye+RV1vke54op6vWziEx+Ael9ZbKTkVBbAn3GcCmnJMDj0zBeYwmMLlZ/QfXK6EQwRLC86DMqL0ZxL1CudBpOYTI++g9xqOCKu5vzyg3fE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=zht8N0or; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-acbb85ce788so1063453866b.3
        for <linux-can@vger.kernel.org>; Mon, 05 May 2025 01:01:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1746432091; x=1747036891; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:message-id:date
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=y1D14DESXgEJssAmCS0DlckceNK8D0Dq2lVptoRgrgc=;
        b=zht8N0orAJ+2M093Ly4fDrgNOgydu3IfxjDaXvQywuD6KOb/8c0RwnXJRX4bEN34Pg
         s3RHhq3BCPNrod9/VSqsYswKas0LBYxDlCsub38TLscvJ4UtjCiQs0grraZj4vRiLCV2
         rXESc8l7rY5N0nO78dI3sfjCayxmFY6U4VJxp1V4rRTJEGxHWedmMuBi8XgrAd77oiRF
         /wmC7+PHesW8kT07R8l/PmXH4oNTWpIW5E1Qxj7xvm3FuHGPXxEWW/ArqSZTh7a3kybU
         FaDw4CQMMSZxLkwepYn50YKib61RoMQA0OHWurf9gLRDpNg8O6SfCuJDOgZdhwQ+WcTT
         DdOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746432091; x=1747036891;
        h=in-reply-to:references:subject:cc:to:from:message-id:date
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=y1D14DESXgEJssAmCS0DlckceNK8D0Dq2lVptoRgrgc=;
        b=GMM90oA2L778THp53nF/AKJ/KVQjqoVPh1Nbt0qXFSyrIiEsrWB+A+/nfir/7pOmMl
         3NRRFA3vLWz36yY2Nb1Vjq3bszjPtrp/xeq7JrfWkyRT+SckF3QzOUwVVxqh2EaiMDmA
         FYzYajDCo3s1peNu7sNPEQwJDMrqyWpfQURZKklXBg54NLjMLDy/Be/LuWfMInD4Labo
         /vI15TjJ60ycqrIalAQmnDCVb3oIHYlkQtzHAmndPud4JJjYYJDHTYwf95dVZYm0c2GS
         SQfip6fgE/Zyhh00MgO2pZ77NmTDsUUCwYgiVIkd/Hu04aA+0DYUz6WWzaAgv4n5mdTz
         TG2w==
X-Gm-Message-State: AOJu0YxGWpJjMG5htJ4ISwDaXcDYfnBVtD/iyao5bIdeLOgaiL977FEI
	P2QzWw9yglO1HEWgfJKB8Eg+Ax+rLICD8sbavIURdtHqgCzVsRbYygHk/w7j5F4=
X-Gm-Gg: ASbGncvM/O6vh5Gtqgifs/U6H3FTownIFR/6XzyrNjS7cnY95aBQVYpky7yRn5c8q1Q
	sUwYTuOe8eOx1rkW4bKZZnCvbaxgr5oqupxukNnWhinL1fuwf3o0qQZCn9EnAJ5rQakwfCVS0Oo
	2GB2AUY0tC1XJ6vwvguLH4HfTgE3bEaf5shE1vNDpXrTpV/d6alMsR/FbfdcK9IlnZcPxg4grzz
	rbR3wHpOgGWychTuetnd84QVHZkV7EZaZ/xaI1mfKpcNjZNd2/RStYCD2sU1ZGkxvVhTP0UwlLd
	0KnY3pyGHtcmjOUckx0gXJSCrCpyUVKkqVccppOkhpsgLAFDGUoxRBZmhZLVPM7ha/YLt9egz6g
	tOYjMPmtlG2YFc58HLBz5
X-Google-Smtp-Source: AGHT+IGp4PfYHD/YxcY0Mn7oA5l0dQ/O7fQeMsiDfpR5dpQOL/r9zkCVIrRqDBHZGZeydZuEK+PkNQ==
X-Received: by 2002:a17:906:7f99:b0:acb:b0f4:bc77 with SMTP id a640c23a62f3a-ad190858b7amr637113766b.57.1746432091180;
        Mon, 05 May 2025 01:01:31 -0700 (PDT)
Received: from localhost (dynamic-176-003-040-035.176.3.pool.telefonica.de. [176.3.40.35])
        by smtp.gmail.com with UTF8SMTPSA id a640c23a62f3a-ad18914736asm449923366b.7.2025.05.05.01.01.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 May 2025 01:01:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: multipart/signed;
 boundary=64453a89ddc6afb76b4932a46c59c202600130e560186a7d832de92cee9b;
 micalg=pgp-sha512; protocol="application/pgp-signature"
Date: Mon, 05 May 2025 10:01:22 +0200
Message-Id: <D9O2I6OT6RSA.JDWMLFP77KSX@baylibre.com>
From: "Markus Schneider-Pargmann" <msp@baylibre.com>
To: "Marc Kleine-Budde" <mkl@pengutronix.de>, "Manivannan Sadhasivam"
 <manivannan.sadhasivam@linaro.org>, "Thomas Kopp"
 <thomas.kopp@microchip.com>, "Vincent Mailhol"
 <mailhol.vincent@wanadoo.fr>, <kernel@pengutronix.de>, "Heiko Stuebner"
 <heiko@sntech.de>, "Chandrasekar Ramakrishnan" <rcsekar@samsung.com>
Cc: <linux-can@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <linux-arm-kernel@lists.infradead.org>,
 <linux-rockchip@lists.infradead.org>, <stable@vger.kernel.org>
Subject: Re: [PATCH 3/3] can: mcan: m_can_class_unregister: fix order of
 unregistration calls
X-Mailer: aerc 0.20.1
References: <20250502-can-rx-offload-del-v1-0-59a9b131589d@pengutronix.de>
 <20250502-can-rx-offload-del-v1-3-59a9b131589d@pengutronix.de>
In-Reply-To: <20250502-can-rx-offload-del-v1-3-59a9b131589d@pengutronix.de>

--64453a89ddc6afb76b4932a46c59c202600130e560186a7d832de92cee9b
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8

On Fri May 2, 2025 at 4:13 PM CEST, Marc Kleine-Budde wrote:
> If a driver is removed, the driver framework invokes the driver's
> remove callback. A CAN driver's remove function calls
> unregister_candev(), which calls net_device_ops::ndo_stop further down
> in the call stack for interfaces which are in the "up" state.
>
> The removal of the module causes the a warning, as
> can_rx_offload_del() deletes the NAPI, while it is still active,
> because the interface is still up.
>
> To fix the warning, first unregister the network interface, which
> calls net_device_ops::ndo_stop, which disables the NAPI, and then call
> can_rx_offload_del().
>
> Fixes: 1be37d3b0414 ("can: m_can: fix periph RX path: use rx-offload to e=
nsure skbs are sent from softirq context")
> Cc: stable@vger.kernel.org
> Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>

Reviewed-by: Markus Schneider-Pargmann <msp@baylibre.com>

> ---
>  drivers/net/can/m_can/m_can.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/net/can/m_can/m_can.c b/drivers/net/can/m_can/m_can.=
c
> index 884a6352c42b..7c430eaff5dd 100644
> --- a/drivers/net/can/m_can/m_can.c
> +++ b/drivers/net/can/m_can/m_can.c
> @@ -2462,9 +2462,9 @@ EXPORT_SYMBOL_GPL(m_can_class_register);
> =20
>  void m_can_class_unregister(struct m_can_classdev *cdev)
>  {
> +	unregister_candev(cdev->net);
>  	if (cdev->is_peripheral)
>  		can_rx_offload_del(&cdev->offload);
> -	unregister_candev(cdev->net);
>  }
>  EXPORT_SYMBOL_GPL(m_can_class_unregister);
> =20


--64453a89ddc6afb76b4932a46c59c202600130e560186a7d832de92cee9b
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iIcEABYKAC8WIQSJYVVm/x+5xmOiprOFwVZpkBVKUwUCaBhwUhEcbXNwQGJheWxp
YnJlLmNvbQAKCRCFwVZpkBVKU3urAQCJ69IFypvaFtVZN9A3KA4EhHPYFZnLhKhP
Pk2HK1dA9AEAlZm7/1uU/TAuxXN+0/6NZUVxbJO2yOQNMI6MhbuvGwY=
=/3qK
-----END PGP SIGNATURE-----

--64453a89ddc6afb76b4932a46c59c202600130e560186a7d832de92cee9b--

