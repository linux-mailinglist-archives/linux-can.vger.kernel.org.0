Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 759233780CC
	for <lists+linux-can@lfdr.de>; Mon, 10 May 2021 12:03:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231179AbhEJKEp (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Mon, 10 May 2021 06:04:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230307AbhEJKD4 (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Mon, 10 May 2021 06:03:56 -0400
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com [IPv6:2a00:1450:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5413DC061574
        for <linux-can@vger.kernel.org>; Mon, 10 May 2021 03:02:48 -0700 (PDT)
Received: by mail-lj1-x22b.google.com with SMTP id o16so20098051ljp.3
        for <linux-can@vger.kernel.org>; Mon, 10 May 2021 03:02:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=g+bSDZsh1iBikjz4vXhw3s4YJh1Ah9D5vbX7trF6hwU=;
        b=mj24zROE5N3jKWkkWC3N0yqK01VoMZRYFYOS0N0ddbLedktyHH+pTMra69FyFWD2VT
         PB+Vz7G5hv8jjl81un+2Taa/o+jJoge5Rkq/onlbWYl5QXrMR9jRUrEbnYvACINYAkNQ
         e+kGH/Iob9OpVIptMRcocZq3+vXKwZTgPiV8A70J3H9wCArjQzdOAPpWjPTwFHMoR1Q/
         W/9R31vJnAk119J+FTHwwYms6gxh5pdT6RAfcPr11Mbwk435xOGlh+OHCvA1Y6nbi+wo
         w9EQUSj+MRhNgNW8YDqgADnZqF4pIt171wN8IFlnT0gSYomjOLM/p5FP7ul+mrM3pOiD
         /wxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=g+bSDZsh1iBikjz4vXhw3s4YJh1Ah9D5vbX7trF6hwU=;
        b=TFeGIf4vAZJ9tT/RrTZT+ej+I4WBWLUqP0HqiUFAA7hiXgdfbeoqL3WCHI2RbiDbmp
         MvCQyIUHjQdA64o6cJuSEbTSoZi+Qj+BnIOhSH+PoTcH5nq370xCk1XkwPpjVPrS2wRO
         U6rt6WiLcMcOyhYcVOIkW3plc58cbcLKS5U5n1rJGdlXh5lMs01f/pM8MxQwiI0kA+6f
         eRQVLfhpxGlS4eDuzlhhAw7x7DCtnx5cxIW+nH0xObdf7SQ3mOtW/i+znXZvmgMBPVYN
         IUP1SgVCWp58o+hSTtP6XQs2aKFrj8lGedSynlDNPmhdG/hseLL0EZHqBEHbIGzmfu7P
         Xk0A==
X-Gm-Message-State: AOAM530yGgI2H7OVrY/3bTOgOAl91RELbaIxmQsb4njRm5p68EmMxsR1
        wOqHHkZ7JgasNWozyAJxhThJk9QfK9l+JOXp6512qUOgFDGrEg==
X-Google-Smtp-Source: ABdhPJwaNwl30j3s/7CVTuwpwIdi0AQ7DqgKGJ42VlL+fOs2/UnJN2zN8x3i4LnWhp/3RBrlNezZ9ymShRVZnBH9fBk=
X-Received: by 2002:a2e:7805:: with SMTP id t5mr6103723ljc.204.1620640966875;
 Mon, 10 May 2021 03:02:46 -0700 (PDT)
MIME-Version: 1.0
References: <CAERdor5nY73X4qip=up8fNU=xT+H7r2XnKiob66=4DxovkBiGw@mail.gmail.com>
 <a7df697c-b6d3-1894-dcc6-672698caa19a@hartkopp.net> <CAERdor5o6yKq1J-hBbjiBtU63OkxhijKifO0OEBt21ASKhCXuw@mail.gmail.com>
 <02607798-4701-376a-6a58-2ff29c87ccab@posteo.de> <CAERdor7LiPPJWLxMQdrQsF=jU0yHNU_uwLAbQegpUj4KeJHzgg@mail.gmail.com>
 <587ef081-804b-9816-f899-f4bd645865cf@posteo.de>
In-Reply-To: <587ef081-804b-9816-f899-f4bd645865cf@posteo.de>
From:   Bartosz Zdanowicz <zdanowiczb@gmail.com>
Date:   Mon, 10 May 2021 12:02:35 +0200
Message-ID: <CAERdor4VkyxQ3X4gZn1jR9PFkwg2BqbC+iG9DQXECakdpsotkA@mail.gmail.com>
Subject: Re: CAN ISO-TP
To:     Patrick Menschel <menschel.p@posteo.de>
Cc:     Oliver Hartkopp <socketcan@hartkopp.net>,
        linux-can <linux-can@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

I used following code:

import isotp
import time
s =3D isotp.socket()
s._socket.settimeout(2)
s.set_opts(s.flags.WAIT_TX_DONE)
s.bind("can0", isotp.Address(rxid=3D1, txid=3D2))

s.send(b"aaaaaaaaa") -> returns immediately with number of bytes
s.send(b"aaaaaaaaa") -> same OS error as above (Error 70)

pt., 7 maj 2021 o 09:59 Patrick Menschel <menschel.p@posteo.de> napisa=C5=
=82(a):
>
> Am 07.05.21 um 09:24 schrieb Bartosz Zdanowicz:
> > pt., 7 maj 2021 o 09:02 Patrick Menschel <menschel.p@posteo.de> napisa=
=C5=82(a):
> >>
> >> Am 06.05.21 um 23:28 schrieb Bartosz Zdanowicz:
> >>>> Can you create a candump log from vcan0 to see, what's going on the =
bus?
> >>>>
> >>> On RPI after first send I got
> >>> pi@raspberrypi:~ $ candump can0
> >>>   can0  002   [8]  10 09 41 41 41 41 41 41
> >>>
> >>> After the second message I got mentioned OSError and there is no data
> >>> on candump. Sending again I received next frame:
> >>> pi@raspberrypi:~ $ candump can0
> >>>   can0  002   [8]  10 09 41 41 41 41 41 41
> >>>   can0  002   [8]  10 09 41 41 41 41 41 41
> >>>
> >>> On my local PC where I get no system Error I got one frame per every =
send:
> >>>  bartosz =EE=82=B0 ~/Work/DeltaThermal/can-isotp =EE=82=B0 =EE=82=A0 =
master =EE=82=B0 candump vcan0
> >>>   vcan0  002   [8]  10 09 41 41 41 41 41 41
> >>>   vcan0  002   [8]  10 09 41 41 41 41 41 41
> >>>   vcan0  002   [8]  10 09 41 41 41 41 41 41
> >>>   vcan0  002   [8]  10 09 41 41 41 41 41 41
> >>>   vcan0  002   [8]  10 09 41 41 41 41 41 41
> >>>   vcan0  002   [8]  10 09 41 41 41 41 41 41
> >>>>
> >>>> ...
> >>>> So how is Python getting this information?
> >>>>
> >>> In general, that's the biggest issue for me. Because in my real
> >>> application I'm using python select() and recv() on that socket. When
> >>> this error is raised, my select() on socket deduce something is
> >>> received and recv() function also throws an error. I just tried to ge=
t
> >>> a minimal example that reproduces the issue which is above. In those
> >>> cases I would expect timeout, not OSError.
> >>
> >>
> >> As expected, timeout error on missing flow control. Since it's tx side
> >> it just tells -ECOMM instead of -ETIMEDOUT .
> >>
> >> https://github.com/raspberrypi/linux/blob/rpi-5.10.y/net/can/isotp.c#L=
10
> >> https://github.com/raspberrypi/linux/blob/rpi-5.10.y/net/can/isotp.c#L=
755
> >>
> >> Is there a specific reason why you use select.select() instead of
> >> Socket.recv(timeout) / Socket.send() ?
> >>
> >> Best Regards,
> >> Patrick
> >
> > I have a seperate thread that waits and process data, since I have
> > multiple sockets opened I want to wait for any of them:
> >
> > while True:
> >     ready_sockets =3D select.select(self.sockets, [], [], self.timeout)=
[0]
> >         if not ready_sockets:
> >         logging.info("No data received")
> >         continue
> >     for socket in ready_sockets:
> >         self.process_data(socket=3Dsocket)
> >
> > In process_data I call:
> >
> > received =3D socket.recv()
> >     if received:
> >     #process data
> >
> > My main thread is sending data on those sockets:
> > schedule.every(X).seconds.do(request_that_sends_using_socket.send(),
> > socket=3Dsocket)
> >
> > So the flow is that my thread sends data to another device, and the
> > processing thread is waiting for data. When I don't send any data I
> > get only prints "No data received" which is expected cause no device
> > is responding (no device is running). When I send data (no other
> > device is running) I get an error on send AND my select() is finished
> > with an error socket inserted to ready_sockets. That means I enter
> > self.process_data() function with socket and also recv() fails. So it
> > seems it's not only that OSError is raised but also that socket is
> > somehow "invalid" because it triggers select() which should not be
> > triggered (no data was received).
>
>
> Ok,
>
> try to enable CAN_ISOTP_WAIT_TX_DONE via socket.setsockopt() .
> https://github.com/raspberrypi/linux/blob/rpi-5.10.y/net/can/isotp.c#L14
>
> https://gitlab.com/Menschel/socketcan/-/blob/master/socketcan/socketcan.p=
y#L583
>
> and wrap tx into a try-except block.
>
> try:
>     self.process_data(socket=3Dsocket)
> except OSError as e:
>     print(e)
>
> With this you actually have a chance to do error handling on tx path
> instead of hitting an already present error of the previous op.
>
> Regards,
> Patrick
>
