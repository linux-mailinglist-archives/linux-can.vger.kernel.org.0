Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4756D375CD7
	for <lists+linux-can@lfdr.de>; Thu,  6 May 2021 23:28:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230187AbhEFV3Y (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Thu, 6 May 2021 17:29:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229572AbhEFV3X (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Thu, 6 May 2021 17:29:23 -0400
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5326C061574
        for <linux-can@vger.kernel.org>; Thu,  6 May 2021 14:28:24 -0700 (PDT)
Received: by mail-lj1-x22a.google.com with SMTP id p12so8943091ljg.1
        for <linux-can@vger.kernel.org>; Thu, 06 May 2021 14:28:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=aGUZXAAJIwy+lceaiPdDUxztlPv0lo/Th3BLJIDBTTc=;
        b=FU++/JzsUy3jziNSojTKEwlqymTBd9m5MzJSyJ7gEnWaF2RyitDijh4TSGOrPyA97q
         8O3hvkWdA/XBI8qehaNmW8rjrxLXXPqrE/+JiOSa6+OBQDpHMOdde4x4c7BxHvYszkjk
         xG8agA+OdtmpXZCn2jqF2cDVme7nFdCGpYUHvN6jr/vJfJdwSTtJRNPaOXldW2NGNZ3H
         fVQqVmn7yPEM0btM1P37oQ5sluZnyDzVsMcfIyzlFryk2ocNLQeSdDbHfS7T4DRHb8qY
         uM0twuLH6swBtqh6YbJMVUGiS/Zx5hAEYaU9ADlEmMMTpuxZ1mCNpPyHJQ2ayy0PUJtD
         h6fQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=aGUZXAAJIwy+lceaiPdDUxztlPv0lo/Th3BLJIDBTTc=;
        b=CtYQKW5IFsLUEfy4jWtFTR32ZfSH4ZYY7bgwmQqdV45Kew3oiGswy2CjSdRyPUbkTT
         Jg/gXvicX0u/AVqxxks1/EtFan3PBbWxzAPbKfWh6+m9yO8XCmKJI1F4Imxkr7KY56zQ
         u5te8yAeDeMHnKKbx6BuWjZCyC5nlhhGidZIqOqCmoaKapskONEjCWfTkIz4qbSsKpYD
         kr7rCuf8IjjS0rZtzftBcf+rfj3Z6lUl2A2u/KkEee+z6ubplRsXMTLEIi9DPreeMWwt
         6F6SCOvEMZ23hgupCjHxyA+q8/V9b+miVmHG+0y46ZTOycNoE6GEeQhNPVES4tUZEUVZ
         HoNQ==
X-Gm-Message-State: AOAM532iqJaX4uUliAoa7tcHbrIPYaYK12umEclll/6gW9wdPFKcxFPd
        zK3F5xsPN57e79WdA0wpmYLWd59v1uuLx8BvSGSm3jm1AkHDGw==
X-Google-Smtp-Source: ABdhPJwAWeBtk4mcQQvxZx4eMuNWElSDGn3W3G0sqMeSzHtan7rtLUiJO12mY39s7ablhZSpLTiN+T5ZEAgKKLfaM5U=
X-Received: by 2002:a2e:a40d:: with SMTP id p13mr5255208ljn.8.1620336502969;
 Thu, 06 May 2021 14:28:22 -0700 (PDT)
MIME-Version: 1.0
References: <CAERdor5nY73X4qip=up8fNU=xT+H7r2XnKiob66=4DxovkBiGw@mail.gmail.com>
 <a7df697c-b6d3-1894-dcc6-672698caa19a@hartkopp.net>
In-Reply-To: <a7df697c-b6d3-1894-dcc6-672698caa19a@hartkopp.net>
From:   Bartosz Zdanowicz <zdanowiczb@gmail.com>
Date:   Thu, 6 May 2021 23:28:11 +0200
Message-ID: <CAERdor5o6yKq1J-hBbjiBtU63OkxhijKifO0OEBt21ASKhCXuw@mail.gmail.com>
Subject: Re: CAN ISO-TP
To:     Oliver Hartkopp <socketcan@hartkopp.net>
Cc:     linux-can <linux-can@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

czw., 6 maj 2021 o 20:01 Oliver Hartkopp <socketcan@hartkopp.net> napisa=C5=
=82(a):
>
> +CC Linux CAN ML
>
> Hi Bartosz,
>
> On 06.05.21 19:28, Bartosz Zdanowicz wrote:
>
> > I'm not sure if you prefer e-mail message, but I don't want to raise
> > GitHub Issue yet.
> >
>
> Raising a GitHub issue is generally a good idea as it may help other
> people too.
>
> But asking on the Linux CAN mailing list is even better ;-)
>
Sure, thanks! :)
>
> > I'm using module that you are an author and it's working perfectly on m=
y
> > local PC. I'm using Ubuntu with Kernel version 5.4.0-70-generic
>
> Which branch did you use? master branch?
>
I'm using a master branch on my local PC. I was not able to find which
version of the codebase specific kernel of RaspberryPI is using.
>
> > I tried to simplify example where I use python wrappers and other thing=
s
> > and manage to get minimal example:
> >
> > /import socket as s
> > socket =3D s.socket(s.AF_CAN, s.SOCK_DGRAM, s.CAN_ISOTP)
> > socket.bind(("vcan0", 1, 2))
> > socket.send(b"AAAAAAAAA")
> > socket.send(b"AAAAAAAAA")/
> > /
> > /
> > It's working perfectly, even if I don't open receiver socket. It just
> > timeout and there is no issue.
>
> But this should raise an issue as you send 9 bytes which would need
> segmentation.
>
> This should only work with CAN FD frames with a single frame.
>
So when no receiver socket is opened, it should already raise an
exception after sending more than 8 bytes? I'm using standard CAN
frames (it's virtual can locally but 8 bytes per frame)
>
> Can you create a candump log from vcan0 to see, what's going on the bus?
>
On RPI after first send I got
pi@raspberrypi:~ $ candump can0
  can0  002   [8]  10 09 41 41 41 41 41 41

After the second message I got mentioned OSError and there is no data
on candump. Sending again I received next frame:
pi@raspberrypi:~ $ candump can0
  can0  002   [8]  10 09 41 41 41 41 41 41
  can0  002   [8]  10 09 41 41 41 41 41 41

On my local PC where I get no system Error I got one frame per every send:
 bartosz =EE=82=B0 ~/Work/DeltaThermal/can-isotp =EE=82=B0 =EE=82=A0 master=
 =EE=82=B0 candump vcan0
  vcan0  002   [8]  10 09 41 41 41 41 41 41
  vcan0  002   [8]  10 09 41 41 41 41 41 41
  vcan0  002   [8]  10 09 41 41 41 41 41 41
  vcan0  002   [8]  10 09 41 41 41 41 41 41
  vcan0  002   [8]  10 09 41 41 41 41 41 41
  vcan0  002   [8]  10 09 41 41 41 41 41 41
>
> > I tried to run my application on RPI, when module is already included
> > with kernel version Linux raspberrypi 5.10.17-v7+ #1403 SMP Mon Feb 22
> > 11:29:51 GMT 2021 armv7l GNU/Linux.
> >
> > I run above code and first send is working (no receiver as well),
> > timeout, but second one is printing
> >
> > OSError: [Errno 70] Communication error on send
>
> That's interesting! We are currently working on creating that kind of
> feedback.
>
> https://lore.kernel.org/linux-can/97e2ddd5-cc8b-9c7b-6198-2eceee39dfd4@ha=
rtkopp.net/
>
> So how is Python getting this information?
>
In general, that's the biggest issue for me. Because in my real
application I'm using python select() and recv() on that socket. When
this error is raised, my select() on socket deduce something is
received and recv() function also throws an error. I just tried to get
a minimal example that reproduces the issue which is above. In those
cases I would expect timeout, not OSError.
>
> Regards,
> Oliver
>
> >
> > And pattern is repeated. So sending next data works and after those
> > error appears. It seems like sending new data somehow ,,validate"
> > previous send. When I create other socket that reads data it's working
> > perfectly. The issue is, somehow in our architecture other device might
> > be unavailable.
> >
> > I checked also dmesg and there is no tips. Is it any known issue, or
> > maybe it's expected?
> >
> > Thanks in advance for you reply.
> >
> > Best Regards,
> > Bartosz Zdanowicz
