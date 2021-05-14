Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A21C0380A33
	for <lists+linux-can@lfdr.de>; Fri, 14 May 2021 15:10:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231666AbhENNMF (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Fri, 14 May 2021 09:12:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229469AbhENNMF (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Fri, 14 May 2021 09:12:05 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E50AC061574
        for <linux-can@vger.kernel.org>; Fri, 14 May 2021 06:10:54 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id q5so10535747wrs.4
        for <linux-can@vger.kernel.org>; Fri, 14 May 2021 06:10:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=maxiluxsystems-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=ReoAafVXI0ufU6Nnb6MGeE01RfLuYaVptOWExyXRYGg=;
        b=zika6ban8LZU9sYSKIO4vQITlK9KVkwWQJdufmiFy3O8DYoOUXcC3CcePGt62rzUTp
         rDx621sZWRaVUtlDqbOywls1+/6F1kAebuRNXQwyaeOFvikeA6bk0HVVzHCTAhPzcHTd
         5uxCrJPwYfOehYT1SNtRFtz1M/kb8L28Fdjrrfyb5le8fQV/S5MAwH1Ie9yvikJjOZe6
         oTtpLCfmMzKYwHelK/z0VMgIPH/PtsNgoNKwFMHGsQsQBBKoFlGaxIT5bMGVIg4L3Isd
         vjyglyAOyIOX+b8ivQijbqIEC/TNe9tv69vJOyQHPE79ATX0s52/omntKJn9mz+b34NW
         dFhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ReoAafVXI0ufU6Nnb6MGeE01RfLuYaVptOWExyXRYGg=;
        b=hHJbSTLfrk4ynE7AZcDuAVPfXmdiN5xYk//XJ4Q7FEhcJOSUtYTxCgoBCfJcaUwvPr
         I2tXaD9HcJ9NADyT25iEwIZdL2Ar2BkSgcMUW1CbZTpkOa8MkRtwj5HBPcdu3ernPGZ2
         q4R+vXq8uU0bx7rDDZR22zvSXSaHdhmePchYB7cWoXxfVFk+/5QQST3S146jAhE5g1bf
         GtKa30g2I3jtk7iyjJj4lrHFJw3+wjtEd7cq+42uWYz+ErI0JzClE+2cs8Xy1qwrC5Ek
         Hwh/idwbVT505n28GZTab8MpmyHugP1X8Fu75F9spyFuyaVeRpvqFtK2cMxuENBJvDyX
         MJDg==
X-Gm-Message-State: AOAM533fNGtFtbJRRynl3h8mmH4fdsYiPOKE4NTF7UYtmOLCvp4oHhPC
        JDKBUPRaGRRILpEHXIntxgVYcR4jAqHhpA==
X-Google-Smtp-Source: ABdhPJz4Y6jtyBED+AsermqlWbsVsXXnBv1uMzdtoG09bi75Fiv+CejBdJVjPP1SXCFPKV4CMxo57Q==
X-Received: by 2002:a5d:650b:: with SMTP id x11mr23239610wru.186.1620997852740;
        Fri, 14 May 2021 06:10:52 -0700 (PDT)
Received: from bigthink (92.41.10.182.threembb.co.uk. [92.41.10.182])
        by smtp.gmail.com with ESMTPSA id x16sm6576507wrp.6.2021.05.14.06.10.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 May 2021 06:10:51 -0700 (PDT)
Date:   Fri, 14 May 2021 14:10:49 +0100
From:   Torin Cooper-Bennun <torin@maxiluxsystems.com>
To:     Marc Kleine-Budde <mkl@pengutronix.de>
Cc:     linux-can@vger.kernel.org
Subject: Re: [PATCH RFC can-next 0/3] m_can: support device-specific
 interrupt handling
Message-ID: <20210514131049.yluxu3cxaspeptvb@bigthink>
References: <20210514121946.2344901-1-torin@maxiluxsystems.com>
 <20210514123417.tlm4bvqidwnioesm@pengutronix.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="optgmcnlgkf6uss5"
Content-Disposition: inline
In-Reply-To: <20210514123417.tlm4bvqidwnioesm@pengutronix.de>
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org


--optgmcnlgkf6uss5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, May 14, 2021 at 02:34:17PM +0200, Marc Kleine-Budde wrote:
> On 14.05.2021 13:19:43, Torin Cooper-Bennun wrote:
> > Using the TCAN4550, I've had occasions where the m_can driver has fallen
> > over with the "nobody cared" message -- the ISR has returned IRQ_NONE
> > upon "99,900 of the previous 100,000 interrupts" (see
> > kernel/irq/spurious.c, __report_bad_irq()).
> >=20
> > While such high numbers certainly indicate some kind of fault,
> > presently, device-specific interrupts are totally ignored -- it may be
> > that such a fault can be handled with a device-specific action.
>=20
> Do you know why the tcan4x5x specific interrupts are enabled in the
> first place? If no-one is handling them, just mask/disable/etc then....

The TCAN4550 has interrupts that cannot be disabled or masked, including
those for faults involving SPI, power, and transceiver issues (e.g. CAN
stuck dominant).

>=20
> > Comments are welcome. One thing right off the bat: I'm not sure whether
> > the new callback should be added alongside clear_interrupts, or if it
> > should replace it.
>=20
> I don't see why we need two callbacks from the generic interrupt
> handler, one should be enough.

Fair enough, and it makes sense to always clear the device-specific
interrupts when handling them anyway.

tcan4x5x needs some cleanup re interrupt init/handling/clearing anyway,
so I'll incorporate that next time!

Regards,

Torin Cooper-Bennun
Software Engineer | maxiluxsystems.com


--optgmcnlgkf6uss5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEHoj68wxDgkT3Oo2Mj1jJmDXJkUgFAmCedtIACgkQj1jJmDXJ
kUhXZwwAvNHPKXSqrtlPiRwlAUyl8mtAnsGqO623CGWJdZms7/MTtKg/Ewt9gAlX
DwM+xio/4x4AH8q1WVp31+EDO+3RTnCPiG2mIbdgBU5gbZHRaQlUImo9FEtZpbMI
dfAqSc3Eoy7Cso+hxKmld8qov28Ieuwv2qUpNLXfAD8rIMTPiQ9lMiYY4s3JD5jk
uz3pEtjdHoi6Q5j2nco1LQd6NGB+rPvFwp0nXGDepOE2wgOlYbBCMbOeLak8J9AY
8urgCSv13NsFMZbXpvKO0mEcpwe9iS/ko/RYt8VEIXdnXjVTIfRs/2H/h+WIjhsY
Qpqya8pUe7/2nkWxixhjizPrEic27XuQRoGg0qAt6dT60rWOjnFwa6R5Ma81jtCT
xroKqxk7ZkNR+5Sg2FlDlMqg1MI7hC3/fauyazeoIYusnHrML1jT5AF7T/12ZtcB
aS0f4rQkqdhjzNhyybKHeRVTTyepp6jeffTjtZrd7lhnbrysOX5A4g0Rl5PLnanB
OeUdXRK1
=PtT5
-----END PGP SIGNATURE-----

--optgmcnlgkf6uss5--
