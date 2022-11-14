Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EFAB262777E
	for <lists+linux-can@lfdr.de>; Mon, 14 Nov 2022 09:25:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236335AbiKNIZV (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Mon, 14 Nov 2022 03:25:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236289AbiKNIZU (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Mon, 14 Nov 2022 03:25:20 -0500
Received: from mo4-p00-ob.smtp.rzone.de (mo4-p00-ob.smtp.rzone.de [81.169.146.221])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 948881AD86
        for <linux-can@vger.kernel.org>; Mon, 14 Nov 2022 00:25:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1668414316;
    s=strato-dkim-0002; d=hartkopp.net;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=aQlPuip8xLMuEh/MsrfyqkkvtnAyqfS4rIEBUoS0CA4=;
    b=KBg4Rm7MeAHKJ3sqoS5JEme7p/rFkWof03XIdsDc6rF+tLRAFjDghdtGHEIf3s5cEt
    bGBqU7aEboyBqCxmlUcjF13RQYv3sQBfJV9in3XVOl3SfcNHx/bqCXhiaxsB7U9kN0q6
    z9k5m1dddQNMX/bdshsOwnPxdauiF3dqFSESFUQ4RMCK36X8z1pZ4oFPZIt1uTwoNl09
    3pfZuxSfyh6YjgFoh5prCZMIQOC7RYZxKYjzn+FlYH+Z6yyF/mCNwOYmKpEHI/2lboPm
    lYS/p6aTW3hKpqwhuMw+Md2CiicUr/3RUROM7RyQmKpQ+uiFqGmHwD6+/MjGbSXYSvfn
    dXXQ==
Authentication-Results: strato.com;
    dkim=none
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjG14FZxedJy6qgO1qCHSa1GLptZHusx3hdIrpKytJSr6hfz3Vg=="
X-RZG-CLASS-ID: mo00
Received: from [IPV6:2a00:6020:1cfd:d100::923]
    by smtp.strato.de (RZmta 48.2.1 AUTH)
    with ESMTPSA id Dde783yAE8PFmKq
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Mon, 14 Nov 2022 09:25:15 +0100 (CET)
Message-ID: <e42dc577-ce1d-9ac7-2bb9-25ce11abeaeb@hartkopp.net>
Date:   Mon, 14 Nov 2022 09:25:11 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.0
Subject: Re: [PATCH can-utils-dev 4/5] candump: use linux/net_tstamp.h instead
 of redefining values ourselves
To:     Vincent MAILHOL <mailhol.vincent@wanadoo.fr>
Cc:     linux-can@vger.kernel.org, Marc Kleine-Budde <mkl@pengutronix.de>
References: <20221113085321.87910-1-mailhol.vincent@wanadoo.fr>
 <20221113085321.87910-5-mailhol.vincent@wanadoo.fr>
 <ff95c43d-d620-0301-06c4-2824f4c686f6@hartkopp.net>
 <CAMZ6RqKVF6SS+eGK=bm16Q+LzitAdipchb2iPOH6c9MNo82prg@mail.gmail.com>
Content-Language: en-US
From:   Oliver Hartkopp <socketcan@hartkopp.net>
In-Reply-To: <CAMZ6RqKVF6SS+eGK=bm16Q+LzitAdipchb2iPOH6c9MNo82prg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org



On 14.11.22 06:25, Vincent MAILHOL wrote:
> On Mon. 14 Nov. 2022 at 05:05, Oliver Hartkopp <socketcan@hartkopp.net> wrote:
>> On 13.11.22 09:53, Vincent Mailhol wrote:
>>> No need to redefine values when available in header.
>>>
>>> linux/net_tstamp.h is available since Linux 2.6.30 while socket CAN
>>> was introduced in v2.6.25. These being old releases not being
>>> maintained any more for many years, dropping support is
>>> acceptable.
>>>
>>> Regardless, candump already relies on some other macros defined in
>>> more recent kernel version (e.g. CAN_RAW_ERR_FILTER) meaning that it
>>> would not build on old linux kernel environments.
>>
>> The patch is right but this text does not fit IMO.
>>
>> We have a copy of net_tstamp.h in this repository to make sure we can
>> always build the latest binaries with the latest kernel APIs even on
>> older development environments/kernels.
> 
> You are right. I missed the fact that there was a local copy of the
> kernel headers at the include/linux/ directory at the root of the
> project.
> 
> I will amend the description. I will also give a second thought on
> patch 5/5: "lib: snprintf_can_error_frame: print counter errors if
> CAN_ERR_CNT is set" as this one might have repercussions if built on a
> new machine and run on an older one.

Good idea!

Thanks!

Oliver

