Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BDBAA633CEA
	for <lists+linux-can@lfdr.de>; Tue, 22 Nov 2022 13:52:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233607AbiKVMwz (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Tue, 22 Nov 2022 07:52:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233564AbiKVMww (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 22 Nov 2022 07:52:52 -0500
Received: from mo4-p00-ob.smtp.rzone.de (mo4-p00-ob.smtp.rzone.de [85.215.255.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7ACF2101EA
        for <linux-can@vger.kernel.org>; Tue, 22 Nov 2022 04:52:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1669121563;
    s=strato-dkim-0002; d=hartkopp.net;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=+JYgCG1vjV+n0HQQyWtxZ6AroOrz6Jxn+jE23zMymYM=;
    b=cJS6vAAS5oHVD9+h3NYtoORXoEc46nN1iMu9xA0gixQ4/bVciPJ7Kzn/6vCXUwT0me
    5FgBrbmGQmS7/saXZo5ShJLnX7tEoCaK2U6jO1SqfOtHb5myaIZVISNl5pIdbFmD0aSn
    WV20KvUVgbHR4JGa7umQfYxNamwDxaz4UIa5bWUEXXa09yp/BNzV7IHCLgkAYVMFu4Ks
    gFX5blAUL/nbhwOT4McLrbsx4K3JMCOdB//ZbhQ+CX7nCGXqWdKcHgrARiEqpTORY4zJ
    6zEI1Jgmre8TWJQ0QCTEv1oDay+W857sC2t3Qri5NVAFsFeUWxeU45NvjAfW4fZ/iEq+
    OyNA==
Authentication-Results: strato.com;
    dkim=none
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjG14FZxedJy6qgO1qCHSa1GLptZHusx3hdIrpKytJSr6hfz3Vg=="
X-RZG-CLASS-ID: mo00
Received: from [IPV6:2a00:6020:1cfd:d100::923]
    by smtp.strato.de (RZmta 48.2.1 AUTH)
    with ESMTPSA id Dde783yAMCqhBZr
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Tue, 22 Nov 2022 13:52:43 +0100 (CET)
Message-ID: <96a4de81-882b-cd88-ae7a-ca3b7c3b432f@hartkopp.net>
Date:   Tue, 22 Nov 2022 13:52:38 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: Problem receiving > 8 byte UDS response when using istpsend
To:     Patrick Menschel <menschel.p@posteo.de>,
        Marvin Ludersdorfer <marvin.ludersdorfer@dintec.solutions>
Cc:     "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>,
        Andre Naujoks <nautsch2@gmail.com>
References: <FR2P281MB165556E4F729AC3CDB50F6F69F0A9@FR2P281MB1655.DEUP281.PROD.OUTLOOK.COM>
 <FR2P281MB165503FACCD9894C353ED4CE9F0A9@FR2P281MB1655.DEUP281.PROD.OUTLOOK.COM>
 <49ce15b4-feaf-a519-9172-d0f59a9285ed@gmail.com>
 <40200c08-552e-e6b3-c5c7-f5ee8a4b839c@posteo.de>
Content-Language: en-US
From:   Oliver Hartkopp <socketcan@hartkopp.net>
In-Reply-To: <40200c08-552e-e6b3-c5c7-f5ee8a4b839c@posteo.de>
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



On 21.11.22 17:45, Patrick Menschel wrote:
> Am 21.11.22 um 17:11 schrieb Andre Naujoks:
>> Am 21.11.22 um 13:08 schrieb Marvin Ludersdorfer:
>>>
>>> In another terminal, I run echo 22 F1 95 | isotpsend -s 00000680 -d 
>>> 00000780 can0 -p 0x00
> 
> Typical error,
> 
> exchange -s and -d
> 
> isotprecv works the other way around.
> 

:-D Yes. Trapped into this myself some times.

Btw. @Marvin are you really sure with the given values for the CAN IDs?

The help text says:

Usage: isotpsend [options] <CAN interface>
Options:
          -s <can_id>  (source can_id. Use 8 digits for extended IDs)
          -d <can_id>  (destination can_id. Use 8 digits for extended IDs)

So your IDs 00000680 and 00000780 are 29 bit CAN identifiers!

Is this intentionally?

Some people mix up the nominal values with the 11/29-bit IDs and think 
every CAN ID below 0x800 is a 11 bit CAN ID.

Regards,
Oliver
