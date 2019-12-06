Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AB286115607
	for <lists+linux-can@lfdr.de>; Fri,  6 Dec 2019 18:03:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726298AbfLFRDE (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Fri, 6 Dec 2019 12:03:04 -0500
Received: from mail-lj1-f181.google.com ([209.85.208.181]:40212 "EHLO
        mail-lj1-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726287AbfLFRDE (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Fri, 6 Dec 2019 12:03:04 -0500
Received: by mail-lj1-f181.google.com with SMTP id s22so8389151ljs.7
        for <linux-can@vger.kernel.org>; Fri, 06 Dec 2019 09:03:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=OaTBnXK81O8v20OQ6UxmlRHrtdQThgc4ZR0QRRYvdLY=;
        b=Nqcfe+vEu7hB0JEDcO8Tz6bgvnRkYMpUVvDirUGtPqudnArb/IgNIyFdzU3uLqw79x
         voM1BZhBCjKZ+5PKi/kcUKceB8ljuxz2FUnJVLB1/PTwZTd0qAcZkkNwxw/2xxYKXLgy
         8hesGK663P/lsqX1Tiv2lm8RX8Bb4sj5UlvVKBmJou9iaJ1loNqtokCY2XYKEEbBxb35
         h5/8kzdYMCOR+IleUT9OQv9XZXmMHlkGCGZ+4EyFu4lYuqSj/HvU2ZtWrU5ogVdhlAKV
         sHQUaTiLzMGjTl3RhGXjDXpAztHwcVh+2V3gshj2cn+/EdBfTmUW/cuKWhtfWiX54lDz
         2AHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=OaTBnXK81O8v20OQ6UxmlRHrtdQThgc4ZR0QRRYvdLY=;
        b=RyesiWpi7QoIp7T6P1bveq6KYHmbR1d/sqAS1AhJkaNvIXUuuTi88u4esaC3q6BGvu
         Q6xUpUSQ6EIHrUvtrJAFJ6gXHZ0k1EShlgyrmhy/QgqcirWuB1OvQDhh7RFTN+7IPyvu
         +R9/Wzk0Vl/EDFkOqvGTlKSXg5YJyD/VwbUKD/fYqm/daDSLIDqMU6bchavAEZbAyyqp
         f4MNsBHrGTH1rMCHA7wKzFbQQQzoTzuM+6xaFr4kgaEvX7XX1xRuwPy4GRTJl+Tq6rBA
         5fcu9WQ0bjTxVtdqI5vyOSziczDlA9KrIwO7SaG7nIzf2uSFM3USHx3W7VFflD/Lak58
         u3hQ==
X-Gm-Message-State: APjAAAXXTEQWkmGDXsGWaPJBnxmvihcwLOc1V3G7VBejMf5VTIHpsaYv
        4or6xq5gzc4is6uVYOhh9KicfJlp5oHTz9LNuz2BVg==
X-Google-Smtp-Source: APXvYqyBvmjjUOXnUccMr6W7xNj6rWE/npdjsV+tvjfxsARNocHbRQppxCugV8vXIhDfvo2Cn+0fCpgs+e5tbENSjjo=
X-Received: by 2002:a2e:b0db:: with SMTP id g27mr9495719ljl.74.1575651781945;
 Fri, 06 Dec 2019 09:03:01 -0800 (PST)
MIME-Version: 1.0
References: <CAHChkrstQdjVcWtvX4oeUOQfZS3-G_RPWb8Y82Zvaku40dM_qA@mail.gmail.com>
 <20191206085923.GA4896@x1.vandijck-laurijssen.be>
In-Reply-To: <20191206085923.GA4896@x1.vandijck-laurijssen.be>
From:   Elenita Hinds <ecathinds@gmail.com>
Date:   Fri, 6 Dec 2019 11:02:50 -0600
Message-ID: <CAHChkruBV2btmtk4FdfJ3-VvidGy5Z0hHhno4pPNuxMoDKAYtQ@mail.gmail.com>
Subject: Re: can-utils jacd questions
To:     dev.kurt@vandijck-laurijssen.be
Cc:     linux-can@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-can-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Thanks, Kurt.

I'll go ahead and make the updates.

-- elenita

On Fri, Dec 6, 2019 at 2:59 AM Kurt Van Dijck
<dev.kurt@vandijck-laurijssen.be> wrote:
>
> Hi,
>
> On do, 05 dec 2019 14:55:53 -0600, Elenita Hinds wrote:
> > Hi all,
> >
> > I am hoping to re-use the can-utils' jacd as default Address Claiming
> > daemon but runs into some issues:
> >
> > (1) " err(0, <string>, ...) " is called in several places, even though
> > looking at the code logic, there is no error and the program should be
> > able to continue. The program exits because err()  never returns.
> > For example:
>
> commit 791b6de7 introduced the problem.
> it replaced all error(x, y, sss) calls with err(y, sss)
> but it should have become warn(y, sss) when x=0.
>
> Feel free to fix that.
>
> > (2) The socket is configured to also set the SO_BINDTODEVICE option.
> > In our system, this requires the program to have root permissions to
> > run but we'd rather not do this for security reasons. Is this option
> > required? What are the side-effects if this option is not set? Can it
> > be made optional such that the program does not exit if the
> > setsockoption(SO_BINDTODEVICE) call fails (seems to work without it)?
>
> It appears on first sight that SO_BINDTODEVICE isn't strictly necessary
> since bind() will have sockaddr_can.can_ifindex set anyway.
> In that case, rather then ignore the result,
> remove the call to SO_BINDTODEVICE completely.
>
> >
> > (3) The claimed address is only saved to a file when the program
> > terminates.  What is the reason for this? Can it not be saved after
> > one is claimed already so that another process can  read it real-time
> > if needed?
>
> That should not be necessary.
> At time of writing jacd, you could consult 'ip addr show can0' to find
> out. I'm not sure what option remained to find it.
> I believe you can, from another program, bind() with the same name, and
> then getsockname() will return the complete sockaddr_can with SA filled
> in.
>
> > Also, in cases of a program crash or a power outage, the
> > claimed address is still saved.
>
> That is a true remark.
> Given a power outage (the program never crashes :-) ),
> and looking at the code, +10 years later, I would now write to a temp file,
> and rename() the file to make it an atomic operation.
> Doing that regularly, or upon change, would be an improvement.
>
> Kurt
> >
> >
> > Thanks in advance,
> > Elenita
