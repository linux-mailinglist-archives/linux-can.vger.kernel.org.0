Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 62371443D93
	for <lists+linux-can@lfdr.de>; Wed,  3 Nov 2021 08:12:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231971AbhKCHPW (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Wed, 3 Nov 2021 03:15:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230152AbhKCHPW (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Wed, 3 Nov 2021 03:15:22 -0400
Received: from mail-il1-x12c.google.com (mail-il1-x12c.google.com [IPv6:2607:f8b0:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BD05C061714
        for <linux-can@vger.kernel.org>; Wed,  3 Nov 2021 00:12:46 -0700 (PDT)
Received: by mail-il1-x12c.google.com with SMTP id s14so1568911ilv.10
        for <linux-can@vger.kernel.org>; Wed, 03 Nov 2021 00:12:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=4WUlnhsHnc9WF4w4T5obGcoJ6CAIJ9WILOiz2/6AfSQ=;
        b=dcr1eII697DJhxPGreljBXtGcEwHKhOsc36D6c7dNu0xOD/0cgl8upnoTaeeNJdss/
         BA3JT5xg//FsQyostPdqwcxcNRdMF/d5I5JRyf1I6WxtLi2VDohtVmWnts+1DUqj7eqL
         UOONPhiMEYE+RolEyezSPTMko3Kx/p/7PWTo7JIQWH7AvQprNsSqHrcpp0qaYcdW2UYR
         wFJpFf2rPoeRxoqWN5nhprSSohbgEL+FSV+MvG7pew0f2if53AhbfwGCpxl9r285dmb0
         eAit+RRFMJZoHnNdcOatUBkBQgSE66q+4nObFWG9eW5avFvWhth7CKb3sJ+rmqU9uMHS
         Apbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=4WUlnhsHnc9WF4w4T5obGcoJ6CAIJ9WILOiz2/6AfSQ=;
        b=g1CIgmmdHSNCfpz4UroxSHoQC8PX7a7tWMhQZuo36ukLWKpd6UsFzBsyH+vcReKMMC
         bdnbXpBNJ2hwdFv/OsLdudMn3IHrPZuWHLRWnss7R5UriZNq/9HcCjHoPONMEuQekNY4
         YHanGC9sorsSXCnk1m+2GzZzBjst+8I9/yRO6FV6Kb6SIKXPk/V7uHMvvXpQobuVB3Jd
         bFQ+RGL+soT47wzwE3QqNdNPTzSOIdDNW97e/MliuuHWRsbd2mxyeaXGQXuUXrot3CTH
         rksOs5DixzQA507Fjpedv5zC6FxCHhnRXphWCXUtR0caVmZ+cAJvWU44npebgtiaITPI
         tn1Q==
X-Gm-Message-State: AOAM531aZwkzLvH/9WewyiAmDekYVOAriqvbM1B+uU4zIYB3/Gon4jUi
        s3AIWgDE336mQvX2c2OfDeVLGQpLurnRZmgT2r0e014XQg==
X-Google-Smtp-Source: ABdhPJxBihfwE23n5aRhaP8dlG6y/GIL3UOOTfhEDLl2OGlAxFhJl8cyaW/wzPNs0RS+sKec2ABEEpkCk4fuWn422Ow=
X-Received: by 2002:a05:6e02:1d8a:: with SMTP id h10mr14978548ila.51.1635923565546;
 Wed, 03 Nov 2021 00:12:45 -0700 (PDT)
MIME-Version: 1.0
References: <CAO8h3eEcK7c6M5T88K0MO6eQk64DY+85Mzsi5zdT9tV9mxiMfw@mail.gmail.com>
 <0a539c49-b92e-892e-5848-613ff745c283@hartkopp.net>
In-Reply-To: <0a539c49-b92e-892e-5848-613ff745c283@hartkopp.net>
From:   =?UTF-8?Q?Matthias_Wei=C3=9Fer?= <m.weisser.m@gmail.com>
Date:   Wed, 3 Nov 2021 08:12:34 +0100
Message-ID: <CAO8h3eEijXsgTN0hyxuCuhDms=z-W_8hj1UHWV3544HugsuoPA@mail.gmail.com>
Subject: Re: sjw in can_calc_bittiming
To:     Oliver Hartkopp <socketcan@hartkopp.net>, linux-can@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Hi Oliver

Thanks for your answer.

Am Di., 2. Nov. 2021 um 16:36 Uhr schrieb Oliver Hartkopp
<socketcan@hartkopp.net>:
>
> > We can fix this quite easily by specifying a higher sjw value.
>
> You can specify the sjw value with the ip command (for CAN FD there is
> also a dsjw). And IIRC you can set it to the max. value for your CAN
> controller if you define sjw to be 4.

I know that and this is my current solution. And I am totally happy with that.
Sorry if this wasn't clear in my original message.

My question was if it makes sense to change the default in can_calc_bittiming()
to something more adaptive than just 1 depending on the total number of tq.
This may prevent others from hitting the same problem as I did.

If you can take some time and rethink my original question that would be great

> > Wouldn't it make sense to increase sjw in can_calc_bittiming() to something
> > like 5% of the total time quanta? This may increase the reliability of the CAN
> > network when there are differences in the bitrates of the single members. Are
> > there any arguments against such an arbitrary selection of sjw?

Regards

Matthias
