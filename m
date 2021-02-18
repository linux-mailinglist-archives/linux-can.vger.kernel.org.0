Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 50AA931E441
	for <lists+linux-can@lfdr.de>; Thu, 18 Feb 2021 03:15:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229553AbhBRCPn (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Wed, 17 Feb 2021 21:15:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229934AbhBRCPm (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Wed, 17 Feb 2021 21:15:42 -0500
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C698CC061574
        for <linux-can@vger.kernel.org>; Wed, 17 Feb 2021 18:15:01 -0800 (PST)
Received: by mail-lf1-x12c.google.com with SMTP id m22so2017923lfg.5
        for <linux-can@vger.kernel.org>; Wed, 17 Feb 2021 18:15:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=eg8ezL6jkJbL8SIwizxIj4drjYyk8slUf8PN2fT3Pfk=;
        b=RqlGSHQC+GH1OCFP9uFpIR1Dqi14nWLVZtXSRIE8whL6NRtxZfHXGmqPQIfKqXw6jG
         Qf/gmdcSFTHQ+fK01r8c3YwveR2lmsz9HYMKdLmO4WJaBs4dKPzofmxZyNF+8A8T4krV
         vz7LVlctUHIfqzuZHSsstnuFrWXGarahsRReFjRO0Qkzdkftu3mFrjp3nJEU0qKWdI9P
         okWXAGPkP2qmfOemDQs96YByKxalKLcMv2Om+DuUee+lO4Dv2fdmWrsMfdE/LAUiYGrp
         XhRKrAGDJJnwJjjFhxj34gj0kDFrR8mmRzOjzDJiGQkTO5Pptzm5+cMayEWg+W1PO7l/
         hWAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=eg8ezL6jkJbL8SIwizxIj4drjYyk8slUf8PN2fT3Pfk=;
        b=VVC0gP6VxoC8rOS09qhRvDbPLOf+CDa8n1AQFHbi2esaEF0ftJz8GV9m2i2SBPsB3J
         s27mhRbFq89/PgdD49HEmwSEI8ShfALJ0hs0G0pHjVG/l++rUVHcvZrYxvUU6J6Tiqap
         ubWnLhLq2aULnZ1TNRcLr7VoXD9N6m4CN46a2wKPjpUqMToqViQ1uNxyGOLAV6yPjWJC
         HL5Kbi5OxN+GJZOK4Hm+yKlIXjASgKaNUyT8O8VRLKDNnV2Qi9Z9XgyyXpGYEXK1zIXP
         BbsP8TQp/AGEUUWJgeVqR2v2peJ6Z+I7olsiqIjpIoSdeXE13dJvIoNJWJywPe9Ctben
         Eucw==
X-Gm-Message-State: AOAM532GSN6qD+7H7esw/mVLW6/VPOYKkULU4gJQlyanYGkmVLOyQcY7
        F+ROvjCB3DsE9v+aZg/VU7bnuZv9BNVr0WR0gkU=
X-Google-Smtp-Source: ABdhPJyjfgYbE3oq90JOBiKEqJqSqU8t3r6NlZH5HugznYpA+GEbx51HK65BNwh7GhV/kEEhLmWHX6Ig2EnUpSdRwdM=
X-Received: by 2002:ac2:5cd1:: with SMTP id f17mr1092312lfq.143.1613614500246;
 Wed, 17 Feb 2021 18:15:00 -0800 (PST)
MIME-Version: 1.0
References: <CABxGUThzGkCerMBTuA95TCs49hjHg+O-u3Z_c8=RZGJ8bVQjRQ@mail.gmail.com>
 <a13ab81e-ad20-0405-6935-ecd748233bc5@pengutronix.de> <CABxGUTjcynztDDoB=OVAXa4SYig3Ju+Y8wHmg-oVxs-b5n2SqA@mail.gmail.com>
 <60b5b0e3-bdb3-e1c5-b4ac-78f955b5374a@pengutronix.de> <CABxGUTi+nCvGA+tAabb6XLhwBx9_ZqVM3KwS-74jS8swApPZPg@mail.gmail.com>
 <b74ebe15-51b6-848c-1fd8-d969d5822766@pengutronix.de>
In-Reply-To: <b74ebe15-51b6-848c-1fd8-d969d5822766@pengutronix.de>
From:   Christian Gagneraud <chgans@gmail.com>
Date:   Thu, 18 Feb 2021 15:14:49 +1300
Message-ID: <CABxGUThxpyPHBkvFg64gxVW=4Lip3qW-Y2eZcecTX9PetymkgQ@mail.gmail.com>
Subject: Re: New USB driver, looking for advice
To:     Marc Kleine-Budde <mkl@pengutronix.de>
Cc:     linux-can <linux-can@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

On Fri, 11 Dec 2020 at 21:39, Marc Kleine-Budde <mkl@pengutronix.de> wrote:
>
> On 12/10/20 11:26 PM, Christian Gagneraud wrote:
> >>>> Yes, your device is quite special :)
>
> [...]
>
> >> I think you have to implement the polling yourself. Start a transfer on
> >> ndo_open(). In the completion handler handle the received data. In case you have
> >> recieved a CAN frame, submit a new transfer in case you haven't received data
> >> yet, schedule delayed work with a delay, e.g. 1ms. Once you have that running
> >> you have fine tune the number of running transfers and delays.
> >
> > Thanks Marc for the hints.
> > I'll look into that, this will certainly take time, I'm not in a rush.
> > Full disclosure: I am actually an employee of Navico (the manufacturer
> > of the device),
>
> Nice! There are several CAN devices which have mainline Linux spport by their
> manufacturers. Is there any driver for other operating systems like Windows,
> etc? You might talk to the developers to find out, how they solve the problem of
> polling.
>
> > I'm currently waiting for approval to publish code
> > related to that device. This shouldn't be an issue, I just need the
> > administrative work done.
>
> Fingers crossed!

I have 3 code base to share:

1. https://github.com/NavicoOS/pegasus-python-can/blob/main/python-can-pegasus/pegasus_iface.py
This code show how to talk to the USB device, it is quite compact and simple
The workhorse are_usb_bulk(), _write_usb_packet() and _read_usb_packet()
There are different types of packet, with a straight mapping with
open, close, bus on, bus off, read, write, ...

2. https://github.com/NavicoOS/pegasus-linux-can/tree/main/pegasus_usb
This is a simple char device driver on top of the Linux USB stack
You can manually write command, and read answer to/from this device,
the README [1], show how to handle the '
get_descriptor' and compare the binary answer with what the above
python based project

3. https://github.com/NavicoOS/pegasus-linux-can/tree/main/pegasus_can
I thought i had an initial PoC based on some linux-can driver, but
obviously not, this is the same as above, so let's ignore it for now,
unless i find a more up to date source tree.

[1] https://github.com/NavicoOS/pegasus-linux-can/blob/main/README.md

Chris
