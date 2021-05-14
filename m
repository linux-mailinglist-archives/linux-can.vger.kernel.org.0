Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0BE20380C1C
	for <lists+linux-can@lfdr.de>; Fri, 14 May 2021 16:44:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232745AbhENOpv (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Fri, 14 May 2021 10:45:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231473AbhENOpu (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Fri, 14 May 2021 10:45:50 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06257C061574
        for <linux-can@vger.kernel.org>; Fri, 14 May 2021 07:44:38 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id v12so30242236wrq.6
        for <linux-can@vger.kernel.org>; Fri, 14 May 2021 07:44:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=maxiluxsystems-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=+OMg+NeoXIrKbvSXglQ3NrcmiLXB4Kf6UkpqHangF8Q=;
        b=QN/rFYyiaJ53JN3ccBzSVNSQDDxnZ1re6mjDtqessNjwDEz06HjH/doDR4LwrCHZrf
         lBmSvud4gMNHeYmOJx/YlRRZ9AX9vE/8z2Wd0ffug4bJ2FE56q4yM7fGqOgycTZQb6Bp
         ksymu4b0rffn2TknZ+pIKxYpuJa8+pacy5yi226qTDKwe1JLfuKSmu4gqmpA2sKnao/4
         /ifxmmNNPAgjtvvLEmPookuOjOMPWHgBtNyrhuXsFnzkEqrxOuBvu0KFLVmogfT6m5Zr
         wwlVvestW6hIqJjhbXWe69zJpcfcHXEardyyywOJnveAGl9H2odMghadwIlX9PR0R8Ul
         S4nQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=+OMg+NeoXIrKbvSXglQ3NrcmiLXB4Kf6UkpqHangF8Q=;
        b=lYeDo37kHguWgUnb80fUwu0oFwqApE+QT7uoGNKrODue2rvznFujyTQeJI3rzViW6c
         nH8hFLQWLfkXAsK+ctLRtQ3V5Ek/n20ZQvTUpaTYE8cu+I6bYuvA5FJrmSGMTOIPOVGh
         6AXWytjT23BU8V1kz5zrinfzH3r+HV9FwjKlLOVW1trvLsnsqWRxA0syx7piA1v7dSJ5
         xLGAnBtQIMWghX89sgHQZke1Bd0VFItj1Kw92SjVJ/RU7iVRUyFmASAQNFDjc5HcCNyB
         n08WvkZ2nj6LB74T5z0c0xs/apU2WBNkKrzyPd/QKlwJerXhYxL0jzSZxum74wR5iQkv
         WheA==
X-Gm-Message-State: AOAM532hyEkNMeBvoreGZEepiYZQZo4qp/+gw4uSDTpYnv3wX/Xyvo9g
        IMfn08CfSjxfhh+//9/Kl2JzBTO4ERQPQA==
X-Google-Smtp-Source: ABdhPJzrMT5YjevkrpN/GgnuJnrZJN7n2Jp/wRIhRJr9zcXemq7mW1ngbxOufY4jXuENMI4WQWUo2w==
X-Received: by 2002:adf:e384:: with SMTP id e4mr16378150wrm.347.1621003476794;
        Fri, 14 May 2021 07:44:36 -0700 (PDT)
Received: from bigthink (92.41.10.182.threembb.co.uk. [92.41.10.182])
        by smtp.gmail.com with ESMTPSA id i14sm11670826wmb.33.2021.05.14.07.44.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 May 2021 07:44:36 -0700 (PDT)
Date:   Fri, 14 May 2021 15:44:34 +0100
From:   Torin Cooper-Bennun <torin@maxiluxsystems.com>
To:     Marc Kleine-Budde <mkl@pengutronix.de>
Cc:     linux-can@vger.kernel.org
Subject: Re: [PATCH RFC can-next 0/3] m_can: support device-specific
 interrupt handling
Message-ID: <20210514144434.etefrlqq5pwcb34t@bigthink>
References: <20210514121946.2344901-1-torin@maxiluxsystems.com>
 <20210514123417.tlm4bvqidwnioesm@pengutronix.de>
 <20210514131049.yluxu3cxaspeptvb@bigthink>
 <20210514141237.ps7gcfjhejnehbhv@pengutronix.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="iax4sdjxh2vqqmgm"
Content-Disposition: inline
In-Reply-To: <20210514141237.ps7gcfjhejnehbhv@pengutronix.de>
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org


--iax4sdjxh2vqqmgm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, May 14, 2021 at 04:12:37PM +0200, Marc Kleine-Budde wrote:
> > The TCAN4550 has interrupts that cannot be disabled or masked, including
> > those for faults involving SPI, power, and transceiver issues (e.g. CAN
> > stuck dominant).
>=20
> Ah, ok. Do they need any handling/acknowledge? You only read TCAN4X5X_INT=
_FLAGS, are
> those clear-or-read?

In theory, for any of these, clearing the register should be sufficient
for the interrupt pin to go inactive... emphasis on "in theory".

> > > > Comments are welcome. One thing right off the bat: I'm not sure whe=
ther
> > > > the new callback should be added alongside clear_interrupts, or if =
it
> > > > should replace it.
> > >=20
> > > I don't see why we need two callbacks from the generic interrupt
> > > handler, one should be enough.
> >=20
> > Fair enough, and it makes sense to always clear the device-specific
> > interrupts when handling them anyway.
>=20
> ACK - and return irqreturn_t.

Sounds good!

--
Regards,

Torin Cooper-Bennun
Software Engineer | maxiluxsystems.com


--iax4sdjxh2vqqmgm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEHoj68wxDgkT3Oo2Mj1jJmDXJkUgFAmCejM4ACgkQj1jJmDXJ
kUjU2Qv+M1fmUiqfQBWKFENZgbpxOWXKAhUF0WkhH+za+Uq5A9zLU6eTuCrpfCkO
RX6UiTW2AW0ctrduQ8/992q5zgVku3KumG8aOleJs0jvDwm4/8JePskFv3PGn++s
eiulO7fHO1ZuaPOaMAFR+1tjeQzu636YA3K9IEzxdrosyy3ubGhxNm8DYJwmAjp5
+5jZWLv9EBOCEeibNO0CONZt/tjtdkOOmlSwwvDj+S42U5sBqLfMxvgYuPnL5PlA
4GbLKPPEwQLKKtPR20p7bdZgZLRBK0p5E3tLu1u5lMdrrgW9wa4Q91Cvp2xGccjp
c9C22gEgB1BuKLj1zdDSdXPvwPrwEx//5yoqkymYnHvdTLFwdY2mTtNotJUcc+Di
FimunXXNy+TEkR/5+tLwKFZSpwMk53AWY8RNAipZj2/mheVMRR/uG6KlwUKk011M
6CDvWeSdkdaouU9JqL6dDnoHeH5PWFEbGJRV1xU/6gotO3CKmQBvfyUu2PbTqups
E3CWsSzU
=WlRP
-----END PGP SIGNATURE-----

--iax4sdjxh2vqqmgm--
