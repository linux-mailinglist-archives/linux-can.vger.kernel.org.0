Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 111A6E44AB
	for <lists+linux-can@lfdr.de>; Fri, 25 Oct 2019 09:39:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407160AbfJYHjC (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Fri, 25 Oct 2019 03:39:02 -0400
Received: from mail.iot.bzh ([51.75.236.24]:39789 "EHLO mail.iot.bzh"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2406055AbfJYHjC (ORCPT <rfc822;linux-can@vger.kernel.org>);
        Fri, 25 Oct 2019 03:39:02 -0400
Received: from [10.18.0.57] (unknown [10.18.0.57])
        by mail.iot.bzh (Postfix) with ESMTPSA id B6A0D40078;
        Fri, 25 Oct 2019 09:38:55 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iot.bzh; s=20180822;
        t=1571989135; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=V5gyaukWNKKWxImyC0Ht3SP6ii6Wv3hK7hk4qqKgZHE=;
        b=V4rcYibe931la26vKiO8/fdhjqpR/0FRuoe012EKhrfwST3JyRcLeVQw+QkWYMHHCWQJiu
        NtyueaG2sEsEFmVSlRoerUOiM5yr97XuW7TPDfJt5a+zR20kUeDmNANC5hU+ZsA9rL19qG
        YpJI2H/D5dxCeYMnzVKAKuWVc/waPjXZwZD1H1Kwooc012SBWyVhTcGa8PM8SkaM6SYx8P
        +JQR8lzW8D8S8xcYzvqB7MMV7GThpMDzeCRt9QELEaiRrUvKMyvYPnnXVGeq/XV7/iyEiA
        LVgSYRFynhDF8tji7RAobPDKjIgwuoq+hiBBjPuZClwbi2phxMJ52ksU7f3fMQ==
Subject: Re: Questions around J1939 backport to old kernel
To:     Oleksij Rempel <o.rempel@pengutronix.de>
Cc:     "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>
References: <b2dd08f0-0390-21c8-83c5-c6c361e78d9c@iot.bzh>
 <20191018145333.a27j7d7f4zf3bqjd@pengutronix.de>
From:   "Romain Forlot [IoT.bzh]" <romain.forlot@iot.bzh>
Organization: IOTBZH
Message-ID: <72a6f8b2-38e3-a54b-d719-10471d4d260b@iot.bzh>
Date:   Fri, 25 Oct 2019 09:38:39 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20191018145333.a27j7d7f4zf3bqjd@pengutronix.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-can-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

I used it in the mainline kernel without troubles. This is a a very good 
job, thanks.

Ok, thanks for the answer. May be I  will work on it in the next few 
months. Let's see. I'll keep you informed.

Regards.

On 18/10/2019 16:53, Oleksij Rempel wrote:
> Hi,
>
> On Fri, Oct 18, 2019 at 12:07:34PM +0200, Romain Forlot [IoT.bzh] wrote:
>> Hi,
>>
>> I am wondering what the cost is to backport the j1939 module to an old
>> version like a v4.14 LTSI version.
> The backport should be quite easy:
>
> git cherry-pick -sx `git rev-list --reverse 2c1f9e26344483e2c74e80ef708d9c7fd2e543f4..9d71dd0c70099914fcd063135da3c580865e924c`
>
> ...but it isn't :/ Some CAN patches are missing. We'll backport the stack to
> v4.14.150 (or newer) and send a follow up mail.
>
> However, the driver for the CAN adapter needs proper RX/TX frame ordering,
> otherwise the stack will explode.
>
> This is fixed in flexcan mainline. And involves a handful of patches. Other
> drivers probably need more fixing. Some CAN hardware may even lack the hardware
> support for proper ordering, that is time stamping registers.
>
>> And what the impact is of backporting the whole CAN stack on the CAN drivers?
> The stack has no impact on the drivers, but requirements on proper RX/TX
> ordering, see above.
>
>> Are there any modifications to drivers once the CAN stack is updated ?
> Yes, as long as they don't have proper RX/TX ordering.
>
> So, which CAN driver are you planing to use?
>
> Regards,
> Oleksij & Marc
>
-- 
Romain Forlot - Embedded Engineer - IoT.bzh
romain.forlot@iot.bzh - www.iot.bzh - +33675142438

