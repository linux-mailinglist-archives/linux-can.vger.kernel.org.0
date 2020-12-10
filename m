Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A26562D6B22
	for <lists+linux-can@lfdr.de>; Fri, 11 Dec 2020 00:38:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404466AbgLJWba (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Thu, 10 Dec 2020 17:31:30 -0500
Received: from mail-ed1-f47.google.com ([209.85.208.47]:36005 "EHLO
        mail-ed1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405144AbgLJW21 (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Thu, 10 Dec 2020 17:28:27 -0500
Received: by mail-ed1-f47.google.com with SMTP id b2so7301101edm.3
        for <linux-can@vger.kernel.org>; Thu, 10 Dec 2020 14:28:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=PsFPGKcfY66tMjPy/Du5hgcdhAkI+DEblpWE9pk07FY=;
        b=vRGLuniIExNDg+LhG9ittm62+ynmWqAWButnP0OYSWbItkC20m6Ad7Cyyj200AtzPF
         1Yh8rpIyme3wFDeewYSczHNXsqSIumeSxWXYAfTwL/2L2DIhirakHjgaQmtErAbOMpzx
         Yoi0CV4o+NXhXr5kqMPHCLnF+zkSTND9XUZjWC6f7LF40vyfeYcMx7mELmilHCbzgBVT
         UHNedK67wYcoYf4IAizU9JeFsoHblZ5eHNrNyzgtz1ANk6tzPDwySXGNswc02VkvUL4W
         ATMIpzHU4lKQ7ca9zfTByq/FHUdzHT+LtWetbSZ1NCJBIYgpAV1xY6q9a2n0VHpYFqkm
         tT9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PsFPGKcfY66tMjPy/Du5hgcdhAkI+DEblpWE9pk07FY=;
        b=XPBrglaXPegXt8/hqotXQl6aUubqm2Uk9rNuuJynZrZ9GgY6XSJuvl2CQwQQ+t23nP
         hA03yhWjRDvVL6hNo1AFTAqjEy+O2OpcOKtMEy73OHihZHKChf+4W5q1yo6KB4Neb8LJ
         A78u6rePH+xZrOP/mZH+wEIRBT5feIy9Sw6BIMAG0TxVLL1G4oMFKiEUBUv40EnjYzM9
         W4uq4IfoOdakIr/D/i25j4Bw7TvMpxUSI6DJqWB/F0/XKb3hlcZZeBhOhaQzvnfEjxrW
         uRwOqwmvxq+iibMNLIfrYIYRW6/d9DXYY6pmqstboUjlYD3zzUbXosd8rmogT9E0dO6s
         bSug==
X-Gm-Message-State: AOAM531e6x4ecaquqb1vIRw2FHJKUp+Oke3tp/Mx1sZmuN5aayU33X2U
        J+xfHX12+j2/h/ZQHWuMIaRrpIP/S/9qxAh/Mzla99409Vk=
X-Google-Smtp-Source: ABdhPJz3jLJbQr7zWWpgUqi4p8POUMaLGD2Oz940+y1mnqiGj8UtqqLWbNXbQnxcDk8KXw64Gl1V9/MqecvJB6MTBVM=
X-Received: by 2002:a05:6402:1816:: with SMTP id g22mr9092627edy.80.1607639205194;
 Thu, 10 Dec 2020 14:26:45 -0800 (PST)
MIME-Version: 1.0
References: <CABxGUThzGkCerMBTuA95TCs49hjHg+O-u3Z_c8=RZGJ8bVQjRQ@mail.gmail.com>
 <a13ab81e-ad20-0405-6935-ecd748233bc5@pengutronix.de> <CABxGUTjcynztDDoB=OVAXa4SYig3Ju+Y8wHmg-oVxs-b5n2SqA@mail.gmail.com>
 <60b5b0e3-bdb3-e1c5-b4ac-78f955b5374a@pengutronix.de>
In-Reply-To: <60b5b0e3-bdb3-e1c5-b4ac-78f955b5374a@pengutronix.de>
From:   Christian Gagneraud <chgans@gmail.com>
Date:   Fri, 11 Dec 2020 11:26:33 +1300
Message-ID: <CABxGUTi+nCvGA+tAabb6XLhwBx9_ZqVM3KwS-74jS8swApPZPg@mail.gmail.com>
Subject: Re: New USB driver, looking for advice
To:     Marc Kleine-Budde <mkl@pengutronix.de>
Cc:     linux-can <linux-can@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

On Thu, 10 Dec 2020 at 20:36, Marc Kleine-Budde <mkl@pengutronix.de> wrote:
> >>> I have the feeling that current drivers are for devices that can
> >>> return data by just scheduling read transfer.
> >>
> >> Yes. Current drivers get notified by the device, if there is a CAN frame waiting.
> >>
> >>> Anyone would have a clue on how these drivers work, and if my device
> >>> is really that special?
> >>
> >> Yes, your device is quite special :)
> >
> > Hum, no good news...
> >
> > The device has 3 interfaces:
> > - keyboard
> > - mouse
> > - device specific (CAN)
>
> I think you have to implement the polling yourself. Start a transfer on
> ndo_open(). In the completion handler handle the received data. In case you have
> recieved a CAN frame, submit a new transfer in case you haven't received data
> yet, schedule delayed work with a delay, e.g. 1ms. Once you have that running
> you have fine tune the number of running transfers and delays.

Thanks Marc for the hints.
I'll look into that, this will certainly take time, I'm not in a rush.
Full disclosure: I am actually an employee of Navico (the manufacturer
of the device), I'm currently waiting for approval to publish code
related to that device. This shouldn't be an issue, I just need the
administrative work done.

Chris
