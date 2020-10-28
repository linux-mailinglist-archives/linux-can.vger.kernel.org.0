Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8264729D9F9
	for <lists+linux-can@lfdr.de>; Thu, 29 Oct 2020 00:08:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725797AbgJ1XIe (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Wed, 28 Oct 2020 19:08:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726037AbgJ1XIc (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Wed, 28 Oct 2020 19:08:32 -0400
Received: from mail-yb1-xb43.google.com (mail-yb1-xb43.google.com [IPv6:2607:f8b0:4864:20::b43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E6E9C0613CF
        for <linux-can@vger.kernel.org>; Wed, 28 Oct 2020 16:08:32 -0700 (PDT)
Received: by mail-yb1-xb43.google.com with SMTP id i186so568077ybc.11
        for <linux-can@vger.kernel.org>; Wed, 28 Oct 2020 16:08:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=beagleboard-org.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=SXocrkxMkADbnUZLcGb/OW3cG8NBWdd4oxmefxOV0xk=;
        b=RNdcnSXZzBT4WtydayMb0fYbFwnQ8myx2XBqV52tYTshFFOV9qQx0XMxxwFldBP0i+
         5ZPbbCUPM7RKF8BgLLat9LcridrXnvYixzAY6ZKcf2Gdz6ONMNkNkG8xhwsgbDjq0WVv
         cUvld+7WR0azLPkG+aK7yx4yznomgMRbWWpsYZXw3NNs7iWWz6ktQg23IivlOTzOjRpL
         s+2y9rMuiKBc5PqX1RSsaCbUfE+6la2zzYshEK+uz1Ha6ceLfpFQdrLshwpKIf7qLZUl
         /Gi+WudfcFTrA42RJ8v8ZNHCTb+dV9g74+iWqXix0r4qazH7JGLs4SrN5BzveTgSs4Wf
         RXkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=SXocrkxMkADbnUZLcGb/OW3cG8NBWdd4oxmefxOV0xk=;
        b=J0jmM7U35m/uS+JJCJtaFktXNUmT6gshMjuaMMlCX2jpRNHJ8i7osgIZIESYJl8L02
         Bx5UX9S5Uw4aOtocu+Mc5SnlgWowAWEBAW9VaVmP7kVG5sk87PAY/BtwAsjGXZ483z4d
         /OR/mFL+TixJJaim2ObRr73rF8AhXxMaRQZQsEOwkS7cDr8oNJPZmM7/wvj85vBXVvNG
         XxcO9kETJ+/rITK/mPTeLH/7P8GBHiqyElGBn7WUBj4cZAb6L6U1JmSelAh7gBsucIe0
         ZotHEqFMWsTAQY1q9HQfZfcJvmUQlYJsz3Jt2NSEQAsLmJDFO+x2nheAGY68R+9AaTu/
         QM3g==
X-Gm-Message-State: AOAM532tlRmKORcdicMw7PasLNbtVbUbiYu9ScCikv632wKCVnrOL2O8
        NQIYD/AMxC5rsuVGzzl1CwYaBec03QL62xe+AJcFMGkXo+3Y5g==
X-Google-Smtp-Source: ABdhPJyDTNUievw/gr0T0+Sh0IEj5laVN1fGCTGZTZWo560zgDgwHaS1JvcRogPMrC90TyjlLn+sO98vRo8vbioiCIk=
X-Received: by 2002:a05:6830:12d9:: with SMTP id a25mr3399096otq.168.1603850265034;
 Tue, 27 Oct 2020 18:57:45 -0700 (PDT)
MIME-Version: 1.0
References: <CAPgEAj5eeN7Q9Hs7ZcrvaNCQJ7uW8kyNs3CPiVfQ=AEX9WeYoQ@mail.gmail.com>
 <CAPgEAj6nQOAQ9NNB2QBbARuqWm5K62QW+NsqPROzcQOZqe-F+g@mail.gmail.com>
 <975a3598-c229-0b9a-df95-c9647f138a3a@hartkopp.net> <20201025105808.2pltif74at3xwtjd@hardanger.blackshift.org>
 <68846197-98dc-b991-1ec8-a477ceb8d614@posteo.de> <715b3c3b-dbbc-688c-9757-578455c3a607@pengutronix.de>
 <0667516a-525e-9c4e-ec7a-e4d8a188c338@posteo.de> <CAPgEAj72jBPDGWnxOM73JLB=0Soo7uYh0FukNhpZQvDvqPewjg@mail.gmail.com>
 <CAPgEAj4DceAkPySUekDZPAKwNToxNjz6Yr66_3mqkE-0iiKAYA@mail.gmail.com>
 <92dd7044-8f0d-154b-eb04-8cec1b572dd2@pengutronix.de> <fa70fffa-7702-7cd0-dcfb-15bd18c3bb15@posteo.de>
 <2a1ddec7-ca28-ae44-dc06-f80f0017bf1f@pengutronix.de> <CAPgEAj6z_DaycgVOqvqqTv2KVRcascT8_nd+FNnZJtg0ObGPaw@mail.gmail.com>
 <CAPgEAj6nu475YeeWXc3wWO8sAmn8stz2Qr3nQ=HABd8CKR-c+w@mail.gmail.com>
 <41b606d5-5991-4d4f-bd6f-aaaf31cbc9b5@pengutronix.de> <6a7061a4-771d-6703-1e30-273050abfb9d@posteo.de>
 <2593d8e0-2d42-0461-e2e1-86a71b415476@pengutronix.de>
In-Reply-To: <2593d8e0-2d42-0461-e2e1-86a71b415476@pengutronix.de>
From:   Drew Fustini <drew@beagleboard.org>
Date:   Tue, 27 Oct 2020 20:57:51 -0500
Message-ID: <CAPgEAj5JheUirqr2kLrjJpwCaK3+HZyo8r8uKk25zMREVXWT3Q@mail.gmail.com>
Subject: Re: mcp251xfd on RPi 5.4 downstream
To:     Marc Kleine-Budde <mkl@pengutronix.de>
Cc:     Patrick Menschel <menschel.p@posteo.de>,
        Oliver Hartkopp <socketcan@hartkopp.net>,
        linux-can@vger.kernel.org, Josh S <josh@macchina.cc>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

On Tue, Oct 27, 2020 at 1:23 PM Marc Kleine-Budde <mkl@pengutronix.de> wrote:
>
> On 10/27/20 7:18 PM, Patrick Menschel wrote:
> >
> >>> It is different but I'm having trouble understanding why it works and
> >>> the new overlay for the newer driver does not.
> >>
> >> Have you actually tested the waveshare driver and overlay with your setup?
> >>
> >> If you have a scope or logic analyser attach it to SPI bus (MISO, MOSI, Clock,
> >> Chipselect and the IRQ Line of the Chip) and check what's going on there.
> >>
> >> Marc
> >>
> >
> > Is the target path for clocks correct?
> >
> > I mean "/clocks"
>
> It doesn't matter where you put them...
>
> > https://gist.github.com/pdp7/784d0ba8b9648d20ab055747ec945225#file-2xmcp2517fd-overlay-dts-L49
> >
> > instead of "/"
> >
> > https://github.com/marckleinebudde/linux/blob/v5.4-rpi/mcp251xfd-20201022-54/arch/arm/boot/dts/overlays/mcp251xfd-spi0-0-overlay.dts#L38
>
> The mcp251xfd node references them via the label ("<&can_osc>"):
>
> https://github.com/marckleinebudde/linux/blob/v5.4-rpi/mcp251xfd-20201022-54/arch/arm/boot/dts/overlays/mcp251xfd-spi0-0-overlay.dts#L61
>
> The driver will bail out even earlier if no clock is found:
>
> https://github.com/marckleinebudde/linux/blob/v5.4-rpi/mcp251xfd-20201022-54/drivers/net/can/spi/mcp251xfd/mcp251xfd-core.c#L2764
>
> regards
> Marc
>
> --
> Pengutronix e.K.                 | Marc Kleine-Budde           |
> Embedded Linux                   | https://www.pengutronix.de  |
> Vertretung West/Dortmund         | Phone: +49-231-2826-924     |
> Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-5555 |
>

Thank you for the suggestions.  I've not been as multi-tasking as I
hoped during ELC-E :)

I assumed the Waveshare instructions work but that is error on my part
for not actually reproducing.  That is what I will do first.
Ultimately, I want the freshly upstreamed driver working but I should
check if their driver tarball works.

thanks,
drew
