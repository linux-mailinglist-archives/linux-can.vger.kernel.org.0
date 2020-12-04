Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3D5F02CE95F
	for <lists+linux-can@lfdr.de>; Fri,  4 Dec 2020 09:19:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728569AbgLDITA (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Fri, 4 Dec 2020 03:19:00 -0500
Received: from mo4-p00-ob.smtp.rzone.de ([85.215.255.25]:17235 "EHLO
        mo4-p00-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725866AbgLDITA (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Fri, 4 Dec 2020 03:19:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1607069707;
        s=strato-dkim-0002; d=hartkopp.net;
        h=In-Reply-To:Date:Message-ID:From:References:Cc:To:Subject:
        X-RZG-CLASS-ID:X-RZG-AUTH:From:Subject:Sender;
        bh=lZbZ4mn2eKus33EVCUtMPWaMvgDKQRTkoQUxQOnF70I=;
        b=DlymInDmq7DIGkyQ/MbjQCvhDEFf35c6cBTD3kezr49qQkj5kEFO605epFS2zpzDa7
        0gC83tJ6x/ZYeNKX0goMlf+x9lbDHe4hGwoqaIjHzbIPCUg2BEDX/M1kioR8QIlVcwc1
        fSGousKIwUKYyAX3YYt2Mk36ZlW315uFJqERSSpqBE4x7kyEf82z0NthF2L8RoT5hp66
        kXAns6q1MwrQlnwUChBQFETwfwK9953JHzcGcbatx0Bi3lhnt55bc1+0/lktjdYC3mBa
        9nb7Mag0PzGgUn4BEC5ESUWBMHTaDABKkzYhndlGewxvG7aN96NaVyVPNrcVg9FHzsE9
        vXFQ==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjG14FZxedJy6qgO1o3TMaFqTEVR9J8xjyl0="
X-RZG-CLASS-ID: mo00
Received: from [192.168.10.137]
        by smtp.strato.de (RZmta 47.3.4 DYNA|AUTH)
        with ESMTPSA id n07f3bwB48F5Hoi
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
        Fri, 4 Dec 2020 09:15:05 +0100 (CET)
Subject: Re: CAN ISO-TP Availability for Yocto
To:     Jin Park <jpark@enphaseenergy.com>
Cc:     "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>
References: <DM6PR19MB36737423D8AC8E3C53912988B1F20@DM6PR19MB3673.namprd19.prod.outlook.com>
From:   Oliver Hartkopp <socketcan@hartkopp.net>
Message-ID: <f17f5543-192b-b33d-df8b-1ea572b5c6c7@hartkopp.net>
Date:   Fri, 4 Dec 2020 09:14:59 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.0
MIME-Version: 1.0
In-Reply-To: <DM6PR19MB36737423D8AC8E3C53912988B1F20@DM6PR19MB3673.namprd19.prod.outlook.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Hello Jin,

On 03.12.20 23:50, Jin Park wrote:

> I tried to build and load module and build image with Yocto frameworks 
> and it showed the error like this.
> 
> ‘can-isotp was skipped: Recipe is blacklisted: Kernel module Needs 
> forward porting to kernel 5.2+’
> 
> Do you know whether CAN ISO-TP supports Yocto project?

the CAN ISO-TP support will be in mainline Linux starting with Linux 
kernel 5.10.

For older kernels you may use the implementation for out-of-tree 
compilation which is located here:
https://github.com/hartkopp/can-isotp (master branch)

There is also a more up-to-date version in the 4.17+ branch which I used 
to prepare the mainline process.

But out-of-tree compilation is probably not to right way to integrate 
iso-tp into Yocto. I would suggest to backport the current mainline code 
to Kernel 5.4 and create a patch for it so that is applied to the kernel 
code before the kernel compilation process.
(Is this already the process in Yocto to have a patch like this which 
lead to the Yocto error message??)

Backporting the 5.10-rc mainline code to 5.4 is really easy as only one 
thing needs to be changed/reverted:
https://github.com/hartkopp/can-isotp/commit/98986fc2f07cb5c7fa73a86d9b4b3ae417d35d79

> I tried to bake module in below condition.
> 
>   * Hardware: VAR-SOM-MX8M-NANO
>   * Yocto version: Dunfell Kernel 5.4.74
> 
> jin@jin-ThinkPad-P51:~/var-fslc-yocto$ bitbake can-isotp
> 
> WARNING: You have included the meta-virtualization layer, but 
> 'virtualization' has not been enabled in your DISTRO_FEATURES. Some 
> bbappend files may not take effect. See the meta-virtualization README 
> for details on enabling virtualization support.
> 
> Loading cache: 100% 
> |#########################################################################################################################################################################| 
> Time: 0:00:00
> 
> Loaded 3848 entries from dependency cache.
> 
> ERROR: Nothing PROVIDES 'can-isotp'
> 
> can-isotp was skipped: Recipe is blacklisted: Kernel module Needs 
> forward porting to kernel 5.2+

I'm not familiar with Yocto. But when they created a kernel patch 
including code/include/Kconfig/Makefile (as suggested above) it should 
be easy to backport the mainline code as base for a 5.4 kernel patch.

Please let me know if you have problems creating such a 5.4 kernel patch.

Regards,
Oliver

