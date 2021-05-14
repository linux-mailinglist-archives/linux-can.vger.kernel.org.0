Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F024C380E60
	for <lists+linux-can@lfdr.de>; Fri, 14 May 2021 18:45:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230431AbhENQqM (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Fri, 14 May 2021 12:46:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230268AbhENQqL (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Fri, 14 May 2021 12:46:11 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3441C061574
        for <linux-can@vger.kernel.org>; Fri, 14 May 2021 09:44:59 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id u133so94524wmg.1
        for <linux-can@vger.kernel.org>; Fri, 14 May 2021 09:44:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=maxiluxsystems-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=vrQby8WZFo5aMpU2AcQraGUCTXRTBHaHN7ZD0WfV1x8=;
        b=N+MeGpg/jZk8KTOatbsBdPeItV/DhMd6FGfDi2OHAi0s9EavIU2tDTlTlvW1YoFbZb
         DgmZdQGQg+p0QIFb4QyIOUX/z3wFrcSQ7u7C/KsukjoWXSS0MOEPABhtUxa2iAahMbgP
         Ae6HU3vpJEcOEwkys1oxlAGCTLN3uMo0cgn2TibSyRWvvAaF6W/I3ehUO8dimdt9nhwt
         Bn5ERQPHYB83Q1AGarvnHAH7Ggei+9RQ4/dyVvchkS5+5Ngv+7sWUJUBETzdDnVmMByv
         SzPDJ9hTH4tR5mu3XfU3QVsLChX/RPwUwAXuHt/unwM620UPZo7A/DAzBXarz+Oj646S
         U77w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=vrQby8WZFo5aMpU2AcQraGUCTXRTBHaHN7ZD0WfV1x8=;
        b=FReqeZzaNgtQDBmNqlH/JA1/dtxzeeHVQaXpKSMUgLtlz+smmHjns4I+iCEXEF3cl4
         yT8LrFd/iauece6raBZGsPOs7S5/oup/1HHwMNtPAXjDsP0SzRHLY6OY8tMTfDgf6i1K
         X+hQUKPeN+2fNZ/YvV3ccG2XQ1GCuACQ+2PY7qkxBnLt1ZBB1uCUg6QIpn3jX8B94Jrs
         Ywhbtgyy7zBaWvRdQ2kdK42bF0BhZiGvKV/UbL05rZpzwBc1nIZ9Vz/Mfrir178u6RT5
         N9TKv+gpjPXgTbh5g+4vP25RuSmQ8dVTwhjBM3BUKKhvy4Gnq013d+I84YEuIul+iuUZ
         7Q2g==
X-Gm-Message-State: AOAM530u3g1q4gqhpNWrO1g6HytBY3dr7XkcnZ+CDqOxU/r+VcRcpdRx
        8Ew99S/QstSd3/bS7jOUCZHfvA==
X-Google-Smtp-Source: ABdhPJz5NC2Z7OHergtRchRCwacfCKv02H+X129mf2n8A57fEfQoROSzjps3h93Er5wktXfNl20q3Q==
X-Received: by 2002:a7b:c005:: with SMTP id c5mr22508909wmb.113.1621010698499;
        Fri, 14 May 2021 09:44:58 -0700 (PDT)
Received: from bigthink ([148.252.128.100])
        by smtp.gmail.com with ESMTPSA id r11sm638837wrp.46.2021.05.14.09.44.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 May 2021 09:44:57 -0700 (PDT)
Date:   Fri, 14 May 2021 17:44:55 +0100
From:   Torin Cooper-Bennun <torin@maxiluxsystems.com>
To:     Marc Kleine-Budde <mkl@pengutronix.de>
Cc:     linux-can@vger.kernel.org
Subject: Re: [PATCH RFC can-next 0/3] m_can: support device-specific
 interrupt handling
Message-ID: <20210514164455.inr3getboissqasr@bigthink>
References: <20210514121946.2344901-1-torin@maxiluxsystems.com>
 <20210514123417.tlm4bvqidwnioesm@pengutronix.de>
 <20210514131049.yluxu3cxaspeptvb@bigthink>
 <20210514141237.ps7gcfjhejnehbhv@pengutronix.de>
 <20210514145430.i4ajyapz6zhjnrro@bigthink>
 <20210514152131.qo4ybv4zx5mbscop@pengutronix.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="2gxxjhk74nzuv6ly"
Content-Disposition: inline
In-Reply-To: <20210514152131.qo4ybv4zx5mbscop@pengutronix.de>
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org


--2gxxjhk74nzuv6ly
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, May 14, 2021 at 05:21:31PM +0200, Marc Kleine-Budde wrote:
> On 14.05.2021 15:54:30, Torin Cooper-Bennun wrote:
> > On Fri, May 14, 2021 at 04:12:37PM +0200, Marc Kleine-Budde wrote:
> > > Ah, ok. Do they need any handling/acknowledge? You only read TCAN4X5X=
_INT_FLAGS, are
> > > those clear-or-read?
> >=20
> > An extra note on this... most of the faults worth responding to here are
> > serious enough that the interface should just be shut down, or at least,
> > the device will need to be init'd again.=20
> >=20
> > I'm surprised no handling was implemented in the first place -
>=20
> At least you should write a warning message that you (as a developer)
> and your users get noticed when these error hits.
>=20
> > makes it very difficult to debug problems when you're prototyping new
> > kit. The driver is written as though these interrupts are meaningless!
>=20
> Proper error handling is not trivial....and from my experience, in most
> cases the documentation of those kinds of errors and how to recover is
> quite sparse, I haven't looked deep into the tcan4x5x docs though.

I guess I should give credit where it's due, in that the driver works
fine without full error handling for the vast majority of cases. It may
just be that the application I'm working on is more sensitive to faults.

The docs are fairly sparse on error handling from a programmer's
perspective, yes. I've learned more from experience with this chip than
=66rom the datasheet!

--
Regards,

Torin Cooper-Bennun
Software Engineer | maxiluxsystems.com


--2gxxjhk74nzuv6ly
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEHoj68wxDgkT3Oo2Mj1jJmDXJkUgFAmCeqP8ACgkQj1jJmDXJ
kUhFhQwAvjZ4jE4WpulYv9oRmV2elntEVH12VAohOEi8/zTdTSIv/hI/dl9uG42Q
/ra8sxoNIhyDy07aw1ggEhz37Cb1ks8VL6uK6WjWu5ziKCtKZjsLBm02n4cwUkET
7n/bvK8K59PktzH3dP8XEARIMKnbsPDtU26FpVYSrVuzqT3yNvlP9MiFlgxeOfYs
Nw3jwOzVftK1UNHewds/a0gLkNXBn2AT7J8Sf/4QgGENE6l1Wf1jvL4rcUj17/qE
u5PFF0bPsiOraGjqBxhPGx/NFkz0AL5tu3O6VvWf3uGmh1M9JBvxuoFvLDgnPiI1
RYw4K8x2zGH6vNYYJYblXWi2KMPxTLu54nRbCO3Pr9urlZTk+qLSr8WYEkCrGgZ+
SzJmITwivHy/Zz2tZSixXcYUvdHbdnYRUIATyR/6y6ovyHnqFbRL+F5cbyavYbzr
Vm1jQ/lCebGIQtiCsqhZXXi7Ys0fey8Rwr0esEc4vwE8ZMsHLufHnpwuNDTzrsbT
2SSo4K+a
=A4ai
-----END PGP SIGNATURE-----

--2gxxjhk74nzuv6ly--
