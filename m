Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A359D153047
	for <lists+linux-can@lfdr.de>; Wed,  5 Feb 2020 13:00:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726961AbgBEMA2 (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Wed, 5 Feb 2020 07:00:28 -0500
Received: from mail-io1-f65.google.com ([209.85.166.65]:40273 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726277AbgBEMA2 (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Wed, 5 Feb 2020 07:00:28 -0500
Received: by mail-io1-f65.google.com with SMTP id x1so1808872iop.7
        for <linux-can@vger.kernel.org>; Wed, 05 Feb 2020 04:00:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=KwiioqXR/LAmLMy4eVTgqxd9guiQxMzOjkdBtckfJ50=;
        b=YeE8T3Ie5/YEc19xH6/q6DS563laEG2IhM/yHLUKSbrJ+IVCTjQTJwiDQ5ug70ARAe
         AqGGu86T0cvLKNDPpevel3J/8RdgopX0fdoQGvXBYXxtFxwuzM0qeXQc+AbhRuj0LxXp
         QCOcGNCrlBJzjUeKZylU3Pu3hOyIl/tvgK8Lrs9nUkuqtLuVyFn+DUdordzJof4Gyv0m
         XDNpAHAC6K8rsJFx496q4ru8QpYAwmxXXFZs/iJaV1evys73XmJ+/8YWjcdtohsk7SXR
         2KRTlWy29tM1+u8rgWk6+rwht0/X/dI0S183+JjLQRcCvRrkI/X8BYB3mvlFFAY4pIOI
         CDxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KwiioqXR/LAmLMy4eVTgqxd9guiQxMzOjkdBtckfJ50=;
        b=Yak13hN6yqnc3xiTdcmu7c8jk3P5VK03xZjheF8gHh8z/Xs1huPvPxZbeiHHoLG1MG
         852+v1tNJhg3BPFuE8U36H7jssf/gd3C8xs9kE7jJGaHNLkkaqpcSerhWl8FFrQgCj/N
         lSx+/ort2bFW5dgIkj8kxgH3GdvsSjUMOm1NMFbaZQhPMVbA2Ah4YDvRh4BWo72Ji59/
         DE/Jc7nBt0PT8oLKkoF2K3c8DsbaJuUqbDQbz5Jtx0sl3+JO+Jf0+w9gAW6pOAAdGGCF
         hy8XKmLpg5bAugiZJbm7nno78TInXHU1OtdQ+P1k18v/FY8lrcXuR89QSnMYJaNXHOxB
         jljA==
X-Gm-Message-State: APjAAAVzxpfQTCcHU5EqqplonbD41ojH+Jcg3i1XKy0NUXSS2YF260Hc
        CvuurfEAvm3DjIQLTUnvPsdthdr20tiRJUNke2hcWLGfXOw=
X-Google-Smtp-Source: APXvYqwRn8fb0jbSDkrRM7kUV95YSgh56LC1y7vMdTgE5opXpBrfuSnh06f3/pvc7s6lg65Y2ZWBEwmGUmw6FjJjpDs=
X-Received: by 2002:a05:6602:2201:: with SMTP id n1mr27203355ion.32.1580904026467;
 Wed, 05 Feb 2020 04:00:26 -0800 (PST)
MIME-Version: 1.0
References: <CAP22eLHKe=0FEoS3DfRK8Oi6k2xntCvxQPVpXhau_bnuOAs71A@mail.gmail.com>
 <f2f20f9f-7810-e555-f6d0-11fc0510491c@hartkopp.net>
In-Reply-To: <f2f20f9f-7810-e555-f6d0-11fc0510491c@hartkopp.net>
From:   "Lev R. Oshvang ." <levonshe@gmail.com>
Date:   Wed, 5 Feb 2020 14:00:15 +0200
Message-ID: <CAP22eLE4L53Qcf0tK4X0kieKxw_=jtoh_qvnUpeq1yUy_cvBsw@mail.gmail.com>
Subject: Re: Help to set up can net interface on Dell 3200 Intel Atom
To:     Oliver Hartkopp <socketcan@hartkopp.net>
Cc:     linux-can@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-can-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Hi Oliver,

I tried command which is proposed in Dell manual
https://www.dell.com/support/manuals/il/en/ilbsdt1/dell-edge-gateway-3000-series/dell-edge_gateway-3002-install_manual/can-module?guid=guid-b6b7f697-0a5c-4b9c-acfe-9b436ca90bdc&lang=en-us

or i in /dev/ttyACM*; do udevadm info $i | grep -q
03eb_2404_USB_CAN_FD && echo "path:
                                    /dev/$(basename $i)"; done

It prints the device  /dev/ttyACM0 is present.

Can I use it as serial CAN  device?
I am novice to CAN devices. Now I understand that can and can_raw are
only generic drivers and I need real driver.
I wrote to Microchip support, perhaps they have driver for this box.

But still I do not understand why can driver is loaded at boot time I
used to think that only real hardware cause the driver to appear.

   16.727375] r8169 0000:02:00.0: can't disable ASPM; OS doesn't have
ASPM control
[   16.742055] r8169 0000:04:00.0: can't disable ASPM; OS doesn't have
ASPM control
[   16.824470] peak_usb 1-2:1.0 can0: attached to PCAN-USB channel 0
(device 255)
[   30.661705] can: controller area network core (rev 20120528 abi 9)
[   30.678155] can: raw protocol (rev 20120528)

I saw these lines in dmesg and now I thing they apperead because CAN
support was not a module but built-in in kernel configuration.
Regards,
Lev

On Tue, Feb 4, 2020 at 6:08 PM Oliver Hartkopp <socketcan@hartkopp.net> wrote:
>
> On 04/02/2020 14.07, Lev R. Oshvang . wrote:
>
> > I have with DELL 3002 Edge server
> > It has can and can_raw drivers loaded at boot time
> > It does not have /boot/config.txt file
> >
> > Unfortunately, I do not have kernel sources and kernel config file is
> > not present in /proc, so I do not know which exactly chip is on b
> > oard and board specs says only:
> >
> > (CAN2.0 A/B/FD) 1Mbps (CAN2.0), 5Mbps (CAN-FD).
>
> https://topics-cdn.dell.com/pdf/dell-edge-gateway-3000-series_Specifications2_de-de.pdf
> says that there is a
> https://www.microchip.com/wwwproducts/en/ATSAME70N19 Cortex-M7 which
> handles the CAN FD controller.
>
> The ATSAME70N19 is connected somehow to the Intel Atom-Prozessor E3805.
>
> So I won't assume, that you can access the CAN controller from the Intel
> CPU.
>
> > I tried to set it up but get the following error
> >
> >
> > root@5HCF902:~# ip link add dev can0 type can
> > RTNETLINK answers: Operation not supported
>
> You can not "add" a real CAN interface with "ip link add ..." - this
> works only for virtual CANs.
>
> Try
>
> ip -det link show
>
> where some CAN interface (e.g. can0) should be visible, if you have one.
>
> Regards,
> Oliver
>
