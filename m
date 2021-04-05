Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AD116354610
	for <lists+linux-can@lfdr.de>; Mon,  5 Apr 2021 19:32:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238666AbhDERcJ (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Mon, 5 Apr 2021 13:32:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237872AbhDERcI (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Mon, 5 Apr 2021 13:32:08 -0400
Received: from mail-yb1-xb30.google.com (mail-yb1-xb30.google.com [IPv6:2607:f8b0:4864:20::b30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48166C061756
        for <linux-can@vger.kernel.org>; Mon,  5 Apr 2021 10:32:01 -0700 (PDT)
Received: by mail-yb1-xb30.google.com with SMTP id l187so7062228ybl.4
        for <linux-can@vger.kernel.org>; Mon, 05 Apr 2021 10:32:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=GHd0F0pVK0rSWUI+aZmByIBFggioRDY9H9ceRva246U=;
        b=ohEACWABDi4GXZhJJm5xbsZOeKbDh/lAct5hZOj/wjJWXj4MG25AsJ82Fx5th2onIP
         45ZjN1/e67J0Nh/HLdHnLaliWg1lf7krAgDeCLgRjN4avMNRy/YJVkWtlhHWt0dPp4MM
         WgIx8metkSj329tkffWKZRwopdy75ZAlrD2lfS7R3m3IAAuuxaoUvRfF9Q5xQfV+joqS
         x5HdVcZ28q7COQogcBTWCLf6MQRLM/P+3V2WuwnUFChX+z/MLqQ5KwKSST2rt9BbNQYE
         UzvWD3t9aic6gz+tCTTXLfJ/TmVOcLmGLYgyqDdyl+UEi8HiJvjDyTxVaZz/hcp0YD5+
         C07Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GHd0F0pVK0rSWUI+aZmByIBFggioRDY9H9ceRva246U=;
        b=LvnN4+YdNcgpya0dt9FxMlikHtRfZP7WkqX70TId380/xO8jL8vYBypuwkGmLvDnQU
         wrDFrZRslqVv6nKr00OmNWWh4Wd1LPaOXSHcwqRuZVKT/FUDPaFOfCeoc6pf84RZhC3C
         t3PDFA73qQKUPq36I6qlPe8tavPL5yqafnW78q4ylsPO4sxkx+dqTC6I+d+x9P+fhU0w
         WLSnRvOu83wW6ho7BGD04NFaZQvxdN/gtG/wxITTPKuENBiBsf33joFN5fR2e5QyddLV
         +5//SjZefZhrJ2KTqrGZH2mLpda7Dohebj/Nu4+i31om9kq7ReaVPBkyMH74QgWrQn/z
         EP/A==
X-Gm-Message-State: AOAM533IbiQhM3em0DMSOAovR+iRxUIAuv8eeXTYeHJzqD6GVoV4Gy+k
        utbT7IluLx1R/1iIEl7lhJrTJMlXySFvoS6aNjlEp9dl9gM=
X-Google-Smtp-Source: ABdhPJxPwu/bJLId5nr8XDJvsq5er5kZj8Ki3sR5b5mDj2BF6R8kN9/DiOzg96b2XwW2P2TZkumMw5JO3uFP+jPX6Ao=
X-Received: by 2002:a25:f304:: with SMTP id c4mr36451907ybs.236.1617643920449;
 Mon, 05 Apr 2021 10:32:00 -0700 (PDT)
MIME-Version: 1.0
References: <CAAfyv37vMxhN2B1uR5xUzZwVzAqrQOyPA6stWYj_5346xO0s3A@mail.gmail.com>
 <20210331083744.pui7rtjexvejjvf6@pengutronix.de> <CAAfyv35tCPxf0KSOk3=mcq6j2yB0DLUrN3AJ6sJtreZmTYZdGQ@mail.gmail.com>
 <20210402192759.up2tperefmwyt3r2@pengutronix.de>
In-Reply-To: <20210402192759.up2tperefmwyt3r2@pengutronix.de>
From:   Belisko Marek <marek.belisko@gmail.com>
Date:   Mon, 5 Apr 2021 19:31:49 +0200
Message-ID: <CAAfyv35ofuk-z4qByJp3y9JRuAYPu4WaUaBf_o9QyschPNOOUg@mail.gmail.com>
Subject: Re: m_can error/overrun frames on high speed
To:     Marc Kleine-Budde <mkl@pengutronix.de>
Cc:     linux-can@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

On Fri, Apr 2, 2021 at 9:28 PM Marc Kleine-Budde <mkl@pengutronix.de> wrote:
>
> On 01.04.2021 11:04:25, Belisko Marek wrote:
> > Is there anything I can tune to have it read faster? Thanks.
>
> Indeed, with current net-next/master, you put the NAPI on a per
> networking device from softirq to threaded mode.
>
> | echo 1 | sudo tee /sys/class/net/can0/threaded
>
> Then you a separate NAPI thread per networking device that can be tuned
> with chrt, etc...
OK I've tse threaded mode for NAPI and for napi:can0 thread I set chrt
-p 99 <pid> but unfortunately there are still buffer overruns which is
kind of strange.

For rx-offload branch I was not able yet to run it on my platform
(have panic during boot which I need to resolve first).

Thanks and BR,

marek
>
> regards,
> Marc
>
> --
> Pengutronix e.K.                 | Marc Kleine-Budde           |
> Embedded Linux                   | https://www.pengutronix.de  |
> Vertretung West/Dortmund         | Phone: +49-231-2826-924     |
> Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-5555 |
