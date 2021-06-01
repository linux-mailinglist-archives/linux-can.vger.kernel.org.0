Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0D4CC396EC7
	for <lists+linux-can@lfdr.de>; Tue,  1 Jun 2021 10:21:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233475AbhFAIWw (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Tue, 1 Jun 2021 04:22:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233300AbhFAIWw (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 1 Jun 2021 04:22:52 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B3E9C061574
        for <linux-can@vger.kernel.org>; Tue,  1 Jun 2021 01:21:11 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id v23so10953643wrd.10
        for <linux-can@vger.kernel.org>; Tue, 01 Jun 2021 01:21:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=maxiluxsystems-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=8x6T8V/a1HCrYAPCnpadhe/CbqqgYvxkS2NdULjn2zU=;
        b=mSU/GY+WmFaAZO4e25gfelhV/XWGzTPUkHDaCQrIOzFb9wNP1Ee0bxGEN6JVrZ2QTY
         7dgY71wIZLGd+aWrW/m0ZVGMAQfdUJDYVqFCrn0/0iJaWP4uDIUE9B2j+eSZ/MxAJylg
         G7z567mk5Ay8t1EWfSDW4Pn9ifuqXMmtdOghFsfaOg868nA+UQjS2Ag00SVO1TYP2C48
         TmrK90ydcAYyYEvYb6nUzXAxQXXaKMKQZI4dU8NwRlOu8m5pZBDpbpUNOasCUXD4xu18
         UdIFfmc2TRwq6mXEg3LPIt1nWh9DSJUmg1lYZ/TBme/Bls1Mhe5WkbWK4jxkgLzNp5Xg
         L9Kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=8x6T8V/a1HCrYAPCnpadhe/CbqqgYvxkS2NdULjn2zU=;
        b=OIs50HSoaWXPR5CvE1ocNKIa65agSVkly6E1QhhSqgaVyBA4RypXlUO4BgTbXDOUn4
         mmGcWhp+gSeupjpT3U1q+BOtzZadkCso1qglN0F1t92xrDZ5RJKfXxtCwBQGrpelZcpq
         9AgYJoG/UhdMK1Iuru9ViD787LQhFnd/oJqvfG+IoSjN3EOAoATcEVYqF55HaU/cxDX8
         6DYA487Qyi45YorLeIzWIs29vr+Ta9bSLiFGllkFnLeOL0/thgVjc9579DYHJTDblKv4
         Ks+x4rEKGZQGuXned5nVDNR+KFeXR3E/+nsLwR20iu8f8YYiuiHXxNGTk9MBc6/8VBO1
         pDew==
X-Gm-Message-State: AOAM5330Hc6K0n86R4bCoBSaG0u8dxxL1q0pH0ZvisKQBdN9t2adjJbC
        ilLwN0KejkfWLLjlfhL9YGpFMtqe9tP26A==
X-Google-Smtp-Source: ABdhPJzMFtid84rbPNr42rTdYyueK4GNkz/4zStQxW0YO+gPCHeA7sJ1F4x7B0DtVvHeWjWVuMSCMQ==
X-Received: by 2002:a5d:4f05:: with SMTP id c5mr523162wru.341.1622535669822;
        Tue, 01 Jun 2021 01:21:09 -0700 (PDT)
Received: from bigthink (94.197.211.16.threembb.co.uk. [94.197.211.16])
        by smtp.gmail.com with ESMTPSA id p10sm2179052wrr.58.2021.06.01.01.21.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Jun 2021 01:21:09 -0700 (PDT)
Date:   Tue, 1 Jun 2021 09:21:07 +0100
From:   Torin Cooper-Bennun <torin@maxiluxsystems.com>
To:     Marc Kleine-Budde <mkl@pengutronix.de>
Cc:     linux-can@vger.kernel.org
Subject: Re: [PATCH can-next 0/5] m_can, tcan4x5x: device-specific interrupt
 handling
Message-ID: <20210601082107.g6rfrtfpfnjfe43s@bigthink>
References: <20210526124747.674055-1-torin@maxiluxsystems.com>
 <20210526152045.j3efhxqpytixa7tt@pengutronix.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="jqhy2rmecli7xzbq"
Content-Disposition: inline
In-Reply-To: <20210526152045.j3efhxqpytixa7tt@pengutronix.de>
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org


--jqhy2rmecli7xzbq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, May 26, 2021 at 05:20:45PM +0200, Marc Kleine-Budde wrote:
> On 26.05.2021 13:47:42, Torin Cooper-Bennun wrote:
> > TCAN4550 shutdown is attempted by setting the device into standby mode.
> > There is probably a better way, but I understand we are limited by being
> > in the ISR context.
>=20
> Not exactly. The tcan's ISR runs in a threaded context, so you can
> basically do normal SPI or regmap transactions, shut down clocks and
> regulators, etc...

Got you. I keep forgetting that detail!

Would it be sufficient to change the CAN state as follows?

|	if (handled =3D=3D IRQ_HANDLED) {
|		netdev_err(cdev->net,
|			   "Device is disabled by driver.\n");
|
|		cdev->can.state =3D CAN_STATE_STOPPED;
|
|		err =3D regmap_update_bits(priv->regmap, TCAN4X5X_CONFIG,
|					 TCAN4X5X_MODE_SEL_MASK,
|					 TCAN4X5X_MODE_STANDBY);
|		if (err)
|			goto exit_regmap_failure;
|	}

--
Regards,

Torin Cooper-Bennun
Software Engineer | maxiluxsystems.com


--jqhy2rmecli7xzbq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEHoj68wxDgkT3Oo2Mj1jJmDXJkUgFAmC17e8ACgkQj1jJmDXJ
kUiSDwwAiJI1Mdc5hxMVDUA38IFvvUJbNbQvfkqHpTs30xROaZrgPZIGD6Ik4hgQ
RUHPq2p/HzJnDLbtZKGUhZUuGhfyTojlqoo3raNw+M7jaRUUwTHEnygwcPUl+f6H
MEHMtbCrtfVNyyoDyoFtEsRe/BU8pJe7LNkga2Z7dFxcK/vpOiWGWozGwjfyXQs7
sA4VWxNQhc0jXnQbrzOUQ06wgVcpZYuEpnXg74Dzx7dyYYIaHBfftroMlfBw+mC2
4OWMAWF0Rw3tCv/O5f1R/KI6L3+6iacxJP0U9t57F6XPnaL8hDpUM3kXxZGeoFNM
78yjsd0MsCmOFQ9FMlU9GJgkHGrSTW/rIRqeCNd6j8xnhmIoceynKpi6oeSivMD6
HnW0cVqMlr6WiZS6qMNrQtgJrHeI/Y65pN1Vq9ef3Q1p5z6hAkVJjtnIToh/KPKo
Zaz+CVgERyIGexlifwg6kMhD33GzxncaMjDDZUAAsWITHU9tyw0L5hn+F0GHxgai
dbzlTe2i
=JBK7
-----END PGP SIGNATURE-----

--jqhy2rmecli7xzbq--
