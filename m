Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2C3C4396E36
	for <lists+linux-can@lfdr.de>; Tue,  1 Jun 2021 09:50:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233069AbhFAHwP (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Tue, 1 Jun 2021 03:52:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232963AbhFAHwP (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 1 Jun 2021 03:52:15 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0031C061574
        for <linux-can@vger.kernel.org>; Tue,  1 Jun 2021 00:50:32 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id o127so7511824wmo.4
        for <linux-can@vger.kernel.org>; Tue, 01 Jun 2021 00:50:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=maxiluxsystems-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=TKLOnZQ7rxTdeaJ3SzOb6Fqs6CZdCuvBU3K92m6627A=;
        b=CKaXkqH0CSvXR5cANk+aoUJsX2lKNPMCeCHKl0Q3eNeaNUmER9rt0IppbeL8jb8l6T
         +CXOw1g2M9ZE9RsUKn48AhQ8lri6n/LB1SYW4W3RJwJ18IsM0jwimvshGceDtzi/ojkf
         bGkWPXtW9NymD/9rR2/oP7mtxc0CWRutv08Mt549JlPT1IPMaa6MkcvgKDvMR9WdKqNv
         eq2BZw50l5V+Z5aJ1JtWYWU4qVW2E/ntunDf229K4GB+8BzbXuqFfcoiAl+mDNh954N/
         MK+0m47qEcfYgJC0PlULDGYwYQgilj4g4g6R/G3idA/OoJMxaopI7MVCIHMIq0zl7wTJ
         /+4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=TKLOnZQ7rxTdeaJ3SzOb6Fqs6CZdCuvBU3K92m6627A=;
        b=NUgIQgSIvxL/Sr3h5TNUjcnHmM0/iHXz5o53EE/YgJBNdGSrhhe4ZxtxvTuv0CaL04
         lr/eRygT/i1eB1Fo2JcVlo/lZb0AzNV3/vCSn4jzMteGzyUR5ut4zkD4kZGKVVwoi17J
         7X8H7z5t+DojJb86SUPWxrcyaFgr0PNccQtkrjjtiIGjj2TnedDsVhz59NBoygJu1m8/
         NC+Y2hyWznteQ5UfViKrz9ns09svVA2Gdi0bN73AOymeBA6EJZOUtWc4YvnfLsyRQ3Ho
         62zR9yF8nNZ/vI1Zi3XaKgK1WJleJ+a+/QEViN2rawYGWDBO93qsdGMrCtcbeTxDF+8X
         9ofg==
X-Gm-Message-State: AOAM530yjNeA6who6lvgcWHD9D6EZAez2MYTylnvzInDDsMia0drcgUr
        wQ3NqVcDA+rrJrcwfZUXb7F3kQ==
X-Google-Smtp-Source: ABdhPJw9OdRJc+GrJXO8lWZ/OipnpFL7lNnMYU0SI/k0hYiY4U+/mKcaDUyAdepq1ImNSzAmm3JdZg==
X-Received: by 2002:a7b:c207:: with SMTP id x7mr18130318wmi.42.1622533831546;
        Tue, 01 Jun 2021 00:50:31 -0700 (PDT)
Received: from bigthink (94.197.211.16.threembb.co.uk. [94.197.211.16])
        by smtp.gmail.com with ESMTPSA id u8sm2308468wrb.77.2021.06.01.00.50.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Jun 2021 00:50:31 -0700 (PDT)
Date:   Tue, 1 Jun 2021 08:50:28 +0100
From:   Torin Cooper-Bennun <torin@maxiluxsystems.com>
To:     Marc Kleine-Budde <mkl@pengutronix.de>
Cc:     linux-can@vger.kernel.org
Subject: Re: [PATCH can-next 5/5] can: tcan4x5x: implement handling of device
 interrupts
Message-ID: <20210601075028.hubzfkhkfdcxtlq5@bigthink>
References: <20210526124747.674055-1-torin@maxiluxsystems.com>
 <20210526124747.674055-6-torin@maxiluxsystems.com>
 <20210526151559.sfmseqqxzatlboay@pengutronix.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="focopynxrtknyhnd"
Content-Disposition: inline
In-Reply-To: <20210526151559.sfmseqqxzatlboay@pengutronix.de>
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org


--focopynxrtknyhnd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, May 26, 2021 at 05:15:59PM +0200, Marc Kleine-Budde wrote:
> On 26.05.2021 13:47:47, Torin Cooper-Bennun wrote:
> > Handle power, transceiver and SPI failures by printing a useful error
> > message (multiple simultaneous failures are not logged) and disabling
>            ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
>=20
> Is this a limitation of your code or the tcan core?

My code doesn't print an error message for every handled interrupt, only
the first, because it's very rare to see more than one. Perhaps it's
prudent to print a line for each handled interrupt just in case.

> >  static irqreturn_t tcan4x5x_handle_dev_interrupts(struct m_can_classde=
v *cdev,
> >  						  bool clear_only)
> >  {
> > -	tcan4x5x_clear_interrupts(cdev);
> > +	struct tcan4x5x_priv *priv =3D cdev_to_priv(cdev);
> > +	int err =3D 0;
> > +	irqreturn_t handled =3D IRQ_NONE;
>=20
> nitpick: please make "int err" the last.

ACK

>=20
> > +
> > +	if (!clear_only) {
> > +		u32 ir =3D 0;
> > +		const char *fail_str =3D "";
>=20
> nitpick: please make the u32 the last.

ACK

> > +		else if (ir & TCAN4X5X_CANDOM_INT_EN)
> > +			fail_str =3D "CAN stuck dominant (CANDOM)";
>=20
> The error message suggests, that this error can be triggered by messing
> around with the CAN high/low wires. I'm not sure if it's a good idea to
> shutdown the driver in this case.

ACK, but I need to test whether the device stays functional without CPU
intervention after CANDOM is asserted.

> > +		if (handled =3D=3D IRQ_HANDLED) {
> > +			netdev_err(cdev->net, "%s: device is disabled.\n",
>=20
> Better change the error message and say that the driver is disabling the
> device due to the error.

ACK

--
Regards,

Torin Cooper-Bennun
Software Engineer | maxiluxsystems.com


--focopynxrtknyhnd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEHoj68wxDgkT3Oo2Mj1jJmDXJkUgFAmC15rsACgkQj1jJmDXJ
kUgUUgwAtBUrTsHtE5d+DQ6zIheNaVmCQrezJfmdsnZQlaaopA96FFcdH5Vm8k8l
dbnTq83eBH7xzQ+1tEJtthoICcJVMs+cMIKHX7pMLenGdYoLbnNekpdnVhxnudU6
LflUC9RlN+XCn/Ovz6RWAQ1CodQiEyO4YFIxE/xLXDgNAvGsczwcgcVQ3giY184e
JWMXjM3y3TxP5N+hCmAlVBPtefTeS0wE9iIyrbe5dEhv5Qswb00JBpIQWMz9D6ZV
7xVaLJ02d37hcwtCi/3uHW4TUlZ9fNhdBwNHAXTLA8aH2hGJTlLVNGUwuFsT0Ugc
yViF9BvgdRe3G1O+mXR8gUtB6mUBHPefIpj3A9/3qkD1yngChTVTXKX4afsMCkZ3
+h9dANu2n0TRfCS9vsUEyL/NacV5PUbkkk+jpu3Bu/qe3Xp18s8FPU6mlsU/jPfw
39hsyvU3Xp3psIy/H7PYqjVctLD/XdzJFUmmWd5ERSoXLxtKFUXfZUef/P/yP10C
8WcVZBTI
=lYbM
-----END PGP SIGNATURE-----

--focopynxrtknyhnd--
