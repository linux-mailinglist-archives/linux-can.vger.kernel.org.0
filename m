Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7D3AB29461C
	for <lists+linux-can@lfdr.de>; Wed, 21 Oct 2020 02:53:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2439779AbgJUAxS (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Tue, 20 Oct 2020 20:53:18 -0400
Received: from smtp06.smtpout.orange.fr ([80.12.242.128]:46313 "EHLO
        smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2439767AbgJUAxS (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 20 Oct 2020 20:53:18 -0400
Received: from tomoyo.flets-east.jp ([153.230.197.127])
        by mwinf5d64 with ME
        id iQt12300B2lQRaH03QtAwp; Wed, 21 Oct 2020 02:53:14 +0200
X-ME-Helo: tomoyo.flets-east.jp
X-ME-Auth: bWFpbGhvbC52aW5jZW50QHdhbmFkb28uZnI=
X-ME-Date: Wed, 21 Oct 2020 02:53:14 +0200
X-ME-IP: 153.230.197.127
From:   Vincent Mailhol <mailhol.vincent@wanadoo.fr>
To:     Marc Kleine-Budde <mkl@pengutronix.de>,
        Oliver Hartkopp <socketcan@hartkopp.net>,
        linux-can@vger.kernel.org
Cc:     Vincent Mailhol <mailhol.vincent@wanadoo.fr>,
        kernel@pengutronix.de,
        =?UTF-8?q?St=C3=A9phane=20Grosjean?= <s.grosjean@peak-system.com>
Subject: Re: [net-rfc 04/16] can: dev: can_get_len(): add a helper function to get the correct length of Classical frames
Date:   Wed, 21 Oct 2020 09:52:26 +0900
Message-Id: <20201021005226.2727-1-mailhol.vincent@wanadoo.fr>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <a9605011-2674-dc73-111c-8ebf724a13ac@hartkopp.net>
References: <20201019190524.1285319-1-mkl@pengutronix.de> <20201019190524.1285319-5-mkl@pengutronix.de> <fbbe1b80-c012-dc87-1eb0-4878cd08cce1@hartkopp.net> <ebf50f35-f093-b2c9-a27c-cef73d403efb@pengutronix.de> <20201020113023.102360-1-mailhol.vincent@wanadoo.fr> <6f869e47-9a76-3398-0b64-2d573d412f4c@hartkopp.net> <20201020160739.104686-1-mailhol.vincent@wanadoo.fr> <a9605011-2674-dc73-111c-8ebf724a13ac@hartkopp.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

>> Some professional tools such as the CAN testing suite of Defensics by
>> Synopsys also include these kind of tests. Because Socket CAN does not
>> support this, Synopsys actually recommends to use the proprietary
>> drivers from the Peak controller which do allow this (unfortunately,
>> the Defensics documentation is not available publicly so I can not
>> give you a link to support my claim on that last example).
> 
> Stephane from PEAK is working on the Linux driver (Mainline Linux & PEAK 
> chardev), so I put him on CC. Or are you referring to the Windows driver?

Good question. As far as I remember, the PEAK Windows driver and the
PEAK Linux char driver shares the same API and as such Defensics
supports both through a python middleware (the injector). This is only
true for Classical CAN. For CAN-FD, only Windows driver are officially
supported but hacking Defensics's injector code to have it run on
Linux is easily done (but that not the topic so let me end the
digression here).

>> I hope that I could highlight in this answer that I am more than just
>> a hobbyist who got exited after ready the ISO and that I know this
>> subject. What I explain here is well known in the niche community of
>> automotive security researcher but outside of it I just think that
>> people are not aware of it.
> 
> Well I have done a lot in automotive CAN security too - with message 
> authentication and with CAN IDS - but this DLC thing was still new to me ...

I also worked on CAN IDS. I was Japan regional FAE for the CycurIDS
product of Escrypt. Speaking of that, I believe you probably know Jan
Holle.

>  From a first thought I would see a new flag CAN_CTRLMODE_RAW_DLC in the 
> netlink interface of IFLA_CAN_CTRLMODE for the CAN controller driver.
> 
> This could switch the sanitizing AND the CAN controller can properly 
> expose its ability to support this mode.

Absolutely yes. In my first message, I mentioned the idea of managing
that through socket option, glad that we now share the same idea.

An other option I thought about would be to use one of the reserved
field of the struct can_frame but I am not fan of that second idea.

Do you want me to come back with an RFC patch? I already started to
thing about that months ago and did some testing. I identified the
code portion which have to be modified.

The only thing is that it will take me some time to draft a nice
proposal. Currently, I have another patch under review for a CAN
driver (https://lkml.org/lkml/2020/10/16/832), I want to finalize this
one first, and can get back to you after that. So that will mean that
we will be targeting Linux 5.11 end of this year, I do not think we
can squeeze that change in 5.10 merging windows.

> I think I have to pick a beer and look at some code ... :-)

Have a nice one! That might have been a shock for you :-)


Yours sincerely,
Vincent Mailhol
