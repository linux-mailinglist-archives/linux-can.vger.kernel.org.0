Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4C26C305583
	for <lists+linux-can@lfdr.de>; Wed, 27 Jan 2021 09:22:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229651AbhA0IVT (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Wed, 27 Jan 2021 03:21:19 -0500
Received: from mx2.suse.de ([195.135.220.15]:41734 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234726AbhA0ITQ (ORCPT <rfc822;linux-can@vger.kernel.org>);
        Wed, 27 Jan 2021 03:19:16 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 675C6AF17;
        Wed, 27 Jan 2021 08:18:34 +0000 (UTC)
References: <20210120143723.26483-1-rpalethorpe@suse.com>
 <20210120143723.26483-3-rpalethorpe@suse.com>
 <058a6f05-d5ca-0746-dc4e-007253d3a84d@hartkopp.net>
 <87bldd9t9i.fsf@suse.de> <20210126212855.GC15365@pevik>
 <64f599af-f2a7-901d-06a6-a5ff56a107a2@hartkopp.net>
User-agent: mu4e 1.4.14; emacs 27.1
From:   Richard Palethorpe <rpalethorpe@suse.de>
To:     Petr Vorel <pvorel@suse.cz>,
        Oliver Hartkopp <socketcan@hartkopp.net>
Cc:     ltp@lists.linux.it, linux-can@vger.kernel.org,
        Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH v3 2/7] can: Add can_common.h for vcan device setup
Reply-To: rpalethorpe@suse.de
In-reply-to: <64f599af-f2a7-901d-06a6-a5ff56a107a2@hartkopp.net>
Date:   Wed, 27 Jan 2021 08:18:33 +0000
Message-ID: <87im7i94iu.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Hello Petr & Oliver,

Oliver Hartkopp <socketcan@hartkopp.net> writes:

> Hi Petr,
>
> On 26.01.21 22:28, Petr Vorel wrote:
>> Hi Oliver, Richie,
>> 
>>>>> --- /dev/null
>>>>> +++ b/testcases/network/can/filter-tests/can_common.h
>>>>> @@ -0,0 +1,75 @@
>>>>> +// SPDX-License-Identifier: GPL-2.0-or-later
>>>>> +/*
>>>>> + * Copyright (c) 2021 SUSE LLC
>>>>> + */
>>>>> +
>>>>> +#include <stdio.h>
>>>>> +#include <stdlib.h>
>>>>> +#include <unistd.h>
>>>>> +#include <string.h>
>>>>> +
>>>>> +#include <sys/types.h>
>>>>> +#include <sys/socket.h>
>>>>> +#include <sys/ioctl.h>
>>>>> +#include <sys/time.h>
>>>>> +
>>>>> +#include "tst_cmd.h"
>>>>> +#include "tst_safe_stdio.h"
>>>>> +#include "tst_safe_file_ops.h"
>>>>> +
>>>>> +#include <linux/if.h>
>>>>> +#include <linux/can.h>
>>>>> +#include <linux/can/raw.h>
>>>>> +
>>>>> +#ifndef IFF_ECHO
>>>>> +# define IFF_ECHO (1<<18)
>>>>> +#endif
>> Thanks a lot, Richie!
>> 
>>>> IFF_ECHO was included into Linux 2.6.25 together with the CAN
>>>> subsystem itself.
>> 
>>>> So when you run the tests on Kernels < 2.6.25 you don't have CAN
>>>> support and don't need IFF_ECHO too.
>> 
>>> Petr, what kernel version and/or distro version did compilation fail on?
>> 
>>> There is a small chance someone might be compiling with old kernel
>>> headers relative to their kernel. However it is a challenge to compile
>>> LTP with such an old user land.
>> No, we don't support 2.6.25 :). I was playing with Buildroot distro
>> in my spare time.
>> These embedded toolchains suffer compatibility problems (usually uclibc-ng and
>> sometimes musl lack the support). This problem was when using sourcery-arm-*.
>
> :-/
>
>> But this is definitely not a blocker for this patchset. That lapi is not a must,
>> I can fix it some time later. I usually fix few of these problems before each
>> LTP release.
>
> Ok. No problem. I wasn't aware that e.g. musl or other toolchains
> select such strange starting points for their include files.

I wonder Petr, is it still necessary to define IFF_ECHO now only
<linux/if.h> is included? Or do they somehow symlink linux/if.h ->
net/if.h?

Indeed it seems the current version of uclibc-ng doesn't include
IFF_ECHO in <net/if.h>. OTOH musl does define it.

-- 
Thank you,
Richard.
