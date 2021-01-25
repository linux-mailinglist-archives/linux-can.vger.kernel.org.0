Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 08BF6302406
	for <lists+linux-can@lfdr.de>; Mon, 25 Jan 2021 12:03:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727676AbhAYLCS (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Mon, 25 Jan 2021 06:02:18 -0500
Received: from mx2.suse.de ([195.135.220.15]:55500 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727691AbhAYLAU (ORCPT <rfc822;linux-can@vger.kernel.org>);
        Mon, 25 Jan 2021 06:00:20 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 6C6CEAD8C;
        Mon, 25 Jan 2021 10:59:38 +0000 (UTC)
References: <20210120143723.26483-1-rpalethorpe@suse.com>
 <20210120143723.26483-3-rpalethorpe@suse.com>
 <058a6f05-d5ca-0746-dc4e-007253d3a84d@hartkopp.net>
User-agent: mu4e 1.4.14; emacs 27.1
From:   Richard Palethorpe <rpalethorpe@suse.de>
To:     Oliver Hartkopp <socketcan@hartkopp.net>,
        Petr Vorel <pvorel@suse.cz>
Cc:     ltp@lists.linux.it, linux-can@vger.kernel.org,
        Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH v3 2/7] can: Add can_common.h for vcan device setup
Reply-To: rpalethorpe@suse.de
In-reply-to: <058a6f05-d5ca-0746-dc4e-007253d3a84d@hartkopp.net>
Date:   Mon, 25 Jan 2021 10:59:37 +0000
Message-ID: <87bldd9t9i.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Hello Oliver and Petr,

Oliver Hartkopp <socketcan@hartkopp.net> writes:

> Hello Richard,
>
> On 20.01.21 15:37, Richard Palethorpe wrote:
>> Note that we call modprobe to set echo=1. However this does seem to be
>> necessary for the current tests on 5.10. It has been kept to avoid
>> changing the test behavior unnecessarily, but can most likely be
>> safely removed if it causes problems.
>
> Without echo=1 a shortcut in af_can.c is used.
>
> I just checked that it works too - but with echo=1 we increase the
> test coverage to a test of the message flow down to the virtual CAN
> driver vcan.

Ah, thanks, I will amend the comments.

>
>> Signed-off-by: Richard Palethorpe <rpalethorpe@suse.com>
>> ---
>>   .../network/can/filter-tests/can_common.h     | 75 +++++++++++++++++++
>>   1 file changed, 75 insertions(+)
>>   create mode 100644 testcases/network/can/filter-tests/can_common.h
>> diff --git a/testcases/network/can/filter-tests/can_common.h
>> b/testcases/network/can/filter-tests/can_common.h
>> new file mode 100644
>> index 000000000..f15145f30
>> --- /dev/null
>> +++ b/testcases/network/can/filter-tests/can_common.h
>> @@ -0,0 +1,75 @@
>> +// SPDX-License-Identifier: GPL-2.0-or-later
>> +/*
>> + * Copyright (c) 2021 SUSE LLC
>> + */
>> +
>> +#include <stdio.h>
>> +#include <stdlib.h>
>> +#include <unistd.h>
>> +#include <string.h>
>> +
>> +#include <sys/types.h>
>> +#include <sys/socket.h>
>> +#include <sys/ioctl.h>
>> +#include <sys/time.h>
>> +
>> +#include "tst_cmd.h"
>> +#include "tst_safe_stdio.h"
>> +#include "tst_safe_file_ops.h"
>> +
>> +#include <linux/if.h>
>> +#include <linux/can.h>
>> +#include <linux/can/raw.h>
>> +
>> +#ifndef IFF_ECHO
>> +# define IFF_ECHO (1<<18)
>> +#endif
>
> IFF_ECHO was included into Linux 2.6.25 together with the CAN
> subsystem itself.
>
> So when you run the tests on Kernels < 2.6.25 you don't have CAN
> support and don't need IFF_ECHO too.

Petr, what kernel version and/or distro version did compilation fail on?

There is a small chance someone might be compiling with old kernel
headers relative to their kernel. However it is a challenge to compile
LTP with such an old user land.

>
> Regards,
> Oliver
>
>> +
>> +static char *can_dev_name;
>> +static int can_created_dev;
>> +
>> +static void can_cmd(const char *const argv[])
>> +{
>> +	tst_cmd(argv, NULL, NULL, TST_CMD_TCONF_ON_MISSING);
>> +}
>> +
>> +#define CAN_CMD(...) can_cmd((const char *const[]){ __VA_ARGS__, NULL })
>> +
>> +static void can_setup_vcan(void)
>> +{
>> +	unsigned int flags;
>> +	char *path;
>> +
>> +	if (can_dev_name)
>> +		goto check_echo;
>> +
>> +	can_dev_name = "vcan0";
>> +
>> +	tst_res(TINFO, "Creating vcan0 device; use -D option to avoid this");
>> +
>> +	CAN_CMD("modprobe", "-r", "vcan");
>> +	CAN_CMD("modprobe", "vcan", "echo=1");
>> +
>> +	can_created_dev = 1;
>> +
>> +	CAN_CMD("ip", "link", "add", "dev", "vcan0", "type", "vcan");
>> +	CAN_CMD("ip", "link", "set", "dev", "vcan0", "up");
>> +
>> +check_echo:
>> +	/* Precondition for the frame flow test? */
>> +	SAFE_ASPRINTF(&path, "/sys/class/net/%s/flags", can_dev_name);
>> +	if (FILE_SCANF(path, "%x", &flags) || !(flags & IFF_ECHO)) {
>> +		tst_res(TWARN, "Could not determine if ECHO is set on %s",
>> +			can_dev_name);
>> +	}
>> +}
>> +
>> +static void can_cleanup_vcan(void)
>> +{
>> +	if (!can_created_dev)
>> +		return;
>> +
>> +	CAN_CMD("ip", "link", "set", "dev", "vcan0", "down");
>> +	CAN_CMD("ip", "link", "del", "dev", "vcan0");
>> +	CAN_CMD("modprobe", "-r", "vcan");
>> +}
>> 


-- 
Thank you,
Richard.
