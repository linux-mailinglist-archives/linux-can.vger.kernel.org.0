Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 58D4EF1719
	for <lists+linux-can@lfdr.de>; Wed,  6 Nov 2019 14:29:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730949AbfKFN3m (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Wed, 6 Nov 2019 08:29:42 -0500
Received: from mail-il1-f196.google.com ([209.85.166.196]:44944 "EHLO
        mail-il1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730551AbfKFN3m (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Wed, 6 Nov 2019 08:29:42 -0500
Received: by mail-il1-f196.google.com with SMTP id i6so3142125ilr.11
        for <linux-can@vger.kernel.org>; Wed, 06 Nov 2019 05:29:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=cS3vZhi3jJfBHxtvAhMKqLWaDsvd9wJHnJkm0Wm7p4o=;
        b=LyJVXPmYudhqf0L+QQNQC/rxVAmEqW6PDgLCdqFhDrUyGmqLiwWMlTfr1wJR/Te1yN
         HyfjILEy+GTf2EfoLWlwEVZ5r371cyNZtoe0hOvDxt9l27rgZwiyFmr3Tc4AehH5TtWM
         28/DEjSvRGLq1/Q52YAMQo6aUKMgZ0ZiAPtYhoiv20nnFL09ZHkUFof+OeY+v4TbdFZT
         kS13isXc2NbDlTdFSrDKiRWGCdzhITpTrA9/Q0HbbRgjrsi5ONWiCo9BLpsoZHeBSQMf
         05V7pTxPWl4qimkkWTMyCyZTKu3+uPdr8UKCxXGj66NsiP5zvEIStm6vgIn7TCIIzEYh
         XVog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=cS3vZhi3jJfBHxtvAhMKqLWaDsvd9wJHnJkm0Wm7p4o=;
        b=LHnS6MNdwwSpnXxFRRaWXolCZMkhqKUkoX3zV8ssqeOIDiD7nWHQq4w3ERbAXIwPux
         dyoAYWOcJUoG9qJafsAvpZpiV3lYbPacfljK85Dg8g1P//NS8kJeEGlgUQqu4hFLy1BY
         hdHOiwrsEJm4FAA23jCD/MjkeexGTJ2gwC/qwC1obfWlXVRWiYhRIcLw7wX4inQZFowr
         yRuSoVYKfkFhosfSyqDpy6FDrJxJXOFr6F50x0IJMwhsDEqPgLpT9G7TSlenHq56lf2q
         Ieqa4GHHh0uPWRjF+4TemgaBS4dCzWpmvhLYS22jS7zFpPzR59jRR9E5t+kdOh3lynHU
         1uBw==
X-Gm-Message-State: APjAAAVpcKLZiQAS2WuAmQsPJdk+GbxB4QW6l5TvtT64y0Es2xyNNx95
        TG2bVkj3EeLY+NB2kSSvFj5O7r1AXvMaS/2v/6dFFIp6
X-Google-Smtp-Source: APXvYqyIB2QWR531GADX3zM7Hw/oZ3PjQr0HYEhhEEcJVzcRLQOXrqEKEFRLzu7pE+BLn23CSEKCilYbqyG0nsHvqZE=
X-Received: by 2002:a92:16d4:: with SMTP id 81mr2672732ilw.198.1573046981171;
 Wed, 06 Nov 2019 05:29:41 -0800 (PST)
MIME-Version: 1.0
References: <CAN1pBYmvcxFoM_zPZYeoUociEJBYHEfMmnspLfSL2=BKiu4Wbg@mail.gmail.com>
 <20191106100715.GA10500@pengutronix.de>
In-Reply-To: <20191106100715.GA10500@pengutronix.de>
From:   =?UTF-8?Q?Cl=C3=A9ment_VIEL?= <vielclement@gmail.com>
Date:   Wed, 6 Nov 2019 14:29:29 +0100
Message-ID: <CAN1pBYnQBsNrSxuB3Ety08_ecQtZLpQAE-MN9BtwZ4HtnMiuUw@mail.gmail.com>
Subject: Re: synchronization problem on old version of j1939 stack
To:     Oleksij Rempel <o.rempel@pengutronix.de>
Cc:     linux-can@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-can-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Hi Oleksij
>
> Hi Cl=C3=A9ment,
>
> On Wed, Nov 06, 2019 at 10:32:48AM +0100, Cl=C3=A9ment VIEL wrote:
> > Hi all,
> >
> > I am currently using a very old version of the j1939 stack. It was
> > forked in 2014 and now running on a custom 3.10.17 kernel. We are
> > experiencing a lot of synchronization problem that cause kernel
> > panics.
> > Doing diffs with the mainline version shows that the whole stack has
> > changed a lot, I noticed, this first mail concerning j1939 on this
> > mailing list is from 2018.
> >  My question is very simple. Did synchronization problems were
> > encountered and corrected before the j1939 entered the mainline ?
>
> What do you mean with synchronization problem? Do you have a tests case
> for your issue?

By synchronization I mean that in the old version of j1939 it seems
that the some functions
and pointers are not fully protected by locks whereas in the mainline
version it seems that there are more
locking.

I give you an example. In the mainline version, there is a function
named j1939_ecu_get_by_name that calls ecu_find_by_name_locked
whereas in our version there just a function named j1939_ecu_find_by_name.

In the mailine, there is a lot of lock protection that lacks in our version=
.

I do not have test case because its a client that feeds  us with these
kernel panics and they cannot tell what manipulation they did.

I hope its more clear now.

Regards


> Regards,
> Oleksij
>
> --
> Pengutronix e.K.                           |                             =
|
> Industrial Linux Solutions                 | http://www.pengutronix.de/  =
|
> Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    =
|
> Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 =
|



--=20
----
Clement Viel
Tel : +33688431961
-----
