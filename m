Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1A5B4304472
	for <lists+linux-can@lfdr.de>; Tue, 26 Jan 2021 18:02:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728998AbhAZGBV (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Tue, 26 Jan 2021 01:01:21 -0500
Received: from mo4-p01-ob.smtp.rzone.de ([85.215.255.51]:18984 "EHLO
        mo4-p01-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727449AbhAYKYL (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Mon, 25 Jan 2021 05:24:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1611570031;
        s=strato-dkim-0002; d=hartkopp.net;
        h=In-Reply-To:Date:Message-ID:From:References:Cc:To:Subject:From:
        Subject:Sender;
        bh=lFAuS/sgHOUb2ncpj7VsITK/pd5OuzCG2iodqvLn4cU=;
        b=HZvNwi7/tIJWIpn038macHjpmaQJrYDYvYdQBTcHuXge04yVwRcDBS+a7VKyjqx5dY
        kxcMJV+dp4ZNRtaEZyohpaQJGwghJpNUP3tvuSznvHJupIrLJHDhqdI5Y4+dA2LbVAqf
        A8fD41iQypM+NDCOFIYSvD/7DF95w7w1G2pIaWxThYY77oR9EFdQ7wsIxI+HY69V3lDp
        /DZV1nWSbh8z3c20FuV8Tu0KuWxR0M5QGehGdD0DxiBDdPIeU+E6YJc2HVpn6Ebu5WDg
        VxNWu4eLoIB8OYllkffTgAt6lZ2DHvkwUvxbC11VfNpriNZzopHddQ0PE2wwce8P2HiO
        Fxzw==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjG14FZxedJy6qgO1o3TMaFqTEVR/J8xty10="
X-RZG-CLASS-ID: mo00
Received: from [192.168.10.137]
        by smtp.strato.de (RZmta 47.12.1 DYNA|AUTH)
        with ESMTPSA id k075acx0PAKRxO6
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
        Mon, 25 Jan 2021 11:20:27 +0100 (CET)
Subject: Re: [PATCH v3 2/7] can: Add can_common.h for vcan device setup
To:     Richard Palethorpe <rpalethorpe@suse.com>, ltp@lists.linux.it
Cc:     linux-can@vger.kernel.org, Marc Kleine-Budde <mkl@pengutronix.de>
References: <20210120143723.26483-1-rpalethorpe@suse.com>
 <20210120143723.26483-3-rpalethorpe@suse.com>
From:   Oliver Hartkopp <socketcan@hartkopp.net>
Message-ID: <058a6f05-d5ca-0746-dc4e-007253d3a84d@hartkopp.net>
Date:   Mon, 25 Jan 2021 11:20:26 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <20210120143723.26483-3-rpalethorpe@suse.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Hello Richard,

On 20.01.21 15:37, Richard Palethorpe wrote:
> Note that we call modprobe to set echo=1. However this does seem to be
> necessary for the current tests on 5.10. It has been kept to avoid
> changing the test behavior unnecessarily, but can most likely be
> safely removed if it causes problems.

Without echo=1 a shortcut in af_can.c is used.

I just checked that it works too - but with echo=1 we increase the test 
coverage to a test of the message flow down to the virtual CAN driver vcan.

> 
> Signed-off-by: Richard Palethorpe <rpalethorpe@suse.com>
> ---
>   .../network/can/filter-tests/can_common.h     | 75 +++++++++++++++++++
>   1 file changed, 75 insertions(+)
>   create mode 100644 testcases/network/can/filter-tests/can_common.h
> 
> diff --git a/testcases/network/can/filter-tests/can_common.h b/testcases/network/can/filter-tests/can_common.h
> new file mode 100644
> index 000000000..f15145f30
> --- /dev/null
> +++ b/testcases/network/can/filter-tests/can_common.h
> @@ -0,0 +1,75 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * Copyright (c) 2021 SUSE LLC
> + */
> +
> +#include <stdio.h>
> +#include <stdlib.h>
> +#include <unistd.h>
> +#include <string.h>
> +
> +#include <sys/types.h>
> +#include <sys/socket.h>
> +#include <sys/ioctl.h>
> +#include <sys/time.h>
> +
> +#include "tst_cmd.h"
> +#include "tst_safe_stdio.h"
> +#include "tst_safe_file_ops.h"
> +
> +#include <linux/if.h>
> +#include <linux/can.h>
> +#include <linux/can/raw.h>
> +
> +#ifndef IFF_ECHO
> +# define IFF_ECHO (1<<18)
> +#endif

IFF_ECHO was included into Linux 2.6.25 together with the CAN subsystem 
itself.

So when you run the tests on Kernels < 2.6.25 you don't have CAN support 
and don't need IFF_ECHO too.

Regards,
Oliver

> +
> +static char *can_dev_name;
> +static int can_created_dev;
> +
> +static void can_cmd(const char *const argv[])
> +{
> +	tst_cmd(argv, NULL, NULL, TST_CMD_TCONF_ON_MISSING);
> +}
> +
> +#define CAN_CMD(...) can_cmd((const char *const[]){ __VA_ARGS__, NULL })
> +
> +static void can_setup_vcan(void)
> +{
> +	unsigned int flags;
> +	char *path;
> +
> +	if (can_dev_name)
> +		goto check_echo;
> +
> +	can_dev_name = "vcan0";
> +
> +	tst_res(TINFO, "Creating vcan0 device; use -D option to avoid this");
> +
> +	CAN_CMD("modprobe", "-r", "vcan");
> +	CAN_CMD("modprobe", "vcan", "echo=1");
> +
> +	can_created_dev = 1;
> +
> +	CAN_CMD("ip", "link", "add", "dev", "vcan0", "type", "vcan");
> +	CAN_CMD("ip", "link", "set", "dev", "vcan0", "up");
> +
> +check_echo:
> +	/* Precondition for the frame flow test? */
> +	SAFE_ASPRINTF(&path, "/sys/class/net/%s/flags", can_dev_name);
> +	if (FILE_SCANF(path, "%x", &flags) || !(flags & IFF_ECHO)) {
> +		tst_res(TWARN, "Could not determine if ECHO is set on %s",
> +			can_dev_name);
> +	}
> +}
> +
> +static void can_cleanup_vcan(void)
> +{
> +	if (!can_created_dev)
> +		return;
> +
> +	CAN_CMD("ip", "link", "set", "dev", "vcan0", "down");
> +	CAN_CMD("ip", "link", "del", "dev", "vcan0");
> +	CAN_CMD("modprobe", "-r", "vcan");
> +}
> 
