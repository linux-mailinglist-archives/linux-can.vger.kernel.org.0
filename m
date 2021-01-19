Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4CFB42FBE8F
	for <lists+linux-can@lfdr.de>; Tue, 19 Jan 2021 19:09:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404647AbhASSGy (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Tue, 19 Jan 2021 13:06:54 -0500
Received: from mx2.suse.de ([195.135.220.15]:51138 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404633AbhASSGp (ORCPT <rfc822;linux-can@vger.kernel.org>);
        Tue, 19 Jan 2021 13:06:45 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 08848AE36;
        Tue, 19 Jan 2021 18:05:59 +0000 (UTC)
Date:   Tue, 19 Jan 2021 19:05:57 +0100
From:   Petr Vorel <pvorel@suse.cz>
To:     Richard Palethorpe <rpalethorpe@suse.com>
Cc:     ltp@lists.linux.it, Oliver Hartkopp <socketcan@hartkopp.net>,
        linux-can@vger.kernel.org
Subject: Re: [LTP] [PATCH v2 2/6] can: Add can_common.h for vcan device setup
Message-ID: <YAcfhf2qg5q4VZrg@pevik>
Reply-To: Petr Vorel <pvorel@suse.cz>
References: <20210119093143.17222-1-rpalethorpe@suse.com>
 <20210119093143.17222-3-rpalethorpe@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210119093143.17222-3-rpalethorpe@suse.com>
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Hi Richie,

...
> +#include <linux/if.h>
...
> +static void can_setup_vcan(void)
> +{
...
> +check_echo:
> +	/* Precondition for the frame flow test? */
> +	SAFE_ASPRINTF(&path, "/sys/class/net/%s/flags", can_dev_name);
> +	if (FILE_SCANF(path, "%x", &flags) || !(flags & IFF_ECHO))
FYI IFF_ECHO is not defined on some older toolchains (aarch64).
It'd be good to add lapi/if.h, where it'd be defined.
But it can be added later.

In file included from can_common.h:21,
                 from can_filter.c:12:
can_common.h: In function ‘can_setup_vcan’:
can_common.h:58:50: error: ‘IFF_ECHO’ undeclared (first use in this function); did you mean ‘IFF_DEBUG’?
  if (FILE_SCANF(path, "%x", &flags) || !(flags & IFF_ECHO))
                                                  ^~~~~~~~
can_common.h:58:50: note: each undeclared identifier is reported only once for each function it appears in
In file included from can_common.h:21,
                 from can_rcv_own_msgs.c:12:
can_common.h: In function ‘can_setup_vcan’:
can_common.h:58:50: error: ‘IFF_ECHO’ undeclared (first use in this function); did you mean ‘IFF_DEBUG’?
  if (FILE_SCANF(path, "%x", &flags) || !(flags & IFF_ECHO))
                                                  ^~~~~~~~

Also there are other problems on toolchains with older linux headers
- bug in using <net/if.h> with <linux/if.h>. Can't we just use <linux/if.h>?
https://travis-ci.org/github/pevik/ltp/jobs/755163076

In file included from /usr/src/ltp/testcases/network/can/filter-tests/can_common.h:15:0,
                 from /usr/src/ltp/testcases/network/can/filter-tests/can_filter.c:12:
/usr/include/linux/if.h:71:2: error: redeclaration of enumerator 'IFF_UP'
  IFF_UP    = 1<<0,  /* sysfs */
  ^
/usr/include/net/if.h:44:5: note: previous definition of 'IFF_UP' was here
     IFF_UP = 0x1,  /* Interface is up.  */
     ^
/usr/include/linux/if.h:72:2: error: redeclaration of enumerator 'IFF_BROADCAST'
  IFF_BROADCAST   = 1<<1,  /* __volatile__ */
  ^
/usr/include/net/if.h:46:5: note: previous definition of 'IFF_BROADCAST' was here
     IFF_BROADCAST = 0x2, /* Broadcast address valid.  */
     ^
/usr/include/linux/if.h:73:2: error: redeclaration of enumerator 'IFF_DEBUG'
  IFF_DEBUG   = 1<<2,  /* sysfs */
  ^
/usr/include/net/if.h:48:5: note: previous definition of 'IFF_DEBUG' was here
     IFF_DEBUG = 0x4,  /* Turn on debugging.  */
     ^
/usr/include/linux/if.h:74:2: error: redeclaration of enumerator 'IFF_LOOPBACK'
  IFF_LOOPBACK   = 1<<3,  /* __volatile__ */
  ^
/usr/include/net/if.h:50:5: note: previous definition of 'IFF_LOOPBACK' was here
     IFF_LOOPBACK = 0x8,  /* Is a loopback net.  */
     ^
/usr/include/linux/if.h:75:2: error: redeclaration of enumerator 'IFF_POINTOPOINT'
  IFF_POINTOPOINT   = 1<<4,  /* __volatile__ */
  ^
/usr/include/net/if.h:52:5: note: previous definition of 'IFF_POINTOPOINT' was here
     IFF_POINTOPOINT = 0x10, /* Interface is point-to-point link.  */
     ^
/usr/include/linux/if.h:76:2: error: redeclaration of enumerator 'IFF_NOTRAILERS'
  IFF_NOTRAILERS   = 1<<5,  /* sysfs */
  ^
/usr/include/net/if.h:54:5: note: previous definition of 'IFF_NOTRAILERS' was here
     IFF_NOTRAILERS = 0x20, /* Avoid use of trailers.  */
     ^
/usr/include/linux/if.h:77:2: error: redeclaration of enumerator 'IFF_RUNNING'
  IFF_RUNNING   = 1<<6,  /* __volatile__ */

Also it fails to run docparse:
invalid character encountered while parsing JSON string, at character offset 133249 (before "\tCAN device name"\n...") at /usr/src/ltp/docparse/testinfo.pl line 398.
make[1]: *** [/usr/src/ltp/docparse/Makefile:60: txt] Error 255
I'll have look into this one.

Kind regards,
Petr
