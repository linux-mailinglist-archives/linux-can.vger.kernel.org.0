Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5F735E54A6
	for <lists+linux-can@lfdr.de>; Fri, 25 Oct 2019 21:50:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726342AbfJYTt4 (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Fri, 25 Oct 2019 15:49:56 -0400
Received: from mail-40135.protonmail.ch ([185.70.40.135]:33646 "EHLO
        mail-40135.protonmail.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726263AbfJYTt4 (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Fri, 25 Oct 2019 15:49:56 -0400
Date:   Fri, 25 Oct 2019 19:49:47 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
        s=default; t=1572032992;
        bh=pOcoG+1uWKVivAQa/vZr7QH7RXokY/nnQLPxVBkQk+0=;
        h=Date:To:From:Cc:Reply-To:Subject:In-Reply-To:References:
         Feedback-ID:From;
        b=sQRMnaJJZoLQlDGoSaNcNdfn64lDVv49kjt68NbBWc9qWJRthVufGm5ccz2conGvj
         yTuRWQHEXqgZy6ZvWeIbyzNsn5DCjF9Qq8DBoprmrtD0OAxdFo0M32ImOj6PD1NsVj
         xi9qYEBqSfh03bmyhYomnBzvqk6e6Tmq3VYRdm5U=
To:     Oleksij Rempel <o.rempel@pengutronix.de>
From:   Arnej <arnejduranovic@protonmail.com>
Cc:     "Romain Forlot [IoT.bzh]" <romain.forlot@iot.bzh>,
        "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>
Reply-To: Arnej <arnejduranovic@protonmail.com>
Subject: Re: Questions around J1939 backport to old kernel
Message-ID: <aHcanZVhvgbO9XqQBg9c6QdeJZmy9g5O5w9yK83_VqiUuKYCBe2Uh_1S7oaPDQq85QTPEgQME2WTpi96iTO0yzSYRIxYQ-L8VcC8oyR591E=@protonmail.com>
In-Reply-To: <20191025093949.ijb5qt5beq4qavnk@pengutronix.de>
References: <b2dd08f0-0390-21c8-83c5-c6c361e78d9c@iot.bzh>
 <20191018145333.a27j7d7f4zf3bqjd@pengutronix.de>
 <72a6f8b2-38e3-a54b-d719-10471d4d260b@iot.bzh>
 <20191025093949.ijb5qt5beq4qavnk@pengutronix.de>
Feedback-ID: c9lPUDIq9bPQt7k0eC-T4kp9KyHxaV2X5AZBTDn2bmvt0EtuEMC2szK_XDB-B4OqimNg3SVwbHFQtMPDoctxlw==:Ext:ProtonMail
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.2 required=7.0 tests=ALL_TRUSTED,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM autolearn=ham
        autolearn_force=no version=3.4.2
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on mail.protonmail.ch
Sender: linux-can-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Hello,

I am also very interested in back-porting. My project is currently on 4.9.9=
 and it is not possible to upgrade to the latest kernel at this time. I was=
 wondering if you had any thoughts on what is required to achieve this? For=
 example, it seems that the net stack in 5.4 is very different from 4.9 (ev=
en more so compared to 4.14) and I am having difficulties getting the kerne=
l to compile after following your cherry-pick suggestion. I'm wondering if =
you are familiar with the net changes and would know if it is a good idea t=
o continue to try back-porting (is it even possible?) or if you know of any=
 other option?

Best Regards,

Arnej Duranovic

On Friday, October 25, 2019 4:39 AM, Oleksij Rempel <o.rempel@pengutronix.d=
e> wrote:

> On Fri, Oct 25, 2019 at 09:38:39AM +0200, Romain Forlot [IoT.bzh] wrote:
>
> > I used it in the mainline kernel without troubles. This is a a very goo=
d
> > job, thanks.
> > Ok, thanks for the answer. May be I=C2=A0 will work on it in the next f=
ew months.
> > Let's see. I'll keep you informed.
>
> Thank you for testing. I hope to get more feed back :)
>
> > Regards.
> > On 18/10/2019 16:53, Oleksij Rempel wrote:
> >
> > > Hi,
> > > On Fri, Oct 18, 2019 at 12:07:34PM +0200, Romain Forlot [IoT.bzh] wro=
te:
> > >
> > > > Hi,
> > > > I am wondering what the cost is to backport the j1939 module to an =
old
> > > > version like a v4.14 LTSI version.
> > > > The backport should be quite easy:
> > >
> > > git cherry-pick -sx `git rev-list --reverse 2c1f9e26344483e2c74e80ef7=
08d9c7fd2e543f4..9d71dd0c70099914fcd063135da3c580865e924c`
> > > ...but it isn't :/ Some CAN patches are missing. We'll backport the s=
tack to
> > > v4.14.150 (or newer) and send a follow up mail.
> > > However, the driver for the CAN adapter needs proper RX/TX frame orde=
ring,
> > > otherwise the stack will explode.
> > > This is fixed in flexcan mainline. And involves a handful of patches.=
 Other
> > > drivers probably need more fixing. Some CAN hardware may even lack th=
e hardware
> > > support for proper ordering, that is time stamping registers.
> > >
> > > > And what the impact is of backporting the whole CAN stack on the CA=
N drivers?
> > > > The stack has no impact on the drivers, but requirements on proper =
RX/TX
> > > > ordering, see above.
> > >
> > > > Are there any modifications to drivers once the CAN stack is update=
d ?
> > > > Yes, as long as they don't have proper RX/TX ordering.
> > >
> > > So, which CAN driver are you planing to use?
> > > Regards,
> > > Oleksij & Marc
> >
> > --
> > Romain Forlot - Embedded Engineer - IoT.bzh
> > romain.forlot@iot.bzh - www.iot.bzh - +33675142438
>
> --
>
> Pengutronix e.K. | |
> Industrial Linux Solutions | http://www.pengutronix.de/ |
> Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0 |
> Amtsgericht Hildesheim, HRA 2686 | Fax: +49-5121-206917-5555 |


