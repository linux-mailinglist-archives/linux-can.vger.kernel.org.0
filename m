Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9B058305578
	for <lists+linux-can@lfdr.de>; Wed, 27 Jan 2021 09:19:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232103AbhA0IS0 (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Wed, 27 Jan 2021 03:18:26 -0500
Received: from mo4-p00-ob.smtp.rzone.de ([85.215.255.23]:13709 "EHLO
        mo4-p00-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231280AbhA0IB6 (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Wed, 27 Jan 2021 03:01:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1611734273;
        s=strato-dkim-0002; d=hartkopp.net;
        h=In-Reply-To:Date:Message-ID:From:References:Cc:To:Subject:Cc:Date:
        From:Subject:Sender;
        bh=6hw3wFjxLaMNsfWzr8wfI0Pit3rYtFzmPxn+oIQNvdA=;
        b=D2o7zRNBktK5F5rtCRikggo6NNjHHwZrbEBUvTf+wLIpWYL63MRMiNIE3YhLLmWhzW
        qq/kZN+eUykIxipEQF/iClh64ZqgVjKPRMsXXIpoDGDsIypCcNJciLOC4zH6xDJVXci6
        Yj12r3RHaqzuFYYF4oSqo3axdrBzvVrebIW5N8XsaECfed517j+98qAOefjJDtsBjYyG
        JFzfU34sHD6FY2iTv6FAr+dObB30qoCVD0EMJ4wKVpdz+bi0zDv/6mGildBGTjOMVcwe
        T843Q20fsQUrqIF5qPb/a+bmZfpwNhxGf7srMjZCQhUZnRalj0z4GF1r5c9WeNKI1dVD
        rxqA==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjG14FZxedJy6qgO1o3TMaFqTEVR9J8xty10="
X-RZG-CLASS-ID: mo00
Received: from [192.168.10.137]
        by smtp.strato.de (RZmta 47.15.2 SBL|AUTH)
        with ESMTPSA id 60826fx0R7qo2lv
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
        Wed, 27 Jan 2021 08:52:50 +0100 (CET)
Subject: Re: [PATCH v3 2/7] can: Add can_common.h for vcan device setup
To:     Petr Vorel <pvorel@suse.cz>,
        Richard Palethorpe <rpalethorpe@suse.de>
Cc:     ltp@lists.linux.it, linux-can@vger.kernel.org,
        Marc Kleine-Budde <mkl@pengutronix.de>
References: <20210120143723.26483-1-rpalethorpe@suse.com>
 <20210120143723.26483-3-rpalethorpe@suse.com>
 <058a6f05-d5ca-0746-dc4e-007253d3a84d@hartkopp.net> <87bldd9t9i.fsf@suse.de>
 <20210126212855.GC15365@pevik>
From:   Oliver Hartkopp <socketcan@hartkopp.net>
Message-ID: <64f599af-f2a7-901d-06a6-a5ff56a107a2@hartkopp.net>
Date:   Wed, 27 Jan 2021 08:52:45 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <20210126212855.GC15365@pevik>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Hi Petr,

On 26.01.21 22:28, Petr Vorel wrote:
> Hi Oliver, Richie,
> 
>>>> --- /dev/null
>>>> +++ b/testcases/network/can/filter-tests/can_common.h
>>>> @@ -0,0 +1,75 @@
>>>> +// SPDX-License-Identifier: GPL-2.0-or-later
>>>> +/*
>>>> + * Copyright (c) 2021 SUSE LLC
>>>> + */
>>>> +
>>>> +#include <stdio.h>
>>>> +#include <stdlib.h>
>>>> +#include <unistd.h>
>>>> +#include <string.h>
>>>> +
>>>> +#include <sys/types.h>
>>>> +#include <sys/socket.h>
>>>> +#include <sys/ioctl.h>
>>>> +#include <sys/time.h>
>>>> +
>>>> +#include "tst_cmd.h"
>>>> +#include "tst_safe_stdio.h"
>>>> +#include "tst_safe_file_ops.h"
>>>> +
>>>> +#include <linux/if.h>
>>>> +#include <linux/can.h>
>>>> +#include <linux/can/raw.h>
>>>> +
>>>> +#ifndef IFF_ECHO
>>>> +# define IFF_ECHO (1<<18)
>>>> +#endif
> Thanks a lot, Richie!
> 
>>> IFF_ECHO was included into Linux 2.6.25 together with the CAN
>>> subsystem itself.
> 
>>> So when you run the tests on Kernels < 2.6.25 you don't have CAN
>>> support and don't need IFF_ECHO too.
> 
>> Petr, what kernel version and/or distro version did compilation fail on?
> 
>> There is a small chance someone might be compiling with old kernel
>> headers relative to their kernel. However it is a challenge to compile
>> LTP with such an old user land.
> 
> No, we don't support 2.6.25 :). I was playing with Buildroot distro in my spare time.
> These embedded toolchains suffer compatibility problems (usually uclibc-ng and
> sometimes musl lack the support). This problem was when using sourcery-arm-*.

:-/

> But this is definitely not a blocker for this patchset. That lapi is not a must,
> I can fix it some time later. I usually fix few of these problems before each
> LTP release.

Ok. No problem. I wasn't aware that e.g. musl or other toolchains select 
such strange starting points for their include files.

Thanks,
Oliver
