Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4BD3710A000
	for <lists+linux-can@lfdr.de>; Tue, 26 Nov 2019 15:13:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727637AbfKZONM (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Tue, 26 Nov 2019 09:13:12 -0500
Received: from first.geanix.com ([116.203.34.67]:50400 "EHLO first.geanix.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726536AbfKZONM (ORCPT <rfc822;linux-can@vger.kernel.org>);
        Tue, 26 Nov 2019 09:13:12 -0500
Received: from [192.168.100.95] (unknown [95.138.208.137])
        by first.geanix.com (Postfix) with ESMTPSA id 4B11C937EF;
        Tue, 26 Nov 2019 14:09:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=geanix.com; s=first;
        t=1574777370; bh=uZe6yZWuUo85RxT85zDL2dLHwKv85LIlHvT3HqOPIHI=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To;
        b=OLr4l6YDOcko6bjp5ybq/LDsw1QFZTRqS5S6HH7Hx7WWOW6LZhEDMdZCcntoVzB2l
         W9etVcWCrNTZOTN6c2iL02Y7cGkUFbw90XjCjuPYC66HfSqeFSw4fIjw4s1w9UYkaQ
         m5/9tx3p0xzRpkPgC/GWKnzMbWtez63FpJMmsz5QEEod8oLT+ZzIviOsbYK1+kiFvU
         4uGhWGam/ZUiDMLGKYaTBqZXNVsJ6xLGjoO7W4ojVb5oL340gz70A7A0HJ9ei+MgkL
         DFMPAB2Z3hsLvl+vUIZ1KgF8tEDCSEQoXKm7u3+aTDms5NTKjwjAp6USY/8AQXWFLl
         QTndxVijwnqcw==
Subject: Re: Devicetree for can tcan4x5x
To:     Dan Murphy <dmurphy@ti.com>, Marc Kleine-Budde <mkl@pengutronix.de>
Cc:     "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>
References: <e5892c08-03a5-60a6-61e0-6b75e248e172@geanix.com>
 <eb7aaa46-3cc8-4ed3-adcf-aaa95c8dd197@ti.com>
From:   Sean Nyekjaer <sean@geanix.com>
Message-ID: <80e8f758-e240-f1b4-f0e2-3a53b2f22b99@geanix.com>
Date:   Tue, 26 Nov 2019 15:12:32 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <eb7aaa46-3cc8-4ed3-adcf-aaa95c8dd197@ti.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US-large
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.1 required=4.0 tests=ALL_TRUSTED,BAYES_00,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,URIBL_BLOCKED
        autolearn=disabled version=3.4.2
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on b0d531b295e6
Sender: linux-can-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org



On 26/11/2019 15.07, Dan Murphy wrote:
> Sean
> 
> On 11/25/19 7:21 AM, Sean Nyekjaer wrote:
>> Hi Dan and Marc,
>>
>> I'm testing a mockup with the iMX6ull and TCAN4x5x for CANFD 
>> functionality.
>>
>> In our devicetree I'm having this entry:
>> &ecspi1 {
>>
>>         cs-gpios = <&gpio4 26 0>;
>>
>>         pinctrl-names = "default";
>>
>>         pinctrl-0 = <&pinctrl_spi1>;
>>
>>
>>
>>         tcan4x5x: tcan4x5x@0 {
>>
>>                 compatible = "ti,tcan4x5x";
>>
>>                 reg = <0>;
>>
>>                 #address-cells = <1>;
>>
>>                 #size-cells = <1>;
>>
>>                 spi-max-frequency = <10000000>;
>>
>>                 bosch,mram-cfg = <0x0 0 0 32 0 0 1 1>;
>>
>>                 interrupt-parent = <&gpio1>;
>>
>>                 interrupts = <23 GPIO_ACTIVE_LOW>;
>>
>>                 reset-gpios = <&gpio1 22 GPIO_ACTIVE_LOW>;
>>
>>         };
>>
>> };
>>
>> But it's not probing.
>> The Documnetation [0] states I need some m_can entry, when looking in 
>> [1] i looks like I'm creating a m_can device on the address/data bus.
>>
>> Do we have an m_can example for the tcan device?
> 
> Is the driver enabled in your .config?
> 
> Are the m_can drivers enabled?
> 
> Dan
> 

Hi Dan,

Thanks for the reply :)
I have the driver loading now, just with the SPI entry.

Our HW guys have hardwired the WAKE pin to GND, I'm guessing that's a 
perfectly valid scenario.
I have a small patch that makes the WAKE pin optional.

/Sean



