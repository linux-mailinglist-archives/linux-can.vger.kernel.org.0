Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CFC08380C54
	for <lists+linux-can@lfdr.de>; Fri, 14 May 2021 16:54:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233191AbhENOzt (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Fri, 14 May 2021 10:55:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232760AbhENOzr (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Fri, 14 May 2021 10:55:47 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BCC7C061574
        for <linux-can@vger.kernel.org>; Fri, 14 May 2021 07:54:34 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id a4so30319473wrr.2
        for <linux-can@vger.kernel.org>; Fri, 14 May 2021 07:54:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=maxiluxsystems-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=owz7t4Uxqe6akAUDscB9oMTjMzIUe7BZ+/5rvVeQ2/8=;
        b=PhW8YVcWcW2eYYCts6P45QEXeB13Su2k+bRw11jgZKan+BrlXM8YCxxEdClXozJj1y
         YSQ0DExrOZVQ4Bi9j4dw6AX9hITJCh9Hg9EFX2NOamdjIVYIqcgDkXwD3wMMxVfJj7AV
         Qoo1An0Co00tdezNWHQyEhsswqBono2AOiwGTjFEiCuCjHX6JNdwZrvaer9edM4PON39
         cj4XSTPPkA/Ic1m+9f2CMxDBQd2wEo2WY3ZX2vjW3KcIJFyV9dz7nzZh9sLQ0JoFzAh3
         81i6yUSp3LRUaZASSQehaxfNnrxq2lQgU0q1r73tbujURQgEAipwE8una3dyRjZIm0LG
         WOlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=owz7t4Uxqe6akAUDscB9oMTjMzIUe7BZ+/5rvVeQ2/8=;
        b=eFPPwEJeM9lHYjtynHmUQVO8U3cNcv1/SBP/DiGPGuxJYdOb5wqpktZwM7NLasU4dH
         7z2FblUs0lCJ5p5cggSAXcB7WSOqoHr+UjtN0ESRmFxQIK5MHa5AK/RMCzX/cZbf3LcA
         IeDjspGkZ6cPcZzeJzXWAzEZwNEgVmKgR/X4EakcNJJ7M1JJqOX20whQgddFfEzr1Nc5
         PXOqLuqnx2fVexSQkJkNDXMUJ02HI/xs6LGadUxx2mkJdjQFAXFImGVDLOpRoeoMEzmF
         qM92jDEAqe/pxZWjcdkulQJMdl/bs9QYr5pcNfSkw9FXLPQScGTO9ct/rlka+o4SzUYg
         glZA==
X-Gm-Message-State: AOAM532IHuSd8AAaUR/E/JDMaJntcdA0VYrOfEm3hPuFyhBDI2Qv2NMM
        ZSjtXGNMkRdH2GhglElCxYMUFQ==
X-Google-Smtp-Source: ABdhPJxyR+AkoScQ80JBfWeEBhWKFRpPZ0FMdRwnkoXF1M8pAcu5OurC4exAic8uJ2k4Nsfmdq9HQA==
X-Received: by 2002:a5d:4bd2:: with SMTP id l18mr59163621wrt.197.1621004072891;
        Fri, 14 May 2021 07:54:32 -0700 (PDT)
Received: from bigthink (92.41.10.182.threembb.co.uk. [92.41.10.182])
        by smtp.gmail.com with ESMTPSA id d3sm6922446wri.75.2021.05.14.07.54.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 May 2021 07:54:32 -0700 (PDT)
Date:   Fri, 14 May 2021 15:54:30 +0100
From:   Torin Cooper-Bennun <torin@maxiluxsystems.com>
To:     Marc Kleine-Budde <mkl@pengutronix.de>
Cc:     linux-can@vger.kernel.org
Subject: Re: [PATCH RFC can-next 0/3] m_can: support device-specific
 interrupt handling
Message-ID: <20210514145430.i4ajyapz6zhjnrro@bigthink>
References: <20210514121946.2344901-1-torin@maxiluxsystems.com>
 <20210514123417.tlm4bvqidwnioesm@pengutronix.de>
 <20210514131049.yluxu3cxaspeptvb@bigthink>
 <20210514141237.ps7gcfjhejnehbhv@pengutronix.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="cyzrzi75qrjemiop"
Content-Disposition: inline
In-Reply-To: <20210514141237.ps7gcfjhejnehbhv@pengutronix.de>
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org


--cyzrzi75qrjemiop
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, May 14, 2021 at 04:12:37PM +0200, Marc Kleine-Budde wrote:
> Ah, ok. Do they need any handling/acknowledge? You only read TCAN4X5X_INT=
_FLAGS, are
> those clear-or-read?

An extra note on this... most of the faults worth responding to here are
serious enough that the interface should just be shut down, or at least,
the device will need to be init'd again.=20

I'm surprised no handling was implemented in the first place - makes it
very difficult to debug problems when you're prototyping new kit. The
driver is written as though these interrupts are meaningless!

--
Regards,

Torin Cooper-Bennun
Software Engineer | maxiluxsystems.com


--cyzrzi75qrjemiop
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEHoj68wxDgkT3Oo2Mj1jJmDXJkUgFAmCejyYACgkQj1jJmDXJ
kUivuwwAkLi7OLhsqC2F2W8N2KBF7vPEW9j1x+KbyS7UaxaZu+Euu/0ELH5Ysihn
WC7wyRXZ0QRgX6vH82c2uwIyV7aUiza/66ZPG/Rca6qWKqCPzmuAiJATg+68zSKc
QbI7rdgEptRcZu9YCUOTrviBLFSc8PhAAtce/RlwAE/Jogpcez0tRsOzmR3tMZyP
EpWvzf6Jfvs0C0lDy3B5vu1KFae1Ob+32Waa8sLgObwTf3Qy1Lc/tsgX1qn1SjKr
FO/O5zk7h/YKTD52aL2YHa5yABUDMy4GiuAPclQ1DvyiBY/qgMQnWfr/a7kV1ixe
j4btL/yFT3ngI99i6CZoHHYh4+kGDQi3xOcGhJakNAx3mgTSOsJt9TlFX/0Q+sEl
DWdeDdCfVYSvzTzseIy0LV1NUeKA83Uo8BmQWzkNKBjwGtlri0VLbiArVO3lVaKW
VNqdtAYQqiNiYxmcs4vPZi1RyU+jZxZLdJM5zB6Aost+x4vrf9iIXppYD/akiqr1
TgVqmvSz
=avbQ
-----END PGP SIGNATURE-----

--cyzrzi75qrjemiop--
