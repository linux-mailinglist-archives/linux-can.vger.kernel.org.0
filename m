Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C706A11E965
	for <lists+linux-can@lfdr.de>; Fri, 13 Dec 2019 18:47:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728203AbfLMRqj (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Fri, 13 Dec 2019 12:46:39 -0500
Received: from lelija.serveriai.lt ([194.135.87.135]:55932 "EHLO
        lelija.serveriai.lt" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726404AbfLMRqj (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Fri, 13 Dec 2019 12:46:39 -0500
X-Greylist: delayed 1583 seconds by postgrey-1.27 at vger.kernel.org; Fri, 13 Dec 2019 12:46:38 EST
Received: from [78.61.95.68] (helo=[192.168.88.188])
        by lelija.serveriai.lt with esmtpsa (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
        (Exim 4.92.3)
        (envelope-from <gediminas@rusoku.com>)
        id 1ifobt-0002Mz-Eb; Fri, 13 Dec 2019 19:20:13 +0200
Subject: Re: usb_8dev - WARN_ON(in_irq())
To:     Michal Sojka <michal.sojka@cvut.cz>,
        Oliver Hartkopp <socketcan@hartkopp.net>,
        linux-can@vger.kernel.org
Cc:     Bernd Krumboeck <b.krumboeck@gmail.com>,
        Marc Kleine-Budde <mkl@pengutronix.de>
References: <87h8245gyv.fsf@steelpick.2x.cz>
From:   Gediminas Simanskis <gediminas@rusoku.com>
Message-ID: <7429cd37-f4dd-247c-7fa3-259801f20944@rusoku.com>
Date:   Fri, 13 Dec 2019 19:20:08 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.1
MIME-Version: 1.0
In-Reply-To: <87h8245gyv.fsf@steelpick.2x.cz>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-GB
X-Sender: gediminas@rusoku.com
Sender: linux-can-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Seems like to USB2CAN buffer overflow and firmware crashing.

Gediminas

On 2019-12-13 18:27, Michal Sojka wrote:
> On Fri, Dec 13 2019, Michal Sojka wrote:
>> Hi Oliver,
>>
>> On Fri, Dec 13 2019, Oliver Hartkopp wrote:
>>> Did you do anything weird (e.g. pulling the USB plug on the run) to get
>>> this problem?
>> No, I just connected it to an ECU and started sending messages on the
>> bus. The behaviour was like if the messages were not acknowledged, i.e.,
>> initially, candump on my laptop showed the messages sent, but after some
>> time (perhaps after TX buffers were full), candump stopped. I was also
>> not able to see any messages sent by the ECU (both before and after I
>> sent my messages).
>>
>> When I used the same ECU and all the wiring with peak_usb, communication
>> with the ECU was without any problems.
> I did more investigation - I was able to fix the problem by adding a
> terminator resistor to the bus.
>
> However, the problem can be easily reproduced by the following sequence
> of commands, when the USB2CAN is not connected to any bus:
>
>      ip link set can0 up txqueuelen 1000 type can bitrate 500000
>      candump can0
>      cangen -v -g 50 can0
>
> when candump stops printing the messages, run:
>
>      ip link set down dev can0
>
> and the warnings appear in dmesg. I was also trying this with latest
> mainline kernel, which includes the fix for use-after-free, and the
> warnings are still there.
>
> -Michal
