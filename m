Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C855B3455C8
	for <lists+linux-can@lfdr.de>; Tue, 23 Mar 2021 03:56:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229547AbhCWC4B (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Mon, 22 Mar 2021 22:56:01 -0400
Received: from mga04.intel.com ([192.55.52.120]:6492 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229537AbhCWCza (ORCPT <rfc822;linux-can@vger.kernel.org>);
        Mon, 22 Mar 2021 22:55:30 -0400
IronPort-SDR: oSN8t+TeqpTE1LxwpZbawNHDZz+SiQ6GgZo6LFojvUSbo2LPWJlxSMhbTAPDLrZ9IMnhlgck1C
 fgQy9+mumgIQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9931"; a="188074951"
X-IronPort-AV: E=Sophos;i="5.81,270,1610438400"; 
   d="scan'208";a="188074951"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Mar 2021 19:55:29 -0700
IronPort-SDR: Qt51m2NdIFWPebJ2Kfbt4AdsLwESOfvS4IR/C3Hdsy11SR8DurC60Lf2S2v7k2OXfN8y01S42V
 ArpnH0y19gmQ==
X-IronPort-AV: E=Sophos;i="5.81,270,1610438400"; 
   d="scan'208";a="408092779"
Received: from shao2-debian.sh.intel.com (HELO [10.239.13.11]) ([10.239.13.11])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Mar 2021 19:55:27 -0700
Subject: Re: [kbuild-all] Re: include/linux/compiler_types.h:315:38: error:
 call to '__compiletime_assert_536' declared with attribute error:
 BUILD_BUG_ON failed: offsetof(struct can_frame, len) != offsetof(struct
 canfd_frame, len) || offsetof(struct can_frame, data) != offsetof(struc...
To:     Oliver Hartkopp <socketcan@hartkopp.net>,
        kernel test robot <lkp@intel.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Marc Kleine-Budde <mkl@pengutronix.de>,
        linux-can <linux-can@vger.kernel.org>
References: <202103210435.I0fiBGAC-lkp@intel.com>
 <dad98ebd-77a4-3305-e681-278cabe38793@hartkopp.net>
 <7f4f7e1c-194b-a903-d474-e3b742556a55@intel.com>
 <f8075a19-10e1-abf9-6d59-1a46454b74b1@hartkopp.net>
From:   Rong Chen <rong.a.chen@intel.com>
Message-ID: <b10903ca-c424-b305-d981-fe0004500190@intel.com>
Date:   Tue, 23 Mar 2021 10:54:40 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <f8075a19-10e1-abf9-6d59-1a46454b74b1@hartkopp.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org



On 3/23/21 12:24 AM, Oliver Hartkopp wrote:
> Hi Rong,
>
> On 22.03.21 09:52, Rong Chen wrote:
>
>> On 3/21/21 10:19 PM, Oliver Hartkopp wrote:
>>> Two reminders in two days? ;-)
>>>
>>> Did you check my answer here?
>>> https://lore.kernel.org/lkml/afffeb73-ba4c-ca2c-75d0-9e7899e5cbe1@hartkopp.net/ 
>>>
>>>
>>> And did you try the partly revert?
>>
>> Hi Oliver,
>>
>> Sorry for the delay, we tried the revert patch and the problem still 
>> exists,
>> we also found that commit c7b74967 changed the error message which 
>> triggered
>> the report.
>>
>> The problem is that offsetof(struct can_frame, data) != 
>> offsetof(struct canfd_frame, data)
>> the following struct layout shows that the offset has been changed by 
>> union:
>>
>> struct can_frame {
>>          canid_t                    can_id;               /* 0     4 */
>>          union {
>>                  __u8               len;                  /* 4     1 */
>>                  __u8               can_dlc;              /* 4     1 */
>>          };                                               /* 4     4 */
>
> Ugh! Why did the compiler extend the space for the union to 4 bytes?!?
>
>>          __u8 __pad;                /* 8     1 */
>>          __u8                       __res0;               /* 9     1 */
>>          __u8                       len8_dlc;             /* 10     1 */
>>
>>          /* XXX 5 bytes hole, try to pack */
>>
>>          __u8                       data[8] 
>> __attribute__((__aligned__(8))); /*    16     8 */
>>
>>          /* size: 24, cachelines: 1, members: 6 */
>>          /* sum members: 19, holes: 1, sum holes: 5 */
>>          /* forced alignments: 1, forced holes: 1, sum forced holes: 
>> 5 */
>>          /* last cacheline: 24 bytes */
>> } __attribute__((__aligned__(8)));
>>
>> struct canfd_frame {
>>          canid_t                    can_id;               /* 0     4 */
>>          __u8                       len;                  /* 4     1 */
>>          __u8                       flags;                /* 5     1 */
>>          __u8                       __res0;               /* 6     1 */
>>          __u8                       __res1;               /* 7     1 */
>>          __u8                       data[64] 
>> __attribute__((__aligned__(8))); /*     8    64 */
>>
>>          /* size: 72, cachelines: 2, members: 6 */
>>          /* forced alignments: 1 */
>>          /* last cacheline: 8 bytes */
>> } __attribute__((__aligned__(8)))
>>
>>
>> and I tried to add "__attribute__((packed))" to the union, the issue 
>> is gone:
>>
>> diff --git a/include/uapi/linux/can.h b/include/uapi/linux/can.h
>> index f75238ac6dce..9842bb55ffd9 100644
>> --- a/include/uapi/linux/can.h
>> +++ b/include/uapi/linux/can.h
>> @@ -113,7 +113,7 @@ struct can_frame {
>>                   */
>>                  __u8 len;
>>                  __u8 can_dlc; /* deprecated */
>> -       };
>> +       } __attribute__((packed));
>>          __u8 __pad; /* padding */
>>          __u8 __res0; /* reserved / padding */
>>          __u8 len8_dlc; /* optional DLC for 8 byte payload length (9 
>> .. 15) */
>
> This is pretty strange!
>
> pahole on my x86_64 machine shows the correct data structure layout:
>
> struct can_frame {
>         canid_t                    can_id;               /* 0     4 */
>         union {
>                 __u8               len;                  /* 4     1 */
>                 __u8               can_dlc;              /* 4     1 */
>         };                                               /* 4     1 */
>         __u8                       __pad;                /* 5     1 */
>         __u8                       __res0;               /* 6     1 */
>         __u8                       len8_dlc;             /* 7     1 */
>         __u8                       data[8] 
> __attribute__((__aligned__(8))); /*     8     8 */
>
>         /* size: 16, cachelines: 1, members: 6 */
>         /* forced alignments: 1 */
>         /* last cacheline: 16 bytes */
> } __attribute__((__aligned__(8)));
>
> Target: x86_64-linux-gnu
> gcc version 10.2.1 20210110 (Debian 10.2.1-6)
> Linux 5.12.0-rc3-00070-g8b12a62a4e3e x86_64 GNU/Linux
>
> So it looks like your compiler does not behave correctly - and I 
> wonder if it would be the correct approach to add the __packed() 
> attribute or better fix/change the (ARM) compiler.

Hi Oliver,

I tried arm-linux-gnueabi (gcc version 10.2.0) and the problem still exists,
btw we prefer to not use the latest gcc compiler to avoid false positives.

Best Regards,
Rong Chen

>
> At least I'm very happy that the BUILD_BUG_ON() triggered correctly - 
> so it was worth to have it ;-)
>
> Best regards,
> Oliver
>
>
>>>
>>> Maybe there's a mismatch in include files - or BUILD_BUG_ON() 
>>> generally does not work with unions on ARM as assumed here:
>>>
>>> https://lore.kernel.org/lkml/6e57d5d2-9b88-aee6-fb7a-82e24144d179@hartkopp.net/ 
>>>
>>>
>>> In both cases I can not really fix the issue.
>>> When the partly revert (suggested above) works, this would be a hack 
>>> too.
>>>
>>> Best,
>>> Oliver
>>>
>>> On 20.03.21 21:43, kernel test robot wrote:
>>>> Hi Oliver,
>>>>
>>>> FYI, the error/warning still remains.
>>>>
>>>> tree: 
>>>> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git 
>>>> master
>>>> head:   812da4d39463a060738008a46cfc9f775e4bfcf6
>>>> commit: c7b74967799b1af52b3045d69d4c26836b2d41de can: replace 
>>>> can_dlc as variable/element for payload length
>>>> date:   4 months ago
>>>> config: arm-randconfig-r016-20210321 (attached as .config)
>>>> compiler: arm-linux-gnueabi-gcc (GCC) 9.3.0
>>>> reproduce (this is a W=1 build):
>>>>          wget 
>>>> https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross 
>>>> -O ~/bin/make.cross
>>>>          chmod +x ~/bin/make.cross
>>>>          # 
>>>> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=c7b74967799b1af52b3045d69d4c26836b2d41de 
>>>>
>>>>          git remote add linus 
>>>> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
>>>>          git fetch --no-tags linus master
>>>>          git checkout c7b74967799b1af52b3045d69d4c26836b2d41de
>>>>          # save the attached .config to linux build tree
>>>>          COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-9.3.0 
>>>> make.cross ARCH=arm
>>>>
>>>> If you fix the issue, kindly add following tag as appropriate
>>>> Reported-by: kernel test robot <lkp@intel.com>
>>>>
>>>> All errors (new ones prefixed by >>):
>>>>
>>>>     In file included from <command-line>:
>>>>     net/can/af_can.c: In function 'can_init':
>>>>>> include/linux/compiler_types.h:315:38: error: call to 
>>>>>> '__compiletime_assert_536' declared with attribute error: 
>>>>>> BUILD_BUG_ON failed: offsetof(struct can_frame, len) != 
>>>>>> offsetof(struct canfd_frame, len) || offsetof(struct can_frame, 
>>>>>> data) != offsetof(struct canfd_frame, data)
>>>>       315 |  _compiletime_assert(condition, msg, 
>>>> __compiletime_assert_, __COUNTER__)
>>>>           |                                      ^
>>>>     include/linux/compiler_types.h:296:4: note: in definition of 
>>>> macro '__compiletime_assert'
>>>>       296 |    prefix ## suffix();    \
>>>>           |    ^~~~~~
>>>>     include/linux/compiler_types.h:315:2: note: in expansion of 
>>>> macro '_compiletime_assert'
>>>>       315 |  _compiletime_assert(condition, msg, 
>>>> __compiletime_assert_, __COUNTER__)
>>>>           |  ^~~~~~~~~~~~~~~~~~~
>>>>     include/linux/build_bug.h:39:37: note: in expansion of macro 
>>>> 'compiletime_assert'
>>>>        39 | #define BUILD_BUG_ON_MSG(cond, msg) 
>>>> compiletime_assert(!(cond), msg)
>>>>           | ^~~~~~~~~~~~~~~~~~
>>>>     include/linux/build_bug.h:50:2: note: in expansion of macro 
>>>> 'BUILD_BUG_ON_MSG'
>>>>        50 |  BUILD_BUG_ON_MSG(condition, "BUILD_BUG_ON failed: " 
>>>> #condition)
>>>>           |  ^~~~~~~~~~~~~~~~
>>>>     net/can/af_can.c:891:2: note: in expansion of macro 'BUILD_BUG_ON'
>>>>       891 |  BUILD_BUG_ON(offsetof(struct can_frame, len) !=
>>>>           |  ^~~~~~~~~~~~
>>>>
>>>>
>>>> vim +/__compiletime_assert_536 +315 include/linux/compiler_types.h
>>>>
>>>> eb5c2d4b45e3d2 Will Deacon 2020-07-21  301
>>>> eb5c2d4b45e3d2 Will Deacon 2020-07-21  302  #define 
>>>> _compiletime_assert(condition, msg, prefix, suffix) \
>>>> eb5c2d4b45e3d2 Will Deacon 2020-07-21  303 
>>>> __compiletime_assert(condition, msg, prefix, suffix)
>>>> eb5c2d4b45e3d2 Will Deacon 2020-07-21  304
>>>> eb5c2d4b45e3d2 Will Deacon 2020-07-21  305  /**
>>>> eb5c2d4b45e3d2 Will Deacon 2020-07-21  306   * compiletime_assert - 
>>>> break build and emit msg if condition is false
>>>> eb5c2d4b45e3d2 Will Deacon 2020-07-21  307   * @condition: a 
>>>> compile-time constant condition to check
>>>> eb5c2d4b45e3d2 Will Deacon 2020-07-21  308   * @msg:       a 
>>>> message to emit if condition is false
>>>> eb5c2d4b45e3d2 Will Deacon 2020-07-21  309   *
>>>> eb5c2d4b45e3d2 Will Deacon 2020-07-21  310   * In tradition of 
>>>> POSIX assert, this macro will break the build if the
>>>> eb5c2d4b45e3d2 Will Deacon 2020-07-21  311   * supplied condition 
>>>> is *false*, emitting the supplied error message if the
>>>> eb5c2d4b45e3d2 Will Deacon 2020-07-21  312   * compiler has support 
>>>> to do so.
>>>> eb5c2d4b45e3d2 Will Deacon 2020-07-21  313   */
>>>> eb5c2d4b45e3d2 Will Deacon 2020-07-21  314  #define 
>>>> compiletime_assert(condition, msg) \
>>>> eb5c2d4b45e3d2 Will Deacon 2020-07-21 @315 
>>>> _compiletime_assert(condition, msg, __compiletime_assert_, 
>>>> __COUNTER__)
>>>> eb5c2d4b45e3d2 Will Deacon 2020-07-21  316
>>>>
>>>> :::::: The code at line 315 was first introduced by commit
>>>> :::::: eb5c2d4b45e3d2d5d052ea6b8f1463976b1020d5 compiler.h: Move 
>>>> compiletime_assert() macros into compiler_types.h
>>>>
>>>> :::::: TO: Will Deacon <will@kernel.org>
>>>> :::::: CC: Will Deacon <will@kernel.org>
>>>>
>>>> ---
>>>> 0-DAY CI Kernel Test Service, Intel Corporation
>>>> https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
>>>>
>>> _______________________________________________
>>> kbuild-all mailing list -- kbuild-all@lists.01.org
>>> To unsubscribe send an email to kbuild-all-leave@lists.01.org
>>

