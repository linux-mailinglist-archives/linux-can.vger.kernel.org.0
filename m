Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8D62236A9F9
	for <lists+linux-can@lfdr.de>; Mon, 26 Apr 2021 02:00:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231331AbhDZAAi (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Sun, 25 Apr 2021 20:00:38 -0400
Received: from mail-yb1-f182.google.com ([209.85.219.182]:41540 "EHLO
        mail-yb1-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231330AbhDZAAi (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Sun, 25 Apr 2021 20:00:38 -0400
Received: by mail-yb1-f182.google.com with SMTP id p202so18952844ybg.8
        for <linux-can@vger.kernel.org>; Sun, 25 Apr 2021 16:59:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zx8wfIX/8NCZCoYBreGQOOW9SIV4OZiyRDaduxCJp3A=;
        b=DTFoQoMOgbf/y8vbqEWg2M8N+gYyEYJg2wJJsyfvkfffgytZSuwR/nHsJodn0BGnWa
         wLySFAjXnK0HtBGEk9kiNRtBUnyxKdeyLkwQf2bU3NCv7JbaCb9u2ncJXBy+6WNvnwDK
         rzPU2Dk4n59z5xam6qOGznLYmypdQfgyO+QHKQ9jiYlHdbw+X0CSJAq2gvBxjDllJHft
         L7c9AONeFDFNSvT74ci/iuQq7tzrnTIDoErJi8JVw3gIAMdekZTvwjZjcq0mX+NVRYFu
         12DLuFMlfgtSBOMxVbqFgg6jt0ZgKJZK+FDt2HaULgGBc3Ev7Ww2I9FjJIiPhUapcg1/
         4jbQ==
X-Gm-Message-State: AOAM53207Do1PmThu9hJyaq322mqtV/dkaZp7yunZntrW8KyxON34zXn
        21QYqVieQ4YacKd3sLplnxQYTHL3rsmJ69XM0sMeD+9mWpQXBQ==
X-Google-Smtp-Source: ABdhPJxkUvs9t4qZSmrSvxagq5wQBFuPamrmycGBX5KeMg9QwKDfNcKN6Mk2YNN4oNqGHPmXIH8plPD/Ss4gdm8I0pQ=
X-Received: by 2002:a25:7381:: with SMTP id o123mr5949115ybc.145.1619395196351;
 Sun, 25 Apr 2021 16:59:56 -0700 (PDT)
MIME-Version: 1.0
References: <20210425151028.8238-1-menschel.p@posteo.de> <CAMZ6RqKkeq6vo0X4_KH01=SXfjKF7YMXGT_cgm+sS+T10hr_CA@mail.gmail.com>
 <0a2b2615-ed9e-f813-8574-b170969c37ba@posteo.de>
In-Reply-To: <0a2b2615-ed9e-f813-8574-b170969c37ba@posteo.de>
From:   Vincent MAILHOL <mailhol.vincent@wanadoo.fr>
Date:   Mon, 26 Apr 2021 08:59:45 +0900
Message-ID: <CAMZ6RqK=4QifudsgxWHxoDYR0PfZvJg-kJjeshqmds1X8c4XfA@mail.gmail.com>
Subject: Re: [PATCH] can-isotp: Add error message if txqueuelen is too small.
To:     Patrick Menschel <menschel.p@posteo.de>
Cc:     linux-can <linux-can@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

On Mon. 26 Apr 2021 at 01:45, Patrick Menschel <menschel.p@posteo.de> wrote:
>
> Am 25.04.21 um 17:35 schrieb Vincent MAILHOL:
> > On Sun. 26 Apr 2021 at 00:10, Patrick Menschel <menschel.p@posteo.de> wrote:
> > Speaking of comprehensive error messages, it would be great to
> > print the mnemotechnic of the error code instead of its value:
> > |                       pr_notice_once("can-isotp: %s: can_send_ret
> > %pe : tx queue is full\n",
> > |                                      __func__, ERR_PTR(err));
> >
> Thanks Vincent,
>
> it's the first time I see this format string %pe , is it new or kernel
> specific?

Yes, this is fairly recent and it is kernel specific (and I love it).

It was added in commit 57f5677e535ba ("printf: add support for
printing symbolic error names").
Ref: https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=57f5677e535ba24b8926a7125be2ef8d7f09323c


Yours sincerely,
Vincent
