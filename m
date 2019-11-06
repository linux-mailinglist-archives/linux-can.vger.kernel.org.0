Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CDDE2F1C61
	for <lists+linux-can@lfdr.de>; Wed,  6 Nov 2019 18:23:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728983AbfKFRXV (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Wed, 6 Nov 2019 12:23:21 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:39418 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729259AbfKFRXV (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Wed, 6 Nov 2019 12:23:21 -0500
Received: by mail-pf1-f194.google.com with SMTP id x28so16204952pfo.6
        for <linux-can@vger.kernel.org>; Wed, 06 Nov 2019 09:23:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=u87tALLXQcW+sUDGP6FjEXaWEAkJG/UJ3qyPmvU9Pbo=;
        b=WMxnigyo6xUBvzpbSA1wjKPA5jd2PkENPCBriMRlbjTw8dh9q0mLo4QIfbu1Ntm237
         548APoG7OLesSuHWubonOhp6mmkHwONnv668nfjh6lkOKOaodUk/MLyc1Z/AGQ8QDaGC
         I1iuvoTcTsEbYoFr1ou2tmlau654WK6GqE3WQKONVki2U6r3uEj3TP7qvgVGZMtNNzr3
         +rGOeOJY5QKGJ+CIURg+v4MAYJv3DNtd3E1QuldvTbiOYmq0DZ9Bua4QnSCWtU3Ec8tZ
         LvOBZWO3hZTvfW2K54EFebEgE4Ogd17uXjR0EUsUnLjxFxf9flLQhrYq8HQ0wSw79VRz
         LwzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=u87tALLXQcW+sUDGP6FjEXaWEAkJG/UJ3qyPmvU9Pbo=;
        b=HUC5Q+qTxOAkguS3FguuX+U7mesHpQqXTAYIn52qSIlSq2xYFF/BpvrMx5B7rpemsb
         UrPyd7YwCTnlIceu/DdAdaQ4j+y60e6mH20mpfBgY9W6PsOmMn0X0fuO1lMiVpsdII36
         pHOv/NnVDAK1Dy1EwQpHRm7N+72h8TLkPUV6rpdSd8dRPivhe68MNUMzleIS50U8s5JH
         ryrO52MD/t5fxmxroJj0GB8U7lpjJb7bNayd5yWumfXi0P/2v1lDmnCTxSRmP/Fh+N7I
         3zI5T2U3vDZXsE36b0wsPDyGBDcYhY4jNpa0t9CijadZqDFvpc/bKJEz+0JECLWu+Yjt
         DGzQ==
X-Gm-Message-State: APjAAAWK1Qvrq5AXISU+ZWoA0Vmbzu9AkS2wyTBscFaXEnCp2KzV4SPK
        p3tZpdjw8eaPgaijK0nVqyaKgYSmCXfmu3zPynSudPMQzhk=
X-Google-Smtp-Source: APXvYqxdJ+H9gDBMaRpw999OikD89a5fIR+rSQHfrFD6BZBvJn2yixtSi1SGp/8W8DP8nm+8DZpkoPt4cmdfsk/fVac=
X-Received: by 2002:a63:1c06:: with SMTP id c6mr4164708pgc.417.1573061000543;
 Wed, 06 Nov 2019 09:23:20 -0800 (PST)
MIME-Version: 1.0
References: <CADNXvDw5KDju9pHaRY1_6T-GgoOo=T2i4FZJRvd0GuP0jZis=g@mail.gmail.com>
 <CADNXvDy5qj0=tUQ1h_aN4UuCRtnXQ+4y55+JSKneyx9-C1CyBA@mail.gmail.com>
 <7e91f790-22f5-070c-f56d-a432779c7e4d@hartkopp.net> <D5447E34-0D39-470F-A4FF-D9530F91359E@vandijck-laurijssen.be>
 <f11ebe09-1ce9-0b4c-2c6c-f6a0d2383696@hartkopp.net>
In-Reply-To: <f11ebe09-1ce9-0b4c-2c6c-f6a0d2383696@hartkopp.net>
From:   Jaroslav Beran <jara.beran@gmail.com>
Date:   Wed, 6 Nov 2019 18:23:07 +0100
Message-ID: <CADNXvDzewkO8L-3LYNtt=JsMTmf8rw5uOaquF5mB2OS_5fKaTA@mail.gmail.com>
Subject: Re: Fwd: Return value of write() in BUS-OFF state
To:     Oliver Hartkopp <socketcan@hartkopp.net>
Cc:     Kurt Van Dijck <kurt@vandijck-laurijssen.be>,
        linux-can@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-can-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

On Wed, Nov 6, 2019 at 3:26 PM Oliver Hartkopp <socketcan@hartkopp.net> wro=
te:
>
>
>
> On 06/11/2019 12.23, Kurt Van Dijck wrote:
> >
> >
> > On 6 November 2019 12:12:39 GMT+01:00, Oliver Hartkopp <socketcan@hartk=
opp.net> wrote:
> >> Hello Jaroslav,
> >>
> >> On 05/11/2019 22.46, Jaroslav Beran wrote:
> >>
> >>> So far I've learned this issue is most probably caused by upper (net
> >>> and can) layers (so this is not specific for certain controller
> >>> driver). When a driver calls can_bus_off, it sets carrier-off and
> >>> triggers linkwatch_* actions that deactivate net queues and
> >> substitute
> >>> a struct qdisc with `noop_qdisc`. Upon sending a frame, it's enqueue
> >>> function - noop_enqueue - just returns NET_XMIT_CN, which is
> >>> transformed by net_xmit_errno macro to zero, that's passed by
> >>> net/can/af_can.c:can_send up to a userspace caller of write as
> >>> success.
> >>
> >> Hm.
> >>
> >>> According to description for qdisc return codes in
> >>> include/linux/netdevice.h, NET_XMIT_CN stands for `congestion
> >>> notification` and further
> >>>
> >>> /* NET_XMIT_CN is special. It does not guarantee that this packet is
> >> lost. It
> >>>    * indicates that the device will soon be dropping packets, or
> >> already drops
> >>>    * some packets of the same priority; prompting us to send less
> >> aggressively. */
> >>>
> >>>
> >>> Is this behavior appropriate for a node in BUS-OFF state? I'd rather
> >>> expect such controller would be always dropping all frames (not just
> >>> soon and some) until reset.
> >>
> >> The common use of the net_xmit_errno macro probably really does not fi=
t
> >>
> >> to the CAN specialties ...
> >>
> >>> In current situation a caller of write gets success even if his frame
> >>> is lost for sure. Is there any specific reason for this? Of course he
> >>> can be notified by receiving error frame, but why don't just return
> >>> error in can_send?
> >>
> >> Yes. It makes sense to forward the carrier-off state that is thankfull=
y
> >>
> >> provided by the linkwatch triggers to the user space.
> >>
> >> Looking to man(2) send we should provide -ENOBUFS in the case of
> >> carrier-off state, right?
> > ENOBUFS seems a bad indication. What about ENETDOWN instead?
>
> ENETDOWN shows that the interface is "down" which does not fit the
> current situation.
>
> The interface is "up" but the carrier is "off".
>
> man(2) send says:
>
> ENOBUFS
>        The output queue for a network interface was full.  This  gener=E2=
=80=90
>        ally  indicates  that the interface has stopped sending, but may
>        be caused by transient congestion.  (Normally, this does not oc=E2=
=80=90
>        cur  in  Linux.  Packets are just silently dropped when a device
>        queue overflows.)
>
> Fits to me !?
>

I don't know, neither option doesn't perfectly fit for the carrier-off
state to me.

What about choosing another code like ENOSPC or EIO to distinguish
bus-off from other recoverable conditions?

Best regards,
Jaroslav

> Best,
> Oliver
