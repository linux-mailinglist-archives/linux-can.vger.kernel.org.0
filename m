Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 564A011D8CB
	for <lists+linux-can@lfdr.de>; Thu, 12 Dec 2019 22:50:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731011AbfLLVuC (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Thu, 12 Dec 2019 16:50:02 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:35973 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730784AbfLLVuB (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Thu, 12 Dec 2019 16:50:01 -0500
Received: by mail-lj1-f196.google.com with SMTP id r19so348521ljg.3
        for <linux-can@vger.kernel.org>; Thu, 12 Dec 2019 13:50:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jk5bFxBhX7PUL81FsEDZPx549vAJojW0agpKD5s82ck=;
        b=TnKFKZwcS1jHqbmJoYSorHCIm1cQovqAMCWDsRHY0anJXb65PW+E6rDEp85wsfPWZZ
         xvAUol/kkv7jr8QAhTFTHucT1E/ieuISJHa/Xn7hxRkIEPf1CouQdKbXU1HwWobAkyuw
         ICmkcSyfAN0x1gkHUbCXsiNOKulW6cqDlX/7scUbZ/vN/RCAAHTA77sks54Czn9L3x3D
         DLBC+b5kCfhYSFzShgIplaPgEP+Ys2g9xUor9pxd2jAZ61c1QYYxNaQjN9jWEeJDyXHz
         8I/R6P+1fCS79rkWaPdQ1NgRyByEPptRy9jYlyqCineIpuPMqBy8ltkz5AjLZiz7Czq5
         pLrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jk5bFxBhX7PUL81FsEDZPx549vAJojW0agpKD5s82ck=;
        b=kVOSibEBu67Gx1HgAMELHLaEB0bidFm9Hi3LS0BCxGEreQ3zgWI+pvQ/1I/2fZzMEJ
         cgmGpeINdtSSLTpMj/VDSs8RbIxmfO5VFBzoo5crNcf9TouhYNpzrgBtvcxMG3lh+T/O
         VaUUQ9bCK499/I4HjKOnAdZRnewnrMni8MEON5rZpD20HP3UeJRSOHbMkC0Q7f8pt15+
         DPj8a8G3MqbZdHM1Br9rlxqPqpK5PSLEqxCh8zVU1tMhS2Qe2Mu4Junz94f1jONdE1PF
         ZZj1iJrsbgMZInbukNsyV3U7A/ZbY4JAWx+j8jHKgaQjefepjakpMufafijLcgWC9gf2
         +wdw==
X-Gm-Message-State: APjAAAV0XncP80UjslxRJb/hMSUxUVgD0uUfr6olVBp7s54YP9GXka/l
        to2JljjGE2EGP4UuyRRHO9P/vxsAQCmSvYG4THnYGAxn
X-Google-Smtp-Source: APXvYqwu+FHJaOqhy+PWawwQrYhbMazUSnrUxnTDIcOAaezv3uPoDbcVOYXZ1DsvWP3j6Zaw40/5JDAJgGL7FgMEmGY=
X-Received: by 2002:a05:651c:3dc:: with SMTP id f28mr7793352ljp.35.1576187399800;
 Thu, 12 Dec 2019 13:49:59 -0800 (PST)
MIME-Version: 1.0
References: <CAHChkrstQdjVcWtvX4oeUOQfZS3-G_RPWb8Y82Zvaku40dM_qA@mail.gmail.com>
 <20191206085923.GA4896@x1.vandijck-laurijssen.be> <CAHChkruBV2btmtk4FdfJ3-VvidGy5Z0hHhno4pPNuxMoDKAYtQ@mail.gmail.com>
In-Reply-To: <CAHChkruBV2btmtk4FdfJ3-VvidGy5Z0hHhno4pPNuxMoDKAYtQ@mail.gmail.com>
From:   Elenita Hinds <ecathinds@gmail.com>
Date:   Thu, 12 Dec 2019 15:49:48 -0600
Message-ID: <CAHChkrtv9+hw30ymjMu9M-CpEnT__WWz7OmVCtxwCwyH42jJyg@mail.gmail.com>
Subject: Re: can-utils jacd questions
To:     dev.kurt@vandijck-laurijssen.be
Cc:     linux-can@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-can-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Hi Kurt,

I tried using getsockname() to retrieve the source address that was
successfully claimed by jacd but was always getting 0xfe (I was
expecting it to be 0xf9 as claimed by jacd).
Is getsockname() expected to be functional for J1939 with kernel v5.4?
Is there another way to retrieving the dynamically claimed address real-time?

--elenita


>
> On Fri, Dec 6, 2019 at 2:59 AM Kurt Van Dijck
> <dev.kurt@vandijck-laurijssen.be> wrote:
> >
> > Hi,
> >
> > On do, 05 dec 2019 14:55:53 -0600, Elenita Hinds wrote:
> > > Hi all,
> > >
> > > I am hoping to re-use the can-utils' jacd as default Address Claiming
> > > daemon but runs into some issues:
> > >
> > > (1) " err(0, <string>, ...) " is called in several places, even though
> > > looking at the code logic, there is no error and the program should be
> > > able to continue. The program exits because err()  never returns.
> > > For example:
> >
> > commit 791b6de7 introduced the problem.
> > it replaced all error(x, y, sss) calls with err(y, sss)
> > but it should have become warn(y, sss) when x=0.
> >
> > Feel free to fix that.
> >
> > > (2) The socket is configured to also set the SO_BINDTODEVICE option.
> > > In our system, this requires the program to have root permissions to
> > > run but we'd rather not do this for security reasons. Is this option
> > > required? What are the side-effects if this option is not set? Can it
> > > be made optional such that the program does not exit if the
> > > setsockoption(SO_BINDTODEVICE) call fails (seems to work without it)?
> >
> > It appears on first sight that SO_BINDTODEVICE isn't strictly necessary
> > since bind() will have sockaddr_can.can_ifindex set anyway.
> > In that case, rather then ignore the result,
> > remove the call to SO_BINDTODEVICE completely.
> >
> > >
> > > (3) The claimed address is only saved to a file when the program
> > > terminates.  What is the reason for this? Can it not be saved after
> > > one is claimed already so that another process can  read it real-time
> > > if needed?
> >
> > That should not be necessary.
> > At time of writing jacd, you could consult 'ip addr show can0' to find
> > out. I'm not sure what option remained to find it.
> > I believe you can, from another program, bind() with the same name, and
> > then getsockname() will return the complete sockaddr_can with SA filled
> > in.
> >
> > > Also, in cases of a program crash or a power outage, the
> > > claimed address is still saved.
> >
> > That is a true remark.
> > Given a power outage (the program never crashes :-) ),
> > and looking at the code, +10 years later, I would now write to a temp file,
> > and rename() the file to make it an atomic operation.
> > Doing that regularly, or upon change, would be an improvement.
> >
> > Kurt
> > >
> > >
> > > Thanks in advance,
> > > Elenita
