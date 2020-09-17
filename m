Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 79E0026D072
	for <lists+linux-can@lfdr.de>; Thu, 17 Sep 2020 03:13:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726054AbgIQBNk (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Wed, 16 Sep 2020 21:13:40 -0400
Received: from mail-out.m-online.net ([212.18.0.9]:60272 "EHLO
        mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725886AbgIQBNk (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Wed, 16 Sep 2020 21:13:40 -0400
X-Greylist: delayed 482 seconds by postgrey-1.27 at vger.kernel.org; Wed, 16 Sep 2020 21:13:38 EDT
Received: from frontend01.mail.m-online.net (unknown [192.168.8.182])
        by mail-out.m-online.net (Postfix) with ESMTP id 4BsJg03z3Pz1qs4G;
        Thu, 17 Sep 2020 03:05:25 +0200 (CEST)
Received: from localhost (dynscan1.mnet-online.de [192.168.6.70])
        by mail.m-online.net (Postfix) with ESMTP id 4BsJfr6Jl6z1qwSy;
        Thu, 17 Sep 2020 03:05:24 +0200 (CEST)
X-Virus-Scanned: amavisd-new at mnet-online.de
Received: from mail.mnet-online.de ([192.168.8.182])
        by localhost (dynscan1.mail.m-online.net [192.168.6.70]) (amavisd-new, port 10024)
        with ESMTP id FqgdTcnucdjh; Thu, 17 Sep 2020 03:05:23 +0200 (CEST)
X-Auth-Info: QtW3ZCSFydW7Acop+OgmpJ4MGJ4Y9os5JMB4YDj5fGA=
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.mnet-online.de (Postfix) with ESMTPSA;
        Thu, 17 Sep 2020 03:05:23 +0200 (CEST)
Subject: Re: [PATCH] can: m_can: Set pinmux into "default" state on start
From:   Marek Vasut <marex@denx.de>
To:     linux-can@vger.kernel.org
Cc:     Alexandre Torgue <alexandre.torgue@st.com>,
        Marc Kleine-Budde <mkl@pengutronix.de>,
        Wolfgang Grandegger <wg@grandegger.com>, dmurphy@ti.com,
        netdev@vger.kernel.org, socketcan@hartkopp.net,
        davem@davemloft.net, andrew@lunn.ch
References: <20200531181324.383930-1-marex@denx.de>
 <419338dc-870d-51a4-87ac-ceddcba046dc@denx.de>
 <341ddbb5-d46a-813a-8fe9-b0d16ca25041@denx.de>
Message-ID: <c0c2b01d-8cdb-713d-5b4a-cb5dd6e2dd9d@denx.de>
Date:   Thu, 17 Sep 2020 03:04:31 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <341ddbb5-d46a-813a-8fe9-b0d16ca25041@denx.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

On 9/1/20 8:56 PM, Marek Vasut wrote:
> On 8/9/20 1:01 PM, Marek Vasut wrote:
>> On 5/31/20 8:13 PM, Marek Vasut wrote:
>>> On systems like stm32mp1 where pins have both "default" and "sleep" pinmux
>>> states in DT, the pins are in "sleep" state by default. Switch the pins into
>>> the "default" state when bringing the interface up in m_can_start(), because
>>> otherwise no CAN communication is possible. This replicates the behavior of
>>> the resume path, which does the same.
>>>
>>> Signed-off-by: Marek Vasut <marex@denx.de>
>>> Cc: Alexandre Torgue <alexandre.torgue@st.com>
>>> Cc: Marc Kleine-Budde <mkl@pengutronix.de>
>>> Cc: Wolfgang Grandegger <wg@grandegger.com>
>>> To: linux-can@vger.kernel.org
>>> ---
>>>  drivers/net/can/m_can/m_can.c | 2 ++
>>>  1 file changed, 2 insertions(+)
>>>
>>> diff --git a/drivers/net/can/m_can/m_can.c b/drivers/net/can/m_can/m_can.c
>>> index 02c5795b7393..76fadf2b8ac2 100644
>>> --- a/drivers/net/can/m_can/m_can.c
>>> +++ b/drivers/net/can/m_can/m_can.c
>>> @@ -1247,6 +1247,8 @@ static void m_can_start(struct net_device *dev)
>>>  	/* basic m_can configuration */
>>>  	m_can_chip_config(dev);
>>>  
>>> +	pinctrl_pm_select_default_state(cdev->dev);
>>> +
>>>  	cdev->can.state = CAN_STATE_ERROR_ACTIVE;
>>>  
>>>  	m_can_enable_all_interrupts(cdev);
>>>
>>
>> Any news on this ?
> 
> Almost another month has passed by, ping ?

Bump ?
