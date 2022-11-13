Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C1923626FC4
	for <lists+linux-can@lfdr.de>; Sun, 13 Nov 2022 14:36:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234973AbiKMNgW (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Sun, 13 Nov 2022 08:36:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231972AbiKMNgV (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Sun, 13 Nov 2022 08:36:21 -0500
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27EBD10551
        for <linux-can@vger.kernel.org>; Sun, 13 Nov 2022 05:36:21 -0800 (PST)
Received: by mail-pj1-f45.google.com with SMTP id z5-20020a17090a8b8500b00210a3a2364fso10898932pjn.0
        for <linux-can@vger.kernel.org>; Sun, 13 Nov 2022 05:36:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EY31RpqZM5oak2LzRdkoL2CKTbaQ2MlV39BsluqWOGs=;
        b=p8XXMOn0YEZc2q4SOjFIAjxvhdH4PUNunTrd1Mw0xOmCoBvHZfpIJ4vm8e0/m8ooqr
         MzqiyuEE15+xxQAP76bnjdkY/Mt/igPw41BBW88UCg04KfhiINFZZ5kygqGKyhFJXvqm
         b7TNxzrn2GJiY8Qw9t5CnRgSfx/VRqdqQY3ot4XP7TEUUmdvwdtr210Fw96fE79/VMmj
         XwwD06oQPH/EDnBKKIeN1/7uc6nY5jupOp1M9Nt0gdaG+6bGQyjIdVCj1v+pBzFLGHxA
         pUOB2WOlwKVlYbhPbARXLJoifupRd8udrlt/FRecgCRK2lk6DXR8IsJWSKaTrfS53I9l
         Mlrw==
X-Gm-Message-State: ANoB5pmL0yuPcocciJbUHOPR6cffTIIIYMqA17SJJyHa2XicGvxvnXev
        ZIIIUatr3mZGoaYAnfhvd52Bti1EYB1uH9+5hxfs8GEJ2bYCEQ==
X-Google-Smtp-Source: AA0mqf5/iCAc+YTIYd6wPpwGMhKfnyBfyGbb9yhkFM3gH0TG0C4yST/PS8EeoDipW7KQyz4UtCTmqTUKedDq6HCiyuM=
X-Received: by 2002:a17:90a:520e:b0:213:2e97:5ea4 with SMTP id
 v14-20020a17090a520e00b002132e975ea4mr9989827pjh.92.1668346580567; Sun, 13
 Nov 2022 05:36:20 -0800 (PST)
MIME-Version: 1.0
References: <20221113085321.87910-1-mailhol.vincent@wanadoo.fr>
 <20221113085321.87910-3-mailhol.vincent@wanadoo.fr> <20221113120402.ymdyylxm3avhxsaw@pengutronix.de>
In-Reply-To: <20221113120402.ymdyylxm3avhxsaw@pengutronix.de>
From:   Vincent MAILHOL <mailhol.vincent@wanadoo.fr>
Date:   Sun, 13 Nov 2022 22:36:09 +0900
Message-ID: <CAMZ6RqKXhqw8uUtqeoBG0jys6OqzPFfa2E1O9VTBuVD9-5tbkg@mail.gmail.com>
Subject: Re: [PATCH can-utils-dev 2/5] lib: add pr_debug() macro
To:     Marc Kleine-Budde <mkl@pengutronix.de>
Cc:     linux-can@vger.kernel.org, Oliver Hartkopp <socketcan@hartkopp.net>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

On Sun. 13 Nov. 2022 at 21:18, Marc Kleine-Budde <mkl@pengutronix.de> wrote:
> On 13.11.2022 17:53:18, Vincent Mailhol wrote:
> > Add the pr_debug() macro so that replace:
> >
> >   #ifdef DEBUG
> >       printf("foo");
> >   #endif
> >
> > by:
> >
> >       pr_debug("foo");
> >
> > Apply the pr_debug() macro wherever relevant.
> >
> > Currently, there is no consensus whether debug messages should be
> > printed on stdout or stderr. Most of the modules: canbusload.c,
> > candump.c and canlogserver.c use stdout but
> > mcp251xfd/mcp251xfd-dev-coredump.c uses stderr. Harmonize the behavior
> > by following the major trend and make
> > mcp251xfd/mcp251xfd-dev-coredump.c also output to stdout.
> >
> > CC: Marc Kleine-Budde <mkl@pengutronix.de>
> > Signed-off-by: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
> > ---
> > @Marc, was there any reasons to print debug information to stderr and
> > not stdout in mcp251xfd-dev-coredump.c?
>
> No real reason, just gut feeling. There are at least 2 differences: IIRC
> stdout is line buffered, it will not write to console until a newline.
> stderr will print even if there is no newline.

Something I learned today!

I thought that all the buffering was done by the libc (i.e.
write(stdout, "foo") is not buffered while fprint(stdout, "foo") is.
But after investigation, you are right. Indeed, 'man 3 stdout' says:

  The stream stderr is unbuffered.  The stream stdout is
  line-buffered when it points to a terminal.  Partial lines will
  not appear until fflush(3) or exit(3) is called, or a newline
  is printed.  This can produce unexpected results, especially
  with debugging output.

> The other one is: If
> use/parse the stdout if the program you're debugging (i.e. in a pipe)
> the debug output on stdout will interfere with the regular output.

I agree. I am fine with putting the debug to stderr or to prefix the
stdout output with "debug: " or something similar so that it can be
easily filtered (usually, I do the latter). The only things which
really bothered me was the #DEBUG everywhere and the inconsistency of
stdout vs. stderr. As long as those things are fixed, anything else is
OK for me.

By default, I just did the most concervative change: everyone prints
to stdout and I did not add a prefix.

> > diff --git a/lib.h b/lib.h
> > index a4d3ce5..1cb1dd4 100644
> > --- a/lib.h
> > +++ b/lib.h
> > @@ -47,6 +47,12 @@
> >
> >  #include <stdio.h>
> >
> > +#ifdef DEBUG
> > +#define pr_debug(fmt, args...) printf(fmt, ##args)
> > +#else
> > +#define pr_debug(...)
> > +#endif
>
> With this change if DEBUG is not defined, the print format strings are
> not checked. This is why I have the pr_no macro. Side node: For functions
> you can use __attribute__ ((format (printf, 2, 3))).

I never thought of that. Now I understand why you put a pr_no macro.
I knew about the print attribute and I prefer to use it instead of the
pr_no to make it more explicit that this is only for compiler check.
Now, I am thinking to do:

  #ifdef DEBUG
  #define pr_debug(fmt, args...) printf(fmt, ##args)
  #else
  __attribute__((format (printf, 1, 2)))
  static inline int pr_debug(const char* fmt, ...) {return 0;}
  #endif

> > +
> >  /* buffer sizes for CAN frame string representations */
> >
> >  #define CL_ID (sizeof("12345678##1"))
> > diff --git a/mcp251xfd/mcp251xfd-dev-coredump.c b/mcp251xfd/mcp251xfd-dev-coredump.c
> > index 5874d24..422900f 100644
> > --- a/mcp251xfd/mcp251xfd-dev-coredump.c
> > +++ b/mcp251xfd/mcp251xfd-dev-coredump.c
> > @@ -17,18 +17,10 @@
> >
> >  #include <linux/kernel.h>
> >
> > +#include "../lib.h"
> >  #include "mcp251xfd.h"
> >  #include "mcp251xfd-dump-userspace.h"
> >
> > -#define pr_err(fmt, args...)    fprintf(stderr, fmt, ##args)
> > -#define pr_no(fmt, args...)     while (0) { fprintf(stdout, fmt, ##args); }
> > -
> > -#ifdef DEBUG
> > -#define pr_debug(fmt, args...) pr_err(fmt, ##args)
> > -#else
> > -#define pr_debug(fmt, args...) pr_no(fmt, ##args)
> > -#endif
> > -
> >
> >  struct mcp251xfd_dump_iter {
> >       const void *start;
> > diff --git a/slcanpty.c b/slcanpty.c
> > index 4ac9e8a..3eba07e 100644
> > --- a/slcanpty.c
> > +++ b/slcanpty.c
> > @@ -49,8 +49,6 @@
> >  #define SLC_MTU (sizeof("T1111222281122334455667788EA5F\r")+1)
> >  #define DEVICE_NAME_PTMX "/dev/ptmx"
> >
> > -#define DEBUG
>
> For completeness mention that you switch off debugging in slcanpty.c.

Ack.


Yours sincerely,
Vincent Mailhol
