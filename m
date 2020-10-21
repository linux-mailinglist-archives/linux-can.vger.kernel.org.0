Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1B2DF2951D0
	for <lists+linux-can@lfdr.de>; Wed, 21 Oct 2020 19:53:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2503750AbgJURxH (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Wed, 21 Oct 2020 13:53:07 -0400
Received: from mo4-p00-ob.smtp.rzone.de ([81.169.146.161]:17513 "EHLO
        mo4-p00-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2503749AbgJURxH (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Wed, 21 Oct 2020 13:53:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1603302783;
        s=strato-dkim-0002; d=hartkopp.net;
        h=In-Reply-To:Date:Message-ID:From:References:Cc:To:Subject:
        X-RZG-CLASS-ID:X-RZG-AUTH:From:Subject:Sender;
        bh=VXD0TJoP2YcCv7a6HyYsmw112qWY3uyDR2KdRnxQCf0=;
        b=kZD0h4nwVwtA3hE17MchOTMZOnabPYTm5kpjQ/G6DccNFKacsJc9j+MvSJUzyUOyj+
        SB4lSunhd+Om1cAolUFv8YRrEybPP11UW0lhmLl7orScCOS/KpZUyspxzqGdySAbqTSc
        jVipAkXfYsrcxTG/OseflbehMLtZZTob9F77+YUlhGJ9z8uZwonTmIngE8r+3S/hG9Rc
        4+Ed9Ah/hWxDhWYCGWvDIq203KS3qHUakeZiw39xsQECAO/erDOrrDrdIIfNvzA9afJS
        HX/KZzBqCZtAwI7Ibd9ykk8WZY159lYH6ishIRslX/TkrynW7hLgmWn+MgfVjql8QTcK
        wFxQ==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjG14FZxedJy6qgO1o3PMaViOoLMJVMh/kSA="
X-RZG-CLASS-ID: mo00
Received: from [192.168.50.177]
        by smtp.strato.de (RZmta 47.2.1 DYNA|AUTH)
        with ESMTPSA id D0b41cw9LHr2sHD
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
        Wed, 21 Oct 2020 19:53:02 +0200 (CEST)
Subject: Re: [net-rfc 04/16] can: dev: can_get_len(): add a helper function to
 get the correct length of Classical frames
To:     Vincent MAILHOL <mailhol.vincent@wanadoo.fr>,
        Marc Kleine-Budde <mkl@pengutronix.de>
Cc:     linux-can@vger.kernel.org, kernel@pengutronix.de,
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
 <2711ea6f-e1ce-c3f9-dd98-83142bd33fc9@hartkopp.net>
 <CAMZ6RqK2RCGLFmjiHTQAxZSGn-HQaAh_nHHGwKdODanZK5oJbg@mail.gmail.com>
From:   Oliver Hartkopp <socketcan@hartkopp.net>
Message-ID: <727e4845-63bd-659b-5344-97eb54121624@hartkopp.net>
Date:   Wed, 21 Oct 2020 19:52:55 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <CAMZ6RqK2RCGLFmjiHTQAxZSGn-HQaAh_nHHGwKdODanZK5oJbg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

On 21.10.20 13:55, Vincent MAILHOL wrote:
>> On 21.10.20 18:48, Oliver Hartkopp wrote:

>> To be more compatible to non raw dlc CAN frame sources the tx handling
>> could also be like this:
>>
>> if ((can_dlc == CAN_MAX_DLEN) &&
>>       (raw_dlc >= CAN_MAX_DLC && raw_dlc <= CAN_MAX_RAW_DLC))
>> => use raw_dlc
>>

(..)

> 
> If I understand well, the idea would be not to use a setsockopt() but
> instead rely on some logic on the can_dlc and raw_dlc to determine
> which one to use.
> 
> Unfortunately, this approach has one issue in the TX path that could
> break existing applications.
> 
> Consider below code (which I think is fairly realistic):
> 
> void send_frame (int soc, canid_t can_id, char *data, size_t len)
> {
>      struct can_frame cf;
>      size_t dlc = len > sizeof(cf.data) ? sizeof(cf.data) : len;
> 
>      cf.can_id = can_id;
>      cf.can_dlc = dlc;
>      memcpy(cf.data, data, dlc);
> 
>      write(soc, &cf, sizeof(cf));
> }
> 
> Here, the user did not initialize the can frame (cf) but assigned all
> the relevant fields manually. Because cf is not initialized, the newly
> introduced cf.dlc_raw field would have any of the values which was
> present on the stack at the moment (rationale: the C standard does not
> guarantee zero initialization). If 9 <= raw_dlc <= 15, the can frame
> will be transmitted with a bad DLC value. If raw_dlc > 15, the can
> frame will be discarded.

No, this is not what I wrote. With my suggestion you need to populate 
both dlc elements to use the new "raw dlc" feature.

if (can_dlc == 8) && (9 <= raw_dlc <= 15)
=> put raw_dlc value into the controller register
else
=> put can_dlc value into the controller register

When you have a test system to make security tests and you enable 
CAN_CTRLMODE_RAW_DLC on a specific CAN interface - which applications 
would you run to send CAN frames on this interface?

I assume only the test application which is really aware of setting 
can_dlc and raw_dlc correctly.

CAN_CTRLMODE_RAW_DLC is no 'standard' option. It's a testing facility 
and only used, when people want to play with raw DLCs.

An option could be to introduce a sockopt CAN_RAW_RAW_DLC that only 
forwards the raw_dlc element for classic CAN frames when enabled, and 
clears the raw_dlc field otherwise.

But again: Who ever enables CAN_CTRLMODE_RAW_DLC has a specific use-case 
in mind and knows what he's doing.

> I think that it is mandatory to have the application declare that it
> wants to use raw DLCs (this way, we know that the code is "DLC
> aware"). I can not think of any transparent approach.
> 
> Next, we might think of using the netlink CAN_CTRLMODE_RAW_DLC and
> the CAN_RAW_RAW_DLC socket option and the raw_dlc field. But I think
> that this is overkill.
> 
> If not introducing new dlc_raw field, the drawback, as you pointed
> out, will be that we would lose the backward compatibility of
> canfd_frame with can_frame and that can_dlc field can not be used
> directly as a length.
> 
> For userland, I think that this is acceptable because the very instant
> the user calls setsockopt() with the CAN_RAW_RAW_DLC, he should be
> aware of the consequences and should resign to use can_dlc field as a
> plain length.

Not filling can_dlc would cause tons of changes for sanity checks and 
feature switches.

Therefore everything should remain as-is and ONLY in the case of 
CAN_CTRLMODE_RAW_DLC and can_dlc == 8 the CAN driver validates the 
raw_dlc value element and uses it for transmission.

> That of course means that this should be clearly
> highlighted when updating the documentation. And users not interested
> by this feature can continue to use it as they did before.
> 
> Inside the kernel, all drivers advertising CAN_CTRLMODE_RAW_DLC will
> also resign the right to use can_dlc as plain length.

As explained before. This would cause effort without any need for the 
can_dlc handling.

> Drivers not
> using it are safe with their existing code. Finally, the TX and RX
> path would both need to be inspected in detail.

Yep.

> TLDR; socket options seem mandatory in all cases. We then have to
> choose between breaking the can_dlc plain length property or
> introducing a new raw_dlc field. My choice goes to the first option of
> breaking the can_dlc plain length property.

The 14 year old documentation in can.h says:
@can_dlc: frame payload length in byte (0 .. 8)

I will not break this established rule for a testing feature. The 
question from Joakim clearly showed: Don't touch this!

At the end it would have made more sense to call it can_frame.len in the 
first place. But this first came into our mind when CAN FD showed up. 
The discussion about the can_dlc meaning can be closed IMO. It is a 
plain length from 0..8 which is unfortunately named can_dlc.

Regards,
Oliver
