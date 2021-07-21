Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D6AB03D0A30
	for <lists+linux-can@lfdr.de>; Wed, 21 Jul 2021 10:00:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234263AbhGUHTj (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Wed, 21 Jul 2021 03:19:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234243AbhGUHTA (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Wed, 21 Jul 2021 03:19:00 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6ED37C061767
        for <linux-can@vger.kernel.org>; Wed, 21 Jul 2021 00:59:33 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id d2so1178046wrn.0
        for <linux-can@vger.kernel.org>; Wed, 21 Jul 2021 00:59:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=maxiluxsystems-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=uxaRd0k08Nsqbj32hFfZuh+VE6NAo9v17G/Tz4UsESw=;
        b=ny7Sc43NEqvO2uiVsIb8gcFbiF5AczqX8boGV0J751iEMMgW4xX/aw0FagEqVQe8GF
         tfcVjyJXs+7y3GvQn4DN5hY/Z6uYQeO46/PNK5Uy5tQhru6NHBdlZ0MxoSY43Co7ZELl
         geASj499mjD9RfLB3selM6Ee36fhGr5OvH9PT3ILrQcB7LcPogS0qT98vbaH8SK2mvpa
         OThuiSSLE9KLBPPqIG8cRtc9oULkPY7x0qvsiHIh3V0Ob/1qyrBaXX/koIiuek6hewbi
         PDSP4TT+qlw1V+9B1a/3NSHuh9U55t9Yh/GYKva9eMYjmwraxAhEw/9dTXebhud1BYE7
         Z9aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=uxaRd0k08Nsqbj32hFfZuh+VE6NAo9v17G/Tz4UsESw=;
        b=phGWeoq9JzHE+fxc8gu2hXJVrkFPFIZe6qYgucjhWBr5FzAuxEW6HzeWKhWYtzY4Ai
         S6cFpDS5/C3+MMm+Bdeu9utsN3uCVxV/gMZl88fLpFhz74/4teDFGF0f4VBcZezGtiB3
         JbfbpGpITo3hK8qayczPBIPDt1c9HaPRqk6+s9MgzP55Mzj/05HLdJOdIhzD+1xCNPOF
         WmUxLmRjmJXZyhg8VVsYwWQ0oSaaJAMH/6Zt/vvODQ/tw+nCynz0nB6NtmCsnBIJf/Sf
         riz5311LZqC5j6OAhw6x6yO3XSPb/gEE1VbPCsfhQkmq/lh/ITtyCLHyuQYEDm4RKpFD
         e3og==
X-Gm-Message-State: AOAM530x4JaLPsIPKU/lhYBTbN7YYYKbueJQt+GgJNcOcOvC2d4PDLtf
        BS6l2XRSxCbWNbnN70YG/PRUXQ==
X-Google-Smtp-Source: ABdhPJw6lapttizzfBF2xPn0qw5TYklOaTGSwEmdrcJ4/L0clp0vhmvYwOfMNNv121M8rSljzTXy5g==
X-Received: by 2002:a5d:5550:: with SMTP id g16mr8884738wrw.342.1626854371666;
        Wed, 21 Jul 2021 00:59:31 -0700 (PDT)
Received: from bigthink (92.40.185.36.threembb.co.uk. [92.40.185.36])
        by smtp.gmail.com with ESMTPSA id z11sm25899541wru.65.2021.07.21.00.59.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Jul 2021 00:59:31 -0700 (PDT)
Date:   Wed, 21 Jul 2021 08:59:28 +0100
From:   Torin Cooper-Bennun <tcbennun@maxiluxsystems.com>
To:     Marc Kleine-Budde <mkl@pengutronix.de>
Cc:     Joakim Zhang <qiangqing.zhang@nxp.com>,
        "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>,
        Torin Cooper-Bennun <torin@maxiluxsystems.com>
Subject: Re: [PATCH] can: raw: fix TX CAN frames show up as RX'ed ones
Message-ID: <20210721075928.ktfaleu2fv5ibwpe@bigthink>
References: <20210510182038.1528631-1-mkl@pengutronix.de>
 <DB8PR04MB6795656CDFC5D021E9FA7D19E6239@DB8PR04MB6795.eurprd04.prod.outlook.com>
 <20210527085425.cxmc4hsecyrdmcob@pengutronix.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="stohfxsw6iyckbic"
Content-Disposition: inline
In-Reply-To: <20210527085425.cxmc4hsecyrdmcob@pengutronix.de>
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org


--stohfxsw6iyckbic
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, May 27, 2021 at 10:54:25AM +0200, Marc Kleine-Budde wrote:
> On 27.05.2021 07:17:22, Joakim Zhang wrote:
> > I have not seen this patch in linux-can repo, what the status? Thanks.
>=20
> I still want to test the patch with network namespaces. I think I'll do
> this now.

Hi Marc. Did any testing go ahead on this? I'm happy to use this patch
manually but it would be cool to have it mainline and backported if/when
possible! :)

--
Regards,

Torin Cooper-Bennun
Software Engineer | maxiluxsystems.com


--stohfxsw6iyckbic
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEHoj68wxDgkT3Oo2Mj1jJmDXJkUgFAmD30+AACgkQj1jJmDXJ
kUg9dAwAstsjelraBPzIrlK3RnO6MZIghqdwiF2ehyfXrJVI8QVBkMs65ShxujRp
GtTINmNal9WcgbCsBM8Z149bdvIuut96z4l8Buxwd/To1DSWqGqz4kiOPE6gII3+
5VbIwOkWP/YKU1yotPdnOvy7hQqvrKvSDfjtftReuGWZ2mks3QvM3ymKN6VWug2Z
dsm6QXfx78dia2KmcLUfv/+ZbT8a7F+bkzrv54WxFeI64+iK2ZLGquD52RiqTee7
QOt93GqWF0yAUWaXqo7fHV3hLp96ozIKr45/sJdzafJhksVV/bD8go+extXJLfOp
/qio2UClTvfRCJTLs80+IZOFWk4iH1ZsTVZtz10wTZ4XK3Ns1OOIjpupwXpX8hGG
5R4DLOiy3VbHLk9yYJkJq/WCkzLQgrALupLhUfyZeFFH+1qaoFI188RWZewiifCr
96bLlnXj8Bm+CT4v7jTuGo0K5CB4DQWJrxIUNvcP7KD3Ld6XdTkyljODkqs9HIX7
2skxIt0F
=yZGo
-----END PGP SIGNATURE-----

--stohfxsw6iyckbic--
