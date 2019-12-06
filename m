Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AD393115157
	for <lists+linux-can@lfdr.de>; Fri,  6 Dec 2019 14:49:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726366AbfLFNtz (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Fri, 6 Dec 2019 08:49:55 -0500
Received: from first.geanix.com ([116.203.34.67]:36354 "EHLO first.geanix.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726284AbfLFNtz (ORCPT <rfc822;linux-can@vger.kernel.org>);
        Fri, 6 Dec 2019 08:49:55 -0500
Received: from [192.168.100.95] (unknown [95.138.208.137])
        by first.geanix.com (Postfix) with ESMTPSA id D20B23BF;
        Fri,  6 Dec 2019 13:49:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=geanix.com; s=first;
        t=1575640187; bh=SL0f1EfmZIUpsEaw4T2Bwmfal12c5jyQZVybKsFjToI=;
        h=Subject:From:To:Cc:References:Date:In-Reply-To;
        b=M4wOasyMtuLNdFg1ySNQcC5m6HqrJyzKre0K7gJ+DEJRV69beeEQ1OFPPPGcAwooR
         XbMGPJWAYMzU1ST12VFfVDjX0XP3rjcQGxkQuA+sQLZpPdHAvvm1/PM5VVTbaIWsT4
         4R3TiMiyryayUo6nO5WDwjiAXxJeeGBRSka/fzX89SmX0iOYFKij1vjNaelsdypjKm
         +cknG5FLQB8JAGwhF/lZHVJQ06ApKur5ZvUX9auFL8FUj7BqX/ycpWggRCjxbP18Gf
         zPqdWZA/3cHAssw20njZ3bZEdoT0Z1GDtD1LhuCnkjEy55FmVni++yMCn2FQVBrckJ
         6GvL/Z5/BNkkA==
Subject: Re: [PATCH 1/2] dt-bindings: tcan4x5x: Make wake-gpio an optional
 gpio
From:   Sean Nyekjaer <sean@geanix.com>
To:     Dan Murphy <dmurphy@ti.com>, mkl@pengutronix.de
Cc:     linux-can@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, Rob Herring <robh@kernel.org>
References: <20191204175112.7308-1-dmurphy@ti.com>
 <d34673db-cc43-6e1d-6f4a-07b25c2c8f7b@geanix.com>
Message-ID: <bd4586d0-4ea7-e247-d72d-a759c99860b0@geanix.com>
Date:   Fri, 6 Dec 2019 14:49:52 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.0
MIME-Version: 1.0
In-Reply-To: <d34673db-cc43-6e1d-6f4a-07b25c2c8f7b@geanix.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US-large
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.1 required=4.0 tests=ALL_TRUSTED,BAYES_00,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,URIBL_BLOCKED
        autolearn=disabled version=3.4.2
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on 8b5b6f358cc9
Sender: linux-can-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org



On 05/12/2019 08.36, Sean Nyekjaer wrote:
> 
> 
> On 04/12/2019 18.51, Dan Murphy wrote:
>> The wake-up of the device can be configured as an optional
>> feature of the device.  Move the wake-up gpio from a requried
>> property to an optional property.
>>
>> Signed-off-by: Dan Murphy <dmurphy@ti.com>
>> CC: Rob Herring <robh@kernel.org>
> Reviewed-by: Sean Nyekjaer <sean@geanix.com>
Tested-by: Sean Nyekjaer <sean@geanix.com>
>> ---
>>   Documentation/devicetree/bindings/net/can/tcan4x5x.txt | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/Documentation/devicetree/bindings/net/can/tcan4x5x.txt 
>> b/Documentation/devicetree/bindings/net/can/tcan4x5x.txt
>> index 27e1b4cebfbd..7cf5ef7acba4 100644
>> --- a/Documentation/devicetree/bindings/net/can/tcan4x5x.txt
>> +++ b/Documentation/devicetree/bindings/net/can/tcan4x5x.txt
>> @@ -10,7 +10,6 @@ Required properties:
>>       - #size-cells: 0
>>       - spi-max-frequency: Maximum frequency of the SPI bus the chip can
>>                    operate at should be less than or equal to 18 MHz.
>> -    - device-wake-gpios: Wake up GPIO to wake up the TCAN device.
>>       - interrupt-parent: the phandle to the interrupt controller 
>> which provides
>>                       the interrupt.
>>       - interrupts: interrupt specification for data-ready.
>> @@ -23,6 +22,7 @@ Optional properties:
>>                  reset.
>>       - device-state-gpios: Input GPIO that indicates if the device is in
>>                     a sleep state or if the device is active.
>> +    - device-wake-gpios: Wake up GPIO to wake up the TCAN device.
>>   Example:
>>   tcan4x5x: tcan4x5x@0 {
>>
