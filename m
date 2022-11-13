Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 52731626FAD
	for <lists+linux-can@lfdr.de>; Sun, 13 Nov 2022 14:19:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235106AbiKMNTh (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Sun, 13 Nov 2022 08:19:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234213AbiKMNTg (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Sun, 13 Nov 2022 08:19:36 -0500
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0E55BF50
        for <linux-can@vger.kernel.org>; Sun, 13 Nov 2022 05:19:35 -0800 (PST)
Received: by mail-pj1-f49.google.com with SMTP id o7so8194450pjj.1
        for <linux-can@vger.kernel.org>; Sun, 13 Nov 2022 05:19:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yyNpcslSbRU3wPbmyfXvgetFYrV0IkBvGSlegjPlejk=;
        b=bqCraCL+4O8I9hnDeilaX6Un46OlMCxF4SYLv60CcWbqn+cJt+jqe6cRxgEGtkMPfu
         ZotQxS68s7fLtLRPxSmQmaO45xO3cYO9ENo9oiQucwNmEaAcypNcup5m0E1olr3qwMcg
         l7WnOjlonaNeoNabGlMehjMpeetgRXCWaSYbt945WlIvvrMwPWyqlW3fg8f+PFET7UNC
         /FIj4/4sP0wOmsfBqc5unQcmYIk1ekeCoBCQ4q3/z3UCDrj/VCySc1ZySy9mlZvhmalD
         fGHqyod12kp8+93L50lW2w9fgnt0NSdLsL8wLnMgIDP/dP2JDVdMpEa0y5ZUvcl7Yu2H
         K2tw==
X-Gm-Message-State: ANoB5pl2Ij9BA09urcuyJHFhhIwuVstgejJdB5ABfDn5KBKsAwPqqK2n
        KLW7OQTF3bIC8jSM/y9nLjXCNGwgI8q7Tlzffuc/bfD8nYgaaw==
X-Google-Smtp-Source: AA0mqf6eRDvsf3PPw9bGalSqRWw3ltP0uPSTN8hoi84z8L9O6s0t6YIs9MnlMjH7jo2KTiqybzz3KF4I435N05xmmPQ=
X-Received: by 2002:a17:902:f34c:b0:17f:6fee:3334 with SMTP id
 q12-20020a170902f34c00b0017f6fee3334mr10265740ple.10.1668345575192; Sun, 13
 Nov 2022 05:19:35 -0800 (PST)
MIME-Version: 1.0
References: <20221113085321.87910-1-mailhol.vincent@wanadoo.fr>
 <20221113085321.87910-3-mailhol.vincent@wanadoo.fr> <20221113130325.5tagqsi4t4523uob@pengutronix.de>
In-Reply-To: <20221113130325.5tagqsi4t4523uob@pengutronix.de>
From:   Vincent MAILHOL <mailhol.vincent@wanadoo.fr>
Date:   Sun, 13 Nov 2022 22:19:23 +0900
Message-ID: <CAMZ6RqKjAyYL6rNXaFK4dTQn=XtYnMw29RNmQJMo1pu29GrE-Q@mail.gmail.com>
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

On Sun. 13 Nov. 2022 at 22:12, Marc Kleine-Budde <mkl@pengutronix.de> wrote:
> On 13.11.2022 17:53:18, Vincent Mailhol wrote:
>
> > diff --git a/mcp251xfd/mcp251xfd-dev-coredump.c b/mcp251xfd/mcp251xfd-dev-coredump.c
> > index 5874d24..422900f 100644
> > --- a/mcp251xfd/mcp251xfd-dev-coredump.c
> > +++ b/mcp251xfd/mcp251xfd-dev-coredump.c
> > @@ -17,18 +17,10 @@
> >
> >  #include <linux/kernel.h>
> >
> > +#include "../lib.h"
>
> Does #include <lib.h> work?

Unfortunately, no:

  cc -O2 -Wall -Wno-parentheses -Iinclude -DAF_CAN=PF_CAN -DPF_CAN=29
-DSO_RXQ_OVFL=40 -DSCM_TIMESTAMPING_OPT_STATS=54
-D_FILE_OFFSET_BITS=64 -D_GNU_SOURCE  -c -o
mcp251xfd/mcp251xfd-dev-coredump.o mcp251xfd/mcp251xfd-dev-coredump.c
  mcp251xfd/mcp251xfd-dev-coredump.c:20:10: fatal error: lib.h: No
such file or directory
     20 | #include <lib.h>
        |          ^~~~~~~
  compilation terminated.
  make: *** [<builtin>: mcp251xfd/mcp251xfd-dev-coredump.o] Error 1

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
>
> Marc
>
> --
> Pengutronix e.K.                 | Marc Kleine-Budde           |
> Embedded Linux                   | https://www.pengutronix.de  |
> Vertretung West/Dortmund         | Phone: +49-231-2826-924     |
> Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-5555 |
