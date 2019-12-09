Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 164E31177FF
	for <lists+linux-can@lfdr.de>; Mon,  9 Dec 2019 22:09:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726483AbfLIVJR (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Mon, 9 Dec 2019 16:09:17 -0500
Received: from fllv0016.ext.ti.com ([198.47.19.142]:52288 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726408AbfLIVJR (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Mon, 9 Dec 2019 16:09:17 -0500
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id xB9L9ANx047646;
        Mon, 9 Dec 2019 15:09:10 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1575925750;
        bh=Y4Fj9ku2JzET4DUtx5DnN34khAGg36Lhfe3pUDRQA3k=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=jhUlUlPm3bcdAoESnImEXH6bHp8xiIG2TuhcWJVNnL9mSheE0GPDNh2ROJ99vPgUI
         7jzaVhlN/CYsq58+U95Ghk8lEYk6+8OPRuAhcBsVXtQHGebopRanadNndeJZ9xzlnh
         vs00QY427Xwdi8vBy14bjL4Q9FedOC/qGE7HxQU0=
Received: from DFLE113.ent.ti.com (dfle113.ent.ti.com [10.64.6.34])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id xB9L9AAF053616
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 9 Dec 2019 15:09:10 -0600
Received: from DFLE114.ent.ti.com (10.64.6.35) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3; Mon, 9 Dec
 2019 15:09:10 -0600
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3 via
 Frontend Transport; Mon, 9 Dec 2019 15:09:10 -0600
Received: from [10.250.65.13] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id xB9L9As7115332;
        Mon, 9 Dec 2019 15:09:10 -0600
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
 <dc24a8a3-d515-f84b-9f33-db92bd4a412a@ti.com>
 <6ef8fe8a-acec-89c5-83d3-fd47cf1f40ab@pengutronix.de>
From:   Dan Murphy <dmurphy@ti.com>
Message-ID: <cc310081-1855-958b-fbe4-529937ff941c@ti.com>
Date:   Mon, 9 Dec 2019 15:07:02 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.1
MIME-Version: 1.0
In-Reply-To: <6ef8fe8a-acec-89c5-83d3-fd47cf1f40ab@pengutronix.de>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-can-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Marc

On 12/9/19 3:06 PM, Marc Kleine-Budde wrote:
> On 12/9/19 10:01 PM, Dan Murphy wrote:
>>>>> I would add tcan4x5x to the subject of this patch ->
>>>>> "net: m_can: tcan4x5x Make wake-up gpio an optional"
>>>>>
>>>> Do you want me to submit v2 with the $subject change?
>>>>
>>>> Or would you fix it up when committing it?
>>> I'll change the subject while applying.
>>>
>>> Dan, what about maintainerchip of the tcan4x5?
>> Do you know when you will be applying these?
> The patch is already upstream. See linux-can/mater:
>
> https://git.kernel.org/pub/scm/linux/kernel/git/mkl/linux-can.git/log/
>
> https://git.kernel.org/pub/scm/linux/kernel/git/mkl/linux-can.git/commit/?id=2de497356955ce58cd066fb03d2da5235f3c7c23

Ah I was looking here

https://git.kernel.org/pub/scm/linux/kernel/git/mkl/linux-can-next.git

>
