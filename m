Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5706B67AA31
	for <lists+linux-can@lfdr.de>; Wed, 25 Jan 2023 07:10:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233235AbjAYGJ7 (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Wed, 25 Jan 2023 01:09:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229611AbjAYGJ7 (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Wed, 25 Jan 2023 01:09:59 -0500
X-Greylist: delayed 1681 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 24 Jan 2023 22:09:57 PST
Received: from mail109.syd.optusnet.com.au (mail109.syd.optusnet.com.au [211.29.132.80])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A413111664
        for <linux-can@vger.kernel.org>; Tue, 24 Jan 2023 22:09:57 -0800 (PST)
Received: from [10.0.25.80] (119-18-18-64.771212.mel.static.aussiebb.net [119.18.18.64])
        (Authenticated sender: thomasaevans@optusnet.com.au)
        by mail109.syd.optusnet.com.au (Postfix) with ESMTPA id 85EC8101D7B;
        Wed, 25 Jan 2023 16:41:52 +1100 (AEDT)
Message-ID: <a269b5b8-a88d-d2da-5bcf-59f2aac40f87@optusnet.com.au>
Date:   Wed, 25 Jan 2023 16:41:50 +1100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Reply-To: tom_usenet@optusnet.com.au
Subject: Re: [PATCH 0/5] can: mcp251xfd: workaround double-RX erratum
Content-Language: en-AU
To:     Marc Kleine-Budde <mkl@pengutronix.de>, linux-can@vger.kernel.org
References: <20230111222042.1139027-1-mkl@pengutronix.de>
 <20230111223004.w7z4ghdahe7jvebe@pengutronix.de>
From:   Tom Evans <tom_usenet@optusnet.com.au>
In-Reply-To: <20230111223004.w7z4ghdahe7jvebe@pengutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.4 cv=VuxAv86n c=1 sm=1 tr=0 ts=63d0c122
        a=Lf5aCawj7dh4WJFkpvCygA==:117 a=Lf5aCawj7dh4WJFkpvCygA==:17
        a=IkcTkHD0fZMA:10 a=RSmzAf-M6YYA:10 a=FowR54BGJnGkWPelVYcA:9
        a=QEXdDO2ut3YA:10
X-Spam-Status: No, score=-3.8 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

On 12/1/23 09:30, Marc Kleine-Budde wrote:
> On 11.01.2023 23:20:37, Marc Kleine-Budde wrote:
>> this is a proof of concept implementation to work around the
>> "double-RX" erratum found by Stefan Althöfer.
>>
>> With the help of Thomas we found out that the chip has a time window
>> after receiving a CAN frame where the RX FIFO STA register content is
>> not read correctly.

This is being called an "erratum". I take that to mean an admitted bug published by the chip 
manufacturer. Has there been any response from Microchip on this yet? If they could properly 
describe what's wrong, it might lead to more robust work arounds.

I've noticed people know about the "maximum SPI clock rate", and are getting close to it in testing. 
The chip might have more (and more frequent) problems near that limit.

The MCP2517FD has more errata items than the MCP2518FD. Anyone using the earlier chip might be 
seeing more problems than people using the MCP2518FD are.

The MCP2517FD (published Errata item #1) is sensitive to delays between SPI Write and delays between 
writes and Chip Select Deassertion. Some SPI drivers and setups don't use the SPI controller's 
native chip-select, but use GPIO pins for flexibility. On Linux that can result in long delays until 
the GPIO Chip Select is deasserted, and long delays between bytes. There are DMA-based SPI 
controllers without these problems, but there may not be full driver support for them. YMMV.

Anyone seeing a difference in errors between two different SPI controllers might be seeing the 
results of different timing (chip select and byte to byte) between them.

Tom

