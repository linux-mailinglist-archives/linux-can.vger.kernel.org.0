Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A85131176F2
	for <lists+linux-can@lfdr.de>; Mon,  9 Dec 2019 21:02:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726408AbfLIUCg (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Mon, 9 Dec 2019 15:02:36 -0500
Received: from first.geanix.com ([116.203.34.67]:47928 "EHLO first.geanix.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726354AbfLIUCg (ORCPT <rfc822;linux-can@vger.kernel.org>);
        Mon, 9 Dec 2019 15:02:36 -0500
Received: from [192.168.100.11] (unknown [95.138.208.137])
        by first.geanix.com (Postfix) with ESMTPSA id CC15344F;
        Mon,  9 Dec 2019 20:02:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=geanix.com; s=first;
        t=1575921733; bh=Yx2rAdqXEU9sP5Pp1mXaMu6WdPlQBXSAiGKZEgNNEWA=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To;
        b=SYk7iZ06wgjUhLXsfWeZgjO+K9vPoJHgE1vBR1s1OVYSttfhLuqueD60vsnQt6Pwi
         ePFrcCRqdSbTDxKpIv2GD+qtOVmP1YBYAiSpym7/sJZRhQQ49CQGJznTw40E6Ckhg9
         9Twb2OkVXjdMxIEseR6gQx22yXExfLSi91GVcIDmKHZqUk8pAKaT76pg76a+oNEkhE
         1uMwU/TKWYOorsnC4MOKbcTDgkMpQo9gRjEFvI6HPm4lUSh2lRJEyvIu2YuIei5EnL
         1CDWMM344C6lC5Z9EL9hbiLIyOg7mePgaNmac6LywB/7GcJh9kWJfD4any/BQuyKfh
         3sCMEQdAI0YvA==
Subject: Re: [PATCH v2] can: m_can: remove double clearing of clock stop
 request bit
To:     Dan Murphy <dmurphy@ti.com>, sriram.dash@samsung.com,
        pankj.sharma@samsung.com, mkl@pengutronix.de,
        linux-can@vger.kernel.org
Cc:     martin@geanix.com
References: <20191209192949.998976-1-sean@geanix.com>
 <cdf36996-376a-4755-75ff-27c441a317ad@ti.com>
From:   Sean Nyekjaer <sean@geanix.com>
Message-ID: <8382275e-c878-6dd2-cd78-9f4615d299ee@geanix.com>
Date:   Mon, 9 Dec 2019 21:02:32 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.0
MIME-Version: 1.0
In-Reply-To: <cdf36996-376a-4755-75ff-27c441a317ad@ti.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US-large
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.1 required=4.0 tests=ALL_TRUSTED,BAYES_00,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,URIBL_BLOCKED
        autolearn=disabled version=3.4.2
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on 8b5b6f358cc9
Sender: linux-can-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org



On 09/12/2019 20.53, Dan Murphy wrote:
> Sean
> 
> On 12/9/19 1:29 PM, Sean Nyekjaer wrote:
>> In m_can_config_endisable the CSR bit cleared 2 times while enabling
>> configuration mode.
>> The CSR should always be cleared when writing to the CCCR register.
>>
>> According to the datasheet:
>> If a Read-Modify-Write operation is performed in Standby mode a
>> CSR = 1 will be read back but a 0 should be written to it.
> 
> I am not understanding why you need to have this statement in the commit 
> message.
> 
> And are you referring to the Bosch IP data sheet or the TCAN data sheet?
TCAN :)
> 
> If it is the TCAN data sheet then this reference may not apply to the 
> MMIO version.
> 
> It would be best to denote which datasheet you are talking about here.
> 
> Other then that I agree with the change and will ACK once I understand 
> what data sheet you are talking about.

This patch is basically removal of some duplicate code, the register 
write functions will write exactly the same as before...
No functional changes have been made.

Maybe it's easier to see when reading drivers/net/can/m_can/m_can.c 
before and after this patch :-)

I can change the commit msg to whatever you will like to make this 
change less confusing...

/Sean
