Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ABF8D2F7C66
	for <lists+linux-can@lfdr.de>; Fri, 15 Jan 2021 14:22:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731332AbhAONVI convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-can@lfdr.de>); Fri, 15 Jan 2021 08:21:08 -0500
Received: from mail-yb1-f176.google.com ([209.85.219.176]:40346 "EHLO
        mail-yb1-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726030AbhAONVH (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Fri, 15 Jan 2021 08:21:07 -0500
Received: by mail-yb1-f176.google.com with SMTP id w24so2732618ybi.7
        for <linux-can@vger.kernel.org>; Fri, 15 Jan 2021 05:21:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=4lsJTt0uqRKngPWOp5F3hpCgNbnlyinFhXWrh7Ri3vE=;
        b=fSl2VCA/CQQj31/FJhjqz9VW45011a4dTBLDmpLBg+KUuj5RBF5BV95HZ8qHJsjfGt
         KLX8+oVHm2edHFFzbhDEP1jeli3v4mKEV+mcHUU2A2XL8F03+G2B7YIqSZxoW4wQJnoV
         9umlev7LAnvtvZCjaBHG3lbKY3JoGo5xZL2CCfJoE6jzmvR5Kpk057sl3hcJ6jQtyLHK
         Aqp1JRFvfABGH06saaTNDWUEAd6w5V5LqZbKw7r6oNRxHz3EFVWxgtb07lsb3M4WEZHf
         5G8DDXnYRT1u2yVtxb699Mphcm6UOuRzmAj598h3ZpsTBH89miuhCNTPDGYIvNZRbvis
         zRuA==
X-Gm-Message-State: AOAM532s1FN6hZIjG2fsWEjnqnASCPaangbg76OGrsaTRON/+UiSSA9/
        t0iF1TBNPzRDoa4tFRc+sMJc722swgbz1jMzXtAnDZjeVNadUw==
X-Google-Smtp-Source: ABdhPJzTItUJ1W7anddUp5QCP1vhBB9Zl9OG7dZtg/yDUiw+pk+Ir64GG6DufXJE7ergg+4WuyLykWSzneMfk5DOcOI=
X-Received: by 2002:a25:5583:: with SMTP id j125mr16225998ybb.307.1610716843405;
 Fri, 15 Jan 2021 05:20:43 -0800 (PST)
MIME-Version: 1.0
References: <20210113211410.917108-1-mkl@pengutronix.de> <20210113211410.917108-10-mkl@pengutronix.de>
 <CAMZ6Rq+Wxn_kG7rSkUrMYMqNw790SMe-UKmpUVdEA_eGcjoT+g@mail.gmail.com>
 <2f3fff1a-9a50-030b-6a29-2009c8b65b68@hartkopp.net> <CAMZ6RqLKYnGDePueN1ftL9a47Qf-ZR7bc4eLGwzCkncsD6ok2Q@mail.gmail.com>
 <75d3c8e9-acbd-09e9-e185-94833dbfb391@hartkopp.net> <CAMZ6RqKZcuJH2DPeZjgqvL2MG+LoLScHTdd4s+K9OFYDUFT2ZQ@mail.gmail.com>
 <a79041a9-a211-bd3f-42b3-35919bd12470@hartkopp.net>
In-Reply-To: <a79041a9-a211-bd3f-42b3-35919bd12470@hartkopp.net>
From:   Vincent MAILHOL <mailhol.vincent@wanadoo.fr>
Date:   Fri, 15 Jan 2021 22:20:32 +0900
Message-ID: <CAMZ6RqLYnLYySQ0ZY3tvR7zk0x6BRoBmw2gh-8pf7kt-nMbQfQ@mail.gmail.com>
Subject: Re: [net-next 09/17] can: length: can_fd_len2dlc(): simplify length calculcation
To:     Oliver Hartkopp <socketcan@hartkopp.net>
Cc:     Marc Kleine-Budde <mkl@pengutronix.de>,
        linux-can <linux-can@vger.kernel.org>, kernel@pengutronix.de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

On Fri. 15 Jan 2021 at 21:38, Oliver Hartkopp <socketcan@hartkopp.net> wrote:
>
> -DaveM
> -Jakub
> -netdev
>
> On 15.01.21 02:57, Vincent MAILHOL wrote:
>
> >> 48 */
> >> +                            /* 49 - 64 is checked in  can_fd_len2dlc() */
> >
> > Ack
> >
> >>
> >>    /* map the sanitized data length to an appropriate data length code */
> >>    u8 can_fd_len2dlc(u8 len)
> >>    {
> >> -       if (unlikely(len > 64))
> >> +       if (len > 48)
> >
> > I personally prefer the use of macros instead of hardcoded values. 48 is the
> > last index of the table, i.e. it is ARRAY_SIZE(len2dlc) - 1.
>
> In general I'm with you here.
>
> > For me, it is like doing this:
> > for (i = 0; i <= harcoded_value_representing_last_index_of_array; i++)
> > instead of this:
> > for (i = 0; i < ARRAY_SIZE(array); i++)
> >
> > Definitely prefer the later and (len >= ARRAY_SIZE(len2dlc)) is nothing less
> > than the negation of the i < ARRAY_SIZE(array) that we usually see in a for
> > loop.
> >
> > I recognize below patterns to be correct:
> >     i < ARRAY_SIZE(array): check that variable is inbound.
> >     i >= ARRAY_SIZE(array): check that variable is outbound.
> >
> > Anything which deviates from those patterns is fishy and it is actually how
> > I spotted the bug.
> >
> > If we don’t use ARRAY_SIZE() we lose that recognizable pattern and we need
> > to be aware of the actual content of len2dlc[] to understand the code.
> > (And I know that the table is just above the function and that this makes my
> > argument weaker).
> >
> > So IMO, checks done against the array size should use the ARRAY_SIZE() macro
> > in order 1/ to make it a recognizable pattern and 2/ to make it work regardless
> > of the actual size of the table (i.e. no hardcoded value).
>
> The problem is NOT that we make sure to access this array correctly.
>
> This particular array is no set of arbitrary values that may be extended
> later on BUT it is a 'translation map' for defined length values which
> will never change.
>
> Therefore ARRAY_SIZE(array) hides the fact that every length value
> "greater than 48" results to a DLC of 15.
>
> For that reason my former code was very clear:
>
> 1. It had a table that mapped 0 .. 64 to a DLC
> 2. It had a test for '> 64' as sanity test.
>
> Now the sanity test is gone and mixed up with the mapping of length
> values - and finally with ARRAY_SIZE(whatever) which doesn't give a hint
> why this is checked.
>
> We are writing code to be understandable for the reader and the
> suggested 'improvement' which saves 16 bytes does exactly the opposite.

You did not convince me but I will not argue more on the use of
ARRAY_SIZE(). I do not want to trigger an endless discussion :)

If we take the code as being understandable as top priority, then
I would suggest to remove the len2dlc[] array and use the GNU
case range extension (which is supported in the kernel):

/* map the data length to an appropriate data length code */
u8 can_fd_len2dlc(u8 len)
{
    switch(len) {
    case 0 ... 8:
        return len;
    case 9 ... 12:
        return 9;
    case 13 ... 16:
        return 10;
    case 17 ... 20:
        return 11;
    case 21 ... 24:
        return 12;
    case 25 ... 32:
        return 13;
    case 33 ... 48:
        return 14;
    case 49 ... 64:
    default:
        return CANFD_MAX_DLC;
    }
}

And we will just leave the optimizations in the hand of the compiler.

> >
> >>                   return 0xF;
> >
> > I would also prefer to use the CANFD_MAX_DLC macro here.
>
> Ack. Me too. Just seen that after pressing the 'send' button :-/

No problem :)
This also happens to me too often.

Yours sincerely,
Vincent
