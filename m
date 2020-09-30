Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4D7CC27E060
	for <lists+linux-can@lfdr.de>; Wed, 30 Sep 2020 07:32:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725497AbgI3Fc3 (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Wed, 30 Sep 2020 01:32:29 -0400
Received: from mailrelay4-2.pub.mailoutpod1-cph3.one.com ([46.30.212.3]:61462
        "EHLO mailrelay4-2.pub.mailoutpod1-cph3.one.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725306AbgI3Fc2 (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Wed, 30 Sep 2020 01:32:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=csselectronics.com; s=20191106;
        h=content-transfer-encoding:content-type:in-reply-to:mime-version:date:
         message-id:cc:from:references:to:subject:from;
        bh=whzn3NvH2s/yKTQy1efR7zLtOFC/1Xr+mfA/PJN2wRM=;
        b=F9b7iBAW3iI0SCojbvGshLe0Gw09Y+S1IBkkMrthBlPZFsHkZVxMOgplu15hRBFy9zJoCOc8RbSI2
         R1q8K+505fRiFvkGAUnDY8zcLQz0WEHxGHPHRM2mmwheBDnoIMBsTNHrqU6TeIwTSuXB+s2gGum3Mb
         BnOiMICA+xYBlg9sAaOObEey/1K3G3OIjwVlBnGXXieaHpHLXa0Hfloxz3l1AmJ8S9SuyI9hHvwRgV
         IT8JZ2oeziOrwidX98gh+ylf82MdXmS3pNU0A/Mw+FdXUIJxWC3B09Hkf/t1loSfd1DAUhZe2AJMGz
         TdBiqQ4hFjrJiHT7WWNcpqqsDxLdTug==
X-HalOne-Cookie: a789c74f3281a66c2a7af3a91b42648bdcc07d82
X-HalOne-ID: 51ff232d-02de-11eb-a2ae-d0431ea8bb10
Received: from [192.168.0.157] (unknown [5.103.118.41])
        by mailrelay4.pub.mailoutpod1-cph3.one.com (Halon) with ESMTPSA
        id 51ff232d-02de-11eb-a2ae-d0431ea8bb10;
        Wed, 30 Sep 2020 05:32:24 +0000 (UTC)
Subject: Re: mcp25xxfd driver questions
To:     Marc Kleine-Budde <mkl@pengutronix.de>
References: <f888df6e-d281-b9b6-93de-1a7329f011ed@csselectronics.com>
 <66662c88-aa9a-325d-8152-c5befbfafa2a@pengutronix.de>
From:   =?UTF-8?Q?Magnus_Aagaard_S=c3=b8rensen?= <mas@csselectronics.com>
Cc:     linux-can@vger.kernel.org
Message-ID: <1ee0af54-cdd6-4dc7-1956-e302bec716ff@csselectronics.com>
Date:   Wed, 30 Sep 2020 07:32:25 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <66662c88-aa9a-325d-8152-c5befbfafa2a@pengutronix.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

On 29-09-2020 15:46, Marc Kleine-Budde wrote:
> On 9/29/20 1:07 PM, Magnus Aagaard Sørensen wrote:
>> I'm evaluating the MCP2518FD, and have two questions to the driver.
I should clarify that we already have an older internal test board with 
the chip working, using the driver by Martin Sperl. I'm evaluating the 
possibilities to migrate to this driver in the future, since I can see 
it is being mainline, but for now I mainly wish to use it on a new 
internal test board.
>> 1. I could not find any references to the GPIOs of the chip. Is it
>> correct that these are not exposed to the host system?
> ACK, gpio support is not implemented yet. Drop me a note, if you need it.

On the board I'm currently working on getting up and running, we have no 
need for GPIOs or any of the other advanced features of the MCP2518FD. 
On our older board, we do utilize the GPIO and oscillator output 
functionality of the chip. It works for now with the old driver, so it 
is not a priority. It would be nice to have this functionality in the 
future for us.

>> 2. When setting the oscillator frequency outside the
>> MCP25XXFD_SYSCLOCK_HZ_MIN and MCP25XXFD_SYSCLOCK_HZ_MAX range, the
>> frequency is compared to the max value scaled by the max PLL value. Is
>> the intention to compare with the min value? Currently, an external
>> oscillator of 4 MHz and a PLL value of 10, resulting in 40 MHz, is
>> treated as being too low.
> This is intended. I have no hardware with a 4MHz osc to test, so I decided to
> not support the 4MHz osc for now. If you design new hardware I suggest to use a
> 40MHz osc, as probably no one has tested the hardware thoroughly in the PLL
> mode. If you need 4MHz support, it can be added, given there is hardware.

I can provide some test information if needed, as I have internal 
testing hardware with a 4 MHz oscillator already. Are there any specific 
message sequences that needs to be tested?

The chip will most likely not reach high loads with the setup we have in 
mind, so I'll manually change the frequency check in the probe function 
for now.

> Hope that helps.
>
> regards,
> Marc

It's great to hear the reasoning. Thanks for the hard work you and 
others have put into this driver and the whole CAN system in linux.

Regards, Magnus.

