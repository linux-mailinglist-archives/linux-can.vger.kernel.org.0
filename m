Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 620D829BEB6
	for <lists+linux-can@lfdr.de>; Tue, 27 Oct 2020 17:57:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1794409AbgJ0Q4k (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Tue, 27 Oct 2020 12:56:40 -0400
Received: from mo4-p00-ob.smtp.rzone.de ([85.215.255.24]:9447 "EHLO
        mo4-p00-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S368695AbgJ0PJy (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 27 Oct 2020 11:09:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1603811393;
        s=strato-dkim-0002; d=hartkopp.net;
        h=In-Reply-To:Date:Message-ID:From:References:To:Subject:
        X-RZG-CLASS-ID:X-RZG-AUTH:From:Subject:Sender;
        bh=Aikp5BbMXxPg9zzj66CEb9g4eTh/BlY6bwnBAudZJbM=;
        b=dUsWmZPGBNj8EeSeahK961YaZW71iPBsKw9c/jfzUS3aozdLZDYehVUoMLxi3zEXNd
        VdjJPb9L4nHrLae5K3/I2YY5kMNEqPFEev2M2MlCasWT10aB3SJdntwGr7Qc+v/1JARH
        t6QEWORDImhp0OJsozEplLp2wiiXvkeaYjG3BjlB6U4N1sIZCStybhyy6mSgN9sfSYD8
        wYcAu8AgzxdFDEba5mOtE+Ib+EDAT+qmEkOcU836nkmmFmaMyeUk9V4pcK4vAr2EkKBo
        8NX9aHzWtOGj/bxHimZRfwDVMwKG/bDdyZua646milNr2LtPbtZ3ZAkLX6hqOb/5l+dk
        vcHw==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjG14FZxedJy6qgO1o3TMaFqTEVR+J8xvyl0="
X-RZG-CLASS-ID: mo00
Received: from [192.168.10.137]
        by smtp.strato.de (RZmta 47.2.2 SBL|AUTH)
        with ESMTPSA id j075f4w9RF9o3TN
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
        Tue, 27 Oct 2020 16:09:50 +0100 (CET)
Subject: Re: [PATCH RFC] can: add optional DLC element to Classical CAN frame
 structure
To:     Marc Kleine-Budde <mkl@pengutronix.de>, mailhol.vincent@wanadoo.fr,
        linux-can@vger.kernel.org
References: <20201023203017.3485-1-socketcan@hartkopp.net>
 <d5ad34b5-7232-eadb-94a0-c58c111fa443@pengutronix.de>
 <8c142aa4-78a2-1291-b5a8-d4af9ba41338@hartkopp.net>
 <64920ca4-35df-2a46-5f1a-09a9e7eeffcf@pengutronix.de>
 <20201027144934.GA20013@x1.vandijck-laurijssen.be>
From:   Oliver Hartkopp <socketcan@hartkopp.net>
Message-ID: <6005f963-be03-5bbc-0e1c-417cb952e72a@hartkopp.net>
Date:   Tue, 27 Oct 2020 16:09:46 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20201027144934.GA20013@x1.vandijck-laurijssen.be>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org



On 27.10.20 15:49, Kurt Van Dijck wrote:
> On Tue, 27 Oct 2020 14:48:30 +0100, Marc Kleine-Budde wrote:
>> On 10/27/20 2:23 PM, Oliver Hartkopp wrote:
>>> On 27.10.20 14:06, Marc Kleine-Budde wrote:
>>>> On 10/23/20 10:30 PM, Oliver Hartkopp wrote:
> 
>>>
>>> No. It is 'Classical CAN'. I'm not very happy with that naming as there
>>> was already a 'CAN2.0B' specification to separate from the first version
>>> which only had 11 Bit identifiers. This could be Ancient CAN now :-D
>>
>> So Classical CAN is CAN2.0B?
>>
>>>> For example there was a press release to harmonize the CAN transceiver nameing
>>>> recently:
>>>>
>>>> https://can-cia.org/news/press-releases/view/harmonized-transceiver-naming/2020/7/16/
>>>
>>> Yes, there you can find:
>>>
>>> "CAN high-speed transceivers might be used in Classical CAN, CAN FD, or
>>> CAN XL networks"
> 
> What happened to 'Standard CAN' (<= CAN2.0A) and 'Extended CAN' (CAN2.0B)?
> Did those names became fossils now?

I'm currently working in a CiA Working group for CAN XL higher layer 
protocols - and all documents that refer to the "CAN with 8 bytes 
payload" seem to use "Classical CAN".

Btw. I would prefer your naming much more.

"Classical" is like "New" or "Enhanced" or "Next Generation" - just 
relative attributes.

Best,
Oliver
