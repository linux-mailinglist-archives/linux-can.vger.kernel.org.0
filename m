Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 534935728CB
	for <lists+linux-can@lfdr.de>; Tue, 12 Jul 2022 23:49:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229918AbiGLVtZ (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Tue, 12 Jul 2022 17:49:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233044AbiGLVtY (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 12 Jul 2022 17:49:24 -0400
Received: from mo4-p00-ob.smtp.rzone.de (mo4-p00-ob.smtp.rzone.de [85.215.255.23])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93995A2EFE
        for <linux-can@vger.kernel.org>; Tue, 12 Jul 2022 14:49:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1657662557;
    s=strato-dkim-0002; d=hartkopp.net;
    h=In-Reply-To:From:Cc:References:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=cEvcxE/u7we35FbzgZ/D+GOo3tqZBoWdrj4bbefeN3g=;
    b=nJZhPMD9NBZ1IGcAAM/iSi2PbnZGwDGCVELdxjeH1+jXwvdhX2/QhcdyTqqtfPk0Uy
    Vcb9NPDij+xkwQq9cusGoxmufYSo5Kn4GSjdaUUDEGqwlS4sOr4pVD01+p5KkS/07/wo
    78cGtukGkaxQmWPzM+i2U0SZVDOlohlBD4rAfNtMVfETtOyAtCMQ4ynqVMFLNGA3dshR
    kjmOjYvYLoilwpaZcLH7H9H21Yb7I5K12MDU7VFn6z4QIxMn9Y5kAZGaioOmmBXeMpGf
    teV/5FbztzGPYa5+Q33lDyw8n/y0p91HAwGHZNXaPBbJwweu7NR+3BPzYwKD65kPeKAG
    6hOQ==
Authentication-Results: strato.com;
    dkim=none
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjG14FZxedJy6qgO1qCHSa1GLptZHusx3hdIrpKytJSr63tDxrw=="
X-RZG-CLASS-ID: mo00
Received: from [IPV6:2a00:6020:1cfd:d100::b82]
    by smtp.strato.de (RZmta 47.47.0 AUTH)
    with ESMTPSA id t870d5y6CLnH0TE
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Tue, 12 Jul 2022 23:49:17 +0200 (CEST)
Message-ID: <a65200f3-0c51-57f8-74f7-b8395be1016c@hartkopp.net>
Date:   Tue, 12 Jul 2022 23:49:11 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: vcan OpenWRT
Content-Language: en-US
To:     Sergio Alberto Valdivia <salberto2000@hotmail.com>
References: <SN7PR14MB4270AE6DC8F68C87E6FD2876DD869@SN7PR14MB4270.namprd14.prod.outlook.com>
 <0ebdf79d-784c-6e8f-32b2-5023cf9e38ad@hartkopp.net>
 <SN7PR14MB4270FF670FBC33CAC9BAD5CADD869@SN7PR14MB4270.namprd14.prod.outlook.com>
Cc:     linux-can <linux-can@vger.kernel.org>
From:   Oliver Hartkopp <socketcan@hartkopp.net>
In-Reply-To: <SN7PR14MB4270FF670FBC33CAC9BAD5CADD869@SN7PR14MB4270.namprd14.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org



On 12.07.22 23:18, Sergio Alberto Valdivia wrote:
> Thank you very much, I guess I have a previous version of OpenWRT because it can’t find the vcan module.

OpenWrt 21.02.3 is the latest stable version.
You should upgrade your system to stay secure!

Have fun!
Oliver

> 
> Sergio A. Valdivia
> 
>> El 12 jul 2022, a la(s) 3:30 p.m., Oliver Hartkopp <socketcan@hartkopp.net> escribió:
>>
>> ﻿Hi Sergio,
>>
>>> On 12.07.22 17:41, Sergio Alberto Valdivia wrote:
>>> Hi my name is Sergio, I’m trying to use can-utils in an Onion Omega 2 pro, which runs OpenWRT.
>>> I have already installed the can-utils packages, but when I try to create a virtual CAN interface I get the following error: failed to find a module named vcan.
>>
>> You need to install the vcan kernel module first.
>>
>> E.g. on OpenWrt 21.02.3 it looks like this:
>>
>> # opkg update
>>
>> # opkg list | grep vcan
>> kmod-can-vcan - 5.4.188-1 - Similar to the network loopback devices, vcan offers a virtual local CAN interface.
>>
>> # opkg install kmod-can-vcan
>> Installing kmod-can-vcan (5.4.188-1) to root...
>> Downloading https://downloads.openwrt.org/releases/21.02.3/targets/ath79/generic/packages/kmod-can-vcan_5.4.188-1_mips_24kc.ipk
>> Installing kmod-can (5.4.188-1) to root...
>> Downloading https://downloads.openwrt.org/releases/21.02.3/targets/ath79/generic/packages/kmod-can_5.4.188-1_mips_24kc.ipk
>> Configuring kmod-can.
>> Configuring kmod-can-vcan.
>>
>> # lsmod | grep vcan
>> vcan                    2192  0
>>
>> There we are ;-)
>>
>> # ip link add type vcan
>>
>> Then you can see vcan0 in
>>
>> # cat /proc/net/dev
>>
>> Best regards,
>> Oliver
