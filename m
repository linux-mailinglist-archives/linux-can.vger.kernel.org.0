Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F1268456B09
	for <lists+linux-can@lfdr.de>; Fri, 19 Nov 2021 08:43:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230477AbhKSHpu (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Fri, 19 Nov 2021 02:45:50 -0500
Received: from fllv0016.ext.ti.com ([198.47.19.142]:51548 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229974AbhKSHpu (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Fri, 19 Nov 2021 02:45:50 -0500
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 1AJ7gXvY026575;
        Fri, 19 Nov 2021 01:42:33 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1637307753;
        bh=aURgQjKNEA+cBJfEgNbo13xu2bl+tUi1w76bXP0DgFs=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=BDM5KBkjzRSem4B3RLN6dG0eUnofCtwkKfHKj+YtTifBzmSnoU9IeH5S36vDBSMzG
         7tZ972+zOSH4UWUv748WBYXl3T+4Hellk7pP20/lHUcbtGAxhFQkvwDEa6VoATNcrk
         EY4txWdVb9X9LGswmhXUPP+7NDjgnHTh0K+mIXvE=
Received: from DLEE101.ent.ti.com (dlee101.ent.ti.com [157.170.170.31])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 1AJ7gXS8127851
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 19 Nov 2021 01:42:33 -0600
Received: from DLEE102.ent.ti.com (157.170.170.32) by DLEE101.ent.ti.com
 (157.170.170.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14; Fri, 19
 Nov 2021 01:42:32 -0600
Received: from fllv0040.itg.ti.com (10.64.41.20) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14 via
 Frontend Transport; Fri, 19 Nov 2021 01:42:32 -0600
Received: from [10.250.232.185] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 1AJ7gSS2010913;
        Fri, 19 Nov 2021 01:42:29 -0600
Subject: Re: [PATCH RFC 2/2] phy: phy-can-transceiver: Add support for setting
 mux
To:     Peter Rosin <peda@axentia.se>,
        Marc Kleine-Budde <mkl@pengutronix.de>
CC:     Vignesh Raghavendra <vigneshr@ti.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Nishanth Menon <nm@ti.com>,
        Wolfgang Grandegger <wg@grandegger.com>,
        Vinod Koul <vkoul@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, <linux-can@vger.kernel.org>,
        <linux-phy@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <20211111164313.649-1-a-govindraju@ti.com>
 <20211111164313.649-3-a-govindraju@ti.com>
 <20211112084027.b2t2beqiiodnwjtv@pengutronix.de>
 <085ec3c0-75c6-f3c2-9999-348098fd88f9@ti.com>
 <f933048c-099f-054a-6563-671cf2a2e2af@axentia.se>
 <8be2b770-9c4c-ce41-4c49-27fa30b4afee@ti.com>
 <b8b0c7c4-3006-071b-d68f-8b18d24a1f72@axentia.se>
 <f47dc612-adea-4dfb-f2fd-d67b5df6ed50@ti.com>
 <3f13a769-f8ef-dbe8-f2c6-ff197af8eddf@axentia.se>
From:   Aswath Govindraju <a-govindraju@ti.com>
Message-ID: <c4efbcd3-8071-7fd2-0f3a-bc42acdfd2ac@ti.com>
Date:   Fri, 19 Nov 2021 13:12:28 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <3f13a769-f8ef-dbe8-f2c6-ff197af8eddf@axentia.se>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Hi Peter,

On 18/11/21 6:14 pm, Peter Rosin wrote:
>>> Ok, I see what you mean now, sorry for being dense. If we allow this then
>>> there is a need to add a special value that means all/many states (such as
>>> -1 or something such) so that a mux-control can be used simultaneously by
>>> drivers "pointing at" a specific state like you want to do, and by the
>>> existing "application" style drivers that wraps the whole mux control.
>>>
>>> I.e. something like this
>>>
>>> 	mux: mux {
>>> 		compatible = "mux-gpio";
>>> 		...
>>>
>>> 		#mux-control-cells = <1>; /* one more than previously */
>>> 	};
>>>
>>> 	phy {
>>> 		...
>>>
>>> 		mux-control = <&mux 3>; /* point to specific state */
>>> 	};
>>>
>>> 	i2c-mux {
>>> 		compatible = "i2c-mux-gpmux";
>>> 		parent = <&i2c0>
>>> 		mux-control = <&mux (-1)>; /* many states needed */
>>>
>>> 		...
>>>
>>> 		i2c@1 {
>>> 			eeprom@50 {
>>> 				...
>>> 			};
>>> 		};
>>>
>>> 		i2c@2 {
>>> 			...
>>> 		};
>>> 	};
>>>
>>> Yes, I realize that accesses to the eeprom cannot happen if the mux is
>>> constantly selected and locked in state 3 by the phy, and that a mux with
>>> one channel being a phy and other channels being I2C might not be
>>> realistic, but the same gpio lines might control several muxes that are
>>> used for separate signals solving at least the latter "problem" with this
>>> completely made up example. Anyway, the above is in principle, and HW
>>> designs are sometimes too weird for words.
>>>
>>
>> This is almost exactly what I was intending to implement except for one
>> more change. The state of the mux will always be represented using the
>> second argument(i.e. #mux-control-cells = <2>).
>>
>> For example,
>> mux-controls = <&mux 0 1>, <&mux 1 0>;
>>
>>
>> With this I think we wouldn't need a special value for all or many states.
> 
> But you do. Several consumers need to be able to point to the same mux
> control. If some of these consumers need one state, and some other need
> all/many, the consumers needing many needs to be able to say that. Listing
> many entries in mux-control = <>; is misleading since then the binding implies
> that you could have different mux controls for each state, which is not
> possible, at least not in the current implementations. It would also be
> wasteful to needlessly establish links to the same mux control multiple
> times, and the binding would cause bloated device trees even if you tried
> to optimize this in the drivers. Therefore, I require a special value so
> that consumers can continue to point at the mux control as a whole, even
> if some other consumers of the same mux control wants to point at a specific
> state.
> 


Understood. One issue that I see is that we certainly can not use the
first argument for representing state as it will result in errors for
current users.

I feel that the safest way to go would be by using a second argument to
represent the state or to represent multiple states can be used by the
driver. The issue that I see with this approach is that currently the
fist argument is used to select the line number from the mux and if the
we use two arguments like this,

mux-controls = <&mux 0 -1>

then this would mean that line nnumber 0 in the mux could use multiple
states and for a driver to use mutiple lines we would need to add an
entry for each line which would bloat the code a well increase the
complexity in the drivers while using devm_mux_get(). So, one solution
that I could think of is to use a "-1" for the first argument too. This
would indicate that the driver would need to toggle multiple lines in
the mux

For example,

1) mux-controls = <&mux -1 3> // the driver would need to set the mux
lines to 3 for enabling it

2) mux-controls = <&mux -1 -1> //the driver would need to set the mux
lines and multiple states in the mux

3) mux-controls = <&mux 0 1> // the driver would need to set the zeroth
mux line to 1

I do see that, going with this method would make <&mux ^\d*$ ^\d*$>(i.e.
any positive number in the first argument) redundant as it can be
represented with <&mux -1 *>. However, I think is the only way so that
existing users will not see issues.


>>>> One more question that I had is, if the number of arguments match the
>>>> #mux-control-cells and if the number of arguments are greater than 1 why
>>>> is an error being returned?
>>>
>>> Changing that would require a bindings update anyway, so I simply
>>> disallowed it as an error. Not much thought went into the decision,
>>> as it couldn't be wrong to do what is being done with the bindings
>>> that exist. That said, I have no problem lifting this restriction,
>>> if there's a matching bindings update that makes it all fit.
>>>
>>
>> Sure, I think making a change in
>>
>> Documentation/devicetree/bindings/mux/gpio-mux.yaml, should be good
>> enough I assume.
> 
> Well, the new way to bind has very little to do with this being a gpio
> mux. There is no reason not to allow this way to bind for any of the
> other muxes. That said, the reg-mux binding has this:
> 
>   '#mux-control-cells':
>     const: 1
> 
> Similarly, the adi,adg792a has explicit wording on how #mux-control-cells
> works (but being a txt binding it is not checked, but that does not matter,
> bindings should be correct). I now notice that this is missing from the
> adi,adgs1408 binding, but that's an oversight.
> 
> The mux-controller binding has this:
>   '#mux-control-cells':
>     enum: [ 0, 1 ]
> 
> The mux-consumer binding should probably be updated with some words
> on this subject too.
> 
> So, all mux bindings need updates when this door is opened. And, in order
> to add this in a compatible way, the old way to bind with 0/1 cells needs
> to continue to both work and be allowed.
> 
> I think it is easiest to add something common to the mux-controller
> binding and then have the specific bindings simply inherit it from there
> instead of adding (almost) the same words to all the driver bindings.
> 

Understood, I will try to add changes in the common mux-controller
bindings itself and then reference it in the gpio-mux bindings

Thanks,
Aswath

> Cheers,
> Peter
> 
>> Thank you for the comments. I'll post a respin of this series, with the
>> above changes.

