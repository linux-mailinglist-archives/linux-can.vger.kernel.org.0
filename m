Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 93C6F65356
	for <lists+linux-can@lfdr.de>; Thu, 11 Jul 2019 10:49:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728253AbfGKItt (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Thu, 11 Jul 2019 04:49:49 -0400
Received: from mail-oi1-f181.google.com ([209.85.167.181]:35596 "EHLO
        mail-oi1-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728247AbfGKItt (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Thu, 11 Jul 2019 04:49:49 -0400
Received: by mail-oi1-f181.google.com with SMTP id a127so3899029oii.2
        for <linux-can@vger.kernel.org>; Thu, 11 Jul 2019 01:49:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=wnY+MXoTAoouVv5x3BXOBcYmCzvME0qxvcsCEYQZzHA=;
        b=ClsfplSgab6UNZuGCYKnEwNJr89Pg8uVLiBajly6EtBtxyayMrnK9lPM44omLuE5eX
         CDqoP4VpOH815PZchOs3vZ+kqnymaBe2zFNHgXmT2ZLW1hyE+b8hMGgMbdz3kLRzA/K+
         1pIZN1REIKeiqw2XYYL3hXem46j5eCz+xKZgHDWsJc/FUOxmXbISECmDe31W+JYwpqOG
         ivpuYtX2n5qEbDQi11WF+JW4k3VC1I9EpNyag2+b6X5iZ97q6LkabyQIaXcQ9lbsVVpa
         pJJctA3ac/c2gkH0aOfwRYtnNtrV/CwmcBb3XU95hVQBzmEof3roUz0CIIrKOe4hH/k5
         1gVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wnY+MXoTAoouVv5x3BXOBcYmCzvME0qxvcsCEYQZzHA=;
        b=jn5pJKBNtiKO5tXHM4WD234TSoiSTxlAGXcILnthUYZ7gTwEwyF76YLbQ0fVqgpkJF
         B089tqAUBypAeEaeTwySFHcYhWGPjGaiVHtwgswlvTldQXW9xTAmTqnN2LL0XJZoKue/
         +6UJbS4OJDdiizAWjILy6Djewz6pyj24bVbN3VuO4jJ1aO7XvApGU1Gs5YL4WZSMfQII
         5aHyhjewcF5IXpFSWvejrgNxLqLlafts86KpfUiVOl7DNA4w21KqMJRwZD7hwFMXZvdH
         B433ZcKkVgj5RS7lUtnjHk6qPb3/eHY+xPeqfE8c6/u3c7n/PwVbMh9CYEq0DX6S25P3
         6EKQ==
X-Gm-Message-State: APjAAAUKxNmpWOETPmM3s3/f/XtWUt2+feE3vAVePWdIAmBVV86h5m02
        1mLdsgtnpFjnOHtUdjWrqHWbmnSl5LMMHLb/pUrLrQ==
X-Google-Smtp-Source: APXvYqwV5FGVKRNvHxGE5nPElp03HJz/S2ZSD7JeBDbDyLZ5V9hWOWYqc8HaZ2X9forJrc3sXOiaN1Ah9bLwzabOLnE=
X-Received: by 2002:aca:37c5:: with SMTP id e188mr1704328oia.66.1562834987987;
 Thu, 11 Jul 2019 01:49:47 -0700 (PDT)
MIME-Version: 1.0
References: <CAA7hF3zC2SrgC6JaKWzTDE6L6bP2o=zM_ZwdXgU7hwfJMraiCA@mail.gmail.com>
 <03c043d3-94e8-1865-b427-cc2a401bbd39@hartkopp.net>
In-Reply-To: <03c043d3-94e8-1865-b427-cc2a401bbd39@hartkopp.net>
From:   laurent vaudoit <laurent.vaudoit@gmail.com>
Date:   Thu, 11 Jul 2019 10:49:36 +0200
Message-ID: <CAA7hF3wReDrLcu5TtthO7NoxqK=uqzM-y6BtZJDjUVrPRz6bHg@mail.gmail.com>
Subject: Re: BCM on ethernet link
To:     Oliver Hartkopp <socketcan@hartkopp.net>
Cc:     linux-can <linux-can@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-can-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Hi Oliver,
thank you for your answer

On Thu, Jul 11, 2019 at 8:06 AM Oliver Hartkopp <socketcan@hartkopp.net> wrote:
>
> Hi Laurent,
>
> On 10/07/2019 14.45, laurent vaudoit wrote:
> > Hi all,
> > we are using CAN-BCM protocol for communication between two cpu (one
> > with Linux, the other one without OS).
> > The communication is basically exchanging some data periodically
> > between the 2 cpus (to keep data synchronous between the 2 side)
> >
> > On a futur architecture of the board, we plan to get some ethernet
> > link between the 2 CPUs instead of CAN.
> > But with still a "Linux CPU" and the other one without OS (which
> > exclude too complex implementation).
> >
> > So my idea was to write a driver inspired from can-bcm, but instead of
> > using can frame using some TCP or UDP socket.  Userspace would use
> > netlink socket to communicate with the driver, as this would not be a
> > AF_CAN driver.
> >
> > But before starting this work, i was wondering:
> > -if it is the good choice?
>
> The CAN_BCM provides a wide range of tx/rx timing modes and even
> bit-wise filtering and notifications - inspired by OSEK COM use-cases in
> vehicles. What kind of BCM functionalities are you currently using?
>
Currently we use mainly TX periodical frames with update of frame when
needed (when a data change in our application)
and also RX stuffs, with rx timeout to be inform if a frame was not received.

> Did you already take a look on "reliable datagram sockets" (RDS) for
> your requirements?
>
> https://www.kernel.org/doc/Documentation/networking/rds.txt
>
> There's also a reference to "RDMA for RDS" which could be interesting
> depending on the potential overhead for your intended data sizes.
>
> Would that fit for you?

I had a look to RDS and RDMA-RDS. This can be interesting for us, in
replacement of the CAN. But we must keep the "timing management of the
BCM).
So the idea would be to have a BCM on rds (or maybe on different
protocol, like BCM on rds or udp (for message not critciall for
example)

RDS seems interesting for the "reliable" aspect, and the frame
ordering also, to avoid having to implement it on our own.
The choice will now depend on the possibility to port it on the lwIP
stack we have on the other cpu.

Thanks again.
Best regards
Laurent
>
> Best regards,
> Oliver
>
> > -if there  is some existing implementation which could be the good
> > choice, or a better start point?
> >
> > Thanks in advance for your advice
> >
> > Regards
> > Laurent
> >
