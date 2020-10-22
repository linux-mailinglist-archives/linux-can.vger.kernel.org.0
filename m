Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C2AB02964C1
	for <lists+linux-can@lfdr.de>; Thu, 22 Oct 2020 20:42:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S369748AbgJVSmC (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Thu, 22 Oct 2020 14:42:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2901446AbgJVSmC (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Thu, 22 Oct 2020 14:42:02 -0400
Received: from mail-oi1-x229.google.com (mail-oi1-x229.google.com [IPv6:2607:f8b0:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D74D5C0613CE
        for <linux-can@vger.kernel.org>; Thu, 22 Oct 2020 11:42:01 -0700 (PDT)
Received: by mail-oi1-x229.google.com with SMTP id 16so2796260oix.9
        for <linux-can@vger.kernel.org>; Thu, 22 Oct 2020 11:42:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=beagleboard-org.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1DJ9BzRFy/zAlUNKm2foUeozDzzCzEdvg7uI36V0Fq8=;
        b=GjDjOXH5PBCLFXZ2U2AOiSnWTUrxwtQcRHSGc1Cv/nYkiE9ljwkltCnH5YEtv5bFS+
         21d6VWVFDt7F7J8IgVYVKEkPgJKi8jFwI+LawUD5cO3kPkjwT1k3dzrALpiAgtcVWcQM
         TwvsfiiucLxnVH/WofiWfswU9tYm7ub7umFQOpwYc2cmWlWZrMnOftiXH4r3XPxHgrM5
         IIkLkl+f7xciaW9KHDRdBpqwH5tU1AEHibUngM6c4WrsssYy0IF1TciZN1blRVzjKKZ5
         4ay7ETXWJK9WUW4bEG0C6faa42hnwve11qbtCsnwcmDvZJ0FpfXoOzIN14E0QPcHOvjN
         Hb/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1DJ9BzRFy/zAlUNKm2foUeozDzzCzEdvg7uI36V0Fq8=;
        b=c8fG+nF9jl+NQs2Ya9zCkSYXlORSJYS+g/E90DXgrR1CKvlwDJFNZrD1VYR50vO3OA
         i/M3wNs1KswBDogyKfy19LhorrEiApTJ1EX42qQLxmnwkW5RI9/oYbHF7fT5NFg2qEtx
         gBLdPs48YR/nSMUb8VOVqF4/YiAIFUCkND6r4g/yBjSKIlmxmV37r33JdnHIv3Y0ruVB
         CFo7gwa3thOhFxW73zkGrgwca1nQTYTaWUKSyw6PECac20Xg7fKK6P+MCuJpmNvQ4tpG
         YjNxUkEQGwpXEc9d79/DII19VmN+C9a8r6hv3RYhndKi88I/6n0PT44RddUlMl+gMoo6
         iM5g==
X-Gm-Message-State: AOAM531KyOceOgNxgEr1NQzOIL8NWbt6P4LKI2KYhhvyi4VubhMpjapX
        PgYti1QjGh9+P1hNZnYIipWpNOHOfkeQHpSLD9F3j0ScJ+o=
X-Google-Smtp-Source: ABdhPJxWqf1xZrCqa+9z+A9s2wlYtouUVR/jB50ASy0Wq8M5L6yO/Dxu5JjPvQmao9yiHfICDde9khWXU0sXAbTyCMA=
X-Received: by 2002:aca:c692:: with SMTP id w140mr2356463oif.94.1603392120977;
 Thu, 22 Oct 2020 11:42:00 -0700 (PDT)
MIME-Version: 1.0
References: <CAPgEAj5eeN7Q9Hs7ZcrvaNCQJ7uW8kyNs3CPiVfQ=AEX9WeYoQ@mail.gmail.com>
 <CAPgEAj5HwFUTqhbgZ2Y5Db-_PPHNN7Rc8dnp1s+TBBALf5EwSw@mail.gmail.com> <3ede1c31-9436-a8ec-b7cd-65cee5fa23fc@pengutronix.de>
In-Reply-To: <3ede1c31-9436-a8ec-b7cd-65cee5fa23fc@pengutronix.de>
From:   Drew Fustini <drew@beagleboard.org>
Date:   Thu, 22 Oct 2020 13:42:04 -0500
Message-ID: <CAPgEAj7JLUjWiN8LdGV9OfQScsUkPVcs9bSE+w_9G0c9BNd-sg@mail.gmail.com>
Subject: Re: mcp251xfd on RPi 5.4 downstream
To:     Marc Kleine-Budde <mkl@pengutronix.de>
Cc:     linux-can@vger.kernel.org, Josh S <josh@macchina.cc>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

On Thu, Oct 22, 2020 at 1:33 AM Marc Kleine-Budde <mkl@pengutronix.de> wrote:
>
> On 10/22/20 8:00 AM, Drew Fustini wrote:
> > It appears it was simpler to get it to compile than I expected.
>
> \o/
>
> > cs_change_delay.unit becomes cs_change_delay_unit,  and
> > cs_change_delay.value becomes cs_change_delay.
> >
> > The other issue was 728fc9ff73d3 ("can: rx-offload:
> > can_rx_offload_add_manual(): add new initialization function") which
> > was simply solved by adding can_rx_offload_add_manual() to:
> > include/linux/can/rx-offload.h
> > drivers/net/can/rx-offload.c
> >
> > The driver builds ok:
>
> With your help :) I backported current linus/master to the rpi-5.4:
>
> https://github.com/marckleinebudde/linux/tree/v5.4-rpi/mcp251xfd-20201022-54
>
> Can you test that?

Thanks, will do.   I am currently trying to finish up my ELC-E talk
prep :) but will get back to you with the results of testing later.

> Do you know the process to get that into the rpi kernel? Send a pull request on
> github?

Yes, the take pull requests on their git repo for their downstream branches.

>
> regards,
> Marc
>
> BTW: What's your current timezone?

currently in US CDT (UTC-5) until the end of October then back in
CEST.  However, I'll be up early next week for ELC-E :)

thanks,
drew
