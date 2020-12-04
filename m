Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3C33B2CEA75
	for <lists+linux-can@lfdr.de>; Fri,  4 Dec 2020 10:05:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726646AbgLDJFF (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Fri, 4 Dec 2020 04:05:05 -0500
Received: from mo4-p00-ob.smtp.rzone.de ([81.169.146.161]:21331 "EHLO
        mo4-p00-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726471AbgLDJFF (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Fri, 4 Dec 2020 04:05:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1607072472;
        s=strato-dkim-0002; d=hartkopp.net;
        h=In-Reply-To:Date:Message-ID:References:Cc:To:From:Subject:
        X-RZG-CLASS-ID:X-RZG-AUTH:From:Subject:Sender;
        bh=WoerftFteiX6ACIuckmPLw/giNbgN3pDu/k+wbu1p1I=;
        b=ixB2Q1lf+yFmPE3b+7DSxobbBDlf0UB5Z66RsOWj7wvJg27XwloGxoU8cfEK3fXmLY
        Pzn3r7RxMwWL2D8V0ZGlTyBhY+Amkm8O5BwZRqeCmSjZlrTsdzgr4rxb/PZ4gZGqduS7
        gvJCNHB6/fHAPFwnW3462M+CyoeW223ZqYOupjdigyEeehg7iTso7w5EbmbGB380sPYb
        ZKoMTKr9sX1zqNnXjA26CELyY2BIBXjgMaChrkFqlg/9OEAZPbcebwL0W/I6yuBqWlff
        LtGPmi0JYFWOJfAmRms9IYIdoqQIbiKnDcnnXAg3pS7juVr6dibAQVBWdV9pWWuKIPTy
        8XmA==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjG14FZxedJy6qgO1o3TMaFqTEVR9J8xjyl0="
X-RZG-CLASS-ID: mo00
Received: from [192.168.10.137]
        by smtp.strato.de (RZmta 47.3.4 DYNA|AUTH)
        with ESMTPSA id n07f3bwB491BI3S
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
        Fri, 4 Dec 2020 10:01:11 +0100 (CET)
Subject: Re: CAN ISO-TP Availability for Yocto
From:   Oliver Hartkopp <socketcan@hartkopp.net>
To:     Jin Park <jpark@enphaseenergy.com>
Cc:     "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>
References: <DM6PR19MB36737423D8AC8E3C53912988B1F20@DM6PR19MB3673.namprd19.prod.outlook.com>
 <f17f5543-192b-b33d-df8b-1ea572b5c6c7@hartkopp.net>
Message-ID: <4b93c231-a1de-05b4-54bb-1407168560f5@hartkopp.net>
Date:   Fri, 4 Dec 2020 10:01:10 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.0
MIME-Version: 1.0
In-Reply-To: <f17f5543-192b-b33d-df8b-1ea572b5c6c7@hartkopp.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Just an addition:

I've looked into openembedded

https://github.com/openembedded/meta-openembedded/commits/master/meta-oe/recipes-extended/socketcan/can-isotp_git.bb

and iso-tp was blacklisted here:

https://github.com/openembedded/meta-openembedded/commit/649d491b213f19f4d7382cc20d824785d0965310#diff-a0aaa6de49c7f7360101571e2fe547248bb29c611c1bcf1f358667007c12f6b5

The recipe update is from 2019-08-29
https://github.com/openembedded/meta-openembedded/commit/d6b4dee1b16b6b2bf5c502f23be7eb05ad2f675e#diff-a0aaa6de49c7f7360101571e2fe547248bb29c611c1bcf1f358667007c12f6b5

So I wonder why isotp was blacklisted instead of upgrading the commit 
hash to a more recent version of the can-isotp GitHub repo ...

¯\_(ツ)_/¯

Btw. they use the out-of-tree implementation instead of creating a 
patch. Hm.



On 04.12.20 09:14, Oliver Hartkopp wrote:
> Hello Jin,
> 
> On 03.12.20 23:50, Jin Park wrote:
> 
>> I tried to build and load module and build image with Yocto frameworks 
>> and it showed the error like this.
>>
>> ‘can-isotp was skipped: Recipe is blacklisted: Kernel module Needs 
>> forward porting to kernel 5.2+’
>>
>> Do you know whether CAN ISO-TP supports Yocto project?
> 
> the CAN ISO-TP support will be in mainline Linux starting with Linux 
> kernel 5.10.
> 
> For older kernels you may use the implementation for out-of-tree 
> compilation which is located here:
> https://github.com/hartkopp/can-isotp (master branch)
> 
> There is also a more up-to-date version in the 4.17+ branch which I used 
> to prepare the mainline process.
> 
> But out-of-tree compilation is probably not to right way to integrate 
> iso-tp into Yocto. I would suggest to backport the current mainline code 
> to Kernel 5.4 and create a patch for it so that is applied to the kernel 
> code before the kernel compilation process.
> (Is this already the process in Yocto to have a patch like this which 
> lead to the Yocto error message??)
> 
> Backporting the 5.10-rc mainline code to 5.4 is really easy as only one 
> thing needs to be changed/reverted:
> https://github.com/hartkopp/can-isotp/commit/98986fc2f07cb5c7fa73a86d9b4b3ae417d35d79 
> 
> 
>> I tried to bake module in below condition.
>>
>>   * Hardware: VAR-SOM-MX8M-NANO
>>   * Yocto version: Dunfell Kernel 5.4.74
>>
>> jin@jin-ThinkPad-P51:~/var-fslc-yocto$ bitbake can-isotp
>>
>> WARNING: You have included the meta-virtualization layer, but 
>> 'virtualization' has not been enabled in your DISTRO_FEATURES. Some 
>> bbappend files may not take effect. See the meta-virtualization README 
>> for details on enabling virtualization support.
>>
>> Loading cache: 100% 
>> |#########################################################################################################################################################################| 
>> Time: 0:00:00
>>
>> Loaded 3848 entries from dependency cache.
>>
>> ERROR: Nothing PROVIDES 'can-isotp'
>>
>> can-isotp was skipped: Recipe is blacklisted: Kernel module Needs 
>> forward porting to kernel 5.2+
> 
> I'm not familiar with Yocto. But when they created a kernel patch 
> including code/include/Kconfig/Makefile (as suggested above) it should 
> be easy to backport the mainline code as base for a 5.4 kernel patch.
> 
> Please let me know if you have problems creating such a 5.4 kernel patch.
> 
> Regards,
> Oliver
> 
