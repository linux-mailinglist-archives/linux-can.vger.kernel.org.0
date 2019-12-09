Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 415421177ED
	for <lists+linux-can@lfdr.de>; Mon,  9 Dec 2019 22:03:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726483AbfLIVDq (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Mon, 9 Dec 2019 16:03:46 -0500
Received: from fllv0015.ext.ti.com ([198.47.19.141]:56872 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726230AbfLIVDq (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Mon, 9 Dec 2019 16:03:46 -0500
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id xB9L3cvU067245;
        Mon, 9 Dec 2019 15:03:38 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1575925418;
        bh=Vo54NlPc9K8goMK1IZ45FTq3vcHvLoEuEauGik/ySfg=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=ZMMOR5ncDPmbR0UlVvHGPTiLOmFCmmKToSdYT30/DfZGN/enuZPJBhU9gAkLpjpq8
         nmI+WRY3Os6AT0VtvBJPRKEQ+avQSs21gT1674/Jq2GbziBOA48D+hfRqlWUKLt0ms
         W7Isrq59osIP/dU88FxEnv+tbLD3BlTNefgzrMdM=
Received: from DLEE106.ent.ti.com (dlee106.ent.ti.com [157.170.170.36])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id xB9L3cD4107652
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 9 Dec 2019 15:03:38 -0600
Received: from DLEE100.ent.ti.com (157.170.170.30) by DLEE106.ent.ti.com
 (157.170.170.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3; Mon, 9 Dec
 2019 15:03:37 -0600
Received: from fllv0039.itg.ti.com (10.64.41.19) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3 via
 Frontend Transport; Mon, 9 Dec 2019 15:03:37 -0600
Received: from [10.250.65.13] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id xB9L3bqH105434;
        Mon, 9 Dec 2019 15:03:37 -0600
Subject: Re: [PATCH 2/2] net: m_can: Make wake-up gpio an optional
To:     Marc Kleine-Budde <mkl@pengutronix.de>,
        Sean Nyekjaer <sean@geanix.com>
CC:     <linux-can@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>
References: <20191204175112.7308-1-dmurphy@ti.com>
 <20191204175112.7308-2-dmurphy@ti.com>
 <b9eaa5c4-13bc-295f-dcbf-d2a846243682@geanix.com>
 <827b022e-9188-7bcf-25e3-3777df3b08a5@ti.com>
 <809b9ff1-88e3-4e46-33e0-856db37898b2@pengutronix.de>
From:   Dan Murphy <dmurphy@ti.com>
Message-ID: <dc24a8a3-d515-f84b-9f33-db92bd4a412a@ti.com>
Date:   Mon, 9 Dec 2019 15:01:30 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.1
MIME-Version: 1.0
In-Reply-To: <809b9ff1-88e3-4e46-33e0-856db37898b2@pengutronix.de>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-can-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Marc

On 12/5/19 8:39 AM, Marc Kleine-Budde wrote:
> On 12/5/19 2:26 PM, Dan Murphy wrote:
>> On 12/5/19 1:39 AM, Sean Nyekjaer wrote:
>>>
>>> On 04/12/2019 18.51, Dan Murphy wrote:
>>>> The device has the ability to disable the wake-up pin option.
>>>> The wake-up pin can be either force to GND or Vsup and does not have to
>>>> be tied to a GPIO.  In order for the device to not use the wake-up
>>>> feature
>>>> write the register to disable the WAKE_CONFIG option.
>>>>
>>>> Signed-off-by: Dan Murphy <dmurphy@ti.com>
>>>> CC: Sean Nyekjaer <sean@geanix.com>
>>> Reviewed-by: Sean Nyekjaer <sean@geanix.com>
>>>> ---
>>>
>>> Hi Dan,
>>>
>>> I would add tcan4x5x to the subject of this patch ->
>>> "net: m_can: tcan4x5x Make wake-up gpio an optional"
>>>
>> Do you want me to submit v2 with the $subject change?
>>
>> Or would you fix it up when committing it?
> I'll change the subject while applying.
>
> Dan, what about maintainerchip of the tcan4x5?

Do you know when you will be applying these?

I have 2 patches I need to put on top.

Dan

> regards,
> Marc
>
