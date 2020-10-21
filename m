Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 76D04294A64
	for <lists+linux-can@lfdr.de>; Wed, 21 Oct 2020 11:21:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393735AbgJUJVf (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Wed, 21 Oct 2020 05:21:35 -0400
Received: from mo4-p00-ob.smtp.rzone.de ([85.215.255.25]:12454 "EHLO
        mo4-p00-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731463AbgJUJVc (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Wed, 21 Oct 2020 05:21:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1603272091;
        s=strato-dkim-0002; d=hartkopp.net;
        h=In-Reply-To:Date:Message-ID:From:References:Cc:To:Subject:
        X-RZG-CLASS-ID:X-RZG-AUTH:From:Subject:Sender;
        bh=sWC5UqPhBbj+6aHcCCOTUSRBNRJE2RlISzYVARrJbMc=;
        b=FfZrBh89M7g0rtFLwPENtk8FMDED3MV2Mqek68cGtA1R+f8WNcpyiODu8IHFpWjgj7
        sStrq05/fwZSexPEU4UI+BOLtdkRpKJnm3Q5VDOQljmAvRfALIxBmwoMAOoU+8WnryZA
        Xc5Jrjum2vlhY7QRNT7mkowCoH2RD4UFjHq0x0RzCVoNHhxTYcLQ1KTJxUWl+FBK3EVI
        rs5WtmLsjRjnP4CQMnNWNNO1lv76o/P/58EbHJka1J/dfydsd7PQ+L1cDbRyQ/iobFnO
        EmqPOFlUoVoyLK1gYGaKkIJL3Yl1H87crBAzYdAvDxHwHZ8+XTA1c4ISFM1RsYhiwAXb
        dzig==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjG14FZxedJy6qgO1o3TMaFqTGVNiOMRppw=="
X-RZG-CLASS-ID: mo00
Received: from [192.168.10.137]
        by smtp.strato.de (RZmta 47.2.1 DYNA|AUTH)
        with ESMTPSA id D0b41cw9L9LQqL0
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
        Wed, 21 Oct 2020 11:21:26 +0200 (CEST)
Subject: Re: [net-rfc 04/16] can: dev: can_get_len(): add a helper function to
 get the correct length of Classical frames
To:     Vincent MAILHOL <mailhol.vincent@wanadoo.fr>,
        Marc Kleine-Budde <mkl@pengutronix.de>,
        linux-can@vger.kernel.org
Cc:     kernel@pengutronix.de,
        =?UTF-8?Q?St=c3=a9phane_Grosjean?= <s.grosjean@peak-system.com>
References: <20201019190524.1285319-1-mkl@pengutronix.de>
 <20201019190524.1285319-5-mkl@pengutronix.de>
 <fbbe1b80-c012-dc87-1eb0-4878cd08cce1@hartkopp.net>
 <ebf50f35-f093-b2c9-a27c-cef73d403efb@pengutronix.de>
 <20201020113023.102360-1-mailhol.vincent@wanadoo.fr>
 <6f869e47-9a76-3398-0b64-2d573d412f4c@hartkopp.net>
 <20201020160739.104686-1-mailhol.vincent@wanadoo.fr>
 <a9605011-2674-dc73-111c-8ebf724a13ac@hartkopp.net>
 <20201021005226.2727-1-mailhol.vincent@wanadoo.fr>
 <CAMZ6RqKFST4dcWZP_8NdDMB6GT09vhVWgN+nuMWkVovkh-EZdw@mail.gmail.com>
From:   Oliver Hartkopp <socketcan@hartkopp.net>
Message-ID: <2711ea6f-e1ce-c3f9-dd98-83142bd33fc9@hartkopp.net>
Date:   Wed, 21 Oct 2020 11:21:25 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <CAMZ6RqKFST4dcWZP_8NdDMB6GT09vhVWgN+nuMWkVovkh-EZdw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Hi Vincent,

On 21.10.20 08:23, Vincent MAILHOL wrote:
>>>  From a first thought I would see a new flag CAN_CTRLMODE_RAW_DLC in the
>>> netlink interface of IFLA_CAN_CTRLMODE for the CAN controller driver.
>>>
>>> This could switch the sanitizing AND the CAN controller can properly
>>> expose its ability to support this mode.
>>
>> Absolutely yes. In my first message, I mentioned the idea of managing
>> that through socket option, glad that we now share the same idea.
> 
> Actually, I just realized that I replied to you too quickly. I was not
> exactly thinking of the same thing here so let me correct what I
> previously said.
> 
> IFLA_CAN_CTRLMODE is at the netlink level. My idea is to have it, in
> addition, at the socket level. Example: add CAN_RAW_RAW_DLC in
> include/uapi/linux/can/raw.h.

Yes. We need at least some different handling inside the driver level 
which could be switched with CAN_CTRLMODE_RAW_DLC.

> The reason is that if we only manage it at the netlink level, some
> application not aware of the RAW_DLC issue might run into some buffer
> overflow issue. Unless an application directly requests it, the current
> behaviour should be maintained (rationale: do not break userland).
> 
> So the full picture will be to have both the CAN_CTRLMODE_RAW_DLC at
> netlink level and CAN_RAW_RAW_DLC at the socket level (in the exact same
> way we have both CAN_CTRLMODE_FD and CAN_RAW_FD_FRAMES for
> CAN-FD).

Yes. That hits the point.

Btw. the impact on all protocols seems to be pretty heavy and to me it 
turned out that it would be a bad idea to use can_frame.can_dlc as 
transport vehicle for the raw dlc. Especially as this will contradict 
the rule that the can_dlc element is a plain length information today as 
canfd_frame.len and shares the same position in the struct.

I currently tend to only have a switch on driver level with 
CAN_CTRLMODE_RAW_DLC and make use of can_frame._res0 -> can_frame.raw_dlc

With CAN_CTRLMODE_RAW_DLC enabled the CAN driver would ...

- fill can_dlc and raw_dlc at reception time
- will use raw_dlc instead of can_dlc at tx time
- will use can_dlc if raw_dlc == 0 at tx time

This would have a minimal impact on the code and we only need to make 
sure that the raw_dlc is not killed at some stage in the network layer.

#define CAN_MAX_RAW_DLC 15

IMO the raw dlc use-case is a really special case for testing purposes. 
Touching the current can_frame.can_dlc handling could lead to more 
complexity and the fear to run into overflows as already stated by Joakim.

What do you think about the above approach?

Regards,
Oliver
