Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CF2B8396DE0
	for <lists+linux-can@lfdr.de>; Tue,  1 Jun 2021 09:22:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229984AbhFAHX4 (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Tue, 1 Jun 2021 03:23:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231928AbhFAHX4 (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 1 Jun 2021 03:23:56 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8BF2C061574
        for <linux-can@vger.kernel.org>; Tue,  1 Jun 2021 00:22:13 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id o2-20020a05600c4fc2b029019a0a8f959dso1255943wmq.1
        for <linux-can@vger.kernel.org>; Tue, 01 Jun 2021 00:22:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=maxiluxsystems-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=u+POkfG1CrcK0sWpp61LCjDf/jPt2qgx9RB+7wZOVlA=;
        b=ni91RT2WYexFTLwiCn7sG3JRYcQBFWT1yZVxeS2jwMooWQUy1lbYLnlZeMJPiHYlx4
         cnj+Itaj7p1GPFW5BMY/CaEDwzhna+3piGmlq+x3dvItcGxLna98jHC65x2LEsIgEw+3
         5hOzpci77ao2NKF+yI2nqPOcReBKC2f2IlB7CHx3P95tpPUlgX7AKt11CHTdMHW25isP
         g6g1KarONPcLCsdPvO9GeEur1+GWYMTSfCe+TjBInrpAoazBTplXLguvk3NwzbQuqGh9
         ZDCGR1bmPAPc07io53Go19C1fYPR+L3IBaseg0co2gYHSubGtOTLAOejSDb6YOmje5lX
         K+FQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=u+POkfG1CrcK0sWpp61LCjDf/jPt2qgx9RB+7wZOVlA=;
        b=uAlxTzlM0EyQWiLTGduE8DkJ53do41Vbff8nGFfTBH5VBeizfbTumwRRq9lm/1lubl
         BLoa3YSwbF2e/EnSQRp5JvD9jXcQfoD/QL2lKMeXsRdVcYzVteQT9qFsEuTjdBkSLlLy
         Sjp25VyKje9LuP18D93LbxluM0wr6aSprExKRb72yowD9TiTUzMNAjHQnZUq0irsvFyN
         NbBN8YE5rDy93tkMGKqOLVKZtcTYmGmrteJd2T5E0iSJwfmty/fJ5/TtHyo6ezFAzjxU
         7uISAywOXLotrkMX5FbBF+ww0BJSXLkgJpFpRyQ27gt8bOb4aDTNMWbxlWYxqwLlJEL/
         ZuYg==
X-Gm-Message-State: AOAM530TaX2WBRHak4vnFg+09V2o3R5mKsxVvKY6hEWiCgtV+98ZFCUs
        1sTHv1/SXbElqW2sDP/53USpUw==
X-Google-Smtp-Source: ABdhPJzmlUeISEvUxkdqmNK1cKVGKnm1SJKs1+ZIixLjTO930WTvvVhLNrJYLCFVqAJbopKBcJNgdg==
X-Received: by 2002:a05:600c:4657:: with SMTP id n23mr2246550wmo.47.1622532132541;
        Tue, 01 Jun 2021 00:22:12 -0700 (PDT)
Received: from bigthink (94.197.211.16.threembb.co.uk. [94.197.211.16])
        by smtp.gmail.com with ESMTPSA id 89sm2405211wrq.14.2021.06.01.00.22.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Jun 2021 00:22:11 -0700 (PDT)
Date:   Tue, 1 Jun 2021 08:22:17 +0100
From:   Torin Cooper-Bennun <torin@maxiluxsystems.com>
To:     Marc Kleine-Budde <mkl@pengutronix.de>
Cc:     linux-can@vger.kernel.org
Subject: Re: [PATCH can-next 2/5] can: m_can: m_can_isr(): handle
 device-specific interrupts
Message-ID: <20210601072217.kazos5xe7iqcqkmd@bigthink>
References: <20210526124747.674055-1-torin@maxiluxsystems.com>
 <20210526124747.674055-3-torin@maxiluxsystems.com>
 <20210526150705.s4ms7jhowsuts3yf@pengutronix.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="alw2hcilcd7f2z6m"
Content-Disposition: inline
In-Reply-To: <20210526150705.s4ms7jhowsuts3yf@pengutronix.de>
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org


--alw2hcilcd7f2z6m
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, May 26, 2021 at 05:07:05PM +0200, Marc Kleine-Budde wrote:
> > diff --git a/drivers/net/can/m_can/m_can.c b/drivers/net/can/m_can/m_ca=
n.c
> > index fa853201d2c4..3bc957da06f7 100644
> > --- a/drivers/net/can/m_can/m_can.c
> > +++ b/drivers/net/can/m_can/m_can.c
> > @@ -1033,17 +1033,24 @@ static irqreturn_t m_can_isr(int irq, void *dev=
_id)
> >  	struct net_device *dev =3D (struct net_device *)dev_id;
> >  	struct m_can_classdev *cdev =3D netdev_priv(dev);
> >  	u32 ir;
> > +	irqreturn_t irq_ret =3D IRQ_NONE;
>=20
> nitpick: please move before the "u32 ir;"

ACK

--
Regards,

Torin Cooper-Bennun
Software Engineer | maxiluxsystems.com


--alw2hcilcd7f2z6m
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEHoj68wxDgkT3Oo2Mj1jJmDXJkUgFAmC14CMACgkQj1jJmDXJ
kUio6QwArg+XukLRYmI5y4yCfgb2/Nf99jXryiGWNYbwnroWEEJVLWaQt2YJLBru
lKcyBSk7Y9wsva9OpWhcgih42/IyCUXtiRJ89VHoj05mJIDl2tLAfTzvICwijwqG
8JiumKFutpQsaOK/IvpiXNrkRks0R0RdhUBODI6x6qsPpUy164K5l5Gg2o8wT8qR
5WVJ7yL0x423C7x4ZaYpT4w7DfUTxxGilfOAIKyQYqsGkZcZQKo7jDc7ItblKvo9
kH76C+FIzApSlXBsh/7fjvGbtid9c7gJIH+yPX45xqflc2Gu8Zxe6EWFLwL9u238
hV2hyR706i6tLmCIKlmFkkL/fsUxZbPm/7D0NwwcHshXztTIH0N/GzRMGFneIvd2
ncyV/24dpoX3zvlnrQEFqgXTLSUXarVd/0mIOjJiYrE+zMd6pIMYQOQstMM8A6PK
LW7WgjSO+7zZV9WdIVwRAiE/JxHI0LzGw5O6kqltyRe0uQEH7yteW5cWhhgE1vhV
no9n1TPs
=7J2s
-----END PGP SIGNATURE-----

--alw2hcilcd7f2z6m--
