Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B42C33B4E76
	for <lists+linux-can@lfdr.de>; Sat, 26 Jun 2021 14:19:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229850AbhFZMVj (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Sat, 26 Jun 2021 08:21:39 -0400
Received: from mail.kernel-space.org ([195.201.34.187]:60372 "EHLO
        mail.kernel-space.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229518AbhFZMVi (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Sat, 26 Jun 2021 08:21:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel-space.org;
        s=20190913; t=1624709953;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=yE2t7aTLXnsIGk9NsRTTnIh6+5LIIl0v6R6s6pcp9W8=;
        b=WCSQMDx38NWXj/DClaJFiEjLRxdGN9o8o5ZuR5NEdhrehvslsoqovJIW87XfY5H6rACluR
        Y3A1kMAxdRPoc5X6NdQPbnScqypo2jlY7k1yWlUTFBC8GtpXzchQatnkcFwbY3x9CuX5BP
        xE4LNVi3qTVeBgRTrQMX2yhrSDKTm+4=
Received: from [192.168.0.2] (host-87-8-57-171.retail.telecomitalia.it [87.8.57.171])
        by ziongate (OpenSMTPD) with ESMTPSA id 47016f6f (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Sat, 26 Jun 2021 12:19:13 +0000 (UTC)
Subject: Re: [PATCH v3 4/5] can: flexcan: update Kconfig to allow non-of cases
To:     Marc Kleine-Budde <mkl@pengutronix.de>,
        Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Greg Ungerer <gerg@linux-m68k.org>,
        Wolfgang Grandegger <wg@grandegger.com>,
        Linux/m68k <linux-m68k@vger.kernel.org>,
        linux-can@vger.kernel.org, Joakim Zhang <qiangqing.zhang@nxp.com>
References: <20210621184615.3345846-1-angelo@kernel-space.org>
 <20210621184615.3345846-4-angelo@kernel-space.org>
 <CAMuHMdV8a=YKowGLY3kGqwsfAPd3VPEXS8x7xqYaUz9ZBh64hg@mail.gmail.com>
 <20210621201816.pk6n4xa7j4bi6vfk@pengutronix.de>
 <CAMuHMdUHQyPB8G5QX-oK7+MDvkLihR6QCoD+9_3pQKQZWu7TGw@mail.gmail.com>
 <20210621204127.xwrk2tlxggct7kst@pengutronix.de>
 <CAMuHMdUrFa6r2VQdNTgr8mV_wGoOb4VhK0Y5_XQQ1Xzgc93NMw@mail.gmail.com>
 <20210622065427.z5dnixenf47zag4g@pengutronix.de>
From:   Angelo Dureghello <angelo@kernel-space.org>
Message-ID: <9d724149-3c30-adca-1ecc-96d204699c03@kernel-space.org>
Date:   Sat, 26 Jun 2021 14:18:07 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <20210622065427.z5dnixenf47zag4g@pengutronix.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Hi Marc, Geert,

thanks, fixed all, but i am still fighting on an
occasional strange heisenbug.

After several hours of "candump can0" on coldfire and
"cangen can0" from PC (peak_usb) at 1Mbit/s, coldfire
side suddenly produces a 129 RX errors from one packet
to another 0 -> 129.
In this condition, after reset and reboot, issue seems
to persist, at the first received packet coldfire
produces no ack, i still get 129 rx errors:

[   18.090000] flexcan flexcan-mcf5441x.0 can0: flexcan_chip_start: 
reading mcr=0x60a3020f ctrl=0x052d2056
[   18.090000] flexcan_irq() ecr=0x00008100 esr=0x0001c912
[   18.090000] flexcan flexcan-mcf5441x.0 can0: Controller changed from 
Error Active State (0) into Error Passive State (2).

Issue seems to disappear again after resoldering the
can transceiver (SN65HVD230).

So it seems some issue with my hw, investigating on
this before v4, need to be fully sure it's not a
driver issue. By oscilloscope, differential signal and
rx signal seems perfect, no rings. Also baudrate seems
nearly perfect.


On 22/06/21 8:54 AM, Marc Kleine-Budde wrote:
> On 22.06.2021 08:52:05, Geert Uytterhoeven wrote:
>>> Probably. What about the original proposed change: "(OF || M5441x) && HAS_IOMEM"?
>>
>> Yeah, the Flexcan might pop up on RISC-V, too.
>> But any new platforms should use OF.
>> Given the Flexcan is probably present on more than just M5441x,
>> I'd go for:
>>
>>      depends on OF || COLDFIRE || COMPILE_TEST
>>      depends on HAS_IOMEM
> 
> Looks good to me!
> 
>>>>> So I think there won't be too many configs where the oldconfig question
>>>>> would pop up.
>>>>
>>>> Now it will, as Mr. Torvalds' main machine does not satisfy "ARM || PPC"
>>>> or "OF && HAS_IOMEM", but does "HAS_IOMEM" ;-)
>>>
>>> IC, that would be one question too much :)
>>
>> I do doubt he has CONFIG_CAN enabled ;-)
> 
> :D
> 
> regards,
> Marc
> 

Regards,
angelo
