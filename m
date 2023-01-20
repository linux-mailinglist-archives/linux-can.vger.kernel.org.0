Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8211767521D
	for <lists+linux-can@lfdr.de>; Fri, 20 Jan 2023 11:10:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229500AbjATKKR (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Fri, 20 Jan 2023 05:10:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229489AbjATKKQ (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Fri, 20 Jan 2023 05:10:16 -0500
Received: from mail3.ems-wuensche.com (mail3.ems-wuensche.com [81.169.186.156])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 682ADAA7C8
        for <linux-can@vger.kernel.org>; Fri, 20 Jan 2023 02:10:10 -0800 (PST)
Received: from localhost (unknown [127.0.0.1])
        by h2257714.serverkompetenz.net (Postfix) with ESMTP id 1B902FF4E9
        for <linux-can@vger.kernel.org>; Fri, 20 Jan 2023 10:10:09 +0000 (UTC)
X-Virus-Scanned: amavisd-new at h2257714.serverkompetenz.net
X-Spam-Score: -1.999
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
Received: from mail3.ems-wuensche.com ([81.169.186.156])
        by localhost (h2257714.serverkompetenz.net [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id cY3zeUFHHzZB for <linux-can@vger.kernel.org>;
        Fri, 20 Jan 2023 11:10:08 +0100 (CET)
Message-ID: <d3aaf68e-d36d-2a32-23f6-6d88c8355c11@ems-wuensche.com>
Date:   Fri, 20 Jan 2023 11:10:03 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH 0/8] can: ems_pci: Add support for CPC-PCIe v3
Content-Language: en-US
To:     Vincent Mailhol <vincent.mailhol@gmail.com>
Cc:     mkl@pengutronix.de, linux-can@vger.kernel.org, wg@grandegger.com
References: <20230119154528.28425-1-uttenthaler@ems-wuensche.com>
 <CAMZ6Rq+5yUCPv9MuTof8xe3UcSzzq+aS9bXzZjUd=8d0jjtMvA@mail.gmail.com>
From:   Gerhard Uttenthaler <uttenthaler@ems-wuensche.com>
In-Reply-To: <CAMZ6Rq+5yUCPv9MuTof8xe3UcSzzq+aS9bXzZjUd=8d0jjtMvA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Hi Vincent,

Thank you for your comments! I will send a v2 series soon.

Gerhard

Am 20.01.23 um 00:28 schrieb Vincent Mailhol:
> Hi Gerhard,
> 
> I had a quick look at your series. I have a couple of nitpicks. The
> rest looks good.
> 
> On Fri. 20 Jan. 2023 at 01:02, Gerhard Uttenthaler
> <uttenthaler@ems-wuensche.com> wrote:
>> The CPC-PCIe v3 uses a Asix AX99100 instead of the discontinued
>> PLX PCI9030 bridge chip. This patch series adds support for this
>> card version and cleaned some code styling issues.
>>
>> Gerhard Uttenthaler (8):
>>    Fixed code style, copyright and email address
>>    Added Asix AX99100 definitions
>>    Initialize BAR registers
>>    Added read/write register and post irq functions
>>    Initialize CAN controller base addresses
>>    Added IRQ enable
>>    Deassert hardware reset
>>    Added MODULE_AUTHOR
> 
>>    Fixed code style, copyright and email address
>      ^^^^^
>>    Added Asix AX99100 definitions
>      ^^^^^
>>    Initialize BAR registers
>>    Added read/write register and post irq functions
>      ^^^^^
>>    Initialize CAN controller base addresses
>>    Added IRQ enable
>      ^^^^^
>>    Deassert hardware reset
>>    Added MODULE_AUTHOR
>      ^^^^^
> 
> For the titles, please use imperative (e.g. add) instead of past
> tense (e.g. Added). This also applies to the description.
> 
>>
>>   drivers/net/can/sja1000/ems_pci.c | 152 ++++++++++++++++++++++--------
>>   1 file changed, 113 insertions(+), 39 deletions(-)
>>
>> --
>> 2.35.3
>>
>> --
>> EMS Dr. Thomas Wuensche e.K.
>> Sonnenhang 3
>> 85304 Ilmmuenster
>> HR Ingolstadt, HRA 170106
>>
>> Phone: +49-8441-490260
>> Fax  : +49-8441-81860
>> http://www.ems-wuensche.com
> -- --
> 
--
EMS Dr. Thomas Wuensche e.K.
Sonnenhang 3
85304 Ilmmuenster
HR Ingolstadt, HRA 170106

Phone: +49-8441-490260
Fax  : +49-8441-81860
http://www.ems-wuensche.com
