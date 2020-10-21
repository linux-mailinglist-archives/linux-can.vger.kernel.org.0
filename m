Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AE402294C04
	for <lists+linux-can@lfdr.de>; Wed, 21 Oct 2020 13:55:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406907AbgJULzm (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Wed, 21 Oct 2020 07:55:42 -0400
Received: from mail-yb1-f196.google.com ([209.85.219.196]:38491 "EHLO
        mail-yb1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2410977AbgJULzg (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Wed, 21 Oct 2020 07:55:36 -0400
Received: by mail-yb1-f196.google.com with SMTP id b138so1531974yba.5
        for <linux-can@vger.kernel.org>; Wed, 21 Oct 2020 04:55:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/R2sfda93RiAhXjR4q6oMav9lNVgfEOrUpIOjkWDHwk=;
        b=C/l3XqBRh9wM4tkITrp6jipydeTTcC5sSFXU8ibRKsH2KgNdjCbrVoF7+oIzh+CFuS
         d89zPTE0xH4rMXsarqGOWxEJQ1pdqTq3G5YFtaS6kiMs/KVgzKlO89Ph8ZTI3NK7aRzG
         FJWkicTDxKywZhwIELXQ4Ca9fHD9BXbUTp/VmKETaJUkF1iVklL4xnEO8oXhCp0HsFbS
         4K9BzzKfLZZIU9o65ZaILeC925EqR9cePCoK2u88Q+7DXIDNc8RYqE+8V54a1ysa6FFc
         YajzJAEmG9+ccBx6cUO0IynRvhPrIq3GcrgNubo6M5GVG9QSpyL/XkJpHO5t8V1Ord6O
         3EDw==
X-Gm-Message-State: AOAM532TSnqC5zYgIEkjsx90+3zsM3pMKkSwyB8dNfvVZ6cAM+m1szyd
        H7BulZ2iHgSa0kXB7AaWJObxlV9ubPcvX0tbIO5438zspQsxnQ==
X-Google-Smtp-Source: ABdhPJw8dqujmIE3LPZ+FecEi7OD2Fep6BxdymUm7JSYVc+kznVg526c0YbAjNy8pQMXgFow0fekq5+23VkTBT++Wf4=
X-Received: by 2002:a25:d345:: with SMTP id e66mr4432592ybf.307.1603281333569;
 Wed, 21 Oct 2020 04:55:33 -0700 (PDT)
MIME-Version: 1.0
References: <20201019190524.1285319-1-mkl@pengutronix.de> <20201019190524.1285319-5-mkl@pengutronix.de>
 <fbbe1b80-c012-dc87-1eb0-4878cd08cce1@hartkopp.net> <ebf50f35-f093-b2c9-a27c-cef73d403efb@pengutronix.de>
 <20201020113023.102360-1-mailhol.vincent@wanadoo.fr> <6f869e47-9a76-3398-0b64-2d573d412f4c@hartkopp.net>
 <20201020160739.104686-1-mailhol.vincent@wanadoo.fr> <a9605011-2674-dc73-111c-8ebf724a13ac@hartkopp.net>
 <20201021005226.2727-1-mailhol.vincent@wanadoo.fr> <CAMZ6RqKFST4dcWZP_8NdDMB6GT09vhVWgN+nuMWkVovkh-EZdw@mail.gmail.com>
 <2711ea6f-e1ce-c3f9-dd98-83142bd33fc9@hartkopp.net>
In-Reply-To: <2711ea6f-e1ce-c3f9-dd98-83142bd33fc9@hartkopp.net>
From:   Vincent MAILHOL <mailhol.vincent@wanadoo.fr>
Date:   Wed, 21 Oct 2020 20:55:20 +0900
Message-ID: <CAMZ6RqK2RCGLFmjiHTQAxZSGn-HQaAh_nHHGwKdODanZK5oJbg@mail.gmail.com>
Subject: Re: [net-rfc 04/16] can: dev: can_get_len(): add a helper function to
 get the correct length of Classical frames
To:     Oliver Hartkopp <socketcan@hartkopp.net>,
        Marc Kleine-Budde <mkl@pengutronix.de>
Cc:     linux-can@vger.kernel.org, kernel@pengutronix.de,
        =?UTF-8?Q?St=C3=A9phane_Grosjean?= <s.grosjean@peak-system.com>,
        Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

> On 21.10.20 18:48, Oliver Hartkopp wrote:
>> On 21.10.20 08:23, Vincent MAILHOL wrote:
>>>>>  From a first thought I would see a new flag CAN_CTRLMODE_RAW_DLC in the
>>>>> netlink interface of IFLA_CAN_CTRLMODE for the CAN controller driver.
>>>>>
>>>>> This could switch the sanitizing AND the CAN controller can properly
>>>>> expose its ability to support this mode.
>>>>
>>>> Absolutely yes. In my first message, I mentioned the idea of managing
>>>> that through socket option, glad that we now share the same idea.
>>>
>>> Actually, I just realized that I replied to you too quickly. I was not
>>> exactly thinking of the same thing here so let me correct what I
>>> previously said.
>>>
>>> IFLA_CAN_CTRLMODE is at the netlink level. My idea is to have it, in
>>> addition, at the socket level. Example: add CAN_RAW_RAW_DLC in
>>> include/uapi/linux/can/raw.h.
>>
>> Yes. We need at least some different handling inside the driver level
>> which could be switched with CAN_CTRLMODE_RAW_DLC.
>>
>>> The reason is that if we only manage it at the netlink level, some
>>> application not aware of the RAW_DLC issue might run into some buffer
>>> overflow issue. Unless an application directly requests it, the current
>>> behaviour should be maintained (rationale: do not break userland).
>>>
>>> So the full picture will be to have both the CAN_CTRLMODE_RAW_DLC at
>>> netlink level and CAN_RAW_RAW_DLC at the socket level (in the exact same
>>> way we have both CAN_CTRLMODE_FD and CAN_RAW_FD_FRAMES for
>>> CAN-FD).
>>
>> Yes. That hits the point.
>>
>> Btw. the impact on all protocols seems to be pretty heavy and to me it
>> turned out that it would be a bad idea to use can_frame.can_dlc as
>> transport vehicle for the raw dlc. Especially as this will contradict
>> the rule that the can_dlc element is a plain length information today as
>> canfd_frame.len and shares the same position in the struct.
>>
>> I currently tend to only have a switch on driver level with
>> CAN_CTRLMODE_RAW_DLC and make use of can_frame._res0 -> can_frame.raw_dlc
>>
>> With CAN_CTRLMODE_RAW_DLC enabled the CAN driver would ...
>>
>> - fill can_dlc and raw_dlc at reception time
>> - will use raw_dlc instead of can_dlc at tx time
>> - will use can_dlc if raw_dlc == 0 at tx time
>
> To be more compatible to non raw dlc CAN frame sources the tx handling
> could also be like this:
>
> if ((can_dlc == CAN_MAX_DLEN) &&
>      (raw_dlc >= CAN_MAX_DLC && raw_dlc <= CAN_MAX_RAW_DLC))
> => use raw_dlc
>
>>
>> This would have a minimal impact on the code and we only need to make
>> sure that the raw_dlc is not killed at some stage in the network layer.
>>
>> #define CAN_MAX_RAW_DLC 15
>>
>> IMO the raw dlc use-case is a really special case for testing purposes.
>> Touching the current can_frame.can_dlc handling could lead to more
>> complexity and the fear to run into overflows as already stated by Joakim.
>>
>> What do you think about the above approach?

If I understand well, the idea would be not to use a setsockopt() but
instead rely on some logic on the can_dlc and raw_dlc to determine
which one to use.

Unfortunately, this approach has one issue in the TX path that could
break existing applications.

Consider below code (which I think is fairly realistic):

void send_frame (int soc, canid_t can_id, char *data, size_t len)
{
    struct can_frame cf;
    size_t dlc = len > sizeof(cf.data) ? sizeof(cf.data) : len;

    cf.can_id = can_id;
    cf.can_dlc = dlc;
    memcpy(cf.data, data, dlc);

    write(soc, &cf, sizeof(cf));
}

Here, the user did not initialize the can frame (cf) but assigned all
the relevant fields manually. Because cf is not initialized, the newly
introduced cf.dlc_raw field would have any of the values which was
present on the stack at the moment (rationale: the C standard does not
guarantee zero initialization). If 9 <= raw_dlc <= 15, the can frame
will be transmitted with a bad DLC value. If raw_dlc > 15, the can
frame will be discarded.

I think that it is mandatory to have the application declare that it
wants to use raw DLCs (this way, we know that the code is "DLC
aware"). I can not think of any transparent approach.

Next, we might think of using the netlink CAN_CTRLMODE_RAW_DLC and
the CAN_RAW_RAW_DLC socket option and the raw_dlc field. But I think
that this is overkill.

If not introducing new dlc_raw field, the drawback, as you pointed
out, will be that we would lose the backward compatibility of
canfd_frame with can_frame and that can_dlc field can not be used
directly as a length.

For userland, I think that this is acceptable because the very instant
the user calls setsockopt() with the CAN_RAW_RAW_DLC, he should be
aware of the consequences and should resign to use can_dlc field as a
plain length. That of course means that this should be clearly
highlighted when updating the documentation. And users not interested
by this feature can continue to use it as they did before.

Inside the kernel, all drivers advertising CAN_CTRLMODE_RAW_DLC will
also resign the right to use can_dlc as plain length. Drivers not
using it are safe with their existing code. Finally, the TX and RX
path would both need to be inspected in detail.

TLDR; socket options seem mandatory in all cases. We then have to
choose between breaking the can_dlc plain length property or
introducing a new raw_dlc field. My choice goes to the first option of
breaking the can_dlc plain length property.

That said, I am curious about what other people think.
