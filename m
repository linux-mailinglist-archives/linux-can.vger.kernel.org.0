Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DD8C93B9CFA
	for <lists+linux-can@lfdr.de>; Fri,  2 Jul 2021 09:33:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230040AbhGBHgE (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Fri, 2 Jul 2021 03:36:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230127AbhGBHgD (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Fri, 2 Jul 2021 03:36:03 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C8DBC061764
        for <linux-can@vger.kernel.org>; Fri,  2 Jul 2021 00:33:30 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id u6so11255623wrs.5
        for <linux-can@vger.kernel.org>; Fri, 02 Jul 2021 00:33:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=maxiluxsystems-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=WiIPVZJhr5+HZQWMZI2vWaAOmSFti6gskrqlFKq7wYE=;
        b=j9UXyAYORmcZ6J4/Akqzlb+goOQMUde/hxyIaoWJuc1ZJKLX5OQ9AOmImWkDXCNduE
         HoO3Eccsp3TnLexTFHf1Nus3MpxGzZ0jZ/GJtij2c+6r5B8vd/5CzPnPf5NE5bFAkbz6
         iPubLNpfl3sd1xjqEzBi8RztJh6oW91aIyqAY0PeKq/FKTUQFPEwR2Gtu6AK+ykN8LRA
         kwg+qrIYx1FAt+23cek0mLlMiBsJfgaMCTdeI+0gXVrE8K6h9gCXXlPU7Bcn5e9lNu7l
         psZ3c0eVGtzz0faAqBr3iTx3wO73RBnH40rNsEhbxbTCnwUBBLsh19oQo9c8usUVCEAa
         Ub1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=WiIPVZJhr5+HZQWMZI2vWaAOmSFti6gskrqlFKq7wYE=;
        b=h72wbXOb9kl7xWfQX7W6IHC5ILdoxF5j9kLemUyt8Ht56aBb6qOKejnQ9uWsDolmP0
         t2FX0M34fBbVHYOOH84dGRsZeFOmD1wXjIRB82J9LlX4F//wCzb5syETfM7Pv8g4UGmf
         BGpEobF0etgWbH5Kg0kiN1C/Z0VGZtf51CtjcP77jRxEvoTJ7nNSjHowDA9bLPMCmCRr
         2oRBXLsuPTFOxTmPzVWa3w8mwQhweqXIrOrSlAHQ7T/GnMMf02XldOTum21fUvrXvW3d
         hrGUExzYpCPxu6LuWkSuI+dI3ybwOZ42tAGDXvRgD+9S3jEldrWHhvdUPQAATYnhe9os
         lFqg==
X-Gm-Message-State: AOAM531WJs/kPcaV8DAWhFaz6HOBl162VQGhN1XgnwjaD1/5TPFedYd8
        YhTh8XoJEx3XoAZsjuuM5O84NAnqgkAr/w==
X-Google-Smtp-Source: ABdhPJzhqQwwlTRdjO3h04nuBY2jCw2gLhONJh59hjz2JE41eUrkH7c+C4GMU8cIPSIRW5nWB4DkgQ==
X-Received: by 2002:a5d:5043:: with SMTP id h3mr4133779wrt.333.1625211209091;
        Fri, 02 Jul 2021 00:33:29 -0700 (PDT)
Received: from bigthink (94.197.218.34.threembb.co.uk. [94.197.218.34])
        by smtp.gmail.com with ESMTPSA id l22sm2674629wrz.54.2021.07.02.00.33.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Jul 2021 00:33:28 -0700 (PDT)
Date:   Fri, 2 Jul 2021 08:33:28 +0100
From:   Torin Cooper-Bennun <torin@maxiluxsystems.com>
To:     Marc Kleine-Budde <mkl@pengutronix.de>, linux-can@vger.kernel.org
Subject: Re: [PATCH can-next 0/5] m_can, tcan4x5x: device-specific interrupt
 handling
Message-ID: <20210702073328.xk2o5dc4edbljl2s@bigthink>
References: <20210526124747.674055-1-torin@maxiluxsystems.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="ahboay7fbo7evy6f"
Content-Disposition: inline
In-Reply-To: <20210526124747.674055-1-torin@maxiluxsystems.com>
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org


--ahboay7fbo7evy6f
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, May 26, 2021 at 01:47:42PM +0100, Torin Cooper-Bennun wrote:
> Hi Marc and list,

It's been a month since I was last able to work on this series - I don't
think I'll ever get round to finishing it. The semiconductor shortage
has hit stocks of the TCAN4550 really hard, so the project I'm working
on has shifted direction. (Good thing the MCP2518FD has such a good
kernel driver, eh Marc?)

So if anyone comes across this and wants to finish off this work, feel
free. :)

--
Regards,

Torin Cooper-Bennun
Software Engineer | maxiluxsystems.com


--ahboay7fbo7evy6f
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEHoj68wxDgkT3Oo2Mj1jJmDXJkUgFAmDewSUACgkQj1jJmDXJ
kUivagv/XVf4QJMoMZsT9mMJSESVLPLOz3ibwN2MNMntGn7xQ1mGoxCM+kUiO/uz
p4yZQpHZ0e8QJ+YXa23NXESIM44YiWHDu3UVGccKPvOBqISzjC2YH046cQdoxEhl
lCgFc7taBNp1T/l4JeinLTF6gjVX67iNIfCLtDhAcDRvjGstaaXTAC8wG70iX6kh
CcnkY0LqOew5JMG0H2tEMxMnpujoqt4whZiVKdDdLXzDrHml0FxUJRs+kjmkxLAs
9Tc1lMqFZ8QjZnsfIQAwIEIQ3TeXo5EwsPwjLkJxpLjgd8PBD/QNkBCbAOw9VBea
Q8hEiPkekhG5elyPmJjcD9FoyobaWuNk39s5egGdj50aQoZoaNIzt8Bvs9wUPXti
/umF5vfyDpI1onp2MM6CjkbBm25DDto80NsP1+CKvdr7MjEbxrAz4/4rNKlQOiAE
tEaTtYYJsuu5Zq6fF/VVdGGkWg1UYWOiJ8A5L0UmfIpXJvAE+S/sUOQ3DOujrw7w
8orQ45dD
=HT4Z
-----END PGP SIGNATURE-----

--ahboay7fbo7evy6f--
