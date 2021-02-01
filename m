Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5BF2630ABBE
	for <lists+linux-can@lfdr.de>; Mon,  1 Feb 2021 16:43:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231805AbhBAPmk (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Mon, 1 Feb 2021 10:42:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230389AbhBAPmb (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Mon, 1 Feb 2021 10:42:31 -0500
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F05FFC061573
        for <linux-can@vger.kernel.org>; Mon,  1 Feb 2021 07:41:50 -0800 (PST)
Received: by mail-lf1-x12f.google.com with SMTP id e15so3191216lft.13
        for <linux-can@vger.kernel.org>; Mon, 01 Feb 2021 07:41:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kvaser.com; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=+m27dvOTaC3Ghqd3o5qud4xljWqVqRo10vopxx/VOQ8=;
        b=V62eFr930oqLQPKejMVNxIFL0wsTcYbcc+9VmMjBTMUsrTSQYiBcuUNVXpifWY0XKP
         7vSPucBRQdXiZA5toHmzv+wkyGV0XQOySC8hH86DUyrhNDM9w+avNH0+ucURO64kI/JP
         PItt0ZdUQndSh5e0BAKYig5MimnXdDh/fITg547HVV6I5yrVZhVauNhBExsFXVsIvHPw
         fWYuMFufmGJLMEQfYdFmNVky0voUowxLcTqhcXnS5fatS8c+E0uLxVSegisj0d6m/n/m
         b3uMpI4QLhWpKSeGeSIGBngjsn7ez7NaryGOgOpXOIH4LSI+A50qVEoWT2hKk+z/gfTN
         mEDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=+m27dvOTaC3Ghqd3o5qud4xljWqVqRo10vopxx/VOQ8=;
        b=CmTq5yvivVA8Eo5lYI/Gw1Sr8KgyRyzLyHCXBWvq6pozQ2wG3KXD9oszhfGaxfGy6w
         DeW3s7g687agPwmzYbJZkLtspimKpQCdMhCKMB+DXot7Tx3JcAhrHha9m3lNGUTL8qNL
         0uNFh8DrRTCiTFyw7OA4morV2l64/861SN4425WtbYfdJ5Qc2ppupvFtsblevsIhNqpm
         z3p7Ux4EAqlVav8KOFdkNQc+lBmXfPP95pWPDWwAIK+0zj28Tv2+ZDsuy1igWVaiZm2h
         dmL/j866WPDw1E7kJrbQKZyFdWsmKaLRE0X6E2y4cj7TvHM2w7uHy6JWUVGPv0XDvAVE
         cDpw==
X-Gm-Message-State: AOAM532u7S8nkolIkFgPVAU5f2PAmOoBbrIDLS2BZNWjZ+J7kAleeF1S
        kQPMeN7STwTIyqLSvlpC1q1Wog==
X-Google-Smtp-Source: ABdhPJx76ATigBE2G65nYV+zWae3ZEVOwYhZtQk1h7xAM2qsAbfXRIT0FW4DmkHHjCSnIONNJpsoRw==
X-Received: by 2002:a19:4c07:: with SMTP id z7mr8807326lfa.455.1612194109403;
        Mon, 01 Feb 2021 07:41:49 -0800 (PST)
Received: from [192.168.16.30] (h-4-68-234.A785.priv.bahnhof.se. [155.4.68.234])
        by smtp.gmail.com with ESMTPSA id c23sm2990815lfi.241.2021.02.01.07.41.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 01 Feb 2021 07:41:48 -0800 (PST)
Subject: Re: [Question] Sending CAN error frames
To:     Vincent MAILHOL <mailhol.vincent@wanadoo.fr>
Cc:     Jimmy Assarsson <jimmyassarsson@gmail.com>,
        Oliver Hartkopp <socketcan@hartkopp.net>,
        linux-can <linux-can@vger.kernel.org>,
        Marc Kleine-Budde <mkl@pengutronix.de>,
        Christer Beskow <chbe@kvaser.com>
References: <CAMZ6RqK0rTNg3u3mBpZOoY51jLZ-et-J01tY6-+mWsM4meVw-A@mail.gmail.com>
 <87e3dd54-50ab-1190-efdb-18ddb3b21a02@hartkopp.net>
 <42080d05-7ab3-99be-92e2-73ed262350ba@gmail.com>
 <CAMZ6RqJWrObGZRwyA1kD5cEZRUd_-4zt8rsMR+zZPLpxD6AWAQ@mail.gmail.com>
From:   Jimmy Assarsson <extja@kvaser.com>
Message-ID: <1debcaeb-71c7-6b78-88b3-7f121a33c1c1@kvaser.com>
Date:   Mon, 1 Feb 2021 16:41:47 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <CAMZ6RqJWrObGZRwyA1kD5cEZRUd_-4zt8rsMR+zZPLpxD6AWAQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

On 2021-02-01 15:19, Vincent MAILHOL wrote:
> Hi Jimmy,
> On Mon. 1 Feb 2021 at 05:42, Jimmy Assarsson <jimmyassarsson@gmail.com> wrote:
>> On 2021-01-31 13:59, Oliver Hartkopp wrote:
>>> Hi Vincent,
>>> On 31.01.21 07:22, Vincent MAILHOL wrote:
>>>> Hello,
>>>>
>>>> The socket CAN API handles the CAN errors (as reported by the
>>>> microcontroller) by emitting some RX CAN frames with the
>>>> CAN_ERR_FLAG set.
>>>
>>> Yes. This is the only intention.
>>>
>>>> My question concerns the transmission path: I would like to
>>>> understand how drivers should handle *TX* CAN frames which have
>>>> the CAN_ERR_FLAG set.
>>>>
>>>> The socket API allows sending such frames. For example doing:
>>>>       cansend can0 20000123#0011223344556677
>>>> will generate such frames and it will reach the xmit() function of
>>>> the driver.
>>>
>>> The reason to pass the frame as-is to the driver layer (including CAN_ERR_FLAG) is the possibility to test the correct behavior on the RX path, e.g. when you use the vcan driver.
>>>
>>> On the sending path the CAN_ERR_FLAG has no functionality so far - at least it was not defined by the community.
>>>
>>>> However, contrary to the other flags (EFF, RTR, FDF, BRS), the
>>>> ERR flag is not present on the data link layer. Instead, the data
>>>> link layer is responsible for detecting errors and signaling those
>>>> as soon as they occur (thus interrupting the transmission).
>>>>
>>>> While the ISO standard does not explicitly forbid having upper
>>>> layers generating such frames, it is not documented. Also, I am
>>>> not aware of CAN controllers allowing to generate error frames on
>>>> demand.
>>>
>>> There are specialized CAN testers, e.g. IIRC Vector CANstress that can generate error frames on specific conditions (e.g. when detecting a specific CAN ID).
>>>
>>> But I heave not seen CAN controllers that provide such functionality.
>>>
>>>> My initial expectation is that those error frames only make
>>>> sense in the RX path and that we should drop such TX frames in,
>>>> for example, can_dropped_invalid_skb().
>>>
>>> No. As written above the bit is defined to be valid in the RX path only and it makes sense for testing.
>>>
>>>> However, after looking at the code of other drivers, it appears
>>>> that one (and only one) of them: the Kvaser hydra, does actually
>>>> check this CAN_ERR_FLAG flag in the TX path:
>>>> https://elixir.bootlin.com/linux/v5.11-rc5/source/drivers/net/can/usb/kvaser_usb/kvaser_usb_hydra.c#L1421
>>>>
>>>> I would be thankful if anyone knowledgeable about the Kvaser hydra
>>>> could explain to me how the device handles those error frames.
>>>
>>> o_O - Yes, would be interested too!!
>>
>> Hi Vincent and Oliver,
>>
>> When the user passes a frame with CAN_ERR_FLAG set, the CAN controller will generate an error frame.
>> We got customers that use this for testing system robustness and fault reporting/handling.
> 
> Interesting.
> 
> There are two forms of error flags:
>    - The active error flag: 6 consecutive dominant bits
>    - The passive error flag: 6 consecutive recessive bits
> Can it generate both or only one of these? Is it generated as
> soon as the device receives the command or is it generated at a
> predefined timing (e.g. beginning of the frame)?

It can only generate the active error flag.
It will generate an error frame on the bus as soon as the bus is idle.

$ sudo ip link set can4 type can bitrate 100000
$ sudo ip link set can5 type can bitrate 100000
$ sudo ip link set can4 up
$ sudo ip link set can5 up
$ ./candump -c -ta -H -d -e -x can4,#FFFFFFFF &
[1] 177884
$ ./cansend can5 20000000#
  (0000000084.786201)  can4  RX - -  20000080   [8]  00 00 00 00 00 00 
00 01   ERRORFRAME
	bus-error
	error-counter-tx-rx{{0}{1}}
$ ./cansend can5 20000123#0011223344556677
  (0000000086.798898)  can4  RX - -  20000080   [8]  00 00 00 00 00 00 
00 02   ERRORFRAME
	bus-error
	error-counter-tx-rx{{0}{2}}
$ ./cansend can5 20000000#
  (0000000087.385292)  can4  RX - -  20000080   [8]  00 00 00 00 00 00 
00 03   ERRORFRAME
	bus-error
	error-counter-tx-rx{{0}{3}}
$ ./cansend can5 20000000#
  (0000000087.911860)  can4  RX - -  20000080   [8]  00 00 00 00 00 00 
00 04   ERRORFRAME
	bus-error
	error-counter-tx-rx{{0}{4}}
$ ./cansend can5 20000000#
  (0000000088.404890)  can4  RX - -  20000080   [8]  00 00 00 00 00 00 
00 05   ERRORFRAME
	bus-error
	error-counter-tx-rx{{0}{5}}
$ ./cansend can5 005#FF.12.20
  (0000000093.061655)  can4  RX - -  005   [3]  FF 12 20
$ ./cansend can5 005#FF.12.21
  (0000000094.667557)  can4  RX - -  005   [3]  FF 12 21
$ ./cansend can5 005#FF.12.22
  (0000000095.617019)  can4  RX - -  005   [3]  FF 12 22
$ ./cansend can5 20000000#
  (0000000097.883071)  can4  RX - -  20000080   [8]  00 00 00 00 00 00 
00 03   ERRORFRAME
	bus-error
	error-counter-tx-rx{{0}{3}}


> Which CAN microcontroller is used inside the device?

It is an IP developed by Kvaser called KCAN. I'm not sure, but I think
it has only been used in FPGAs.

> Also, could you point me to the Kvaser hydra product page? I
> couldn't find it with a quick search so I figured out that maybe
> the commercial name is different?

Hydra is the name of the platform for the USB based products.
You find all devices with this capability here:
https://www.kvaser.com/products-services/our-products/#/?descriptors=can_fd,err_frame_gen&pc_int=mini-pci-express,pci-express,usb
As mentioned before, the SocketCAN driver for the PCIe based devices
does not support this.

>> We also got this implemented in the early version of kvaser_pciefd driver, but dropped it:
>> https://marc.info/?l=linux-can&m=154324867704480&w=2
>> Is this something that we should remove from kvasr_usb aswell?
> 
> No. My intent is not to ask you to remove it. It is rather the
> opposite: I want to understand more how you are able to achieve
> what I thought not to be possible. For what you told me, the
> Kvaser hydra is the kind of device which I would like to have in
> my testing environment :)
> 
> However, it would make sense to normalize this use case in the
> Socket CAN interface. For the discussion with Oliver, it is clear
> that this use case is currently not expected and undefined, the
> reason being that such a CAN controller was not thought to
> exist. Now that you have proved us wrong, things are different.

Right, it would be nice to sort this out. I prefer to keep the
functionality, since we got customers using it.

Regards,
jimmy
