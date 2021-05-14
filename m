Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E2688380C44
	for <lists+linux-can@lfdr.de>; Fri, 14 May 2021 16:51:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232542AbhENOwR (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Fri, 14 May 2021 10:52:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232509AbhENOwQ (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Fri, 14 May 2021 10:52:16 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4DA8C061574
        for <linux-can@vger.kernel.org>; Fri, 14 May 2021 07:51:04 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id n17-20020a7bc5d10000b0290169edfadac9so1572837wmk.1
        for <linux-can@vger.kernel.org>; Fri, 14 May 2021 07:51:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=maxiluxsystems-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Z/iq+W16t+RS284Zbr6HnNiSMQSdyO4fqeHSQZACta8=;
        b=QJqwpYuv4PlGafQP52pWrxcYlQ55x+TuquiRnFHDtBghmTqUngvihh/svUagAI3s8V
         +L/oHlIRHq0Wkl5iI36Svjv9fsGR3oDncbsvoHMgXlnLgbxnN+G9nmuAXLLY3rkfL5jT
         EUHEaHB2oP3RdIzVL6r0Kw8QeEtD9TYwPdFdhrnfRrkFWDgppRaTTbnVec5ZhErwOrzm
         UI0ZilKyzxlByKZfwqO/ig2P966sZxeHZlvyw+o6ZWLV0qquipojsP+lbe8VUXsinEva
         PcQ2HFUNy1buIecpOfu3RN2klY6a9EpdZ9ipqE63y0nZFe+9XmdiPVO1H53yNMzRdHT8
         h4gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Z/iq+W16t+RS284Zbr6HnNiSMQSdyO4fqeHSQZACta8=;
        b=XhYS6KBz/UlMX3+iP5H9perFLHy60W/qIdXwFXaEKuaiHi/3L1BbPEK3tkRUXiVMyY
         Xs5krmNdl5vy7BHSt5qfCamhrSH4QQSboroepigxAdtQZ6sCuk8dIX2G83Q09B6OaPad
         I9t92HCV4HZoetUajVRv9N2n4KKcuc+ebKZGGJXxIRTjZXNy9KpAX54lUYYTZP8sGiBD
         f3FQSQ9nSJGCdG8zK/9ZapF30Gz8ngD8av51R/7AjuZRdmZOx68SL2SiCJry4DgSqRi6
         SHxiDgKoAK4Qh68wwdILvgbH489f/IGhz+vrNUxSS6H6cgGZS5iVMuLSYPrUlXwvgqtD
         MJlg==
X-Gm-Message-State: AOAM532dAHSaf6n+MFQQs1WaGZ3QapniijRiPvzWwSJFKY/C7uqkSYVE
        20DrnKX7XbMANVzJb6cxee5Y1Q==
X-Google-Smtp-Source: ABdhPJysMvVlCakOsogudX6CPm5QZoYM0iqjyHDGE5NP0pyppbk7f6v2gvhA7wQr9DRafoMKeISOZA==
X-Received: by 2002:a7b:c206:: with SMTP id x6mr9943917wmi.72.1621003863576;
        Fri, 14 May 2021 07:51:03 -0700 (PDT)
Received: from bigthink (92.41.10.182.threembb.co.uk. [92.41.10.182])
        by smtp.gmail.com with ESMTPSA id o1sm11702127wmc.6.2021.05.14.07.51.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 May 2021 07:51:03 -0700 (PDT)
Date:   Fri, 14 May 2021 15:51:01 +0100
From:   Torin Cooper-Bennun <torin@maxiluxsystems.com>
To:     Marc Kleine-Budde <mkl@pengutronix.de>
Cc:     linux-can@vger.kernel.org
Subject: Re: [PATCH RFC can-next 3/3] can: tcan4x5x: add
 handle_dev_interrupts callback to ops
Message-ID: <20210514145101.uk7wldgsao5cvuj7@bigthink>
References: <20210514121946.2344901-1-torin@maxiluxsystems.com>
 <20210514121946.2344901-4-torin@maxiluxsystems.com>
 <20210514141012.3ehw4tosog3lreq4@pengutronix.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="q3xoks3erwg73ovw"
Content-Disposition: inline
In-Reply-To: <20210514141012.3ehw4tosog3lreq4@pengutronix.de>
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org


--q3xoks3erwg73ovw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, May 14, 2021 at 04:10:12PM +0200, Marc Kleine-Budde wrote:
> For new code, please don't wrap the regmap_*() functions so that the
> error values are ignored. I know, it's a bit annoying to always do the
> "if (err) return err" dance.

Will do, thanks.

> As this is the interrupt handler there's not much we can do in case of
> an error. In the mcp251xfd driver I print an error message and shut down
> the interface. You should at least print an error message at the end of
> the handle_interrupts() function.

I assume you mean the handling of errors out of aforementioned
regmap_*() functions specifically? I agree we should shut down the
interface - I've previously endured serious debugging pain due to SPI
errors going unrecognised and causing havoc.

> I think it's best to have a single handle_interrupts() callback that
> combines the existing clear_interrupts and this code. If you want to
> save an SPI transaction and only read the TCAN4X5X_INT_FLAGS if the
> M_CAN_IR is unset, pass is as 2nd parameter from the generic interrupt
> handler.

Yup, agreed.

--
Regards,

Torin Cooper-Bennun
Software Engineer | maxiluxsystems.com


--q3xoks3erwg73ovw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEHoj68wxDgkT3Oo2Mj1jJmDXJkUgFAmCejlQACgkQj1jJmDXJ
kUiHgwwAuPNOWQtTb8YBnoismpR51SGs1iDoIYhBDr6KnSZ/h/rdY9M7gqqVNZvm
VUeNCjzQATdlXoQssMs94vgAMgOOiA373WQJWDn1Q+YLDxNRGspaRJ9b/rkSYEKh
Ha4Ncs8T3+H/4o0c/Cn5Y5ZFpysFxsdvVtv4DwGPqOzo3bxm7fa+lPCXsAUZ4kmp
lRm73eAKG29WXIeAk34ENO0Fndvd6QHXwNc6EETaHFXhnQVgHWZDsX3wWOulLKCL
D7KSJBFqLPAuFmo2Q4PY8nQh/JRrJmrBobb+oY3oeP8CKkjSjjhU0/MgXEoWQS7+
mxU335qlDEm6VTb0zReEoWmyuifQbg8JTkK4xjXBJVcqGUg7LcxhMRCbYPmJXtz0
qQPKusA8VzRKZiEXqiZr8u42q2SiTiPbpe0HXV5nXk53MwxzCIvHenkFJiFZeg0g
TXngPiZ5ijXCNBO/3O0pFP/Hc2L6IBFvHbWZSGYQUcBWdVMRbV8De55DwtBVM1z3
9fMzCUj5
=Dx++
-----END PGP SIGNATURE-----

--q3xoks3erwg73ovw--
