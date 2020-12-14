Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D7A202D95B9
	for <lists+linux-can@lfdr.de>; Mon, 14 Dec 2020 11:03:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388047AbgLNKBc (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Mon, 14 Dec 2020 05:01:32 -0500
Received: from mo4-p00-ob.smtp.rzone.de ([81.169.146.217]:9455 "EHLO
        mo4-p00-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2394736AbgLNJ7R (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Mon, 14 Dec 2020 04:59:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1607939720;
        s=strato-dkim-0002; d=hartkopp.net;
        h=In-Reply-To:Date:Message-ID:From:References:Cc:To:Subject:From:
        Subject:Sender;
        bh=HriK0u6nOVlczSQ2vggZU9rKodMlCn9dz0gWXJBLS68=;
        b=byQoZER4uuyvLSRfcHm3IkyxUDt47+8xbT8P7fcdR1c92Mq55lnmGvMwJPNlHLpuoS
        wVr94qFVdZ9xd9C2zXxAe9EB0L1KaZn3MFeS9qrJVuPRbj09Sj/EjdigdzF3rjrQg+lv
        b2MRx5P9PITnQ3HbfN2iV2UeYfAjL0IDQvikzSpjfXsDBdEqaOkZItjk7gt63PbacQ/D
        OBB8LhPO7PsIhN9t2YJhYiXuFoxSiTVyGrRXHV94rur1zUWm/VIBbol91SUroAF+FhB8
        2NzXx0GR5QclQ1SmmEmy+FU15UD2uY4Is5JgXAzs0618GWUT5fCx3oHq5qjVnKZQJy+i
        Z0tw==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjG14FZxedJy6qgO1o3TMaFqTEVR+J8xty10="
X-RZG-CLASS-ID: mo00
Received: from [192.168.10.137]
        by smtp.strato.de (RZmta 47.8.1 SBL|AUTH)
        with ESMTPSA id L093f2wBE9tK032
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
        Mon, 14 Dec 2020 10:55:20 +0100 (CET)
Subject: Re: [can-next-rfc 1/7] can: m_can: update link to M_CAN user manual
To:     Marc Kleine-Budde <mkl@pengutronix.de>, linux-can@vger.kernel.org
Cc:     kernel@pengutronix.de, Dan Murphy <dmurphy@ti.com>,
        Sean Nyekjaer <sean@geanix.com>,
        Sriram Dash <sriram.dash@samsung.com>
References: <20201212175518.139651-1-mkl@pengutronix.de>
 <20201212175518.139651-2-mkl@pengutronix.de>
 <3b1ef62e-f61a-7445-b890-e346781a64f9@hartkopp.net>
 <9eb66266-2211-4551-1c2b-b6493c6daac9@pengutronix.de>
From:   Oliver Hartkopp <socketcan@hartkopp.net>
Message-ID: <bdb574a8-d64b-c9fc-ee65-1187208929c2@hartkopp.net>
Date:   Mon, 14 Dec 2020 10:55:19 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.1
MIME-Version: 1.0
In-Reply-To: <9eb66266-2211-4551-1c2b-b6493c6daac9@pengutronix.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org



On 14.12.20 10:37, Marc Kleine-Budde wrote:
> On 12/14/20 10:31 AM, Oliver Hartkopp wrote:
>>
>>
>> On 12.12.20 18:55, Marc Kleine-Budde wrote:
>>> Old versions of the user manual are regularly depublished, so change link to
>>> point to the product page instead. This will be hopefully more stable.
>>>
>>> Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
>>> ---
>>>    drivers/net/can/m_can/m_can.c | 3 +--
>>>    1 file changed, 1 insertion(+), 2 deletions(-)
>>>
>>> diff --git a/drivers/net/can/m_can/m_can.c b/drivers/net/can/m_can/m_can.c
>>> index 06c136961c7c..8873f6f6f6da 100644
>>> --- a/drivers/net/can/m_can/m_can.c
>>> +++ b/drivers/net/can/m_can/m_can.c
>>> @@ -5,8 +5,7 @@
>>>    // Copyright (C) 2018-19 Texas Instruments Incorporated - http://www.ti.com/
>>>    
>>>    /* Bosch M_CAN user manual can be obtained from:
>>> - * http://www.bosch-semiconductors.de/media/pdf_1/ipmodules_1/m_can/
>>> - * mcan_users_manual_v302.pdf
>>> + * https://www.bosch-semiconductors.com/ip-modules/can-ip-modules/m-can/
>>>     */
>>
>> This URL update makes it just 'a little' better.
>>
>> Would it make sense to move
>>
>> https://github.com/hartkopp/M_CAN-User-Manual-History
>>
>> to
>>
>> https://github.com/linux-can/M_CAN-User-Manual-Archive
>>
>> and rework the README.md in a way that it's just an archive of already
>> published content?
> 
> make it so!

While watching the button to create a new repo I thought about a more 
generic name.

What about
https://github.com/linux-can/can-doc-archive
https://github.com/linux-can/can-doc
https://github.com/linux-can/can-drv-doc
... ?

where we can create a m_can directory (as named in the kernel).

Regards,
Oliver
