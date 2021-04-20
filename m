Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BA1B036605C
	for <lists+linux-can@lfdr.de>; Tue, 20 Apr 2021 21:40:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233752AbhDTTlY (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Tue, 20 Apr 2021 15:41:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233697AbhDTTlY (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 20 Apr 2021 15:41:24 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 155C7C06174A
        for <linux-can@vger.kernel.org>; Tue, 20 Apr 2021 12:40:51 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id i21-20020a05600c3555b029012eae2af5d4so11308067wmq.4
        for <linux-can@vger.kernel.org>; Tue, 20 Apr 2021 12:40:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=flodin-me.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=nHtWBDfqef8hXJ8CYwb7uUBQx6KtcXxptsI9QslbRzA=;
        b=GBL1bK+Mdg6OdDfda9k5NKYx2ULsEYNpD9ptecSeqLuTWHUYf/1IUx2M3w+I8ZfhLL
         Jc7y2aDlGBjSG6mgC7PgMbIHDsOxmKYgI+nx138pFIzr/nRacMaKytu7VVkEn8JTH1Tb
         OrhQYuwWEnRTqoG9Bce3wYgfnjaeQ7nsFQmQFktbwUHWFncBwz6z3RQ/0lkEHN5uaDVp
         CHulzhWtlWtF9Cljc4EL2ebuaI5x8VMBuvdQGv1m6TROkturchflA2PVym4WIPanK8Sp
         Fqd1+zL2OreANz/rP8qjgjdPOH2Ldq0zpGYegHN5u/7Tr7I2to2idUAJ7SxLb22WIuzO
         1RAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nHtWBDfqef8hXJ8CYwb7uUBQx6KtcXxptsI9QslbRzA=;
        b=E03ThXlpszSlDwr9YX/JTYinuvMxtoomdcRrMGIJo0UprCjKkSLrdgL9bmyA90D4Vi
         bisw+j0ulBeb6vPR30tZJFzzxiEymhtShBQswRb5JbESu6/x0DYRnvGxKqKA6YrItVeH
         0xz6qRkzyEQa5DTv+x6vAJrA6Tq+pBHVo72XLuGpoPfCQCKfYeWUd0a44oZB9fNvseOO
         A2Ns7xJXugp1z7ASPPojlz7uZyzM+HpdZaxA1/TItYhobUeZtylKQJ2aMf7bId71fl5h
         blQEiyg2cifVVITgZhE3w0ngiZX1ZiJnkmdzsuDuPYr5A9Fbb32yrkpsfjhk8M5sRPsf
         d0Ng==
X-Gm-Message-State: AOAM532vDPC+e5qtj7KNeahMhme3eRGQKk+waS8AjQEtd4zqR9ZzXHDa
        JvAtnTFWtPDDGZM7hviWGqVbgIzntzdm7GboYY2bTtcb1V8=
X-Google-Smtp-Source: ABdhPJxmzhbHkxC8YjA3ZWbTggN/BPCo7POPc2nYbDGGG43wESlp4eEEm/HVzMXu40edZjNNDxGZUHtIsDYZXlHZIiQ=
X-Received: by 2002:a1c:7c13:: with SMTP id x19mr6051562wmc.189.1618947649809;
 Tue, 20 Apr 2021 12:40:49 -0700 (PDT)
MIME-Version: 1.0
References: <CAAMKmofMUGrXPynSQXcvFCvB3nJXYrvosv63Aq4tcxyFok=rgA@mail.gmail.com>
 <20210415083254.lxm2y7xdz2s2qalo@pengutronix.de>
In-Reply-To: <20210415083254.lxm2y7xdz2s2qalo@pengutronix.de>
From:   Erik Flodin <erik@flodin.me>
Date:   Tue, 20 Apr 2021 21:40:38 +0200
Message-ID: <CAAMKmoc=xiZ+ejkXUGSgZtrWiBcpYbtiROHESKM44JfL4Qs24g@mail.gmail.com>
Subject: Re: CAN_RAW_RECV_OWN_MSGS and filters
To:     Marc Kleine-Budde <mkl@pengutronix.de>
Cc:     Oliver Hartkopp <socketcan@hartkopp.net>, linux-can@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

On Thu, 15 Apr 2021 at 10:32, Marc Kleine-Budde <mkl@pengutronix.de> wrote:
>
> On 14.04.2021 21:22:50, Erik Flodin wrote:
> > I've been using a raw CAN socket with RECV_OWN_MSGS enabled to get a
> > transmission confirmation when a frame has been sent. Today when I
> > tried to enable filters to limit what I receive to only those frames
> > that I'm interested in I noticed that the filters also affected
> > reception of my own frames. So in order to receive all frames that I
> > send I must also add a filter that matches all frames that I send.
> >
> > Is this the expected behavior?
>
> At least it's implemented this way.
>
> On TX complete of a CAN frame it's pushed into the RX path of the
> networking stack, along with the information of the originating socket.
>
> Then the CAN frame is delivered into AF_CAN, where it is passed on to
> all registered receivers depending on filters. One receiver is the
> sending socket in CAN_RAW. Then in CAN_RAW the it is checked if the
> sending socket has RECV_OWN_MSGS enabled.

Thanks for the explanation. I've sent a patch to clarify in the
documentation that the socket's own frames are also subject to
filtering.

> I don't think there's a way to do that without modifying the kernel
> code. One option is to add a new sockopt RECV_OWN_MSGS_ALL or
> RECV_OWN_MSGS_UNFILTERED. The CAN_RAW can then register another receiver
> at AF_CAN for own messages only.

I'll see if I can figure something out. Unless someone beats me to it :)

// Erik
