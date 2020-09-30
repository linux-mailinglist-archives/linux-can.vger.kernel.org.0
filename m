Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0293C27E63F
	for <lists+linux-can@lfdr.de>; Wed, 30 Sep 2020 12:11:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725823AbgI3KLW (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Wed, 30 Sep 2020 06:11:22 -0400
Received: from mailrelay2-2.pub.mailoutpod1-cph3.one.com ([46.30.212.1]:57715
        "EHLO mailrelay2-2.pub.mailoutpod1-cph3.one.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725779AbgI3KLW (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Wed, 30 Sep 2020 06:11:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=csselectronics.com; s=20191106;
        h=content-transfer-encoding:content-type:in-reply-to:mime-version:date:
         message-id:from:references:cc:to:subject:from;
        bh=+agPal0QNlIlVkn0xFRNU+n/7jGIaMeashGPPh/iZAE=;
        b=HmGFHHanRGSb3TODsg2K3C7PEY3tH1R87uElbv3lsJsLik6NWLnW7bu9Ao45ARo9o11zE8pTCUIO5
         2WOm8yP/9XjDzzZ5hA4/sof+PkCZ4ffKXO79Sl1ORmZCQrcy3irBxURUu6ZgoUVRBy/xnrDBr8THTK
         C3y++AgiY88Rg+xBM+7V1bnYq1aINXuQM+AKcNrWrUj6JklgTXENNv2C3lG/b62+InhizJIO78vfTh
         DkHIb7gUrSueqGdfgxiivA4FZzRgDTIG8etEBiCuFt746K8lcq4x4QmhGfDTDNFiqdl+GRJbWoCkhs
         lky5UqCnaOM/CV9dlISBB+UfZFFOMvQ==
X-HalOne-Cookie: 766aff575a3abb401aceabd48ce7f42e3652c4a1
X-HalOne-ID: 4770d70a-0305-11eb-84a6-d0431ea8a290
Received: from [192.168.0.157] (unknown [5.103.118.41])
        by mailrelay2.pub.mailoutpod1-cph3.one.com (Halon) with ESMTPSA
        id 4770d70a-0305-11eb-84a6-d0431ea8a290;
        Wed, 30 Sep 2020 10:11:17 +0000 (UTC)
Subject: Re: mcp25xxfd driver questions
To:     Marc Kleine-Budde <mkl@pengutronix.de>
Cc:     linux-can@vger.kernel.org, Bas Vermeulen <bas.vermeulen@molex.com>,
        Thomas Kopp <Thomas.Kopp@microchip.com>
References: <f888df6e-d281-b9b6-93de-1a7329f011ed@csselectronics.com>
 <66662c88-aa9a-325d-8152-c5befbfafa2a@pengutronix.de>
 <1ee0af54-cdd6-4dc7-1956-e302bec716ff@csselectronics.com>
 <6bfc53ae-e40c-98b1-af78-66aca4d911cc@pengutronix.de>
From:   =?UTF-8?Q?Magnus_Aagaard_S=c3=b8rensen?= <mas@csselectronics.com>
Message-ID: <fafb1bf7-5427-34a5-54b1-c80280e466a1@csselectronics.com>
Date:   Wed, 30 Sep 2020 12:11:17 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <6bfc53ae-e40c-98b1-af78-66aca4d911cc@pengutronix.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

On 30-09-2020 09:27, Marc Kleine-Budde wrote:
> On 9/30/20 7:32 AM, Magnus Aagaard Sørensen wrote:
>> On 29-09-2020 15:46, Marc Kleine-Budde wrote:
>>> On 9/29/20 1:07 PM, Magnus Aagaard Sørensen wrote:
>>>> I'm evaluating the MCP2518FD, and have two questions to the driver.
>> I should clarify that we already have an older internal test board with
>> the chip working, using the driver by Martin Sperl. I'm evaluating the
>> possibilities to migrate to this driver in the future, since I can see
>> it is being mainline, but for now I mainly wish to use it on a new
>> internal test board.
> Ah, ok. More users are always welcome. Which SoC are you using?
We are controlling the test boards using a Raspberry Pi 4, so I assume 
it is a Broadcom BCM2711.
>>>> 1. I could not find any references to the GPIOs of the chip. Is it
>>>> correct that these are not exposed to the host system?
>>> ACK, gpio support is not implemented yet. Drop me a note, if you need it.
>> On the board I'm currently working on getting up and running, we have no
>> need for GPIOs or any of the other advanced features of the MCP2518FD.
>> On our older board, we do utilize the GPIO and oscillator output
>> functionality of the chip. It works for now with the old driver, so it
>> is not a priority. It would be nice to have this functionality in the
>> future for us.
> Bas Vermeulen (Cc'ed) is using the mainline driver (or an older version of it)
> and send a pull request for oscillator output
> (https://github.com/marckleinebudde/linux/pull/5). I did an initial review
> there. This is a good starting point if you want to contribute (or drop me a
> note for commercial support).
>
>>>> 2. When setting the oscillator frequency outside the
>>>> MCP25XXFD_SYSCLOCK_HZ_MIN and MCP25XXFD_SYSCLOCK_HZ_MAX range, the
>>>> frequency is compared to the max value scaled by the max PLL value. Is
>>>> the intention to compare with the min value? Currently, an external
>>>> oscillator of 4 MHz and a PLL value of 10, resulting in 40 MHz, is
>>>> treated as being too low.
>>> This is intended. I have no hardware with a 4MHz osc to test, so I decided to
>>> not support the 4MHz osc for now. If you design new hardware I suggest to use a
>>> 40MHz osc, as probably no one has tested the hardware thoroughly in the PLL
>>> mode. If you need 4MHz support, it can be added, given there is hardware.
>> I can provide some test information if needed, as I have internal
>> testing hardware with a 4 MHz oscillator already. Are there any specific
>> message sequences that needs to be tested?
> You have to take care of the PLL in the functions mcp25xxfd_chip_clock_enable(),
> mcp25xxfd_chip_softreset_check(), mcp25xxfd_chip_clock_init().
>
> The MCP25XXFD_REG_OSC_PLLEN bit has to be set and the MCP25XXFD_REG_OSC_PLLRDY
> bit has to be polled.
>
> I'm not sure what SPI speed you can use, when communicating with the mcp, if the
> PLL is not enabled. Maybe Thomas (Cc'ed) can answer this. I suspect you can only
> use 2MHZ (or rather 85% of it) if you have a 4 MHz OSC with PLL still disabled.
Thanks for the hints, I'll see if I can adapt it to our use case.
>> The chip will most likely not reach high loads with the setup we have in
>> mind, so I'll manually change the frequency check in the probe function
>> for now.
> This will probably not work, as the driver has to enable the PLL and the SPI
> clock has to be really slow.
>
>> It's great to hear the reasoning. Thanks for the hard work you and
>> others have put into this driver and the whole CAN system in linux.
> Thanks. I'm just standing on the shoulder of giants. This driver was and is
> great community work. First of all there was Martin's driver, which shows how a
> Linux driver for the chip can look. Then several tireless testers here and on
> github, direct and open communication with Microchip, and there are several
> $CUSTOMERs paying to get the driver mainline.
>
> regards,
> Marc

Regards, Magnus.


