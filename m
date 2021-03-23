Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8D1D7345E7C
	for <lists+linux-can@lfdr.de>; Tue, 23 Mar 2021 13:50:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230347AbhCWMtn (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Tue, 23 Mar 2021 08:49:43 -0400
Received: from mo4-p01-ob.smtp.rzone.de ([85.215.255.54]:14512 "EHLO
        mo4-p01-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230225AbhCWMtZ (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 23 Mar 2021 08:49:25 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1616503747; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=UJBQO+4sjH2MNOBp1irTktv/TLRYezB1F2QopiboVmjNEtcIAbLPfKVSYynMAwuKH/
    nofVM15h2vuPy3yLFZsXgTEcI50GBq1Xjrw9Lc/rBhuocGcqlRgMeErPM77FjZpYiQBS
    +XamBH6zuVNTCboVvIxFu5NhUpktqwg0oymTiT/zc3w4c0NdLP1LGtcPxlE1UN2t5zXM
    MGmtRA+KDu3GOTUHJsT58y3oP28rVzGf34H2tGfyV+YhvKMiM1SEZLxF1MwFExUL+EIb
    SrRCHfdUCV2rOh5gYjZX9+YGhMiJy7EMw9TF4XcCNmxz3GudzTkmgG5x/z37Lk6AZqXI
    DA1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1616503747;
    s=strato-dkim-0002; d=strato.com;
    h=In-Reply-To:Date:Message-ID:From:References:Cc:To:Subject:Cc:Date:
    From:Subject:Sender;
    bh=54FbOPMMx9252ak9oy/bpUJQjbPZrvT51k9lrhpURY8=;
    b=awYs7JFs5gt3eWntUYea3NMqpQ/mk6dsWFRKG4x8cj87rxgCyZr58Y8E2TVhhpgZIj
    iwFjI2cHwTeAhK+7fLTgXCt8QMgCSgYRK0WaCVJnV3FWqbkOkA3ASj0kTNa1JCrZ45YB
    bu69xMqrWIv0cxTsVIXGyzpqu6YhXCJEkXe5H6JlZaikXtcf7bRMjdH+TWpm/OtwockW
    FQEu5V6CyKC488pID+tUz1IUzXAmCLoU0He9QotyQTo3mbVqWd7MfOk1nPnL68WI9OvJ
    c20Q7WVwCiz/2XtD0KdUEqxbn49NxNlUwaaAtkiH0DSrwVVFYlngIHSxfse2UZH+tHgk
    /qlg==
ARC-Authentication-Results: i=1; strato.com;
    dkim=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1616503747;
    s=strato-dkim-0002; d=hartkopp.net;
    h=In-Reply-To:Date:Message-ID:From:References:Cc:To:Subject:Cc:Date:
    From:Subject:Sender;
    bh=54FbOPMMx9252ak9oy/bpUJQjbPZrvT51k9lrhpURY8=;
    b=AWSh6K8gVLx0CkUcxKNAf36egZBKz2BhAXdZ022WFc1WgAnxTT1CWW5a5uGjxIv0AM
    +5iw3Bs0cN7qKiTNHgG7gSBhfSAyvc/sNXBohYZRzzFcaWrq6YY6q3wFAqY5t4F4rxOw
    S4++ixoOZqPBlMBfwXv4Aq+ZIj9yF5aGX5o8rBtyA7njUEq32JheXPSvPF5txs9XYzA/
    EF9AcTxxliw5HfMkQc1/kX/esOAnyuhKTmys359XChlXuMIZlDXFBbiuBbFo9uikUA20
    1TF8qXNxUHW6g+8f/8Rv4g/kmPP+ahi1eyfyiRN2KbO6ioHe564mpzTCuPz/R9Kypkid
    NHsQ==
Authentication-Results: strato.com;
    dkim=none
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjG14FZxedJy6qgO1o3TMaFqTEVR+J8xswl0="
X-RZG-CLASS-ID: mo00
Received: from [192.168.10.137]
    by smtp.strato.de (RZmta 47.21.0 DYNA|AUTH)
    with ESMTPSA id R01debx2NCn6FI6
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Tue, 23 Mar 2021 13:49:06 +0100 (CET)
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
From:   Oliver Hartkopp <socketcan@hartkopp.net>
Message-ID: <080d9e5c-fe1f-4a64-2938-8ca6d8a98d78@hartkopp.net>
Date:   Tue, 23 Mar 2021 13:49:01 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <a5599800-53f4-c53f-abcc-e166ea9028b9@rasmusvillemoes.dk>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org



On 23.03.21 12:36, Rasmus Villemoes wrote:
> On 23/03/2021 08.45, Oliver Hartkopp wrote:
> 
>> IMO we facing a compiler problem here - and we should be very happy that
>> the BUILD_BUG_ON() triggered an issue after years of silence.
>>
>> I do not have a good feeling about what kind of strange effects this
>> compiler issue might have in other code of other projects.
>>
>> So I would explicitly suggest NOT to change the af_can.c code to work
>> around this compiler issue.
>>
>> Let the gcc people fix their product and let them thank all of us for
>> detecting it.
> 
> I'm sure you'd be eligible for a full refund in case this was a bug in
> gcc. It is not. It's a pretty clear ABI requirement for (at least some
> flavors of) ARM:
> 
> https://stackoverflow.com/questions/43786747/struct-layout-in-apcs-gnu-abi
> 
> and more directly from the horse's mouth:
> 
> https://developer.arm.com/documentation/dui0067/d/arm-compiler-reference/c-and-c---implementation-details/structures--unions--enumerations--and-bitfields
> 
> Field alignment
> 
>      Structures are arranged with the first-named component at the lowest
> address. Fields are aligned as follows:
> 
>          A field with a char type is aligned to the next available byte.
> 
>          A field with a short type is aligned to the next even-addressed
> byte.
> 
>          Bitfield alignment depends on how the bitfield is declared. See
> Bitfields in packed structures for more information.
> 
>          All other types are aligned on word boundaries.
> 
> That anonymous union falls into the "All other types" bullet.
> 
> __packed is the documented and standard way to overrule the
> compiler's/ABI's layout decisions.

So why is there a difference between

gcc version 10.2.0

and

gcc version 10.2.1 20210110 (Debian 10.2.1-6)

https://lore.kernel.org/linux-can/20210323073437.yo63wreqnubbeqby@pengutronix.de/

??

Would this mean that either STRUCTURE_SIZE_BOUNDARY or the command line 
option -mstructure_size_boundary=<n>

are set differently?

https://stackoverflow.com/questions/43786747/struct-layout-in-apcs-gnu-abi/43829053#43829053

I'm not a compiler expert but this does not seem to be consistent.

Especially as we only have byte sizes (inside and outside of the union) 
and "A field with a char type is aligned to the next available byte."

The union is indeed aligned to the word boundary - but the following 
byte is not aligned to the next available byte.

Regards,
Oliver
