Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 57CCE344B2D
	for <lists+linux-can@lfdr.de>; Mon, 22 Mar 2021 17:25:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231142AbhCVQZL (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Mon, 22 Mar 2021 12:25:11 -0400
Received: from mo4-p00-ob.smtp.rzone.de ([85.215.255.25]:22522 "EHLO
        mo4-p00-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230377AbhCVQY5 (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Mon, 22 Mar 2021 12:24:57 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1616430283; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=JsgLVy7hX7SvJZBACqksoXLXZwZKTjzOE80jODI7f4lQMXLy+KZEJFeZvdLgYWwZnE
    i2Lpct3FVeSc+qQZE8DIpN0x3g7BmMazNzTa11+Lf2Lm+7RgR9GzBMfAYZSaqmF+O5Tq
    YFzCEq8TPTZDntMOsFFGdLkGDR0jVNRS7Amhi9P+PSakxuWqJtwxCRCzRxCsqhyFhHKP
    oQmCNv+HldymXTS5Al2L0zAY+PDl3Q/Za2L24/jzq0Udwgpp1E0ovETiv5uNxNSg/zGM
    7XHISZalMASQfVoB9BlQmsGskttyIdwrInHwamV0zRhe4L286eZ/vbk3PJZRphtUytcj
    lnng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1616430283;
    s=strato-dkim-0002; d=strato.com;
    h=In-Reply-To:Date:Message-ID:From:References:Cc:To:Subject:Cc:Date:
    From:Subject:Sender;
    bh=fNSPOvAcXJaGwOFbee0eesJYwvcfj3mVkyRH4eS4iOg=;
    b=lLGpcH0r1zxv6DvLjuiAZhPci+8ZWlhn4vg/mnVGfazYU+j/Y1hdJFI5B/ikyxWu3K
    ZIBSS0G+xTeSyqHV3r+b9eQEtW4FOrAXCL6xUB2gSfHst53L+O05nYtKVCgYKxnc/7xE
    z1tDXFkv9rubxV5bsDKFD2O1MJQnZ0yex7UHnNBPTzEFu8F/VCsjRSVa6aF3cRnS+1UZ
    9gIablcKFsp2bsQWOB3Ban/Uw3DAqEnO0bF1zSqEQZJm7LNEXHk/mPJPxBPMnRKBY73q
    +BxvdH0GiZcq2JStOd0D9uLbk9e8mI6p0UX/9iRcaQ6vPBxzmxOlI5e/CNJeEFa4P1XQ
    NO0Q==
ARC-Authentication-Results: i=1; strato.com;
    dkim=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1616430283;
    s=strato-dkim-0002; d=hartkopp.net;
    h=In-Reply-To:Date:Message-ID:From:References:Cc:To:Subject:Cc:Date:
    From:Subject:Sender;
    bh=fNSPOvAcXJaGwOFbee0eesJYwvcfj3mVkyRH4eS4iOg=;
    b=dZTSxhUCRXaurYltWQj9o4RvqePC+AoYkOn0ifZqCQqb+39aLNpEWXRWcq4o4o6LMf
    /8Xc0ckBldZhaxhCQBp9BKaUShrlIpihaJM0067kcVS0V2C/B/eTVJWgsAtopBe5noAo
    l9gQ3B1yKvZbLe/4qhwvrwpLla6U3F3qoL/QTrAbw6nRin3qEs3LGMZ04R/A1uOlfSXp
    x1+YxFyqBG+cK6aayodhJnYA4cvyr7c3zcffYEtIu177nrId643CKLdwNs9n8BbMy0Qb
    bfOzcQZnBi63tjaT4cvK+GjCaML9Rugk5PZCWvBLRze3n2D7Qk4YC5B9STyd1OUR29rA
    +UlQ==
Authentication-Results: strato.com;
    dkim=none
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjG14FZxedJy6qgO1o3TMaFqTGVNiOMpjpw=="
X-RZG-CLASS-ID: mo00
Received: from [192.168.10.137]
    by smtp.strato.de (RZmta 47.21.0 DYNA|AUTH)
    with ESMTPSA id R01debx2MGOgCwc
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Mon, 22 Mar 2021 17:24:42 +0100 (CET)
Subject: Re: [kbuild-all] Re: include/linux/compiler_types.h:315:38: error:
 call to '__compiletime_assert_536' declared with attribute error:
 BUILD_BUG_ON failed: offsetof(struct can_frame, len) != offsetof(struct
 canfd_frame, len) || offsetof(struct can_frame, data) != offsetof(struc...
To:     Rong Chen <rong.a.chen@intel.com>,
        kernel test robot <lkp@intel.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Marc Kleine-Budde <mkl@pengutronix.de>,
        linux-can <linux-can@vger.kernel.org>
References: <202103210435.I0fiBGAC-lkp@intel.com>
 <dad98ebd-77a4-3305-e681-278cabe38793@hartkopp.net>
 <7f4f7e1c-194b-a903-d474-e3b742556a55@intel.com>
From:   Oliver Hartkopp <socketcan@hartkopp.net>
Message-ID: <f8075a19-10e1-abf9-6d59-1a46454b74b1@hartkopp.net>
Date:   Mon, 22 Mar 2021 17:24:37 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <7f4f7e1c-194b-a903-d474-e3b742556a55@intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Hi Rong,

On 22.03.21 09:52, Rong Chen wrote:

> On 3/21/21 10:19 PM, Oliver Hartkopp wrote:
>> Two reminders in two days? ;-)
>>
>> Did you check my answer here?
>> https://lore.kernel.org/lkml/afffeb73-ba4c-ca2c-75d0-9e7899e5cbe1@hartkopp.net/ 
>>
>>
>> And did you try the partly revert?
> 
> Hi Oliver,
> 
> Sorry for the delay, we tried the revert patch and the problem still 
> exists,
> we also found that commit c7b74967 changed the error message which 
> triggered
> the report.
> 
> The problem is that offsetof(struct can_frame, data) != offsetof(struct 
> canfd_frame, data)
> the following struct layout shows that the offset has been changed by 
> union:
> 
> struct can_frame {
>          canid_t                    can_id;               /* 0     4 */
>          union {
>                  __u8               len;                  /* 4     1 */
>                  __u8               can_dlc;              /* 4     1 */
>          };                                               /* 4     4 */

Ugh! Why did the compiler extend the space for the union to 4 bytes?!?

>          __u8                       __pad;                /* 8     1 */
>          __u8                       __res0;               /* 9     1 */
>          __u8                       len8_dlc;             /* 10     1 */
> 
>          /* XXX 5 bytes hole, try to pack */
> 
>          __u8                       data[8] 
> __attribute__((__aligned__(8))); /*    16     8 */
> 
>          /* size: 24, cachelines: 1, members: 6 */
>          /* sum members: 19, holes: 1, sum holes: 5 */
>          /* forced alignments: 1, forced holes: 1, sum forced holes: 5 */
>          /* last cacheline: 24 bytes */
> } __attribute__((__aligned__(8)));
> 
> struct canfd_frame {
>          canid_t                    can_id;               /* 0     4 */
>          __u8                       len;                  /* 4     1 */
>          __u8                       flags;                /* 5     1 */
>          __u8                       __res0;               /* 6     1 */
>          __u8                       __res1;               /* 7     1 */
>          __u8                       data[64] 
> __attribute__((__aligned__(8))); /*     8    64 */
> 
>          /* size: 72, cachelines: 2, members: 6 */
>          /* forced alignments: 1 */
>          /* last cacheline: 8 bytes */
> } __attribute__((__aligned__(8)))
> 
> 
> and I tried to add "__attribute__((packed))" to the union, the issue is 
> gone:
> 
> diff --git a/include/uapi/linux/can.h b/include/uapi/linux/can.h
> index f75238ac6dce..9842bb55ffd9 100644
> --- a/include/uapi/linux/can.h
> +++ b/include/uapi/linux/can.h
> @@ -113,7 +113,7 @@ struct can_frame {
>                   */
>                  __u8 len;
>                  __u8 can_dlc; /* deprecated */
> -       };
> +       } __attribute__((packed));
>          __u8 __pad; /* padding */
>          __u8 __res0; /* reserved / padding */
>          __u8 len8_dlc; /* optional DLC for 8 byte payload length (9 .. 
> 15) */

This is pretty strange!

pahole on my x86_64 machine shows the correct data structure layout:

struct can_frame {
         canid_t                    can_id;               /*     0     4 */
         union {
                 __u8               len;                  /*     4     1 */
                 __u8               can_dlc;              /*     4     1 */
         };                                               /*     4     1 */
         __u8                       __pad;                /*     5     1 */
         __u8                       __res0;               /*     6     1 */
         __u8                       len8_dlc;             /*     7     1 */
         __u8                       data[8] 
__attribute__((__aligned__(8))); /*     8     8 */

         /* size: 16, cachelines: 1, members: 6 */
         /* forced alignments: 1 */
         /* last cacheline: 16 bytes */
} __attribute__((__aligned__(8)));

Target: x86_64-linux-gnu
gcc version 10.2.1 20210110 (Debian 10.2.1-6)
Linux 5.12.0-rc3-00070-g8b12a62a4e3e x86_64 GNU/Linux

So it looks like your compiler does not behave correctly - and I wonder 
if it would be the correct approach to add the __packed() attribute or 
better fix/change the (ARM) compiler.

At least I'm very happy that the BUILD_BUG_ON() triggered correctly - so 
it was worth to have it ;-)

Best regards,
Oliver


>>
>> Maybe there's a mismatch in include files - or BUILD_BUG_ON() 
>> generally does not work with unions on ARM as assumed here:
>>
>> https://lore.kernel.org/lkml/6e57d5d2-9b88-aee6-fb7a-82e24144d179@hartkopp.net/ 
>>
>>
>> In both cases I can not really fix the issue.
>> When the partly revert (suggested above) works, this would be a hack too.
>>
>> Best,
>> Oliver
>>
>> On 20.03.21 21:43, kernel test robot wrote:
>>> Hi Oliver,
>>>
>>> FYI, the error/warning still remains.
>>>
>>> tree: 
>>> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git 
>>> master
>>> head:   812da4d39463a060738008a46cfc9f775e4bfcf6
>>> commit: c7b74967799b1af52b3045d69d4c26836b2d41de can: replace can_dlc 
>>> as variable/element for payload length
>>> date:   4 months ago
>>> config: arm-randconfig-r016-20210321 (attached as .config)
>>> compiler: arm-linux-gnueabi-gcc (GCC) 9.3.0
>>> reproduce (this is a W=1 build):
>>>          wget 
>>> https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross 
>>> -O ~/bin/make.cross
>>>          chmod +x ~/bin/make.cross
>>>          # 
>>> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=c7b74967799b1af52b3045d69d4c26836b2d41de 
>>>
>>>          git remote add linus 
>>> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
>>>          git fetch --no-tags linus master
>>>          git checkout c7b74967799b1af52b3045d69d4c26836b2d41de
>>>          # save the attached .config to linux build tree
>>>          COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-9.3.0 
>>> make.cross ARCH=arm
>>>
>>> If you fix the issue, kindly add following tag as appropriate
>>> Reported-by: kernel test robot <lkp@intel.com>
>>>
>>> All errors (new ones prefixed by >>):
>>>
>>>     In file included from <command-line>:
>>>     net/can/af_can.c: In function 'can_init':
>>>>> include/linux/compiler_types.h:315:38: error: call to 
>>>>> '__compiletime_assert_536' declared with attribute error: 
>>>>> BUILD_BUG_ON failed: offsetof(struct can_frame, len) != 
>>>>> offsetof(struct canfd_frame, len) || offsetof(struct can_frame, 
>>>>> data) != offsetof(struct canfd_frame, data)
>>>       315 |  _compiletime_assert(condition, msg, 
>>> __compiletime_assert_, __COUNTER__)
>>>           |                                      ^
>>>     include/linux/compiler_types.h:296:4: note: in definition of 
>>> macro '__compiletime_assert'
>>>       296 |    prefix ## suffix();    \
>>>           |    ^~~~~~
>>>     include/linux/compiler_types.h:315:2: note: in expansion of macro 
>>> '_compiletime_assert'
>>>       315 |  _compiletime_assert(condition, msg, 
>>> __compiletime_assert_, __COUNTER__)
>>>           |  ^~~~~~~~~~~~~~~~~~~
>>>     include/linux/build_bug.h:39:37: note: in expansion of macro 
>>> 'compiletime_assert'
>>>        39 | #define BUILD_BUG_ON_MSG(cond, msg) 
>>> compiletime_assert(!(cond), msg)
>>>           | ^~~~~~~~~~~~~~~~~~
>>>     include/linux/build_bug.h:50:2: note: in expansion of macro 
>>> 'BUILD_BUG_ON_MSG'
>>>        50 |  BUILD_BUG_ON_MSG(condition, "BUILD_BUG_ON failed: " 
>>> #condition)
>>>           |  ^~~~~~~~~~~~~~~~
>>>     net/can/af_can.c:891:2: note: in expansion of macro 'BUILD_BUG_ON'
>>>       891 |  BUILD_BUG_ON(offsetof(struct can_frame, len) !=
>>>           |  ^~~~~~~~~~~~
>>>
>>>
>>> vim +/__compiletime_assert_536 +315 include/linux/compiler_types.h
>>>
>>> eb5c2d4b45e3d2 Will Deacon 2020-07-21  301
>>> eb5c2d4b45e3d2 Will Deacon 2020-07-21  302  #define 
>>> _compiletime_assert(condition, msg, prefix, suffix) \
>>> eb5c2d4b45e3d2 Will Deacon 2020-07-21  303 
>>> __compiletime_assert(condition, msg, prefix, suffix)
>>> eb5c2d4b45e3d2 Will Deacon 2020-07-21  304
>>> eb5c2d4b45e3d2 Will Deacon 2020-07-21  305  /**
>>> eb5c2d4b45e3d2 Will Deacon 2020-07-21  306   * compiletime_assert - 
>>> break build and emit msg if condition is false
>>> eb5c2d4b45e3d2 Will Deacon 2020-07-21  307   * @condition: a 
>>> compile-time constant condition to check
>>> eb5c2d4b45e3d2 Will Deacon 2020-07-21  308   * @msg:       a message 
>>> to emit if condition is false
>>> eb5c2d4b45e3d2 Will Deacon 2020-07-21  309   *
>>> eb5c2d4b45e3d2 Will Deacon 2020-07-21  310   * In tradition of POSIX 
>>> assert, this macro will break the build if the
>>> eb5c2d4b45e3d2 Will Deacon 2020-07-21  311   * supplied condition is 
>>> *false*, emitting the supplied error message if the
>>> eb5c2d4b45e3d2 Will Deacon 2020-07-21  312   * compiler has support 
>>> to do so.
>>> eb5c2d4b45e3d2 Will Deacon 2020-07-21  313   */
>>> eb5c2d4b45e3d2 Will Deacon 2020-07-21  314  #define 
>>> compiletime_assert(condition, msg) \
>>> eb5c2d4b45e3d2 Will Deacon 2020-07-21 @315 
>>> _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
>>> eb5c2d4b45e3d2 Will Deacon 2020-07-21  316
>>>
>>> :::::: The code at line 315 was first introduced by commit
>>> :::::: eb5c2d4b45e3d2d5d052ea6b8f1463976b1020d5 compiler.h: Move 
>>> compiletime_assert() macros into compiler_types.h
>>>
>>> :::::: TO: Will Deacon <will@kernel.org>
>>> :::::: CC: Will Deacon <will@kernel.org>
>>>
>>> ---
>>> 0-DAY CI Kernel Test Service, Intel Corporation
>>> https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
>>>
>> _______________________________________________
>> kbuild-all mailing list -- kbuild-all@lists.01.org
>> To unsubscribe send an email to kbuild-all-leave@lists.01.org
> 
