Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5314D345A3B
	for <lists+linux-can@lfdr.de>; Tue, 23 Mar 2021 10:01:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229728AbhCWJBJ (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Tue, 23 Mar 2021 05:01:09 -0400
Received: from mga07.intel.com ([134.134.136.100]:26550 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229915AbhCWJAp (ORCPT <rfc822;linux-can@vger.kernel.org>);
        Tue, 23 Mar 2021 05:00:45 -0400
IronPort-SDR: QesQvV6XkaW5gzZx/+Fky27SlgQ6E4KeAZ2IMKqKjiSONcKzP/TK7JndVjIkSlTIFg5+FKG+RK
 A9I3EmI57wqQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9931"; a="254434489"
X-IronPort-AV: E=Sophos;i="5.81,271,1610438400"; 
   d="scan'208";a="254434489"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Mar 2021 02:00:44 -0700
IronPort-SDR: 1m6mQJloJ6uQ1wwpLHZzx0gwXHi0RfJE73dH5Zr7+1FWKaphBFaQNHfjJFpjSGpCerTjfoNRgL
 aGMLYEi4tv/w==
X-IronPort-AV: E=Sophos;i="5.81,271,1610438400"; 
   d="scan'208";a="408225261"
Received: from shao2-debian.sh.intel.com (HELO [10.239.13.11]) ([10.239.13.11])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Mar 2021 02:00:41 -0700
Subject: Re: [kbuild-all] Re: include/linux/compiler_types.h:315:38: error:
 call to '__compiletime_assert_536' declared with attribute error:
 BUILD_BUG_ON failed: offsetof(struct can_frame, len) != offsetof(struct
 canfd_frame, len) || offsetof(struct can_frame, data) != offsetof(struc...
To:     Marc Kleine-Budde <mkl@pengutronix.de>,
        Oliver Hartkopp <socketcan@hartkopp.net>
Cc:     Patrick Menschel <menschel.p@posteo.de>,
        kernel test robot <lkp@intel.com>, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org, linux-can <linux-can@vger.kernel.org>
References: <202103210435.I0fiBGAC-lkp@intel.com>
 <dad98ebd-77a4-3305-e681-278cabe38793@hartkopp.net>
 <7f4f7e1c-194b-a903-d474-e3b742556a55@intel.com>
 <f8075a19-10e1-abf9-6d59-1a46454b74b1@hartkopp.net>
 <b10903ca-c424-b305-d981-fe0004500190@intel.com>
 <20210323073437.yo63wreqnubbeqby@pengutronix.de>
 <7ff6bfd3-6b4b-045a-abb7-485927909587@hartkopp.net>
 <c0fb01a8-6a6a-7e5f-f932-697065d18600@hartkopp.net>
 <20210323085418.4g7rojhkvcg2ib4e@pengutronix.de>
From:   Rong Chen <rong.a.chen@intel.com>
Message-ID: <e52e9f3f-bb88-0cb3-b4ce-7885e57a5dba@intel.com>
Date:   Tue, 23 Mar 2021 16:59:53 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20210323085418.4g7rojhkvcg2ib4e@pengutronix.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org



On 3/23/21 4:54 PM, Marc Kleine-Budde wrote:
> On 23.03.2021 09:32:10, Oliver Hartkopp wrote:
>> I wonder if the compiler configurations (gcc -v) or the options used at
>> kernel build time are identical.
> I tested several compilers and with my .config never triggered a
> problem, but with Rong Chen it does. I'm trying to figure out which
> option it is, stay tuned.
>
> Marc
>

Hi Marc, Oliver,

We use the below cross compiler:

https://download.01.org/0day-ci/cross-package/gcc-9.3.0-nolibc/x86_64-gcc-9.3.0-nolibc_arm-linux-gnueabi.tar.xz

and here is the detail:

$ 
/home/nfs/0day/gcc-9.3.0-nolibc/arm-linux-gnueabi/bin/arm-linux-gnueabi-gcc 
-v
Using built-in specs.
COLLECT_GCC=/home/nfs/0day/gcc-9.3.0-nolibc/arm-linux-gnueabi/bin/arm-linux-gnueabi-gcc
COLLECT_LTO_WRAPPER=/home/nfs/0day/gcc-9.3.0-nolibc/arm-linux-gnueabi/bin/../libexec/gcc/arm-linux-gnueabi/9.3.0/lto-wrapper
Target: arm-linux-gnueabi
Configured with: /tmp/build-crosstools-xh/gcc/gcc-9.3.0/configure 
--target=arm-linux-gnueabi --enable-targets=all 
--prefix=/tmp/build-crosstools-xh/cross --enable-languages=c 
--without-headers --disable-bootstrap --disable-nls --disable-threads 
--disable-shared --disable-libmudflap --disable-libssp --disable-libgomp 
--disable-decimal-float --disable-libquadmath --disable-libatomic 
--disable-libcc1 --disable-libmpx --enable-checking=release
Thread model: single
gcc version 9.3.0 (GCC)

Best Regards,
Rong Chen
