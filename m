Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E8078151E41
	for <lists+linux-can@lfdr.de>; Tue,  4 Feb 2020 17:25:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727347AbgBDQZl (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Tue, 4 Feb 2020 11:25:41 -0500
Received: from metis.ext.pengutronix.de ([85.220.165.71]:50255 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727310AbgBDQZl (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 4 Feb 2020 11:25:41 -0500
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=[IPv6:::1])
        by metis.ext.pengutronix.de with esmtp (Exim 4.92)
        (envelope-from <a.fatoum@pengutronix.de>)
        id 1iz11A-0000TR-6w; Tue, 04 Feb 2020 17:25:40 +0100
Subject: Re: [BUG] pfifo_fast may cause out-of-order CAN frame transmission
From:   Ahmad Fatoum <a.fatoum@pengutronix.de>
To:     Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
        linux-can@vger.kernel.org,
        Pengutronix Kernel Team <kernel@pengutronix.de>
References: <661cc33a-5f65-2769-cc1a-65791cb4b131@pengutronix.de>
 <7717e4470f6881bbc92645c72ad7f6ec71360796.camel@redhat.com>
 <779d3346-0344-9064-15d5-4d565647a556@pengutronix.de>
 <1b70f56b72943bf5dfd2813565373e8c1b639c31.camel@redhat.com>
 <53ce1ab4-3346-2367-8aa5-85a89f6897ec@pengutronix.de>
 <57a2352dfc442ea2aa9cd653f8e09db277bf67c7.camel@redhat.com>
 <b012e914-fc1a-5a45-f28b-e9d4d4dfc0fe@pengutronix.de>
Message-ID: <ef6b4e00-75fe-70f6-6b57-7bdbaa1aac33@pengutronix.de>
Date:   Tue, 4 Feb 2020 17:25:38 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.0
MIME-Version: 1.0
In-Reply-To: <b012e914-fc1a-5a45-f28b-e9d4d4dfc0fe@pengutronix.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 2001:67c:670:201:5054:ff:fe8d:eefb
X-SA-Exim-Mail-From: a.fatoum@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org
Sender: linux-can-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Hello Paolo,

On 1/20/20 5:06 PM, Ahmad Fatoum wrote:
> Hello Paolo,
> 
> On 1/16/20 1:40 PM, Paolo Abeni wrote:
>> I'm sorry for this trial & error experience. I tried to reproduce the
>> issue on top of the vcan virtual device, but it looks like it requires
>> the timing imposed by a real device, and it's missing here (TL;DR: I
>> can't reproduce the issue locally).
> 
> No worries. I don't mind testing.
> 
>>
>> Code wise, the 2nd patch closed a possible race, but it dumbly re-
>> opened the one addressed by the first attempt - the 'empty' field must
>> be cleared prior to the trylock operation, or we may end-up with such
>> field set and the queue not empty.
>>
>> So, could you please try the following code?
> 
> Unfortunately, I still see observe reodering.

Any news?

Thanks
Ahmad

-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
