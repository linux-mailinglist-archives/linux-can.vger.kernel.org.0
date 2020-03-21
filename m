Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 06F7018E14A
	for <lists+linux-can@lfdr.de>; Sat, 21 Mar 2020 13:38:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727317AbgCUMiz (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Sat, 21 Mar 2020 08:38:55 -0400
Received: from mo4-p00-ob.smtp.rzone.de ([81.169.146.221]:22233 "EHLO
        mo4-p00-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726607AbgCUMiz (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Sat, 21 Mar 2020 08:38:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1584794330;
        s=strato-dkim-0002; d=hartkopp.net;
        h=In-Reply-To:Date:Message-ID:From:References:To:Subject:
        X-RZG-CLASS-ID:X-RZG-AUTH:From:Subject:Sender;
        bh=wtB8/ERINB4blKOqfY5lTlPZAmXRPVhQ5Fj+8xfzxX0=;
        b=UwI2bV07u0YlHr9wsbLMw3KJKPa2MZTMLo8Viquc7n2BTpAuq3weRfQmPUUbTkrI2Z
        PSf/QHhhtLD9E19PvEmzl6z11g1+QcgqtBz8EjzYVk+o05EuFk3wJDcYLd2E2b2hPpZa
        GE6go+9bRnI98QDGJtmvokE1Gk0xS4V0XdlBUlLeDCbX3rlRHQex5lUtf26M5zWwejBh
        0OfFSAqXnJINkcIJG6REmVp49eJGg0PcjLBLO2HcTnSoL521M5tkpWhHAT+gbA5XOEBQ
        sKqxeWHSLNWbYjHLmrHu/CpNSU+hlNzw7fhxjHxJPvbMqxwSGXbo3kMSdWYjpxQa/tfv
        V1UQ==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjG14FZxedJy6qgO1o3PMaViOoLMGXsh6kk/L"
X-RZG-CLASS-ID: mo00
Received: from [192.168.50.177]
        by smtp.strato.de (RZmta 46.2.1 DYNA|AUTH)
        with ESMTPSA id R0105bw2LCcn6Zn
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
        Sat, 21 Mar 2020 13:38:49 +0100 (CET)
Subject: Re: Need help in interpreting ip status output
To:     =?UTF-8?Q?Andr=c3=a9_Hartmann?= <aha_1980@gmx.de>,
        "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>
References: <a6c8ef8c-5c72-7a2b-98df-0a30057c5fdc@gmx.de>
 <f029f731-25bc-a3f0-c5a9-380012a16839@gmx.de>
From:   Oliver Hartkopp <socketcan@hartkopp.net>
Message-ID: <86b34b1b-7bda-e481-2087-1be8e64d2fed@hartkopp.net>
Date:   Sat, 21 Mar 2020 13:38:49 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <f029f731-25bc-a3f0-c5a9-380012a16839@gmx.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-can-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Hi André,

I have an idea ;-)

On 12/03/2020 18.43, André Hartmann wrote:

>> can someone help me interpreting the following ip output:
>>
>> ip -s link show can1
>>       3: can1: <NOARP,UP,LOWER_UP,ECHO> mtu 16 qdisc pfifo_fast state 
>> UNKNOWN mode DEFAULT group default qlen 100
>>           link/can
>>           RX: bytes  packets  errors  dropped overrun mcast
>>           0          9987413  1       74      1       0
>>           TX: bytes  packets  errors  dropped carrier collsns
>>           0          0        0       0       0       0
>>
>> I'm especially interested in the meaning of the
>>
>> * 1 errors
>> * 74 dropped
>> * 1 overrun

E.g. if you look into
linux/drivers/net/can/sja1000/sja1000.c
you can see that an overrun error also triggers the error counter to 
increase - that's why both are set to 1.

The reason for the overrun error is a notification from the CAN 
controller itself. It tells us that the received CAN frame has not been 
read from the controller until the next CAN frame arrived.

The dropped counter usually indicates that the CAN driver did not get a 
skbuff data structure (e.g. out of memory condition).

This is NOT good. What CAN hardware/setup are you using?

Regards,
Oliver
