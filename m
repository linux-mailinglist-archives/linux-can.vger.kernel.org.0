Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 32B5D346860
	for <lists+linux-can@lfdr.de>; Tue, 23 Mar 2021 20:01:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232836AbhCWTAw (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Tue, 23 Mar 2021 15:00:52 -0400
Received: from mo4-p01-ob.smtp.rzone.de ([85.215.255.50]:32734 "EHLO
        mo4-p01-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232795AbhCWTAd (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 23 Mar 2021 15:00:33 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1616526002; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=sa8+XXYk5fzpeUUGFgweLdaV5pcMYhkGYfEwI/zc7wDOas4hiXMM6xMnoqtvZbePo6
    +Dy1b9xT8IyIAEpOnTSyX9GLapGf9sijR2GIgBLdMoBF3wgaZup2KdQ/XjGsURZOJU3t
    X0EdaVtkdRPHt/c83vc77Jo+cF/R57rZci1fGls9JeSVdhFYwSVxqiqzsNVZcIQb2s2e
    4/T5ZpHwLezlfcr1agJ2GGDhkrn0MdGyHWETjvMM4kBUghWdk1kyDFPoIKASRR+ndybv
    +ZpMArFG+8vcNfzLFJbba+TJGqM3zfpbdIsn2osKO4s64ZNHrRmNxKgFi96XjiXIkelf
    d3dw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1616526002;
    s=strato-dkim-0002; d=strato.com;
    h=In-Reply-To:Date:Message-ID:From:References:Cc:To:Subject:Cc:Date:
    From:Subject:Sender;
    bh=H+iy5Xnl/Ax+UX6kbotNvo5bA7mOOjr9W7ty17zBvZQ=;
    b=EZozfeRXENsDISDAT3MMefboraw5mIovsCNJJdgFKAASDbdH7SfDPoRag5exVI6qyM
    K8dThl4GSXH3504HbTBSskM+uI7EGzSSwt7EirPDtfJe30R7keiBx048O9IAwAUh3diL
    x9ulglWQrjn/vF9jh6lEsCri8Jq9GMvLqt9OFFX1JzfPVwTQyNSwaNfhLMO95gXb0iNy
    caBb0Ugbyt3fXOIDF2h64TfULuKnoge1LywgUXQ610yK1C1tuSK8lzGUCUTxvuKfs8tO
    5+QMNgVBLNftiNqTssLAShUTIMYEiZRujFVgAI/pD+y3yENaXKOeg0uRy8d2ReKApJ8V
    91kQ==
ARC-Authentication-Results: i=1; strato.com;
    dkim=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1616526002;
    s=strato-dkim-0002; d=hartkopp.net;
    h=In-Reply-To:Date:Message-ID:From:References:Cc:To:Subject:Cc:Date:
    From:Subject:Sender;
    bh=H+iy5Xnl/Ax+UX6kbotNvo5bA7mOOjr9W7ty17zBvZQ=;
    b=CyaOCEtVZevFZ0h36g2aN34KtjvlOcqyLG3JI73Lmo04HiM/6LAKqu6AvVeQzvJsnz
    eWVWcEoR4TwCiHmuozKCuGhGjFELnDxRLzyFOHbCBHZ43b4OW1BG0UfKk/cipnv8keQN
    GX03lPw3KlAicfmxpmIq72kBt/tKqwmFldX+Gk4AJrSmUrSydasg8n2cOfKf7JiqBaQM
    xiNVdK15MVP3thQkVZoPIHOcGrXNlmJRgjfck7kWmLqZrEzq7sq+9UDig9fd7/2jdwEk
    5wf8aML3MGmpZq5N5x8ehFXZ+7pX4CaP1qlj9v8YfAKARkoGVa5uXnLzrx4kMQxond5H
    60JA==
Authentication-Results: strato.com;
    dkim=none
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjG14FZxedJy6qgO1o3HMbEWKN9eVTNI="
X-RZG-CLASS-ID: mo00
Received: from [192.168.50.177]
    by smtp.strato.de (RZmta 47.21.0 DYNA|AUTH)
    with ESMTPSA id R01debx2NJ00Gnc
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Tue, 23 Mar 2021 20:00:00 +0100 (CET)
Subject: Re: [kbuild-all] Re: include/linux/compiler_types.h:315:38: error:
 call to '__compiletime_assert_536' declared with attribute error:
 BUILD_BUG_ON failed: offsetof(struct can_frame, len) != offsetof(struct
 canfd_frame, len) || offsetof(struct can_frame, data) != offsetof(struc...
To:     Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Marc Kleine-Budde <mkl@pengutronix.de>,
        Rong Chen <rong.a.chen@intel.com>,
        Patrick Menschel <menschel.p@posteo.de>
Cc:     kernel test robot <lkp@intel.com>, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org, linux-can <linux-can@vger.kernel.org>
References: <202103210435.I0fiBGAC-lkp@intel.com>
 <dad98ebd-77a4-3305-e681-278cabe38793@hartkopp.net>
 <7f4f7e1c-194b-a903-d474-e3b742556a55@intel.com>
 <f8075a19-10e1-abf9-6d59-1a46454b74b1@hartkopp.net>
 <b10903ca-c424-b305-d981-fe0004500190@intel.com>
 <20210323073437.yo63wreqnubbeqby@pengutronix.de>
 <7ff6bfd3-6b4b-045a-abb7-485927909587@hartkopp.net>
 <a5599800-53f4-c53f-abcc-e166ea9028b9@rasmusvillemoes.dk>
 <080d9e5c-fe1f-4a64-2938-8ca6d8a98d78@hartkopp.net>
 <0a8e8e95-c1a2-ede6-9f87-1ab7a0a155e3@rasmusvillemoes.dk>
From:   Oliver Hartkopp <socketcan@hartkopp.net>
Message-ID: <212c8bc3-89f9-9c33-ed1b-b50ac04e7532@hartkopp.net>
Date:   Tue, 23 Mar 2021 19:59:55 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <0a8e8e95-c1a2-ede6-9f87-1ab7a0a155e3@rasmusvillemoes.dk>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org



On 23.03.21 15:00, Rasmus Villemoes wrote:
> On 23/03/2021 13.49, Oliver Hartkopp wrote:
>>
>>
>> On 23.03.21 12:36, Rasmus Villemoes wrote:
>>>
>>> and more directly from the horse's mouth:
>>>
>>> https://developer.arm.com/documentation/dui0067/d/arm-compiler-reference/c-and-c---implementation-details/structures--unions--enumerations--and-bitfields
>>>
>>>
>>> Field alignment
>>>
>>>       Structures are arranged with the first-named component at the lowest
>>> address. Fields are aligned as follows:
>>>
>>>           A field with a char type is aligned to the next available byte.
>>>
>>>           A field with a short type is aligned to the next even-addressed
>>> byte.
>>>
>>>           Bitfield alignment depends on how the bitfield is declared. See
>>> Bitfields in packed structures for more information.
>>>
>>>           All other types are aligned on word boundaries.
>>>
>>> That anonymous union falls into the "All other types" bullet.
>>>
>>> __packed is the documented and standard way to overrule the
>>> compiler's/ABI's layout decisions.
>>
>> So why is there a difference between
>>
>> gcc version 10.2.0
>>
>> and
>>
>> gcc version 10.2.1 20210110 (Debian 10.2.1-6)
> 
> I'm guessing there's no difference between those (in this respect), but
> they are invoked differently.
> 
>> Would this mean that either STRUCTURE_SIZE_BOUNDARY or the command line
>> option -mstructure_size_boundary=<n>
>>
>> are set differently?
> 
> Yes, though very likely -mstructure_size_boundary is not set explicitly
> but via some other option.
> 
> gcc has a rather helpful but almost unknown feature that one can
> actually query for lots of different parameters and their
> default/current values. So on my Ubuntu system (20.04, gcc 9.3), for
> example, if I do
> 
> $ arm-linux-gnueabihf-gcc -O2 -Q --help=target | grep struct
>    -mstructure-size-boundary=            8
> 
> So that would seem to say that the union should work as expected.
> However, when I actually try to compile with the .config that kbuild
> reports failing, I do see that BUILD_BUG_ON triggering.
> 
> So let us inspect the actual command line used to build some other
> random .o file in net/can; look at net/can/.bcm.o.cmd
> 
> cmd_net/can/bcm.o := arm-linux-gnueabihf-gcc -Wp,-MMD,net/can/.bcm.o.d
> -nostdinc -isystem /usr/lib/gcc-cross/arm-linux-gnueabihf/9/include
> -I./arch/arm/include -I./arch/arm/include/generated  -I./include
> -I./arch/arm/include/uapi -I./arch/arm/include/generated/uapi
> -I./include/uapi -I./include/generated/uapi -include
> ./include/linux/compiler-version.h -include ./include/linux/kconfig.h
> -include ./include/linux/compiler_types.h -D__KERNEL__ -mlittle-endian
> -I./arch/arm/mach-footbridge/include -fmacro-prefix-map=./= -Wall
> -Wundef -Werror=strict-prototypes -Wno-trigraphs -fno-strict-aliasing
> -fno-common -fshort-wchar -fno-PIE -Werror=implicit-function-declaration
> -Werror=implicit-int -Werror=return-type -Wno-format-security -std=gnu89
> -fno-dwarf2-cfi-asm -mno-unaligned-access -fno-omit-frame-pointer -mapcs
> -mno-sched-prolog -fno-ipa-sra -mabi=apcs-gnu -mno-thumb-interwork -marm
> -Wa,-mno-warn-deprecated -D__LINUX_ARM_ARCH__=4 -march=armv4
> -mtune=strongarm110 -msoft-float -Uarm -fno-delete-null-pointer-checks
> -Wno-frame-address -Wno-format-truncation -Wno-format-overflow
> -Wno-address-of-packed-member -O2 --param=allow-store-data-races=0
> -Wframe-larger-than=1024 -fno-stack-protector
> -Wno-unused-but-set-variable -Wimplicit-fallthrough
> -Wno-unused-const-variable -fno-omit-frame-pointer
> -fno-optimize-sibling-calls -fno-inline-functions-called-once
> -Wdeclaration-after-statement -Wvla -Wno-pointer-sign
> -Wno-stringop-truncation -Wno-array-bounds -Wno-stringop-overflow
> -Wno-restrict -Wno-maybe-uninitialized -fno-strict-overflow
> -fno-stack-check -fconserve-stack -Werror=date-time
> -Werror=incompatible-pointer-types -Werror=designated-init
> -Wno-packed-not-aligned    -fsanitize-coverage=trace-pc
> -DKBUILD_MODFILE='"net/can/can-bcm"' -DKBUILD_BASENAME='"bcm"'
> -DKBUILD_MODNAME='"can_bcm"' -D__KBUILD_MODNAME=kmod_can_bcm -c -o
> net/can/bcm.o net/can/bcm.c
> 
> Lots of gunk. But just to see if one of those options have affected the
> -mstructure-size-boundary= value, just take that whole command line and
> throw in -Q --help=target at the end, and we get
> 
>    -mstructure-size-boundary=            32
> 
> So let us guess that it's the ABI choice -mabi=apcs-gnu
> 
> $ arm-linux-gnueabihf-gcc -O2 -msoft-float -mabi=apcs-gnu -Q
> --help=target | grep struct
>    -mstructure-size-boundary=            32
> 
> Bingo. (-msoft-float is also included just as in the real command line
> because gcc barfs otherwise).

Thanks for all the comprehensive explanations!

> Now what CONFIG_* knobs are responsible for putting -mabi=apcs-gnu in
> CFLAGS is left as an exercise for the reader. Regardless, it is not a
> bug in the compiler. The error is the assumption that this language
> 
> "Aggregates and Unions
> 
> Structures and unions assume the alignment of their most strictly
> aligned component.

(parse error in sentence)

> Each member is assigned to the lowest available offset with the appropriate
> alignment. The size of any object is always a multiple of the object‘s
> alignment."
> 
> from the x86-64 ABI applies on all other architectures/ABIs.
> 
>> I'm not a compiler expert but this does not seem to be consistent.
>>
>> Especially as we only have byte sizes (inside and outside of the union)
>> and "A field with a char type is aligned to the next available byte."
> 
> Yes, and that's exactly what you got before the anon union was introduced.

Before(!) the union there is nothing to pad.

>> The union is indeed aligned to the word boundary - but the following
>> byte is not aligned to the next available byte.
> 
> Yes it is, because the union occupies 4 bytes. The first byte is shared
> by the two char members, the remaining three bytes are padding.

But why is the union 4 bytes long here and adds a padding of three bytes 
at the end? IMO this is an error.

Thanks for your patience,
Oliver
