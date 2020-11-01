Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A49172A1F53
	for <lists+linux-can@lfdr.de>; Sun,  1 Nov 2020 16:56:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726791AbgKAP4j (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Sun, 1 Nov 2020 10:56:39 -0500
Received: from mail-yb1-f196.google.com ([209.85.219.196]:46145 "EHLO
        mail-yb1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726637AbgKAP4j (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Sun, 1 Nov 2020 10:56:39 -0500
Received: by mail-yb1-f196.google.com with SMTP id a4so9556204ybq.13
        for <linux-can@vger.kernel.org>; Sun, 01 Nov 2020 07:56:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wQbGskRIHAqPdOsbCreVACNqcxVvDyhUAm9JxgD2SrE=;
        b=V942w77r6S2Lei3z2myOan+IRlC/0P25HiwsV98Sa1EhBErR6s9RFnlGRFLW0h5bap
         O56lJwN3zuLVzI9VjoNXnj8abGPcNwenanWwRlp7syPPennY3a8WLDYr7s2A41+3JupU
         /j26Th+gGZwNGnNd62YeaPVGHXvMrhl1ZCVga/us09QupmeTfCwvaemXVSZRb3SAIWKg
         uhZ3E5AQIGorD4S2JgZ6e9ZJkoQRImsfvr4AnVUa8RX7bV9Y6Qb8HZLohhvTLgBomHOY
         2h/MFQrczthdcwnFW2XCpPitKMHFOKnoLP7eBv6TiQ3n5Km56u4OSgHZ7m+M14d+uzyp
         CwsA==
X-Gm-Message-State: AOAM530QUPC/kAUZhjePAoSjMj8PQ/pXVwhoqG0OKNixj7OQxkOHEiu9
        b/jl42NI5ta/H4GZIekYNqipvLNfnl84RRPKRNJiWlcl5eI=
X-Google-Smtp-Source: ABdhPJwed0APFbEjpNBqRq5mmY5vmAe0wYV65rT/J9W3rBa+PwNydATdEU8lVEkDA7qv6cMxCjg6QBRHVzsnAbRF6P8=
X-Received: by 2002:a25:d345:: with SMTP id e66mr14931412ybf.307.1604246198656;
 Sun, 01 Nov 2020 07:56:38 -0800 (PST)
MIME-Version: 1.0
References: <20201101145712.489795-1-mailhol.vincent@wanadoo.fr> <5ecff3df-2e94-8702-3894-3fcd70364552@hartkopp.net>
In-Reply-To: <5ecff3df-2e94-8702-3894-3fcd70364552@hartkopp.net>
From:   Vincent MAILHOL <mailhol.vincent@wanadoo.fr>
Date:   Mon, 2 Nov 2020 00:56:27 +0900
Message-ID: <CAMZ6RqJjOYCdakf7jfdzZkagP0wws67BasBw+zpbbWP7m6e0ww@mail.gmail.com>
Subject: Re: [PATCH] cangen: flush the CAN frame at each iteration
To:     Oliver Hartkopp <socketcan@hartkopp.net>
Cc:     linux-can <linux-can@vger.kernel.org>,
        Marc Kleine-Budde <mkl@pengutronix.de>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

On 01.11.20 15:57, Oliver Hartkopp wrote:
> - linux-kernel@vger.kernel.org
> + linux-can@vger.kernel.org
>
> Wrong mailing list ...
>
> On 01.11.20 15:57, Vincent Mailhol wrote:
> > The variable 'frame' is declared on the stack and is reused at each
> > iteration of the while loop.
> >
> > If not flushed, garbage data from the previous iteration of the loop
> > could remain causing unexpected behavior. This is the case in DLC
> > random mode: the field frame.len8_dlc is not cleared when the dlc is
> > exactly 8 and the len8_dlc value of the previous iteration will be
> > sent again.
>
> Good catch! Thanks.
>
> > This can be observed by running 'cangen -8 can0'. Once a frame of DLC
> > in the range 9..15 is generated, no more frames of DLC 8 show out in
> > the log.
> >
> > Signed-off-by: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
> > ---
> >   cangen.c | 2 +-
> >   1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/cangen.c b/cangen.c
> > index ab8122c..d7392b6 100644
> > --- a/cangen.c
> > +++ b/cangen.c
> > @@ -384,7 +384,7 @@ int main(int argc, char **argv)
> >       }
> >
> >       while (running) {
> > -             frame.flags = 0;
> > +             memset(&frame, 0, sizeof(frame));
>
> But this patch breaks everything which is not in random mode.
>
> Analogue to frame.flags we just need to clear frame.len8_dlc

You are right! My patch was dumb.
