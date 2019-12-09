Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id ACDC31178EF
	for <lists+linux-can@lfdr.de>; Mon,  9 Dec 2019 22:59:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726483AbfLIV72 (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Mon, 9 Dec 2019 16:59:28 -0500
Received: from fllv0016.ext.ti.com ([198.47.19.142]:58196 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726230AbfLIV72 (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Mon, 9 Dec 2019 16:59:28 -0500
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id xB9LxLbQ063300;
        Mon, 9 Dec 2019 15:59:21 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1575928761;
        bh=lMO0PXn0Jt5mKiDMFiWM68xjM56tmY97PJ9ZbttHX0k=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=GFxE58y90h1tAZC7SkTdkTNKDY/5pJROHsWpMw2IFgCH+HYBjBKj1WMrtqtcTFyfF
         rCJ3h/yVQ8R+m9CrENVSck1nDPDKIClpo8GQ82vJroK7alwndfLLhcOYN4sflu5IH9
         hAEp5B7RV1CpwzjpQ02K5g0l2BDqb9t6K9TZdunw=
Received: from DLEE103.ent.ti.com (dlee103.ent.ti.com [157.170.170.33])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTP id xB9LxL7N127481;
        Mon, 9 Dec 2019 15:59:21 -0600
Received: from DLEE100.ent.ti.com (157.170.170.30) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3; Mon, 9 Dec
 2019 15:59:20 -0600
Received: from fllv0039.itg.ti.com (10.64.41.19) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3 via
 Frontend Transport; Mon, 9 Dec 2019 15:59:20 -0600
Received: from [10.250.65.13] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id xB9LxK4c072751;
        Mon, 9 Dec 2019 15:59:20 -0600
Subject: Re: [PATCH v2 2/2] can: m_can: tcan4x5x: reset device before register
 access
To:     Sean Nyekjaer <sean@geanix.com>, <mkl@pengutronix.de>,
        <linux-can@vger.kernel.org>
CC:     <martin@geanix.com>
References: <20191209192440.998659-1-sean@geanix.com>
 <20191209192440.998659-2-sean@geanix.com>
 <17908fc8-550b-4832-5b43-7a5ea387a12f@ti.com>
 <10dab7ae-dcfa-2aec-2146-df24ec1e8686@geanix.com>
From:   Dan Murphy <dmurphy@ti.com>
Message-ID: <1eca843d-8ef5-f591-5433-4bab6921e8dd@ti.com>
Date:   Mon, 9 Dec 2019 15:57:13 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.1
MIME-Version: 1.0
In-Reply-To: <10dab7ae-dcfa-2aec-2146-df24ec1e8686@geanix.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-can-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Sean

On 12/9/19 3:47 PM, Sean Nyekjaer wrote:
>
>
> On 09/12/2019 22.27, Dan Murphy wrote:
>> Sean
>>
>> On 12/9/19 1:24 PM, Sean Nyekjaer wrote:
>>> It's a good idea to reset a ip-block/spi device before using it,
>>> this patch will reset the device.
>>
>> $subject says 2/2 where is 1/2?
>
> Here?
> https://www.spinics.net/lists/linux-can/msg03020.html
>

Interesting I don't have that in my inbox or in the thread. Maybe it got 
bounced.

But anyway you will probably need my power_enable patch.  If you try to 
init with power off on a managed regulator your SPI access will fail.

https://www.spinics.net/lists/kernel/msg3340542.html

v2 will be posted once I test it

Dan


