Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E2B89383BEF
	for <lists+linux-can@lfdr.de>; Mon, 17 May 2021 20:09:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229610AbhEQSKj (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Mon, 17 May 2021 14:10:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236935AbhEQSKi (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Mon, 17 May 2021 14:10:38 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE0DCC061573
        for <linux-can@vger.kernel.org>; Mon, 17 May 2021 11:09:20 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id u5-20020a7bc0450000b02901480e40338bso356181wmc.1
        for <linux-can@vger.kernel.org>; Mon, 17 May 2021 11:09:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=flodin-me.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=X/x/VHNWCMz/4kvAJtfiWKVvppih4W25iBv5lcNDtY4=;
        b=E+eZnxfvZO1TPOxf1FnMPMLCJY6XYOkERIZzK62zSwo4Ov2reoGS+rGmXK+upO7rRP
         4LFifobRvlunzQY/NbF0KEPKlfKcM/LCC00xgeggippUwBThbjcrxCKyrUzP2xQPhT+A
         YUwgSVkSHzm5Sag2d/HBexqRjMyu8c8U5T/UBD0dRp0bHfOtLfMhLD08yiZkQJvIjD/a
         Ldg3F8q5M49UNfAWp/cinddumyCl2DhLYhRtMLmKUjf/8VFay3Rnz+O6pXEM9WHyXZla
         H2CzkYkLRexrrHeepIcUA/IBewJa2BGZL5ok/GaZmAHWhtge3rGoh2qWoYT4oXp+lLAf
         YGgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=X/x/VHNWCMz/4kvAJtfiWKVvppih4W25iBv5lcNDtY4=;
        b=Vo3cLqDmV3T3qCVTbA7Kc8JzZNh//cGaTc5trELP3fSZ7EAdUnMIc8U6773AaMKRnW
         /tMH1o/X1hvz8o2ftQSETwO2ktfrr+1PLRslWYG97+Uv2ZNgwusIUruTrVsvJOJz6Lef
         0j58oStDezPyRYY6TmXHu6j7cggDyXjRy40bcBv7x3AHgcHn932CCW+UFq/+E7dkAcvF
         x8trFZufosceJ7phr1eOrZkeAsxX2wyM1HrIQDdjhS6I9Cv//Wz/Ze3Mw2Mvpg4Rh6eY
         2Un+drQ3EWZ9W/T8XEnHT5glJD6F1cFB6XOVzIj3tkgAZNHH5sBUKgkgTd08Mstwm+fG
         sfSw==
X-Gm-Message-State: AOAM531OH99QngGvKIXy5dm2EuGl2ysZWwjB6H710bVjXouz4qT/TWoy
        wj/Ybx6A4qpuHAkgYbYwn2H+djngMCBEEIQcqzCrOQo4Z3E=
X-Google-Smtp-Source: ABdhPJxXtOXXLDuZzEfkZTkMebfrbCqX15+4uCsqCAoXbLu/WdCIlnSiCQzjMp8DmGzpXb2jW8CS/TpaiLx3ODLRrzY=
X-Received: by 2002:a1c:1d8e:: with SMTP id d136mr864088wmd.80.1621274959560;
 Mon, 17 May 2021 11:09:19 -0700 (PDT)
MIME-Version: 1.0
References: <20210504203546.115734-1-erik@flodin.me> <20210504203546.115734-2-erik@flodin.me>
 <cf5fdb14-47e2-2d08-0d29-c621bff7b312@hartkopp.net> <CAAMKmocxj1zOQastSqKhHmV0-9HVh3NpPmSPWf=byxj+fFPUHQ@mail.gmail.com>
 <64bf5aaf-1e8c-2f29-8263-63710a771843@hartkopp.net> <CAAMKmoda0U912_6Qp97fzt4BjcbUPDrE8Cy5C7C-TS5_7du31Q@mail.gmail.com>
 <46bdff5c-c0ab-56e9-7c70-8a3267458d55@hartkopp.net> <CAAMKmocsZBsFfpRLyLHqFE94xb-xrm5S8YG=QzQTndDjtOyuzw@mail.gmail.com>
 <64e37aae-e6b5-20aa-04fb-10b4a2f50b5e@hartkopp.net> <CAAMKmocfkcFhhg+JgosbOVZD7AexWEwF6rJzN=Vv86WPFhQYyA@mail.gmail.com>
 <df854f78-cd82-81b6-2456-b4c272920b6a@hartkopp.net>
In-Reply-To: <df854f78-cd82-81b6-2456-b4c272920b6a@hartkopp.net>
From:   Erik Flodin <erik@flodin.me>
Date:   Mon, 17 May 2021 20:09:07 +0200
Message-ID: <CAAMKmocgjpH399_UFDG0sOwuKbqYuhhRi8mKhSew4S-spE=z-A@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] can: add support for filtering own messages only
To:     Oliver Hartkopp <socketcan@hartkopp.net>
Cc:     linux-can@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

On Mon, 17 May 2021 at 09:36, Oliver Hartkopp <socketcan@hartkopp.net> wrote:
>
>
>
> On 16.05.21 22:02, Erik Flodin wrote:
>
> >> You mainly want to throttle the outgoing traffic, to make sure that e.g.
> >> a specific CAN ID is not sent 'back-to'back' and might lead to a DoS
> >> situation on the wire?!?
> >
> > Yes, so after a frame has been sent, I want to leave the bus idle long
> > enough to give another device on the bus that has something in its TX
> > queue an opportunity to send.
> >
> >> Do you know about the Linux CAN queuing disciplines that might provide
> >> the solution to your question?
> >
> > Yes, I came across that when I started my journey in CAN-land, but
> > unfortunately the kernel I have to use doesn't have support for
> > traffic control. That's when I started using RECV_OWN_MSGS which
> > worked until I added filters and here we are now :)
> >
> > If I get the chance to update the kernel (which would have to happen
> > before my proposed patch could be used anyway) I should perhaps try to
> > get tc support instead. That would simplify my application at least.
>
> :-D
>
> In any case it seems you need to change some kernel code.
>
> The CAN frame ematch rule is from 2012:
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit?id=f057bbb6f9ed0fb61ea11105c9ef0ed5ac1a354d
>
> Is your kernel older than 2012? o_O
> Or was TC just not enabled?

TC wasn't enabled.

// Erik
