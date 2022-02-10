Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3B434B146B
	for <lists+linux-can@lfdr.de>; Thu, 10 Feb 2022 18:41:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237627AbiBJRlU (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Thu, 10 Feb 2022 12:41:20 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:48414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238232AbiBJRlU (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Thu, 10 Feb 2022 12:41:20 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E68421B7
        for <linux-can@vger.kernel.org>; Thu, 10 Feb 2022 09:41:20 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 1EDA5B8268C
        for <linux-can@vger.kernel.org>; Thu, 10 Feb 2022 17:41:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E7EDC004E1;
        Thu, 10 Feb 2022 17:41:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1644514877;
        bh=dfBWUjs9nWygX497Ht8NGwqRX6eqziIyYDjXOPKklKk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=zfv51sP43XiPyF6KPQyg9WhbWCyv+E+sr5SyrxoyVg4GJ6hGMcEbHzacu+koNTsFL
         Rack1ABGyX8a3XIRrjJG0yFDlOR2ALqrJNdVnkII+QKyP4YUadx4++XkEeuUwjYN9G
         QgxU0e9zz+8sF1EmnnzPjA7kGdxcgRpMRtiGZCPM=
Date:   Thu, 10 Feb 2022 18:41:14 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Max Staudt <max@enpas.org>
Cc:     linux-can@vger.kernel.org, Marc Kleine-Budde <mkl@pengutronix.de>,
        Wolfgang Grandegger <wg@grandegger.com>,
        Oliver Neukum <oneukum@suse.com>, Jiri Slaby <jslaby@suse.com>
Subject: Re: [PATCH v2] can, tty: elmcan CAN/ldisc driver for ELM327 based
 OBD-II adapters
Message-ID: <YgVOOmi929pd0/M5@kroah.com>
References: <20220210171315.87796-1-max@enpas.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220210171315.87796-1-max@enpas.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

On Thu, Feb 10, 2022 at 06:13:15PM +0100, Max Staudt wrote:
> --- /dev/null
> +++ b/drivers/net/can/elmcan.c
> @@ -0,0 +1,1299 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/* elmcan.c - ELM327 based CAN interface driver
> + *            (tty line discipline)
> + *
> + * This driver started as a derivative of linux/drivers/net/can/slcan.c
> + * and my thanks go to the original authors for their inspiration.
> + *
> + * elmcan.c Author : Max Staudt <max@enpas.org>
> + * slcan.c Author  : Oliver Hartkopp <socketcan@hartkopp.net>
> + * slip.c Authors  : Laurence Culhane <loz@holmes.demon.co.uk>
> + *                   Fred N. van Kempen <waltje@uwalt.nl.mugnet.org>
> + *
> + * This code barely bears any resemblance to slcan anymore, and whatever
> + * may be left is Linux specific boilerplate anyway, however I am leaving
> + * the GPL-2.0 identifier at the top just to be sure.
> + *
> + * Please feel free to use my own code, especially the ELM327 communication
> + * logic, in accordance with SPDX-License-Identifier BSD-3-Clause to port
> + * this driver to other systems.
> + *    - Max

That is too hard to unwind and determine by anyone.  Please don't do
stuff like that, it just gives lawyers nightmares :(

> + *
> + */
> +
> +#define pr_fmt(fmt) "[elmcan] " fmt
> +
> +#include <linux/init.h>
> +#include <linux/module.h>
> +#include <linux/moduleparam.h>
> +
> +#include <linux/atomic.h>
> +#include <linux/bitops.h>
> +#include <linux/ctype.h>
> +#include <linux/delay.h>
> +#include <linux/errno.h>
> +#include <linux/if_ether.h>
> +#include <linux/kernel.h>
> +#include <linux/list.h>
> +#include <linux/netdevice.h>
> +#include <linux/skbuff.h>
> +#include <linux/spinlock.h>
> +#include <linux/string.h>
> +#include <linux/tty.h>
> +#include <linux/tty_ldisc.h>
> +#include <linux/workqueue.h>
> +
> +#include <uapi/linux/tty.h>
> +
> +#include <linux/can.h>
> +#include <linux/can/dev.h>
> +#include <linux/can/error.h>
> +#include <linux/can/led.h>
> +#include <linux/can/rx-offload.h>
> +
> +MODULE_ALIAS_LDISC(N_ELMCAN);
> +MODULE_DESCRIPTION("ELM327 based CAN interface");
> +MODULE_LICENSE("GPL");
> +MODULE_AUTHOR("Max Staudt <max@enpas.org>");
> +
> +/* If this is enabled, we'll try to make the best of the situation
> + * even if we receive unexpected characters on the line.
> + * No guarantees.
> + * Handle with care, it's likely your hardware is unreliable!
> + */
> +static bool accept_flaky_uart;
> +module_param_named(accept_flaky_uart, accept_flaky_uart, bool, 0444);
> +MODULE_PARM_DESC(accept_flaky_uart, "Don't bail at the first invalid character. Behavior undefined.");

Module parameters are from the 1990's, please no.  This is a per-code
setting, when you want it to be a per-device setting, right?  Please
just drop this.

> + /***********************************************************************
> +  *		ELM327: Reception -> netdev glue			*
> +  *									*
> +  * (assumes elm->lock taken)						*
> +  ***********************************************************************/
> +
> +static void elm327_feed_frame_to_netdev(struct elmcan *elm,

Please use normal kernel function comment formats.  kernel-doc for
global functions, simpler stuff for static functions.

> +static void elm327_parse_error(struct elmcan *elm, int len)
> +{
> +	struct can_frame frame;
> +
> +	memset(&frame, 0, sizeof(frame));
> +	frame.can_id = CAN_ERR_FLAG;
> +	frame.can_dlc = CAN_ERR_DLC;
> +
> +	switch (len) {
> +	case 17:
> +		if (!memcmp(elm->rxbuf, "UNABLE TO CONNECT", 17)) {

hard-coded numbers here and everywhere.  If you have these strings as a
define or array somewhere, you can calculate the length automatically.

> +/* Dummy needed to use bitrate_const */
> +static int elmcan_do_set_bittiming(struct net_device *netdev)
> +{
> +	(void)netdev;

No need for this line.

> +
> +	return 0;
> +}

...

> +static int __init elmcan_init(void)
> +{
> +	int status;
> +
> +	pr_info("ELM327 based best effort CAN interface driver\n");
> +	pr_info("This device is severely limited as a CAN interface, see documentation.\n");

When all works properly, kernel drivers are quiet.  No need for these
two lines at all.

> +
> +	status = tty_register_ldisc(&elmcan_ldisc);
> +	if (status)
> +		pr_err("Can't register line discipline\n");
> +
> +	return status;
> +}
> +
> +static void __exit elmcan_exit(void)
> +{
> +	/* This will only be called when all channels have been closed by
> +	 * userspace - tty_ldisc.c takes care of the module's refcount.
> +	 */
> +	tty_unregister_ldisc(&elmcan_ldisc);
> +}
> +
> +module_init(elmcan_init);
> +module_exit(elmcan_exit);
> diff --git a/include/uapi/linux/tty.h b/include/uapi/linux/tty.h
> index a58deb3061eb..4d3ad2569641 100644
> --- a/include/uapi/linux/tty.h
> +++ b/include/uapi/linux/tty.h
> @@ -39,5 +39,6 @@
>  #define N_SPEAKUP	26	/* Speakup communication with synths */
>  #define N_NULL		27	/* Null ldisc used for error handling */
>  #define N_MCTP		28	/* MCTP-over-serial */
> +#define N_ELMCAN	29	/* Serial / USB serial OBD-II Interfaces */

We are now full, no more new ones to ever add!  :)

This looks fine, we can always bump up the number if we want more.

thanks,

greg k-h
