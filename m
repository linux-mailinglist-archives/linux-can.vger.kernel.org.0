Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 326BC3971F2
	for <lists+linux-can@lfdr.de>; Tue,  1 Jun 2021 12:56:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230308AbhFAK6T (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Tue, 1 Jun 2021 06:58:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230282AbhFAK6S (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 1 Jun 2021 06:58:18 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66A47C061574
        for <linux-can@vger.kernel.org>; Tue,  1 Jun 2021 03:56:36 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id l11-20020a05600c4f0bb029017a7cd488f5so1658187wmq.0
        for <linux-can@vger.kernel.org>; Tue, 01 Jun 2021 03:56:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=maxiluxsystems-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=QTqLbaq0k6Ll5x8dBP006fogUdqFSviRCeeYquOCuG8=;
        b=y+sSNi4oAJ6KH0JizsdZXj730SsC+YHfgf86LKo5yVNXdk6soQGzduhjuNiyhnrEXd
         PhRbYigBuhX7QfaGWLHFvP+DnqHPd1fhTqoyo8mtIirw/BZtoV2nSU35eOGOo7JC+Prg
         fsXKjXzeBwqQVWB025KsHwGKZcGnq+/XN/mdHI/a0VGsfg5SjxJh5qR1XOdYfGAu9v2G
         4yZLtci72glWnABLa8lcOoMI1dp1L1ycvClLk8L+dzuZdSh3UkP6Q9dYEsyP9gJuaAgz
         xR0Rg1ak+mzsjRkk6fMn42q4CyB+bSMc22gFGGSEHgIUqfAPakonHyz+Udv0JFEyHVgN
         tBPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=QTqLbaq0k6Ll5x8dBP006fogUdqFSviRCeeYquOCuG8=;
        b=E1VxYpBUZefGOZ4mQGuPX8kLqhVFVDx3bNpIf9VRLRYwHJ62Q1Bhsdv/2ODnkJqgk+
         HBLFbsbyoZ7riICsVs2RrczWFD/R87y5xMREF+76yr61bfN2WkzuCcJmnfst4czNpoz8
         UIREpbDLDPo1OW1U762odwRnybJ+kCnxyt4oretKJrI4qRBRHoM0eTctpgBiMXU/3/kb
         1Afh4sKBCprXuIHmqyvGI+JKhvn6tMYn/X4be5/JzZdqRykFKjvfw6KDkWx1VvJlCu2T
         uvpeyuaGBMYcPJ17V4EwmeOkKHqcFL7feKChX3G7+rQN4EXgvMWfDH5XlvhP68Cxy3Tc
         GYZw==
X-Gm-Message-State: AOAM53352bBrwMlW18A+0sFCQpiDHav+oGI+dr5awXQg0doLwTikv4UA
        kjfZFRr4egD1sXgpQkOGTgWjfw==
X-Google-Smtp-Source: ABdhPJz7r7rnbo2H5k9yBJne3y6kTAyp1ex/qbJ0Zm0ns3tqE9Y3jAh5hvzUjlpH5Yd/BZ41p3uW3Q==
X-Received: by 2002:a1c:7402:: with SMTP id p2mr4000991wmc.88.1622544995009;
        Tue, 01 Jun 2021 03:56:35 -0700 (PDT)
Received: from bigthink ([109.249.181.35])
        by smtp.gmail.com with ESMTPSA id j1sm5827206wmi.44.2021.06.01.03.56.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Jun 2021 03:56:34 -0700 (PDT)
Date:   Tue, 1 Jun 2021 11:56:31 +0100
From:   Torin Cooper-Bennun <torin@maxiluxsystems.com>
To:     Marc Kleine-Budde <mkl@pengutronix.de>
Cc:     linux-can@vger.kernel.org
Subject: Re: [PATCH can-next 0/5] m_can, tcan4x5x: device-specific interrupt
 handling
Message-ID: <20210601105631.lvtziz7gzsauayov@bigthink>
References: <20210526124747.674055-1-torin@maxiluxsystems.com>
 <20210526152045.j3efhxqpytixa7tt@pengutronix.de>
 <20210601082107.g6rfrtfpfnjfe43s@bigthink>
 <20210601091847.ixsbe4gz4jk7eeeb@pengutronix.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="zmtilgl6wizdius4"
Content-Disposition: inline
In-Reply-To: <20210601091847.ixsbe4gz4jk7eeeb@pengutronix.de>
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org


--zmtilgl6wizdius4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 01, 2021 at 11:18:47AM +0200, Marc Kleine-Budde wrote:
> I think there already is a function to stop the m-can core:
>=20
> | m_can_stop(struct net_device *dev)
>=20
> You have remove the static to use it from the tcan4x5x, though. If this
> function doesn't stop the tcan properly, you might have to add another
> callback.

ACK, that looks like it'll work. When I get the chance I'll do some
testing to make sure.

--
Regards,

Torin Cooper-Bennun
Software Engineer | maxiluxsystems.com


--zmtilgl6wizdius4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEHoj68wxDgkT3Oo2Mj1jJmDXJkUgFAmC2ElwACgkQj1jJmDXJ
kUjxiwv/aZWO97f2i5P//Mjq+KOd8pNdCPHHDAJ0GE2+l0wWp7yP73EAeTkkVEBo
qS7j1mMUSgHg3y77q5j5GmaWsAiQ1w1AhIw/xkquivktHyQNxqij0aqR+FnUjsiM
DEkySzPBnklLSf+bTm9z6UEIeUpwv26utvoHnwTAhOVJcBuwvMx4fHOARNcOnR37
Nn8tjn52aTrKXuPL1jTAXmVE4pRtncsUPA5T5TAfO8TBDvp/H78wRVtqQrqFQ82S
ikxbNEV7X2YW69U5vjPKx1e3VNRrTgZ8Cyy+V0iJs4d/76ari2Kq4TDiJXD24iyL
QWwWYLliSMkzInPAxdqcSmAIlq820+4b61qJPER54TNY8wJXUi5r7LfOaM3fTcjA
OrtskecM9+5EdYp+LqDRxPq9KmhF+wUbhKsmkjT1hbNbBa14UyI0KB1aLNqK3tpW
BCWz/Nud74yEJN73sAkR76HlwcDKSPJadcppYH7ZSUDbHdiX5g6MHICE7rF0U8p9
fxNWtDqs
=u3IQ
-----END PGP SIGNATURE-----

--zmtilgl6wizdius4--
