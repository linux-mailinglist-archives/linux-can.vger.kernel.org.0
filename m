Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3D58A345B0B
	for <lists+linux-can@lfdr.de>; Tue, 23 Mar 2021 10:39:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230119AbhCWJir (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Tue, 23 Mar 2021 05:38:47 -0400
Received: from mga03.intel.com ([134.134.136.65]:49967 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229592AbhCWJil (ORCPT <rfc822;linux-can@vger.kernel.org>);
        Tue, 23 Mar 2021 05:38:41 -0400
IronPort-SDR: s/SdBRJvYlvkUeygEsuWINJrnQXYDssidBtK2xkY0uX9/Gw6b3isEI4hVTTwibJ8Tv88rKRP4i
 eF+UtHPVfXSg==
X-IronPort-AV: E=McAfee;i="6000,8403,9931"; a="190469402"
X-IronPort-AV: E=Sophos;i="5.81,271,1610438400"; 
   d="scan'208";a="190469402"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Mar 2021 02:38:40 -0700
IronPort-SDR: 3w5nq6C/JwVxfTYZsqf5xyHWWWW+8yxSq1jueIciIPhKSc8yM5vXKFJ3v/ISPoMhfuwqATdRji
 tQiCcrejj4Kg==
X-IronPort-AV: E=Sophos;i="5.81,271,1610438400"; 
   d="scan'208";a="414904619"
Received: from shao2-debian.sh.intel.com (HELO [10.239.13.11]) ([10.239.13.11])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Mar 2021 02:38:38 -0700
Subject: Re: [PATCH] can: uapi: can.h: mark union inside struct can_frame
 packed
To:     Marc Kleine-Budde <mkl@pengutronix.de>,
        Oliver Hartkopp <socketcan@hartkopp.net>
Cc:     linux-can@vger.kernel.org, kernel@pengutronix.de,
        kernel test robot <lkp@intel.com>
References: <20210322102814.402850-1-mkl@pengutronix.de>
 <61ef8390-6c08-8fcc-4753-5294483ec41a@hartkopp.net>
 <20210323082409.rakcci75aqodp66l@pengutronix.de>
From:   Rong Chen <rong.a.chen@intel.com>
Message-ID: <c02523d3-dbb1-87db-d455-975703de7dcd@intel.com>
Date:   Tue, 23 Mar 2021 17:37:50 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20210323082409.rakcci75aqodp66l@pengutronix.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org



On 3/23/21 4:24 PM, Marc Kleine-Budde wrote:
> On 22.03.2021 17:27:38, Oliver Hartkopp wrote:
>>
>> On 22.03.21 11:28, Marc Kleine-Budde wrote:
>>> In commit ea7800565a12 ("can: add optional DLC element to Classical
>>> CAN frame structure") the struct can_frame::can_dlc was put into an
>>> anonymous union with another u8 variable.
>>>
>>> For various reasons some members in struct can_frame and canfd_frame
>>> including the first 8 byes of data are expected to have the same
>>> memory layout. This is enforced by a BUILD_BUG_ON check in af_can.c.
>>>
>>> Since the above mentioned commit this check fails on at least one compiler
>>> (arm-linux-gnueabi-gcc (GCC) 9.3.0). Rong Chen analyzed the problem
>>> and found that the union in struct can_frame takes 4 bytes instead of
>>> the expected 1:
>>>
>>> | struct can_frame {
>>> |          canid_t                    can_id;               /* 0     4 */
>>> |          union {
>>> |                  __u8               len;                  /* 4     1 */
>>> |                  __u8               can_dlc;              /* 4     1 */
>>> |          };                                               /* 4     4 */
>>> |          __u8                       __pad;                /* 8     1 */
>>> |          __u8                       __res0;               /* 9     1 */
>>> |          __u8                       len8_dlc;             /* 10     1 */
>>> |
>>> |          /* XXX 5 bytes hole, try to pack */
>>> |
>>> |          __u8                       data[8]
>>> | __attribute__((__aligned__(8))); /*    16     8 */
>>> |
>>> |          /* size: 24, cachelines: 1, members: 6 */
>>> |          /* sum members: 19, holes: 1, sum holes: 5 */
>>> |          /* forced alignments: 1, forced holes: 1, sum forced holes: 5 */
>>> |          /* last cacheline: 24 bytes */
>>> | } __attribute__((__aligned__(8)));
>>>
>>> Marking the union as packed fixes the problem.
>> Is this a proper answer to this issue?
> With the affected compiler, yes. This patch makes the union 1 byte long,
> as expected. This effectively fixes compiling.
>
> I'm glad that the build bug triggered, which avoids having a broken
> running kernel.
>
>> Shouldn't this problem cause the developer to update the compiler?
> The question is, are the other silent corruptions with a similar union
> somewhere? Maybe we should escalate this problem to the linux-arm-kernel
> ML.
>
> Rong Chen, can I download the compiler you're using somewhere?

Hi Marc,

I tried the below two compilers , and detail is at 
https://lore.kernel.org/linux-can/f8075a19-10e1-abf9-6d59-1a46454b74b1@hartkopp.net/T/#m1eff42a8f6c24ebf066fa74a826a0ca068457ed8

https://download.01.org/0day-ci/cross-package/gcc-9.3.0-nolibc/x86_64-gcc-9.3.0-nolibc_arm-linux-gnueabi.tar.xz

http://cdn.kernel.org/pub/tools/crosstool/files/bin/x86_64/10.1.0/x86_64-gcc-10.1.0-nolibc-arm-linux-gnueabi.tar.xz

Best Regards,
Rong Chen

>
>> https://lore.kernel.org/linux-can/f8075a19-10e1-abf9-6d59-1a46454b74b1@hartkopp.net/T/#u
> regards,
> Marc
>

