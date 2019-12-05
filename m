Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 24B7411416F
	for <lists+linux-can@lfdr.de>; Thu,  5 Dec 2019 14:28:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729099AbfLEN2R (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Thu, 5 Dec 2019 08:28:17 -0500
Received: from fllv0015.ext.ti.com ([198.47.19.141]:52320 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729048AbfLEN2Q (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Thu, 5 Dec 2019 08:28:16 -0500
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id xB5DS8rd109614;
        Thu, 5 Dec 2019 07:28:08 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1575552488;
        bh=7JZvZPT9dAnniPhNx/k+WuJDCz1xGhlz+enp4fhaaso=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=LO4WnFjFJZYlztPxOqGoBcNW2PzIim+nRdQu8VoL+BtGNe7lQoVreWr3LB0BhKZy5
         cbCYg61lZ96gzOU5/YnV142mFAzF61b7e6sgS/00kjiwUgGljbZGQ67WXMxZiDkJ7B
         F7julAaklTk8wGJ3ZxEAWwFhTQgG+VLPxCyfZKE8=
Received: from DLEE114.ent.ti.com (dlee114.ent.ti.com [157.170.170.25])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTP id xB5DS8mX002799;
        Thu, 5 Dec 2019 07:28:08 -0600
Received: from DLEE105.ent.ti.com (157.170.170.35) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3; Thu, 5 Dec
 2019 07:28:08 -0600
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3 via
 Frontend Transport; Thu, 5 Dec 2019 07:28:08 -0600
Received: from [10.250.65.13] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id xB5DS8kr052362;
        Thu, 5 Dec 2019 07:28:08 -0600
Subject: Re: [PATCH 2/2] net: m_can: Make wake-up gpio an optional
To:     Sean Nyekjaer <sean@geanix.com>, <mkl@pengutronix.de>
CC:     <linux-can@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>
References: <20191204175112.7308-1-dmurphy@ti.com>
 <20191204175112.7308-2-dmurphy@ti.com>
 <b9eaa5c4-13bc-295f-dcbf-d2a846243682@geanix.com>
From:   Dan Murphy <dmurphy@ti.com>
Message-ID: <827b022e-9188-7bcf-25e3-3777df3b08a5@ti.com>
Date:   Thu, 5 Dec 2019 07:26:05 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.1
MIME-Version: 1.0
In-Reply-To: <b9eaa5c4-13bc-295f-dcbf-d2a846243682@geanix.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-can-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Marc

On 12/5/19 1:39 AM, Sean Nyekjaer wrote:
>
>
> On 04/12/2019 18.51, Dan Murphy wrote:
>> The device has the ability to disable the wake-up pin option.
>> The wake-up pin can be either force to GND or Vsup and does not have to
>> be tied to a GPIO.  In order for the device to not use the wake-up 
>> feature
>> write the register to disable the WAKE_CONFIG option.
>>
>> Signed-off-by: Dan Murphy <dmurphy@ti.com>
>> CC: Sean Nyekjaer <sean@geanix.com>
> Reviewed-by: Sean Nyekjaer <sean@geanix.com>
>> ---
>
>
> Hi Dan,
>
> I would add tcan4x5x to the subject of this patch ->
> "net: m_can: tcan4x5x Make wake-up gpio an optional"
>
Do you want me to submit v2 with the $subject change?

Or would you fix it up when committing it?

Dan

