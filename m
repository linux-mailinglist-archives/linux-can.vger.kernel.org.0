Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A58821A3296
	for <lists+linux-can@lfdr.de>; Thu,  9 Apr 2020 12:37:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725972AbgDIKhj (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Thu, 9 Apr 2020 06:37:39 -0400
Received: from mail-ed1-f54.google.com ([209.85.208.54]:41251 "EHLO
        mail-ed1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725970AbgDIKhj (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Thu, 9 Apr 2020 06:37:39 -0400
Received: by mail-ed1-f54.google.com with SMTP id v1so12669232edq.8
        for <linux-can@vger.kernel.org>; Thu, 09 Apr 2020 03:37:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=8devices-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Xjm22OJmnUP0QTGTjVQPn4Fh5TOkwUaQaai/1wAnbRE=;
        b=aLIUAzTCEiyZ8pdlY9zoETlCwYTzr5Cm6ktIDGWTMDkHdPhXQ4pu8SekWSsO3ZN/MO
         w7h0QeOO0mze1CRKVZEK8HK3GvdJdp+jPbiCQzdNjyhDwdbIOQd9It6VcYLPrtypZeHU
         vKZ8LpqnR+s5ugJ6eTRn6JZMC06bVZqU9WlY+/fJ5OkQAdBugYksVfUGZcXlU4nSG5KQ
         4+j5odcuR5P67+EKoNY/3TbDuVr7DtmJrdU3SXGVo2hR+p5v71R23Ri4sloZBPHZ4qux
         kmM1dRgq073cS6qdROOvwIIKPIObRgomzZnyxaIf0u5ReR6jCNuJMrOscq3DAX7SvlpK
         jiow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Xjm22OJmnUP0QTGTjVQPn4Fh5TOkwUaQaai/1wAnbRE=;
        b=VPTUR5HhQlQEatbSO15YMBUIVhXWGljyrXghBGZ0QbQA0NWknly0Pco4rQTCOnUKqC
         wVoZhzwz1qJ4Z9e7h2jOgMJyBl6McCBje3GYRF07Pr/mde/WHkzwLYSEkJQU/6PKkbJ0
         uYzwqVMJOTtQ4eWZ5YMzVOFgPhTpTj3tOjSaw46TtR0DL/JitKTYfbeP/Ss0X2MFSLxc
         8IwgxbQH74h1miiezqCB8yBrK2wef6AttS0j9k/512cfE2ksGHgm2WH+UYSCvvI6J7hI
         DbSaurw/su7UnzTyphS1GTic0TPKjIThp2Kfx5V3vbD56sojmarYxgeHEiatqWF8JG71
         3y7w==
X-Gm-Message-State: AGi0Pubd8+VZMo/9ozVhhfDevl/+/745F/9REiTPLdaQfJs6ClcDMyhB
        7kMwfJ5UYwJ1IhTDAu1Frrs/Su6LOMefmWu1OA/4Bg==
X-Google-Smtp-Source: APiQypIFKEgqpV8MGCvOVRfZR+aESt+MvZpODh8I1Ogj5QXswvmRES37IHoRxDbhBUzQTFmSQDcG7WkG17ZPkt9c6DA=
X-Received: by 2002:a50:cc95:: with SMTP id q21mr10219911edi.33.1586428658289;
 Thu, 09 Apr 2020 03:37:38 -0700 (PDT)
MIME-Version: 1.0
References: <CAFnz-BWK_c63YyZ2KzMq=EWn6yfEQyyX+Vo7WSh4SddyY7PCfQ@mail.gmail.com>
 <f17f8d95-96b4-4d51-4390-1fb6a1e47fc8@grandegger.com> <871rp4he0s.fsf@steelpick.2x.cz>
 <CAFnz-BUVcSwN6tFUS6W3Y9HUKsbf5am2x=BccSXzX-pRSh9G6w@mail.gmail.com> <44255c9f-9c22-7bbf-4426-34506bf8a2b0@grandegger.com>
In-Reply-To: <44255c9f-9c22-7bbf-4426-34506bf8a2b0@grandegger.com>
From:   =?UTF-8?Q?Andrejus_Fal=C4=8Dikas?= <andrejus.f@8devices.com>
Date:   Thu, 9 Apr 2020 13:37:27 +0300
Message-ID: <CAFnz-BU1hKPzMyXqgYw82Nt-z2rw+BRNGLvU38BBm-h84d1ztA@mail.gmail.com>
Subject: Re: Fwd: usb_8dev - WARN_ON(in_irq()) Ticket #00560
To:     Wolfgang Grandegger <wg@grandegger.com>
Cc:     Michal Sojka <michal.sojka@cvut.cz>, socketcan@hartkopp.net,
        linux-can@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-can-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Hello,

Thank you Mr. Wolfgang Grandegger for the patch. I checked and the
problem disappeared, any warnings do not appear in dmesg after the
"interface down".

Best regards,
Andrejus F.

On Thu, Apr 9, 2020 at 1:25 PM Wolfgang Grandegger <wg@grandegger.com> wrot=
e:
>
>
> Am 09.04.20 um 08:46 schrieb Andrejus Fal=C4=8Dikas:
> > Hello,
> >
> > this Ticket #00560 is closed.
>
> Which does not mean that the problem is gone ;)
>
> Wolfgang
>
> > On Fri, Apr 3, 2020 at 4:53 PM Michal Sojka <michal.sojka@cvut.cz> wrot=
e:
> >>
> >> Hello Wolfgang,
> >>
> >> On Fri, Apr 03 2020, Wolfgang Grandegger wrote:
> >>> Hello Andrejus,
> >>>
> >>> please do not remove the history of this conversation! It's very
> >>> difficult to follow what you are speaking about...
> >>>
> >>> Am 03.04.20 um 15:04 schrieb Andrejus Fal=C4=8Dikas:
> >>>> Hello Mr. Oliver Hartkopp,
> >>>>
> >>>> I would like to notify you that the case described as the issue is
> >>>> caused by non-standard use of the device and protocol.
> >>
> >> [...]
> >>
> >>>
> >>> I observe a similar problem with the GS_USB CAN controller and I have
> >>> posted a patch recently here:
> >>>
> >>>   https://marc.info/?l=3Dlinux-can&m=3D158504888512764&w=3D2
> >>>
> >>> Could you please give the patch for your device below a try:
> >>
> >> It would be great if Andrejus can try the patch. If not, I'll try it
> >> after I get back to work where I have the device. Unfortunately, due t=
o
> >> current situation, I'm not sure when it will happen.
> >>
> >> Thanks.
> >> -Michal
> >
> >
