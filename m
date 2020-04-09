Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 658BE1A2F7B
	for <lists+linux-can@lfdr.de>; Thu,  9 Apr 2020 08:47:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725783AbgDIGrD (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Thu, 9 Apr 2020 02:47:03 -0400
Received: from mail-ed1-f51.google.com ([209.85.208.51]:40017 "EHLO
        mail-ed1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725765AbgDIGrD (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Thu, 9 Apr 2020 02:47:03 -0400
Received: by mail-ed1-f51.google.com with SMTP id w26so11962874edu.7
        for <linux-can@vger.kernel.org>; Wed, 08 Apr 2020 23:47:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=8devices-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=UFxzYdSSCkFIXFjE/G/Rlrwy0h3MpanBlFfMxGgjEMc=;
        b=Bogj2DlUjox9ahA5Gw4wlel5dzU0+hqIMQvIOtd8QhCK5PcEZS02b7R/9NJBblp17n
         OKRlvv//FHvziOUKO8GdboZklo+0kD7weDcToG9V1Sg1rsCAtKuZ3r1ISEDdJRk19rpJ
         bPSjn6UtNpV/a0EsBUzKG5/pvG0xIobsqnq70bPbeyymeLfFPUMvoBXA1G5tNblok16y
         zpM0c6n6mBLttYUWuFXAFCn0mv08CYokgz8CrSVKCotaB5Ms2ieURMxfA4EEvq0s3/tK
         F+E9QcFSBTSPsLSwP3gFoGY+tTiYdYGLgitSG22SxkqrDGy/7fsSCy2wYEDjCY/HAePy
         cq2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=UFxzYdSSCkFIXFjE/G/Rlrwy0h3MpanBlFfMxGgjEMc=;
        b=stv/RZzkTH0wM5NLvwxlLmO07I645gM2kX6eIKQMOwro7AD/e5uKD0kHpI0zuGMQNT
         J3AW6Y2Ly+N6A+Z6343MJ/hs5qQMhfd8GOc38AVOWksueGvXmTI6tRubIF2RgbkwfJEt
         5oFlAr03yZTEShvHu61q9QL/plEXHrxPxtch00UcEW63sDQW8Wldi9HeJCni+pZkRpgf
         IN1x47V1d1s0bsh9LIPk2PGlQ79/xZ1CPbL8REWBsCw164Kr1D/idb2fk7h2OneQbnz+
         ksxZfBRdTMlyOY4z6C1cqVapoIh55UXXa4wd1kVJaKj0U7NEIlytjJURU5Roe+KxAPUi
         zKrg==
X-Gm-Message-State: AGi0Puarf1JQiuqLiNBdEKSbKoS16wTBhkXQU9+DIkrgmIW6wTxjZp4m
        eOGpdYscE96hCpq1fpFdAcq/YAq4lFP3pIvq/2yxBg==
X-Google-Smtp-Source: APiQypIRIP07Pi3dVFCmCFrqSuEQ7ubL9AmbOuofrGq3ppD9vsGJ3oVnh31GKMeP8k2TQwQsK8IwpgGdODoRZ4UkWHY=
X-Received: by 2002:a17:906:1251:: with SMTP id u17mr9723300eja.315.1586414821717;
 Wed, 08 Apr 2020 23:47:01 -0700 (PDT)
MIME-Version: 1.0
References: <CAFnz-BWK_c63YyZ2KzMq=EWn6yfEQyyX+Vo7WSh4SddyY7PCfQ@mail.gmail.com>
 <f17f8d95-96b4-4d51-4390-1fb6a1e47fc8@grandegger.com> <871rp4he0s.fsf@steelpick.2x.cz>
In-Reply-To: <871rp4he0s.fsf@steelpick.2x.cz>
From:   =?UTF-8?Q?Andrejus_Fal=C4=8Dikas?= <andrejus.f@8devices.com>
Date:   Thu, 9 Apr 2020 09:46:48 +0300
Message-ID: <CAFnz-BUVcSwN6tFUS6W3Y9HUKsbf5am2x=BccSXzX-pRSh9G6w@mail.gmail.com>
Subject: Re: Fwd: usb_8dev - WARN_ON(in_irq()) Ticket #00560
To:     Michal Sojka <michal.sojka@cvut.cz>
Cc:     Wolfgang Grandegger <wg@grandegger.com>, socketcan@hartkopp.net,
        linux-can@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-can-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Hello,

this Ticket #00560 is closed.

Best regards,
Andrejus F.

On Fri, Apr 3, 2020 at 4:53 PM Michal Sojka <michal.sojka@cvut.cz> wrote:
>
> Hello Wolfgang,
>
> On Fri, Apr 03 2020, Wolfgang Grandegger wrote:
> > Hello Andrejus,
> >
> > please do not remove the history of this conversation! It's very
> > difficult to follow what you are speaking about...
> >
> > Am 03.04.20 um 15:04 schrieb Andrejus Fal=C4=8Dikas:
> >> Hello Mr. Oliver Hartkopp,
> >>
> >> I would like to notify you that the case described as the issue is
> >> caused by non-standard use of the device and protocol.
>
> [...]
>
> >
> > I observe a similar problem with the GS_USB CAN controller and I have
> > posted a patch recently here:
> >
> >   https://marc.info/?l=3Dlinux-can&m=3D158504888512764&w=3D2
> >
> > Could you please give the patch for your device below a try:
>
> It would be great if Andrejus can try the patch. If not, I'll try it
> after I get back to work where I have the device. Unfortunately, due to
> current situation, I'm not sure when it will happen.
>
> Thanks.
> -Michal
