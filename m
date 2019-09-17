Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 12AA8B48A9
	for <lists+linux-can@lfdr.de>; Tue, 17 Sep 2019 09:58:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728097AbfIQH6l (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Tue, 17 Sep 2019 03:58:41 -0400
Received: from mail.iot.bzh ([51.75.236.24]:40032 "EHLO mail.iot.bzh"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727321AbfIQH6l (ORCPT <rfc822;linux-can@vger.kernel.org>);
        Tue, 17 Sep 2019 03:58:41 -0400
Received: from [10.18.0.57] (laubervilliers-656-1-70-194.w82-127.abo.wanadoo.fr [82.127.244.194])
        by mail.iot.bzh (Postfix) with ESMTPSA id 67F8940098;
        Tue, 17 Sep 2019 09:58:33 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iot.bzh; s=20180822;
        t=1568707113; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=XsTBUCTq90MhkblZtaBtrCc0OjIWYDQ0z/ny4/i4HrA=;
        b=LHkgeG/m0+W/OBvRRJ16B0orVFhF3OQX1vfTcKo+GJDKHp6z5s4mVEqVJNSeS/JGPTUGx0
        WCG4Bb+QxNYEk27PD1bffp3lkagcP6dlXtZOHnASmh2krPJLqR8rzWsinTJkNBtCP6yOC/
        To6NowTXUcmgR1IuPjK1Hr8ubCAVvBXPv3xMx+iCt7UZzGz1NWBjSjE57OwNeygTUJdfT/
        gqBvrCnQOluK2zdv5+SfEdQqGapB6nrrAbFu5UiOmvLQIJIIKVRTwLbPeX9Wvh7jI9Twyi
        2uU48r2ZVTvkjpDyTXG8CpLcjz3R7DHZmcdRiXw5Llz+ynU9NZa40VvL1kN9CA==
Subject: Re: J1939 support
To:     Oleksij Rempel <o.rempel@pengutronix.de>,
        Robert Schwebel <r.schwebel@pengutronix.de>
Cc:     "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>
References: <e39e2d61-66ad-d3ce-cd1e-5a2245d632a1@iot.bzh>
 <20190916214043.ozk4hivghjpuwu56@pengutronix.de>
 <70f12813-8f6a-fa73-42eb-95c76dde03ad@pengutronix.de>
From:   "Romain Forlot [IoT.bzh]" <romain.forlot@iot.bzh>
Organization: IOTBZH
Message-ID: <c3e2a14d-6ac2-1c6c-d501-c87fd99c8665@iot.bzh>
Date:   Tue, 17 Sep 2019 09:58:31 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.0
MIME-Version: 1.0
In-Reply-To: <70f12813-8f6a-fa73-42eb-95c76dde03ad@pengutronix.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-can-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Oh nice, thanks guys !

On 17/09/2019 06:38, Oleksij Rempel wrote:
>
>
> On 16.09.19 23:40, Robert Schwebel wrote:
>> On Mon, Sep 16, 2019 at 06:41:01PM +0200, Romain Forlot [IoT.bzh] wrote:
>>> We followed work within linux-can-next repository and more particularly
>>> about the j1939 branches.
>>>
>>> They have recently been removed from the repository, is it because 
>>> they will
>>> be integrated in the mainline kernel ? (Not found ATM in the master 
>>> branch
>>> of the stable linux repository)
>>>
>>> Else, where could be found the recent progression on this subject ? 
>>> Thanks
>>
>> It is currently in net-next:
>> https://git.kernel.org/pub/scm/linux/kernel/git/davem/net-next.git/commit/?id=9d71dd0c70099914fcd063135da3c580865e924c 
>>
>
> and linux-next.git
> https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/commit/net/can/j1939?h=next-20190916&id=9d71dd0c70099914fcd063135da3c580865e924c 
>
>
> Kind regards,
> Oleksij Rempel
>
-- 
Romain Forlot - Embedded Engineer - IoT.bzh
romain.forlot@iot.bzh - www.iot.bzh - +33675142438

