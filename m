Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 40368376114
	for <lists+linux-can@lfdr.de>; Fri,  7 May 2021 09:24:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233131AbhEGHZR (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Fri, 7 May 2021 03:25:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230046AbhEGHZQ (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Fri, 7 May 2021 03:25:16 -0400
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6A0DC061574
        for <linux-can@vger.kernel.org>; Fri,  7 May 2021 00:24:15 -0700 (PDT)
Received: by mail-lf1-x135.google.com with SMTP id j10so11373790lfb.12
        for <linux-can@vger.kernel.org>; Fri, 07 May 2021 00:24:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=SagpwFIe45HGDJElolTgoqY+bS/SlzaLAvR1Ash1SEM=;
        b=Ub+efAtxTQvcVRpCFGCamC9Ae0bsWfwra4CRf0tjHcNqwM6H82QRzJG/h2rXJmPvmn
         8nKEP7qE12D959yWbMaI1lNySyQr+IonRQVkIDN0CrQDz0K4EHCr5YfpHmA4R/bkzUr9
         JVe/5qwAgL93SYDSodg1imiY+BkBcd3pV8ZYLdYw/q0GCY+U73459SSvUSUC9cb2J636
         kj61XdY4KBFD0XeW+WeX5wWC1V4l088nHTDIi+y39vwoBdsGhEODgyuhZibl/+GCd+/Y
         CHdf7+QBng2GU6VBMN6bpRurWpa4o4Nw94eIHx3W0MFEMfEi9G+5Oy1mwkyf4iYL+9UJ
         Sc+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=SagpwFIe45HGDJElolTgoqY+bS/SlzaLAvR1Ash1SEM=;
        b=XhqYOCFu5ZaFdNtIW8D0MeSuCTvGGtIH9NdCD73gRWfDZvnkZjzuWrpIrJ7GZe/dEW
         FjTBFh3+K42fonTg7rvxXulrtfMv6pk5xBxmqDOzvgl0E7kPHMN7psEBq47nHqlsU/Th
         vH8Xeip4wA9d3MkhS/I/SJv2MAu0pHM273XofGkx+y+MTCNzh6ABypCWfeGizefJKVtJ
         CLOTf6r/llXaygYMZNL9R+K7is+AwWfcix01Rl8l+0R3Ft8dM0opox+KRi3vMWmCs+9e
         RQpy/VKtnnuT7ePMGqQEK0OPcbBSv1w6v1in+xjwDE1AtkGXXipbx4kfwKd33isnXMxu
         IIUw==
X-Gm-Message-State: AOAM530vJuAKGkP2VAHO7SIW0bWQ3y2tsJ3CeTSMyjJu6H+d6S7nP7uL
        t243noXCsaSBEHix7DpFjUHceAsSQMc1QBC2alo=
X-Google-Smtp-Source: ABdhPJyRKai9ELukLXY/Hi5+JfxCErNvA4PymSmrAH1beVmhM+XQoFGqLrZmy66vEnCK4WZ946U1CvLPYkHpHEgHnsQ=
X-Received: by 2002:ac2:544f:: with SMTP id d15mr5452271lfn.465.1620372254377;
 Fri, 07 May 2021 00:24:14 -0700 (PDT)
MIME-Version: 1.0
References: <CAERdor5nY73X4qip=up8fNU=xT+H7r2XnKiob66=4DxovkBiGw@mail.gmail.com>
 <a7df697c-b6d3-1894-dcc6-672698caa19a@hartkopp.net> <CAERdor5o6yKq1J-hBbjiBtU63OkxhijKifO0OEBt21ASKhCXuw@mail.gmail.com>
 <02607798-4701-376a-6a58-2ff29c87ccab@posteo.de>
In-Reply-To: <02607798-4701-376a-6a58-2ff29c87ccab@posteo.de>
From:   Bartosz Zdanowicz <zdanowiczb@gmail.com>
Date:   Fri, 7 May 2021 09:24:02 +0200
Message-ID: <CAERdor7LiPPJWLxMQdrQsF=jU0yHNU_uwLAbQegpUj4KeJHzgg@mail.gmail.com>
Subject: Re: CAN ISO-TP
To:     Patrick Menschel <menschel.p@posteo.de>
Cc:     Oliver Hartkopp <socketcan@hartkopp.net>,
        linux-can <linux-can@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

pt., 7 maj 2021 o 09:02 Patrick Menschel <menschel.p@posteo.de> napisa=C5=
=82(a):
>
> Am 06.05.21 um 23:28 schrieb Bartosz Zdanowicz:
> >> Can you create a candump log from vcan0 to see, what's going on the bu=
s?
> >>
> > On RPI after first send I got
> > pi@raspberrypi:~ $ candump can0
> >   can0  002   [8]  10 09 41 41 41 41 41 41
> >
> > After the second message I got mentioned OSError and there is no data
> > on candump. Sending again I received next frame:
> > pi@raspberrypi:~ $ candump can0
> >   can0  002   [8]  10 09 41 41 41 41 41 41
> >   can0  002   [8]  10 09 41 41 41 41 41 41
> >
> > On my local PC where I get no system Error I got one frame per every se=
nd:
> >  bartosz =EE=82=B0 ~/Work/DeltaThermal/can-isotp =EE=82=B0 =EE=82=A0 ma=
ster =EE=82=B0 candump vcan0
> >   vcan0  002   [8]  10 09 41 41 41 41 41 41
> >   vcan0  002   [8]  10 09 41 41 41 41 41 41
> >   vcan0  002   [8]  10 09 41 41 41 41 41 41
> >   vcan0  002   [8]  10 09 41 41 41 41 41 41
> >   vcan0  002   [8]  10 09 41 41 41 41 41 41
> >   vcan0  002   [8]  10 09 41 41 41 41 41 41
> >>
> >> ...
> >> So how is Python getting this information?
> >>
> > In general, that's the biggest issue for me. Because in my real
> > application I'm using python select() and recv() on that socket. When
> > this error is raised, my select() on socket deduce something is
> > received and recv() function also throws an error. I just tried to get
> > a minimal example that reproduces the issue which is above. In those
> > cases I would expect timeout, not OSError.
>
>
> As expected, timeout error on missing flow control. Since it's tx side
> it just tells -ECOMM instead of -ETIMEDOUT .
>
> https://github.com/raspberrypi/linux/blob/rpi-5.10.y/net/can/isotp.c#L10
> https://github.com/raspberrypi/linux/blob/rpi-5.10.y/net/can/isotp.c#L755
>
> Is there a specific reason why you use select.select() instead of
> Socket.recv(timeout) / Socket.send() ?
>
> Best Regards,
> Patrick

I have a seperate thread that waits and process data, since I have
multiple sockets opened I want to wait for any of them:

while True:
    ready_sockets =3D select.select(self.sockets, [], [], self.timeout)[0]
        if not ready_sockets:
        logging.info("No data received")
        continue
    for socket in ready_sockets:
        self.process_data(socket=3Dsocket)

In process_data I call:

received =3D socket.recv()
    if received:
    #process data

My main thread is sending data on those sockets:
schedule.every(X).seconds.do(request_that_sends_using_socket.send(),
socket=3Dsocket)

So the flow is that my thread sends data to another device, and the
processing thread is waiting for data. When I don't send any data I
get only prints "No data received" which is expected cause no device
is responding (no device is running). When I send data (no other
device is running) I get an error on send AND my select() is finished
with an error socket inserted to ready_sockets. That means I enter
self.process_data() function with socket and also recv() fails. So it
seems it's not only that OSError is raised but also that socket is
somehow "invalid" because it triggers select() which should not be
triggered (no data was received).

I hope I described it clearly, if any more details are needed I'll try
to provide.

Best Regards,
Bartosz Zdanowicz
