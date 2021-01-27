Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4F920305AFB
	for <lists+linux-can@lfdr.de>; Wed, 27 Jan 2021 13:15:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235395AbhA0MPb (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Wed, 27 Jan 2021 07:15:31 -0500
Received: from mx2.suse.de ([195.135.220.15]:45670 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237674AbhA0MOS (ORCPT <rfc822;linux-can@vger.kernel.org>);
        Wed, 27 Jan 2021 07:14:18 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id CDB55ACC6;
        Wed, 27 Jan 2021 12:13:36 +0000 (UTC)
Date:   Wed, 27 Jan 2021 13:13:35 +0100
From:   Petr Vorel <pvorel@suse.cz>
To:     Richard Palethorpe <rpalethorpe@suse.de>
Cc:     Oliver Hartkopp <socketcan@hartkopp.net>, ltp@lists.linux.it,
        linux-can@vger.kernel.org, Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH v3 2/7] can: Add can_common.h for vcan device setup
Message-ID: <YBFY7w1vseKSA4Df@pevik>
Reply-To: Petr Vorel <pvorel@suse.cz>
References: <20210120143723.26483-1-rpalethorpe@suse.com>
 <20210120143723.26483-3-rpalethorpe@suse.com>
 <058a6f05-d5ca-0746-dc4e-007253d3a84d@hartkopp.net>
 <87bldd9t9i.fsf@suse.de>
 <20210126212855.GC15365@pevik>
 <64f599af-f2a7-901d-06a6-a5ff56a107a2@hartkopp.net>
 <87im7i94iu.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87im7i94iu.fsf@suse.de>
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Hi Richie,

<snip>
> >>>> IFF_ECHO was included into Linux 2.6.25 together with the CAN
> >>>> subsystem itself.

> >>>> So when you run the tests on Kernels < 2.6.25 you don't have CAN
> >>>> support and don't need IFF_ECHO too.

> >>> Petr, what kernel version and/or distro version did compilation fail on?

> >>> There is a small chance someone might be compiling with old kernel
> >>> headers relative to their kernel. However it is a challenge to compile
> >>> LTP with such an old user land.
> >> No, we don't support 2.6.25 :). I was playing with Buildroot distro
> >> in my spare time.
> >> These embedded toolchains suffer compatibility problems (usually uclibc-ng and
> >> sometimes musl lack the support). This problem was when using sourcery-arm-*.

> > :-/

> >> But this is definitely not a blocker for this patchset. That lapi is not a must,
> >> I can fix it some time later. I usually fix few of these problems before each
> >> LTP release.

> > Ok. No problem. I wasn't aware that e.g. musl or other toolchains
> > select such strange starting points for their include files.

> I wonder Petr, is it still necessary to define IFF_ECHO now only
> <linux/if.h> is included? Or do they somehow symlink linux/if.h ->
> net/if.h?
No.

> Indeed it seems the current version of uclibc-ng doesn't include
> IFF_ECHO in <net/if.h>. OTOH musl does define it.
Yes => please keep that definition in can_common.h (enough here, we don't have
to bother with if.h when we don't have it yet).
And I'll send tonight patch to uclibc-ng.
The more mature musl is the less relevant uclibc-ng is.

Kind regards,
Petr
