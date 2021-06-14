Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 785C53A5E6D
	for <lists+linux-can@lfdr.de>; Mon, 14 Jun 2021 10:32:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232617AbhFNIeu (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Mon, 14 Jun 2021 04:34:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232546AbhFNIet (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Mon, 14 Jun 2021 04:34:49 -0400
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A13EC061574
        for <linux-can@vger.kernel.org>; Mon, 14 Jun 2021 01:32:47 -0700 (PDT)
Received: by mail-lj1-x229.google.com with SMTP id z22so18983751ljh.8
        for <linux-can@vger.kernel.org>; Mon, 14 Jun 2021 01:32:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=smile-fr.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=35OIADZf3Zib/l8yyoH9XWcjiZc4+9KjqhlM5wbqk/I=;
        b=eQmY7AF3+HK8oyQRXd4Y0hJV88ojfovklLcHrA19ov3s9B6GukjxC2IE9W4J6TGs9W
         9DUYHT6RTCdddjJqrvuPisTIpGRl7k4RU0n5U8O36AgYGlOHRUaJNZH/UrWfSc7pkwUp
         RVDCWimE9OzQuseDmxnNORHZqZREwSmvp1cLmMPUMWwCuQf3P+fEGgeAFhWsBmRVYXj5
         w1oYPBBS9eREDpbcnRblTynbqk0ZbV2cVwHdeSqiM51USggDeUVJHsb2aZQ26Ds8wWir
         m7lbXAETYEWlGoPiaKl6US83F30dL/wDCrepc72bQRS6fWpib+gRg9GNsq2gIuNU/d6E
         A5hQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:content-transfer-encoding;
        bh=35OIADZf3Zib/l8yyoH9XWcjiZc4+9KjqhlM5wbqk/I=;
        b=Zc4Ml3CpJYyd0eHDdoXTyTL1PGTS4bzbnKymsR/nsB4ispPEiP5i+2CJ3Eqs+v9g38
         XvSiQSxdad09ZRMBSLUx1ARdhJAb2MsX8Z6AEzR5CIbSCNFBAoSDPfjTZFYg2NpJGwdB
         +DXnY2jseqgte4yLvmSYZVFv2m1BU54l2xFLWfAAFHOsci9lGq+ydX/bzWXsfNXPpkRW
         UFwbgX2YrEr8enRcjD9+s5oJAEk/SVCP7PmybrsTdY7A0eKXypC6vQN+i7AYmGGKDOkF
         uiNS9iEf5gxzEKbqOsB5PSpxqJ8ZBrte/eQziUUmOk+zcxLUKog9SRadXQ20jOP0HEOx
         ZxeQ==
X-Gm-Message-State: AOAM532jPIZsw1LXXIyLDhJ9l6ou1/pwa6DViEuqiv1bnSWoPOMYo5X2
        cfO++Zxgn29sZ0HXGqYHTuRpP9fISsotpdslN8gb5E/sXetvrw==
X-Google-Smtp-Source: ABdhPJyHgWOtSWBERacrSDgfSVKADgvX3U0Pdf2qtE+HMNdvAH3aOJmJqLIWxuqr7y9g8WQJRx+JPDU0Y9M9l4bU4SM=
X-Received: by 2002:a2e:b790:: with SMTP id n16mr10967188ljo.9.1623659565348;
 Mon, 14 Jun 2021 01:32:45 -0700 (PDT)
MIME-Version: 1.0
References: <CAEWvZg2rvR=9kE_wcm-KtzMvDtnqTEXSLF56zrB=3TgqZbEs1w@mail.gmail.com>
 <20210611041232.6avft7jhzsqcuuwc@pengutronix.de> <20210611065708.GA2028@x1.vandijck-laurijssen.be>
In-Reply-To: <20210611065708.GA2028@x1.vandijck-laurijssen.be>
From:   =?UTF-8?Q?R=C3=A9my_DZIEMIASZKO?= <remy.dziemiaszko@smile.fr>
Date:   Mon, 14 Jun 2021 10:32:34 +0200
Message-ID: <CAEWvZg3vk7WUr1S-e0VxWd-BuFgf51m9WXyASeCssAPc2Yo+dg@mail.gmail.com>
Subject: Re: How to statically set J1939 addresses and names
To:     =?UTF-8?Q?R=C3=A9my_DZIEMIASZKO?= <remy.dziemiaszko@smile.fr>,
        Oleksij Rempel <o.rempel@pengutronix.de>,
        linux-can@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Le ven. 11 juin 2021 =C3=A0 08:57, Kurt Van Dijck
<dev.kurt@vandijck-laurijssen.be> a =C3=A9crit :
>
> On Fri, 11 Jun 2021 06:12:32 +0200, Oleksij Rempel wrote:
> > Hi R=C3=A9my,
> >
> > On Tue, Jun 08, 2021 at 05:27:45PM +0200, R=C3=A9my DZIEMIASZKO wrote:
> > > Hello,
> > >
> > > I need that my applications do not care about J1939 node addresses bu=
t
> > > directly bind / connect to socket based on node name only and the
> > > kernel takes care of the conversion to addresses.
> > >
> > > I know this is possible if addresses are dynamically assigned through
> > > the Address Claiming protocol that is implemented in the kernel. The
> > > kernel keeps track of its own address and name as well as the
> > > addresses and names of other ECUs on the network and convert name to
> > > adresse when requested by the applications.
> > >
> > > But I don't want to use the Address Claiming protocol. I want to
> > > statically set all addresses and names.
>
> It is supported to not use Address Claiming.
>
> > >
> > > Is there a way to assign J1939 addresses and names to a CAN interface
> > > without using the J1939 address claim protocol?
> >
> > Current version do not have this functionality.
>
> If you bind() your socket with only sockaddr_can.j1939.sa set to your
> SA, and sockaddr_can.j1939.name to 0, makes your socket use your SA as
> static address.
>
> >
> > > I found in old j1939 kernel documentation something like
> > > ip addr add dev canX j1939 0xXX
> > > ip addr add dev canX j1939 name 0xXX
> > > See https://www.spinics.net/lists/netdev/msg162350.html
> > >
> > > But in the latest j1939 kernel documentation I do not find any
> > > reference to these commands.
> >
> > Yes, it was pre mainline version. For mainlining we reduced UAPI to the
> > minimum to simplify reviewing, mainlining and testing process.
> >
>
> The strict addressing was rejected because it felt much heavier than
> what most CAN users were used to. Moving to the current ad-hoc
> implementation allowed to drop quite some kernel code too.
>
Hi Kurt,

When I develop my application I don't know it's source address. I only
know its name.
In the future my application shall be integrated in different
projects/vehicules.
For each project, the source_address may be different but the name
will never change.
I don't want to adapt the source code of the application for each
project so I don't want to bind/connect to source_addresses but to
names.
That's why it would be nice if the platform / the kernel does the
translation name --> source_address.
