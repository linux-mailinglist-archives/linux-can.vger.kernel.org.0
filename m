Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 760733820BD
	for <lists+linux-can@lfdr.de>; Sun, 16 May 2021 22:03:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233172AbhEPUEO (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Sun, 16 May 2021 16:04:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230104AbhEPUEO (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Sun, 16 May 2021 16:04:14 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBCFEC061573
        for <linux-can@vger.kernel.org>; Sun, 16 May 2021 13:02:58 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id n2so4338995wrm.0
        for <linux-can@vger.kernel.org>; Sun, 16 May 2021 13:02:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=flodin-me.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=GiBBlITzVhVZJitHcXMO87A/nSQPYQzMoE6RVq1dZpU=;
        b=tiVFT80ngymRrP76Tu0tFrnDXlOdkteZDSFYjrSHM0G6eARylOV3eXCwjoa1RRQkQ4
         Mpvs0pTLk19iPrcPf4ssuJbUXJs1ixN1r0pGCKwNZNoA0c5Sg7h44qdEjLgsN1vtP8Hu
         DHUbaoaZvYnHpUyOT9HDTPhsU/MHX19z0cV7OINt/0J0OdVfZYMQZdfE6PoxQ2gMSVPv
         nSu6IL0ssWCVJMpNhahpvv15BMMlo5vQJLo9mmkRXeuAAOxWz09SayZV81vFkFy3lpFQ
         IRv3s5rTMcAzo77WtiIcLagEYfjqm9bVrWd0SC0/oifd8lC34N0WJc0wypXaiUGWMqJQ
         8wfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GiBBlITzVhVZJitHcXMO87A/nSQPYQzMoE6RVq1dZpU=;
        b=cOfNCl6w3lrF+LJXqht288VhK8Bde7FAex+x+e1oCqtrsU920MMW73uOt+UpCELDtm
         kLIVNileb6leZEucMvrVsVk+QnMPiC2HdDZJzGY9rDygT58ChCl4vzqrXBn7FjExiDX7
         KCqYKkFb+HgbEJWiFMUIoCMbD+Tal6TQIx8c5aT589UoRIH26cTlS7opfU/lpKPLsz0t
         SrypruuKNWAvbvjaV0wfj2NnihmJkFWWx0AGrZA4xS5+2AaEB1yMWzKLoWmQVFeZwS8X
         wcrfyA6fSUapy55Qz263hbSqATROwwseK2/MyS4A+DaYrRPpjXNNNp/RtGmLvg4Oo08t
         6/3Q==
X-Gm-Message-State: AOAM532b74hjFsun3PD5ZYhVDVly0xAWvA7BnQBwO27rlKuAH2b1+lMN
        tSKN5tboqjC09Q1Ey/01nz2RQz6d4/artNlOKrvlhm/hzJU=
X-Google-Smtp-Source: ABdhPJxq3BvsaBhTa/cOoxp9IK80cI57s+60szwm3ecgkY7+hziCB8RWb7zRrLdHW31J1pfASKHvL+jv2oy+ssZ4Gno=
X-Received: by 2002:adf:f58e:: with SMTP id f14mr4318457wro.258.1621195377612;
 Sun, 16 May 2021 13:02:57 -0700 (PDT)
MIME-Version: 1.0
References: <20210504203546.115734-1-erik@flodin.me> <20210504203546.115734-2-erik@flodin.me>
 <cf5fdb14-47e2-2d08-0d29-c621bff7b312@hartkopp.net> <CAAMKmocxj1zOQastSqKhHmV0-9HVh3NpPmSPWf=byxj+fFPUHQ@mail.gmail.com>
 <64bf5aaf-1e8c-2f29-8263-63710a771843@hartkopp.net> <CAAMKmoda0U912_6Qp97fzt4BjcbUPDrE8Cy5C7C-TS5_7du31Q@mail.gmail.com>
 <46bdff5c-c0ab-56e9-7c70-8a3267458d55@hartkopp.net> <CAAMKmocsZBsFfpRLyLHqFE94xb-xrm5S8YG=QzQTndDjtOyuzw@mail.gmail.com>
 <64e37aae-e6b5-20aa-04fb-10b4a2f50b5e@hartkopp.net>
In-Reply-To: <64e37aae-e6b5-20aa-04fb-10b4a2f50b5e@hartkopp.net>
From:   Erik Flodin <erik@flodin.me>
Date:   Sun, 16 May 2021 22:02:46 +0200
Message-ID: <CAAMKmocfkcFhhg+JgosbOVZD7AexWEwF6rJzN=Vv86WPFhQYyA@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] can: add support for filtering own messages only
To:     Oliver Hartkopp <socketcan@hartkopp.net>
Cc:     linux-can@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Hi again,

Sorry for being slow to reply...

On Mon, 10 May 2021 at 14:28, Oliver Hartkopp <socketcan@hartkopp.net> wrote:
>
>
>
> On 09.05.21 13:28, Erik Flodin wrote:
> > On Thu, 6 May 2021 at 07:26, Oliver Hartkopp <socketcan@hartkopp.net> wrote:
>
> >>>>    From what I understood your main requirement is to double check the
> >>>> outgoing traffic whether is has been sent.
> >>>
> >>> What I would like to have is:
> >>> 1. Be notified when a frame has been sent. I send (from user space) a
> >>> single frame and wait until I get confirmation before sending the next
> >>> to give other nodes on the bus a slot to start sending, even if their
> >>> frames have ID with lower priority.
> >>
> >> o_O
> >>
> >> Sorry, but I have problems to get behind your use-case.
> >>
> >> 1. You are sending a frame
> >> 2. You get a confirmation
> >> 3. You are waiting some time (which is not written above), to give other
> >> nodes a slot??
> >
> > No explicit sleep is needed. The machine is sufficient slow so that
> > just waiting for the confirmation before sending the next frame is
> > enough. But if the frames are queued in the socket/device then the
> > frames are sent back-to-back.
>
> Ok, I feel I'm getting behind your requirement ...
>
> You mainly want to throttle the outgoing traffic, to make sure that e.g.
> a specific CAN ID is not sent 'back-to'back' and might lead to a DoS
> situation on the wire?!?

Yes, so after a frame has been sent, I want to leave the bus idle long
enough to give another device on the bus that has something in its TX
queue an opportunity to send.

> Do you know about the Linux CAN queuing disciplines that might provide
> the solution to your question?

Yes, I came across that when I started my journey in CAN-land, but
unfortunately the kernel I have to use doesn't have support for
traffic control. That's when I started using RECV_OWN_MSGS which
worked until I added filters and here we are now :)

If I get the chance to update the kernel (which would have to happen
before my proposed patch could be used anyway) I should perhaps try to
get tc support instead. That would simplify my application at least.

Thanks for your time!

Best regards,
// Erik
