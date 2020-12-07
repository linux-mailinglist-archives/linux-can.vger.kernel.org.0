Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4EB262D126E
	for <lists+linux-can@lfdr.de>; Mon,  7 Dec 2020 14:47:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726046AbgLGNrY (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Mon, 7 Dec 2020 08:47:24 -0500
Received: from mo4-p00-ob.smtp.rzone.de ([85.215.255.22]:29718 "EHLO
        mo4-p00-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726042AbgLGNrY (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Mon, 7 Dec 2020 08:47:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1607348607;
        s=strato-dkim-0002; d=hartkopp.net;
        h=In-Reply-To:Date:Message-ID:From:References:Cc:To:Subject:
        X-RZG-CLASS-ID:X-RZG-AUTH:From:Subject:Sender;
        bh=55JZK/dt5t9+W8Z8jEecFE9mUoxZ2ZUvpLWLDszELyc=;
        b=YjnH94q3GGK6Y2lQ6lFv9NmPMv6SywTgufPBBEGufjVU7/ZYxWIqjei4RaufSnt0d9
        lHp7MSL72N00PplrdZxIDLNn1F4YSt4W5/sRv6D4pogy6hM9+DqJMByzqAHrzZXm0Cj2
        ZV9+F55N17J+0GRQHB1vNj9EdfWqysZG5svXHJWhdGSee0m9nJZW5liPHsVBOsKOd3ww
        wQtyx1Z/b/LIRzdKVaYzQukS7UJPRXEVSvQlTbCmLnImRmB8fbrDYcKPZjqfXJ04WhZa
        o2EexETd3wRmbRchATedWtDfw3qYA5tJa60D7AwacZC85jTywBm9C53MHvtC8I3eGr7u
        ZLkw==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjG14FZxedJy6qgO1o3TMaFqTEVR+J89vzF0="
X-RZG-CLASS-ID: mo00
Received: from [192.168.10.137]
        by smtp.strato.de (RZmta 47.3.4 SBL|AUTH)
        with ESMTPSA id n07f3bwB7DhPQWd
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
        Mon, 7 Dec 2020 14:43:25 +0100 (CET)
Subject: Re: CAN ISO-TP Availability for Yocto
To:     Jin Park <jpark@enphaseenergy.com>
Cc:     "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>
References: <DM6PR19MB36737423D8AC8E3C53912988B1F20@DM6PR19MB3673.namprd19.prod.outlook.com>
 <f17f5543-192b-b33d-df8b-1ea572b5c6c7@hartkopp.net>
 <4b93c231-a1de-05b4-54bb-1407168560f5@hartkopp.net>
 <DM6PR19MB3673077699C6F1AEECA5D9A2B1F10@DM6PR19MB3673.namprd19.prod.outlook.com>
From:   Oliver Hartkopp <socketcan@hartkopp.net>
Message-ID: <c75bccd0-3ff4-cf81-8bc8-4260b1274758@hartkopp.net>
Date:   Mon, 7 Dec 2020 14:43:20 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.0
MIME-Version: 1.0
In-Reply-To: <DM6PR19MB3673077699C6F1AEECA5D9A2B1F10@DM6PR19MB3673.namprd19.prod.outlook.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org



On 04.12.20 22:46, Jin Park wrote:
> Hello Oliver,
> 
> I appreciate your comments.
> 
> I successfully build the image, loading can-isotp module with your suggestion and change .bb recipe for can-isotp.
> I commanded send and recv for 'can-isotp' in my hardware board and it worked.
> 
> In the socketcan directoryin my local, there is can-isotp_git.bb like below path and I revised the bb.
> <yocto>/sources/meta-openembedded/meta-oe/recipes-extended/socketcan
> 
> Here is my revision for bb.
> 1) I reverted back to the commit id, d50a2001ec994031233ad9c0cc1647fad41835f3, and change the branch to 4.17+.

It should work for 5.4.x

Btw. looking forward to 5.10 where all this out-of-tree stuff becomes 
obsolete ...

Regards,
Oliver

> 
> If you think that something wrong with the commit id, please let me know. The commit id is just before the commit id that changing from Kernel version change like below.
> 
> #if LINUX_VERSION_CODE < KERNEL_VERSION(5,4,0)
> #error This module needs Kernel 5.4 or newer
> #if LINUX_VERSION_CODE < KERNEL_VERSION(5,9,0)
> #error This module needs Kernel 5.9 or newer
> 
> 2) I commented out PNBLACKLIST like below, because my Yocto framework is based on Dunfell 5.4.
> I opened the issue in openembedded like below. It seems okay to comment out PNBLACKLIST. At least, it works for my hardware and yocto environment.
> https://github.com/openembedded/meta-openembedded/issues/296
> 
> #<can-isotp_git.bb>
> 
> LICENSE = "GPLv2"
> LIC_FILES_CHKSUM = "file://COPYING;md5=72d977d697c3c05830fdff00a7448931"
> SRCREV = "d50a2001ec994031233ad9c0cc1647fad41835f3"
> PV = "1.0+git${SRCPV}"
> SRC_URI = "git://github.com/hartkopp/can-isotp.git;branch=4.17+;protocol=https"
> S = "${WORKDIR}/git"
> inherit module
> EXTRA_OEMAKE += "KERNELDIR=${STAGING_KERNEL_DIR}"
> #PNBLACKLIST[can-isotp] = "Kernel module Needs forward porting to kernel 5.2+"
> 
> In addition, FYI, I added 'can-isotp' in my <build>/conf/local.conf like below.
> 
> IMAGE_INSTALL_append = " \
>      tcf-agent \
>      openssh-sftp-server \
>      can-isotp \
> "
> 
> Thanks for your help.
> 
> Regards,
> Jin
> 
> -----Original Message-----
> From: Oliver Hartkopp <socketcan@hartkopp.net>
> Sent: Friday, December 4, 2020 1:01 AM
> To: Jin Park <jpark@enphaseenergy.com>
> Cc: linux-can@vger.kernel.org
> Subject: Re: CAN ISO-TP Availability for Yocto
> 
> EXTERNAL EMAIL - Use caution when responding, clicking, and/or downloading attachments.
> 
> 
> 
> 
> 
> Just an addition:
> 
> I've looked into openembedded
> 
> https://github.com/openembedded/meta-openembedded/commits/master/meta-oe/recipes-extended/socketcan/can-isotp_git.bb
> 
> and iso-tp was blacklisted here:
> 
> https://github.com/openembedded/meta-openembedded/commit/649d491b213f19f4d7382cc20d824785d0965310#diff-a0aaa6de49c7f7360101571e2fe547248bb29c611c1bcf1f358667007c12f6b5
> 
> The recipe update is from 2019-08-29
> https://github.com/openembedded/meta-openembedded/commit/d6b4dee1b16b6b2bf5c502f23be7eb05ad2f675e#diff-a0aaa6de49c7f7360101571e2fe547248bb29c611c1bcf1f358667007c12f6b5
> 
> So I wonder why isotp was blacklisted instead of upgrading the commit hash to a more recent version of the can-isotp GitHub repo ...
> 
> ¯\_(ツ)_/¯
> 
> Btw. they use the out-of-tree implementation instead of creating a patch. Hm.
> 
> 
> 
> On 04.12.20 09:14, Oliver Hartkopp wrote:
>> Hello Jin,
>>
>> On 03.12.20 23:50, Jin Park wrote:
>>
>>> I tried to build and load module and build image with Yocto
>>> frameworks and it showed the error like this.
>>>
>>> ‘can-isotp was skipped: Recipe is blacklisted: Kernel module Needs
>>> forward porting to kernel 5.2+’
>>>
>>> Do you know whether CAN ISO-TP supports Yocto project?
>>
>> the CAN ISO-TP support will be in mainline Linux starting with Linux
>> kernel 5.10.
>>
>> For older kernels you may use the implementation for out-of-tree
>> compilation which is located here:
>> https://github.com/hartkopp/can-isotp (master branch)
>>
>> There is also a more up-to-date version in the 4.17+ branch which I
>> used to prepare the mainline process.
>>
>> But out-of-tree compilation is probably not to right way to integrate
>> iso-tp into Yocto. I would suggest to backport the current mainline
>> code to Kernel 5.4 and create a patch for it so that is applied to the
>> kernel code before the kernel compilation process.
>> (Is this already the process in Yocto to have a patch like this which
>> lead to the Yocto error message??)
>>
>> Backporting the 5.10-rc mainline code to 5.4 is really easy as only
>> one thing needs to be changed/reverted:
>> https://github.com/hartkopp/can-isotp/commit/98986fc2f07cb5c7fa73a86d9
>> b4b3ae417d35d79
>>
>>
>>> I tried to bake module in below condition.
>>>
>>>    * Hardware: VAR-SOM-MX8M-NANO
>>>    * Yocto version: Dunfell Kernel 5.4.74
>>>
>>> jin@jin-ThinkPad-P51:~/var-fslc-yocto$ bitbake can-isotp
>>>
>>> WARNING: You have included the meta-virtualization layer, but
>>> 'virtualization' has not been enabled in your DISTRO_FEATURES. Some
>>> bbappend files may not take effect. See the meta-virtualization
>>> README for details on enabling virtualization support.
>>>
>>> Loading cache: 100%
>>> |####################################################################
>>> |####################################################################
>>> |#################################|
>>> Time: 0:00:00
>>>
>>> Loaded 3848 entries from dependency cache.
>>>
>>> ERROR: Nothing PROVIDES 'can-isotp'
>>>
>>> can-isotp was skipped: Recipe is blacklisted: Kernel module Needs
>>> forward porting to kernel 5.2+
>>
>> I'm not familiar with Yocto. But when they created a kernel patch
>> including code/include/Kconfig/Makefile (as suggested above) it should
>> be easy to backport the mainline code as base for a 5.4 kernel patch.
>>
>> Please let me know if you have problems creating such a 5.4 kernel patch.
>>
>> Regards,
>> Oliver
>>
